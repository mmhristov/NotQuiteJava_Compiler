@.print_message_1 = private unnamed_addr constant [64 x i8] c"Nullpointer exception in line frontend.SourcePosition@2896e105\0A\00", align 1
@.print_message_2 = private unnamed_addr constant [64 x i8] c"Nullpointer exception in line frontend.SourcePosition@658ec00c\0A\00", align 1
@.print_message_3 = private unnamed_addr constant [64 x i8] c"Nullpointer exception in line frontend.SourcePosition@6fe37577\0A\00", align 1
@.print_message_4 = private unnamed_addr constant [64 x i8] c"Nullpointer exception in line frontend.SourcePosition@7eb91b95\0A\00", align 1
@.print_message_5 = private unnamed_addr constant [64 x i8] c"Nullpointer exception in line frontend.SourcePosition@33260ecd\0A\00", align 1
@.print_message_6 = private unnamed_addr constant [64 x i8] c"Nullpointer exception in line frontend.SourcePosition@3d2bb013\0A\00", align 1
@.print_message_7 = private unnamed_addr constant [64 x i8] c"Nullpointer exception in line frontend.SourcePosition@21ec7946\0A\00", align 1


%class_A = type {
     %vTable_A*  ; vTable
}

%class_B = type {
     %vTable_B*  ; vTable
}

%vTable_A = type {
     i32(%class_A*)*  ; test1
    ,i32(%class_A*)*  ; test2
}

%vTable_A1 = type {
     i32(%class_A*)*  ; test1
    ,i32(%class_A*)*  ; test2
}

%vTable_B = type {
     i32(%class_B*)*  ; test1
    ,i32(%class_B*)*  ; test2
}

%vTable_B1 = type {
     i32(%class_B*)*  ; test1
    ,i32(%class_B*)*  ; test2
}

@vTableGlobal_A = constant %vTable_A  {
    i32(%class_A*)* @test1,
    i32(%class_A*)* @test2
}


@vTableGlobal_B = constant %vTable_B  {
    i32(%class_B*)* @test11,
    i32(%class_B*)* @test21
}


