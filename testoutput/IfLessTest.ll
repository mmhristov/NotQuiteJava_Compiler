

define i32 @main() {
init:
    ;7 start statement : {
    ;8 start statement : if ((1 < 2)) {
    %resSltImpl = icmp slt i32 1, 2
    br i1 %resSltImpl, label %ifTrue, label %ifFalse
    
ifTrue:
    ;8 start statement : {
    ;9 start statement : printInt(1);
    call void @print(i32 1)
    ;9 end statement: printInt(1);
    ;8 end statement: {
    br label %endif
    
ifFalse:
    ;8 start statement : {
    ;11 start statement : printInt(666);
    call void @print(i32 666)
    ;11 end statement: printInt(666);
    ;8 end statement: {
    br label %endif
    
endif:
    ;8 end statement: if ((1 < 2)) {
    ;13 start statement : if ((2 < 1)) {
    %resSltImpl1 = icmp slt i32 2, 1
    br i1 %resSltImpl1, label %ifTrue1, label %ifFalse1
    
ifTrue1:
    ;13 start statement : {
    ;14 start statement : printInt(999);
    call void @print(i32 999)
    ;14 end statement: printInt(999);
    ;13 end statement: {
    br label %endif1
    
ifFalse1:
    ;13 start statement : {
    ;16 start statement : printInt(2);
    call void @print(i32 2)
    ;16 end statement: printInt(2);
    ;13 end statement: {
    br label %endif1
    
endif1:
    ;13 end statement: if ((2 < 1)) {
    ;18 start statement : if ((1 < 1)) {
    %resSltImpl2 = icmp slt i32 1, 1
    br i1 %resSltImpl2, label %ifTrue2, label %ifFalse2
    
ifTrue2:
    ;18 start statement : {
    ;19 start statement : printInt(999);
    call void @print(i32 999)
    ;19 end statement: printInt(999);
    ;18 end statement: {
    br label %endif2
    
ifFalse2:
    ;18 start statement : {
    ;21 start statement : printInt(3);
    call void @print(i32 3)
    ;21 end statement: printInt(3);
    ;18 end statement: {
    br label %endif2
    
endif2:
    ;18 end statement: if ((1 < 1)) {
    ;23 start statement : printInt(4);
    call void @print(i32 4)
    ;23 end statement: printInt(4);
    ;24 start statement : return 0;
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
