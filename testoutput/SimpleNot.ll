

define i32 @main() {
init:
    ;7 start statement : {
    ;8 start statement : if ((! (1 < 2))) {
    %resSltImpl = icmp slt i32 1, 2
    %neg_res = icmp eq i1 0, %resSltImpl
    br i1 %neg_res, label %ifTrue, label %ifFalse
    
ifTrue:
    ;8 start statement : {
    ;9 start statement : printInt(666);
    call void @print(i32 666)
    ;9 end statement: printInt(666);
    ;8 end statement: {
    br label %endif
    
ifFalse:
    ;8 start statement : {
    ;11 start statement : printInt(1);
    call void @print(i32 1)
    ;11 end statement: printInt(1);
    ;8 end statement: {
    br label %endif
    
endif:
    ;8 end statement: if ((! (1 < 2))) {
    ;13 start statement : if ((! (2 < 1))) {
    %resSltImpl1 = icmp slt i32 2, 1
    %neg_res1 = icmp eq i1 0, %resSltImpl1
    br i1 %neg_res1, label %ifTrue1, label %ifFalse1
    
ifTrue1:
    ;13 start statement : {
    ;14 start statement : printInt(2);
    call void @print(i32 2)
    ;14 end statement: printInt(2);
    ;13 end statement: {
    br label %endif1
    
ifFalse1:
    ;13 start statement : {
    ;16 start statement : printInt(999);
    call void @print(i32 999)
    ;16 end statement: printInt(999);
    ;13 end statement: {
    br label %endif1
    
endif1:
    ;13 end statement: if ((! (2 < 1))) {
    ;18 start statement : return 0;
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
