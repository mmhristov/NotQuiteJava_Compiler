

define i32 @main() {
init:
    %b = alloca i1
    ;1 start statement : {
    ;2 start statement : boolean b
    ;2 end statement: boolean b
    ;3 start statement : b = (! true);
    %neg_res = icmp eq i1 0, 1
    store i1 %neg_res, i1* %b
    ;3 end statement: b = (! true);
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
