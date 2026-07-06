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
  std::vector<BasicBlock *> LoopBasicBlocks;
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

   void duplicateLoopBody(std::vector<BasicBlock *> LoopBodyBasicBlocks, int numOfTimes, BasicBlock *InsertBefore, BasicBlock *Preaheader) {
        std::unordered_map<Value *, Value *> Mapping;
        std::unordered_map<Value *, Value *> LoadMapping;
        std::unordered_map<BasicBlock *, BasicBlock *> BlocksMapping;

        IRBuilder<> Builder(InsertBefore->getContext());
        Instruction *Copy;
        BasicBlock *LastFromPreviousCopy = Preaheader;
        std::vector<BasicBlock *> LoopBodyBasicBlockCopy;

        for (int i = 0; i < numOfTimes; i++) {
            LoopBodyBasicBlockCopy.clear();
            Mapping.clear();
            LoadMapping.clear();
            BlocksMapping.clear();

            for (size_t j = 0; j < LoopBodyBasicBlocks.size(); j++) {
                BasicBlock *NewBasicBlock = BasicBlock::Create(InsertBefore->getContext(), "", InsertBefore->getParent(), InsertBefore);
                LoopBodyBasicBlockCopy.push_back(NewBasicBlock);
                BlocksMapping[LoopBodyBasicBlocks[j]] = NewBasicBlock;
            }

            for (size_t j = 0; j < LoopBodyBasicBlocks.size(); j++) {
                Builder.SetInsertPoint(LoopBodyBasicBlockCopy[j]);

                for (Instruction &I : *LoopBodyBasicBlocks[j]) {
                    Copy = I.clone();
                    Builder.Insert(Copy);

                    if (isa<LoadInst>(Copy) && Copy->getOperand(0) == LoopCounter) {
                        Instruction *Add = (Instruction *) BinaryOperator::CreateAdd(
                            Copy, ConstantInt::get(Type::getInt32Ty(Copy->getContext()), i));
                        Add->insertAfter(Copy);
                        LoadMapping[Copy] = Add;
                    }

                    Mapping[&I] = Copy;

                    for (size_t k = 0; k < Copy->getNumOperands(); k++) {
                        if (Mapping.find(Copy->getOperand(k)) != Mapping.end())
                            Copy->setOperand(k, Mapping[Copy->getOperand(k)]);
                        if (LoadMapping.find(Copy->getOperand(k)) != LoadMapping.end())
                            Copy->setOperand(k, LoadMapping[Copy->getOperand(k)]);
                    }
                }
            }

            for (size_t j = 0; j < LoopBodyBasicBlocks.size(); j++) {
                if (!LoopBodyBasicBlockCopy[j]->getTerminator()) continue;
                for (size_t k = 0; k < LoopBodyBasicBlockCopy[j]->getTerminator()->getNumSuccessors(); k++) {
                    BasicBlock *Succ = LoopBodyBasicBlocks[j]->getTerminator()->getSuccessor(k);
                    if (BlocksMapping.find(Succ) != BlocksMapping.end())
                        LoopBodyBasicBlockCopy[j]->getTerminator()->setSuccessor(k, BlocksMapping[Succ]);
                }
            }

            LastFromPreviousCopy->getTerminator()->setSuccessor(0, LoopBodyBasicBlockCopy.front());
            LastFromPreviousCopy = LoopBodyBasicBlockCopy.back();
        }

        if (!LoopBodyBasicBlockCopy.empty())
            LoopBodyBasicBlockCopy.back()->getTerminator()->setSuccessor(0, InsertBefore);

        Builder.SetInsertPoint(LoopBodyBasicBlockCopy.back()->getTerminator());
        Builder.CreateStore(Builder.getInt32(numOfTimes), LoopCounter);
    }

  void peelFirstNIterations(Loop *L) {
    BasicBlock *Preheader = L->getLoopPreheader();
    if (!Preheader) {
      errs() << "Petlja nema preheader!\n";
      return;
    }

    BasicBlock *Header = L->getHeader();

    std::vector<BasicBlock *> LoopBodyBasicBlocks;
    if (LoopBasicBlocks.size() > 2) {
      LoopBodyBasicBlocks.resize(LoopBasicBlocks.size() - 2);
      std::copy(LoopBasicBlocks.begin() + 1, LoopBasicBlocks.end() - 1, LoopBodyBasicBlocks.begin());
    }
    int numOfTimes = 4;
    duplicateLoopBody(LoopBodyBasicBlocks, numOfTimes, Header, Preheader);
  }

  bool runOnLoop(Loop *L, LPPassManager &LPM) override {
    LoopBasicBlocks = L->getBlocksVector();
    mapVariables(L);
    findLoopCounterAndBound(L);

    if (!LoopCounter) {
      errs() << "Nisam pronasao brojac petlje!\n";
      return false;
    }

    peelFirstNIterations(L);

    return true;
  }
};
} // namespace

char LoopPeelingPass::ID = 0;
static RegisterPass<LoopPeelingPass> X("loop-peeling", "Loop peeling Pass",
                                        false, false);