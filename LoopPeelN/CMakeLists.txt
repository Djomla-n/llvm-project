add_llvm_library( LLVMLoopPeelNPass MODULE
  LoopPeelingPass.cpp

  
  PLUGIN_TOOL
  opt
  )
