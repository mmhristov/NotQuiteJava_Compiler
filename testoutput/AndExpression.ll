

define i32 @main() {
init:
    %z = alloca i1
    %wahr = alloca i1
    ;2 start statement : {
    ;3 start statement : boolean z
    ;3 end statement: boolean z
    ;4 start statement : boolean wahr
    ;4 end statement: boolean wahr
    ;5 start statement : wahr = true;
    store i1 1, i1* %wahr
    ;5 end statement: wahr = true;
    ;6 start statement : z = (wahr && false);
    %t = load i1, i1* %wahr
    %andResVar = alloca i1
    store i1 %t, i1* %andResVar
    br i1 %t, label %and_first_true, label %and_end
    
and_first_true:
    store i1 0, i1* %andResVar
    br label %and_end
    
and_end:
    %andRes = load i1, i1* %andResVar
    store i1 %andRes, i1* %z
    ;6 end statement: z = (wahr && false);
    ;7 start statement : if (z) {
    %t1 = load i1, i1* %z
    br i1 %t1, label %ifTrue, label %ifFalse
    
ifTrue:
    ;7 start statement : {
    ;8 start statement : printInt(666);
    call void @print(i32 666)
    ;8 end statement: printInt(666);
    ;7 end statement: {
    br label %endif
    
ifFalse:
    ;7 start statement : {
    ;10 start statement : printInt(1);
    call void @print(i32 1)
    ;10 end statement: printInt(1);
    ;7 end statement: {
    br label %endif
    
endif:
    ;7 end statement: if (z) {
    ;13 start statement : z = (wahr && true);
    %t2 = load i1, i1* %wahr
    %andResVar1 = alloca i1
    store i1 %t2, i1* %andResVar1
    br i1 %t2, label %and_first_true1, label %and_end1
    
and_first_true1:
    store i1 1, i1* %andResVar1
    br label %and_end1
    
and_end1:
    %andRes1 = load i1, i1* %andResVar1
    store i1 %andRes1, i1* %z
    ;13 end statement: z = (wahr && true);
    ;14 start statement : if (z) {
    %t3 = load i1, i1* %z
    br i1 %t3, label %ifTrue1, label %ifFalse1
    
ifTrue1:
    ;14 start statement : {
    ;15 start statement : printInt(2);
    call void @print(i32 2)
    ;15 end statement: printInt(2);
    ;14 end statement: {
    br label %endif1
    
ifFalse1:
    ;14 start statement : {
    ;17 start statement : printInt(667);
    call void @print(i32 667)
    ;17 end statement: printInt(667);
    ;14 end statement: {
    br label %endif1
    
endif1:
    ;14 end statement: if (z) {
    ;19 start statement : return 0;
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
