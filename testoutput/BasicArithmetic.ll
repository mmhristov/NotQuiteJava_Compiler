

define i32 @main() {
init:
    ;1 start statement : {
    ;2 start statement : printInt((2 + 5));
    %resAddImpl = add i32 2, 5
    call void @print(i32 %resAddImpl)
    ;2 end statement: printInt((2 + 5));
    ;3 start statement : printInt((2 - 5));
    %resSubImpl = sub i32 2, 5
    call void @print(i32 %resSubImpl)
    ;3 end statement: printInt((2 - 5));
    ;4 start statement : printInt(((- 2) + 5));
    %minus_res = sub i32 0, 2
    %resAddImpl1 = add i32 %minus_res, 5
    call void @print(i32 %resAddImpl1)
    ;4 end statement: printInt(((- 2) + 5));
    ;5 start statement : printInt((2 * 5));
    %resMulImpl = mul i32 2, 5
    call void @print(i32 %resMulImpl)
    ;5 end statement: printInt((2 * 5));
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
