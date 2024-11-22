//=============================================================================
// FILE:
//    HelloWorld.cpp
//
// DESCRIPTION:
//    Visits all functions in a module, prints their names and the number of
//    arguments via stderr. Strictly speaking, this is an analysis pass (i.e.
//    the functions are not modified). However, in order to keep things simple
//    there's no 'print' method here (every analysis pass should implement it).
//
// USAGE:
//    New PM
//      opt -load-pass-plugin=libHelloWorld.dylib -passes="hello-world" `\`
//        -disable-output <input-llvm-file>
//
//
// License: MIT
//=============================================================================
#include "llvm/IR/LegacyPassManager.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"
#include "llvm/Support/raw_ostream.h"

using namespace llvm;

//-----------------------------------------------------------------------------
// HelloWorld implementation
//-----------------------------------------------------------------------------
// No need to expose the internals of the pass to the outside world - keep
// everything in an anonymous namespace.
namespace {

void walkInstruction(Instruction &I)
{
  unsigned num = I.getNumOperands();
  for (unsigned i = 0; i < num; i++) {
      //I.getOperand(i)->dump();
      Value* v = I.getOperand(i);
      errs() << v->getNameOrAsOperand() << "\n";

  }
  errs() << "Done printing operands for instruction " << I.getOpcodeName() << "\n";
  
}


void iterateInstructionsAndOperands(Function &F) {


    errs() << "Function: " << F.getName() << "\n";
    for (BasicBlock &block : F) {
        errs() << "  BasicBlock:\n";
        for (Instruction &instruction : block) {
            errs() << "    Instruction: ";
            instruction.print(errs());
            errs() << "\n";

            for (Use &operand : instruction.operands()) {
                Value *value = operand.get();
                errs() << "      Operand: ";
                if (value->hasName())
                    errs() << value->getName();
                else
                    value->print(errs());
                errs() << "\n";
            }
        }
    }
    
}

void emitSexp(const std::string &id, std::vector<std::string> args)
{
  std::string out = "";
  out +=  "(" + id;

  for(const std::string& s : args)
  {
    out += " " + s;
  }
  out += ")";

  llvm::outs() << out << "\n";

}

void emitArith(llvm::Instruction &inst, const std::string &smtOp)
{
  llvm::Value* op1 = inst.getOperand(0);
  llvm::Value* op2 = inst.getOperand(1);

  std::vector<std::string> args = {op1->getNameOrAsOperand(), op2->getNameOrAsOperand()};
  emitSexp(smtOp, args);
  
  return;
}

// This method implements what the pass does
void emitter(Function &F) {

    
    //errs() << "Function: " << F.getName() << "\n";
    for (BasicBlock &BB : F) {
        //errs() << "  BasicBlock: " << BB.getName() << "\n";
        for (Instruction &I : BB) {

            // errs() << "    Instruction: " << I << "\n";
            
            switch(I.getOpcode())
            {
              case llvm::Instruction::Br:
                //errs() << "    Opcode: " << I.getOpcodeName() << "\n";
                break;
              case llvm::Instruction::Add:
                emitArith(I, "add");
                
                //errs() << "    Opcode: " << I.getOpcodeName() << "\n";
                //errs() << I.getNumOperands() << "\n";
                break;
              default:
              continue;
                //llvm::outs() << I.getOpcodeName() << " is unsupported\n";
              
            }
            
        }
    }
        

    errs() << "(llvm-tutor) Hello from: "<< F.getName() << "\n";
    errs() << "(llvm-tutor)   number of arguments: " << F.arg_size() << "\n";
}

// New PM implementation
struct HelloWorld : PassInfoMixin<HelloWorld> {
  // Main entry point, takes IR unit to run the pass on (&F) and the
  // corresponding pass manager (to be queried if need be)
  PreservedAnalyses run(Function &F, FunctionAnalysisManager &) {
    emitter(F);
    return PreservedAnalyses::all();
  }

  // Without isRequired returning true, this pass will be skipped for functions
  // decorated with the optnone LLVM attribute. Note that clang -O0 decorates
  // all functions with optnone.
  static bool isRequired() { return true; }
};
} // namespace

//-----------------------------------------------------------------------------
// New PM Registration
//-----------------------------------------------------------------------------
llvm::PassPluginLibraryInfo getHelloWorldPluginInfo() {
  return {LLVM_PLUGIN_API_VERSION, "HelloWorld", LLVM_VERSION_STRING,
          [](PassBuilder &PB) {
            PB.registerPipelineParsingCallback(
                [](StringRef Name, FunctionPassManager &FPM,
                   ArrayRef<PassBuilder::PipelineElement>) {
                  if (Name == "hello-world") {
                    FPM.addPass(HelloWorld());
                    return true;
                  }
                  return false;
                });
          }};
}

// This is the core interface for pass plugins. It guarantees that 'opt' will
// be able to recognize HelloWorld when added to the pass pipeline on the
// command line, i.e. via '-passes=hello-world'
extern "C" LLVM_ATTRIBUTE_WEAK ::llvm::PassPluginLibraryInfo
llvmGetPassPluginInfo() {
  return getHelloWorldPluginInfo();
}