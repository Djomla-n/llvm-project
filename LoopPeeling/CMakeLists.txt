add_llvm_library(LLVMLoopPeelingPass MODULE
  LoopPeelingPass.cpp
  LoopPeeling.h

  PLUGIN_TOOL
  opt
)
