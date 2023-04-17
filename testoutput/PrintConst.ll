

define i32 @main() {
init:
    ;7 start statement : {
    ;8 start statement : printInt(1);
    call void @print(i32 1)
    ;8 end statement: printInt(1);
    ;9 start statement : printInt(2);
    call void @print(i32 2)
    ;9 end statement: printInt(2);
    ;10 start statement : return 0;
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
