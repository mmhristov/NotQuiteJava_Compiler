@.print_message_1 = private unnamed_addr constant [33 x i8] c"Nullpointer exception in line 7\0A\00", align 1
@.print_message_2 = private unnamed_addr constant [64 x i8] c"Nullpointer exception in line frontend.SourcePosition@52066604\0A\00", align 1
@.print_message_3 = private unnamed_addr constant [33 x i8] c"Nullpointer exception in line 8\0A\00", align 1


%class_SimpleMethods = type {
     %vTable_SimpleMethods*  ; vTable
    ,i1  ; isSimple
    ,i32  ; numnum
}

%vTable_SimpleMethods = type {
     i32(%class_SimpleMethods*, i1)*  ; simpleMethod
}

%vTable_SimpleMethods1 = type {
     i32(%class_SimpleMethods*, i1)*  ; simpleMethod
}

@vTableGlobal_SimpleMethods = constant %vTable_SimpleMethods  {
    i32(%class_SimpleMethods*, i1)* @simpleMethod
}


define i32 @simpleMethod(%class_SimpleMethods* %this, i1 %argument) {
init:
    %argument1 = alloca i1
    store i1 %argument, i1* %argument1
    ;15 start statement : {
    ;16 start statement : if (argument) {
    %t = load i1, i1* %argument1
    br i1 %t, label %ifTrue, label %ifFalse
    
ifTrue:
    ;16 start statement : {
    ;17 start statement : printInt(1);
    call void @print(i32 1)
    ;17 end statement: printInt(1);
    ;16 end statement: {
    br label %endif
    
ifFalse:
    ;16 start statement : {
    ;19 start statement : numnum = (numnum - 2);
    %ptrField = getelementptr %class_SimpleMethods, %class_SimpleMethods* %this, i32 0, i32 2
    %ptrField1 = getelementptr %class_SimpleMethods, %class_SimpleMethods* %this, i32 0, i32 2
    %t1 = load i32, i32* %ptrField1
    %resSubImpl = sub i32 %t1, 2
    store i32 %resSubImpl, i32* %ptrField
    ;19 end statement: numnum = (numnum - 2);
    ;20 start statement : printInt(numnum);
    %ptrField2 = getelementptr %class_SimpleMethods, %class_SimpleMethods* %this, i32 0, i32 2
    %t2 = load i32, i32* %ptrField2
    call void @print(i32 %t2)
    ;20 end statement: printInt(numnum);
    ;16 end statement: {
    br label %endif
    
endif:
    ;16 end statement: if (argument) {
    ;22 start statement : return 0;
    ret i32 0
    

}

define %class_SimpleMethods* @constructor_SimpleMethods() {
constructorBlock:
    %mallocVar = call i8* @malloc(i32 ptrtoint (%class_SimpleMethods* getelementptr (%class_SimpleMethods, %class_SimpleMethods* null, i32 1) to i32))
    %newClass = bitcast i8* %mallocVar to %class_SimpleMethods*
    %address = getelementptr %class_SimpleMethods, %class_SimpleMethods* %newClass, i32 0, i32 0
    store %vTable_SimpleMethods* @vTableGlobal_SimpleMethods, %vTable_SimpleMethods** %address
    %fieldTempVar_isSimple = getelementptr %class_SimpleMethods, %class_SimpleMethods* %newClass, i32 0, i32 1
    store i1 0, i1* %fieldTempVar_isSimple
    %fieldTempVar_numnum = getelementptr %class_SimpleMethods, %class_SimpleMethods* %newClass, i32 0, i32 2
    store i32 0, i32* %fieldTempVar_numnum
    ret %class_SimpleMethods* %newClass
    

}

define i32 @main() {
init:
    %c = alloca %class_SimpleMethods*
    ;4 start statement : {
    ;5 start statement : SimpleMethods c
    ;5 end statement: SimpleMethods c
    ;6 start statement : c = new SimpleMethods();
    %newObject = call %class_SimpleMethods* @constructor_SimpleMethods()
    store %class_SimpleMethods* %newObject, %class_SimpleMethods** %c
    ;6 end statement: c = new SimpleMethods();
    ;7 start statement : c.isSimple = false;
    %t = load %class_SimpleMethods*, %class_SimpleMethods** %c
    %isNull = icmp eq %class_SimpleMethods* %t, null
    br i1 %isNull, label %whenIsNull, label %notNull
    
whenIsNull:
    ; ERROR: Nullpointer exception in line 7
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([33 x i8], [33 x i8]* @.print_message_1, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
notNull:
    %ptrField = getelementptr %class_SimpleMethods, %class_SimpleMethods* %t, i32 0, i32 1
    store i1 0, i1* %ptrField
    ;7 end statement: c.isSimple = false;
    ;8 start statement : c.simpleMethod(c.isSimple);
    %t1 = load %class_SimpleMethods*, %class_SimpleMethods** %c
    %isNull1 = icmp eq %class_SimpleMethods* %t1, null
    br i1 %isNull1, label %whenIsNull1, label %notNull1
    
whenIsNull1:
    ; ERROR: Nullpointer exception in line frontend.SourcePosition@52066604
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([64 x i8], [64 x i8]* @.print_message_2, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
notNull1:
    %ptrVTablePointer = getelementptr %class_SimpleMethods, %class_SimpleMethods* %t1, i32 0, i32 0
    %ptrVTable = load %vTable_SimpleMethods*, %vTable_SimpleMethods** %ptrVTablePointer
    %ptrMethod = getelementptr %vTable_SimpleMethods, %vTable_SimpleMethods* %ptrVTable, i32 0, i32 0
    %method = load i32(%class_SimpleMethods*, i1)*, i32(%class_SimpleMethods*, i1)** %ptrMethod
    %t2 = load %class_SimpleMethods*, %class_SimpleMethods** %c
    %isNull2 = icmp eq %class_SimpleMethods* %t2, null
    br i1 %isNull2, label %whenIsNull2, label %notNull2
    
whenIsNull2:
    ; ERROR: Nullpointer exception in line 8
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([33 x i8], [33 x i8]* @.print_message_3, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
notNull2:
    %ptrField1 = getelementptr %class_SimpleMethods, %class_SimpleMethods* %t2, i32 0, i32 1
    %t3 = load i1, i1* %ptrField1
    %simpleMethod_result = call i32 %method(%class_SimpleMethods* %t1, i1 %t3)
    ;8 end statement: c.simpleMethod(c.isSimple);
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
