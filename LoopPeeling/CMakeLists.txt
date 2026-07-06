add_llvm_library( LLVMLoopPeelingPass MODULE
  LoopPeelingPass.cpp

  
  PLUGIN_TOOL
  opt
  )