define i32 @test1(%class_A* %this) {
init:
    ;21 start statement : {
    ;22 start statement : return 1;
    ret i32 1
    

}

define i32 @test2(%class_A* %this) {
init:
    ;25 start statement : {
    ;26 start statement : return 2;
    ret i32 2
    

}

define i32 @test11(%class_B* %this) {
init:
    ;31 start statement : {
    ;32 start statement : printInt(this.test2());
    %isNull = icmp eq %class_B* %this, null
    br i1 %isNull, label %whenIsNull, label %notNull
    
whenIsNull:
    ; ERROR: Nullpointer exception in line frontend.SourcePosition@2896e105
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([64 x i8], [64 x i8]* @.print_message_1, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
notNull:
    %ptrVTablePointer = getelementptr %class_B, %class_B* %this, i32 0, i32 0
    %ptrVTable = load %vTable_B*, %vTable_B** %ptrVTablePointer
    %ptrMethod = getelementptr %vTable_B, %vTable_B* %ptrVTable, i32 0, i32 1
    %method = load i32(%class_B*)*, i32(%class_B*)** %ptrMethod
    %test2_result = call i32 %method(%class_B* %this)
    call void @print(i32 %test2_result)
    ;32 end statement: printInt(this.test2());
    ;33 start statement : return 10;
    ret i32 10
    

}

define i32 @test21(%class_B* %this) {
init:
    ;36 start statement : {
    ;37 start statement : return 11;
    ret i32 11
    

}

define %class_A* @constructor_A() {
constructorBlock:
    %mallocVar = call i8* @malloc(i32 ptrtoint (%class_A* getelementptr (%class_A, %class_A* null, i32 1) to i32))
    %newClass = bitcast i8* %mallocVar to %class_A*
    %address = getelementptr %class_A, %class_A* %newClass, i32 0, i32 0
    store %vTable_A* @vTableGlobal_A, %vTable_A** %address
    ret %class_A* %newClass
    

}

define %class_B* @constructor_B() {
constructorBlock:
    %mallocVar = call i8* @malloc(i32 ptrtoint (%class_B* getelementptr (%class_B, %class_B* null, i32 1) to i32))
    %newClass = bitcast i8* %mallocVar to %class_B*
    %address = getelementptr %class_B, %class_B* %newClass, i32 0, i32 0
    store %vTable_B* @vTableGlobal_B, %vTable_B** %address
    ret %class_B* %newClass
    

}

define i32 @f(%class_B* %a) {
init:
    %a1 = alloca %class_B*
    store %class_B* %a, %class_B** %a1
    ;14 start statement : {
    ;15 start statement : printInt(a.test1());
    %t = load %class_B*, %class_B** %a1
    %isNull = icmp eq %class_B* %t, null
    br i1 %isNull, label %whenIsNull, label %notNull
    
whenIsNull:
    ; ERROR: Nullpointer exception in line frontend.SourcePosition@658ec00c
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([64 x i8], [64 x i8]* @.print_message_2, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
notNull:
    %ptrVTablePointer = getelementptr %class_B, %class_B* %t, i32 0, i32 0
    %ptrVTable = load %vTable_B*, %vTable_B** %ptrVTablePointer
    %ptrMethod = getelementptr %vTable_B, %vTable_B* %ptrVTable, i32 0, i32 0
    %method = load i32(%class_B*)*, i32(%class_B*)** %ptrMethod
    %test1_result = call i32 %method(%class_B* %t)
    call void @print(i32 %test1_result)
    ;15 end statement: printInt(a.test1());
    ;16 start statement : printInt(a.test2());
    %t1 = load %class_B*, %class_B** %a1
    %isNull1 = icmp eq %class_B* %t1, null
    br i1 %isNull1, label %whenIsNull1, label %notNull1
    
whenIsNull1:
    ; ERROR: Nullpointer exception in line frontend.SourcePosition@6fe37577
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([64 x i8], [64 x i8]* @.print_message_3, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
notNull1:
    %ptrVTablePointer1 = getelementptr %class_B, %class_B* %t1, i32 0, i32 0
    %ptrVTable1 = load %vTable_B*, %vTable_B** %ptrVTablePointer1
    %ptrMethod1 = getelementptr %vTable_B, %vTable_B* %ptrVTable1, i32 0, i32 1
    %method1 = load i32(%class_B*)*, i32(%class_B*)** %ptrMethod1
    %test2_result = call i32 %method1(%class_B* %t1)
    call void @print(i32 %test2_result)
    ;16 end statement: printInt(a.test2());
    ;17 start statement : return 0;
    ret i32 0
    

}

define i32 @main() {
init:
    %a = alloca %class_B*
    ;1 start statement : {
    ;2 start statement : I a
    ;2 end statement: I a
    ;3 start statement : a = new A();
    %newObject = call %class_A* @constructor_A1()
    %castValue = bitcast %class_A* %newObject to %class_B*
    store %class_B* %castValue, %class_B** %a
    ;3 end statement: a = new A();
    ;4 start statement : printInt(a.test1());
    %t = load %class_B*, %class_B** %a
    %isNull = icmp eq %class_B* %t, null
    br i1 %isNull, label %whenIsNull, label %notNull
    
whenIsNull:
    ; ERROR: Nullpointer exception in line frontend.SourcePosition@7eb91b95
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([64 x i8], [64 x i8]* @.print_message_4, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
notNull:
    %ptrVTablePointer = getelementptr %class_B, %class_B* %t, i32 0, i32 0
    %ptrVTable = load %vTable_B*, %vTable_B** %ptrVTablePointer
    %ptrMethod = getelementptr %vTable_B, %vTable_B* %ptrVTable, i32 0, i32 0
    %method = load i32(%class_B*)*, i32(%class_B*)** %ptrMethod
    %test1_result = call i32 %method(%class_B* %t)
    call void @print(i32 %test1_result)
    ;4 end statement: printInt(a.test1());
    ;5 start statement : printInt(a.test2());
    %t1 = load %class_B*, %class_B** %a
    %isNull1 = icmp eq %class_B* %t1, null
    br i1 %isNull1, label %whenIsNull1, label %notNull1
    
whenIsNull1:
    ; ERROR: Nullpointer exception in line frontend.SourcePosition@33260ecd
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([64 x i8], [64 x i8]* @.print_message_5, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
notNull1:
    %ptrVTablePointer1 = getelementptr %class_B, %class_B* %t1, i32 0, i32 0
    %ptrVTable1 = load %vTable_B*, %vTable_B** %ptrVTablePointer1
    %ptrMethod1 = getelementptr %vTable_B, %vTable_B* %ptrVTable1, i32 0, i32 1
    %method1 = load i32(%class_B*)*, i32(%class_B*)** %ptrMethod1
    %test2_result = call i32 %method1(%class_B* %t1)
    call void @print(i32 %test2_result)
    ;5 end statement: printInt(a.test2());
    ;6 start statement : f(a);
    %t2 = load %class_B*, %class_B** %a
    %f_result = call i32 @f(%class_B* %t2)
    ;6 end statement: f(a);
    ;7 start statement : a = new B();
    %newObject1 = call %class_B* @constructor_B1()
    store %class_B* %newObject1, %class_B** %a
    ;7 end statement: a = new B();
    ;8 start statement : f(a);
    %t3 = load %class_B*, %class_B** %a
    %f_result1 = call i32 @f(%class_B* %t3)
    ;8 end statement: f(a);
    ;9 start statement : printInt(a.test1());
    %t4 = load %class_B*, %class_B** %a
    %isNull2 = icmp eq %class_B* %t4, null
    br i1 %isNull2, label %whenIsNull2, label %notNull2
    
whenIsNull2:
    ; ERROR: Nullpointer exception in line frontend.SourcePosition@3d2bb013
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([64 x i8], [64 x i8]* @.print_message_6, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
notNull2:
    %ptrVTablePointer2 = getelementptr %class_B, %class_B* %t4, i32 0, i32 0
    %ptrVTable2 = load %vTable_B*, %vTable_B** %ptrVTablePointer2
    %ptrMethod2 = getelementptr %vTable_B, %vTable_B* %ptrVTable2, i32 0, i32 0
    %method2 = load i32(%class_B*)*, i32(%class_B*)** %ptrMethod2
    %test1_result1 = call i32 %method2(%class_B* %t4)
    call void @print(i32 %test1_result1)
    ;9 end statement: printInt(a.test1());
    ;10 start statement : printInt(a.test2());
    %t5 = load %class_B*, %class_B** %a
    %isNull3 = icmp eq %class_B* %t5, null
    br i1 %isNull3, label %whenIsNull3, label %notNull3
    
whenIsNull3:
    ; ERROR: Nullpointer exception in line frontend.SourcePosition@21ec7946
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([64 x i8], [64 x i8]* @.print_message_7, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
notNull3:
    %ptrVTablePointer3 = getelementptr %class_B, %class_B* %t5, i32 0, i32 0
    %ptrVTable3 = load %vTable_B*, %vTable_B** %ptrVTablePointer3
    %ptrMethod3 = getelementptr %vTable_B, %vTable_B* %ptrVTable3, i32 0, i32 1
    %method3 = load i32(%class_B*)*, i32(%class_B*)** %ptrMethod3
    %test2_result1 = call i32 %method3(%class_B* %t5)
    call void @print(i32 %test2_result1)
    ;10 end statement: printInt(a.test2());
    ;11 start statement : return 0;
    ret i32 0
    

}

define %class_A* @constructor_A1() {
constructorBlock:
    %mallocVar = call i8* @malloc(i32 ptrtoint (%class_A* getelementptr (%class_A, %class_A* null, i32 1) to i32))
    %newClass = bitcast i8* %mallocVar to %class_A*
    %address = getelementptr %class_A, %class_A* %newClass, i32 0, i32 0
    store %vTable_A* @vTableGlobal_A, %vTable_A** %address
    ret %class_A* %newClass
    

}

define %class_B* @constructor_B1() {
constructorBlock:
    %mallocVar = call i8* @malloc(i32 ptrtoint (%class_B* getelementptr (%class_B, %class_B* null, i32 1) to i32))
    %newClass = bitcast i8* %mallocVar to %class_B*
    %address = getelementptr %class_B, %class_B* %newClass, i32 0, i32 0
    store %vTable_B* @vTableGlobal_B, %vTable_B** %address
    ret %class_B* %newClass
    

}


declare noalias i8* @malloc(i32)

declare i32 @printf(i8*, ...)

declare void @exit(i32)

@.printstr = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1
define void @print(i32 %i) {
    %temp = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.printstr, i32 0, i32 0), i32 %i)
    ret void
}
