

define i32 @main() {
init:
    %i = alloca i32
    ;1 start statement : {
    ;2 start statement : int i
    ;2 end statement: int i
    ;3 start statement : i = 7;
    store i32 7, i32* %i
    ;3 end statement: i = 7;
    ;4 start statement : while ((i < 3)) {
    br label %whileStart
    
whileStart:
    %t = load i32, i32* %i
    %resSltImpl = icmp slt i32 %t, 3
    br i1 %resSltImpl, label %loopBodyStart, label %endloop
    
loopBodyStart:
    ;4 start statement : {
    ;4 end statement: {
    br label %whileStart
    
endloop:
    ;4 end statement: while ((i < 3)) {
    ;6 start statement : return 0;
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
