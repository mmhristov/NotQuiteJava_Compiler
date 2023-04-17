

define i32 @main() {
init:
    %x = alloca i32
    ;7 start statement : {
    ;8 start statement : int x
    ;8 end statement: int x
    ;9 start statement : x = 7;
    store i32 7, i32* %x
    ;9 end statement: x = 7;
    ;10 start statement : printInt((4 * (x + 1)));
    %t = load i32, i32* %x
    %resAddImpl = add i32 %t, 1
    %resMulImpl = mul i32 4, %resAddImpl
    call void @print(i32 %resMulImpl)
    ;10 end statement: printInt((4 * (x + 1)));
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
