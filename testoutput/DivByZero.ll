@.print_message_1 = private unnamed_addr constant [28 x i8] c"Division by zero in line 2\0A\00", align 1


define i32 @main() {
init:
    ;1 start statement : {
    ;2 start statement : printInt((100 / 0));
    %divResVar = alloca i32
    %isZero = icmp eq i32 0, 0
    br i1 %isZero, label %ifZero, label %notZero
    
ifZero:
    ; ERROR: Division by zero in line 2
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([28 x i8], [28 x i8]* @.print_message_1, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
notZero:
    %isMinusOne = icmp eq i32 0, -1
    %isMinInt = icmp eq i32 100, -2147483648
    %isOverflow = and i1 %isMinInt, %isMinusOne
    store i32 -2147483648, i32* %divResVar
    br i1 %isOverflow, label %div_end, label %div_noOverflow
    
div_noOverflow:
    %divResultA = sdiv i32 100, 0
    store i32 %divResultA, i32* %divResVar
    br label %div_end
    
div_end:
    %divResultB = load i32, i32* %divResVar
    call void @print(i32 %divResultB)
    ;2 end statement: printInt((100 / 0));
    ;3 start statement : return 0;
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
