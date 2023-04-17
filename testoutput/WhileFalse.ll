

define i32 @main() {
init:
    %f = alloca i1
    ;1 start statement : {
    ;2 start statement : boolean f
    ;2 end statement: boolean f
    ;3 start statement : f = false;
    store i1 0, i1* %f
    ;3 end statement: f = false;
    ;4 start statement : while (f) {
    br label %whileStart
    
whileStart:
    %t = load i1, i1* %f
    br i1 %t, label %loopBodyStart, label %endloop
    
loopBodyStart:
    ;4 start statement : {
    ;5 start statement : printInt(666);
    call void @print(i32 666)
    ;5 end statement: printInt(666);
    ;4 end statement: {
    br label %whileStart
    
endloop:
    ;4 end statement: while (f) {
    ;7 start statement : printInt(1);
    call void @print(i32 1)
    ;7 end statement: printInt(1);
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
