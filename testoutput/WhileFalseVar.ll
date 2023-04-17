

define i32 @main() {
init:
    %x = alloca i1
    ;1 start statement : {
    ;2 start statement : boolean x
    ;2 end statement: boolean x
    ;3 start statement : x = false;
    store i1 0, i1* %x
    ;3 end statement: x = false;
    ;4 start statement : printInt(1);
    call void @print(i32 1)
    ;4 end statement: printInt(1);
    ;5 start statement : while (x) {
    br label %whileStart
    
whileStart:
    %t = load i1, i1* %x
    br i1 %t, label %loopBodyStart, label %endloop
    
loopBodyStart:
    ;5 start statement : {
    ;6 start statement : printInt(666);
    call void @print(i32 666)
    ;6 end statement: printInt(666);
    ;5 end statement: {
    br label %whileStart
    
endloop:
    ;5 end statement: while (x) {
    ;8 start statement : printInt(2);
    call void @print(i32 2)
    ;8 end statement: printInt(2);
    ;9 start statement : return 0;
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
