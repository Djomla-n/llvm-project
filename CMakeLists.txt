add_llvm_library(LLVMMyPasses MODULE
  LoopPeelingPass.cpp
  LoopPeeling.h
  LoopUnswitchingPass.cpp

  PLUGIN_TOOL
  opt
)
