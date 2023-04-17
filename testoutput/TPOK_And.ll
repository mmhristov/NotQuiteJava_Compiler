

define i32 @main() {
init:
    %falsch = alloca i1
    ;1 start statement : {
    ;2 start statement : boolean falsch
    ;2 end statement: boolean falsch
    ;3 start statement : falsch = (4 < 1);
    %resSltImpl = icmp slt i32 4, 1
    store i1 %resSltImpl, i1* %falsch
    ;3 end statement: falsch = (4 < 1);
    ;4 start statement : if ((falsch && true)) {
    %t = load i1, i1* %falsch
    %andResVar = alloca i1
    store i1 %t, i1* %andResVar
    br i1 %t, label %and_first_true, label %and_end
    
and_first_true:
    store i1 1, i1* %andResVar
    br label %and_end
    
and_end:
    %andRes = load i1, i1* %andResVar
    br i1 %andRes, label %ifTrue, label %ifFalse
    
ifTrue:
    ;4 start statement : {
    ;5 start statement : printInt((- 9));
    %minus_res = sub i32 0, 9
    call void @print(i32 %minus_res)
    ;5 end statement: printInt((- 9));
    ;4 end statement: {
    br label %endif
    
ifFalse:
    ;4 start statement : {
    ;7 start statement : printInt(11);
    call void @print(i32 11)
    ;7 end statement: printInt(11);
    ;4 end statement: {
    br label %endif
    
endif:
    ;4 end statement: if ((falsch && true)) {
    ;9 start statement : if (((! falsch) && true)) {
    %t1 = load i1, i1* %falsch
    %neg_res = icmp eq i1 0, %t1
    %andResVar1 = alloca i1
    store i1 %neg_res, i1* %andResVar1
    br i1 %neg_res, label %and_first_true1, label %and_end1
    
and_first_true1:
    store i1 1, i1* %andResVar1
    br label %and_end1
    
and_end1:
    %andRes1 = load i1, i1* %andResVar1
    br i1 %andRes1, label %ifTrue1, label %ifFalse1
    
ifTrue1:
    ;9 start statement : {
    ;10 start statement : printInt((- 7));
    %minus_res1 = sub i32 0, 7
    call void @print(i32 %minus_res1)
    ;10 end statement: printInt((- 7));
    ;9 end statement: {
    br label %endif1
    
ifFalse1:
    ;9 start statement : {
    ;12 start statement : printInt(13);
    call void @print(i32 13)
    ;12 end statement: printInt(13);
    ;9 end statement: {
    br label %endif1
    
endif1:
    ;9 end statement: if (((! falsch) && true)) {
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
