

define i32 @main() {
init:
    %x = alloca i32
    %b = alloca i1
    ;1 start statement : {
    ;2 start statement : int x
    ;2 end statement: int x
    ;3 start statement : boolean b
    ;3 end statement: boolean b
    ;4 start statement : x = ((- 1) + 2);
    %minus_res = sub i32 0, 1
    %resAddImpl = add i32 %minus_res, 2
    store i32 %resAddImpl, i32* %x
    ;4 end statement: x = ((- 1) + 2);
    ;5 start statement : x = (567 * 876);
    %resMulImpl = mul i32 567, 876
    store i32 %resMulImpl, i32* %x
    ;5 end statement: x = (567 * 876);
    ;6 start statement : x = (34 - 12);
    %resSubImpl = sub i32 34, 12
    store i32 %resSubImpl, i32* %x
    ;6 end statement: x = (34 - 12);
    ;7 start statement : b = (234 < 9218347);
    %resSltImpl = icmp slt i32 234, 9218347
    store i1 %resSltImpl, i1* %b
    ;7 end statement: b = (234 < 9218347);
    ;8 start statement : b = (true && false);
    %andResVar = alloca i1
    store i1 1, i1* %andResVar
    br i1 1, label %and_first_true, label %and_end
    
and_first_true:
    store i1 0, i1* %andResVar
    br label %and_end
    
and_end:
    %andRes = load i1, i1* %andResVar
    store i1 %andRes, i1* %b
    ;8 end statement: b = (true && false);
    ;9 start statement : return 0;
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
