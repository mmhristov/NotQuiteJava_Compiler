

define i32 @main() {
init:
    %i = alloca i32
    %n = alloca i32
    %sum = alloca i32
    ;1 start statement : {
    ;2 start statement : int i
    ;2 end statement: int i
    ;3 start statement : int n
    ;3 end statement: int n
    ;4 start statement : int sum
    ;4 end statement: int sum
    ;5 start statement : n = 20;
    store i32 20, i32* %n
    ;5 end statement: n = 20;
    ;6 start statement : sum = 0;
    store i32 0, i32* %sum
    ;6 end statement: sum = 0;
    ;7 start statement : i = 0;
    store i32 0, i32* %i
    ;7 end statement: i = 0;
    ;8 start statement : while ((i < n)) {
    br label %whileStart
    
whileStart:
    %t = load i32, i32* %i
    %t1 = load i32, i32* %n
    %resSltImpl = icmp slt i32 %t, %t1
    br i1 %resSltImpl, label %loopBodyStart, label %endloop
    
loopBodyStart:
    ;8 start statement : {
    ;9 start statement : i = (i + 1);
    %t2 = load i32, i32* %i
    %resAddImpl = add i32 %t2, 1
    store i32 %resAddImpl, i32* %i
    ;9 end statement: i = (i + 1);
    ;10 start statement : sum = (sum + i);
    %t3 = load i32, i32* %sum
    %t4 = load i32, i32* %i
    %resAddImpl1 = add i32 %t3, %t4
    store i32 %resAddImpl1, i32* %sum
    ;10 end statement: sum = (sum + i);
    ;8 end statement: {
    br label %whileStart
    
endloop:
    ;8 end statement: while ((i < n)) {
    ;12 start statement : printInt(sum);
    %t5 = load i32, i32* %sum
    call void @print(i32 %t5)
    ;12 end statement: printInt(sum);
    ;13 start statement : return 0;
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
