

define i32 @main() {
init:
    %fred = alloca i32
    ;7 start statement : {
    ;8 start statement : int fred
    ;8 end statement: int fred
    ;9 start statement : fred = 500;
    store i32 500, i32* %fred
    ;9 end statement: fred = 500;
    ;10 start statement : printInt(fred);
    %t = load i32, i32* %fred
    call void @print(i32 %t)
    ;10 end statement: printInt(fred);
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
