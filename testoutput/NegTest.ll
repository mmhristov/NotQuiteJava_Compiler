

define i32 @main() {
init:
    %b = alloca i32
    ;1 start statement : {
    ;2 start statement : int b
    ;2 end statement: int b
    ;3 start statement : b = (- 5);
    %minus_res = sub i32 0, 5
    store i32 %minus_res, i32* %b
    ;3 end statement: b = (- 5);
    ;4 start statement : return 0;
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
