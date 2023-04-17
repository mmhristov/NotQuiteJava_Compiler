

define i32 @main() {
init:
    %a = alloca i32
    ;1 start statement : {
    ;2 start statement : int a
    ;2 end statement: int a
    ;1 start statement : {
    ;4 start statement : a = (4 + 1);
    %resAddImpl = add i32 4, 1
    store i32 %resAddImpl, i32* %a
    ;4 end statement: a = (4 + 1);
    ;1 end statement: {
    ;6 start statement : printInt(a);
    %t = load i32, i32* %a
    call void @print(i32 %t)
    ;6 end statement: printInt(a);
    ;7 start statement : return 0;
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
