#include "LoopPeeling.h"
#include "llvm/ADT/Statistic.h"
#include "llvm/Analysis/LoopInfo.h"
#include "llvm/Analysis/LoopPass.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/Instruction.h"
#include "llvm/Pass.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Transforms/Utils/BasicBlockUtils.h"
#include "llvm/Transforms/Utils/LoopUtils.h"

using namespace llvm;

namespace {
struct LoopPeelingPass : public LoopPass {
  std::unordered_map<Value *, Value *> VariablesMap;
  Value *LoopCounter = nullptr;
  Value *LoopBound = nullptr;

  static char ID;
  LoopPeelingPass() : LoopPass(ID) {}


  void mapVariables(Loop *L) {
    VariablesMap.clear();
    Function *F = L->getHeader()->getParent();
    for (BasicBlock &BB : *F) {
      for (Instruction &I : BB) {
        if (isa<LoadInst>(&I)) {
          VariablesMap[&I] = I.getOperand(0);
        }
      }
    }
  }

  void findLoopCounterAndBound(Loop *L) {
    for (Instruction &I : *L->getHeader()) {
      if (isa<ICmpInst>(&I)) {
        LoopCounter = VariablesMap[I.getOperand(0)];
        LoopBound = VariablesMap[I.getOperand(1)];
        break;
      }
    }
  }

  Value *getInitialValueFromPreheader(BasicBlock *Preheader) {
    for (Instruction &I : *Preheader) {
      if (auto *SI = dyn_cast<StoreInst>(&I)) {
        if (SI->getPointerOperand() == LoopCounter) {
          return SI->getValueOperand();
        }
      }
    }

    errs() << "Nije pronadjen store za brojac petlje u preheader-u!\n";
    return nullptr;
  }

  void peelFirstIteration(Loop *L) {
    BasicBlock *Header = L->getHeader();
    Function *F = Header->getParent();

    BasicBlock *Preheader = L->getLoopPreheader();
    if (!Preheader) {
      errs() << "Loop nema preheader!\n";
      return;
    }

    Value *InitialValue = getInitialValueFromPreheader(Preheader);
    if (!InitialValue) {
      return;
    }

    std::vector<BasicBlock *> LoopBlocks = L->getBlocks();

    std::unordered_map<BasicBlock *, BasicBlock *> BlockMapping;

    std::unordered_map<Value *, Value *> LoopMapping;


    for (BasicBlock *BB : LoopBlocks) {
      BasicBlock *NewBB = BasicBlock::Create(Header->getContext(), BB->getName() + ".peel", F, Header);
      BranchInst::Create(Header, NewBB);
      BlockMapping[BB] = NewBB;
    }

    for (BasicBlock *BB : LoopBlocks) {
      BasicBlock *NewBB = BlockMapping[BB];

      std::vector<Instruction *> BlockInstructions;
      for (Instruction &I : *BB) {
        if (!I.isTerminator()) {
          BlockInstructions.push_back(&I);
        }
      }

      for (Instruction *Instr : BlockInstructions) {
        Instruction *Copy = Instr->clone();
        Copy->insertBefore(NewBB->getTerminator());

        LoopMapping[Instr] = Copy;

        if (isa<LoadInst>(Instr)) {
          if (Instr->getOperand(0) == LoopCounter) {
            LoopMapping[Instr] = InitialValue;
          }
        }

        for (size_t j = 0; j < Copy->getNumOperands(); j++) {
          if (LoopMapping[Copy->getOperand(j)]) {
            Copy->setOperand(j, LoopMapping[Copy->getOperand(j)]);
          }
        }
      }

      Instruction *OldTerminator = BB->getTerminator();
      Instruction *NewTerminator = OldTerminator->clone();
      NewTerminator->insertBefore(NewBB->getTerminator());
      NewBB->getTerminator()->eraseFromParent();


      for (unsigned j = 0; j < NewTerminator->getNumOperands(); ++j) {
        Value *Op = NewTerminator->getOperand(j);

        if (auto *OldTarget = dyn_cast<BasicBlock>(Op)) {
          if (BlockMapping.count(OldTarget)) {
            NewTerminator->setOperand(j, BlockMapping[OldTarget]);
          }
          continue;
        }

        if (LoopMapping[Op]) {
          NewTerminator->setOperand(j, LoopMapping[Op]);
        }
      }
    }


    BasicBlock *NewHeader = BlockMapping[Header];
    for (BasicBlock *BB : LoopBlocks) {
      BasicBlock *NewBB = BlockMapping[BB];
      Instruction *Term = NewBB->getTerminator();
      for (unsigned i = 0; i < Term->getNumSuccessors(); ++i) {
        if (Term->getSuccessor(i) == NewHeader) {
          Term->setSuccessor(i, Header);
        }
      }
    }

    Instruction *PreheaderTerm = Preheader->getTerminator();
    for (unsigned i = 0; i < PreheaderTerm->getNumSuccessors(); ++i) {
      if (PreheaderTerm->getSuccessor(i) == Header) {
        PreheaderTerm->setSuccessor(i, NewHeader);
      }
    }
  }

  bool runOnLoop(Loop *L, LPPassManager &LPM) override {
    mapVariables(L);
    findLoopCounterAndBound(L);

    if (!LoopCounter) {
      errs() << "Nisam pronasao brojac petlje!\n";
      return false;
    }

    peelFirstIteration(L);
    return true;
  }
};
} // namespace

char LoopPeelingPass::ID = 0;
static RegisterPass<LoopPeelingPass> X("loop-peeling", "Loop peeling Pass",
                                        false, false);