

define i32 @main() {
init:
    %i = alloca i32
    ;2 start statement : {
    ;3 start statement : int i
    ;3 end statement: int i
    ;4 start statement : i = 0;
    store i32 0, i32* %i
    ;4 end statement: i = 0;
    ;5 start statement : printInt(100);
    call void @print(i32 100)
    ;5 end statement: printInt(100);
    ;6 start statement : while (((i < 4) && (i < 3))) {
    br label %whileStart
    
whileStart:
    %t = load i32, i32* %i
    %resSltImpl = icmp slt i32 %t, 4
    %andResVar = alloca i1
    store i1 %resSltImpl, i1* %andResVar
    br i1 %resSltImpl, label %and_first_true, label %and_end
    
and_first_true:
    %t1 = load i32, i32* %i
    %resSltImpl1 = icmp slt i32 %t1, 3
    store i1 %resSltImpl1, i1* %andResVar
    br label %and_end
    
and_end:
    %andRes = load i1, i1* %andResVar
    br i1 %andRes, label %loopBodyStart, label %endloop
    
loopBodyStart:
    ;6 start statement : {
    ;7 start statement : printInt(i);
    %t2 = load i32, i32* %i
    call void @print(i32 %t2)
    ;7 end statement: printInt(i);
    ;8 start statement : i = (i + 1);
    %t3 = load i32, i32* %i
    %resAddImpl = add i32 %t3, 1
    store i32 %resAddImpl, i32* %i
    ;8 end statement: i = (i + 1);
    ;6 end statement: {
    br label %whileStart
    
endloop:
    ;6 end statement: while (((i < 4) && (i < 3))) {
    ;10 start statement : printInt(101);
    call void @print(i32 101)
    ;10 end statement: printInt(101);
    ;11 start statement : return 0;
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
