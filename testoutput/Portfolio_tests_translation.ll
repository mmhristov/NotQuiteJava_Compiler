@.print_message_1 = private unnamed_addr constant [33 x i8] c"Nullpointer exception in line 8\0A\00", align 1
@.print_message_2 = private unnamed_addr constant [34 x i8] c"Nullpointer exception in line 16\0A\00", align 1
@.print_message_3 = private unnamed_addr constant [64 x i8] c"Nullpointer exception in line frontend.SourcePosition@1b765a2c\0A\00", align 1
@.print_message_4 = private unnamed_addr constant [34 x i8] c"Nullpointer exception in line 18\0A\00", align 1


%class_B = type {
     %vTable_B*  ; vTable
    ,i32  ; value
}

%vTable_B = type {
     i32(%class_B*)*  ; helloworld
}

%vTable_B1 = type {
     i32(%class_B*)*  ; helloworld
}

@vTableGlobal_B = constant %vTable_B  {
    i32(%class_B*)* @helloworld
}


define i32 @helloworld(%class_B* %this) {
init:
    ;7 start statement : {
    ;8 start statement : this.value = 4;
    %isNull = icmp eq %class_B* %this, null
    br i1 %isNull, label %whenIsNull, label %notNull
    
whenIsNull:
    ; ERROR: Nullpointer exception in line 8
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([33 x i8], [33 x i8]* @.print_message_1, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
notNull:
    %ptrField = getelementptr %class_B, %class_B* %this, i32 0, i32 1
    store i32 4, i32* %ptrField
    ;8 end statement: this.value = 4;
    ;9 start statement : return 1;
    ret i32 1
    

}

define %class_B* @constructor_B() {
constructorBlock:
    %mallocVar = call i8* @malloc(i32 ptrtoint (%class_B* getelementptr (%class_B, %class_B* null, i32 1) to i32))
    %newClass = bitcast i8* %mallocVar to %class_B*
    %address = getelementptr %class_B, %class_B* %newClass, i32 0, i32 0
    store %vTable_B* @vTableGlobal_B, %vTable_B** %address
    %fieldTempVar_value = getelementptr %class_B, %class_B* %newClass, i32 0, i32 1
    store i32 0, i32* %fieldTempVar_value
    ret %class_B* %newClass
    

}

define i32 @main() {
init:
    %b = alloca %class_B*
    ;13 start statement : {
    ;14 start statement : B b
    ;14 end statement: B b
    ;15 start statement : b = new B();
    %newObject = call %class_B* @constructor_B1()
    store %class_B* %newObject, %class_B** %b
    ;15 end statement: b = new B();
    ;16 start statement : printInt(b.value);
    %t = load %class_B*, %class_B** %b
    %isNull = icmp eq %class_B* %t, null
    br i1 %isNull, label %whenIsNull, label %notNull
    
whenIsNull:
    ; ERROR: Nullpointer exception in line 16
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([34 x i8], [34 x i8]* @.print_message_2, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
notNull:
    %ptrField = getelementptr %class_B, %class_B* %t, i32 0, i32 1
    %t1 = load i32, i32* %ptrField
    call void @print(i32 %t1)
    ;16 end statement: printInt(b.value);
    ;17 start statement : b.helloworld();
    %t2 = load %class_B*, %class_B** %b
    %isNull1 = icmp eq %class_B* %t2, null
    br i1 %isNull1, label %whenIsNull1, label %notNull1
    
whenIsNull1:
    ; ERROR: Nullpointer exception in line frontend.SourcePosition@1b765a2c
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([64 x i8], [64 x i8]* @.print_message_3, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
notNull1:
    %ptrVTablePointer = getelementptr %class_B, %class_B* %t2, i32 0, i32 0
    %ptrVTable = load %vTable_B*, %vTable_B** %ptrVTablePointer
    %ptrMethod = getelementptr %vTable_B, %vTable_B* %ptrVTable, i32 0, i32 0
    %method = load i32(%class_B*)*, i32(%class_B*)** %ptrMethod
    %helloworld_result = call i32 %method(%class_B* %t2)
    ;17 end statement: b.helloworld();
    ;18 start statement : printInt(b.value);
    %t3 = load %class_B*, %class_B** %b
    %isNull2 = icmp eq %class_B* %t3, null
    br i1 %isNull2, label %whenIsNull2, label %notNull2
    
whenIsNull2:
    ; ERROR: Nullpointer exception in line 18
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([34 x i8], [34 x i8]* @.print_message_4, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
notNull2:
    %ptrField1 = getelementptr %class_B, %class_B* %t3, i32 0, i32 1
    %t4 = load i32, i32* %ptrField1
    call void @print(i32 %t4)
    ;18 end statement: printInt(b.value);
    ;19 start statement : return 0;
    ret i32 0
    

}

define %class_B* @constructor_B1() {
constructorBlock:
    %mallocVar = call i8* @malloc(i32 ptrtoint (%class_B* getelementptr (%class_B, %class_B* null, i32 1) to i32))
    %newClass = bitcast i8* %mallocVar to %class_B*
    %address = getelementptr %class_B, %class_B* %newClass, i32 0, i32 0
    store %vTable_B* @vTableGlobal_B, %vTable_B** %address
    %fieldTempVar_value = getelementptr %class_B, %class_B* %newClass, i32 0, i32 1
    store i32 0, i32* %fieldTempVar_value
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
