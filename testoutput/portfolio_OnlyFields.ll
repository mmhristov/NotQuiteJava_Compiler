@.print_message_1 = private unnamed_addr constant [33 x i8] c"Nullpointer exception in line 6\0A\00", align 1
@.print_message_2 = private unnamed_addr constant [33 x i8] c"Nullpointer exception in line 7\0A\00", align 1
@.print_message_3 = private unnamed_addr constant [33 x i8] c"Nullpointer exception in line 8\0A\00", align 1


%class_TTTest = type {
     %vTable_TTTest*  ; vTable
    ,i32  ; var1
    ,i32  ; var2
}

%vTable_TTTest = type {
}

%vTable_TTTest1 = type {
}

@vTableGlobal_TTTest = constant %vTable_TTTest  {
    
}


define %class_TTTest* @constructor_TTTest() {
constructorBlock:
    %mallocVar = call i8* @malloc(i32 ptrtoint (%class_TTTest* getelementptr (%class_TTTest, %class_TTTest* null, i32 1) to i32))
    %newClass = bitcast i8* %mallocVar to %class_TTTest*
    %address = getelementptr %class_TTTest, %class_TTTest* %newClass, i32 0, i32 0
    store %vTable_TTTest* @vTableGlobal_TTTest, %vTable_TTTest** %address
    %fieldTempVar_var1 = getelementptr %class_TTTest, %class_TTTest* %newClass, i32 0, i32 1
    store i32 0, i32* %fieldTempVar_var1
    %fieldTempVar_var2 = getelementptr %class_TTTest, %class_TTTest* %newClass, i32 0, i32 2
    store i32 0, i32* %fieldTempVar_var2
    ret %class_TTTest* %newClass
    

}

define i32 @main() {
init:
    %c = alloca %class_TTTest*
    ;3 start statement : {
    ;4 start statement : TTTest c
    ;4 end statement: TTTest c
    ;5 start statement : c = new TTTest();
    %newObject = call %class_TTTest* @constructor_TTTest()
    store %class_TTTest* %newObject, %class_TTTest** %c
    ;5 end statement: c = new TTTest();
    ;6 start statement : c.var1 = 1;
    %t = load %class_TTTest*, %class_TTTest** %c
    %isNull = icmp eq %class_TTTest* %t, null
    br i1 %isNull, label %whenIsNull, label %notNull
    
whenIsNull:
    ; ERROR: Nullpointer exception in line 6
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([33 x i8], [33 x i8]* @.print_message_1, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
notNull:
    %ptrField = getelementptr %class_TTTest, %class_TTTest* %t, i32 0, i32 1
    store i32 1, i32* %ptrField
    ;6 end statement: c.var1 = 1;
    ;7 start statement : c.var2 = (c.var1 + 2);
    %t1 = load %class_TTTest*, %class_TTTest** %c
    %isNull1 = icmp eq %class_TTTest* %t1, null
    br i1 %isNull1, label %whenIsNull1, label %notNull1
    
whenIsNull1:
    ; ERROR: Nullpointer exception in line 7
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([33 x i8], [33 x i8]* @.print_message_2, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
notNull1:
    %ptrField1 = getelementptr %class_TTTest, %class_TTTest* %t1, i32 0, i32 2
    %t2 = load %class_TTTest*, %class_TTTest** %c
    %isNull2 = icmp eq %class_TTTest* %t2, null
    br i1 %isNull2, label %whenIsNull2, label %notNull2
    
whenIsNull2:
    ; ERROR: Nullpointer exception in line 7
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([33 x i8], [33 x i8]* @.print_message_2, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
notNull2:
    %ptrField2 = getelementptr %class_TTTest, %class_TTTest* %t2, i32 0, i32 1
    %t3 = load i32, i32* %ptrField2
    %resAddImpl = add i32 %t3, 2
    store i32 %resAddImpl, i32* %ptrField1
    ;7 end statement: c.var2 = (c.var1 + 2);
    ;8 start statement : printInt(c.var2);
    %t4 = load %class_TTTest*, %class_TTTest** %c
    %isNull3 = icmp eq %class_TTTest* %t4, null
    br i1 %isNull3, label %whenIsNull3, label %notNull3
    
whenIsNull3:
    ; ERROR: Nullpointer exception in line 8
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([33 x i8], [33 x i8]* @.print_message_3, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
notNull3:
    %ptrField3 = getelementptr %class_TTTest, %class_TTTest* %t4, i32 0, i32 2
    %t5 = load i32, i32* %ptrField3
    call void @print(i32 %t5)
    ;8 end statement: printInt(c.var2);
    ;9 start statement : return 0;
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
