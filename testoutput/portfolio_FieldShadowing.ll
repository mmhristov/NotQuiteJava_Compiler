@.print_message_1 = private unnamed_addr constant [64 x i8] c"Nullpointer exception in line frontend.SourcePosition@44e3a2b2\0A\00", align 1


%class_Shadower = type {
     %vTable_Shadower*  ; vTable
    ,i1  ; isShadowed
}

%vTable_Shadower = type {
     i32(%class_Shadower*)*  ; shadow
}

%vTable_Shadower1 = type {
     i32(%class_Shadower*)*  ; shadow
}

@vTableGlobal_Shadower = constant %vTable_Shadower  {
    i32(%class_Shadower*)* @shadow
}


define i32 @shadow(%class_Shadower* %this) {
init:
    %isShadowed = alloca i1
    ;10 start statement : {
    ;11 start statement : boolean isShadowed
    ;11 end statement: boolean isShadowed
    ;12 start statement : isShadowed = true;
    store i1 1, i1* %isShadowed
    ;12 end statement: isShadowed = true;
    ;13 start statement : if (isShadowed) {
    %t = load i1, i1* %isShadowed
    br i1 %t, label %ifTrue, label %ifFalse
    
ifTrue:
    ;13 start statement : {
    ;14 start statement : printInt(1);
    call void @print(i32 1)
    ;14 end statement: printInt(1);
    ;13 end statement: {
    br label %endif
    
ifFalse:
    ;13 start statement : {
    ;16 start statement : printInt(0);
    call void @print(i32 0)
    ;16 end statement: printInt(0);
    ;13 end statement: {
    br label %endif
    
endif:
    ;13 end statement: if (isShadowed) {
    ;18 start statement : return 0;
    ret i32 0
    

}

define i32 @main() {
init:
    %c = alloca %class_Shadower*
    ;1 start statement : {
    ;2 start statement : Shadower c
    ;2 end statement: Shadower c
    ;3 start statement : c = new Shadower();
    %newObject = call %class_Shadower* @constructor_Shadower()
    store %class_Shadower* %newObject, %class_Shadower** %c
    ;3 end statement: c = new Shadower();
    ;4 start statement : c.shadow();
    %t = load %class_Shadower*, %class_Shadower** %c
    %isNull = icmp eq %class_Shadower* %t, null
    br i1 %isNull, label %whenIsNull, label %notNull
    
whenIsNull:
    ; ERROR: Nullpointer exception in line frontend.SourcePosition@44e3a2b2
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([64 x i8], [64 x i8]* @.print_message_1, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
notNull:
    %ptrVTablePointer = getelementptr %class_Shadower, %class_Shadower* %t, i32 0, i32 0
    %ptrVTable = load %vTable_Shadower*, %vTable_Shadower** %ptrVTablePointer
    %ptrMethod = getelementptr %vTable_Shadower, %vTable_Shadower* %ptrVTable, i32 0, i32 0
    %method = load i32(%class_Shadower*)*, i32(%class_Shadower*)** %ptrMethod
    %shadow_result = call i32 %method(%class_Shadower* %t)
    ;4 end statement: c.shadow();
    ;5 start statement : return 0;
    ret i32 0
    

}

define %class_Shadower* @constructor_Shadower() {
constructorBlock:
    %mallocVar = call i8* @malloc(i32 ptrtoint (%class_Shadower* getelementptr (%class_Shadower, %class_Shadower* null, i32 1) to i32))
    %newClass = bitcast i8* %mallocVar to %class_Shadower*
    %address = getelementptr %class_Shadower, %class_Shadower* %newClass, i32 0, i32 0
    store %vTable_Shadower* @vTableGlobal_Shadower, %vTable_Shadower** %address
    %fieldTempVar_isShadowed = getelementptr %class_Shadower, %class_Shadower* %newClass, i32 0, i32 1
    store i1 0, i1* %fieldTempVar_isShadowed
    ret %class_Shadower* %newClass
    

}


declare noalias i8* @malloc(i32)

declare i32 @printf(i8*, ...)

declare void @exit(i32)

@.printstr = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1
define void @print(i32 %i) {
    %temp = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.printstr, i32 0, i32 0), i32 %i)
    ret void
}
