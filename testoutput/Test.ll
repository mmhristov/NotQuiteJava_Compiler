

define i32 @main() {
init:
    %x = alloca i32
    ;1 start statement : {
    ;2 start statement : int x
    ;2 end statement: int x
    ;3 start statement : x = 42;
    store i32 42, i32* %x
    ;3 end statement: x = 42;
    ;4 start statement : while ((0 < x)) {
    br label %whileStart
    
whileStart:
    %t = load i32, i32* %x
    %resSltImpl = icmp slt i32 0, %t
    br i1 %resSltImpl, label %loopBodyStart, label %endloop
    
loopBodyStart:
    ;4 start statement : {
    ;5 start statement : printInt(x);
    %t1 = load i32, i32* %x
    call void @print(i32 %t1)
    ;5 end statement: printInt(x);
    ;6 start statement : x = (x - 1);
    %t2 = load i32, i32* %x
    %resSubImpl = sub i32 %t2, 1
    store i32 %resSubImpl, i32* %x
    ;6 end statement: x = (x - 1);
    ;4 end statement: {
    br label %whileStart
    
endloop:
    ;4 end statement: while ((0 < x)) {
    ;8 start statement : return 0;
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
