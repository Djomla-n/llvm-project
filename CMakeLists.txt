add_llvm_library(LLVMMyPasses MODULE
  LoopPeelingPass.cpp
  LoopPeeling.h

  PLUGIN_TOOL
  opt
)