

define i32 @main() {
init:
    %i = alloca i32
    %doContinue = alloca i1
    ;2 start statement : {
    ;3 start statement : int i
    ;3 end statement: int i
    ;4 start statement : boolean doContinue
    ;4 end statement: boolean doContinue
    ;5 start statement : doContinue = true;
    store i1 1, i1* %doContinue
    ;5 end statement: doContinue = true;
    ;6 start statement : i = 0;
    store i32 0, i32* %i
    ;6 end statement: i = 0;
    ;7 start statement : printInt(100);
    call void @print(i32 100)
    ;7 end statement: printInt(100);
    ;8 start statement : while (doContinue) {
    br label %whileStart
    
whileStart:
    %t = load i1, i1* %doContinue
    br i1 %t, label %loopBodyStart, label %endloop
    
loopBodyStart:
    ;8 start statement : {
    ;9 start statement : printInt(i);
    %t1 = load i32, i32* %i
    call void @print(i32 %t1)
    ;9 end statement: printInt(i);
    ;10 start statement : i = (i + 1);
    %t2 = load i32, i32* %i
    %resAddImpl = add i32 %t2, 1
    store i32 %resAddImpl, i32* %i
    ;10 end statement: i = (i + 1);
    ;11 start statement : doContinue = (i < 3);
    %t3 = load i32, i32* %i
    %resSltImpl = icmp slt i32 %t3, 3
    store i1 %resSltImpl, i1* %doContinue
    ;11 end statement: doContinue = (i < 3);
    ;8 end statement: {
    br label %whileStart
    
endloop:
    ;8 end statement: while (doContinue) {
    ;13 start statement : printInt(101);
    call void @print(i32 101)
    ;13 end statement: printInt(101);
    ;14 start statement : return 0;
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
