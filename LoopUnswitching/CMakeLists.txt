add_llvm_library(LLVMLoopUnswitchingPass MODULE
  LoopUnswitchingPass.cpp

  PLUGIN_TOOL
  opt
)
