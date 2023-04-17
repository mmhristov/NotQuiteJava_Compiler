@.print_message_1 = private unnamed_addr constant [64 x i8] c"Nullpointer exception in line frontend.SourcePosition@376f3de6\0A\00", align 1
@.print_message_2 = private unnamed_addr constant [64 x i8] c"Nullpointer exception in line frontend.SourcePosition@21282fc6\0A\00", align 1


%class_C = type {
     %vTable_C*  ; vTable
}

%class_D = type {
     %vTable_D*  ; vTable
}

%vTable_C = type {
     i32(%class_C*)*  ; b
    ,i32(%class_C*)*  ; num
}

%vTable_C1 = type {
     i32(%class_C*)*  ; b
    ,i32(%class_C*)*  ; num
}

%vTable_D = type {
     i32(%class_D*)*  ; num
}

%vTable_D1 = type {
     i32(%class_D*)*  ; num
}

@vTableGlobal_C = constant %vTable_C  {
    i32(%class_C*)* @b,
    i32(%class_C*)* @num
}


@vTableGlobal_D = constant %vTable_D  {
    i32(%class_D*)* @num1
}


define i32 @b(%class_C* %this) {
init:
    ;28 start statement : {
    ;29 start statement : return 69;
    ret i32 69
    

}

define i32 @num(%class_C* %this) {
init:
    ;31 start statement : {
    ;32 start statement : return 1;
    ret i32 1
    

}

define i32 @num1(%class_D* %this) {
init:
    ;37 start statement : {
    ;38 start statement : return 2;
    ret i32 2
    

}

define %class_C* @constructor_C() {
constructorBlock:
    %mallocVar = call i8* @malloc(i32 ptrtoint (%class_C* getelementptr (%class_C, %class_C* null, i32 1) to i32))
    %newClass = bitcast i8* %mallocVar to %class_C*
    %address = getelementptr %class_C, %class_C* %newClass, i32 0, i32 0
    store %vTable_C* @vTableGlobal_C, %vTable_C** %address
    ret %class_C* %newClass
    

}

define %class_D* @constructor_D() {
constructorBlock:
    %mallocVar = call i8* @malloc(i32 ptrtoint (%class_D* getelementptr (%class_D, %class_D* null, i32 1) to i32))
    %newClass = bitcast i8* %mallocVar to %class_D*
    %address = getelementptr %class_D, %class_D* %newClass, i32 0, i32 0
    store %vTable_D* @vTableGlobal_D, %vTable_D** %address
    ret %class_D* %newClass
    

}

define i32 @main() {
init:
    %res = alloca i32
    %a = alloca %class_D*
    ;3 start statement : {
    ;4 start statement : int res
    ;4 end statement: int res
    ;5 start statement : A a
    ;5 end statement: A a
    ;7 start statement : a = new C();
    %newObject = call %class_C* @constructor_C()
    %castValue = bitcast %class_C* %newObject to %class_D*
    store %class_D* %castValue, %class_D** %a
    ;7 end statement: a = new C();
    ;8 start statement : res = a.num();
    %t = load %class_D*, %class_D** %a
    %isNull = icmp eq %class_D* %t, null
    br i1 %isNull, label %whenIsNull, label %notNull
    
whenIsNull:
    ; ERROR: Nullpointer exception in line frontend.SourcePosition@376f3de6
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([64 x i8], [64 x i8]* @.print_message_1, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
notNull:
    %ptrVTablePointer = getelementptr %class_D, %class_D* %t, i32 0, i32 0
    %ptrVTable = load %vTable_D*, %vTable_D** %ptrVTablePointer
    %ptrMethod = getelementptr %vTable_D, %vTable_D* %ptrVTable, i32 0, i32 0
    %method = load i32(%class_D*)*, i32(%class_D*)** %ptrMethod
    %num_result = call i32 %method(%class_D* %t)
    store i32 %num_result, i32* %res
    ;8 end statement: res = a.num();
    ;9 start statement : printInt(res);
    %t1 = load i32, i32* %res
    call void @print(i32 %t1)
    ;9 end statement: printInt(res);
    ;11 start statement : a = new D();
    %newObject1 = call %class_D* @constructor_D()
    store %class_D* %newObject1, %class_D** %a
    ;11 end statement: a = new D();
    ;12 start statement : res = a.num();
    %t2 = load %class_D*, %class_D** %a
    %isNull1 = icmp eq %class_D* %t2, null
    br i1 %isNull1, label %whenIsNull1, label %notNull1
    
whenIsNull1:
    ; ERROR: Nullpointer exception in line frontend.SourcePosition@21282fc6
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([64 x i8], [64 x i8]* @.print_message_2, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
notNull1:
    %ptrVTablePointer1 = getelementptr %class_D, %class_D* %t2, i32 0, i32 0
    %ptrVTable1 = load %vTable_D*, %vTable_D** %ptrVTablePointer1
    %ptrMethod1 = getelementptr %vTable_D, %vTable_D* %ptrVTable1, i32 0, i32 0
    %method1 = load i32(%class_D*)*, i32(%class_D*)** %ptrMethod1
    %num_result1 = call i32 %method1(%class_D* %t2)
    store i32 %num_result1, i32* %res
    ;12 end statement: res = a.num();
    ;13 start statement : printInt(res);
    %t3 = load i32, i32* %res
    call void @print(i32 %t3)
    ;13 end statement: printInt(res);
    ;15 start statement : return 0;
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
