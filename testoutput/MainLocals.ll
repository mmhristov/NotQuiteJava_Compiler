

define i32 @main() {
init:
    %x = alloca i32
    %y = alloca i32
    ;1 start statement : {
    ;2 start statement : int x
    ;2 end statement: int x
    ;3 start statement : int y
    ;3 end statement: int y
    ;4 start statement : x = 1;
    store i32 1, i32* %x
    ;4 end statement: x = 1;
    ;5 start statement : y = x;
    %t = load i32, i32* %x
    store i32 %t, i32* %y
    ;5 end statement: y = x;
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
