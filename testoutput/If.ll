

define i32 @main() {
init:
    %drei = alloca i32
    %vier = alloca i32
    ;1 start statement : {
    ;2 start statement : int drei
    ;2 end statement: int drei
    ;3 start statement : int vier
    ;3 end statement: int vier
    ;4 start statement : drei = 3;
    store i32 3, i32* %drei
    ;4 end statement: drei = 3;
    ;5 start statement : vier = (((2 * 2) * 1) * 1);
    %resMulImpl = mul i32 2, 2
    %resMulImpl1 = mul i32 %resMulImpl, 1
    %resMulImpl2 = mul i32 %resMulImpl1, 1
    store i32 %resMulImpl2, i32* %vier
    ;5 end statement: vier = (((2 * 2) * 1) * 1);
    ;6 start statement : if ((drei < vier)) {
    %t = load i32, i32* %drei
    %t1 = load i32, i32* %vier
    %resSltImpl = icmp slt i32 %t, %t1
    br i1 %resSltImpl, label %ifTrue, label %ifFalse
    
ifTrue:
    ;6 start statement : {
    ;7 start statement : printInt(drei);
    %t2 = load i32, i32* %drei
    call void @print(i32 %t2)
    ;7 end statement: printInt(drei);
    ;6 end statement: {
    br label %endif
    
ifFalse:
    ;6 start statement : {
    ;9 start statement : printInt(vier);
    %t3 = load i32, i32* %vier
    call void @print(i32 %t3)
    ;9 end statement: printInt(vier);
    ;6 end statement: {
    br label %endif
    
endif:
    ;6 end statement: if ((drei < vier)) {
    ;11 start statement : if ((vier < drei)) {
    %t4 = load i32, i32* %vier
    %t5 = load i32, i32* %drei
    %resSltImpl1 = icmp slt i32 %t4, %t5
    br i1 %resSltImpl1, label %ifTrue1, label %ifFalse1
    
ifTrue1:
    ;11 start statement : {
    ;12 start statement : printInt((44 * vier));
    %t6 = load i32, i32* %vier
    %resMulImpl3 = mul i32 44, %t6
    call void @print(i32 %resMulImpl3)
    ;12 end statement: printInt((44 * vier));
    ;13 start statement : drei = 0;
    store i32 0, i32* %drei
    ;13 end statement: drei = 0;
    ;14 start statement : vier = 27;
    store i32 27, i32* %vier
    ;14 end statement: vier = 27;
    ;11 end statement: {
    br label %endif1
    
ifFalse1:
    ;16 start statement : printInt(0);
    call void @print(i32 0)
    ;16 end statement: printInt(0);
    br label %endif1
    
endif1:
    ;11 end statement: if ((vier < drei)) {
    ;17 start statement : printInt((drei * vier));
    %t7 = load i32, i32* %drei
    %t8 = load i32, i32* %vier
    %resMulImpl4 = mul i32 %t7, %t8
    call void @print(i32 %resMulImpl4)
    ;17 end statement: printInt((drei * vier));
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
