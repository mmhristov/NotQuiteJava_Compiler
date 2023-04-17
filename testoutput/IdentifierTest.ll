

define i32 @main() {
init:
    %a3 = alloca i32
    %b_blub = alloca i32
    %HUGO = alloca i32
    %N8 = alloca i32
    ;1 start statement : {
    ;2 start statement : int a3
    ;2 end statement: int a3
    ;3 start statement : int b_blub
    ;3 end statement: int b_blub
    ;4 start statement : int HUGO
    ;4 end statement: int HUGO
    ;5 start statement : int N8
    ;5 end statement: int N8
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
