

define i32 @main() {
init:
    ;1 start statement : {
    ;2 start statement : printInt(4);
    call void @print(i32 4)
    ;2 end statement: printInt(4);
    ;3 start statement : printInt(5);
    call void @print(i32 5)
    ;3 end statement: printInt(5);
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
