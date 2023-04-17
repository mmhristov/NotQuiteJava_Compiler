@.print_message_1 = private unnamed_addr constant [64 x i8] c"Nullpointer exception in line frontend.SourcePosition@2385ee72\0A\00", align 1


%class_TestA = type {
     %vTable_TestA*  ; vTable
}

%vTable_TestA = type {
     i32(%class_TestA*, i32)*  ; a
    ,i32(%class_TestA*, i32)*  ; b
}

%vTable_TestA1 = type {
     i32(%class_TestA*, i32)*  ; a
    ,i32(%class_TestA*, i32)*  ; b
}

@vTableGlobal_TestA = constant %vTable_TestA  {
    i32(%class_TestA*, i32)* @a,
    i32(%class_TestA*, i32)* @b
}


define i32 @a(%class_TestA* %this, i32 %op) {
init:
    %op1 = alloca i32
    store i32 %op, i32* %op1
    ;22 start statement : {
    ;23 start statement : printInt((op + 100));
    %t = load i32, i32* %op1
    %resAddImpl = add i32 %t, 100
    call void @print(i32 %resAddImpl)
    ;23 end statement: printInt((op + 100));
    ;24 start statement : return 0;
    ret i32 0
    

}

define i32 @b(%class_TestA* %this, i32 %op) {
init:
    %op1 = alloca i32
    store i32 %op, i32* %op1
    ;27 start statement : {
    ;28 start statement : printInt(op);
    %t = load i32, i32* %op1
    call void @print(i32 %t)
    ;28 end statement: printInt(op);
    ;29 start statement : return 0;
    ret i32 0
    

}

define %class_TestA* @constructor_TestA() {
constructorBlock:
    %mallocVar = call i8* @malloc(i32 ptrtoint (%class_TestA* getelementptr (%class_TestA, %class_TestA* null, i32 1) to i32))
    %newClass = bitcast i8* %mallocVar to %class_TestA*
    %address = getelementptr %class_TestA, %class_TestA* %newClass, i32 0, i32 0
    store %vTable_TestA* @vTableGlobal_TestA, %vTable_TestA** %address
    ret %class_TestA* %newClass
    

}

define i32 @main() {
init:
    %v = alloca %class_TestA*
    ;3 start statement : {
    ;5 start statement : Test v
    ;5 end statement: Test v
    ;7 start statement : v = new TestA();
    %newObject = call %class_TestA* @constructor_TestA()
    store %class_TestA* %newObject, %class_TestA** %v
    ;7 end statement: v = new TestA();
    ;9 start statement : v.a(100);
    %t = load %class_TestA*, %class_TestA** %v
    %isNull = icmp eq %class_TestA* %t, null
    br i1 %isNull, label %whenIsNull, label %notNull
    
whenIsNull:
    ; ERROR: Nullpointer exception in line frontend.SourcePosition@2385ee72
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([64 x i8], [64 x i8]* @.print_message_1, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
notNull:
    %ptrVTablePointer = getelementptr %class_TestA, %class_TestA* %t, i32 0, i32 0
    %ptrVTable = load %vTable_TestA*, %vTable_TestA** %ptrVTablePointer
    %ptrMethod = getelementptr %vTable_TestA, %vTable_TestA* %ptrVTable, i32 0, i32 0
    %method = load i32(%class_TestA*, i32)*, i32(%class_TestA*, i32)** %ptrMethod
    %a_result = call i32 %method(%class_TestA* %t, i32 100)
    ;9 end statement: v.a(100);
    ;10 start statement : return 0;
    ret i32 0
    

}


declare noalias i8* @malloc(i32)

declare i32 @printf(i8*, ...)

declare void @exit(i32)

@.printstr = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1
define void @print(i32 %i) {
    %temp = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.printstr, i32 0, i32 0), i32 %i)
    ret void
}
