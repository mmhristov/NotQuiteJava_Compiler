@.print_message_1 = private unnamed_addr constant [64 x i8] c"Nullpointer exception in line frontend.SourcePosition@376f3de6\0A\00", align 1
@.print_message_2 = private unnamed_addr constant [64 x i8] c"Nullpointer exception in line frontend.SourcePosition@21282fc6\0A\00", align 1


%class_B = type {
     %vTable_B*  ; vTable
}

%class_C = type {
     %vTable_C*  ; vTable
}

%vTable_B = type {
     i32(%class_B*)*  ; test
    ,i32(%class_B*)*  ; run
}

%vTable_B1 = type {
     i32(%class_B*)*  ; test
    ,i32(%class_B*)*  ; run
}

%vTable_C = type {
     i32(%class_C*)*  ; run
}

%vTable_C1 = type {
     i32(%class_C*)*  ; run
}

@vTableGlobal_B = constant %vTable_B  {
    i32(%class_B*)* @test,
    i32(%class_B*)* @run
}


@vTableGlobal_C = constant %vTable_C  {
    i32(%class_C*)* @run1
}


define i32 @test(%class_B* %this) {
init:
    ;23 start statement : {
    ;24 start statement : return 2;
    ret i32 2
    

}

define i32 @run(%class_B* %this) {
init:
    ;26 start statement : {
    ;27 start statement : return 1;
    ret i32 1
    

}

define i32 @run1(%class_C* %this) {
init:
    ;32 start statement : {
    ;33 start statement : return 2;
    ret i32 2
    

}

define i32 @main() {
init:
    %y = alloca i32
    %x = alloca %class_C*
    ;1 start statement : {
    ;2 start statement : int y
    ;2 end statement: int y
    ;3 start statement : A x
    ;3 end statement: A x
    ;4 start statement : x = new B();
    %newObject = call %class_B* @constructor_B()
    %castValue = bitcast %class_B* %newObject to %class_C*
    store %class_C* %castValue, %class_C** %x
    ;4 end statement: x = new B();
    ;5 start statement : y = x.run();
    %t = load %class_C*, %class_C** %x
    %isNull = icmp eq %class_C* %t, null
    br i1 %isNull, label %whenIsNull, label %notNull
    
whenIsNull:
    ; ERROR: Nullpointer exception in line frontend.SourcePosition@376f3de6
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([64 x i8], [64 x i8]* @.print_message_1, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
notNull:
    %ptrVTablePointer = getelementptr %class_C, %class_C* %t, i32 0, i32 0
    %ptrVTable = load %vTable_C*, %vTable_C** %ptrVTablePointer
    %ptrMethod = getelementptr %vTable_C, %vTable_C* %ptrVTable, i32 0, i32 0
    %method = load i32(%class_C*)*, i32(%class_C*)** %ptrMethod
    %run_result = call i32 %method(%class_C* %t)
    store i32 %run_result, i32* %y
    ;5 end statement: y = x.run();
    ;6 start statement : printInt(y);
    %t1 = load i32, i32* %y
    call void @print(i32 %t1)
    ;6 end statement: printInt(y);
    ;7 start statement : x = new C();
    %newObject1 = call %class_C* @constructor_C()
    store %class_C* %newObject1, %class_C** %x
    ;7 end statement: x = new C();
    ;8 start statement : y = x.run();
    %t2 = load %class_C*, %class_C** %x
    %isNull1 = icmp eq %class_C* %t2, null
    br i1 %isNull1, label %whenIsNull1, label %notNull1
    
whenIsNull1:
    ; ERROR: Nullpointer exception in line frontend.SourcePosition@21282fc6
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([64 x i8], [64 x i8]* @.print_message_2, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
notNull1:
    %ptrVTablePointer1 = getelementptr %class_C, %class_C* %t2, i32 0, i32 0
    %ptrVTable1 = load %vTable_C*, %vTable_C** %ptrVTablePointer1
    %ptrMethod1 = getelementptr %vTable_C, %vTable_C* %ptrVTable1, i32 0, i32 0
    %method1 = load i32(%class_C*)*, i32(%class_C*)** %ptrMethod1
    %run_result1 = call i32 %method1(%class_C* %t2)
    store i32 %run_result1, i32* %y
    ;8 end statement: y = x.run();
    ;9 start statement : printInt(y);
    %t3 = load i32, i32* %y
    call void @print(i32 %t3)
    ;9 end statement: printInt(y);
    ;10 start statement : return 0;
    ret i32 0
    

}

define %class_B* @constructor_B() {
constructorBlock:
    %mallocVar = call i8* @malloc(i32 ptrtoint (%class_B* getelementptr (%class_B, %class_B* null, i32 1) to i32))
    %newClass = bitcast i8* %mallocVar to %class_B*
    %address = getelementptr %class_B, %class_B* %newClass, i32 0, i32 0
    store %vTable_B* @vTableGlobal_B, %vTable_B** %address
    ret %class_B* %newClass
    

}

define %class_C* @constructor_C() {
constructorBlock:
    %mallocVar = call i8* @malloc(i32 ptrtoint (%class_C* getelementptr (%class_C, %class_C* null, i32 1) to i32))
    %newClass = bitcast i8* %mallocVar to %class_C*
    %address = getelementptr %class_C, %class_C* %newClass, i32 0, i32 0
    store %vTable_C* @vTableGlobal_C, %vTable_C** %address
    ret %class_C* %newClass
    

}


declare noalias i8* @malloc(i32)

declare i32 @printf(i8*, ...)

declare void @exit(i32)

@.printstr = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1
define void @print(i32 %i) {
    %temp = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.printstr, i32 0, i32 0), i32 %i)
    ret void
}
