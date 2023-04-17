package notquitejava.translation;

import minillvm.analysis.Checks;
import minillvm.ast.BasicBlock;
import minillvm.ast.BasicBlockList;
import minillvm.ast.Parameter;
import minillvm.ast.Proc;
import minillvm.ast.Prog;
import minillvm.ast.TemporaryVar;
import minillvm.ast.TypeStruct;
import minillvm.ast.*;
import minillvm.printer.PrettyPrinter;
import org.junit.Test;

import static minillvm.ast.Ast.*;

public class DocExamples {

	@Test
	public void print() {
		BasicBlock block = BasicBlock();
		block.add(Print(ConstInt(12)));
		print(block);
	}

	@Test
	public void store() {
		TemporaryVar x = TemporaryVar("x");
		BasicBlock block = BasicBlock(
			Alloca(x, TypeInt()),
			Store(VarRef(x), ConstInt(42))
		);
		print(block);
	}

	@Test
	public void comment() {
		BasicBlock block = BasicBlock(
				CommentInstr("This is a comment")
		);
		print(block);
	}

	@Test
	public void alloc() {
		BasicBlock block = BasicBlock(
				Alloc(TemporaryVar("t"), ConstInt(100))
		);
		print(block);
	}

	@Test
	public void alloca() {
		BasicBlock block = BasicBlock(
				Alloca(TemporaryVar("x"), TypeInt())
		);
		print(block);
	}

	@Test
	public void binary() {
		TemporaryVar x = TemporaryVar("x");
		TemporaryVar y = TemporaryVar("y");
		TemporaryVar z = TemporaryVar("z");
		BasicBlock block = BasicBlock(
				BinaryOperation(x, ConstInt(5), Add(), ConstInt(4)),
				BinaryOperation(y, VarRef(x), Sdiv(), ConstInt(2)),
				BinaryOperation(z, VarRef(x), Slt(), VarRef(y))
		);
		print(block);
	}

	@Test
	public void bitcast() {
		TemporaryVar x = TemporaryVar("x");
		TemporaryVar y = TemporaryVar("y");
		Type myStruct = TypeStruct("myStruct", StructFieldList());
		BasicBlock block = BasicBlock(
				Alloc(x, ConstInt(128)),
				Bitcast(y, TypePointer(myStruct), VarRef(x))
		);
		print(block);
	}

	@Test
	public void call() {
		TemporaryVar x = TemporaryVar("x");
		Proc f = Proc("f", TypeInt(), ParameterList(Parameter(TypeInt(), "a"),Parameter(TypeBool(), "b")), BasicBlockList());
		BasicBlock block = BasicBlock(
				Call(x, ProcedureRef(f), OperandList(ConstInt(4), ConstBool(true)))
		);
		print(block);
	}

	@Test
	public void getElementPtr() {
		TemporaryVar x = TemporaryVar("x");
		TemporaryVar y = TemporaryVar("y");
		TypeStruct myStruct = TypeStruct("myStruct", StructFieldList(
				StructField(TypeBool(), "a"),
				StructField(TypeBool(), "b"),
				StructField(TypeInt(), "c")
		));
		Parameter p = Parameter(TypePointer(myStruct), "p");
		BasicBlock block = BasicBlock(
				GetElementPtr(x, VarRef(p), OperandList(ConstInt(0), ConstInt(1))),
				Load(y, VarRef(x))
		);
		System.out.println(TypeStructList(myStruct));
		print(block);
	}

	@Test
	public void storeLoad() {
		TemporaryVar x = TemporaryVar("x");
		TemporaryVar y = TemporaryVar("y");
		BasicBlock block = BasicBlock(
				Alloca(x, TypeInt()),
				Store(VarRef(x), ConstInt(32)),
				Load(y, VarRef(x))
		);
		print(block);
	}

	@Test
	public void phis() {
		Parameter x = Parameter(TypePointer(TypeInt()), "x");
		Parameter y = Parameter(TypePointer(TypeInt()), "y");
		TemporaryVar a1 = TemporaryVar("a1");
		TemporaryVar a2 = TemporaryVar("a2");
		TemporaryVar a = TemporaryVar("a");

		BasicBlock block1 = BasicBlock(
				Load(a1, VarRef(x))
		);
		block1.setName("b1");
		BasicBlock block2 = BasicBlock(
				Load(a2, VarRef(y))
		);
		block2.setName("b2");
		BasicBlock block3 = BasicBlock(
				PhiNode(a, TypeInt(), PhiNodeChoiceList(
						PhiNodeChoice(block1, Ast.VarRef(a1)),
						PhiNodeChoice(block2, Ast.VarRef(a2))
				))
		);
		block3.setName("b3");
		block1.add(Jump(block3));
		block2.add(Jump(block3));


		BasicBlockList blocks = BasicBlockList(
			block1, block2, block3
		);
		System.out.println(blocks);
	}
	@Test
	public void branch() {
		Parameter c = Parameter(TypeBool(), "c");
		BasicBlock ifTrue = BasicBlock();
		ifTrue.setName("ifTrue");
		BasicBlock ifFalse = BasicBlock();
		ifFalse.setName("ifFalse");
		BasicBlock block = BasicBlock(
				Branch(VarRef(c), ifTrue, ifFalse)
		);
		print(block);
	}


	@Test
	public void jump() {
		BasicBlock block2 = BasicBlock();
		block2.setName("block2");
		BasicBlock block = BasicBlock(
				Jump(block2)
		);
		print(block);
	}

	@Test
	public void returnE() {
		BasicBlock block = BasicBlock(
				ReturnExpr(ConstInt(42))
		);
		print(block);
	}


	@Test
	public void returnVoid() {
		BasicBlock block = BasicBlock(
				ReturnVoid()
		);
		print(block);
	}

	@Test
	public void error() {
		BasicBlock block = BasicBlock(
				HaltWithError("description")
		);
		printInProg(block);
	}

//	@Test
//	public void names() {
//
//		BasicBlock block = BasicBlock(
//			Alloca(TemporaryVar("a"), TypeInt()),
//			Load(TemporaryVar("t"), VarRef(TemporaryVar("a"))));
//
//		printInProg(block);
//	}

	private void printInProg(BasicBlock block) {
		Proc proc = Proc("test", TypeInt(), ParameterList(), BasicBlockList(block));
		Prog prog = Prog(TypeStructList(),GlobalList(),ProcList(proc));
		PrettyPrinter.elementToString(prog);
		new Checks().checkProgram(prog);
		System.out.println(prog);
	}


	private void print(BasicBlock block) {
		Proc proc = Proc("test", TypeInt(), ParameterList(), BasicBlockList(block));
		System.out.println(proc);
	}
}
