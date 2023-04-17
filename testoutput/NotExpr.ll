

define i32 @main() {
init:
    %a = alloca i1
    %b = alloca i1
    ;7 start statement : {
    ;8 start statement : boolean a
    ;8 end statement: boolean a
    ;9 start statement : boolean b
    ;9 end statement: boolean b
    ;10 start statement : a = true;
    store i1 1, i1* %a
    ;10 end statement: a = true;
    ;11 start statement : b = (! a);
    %t = load i1, i1* %a
    %neg_res = icmp eq i1 0, %t
    store i1 %neg_res, i1* %b
    ;11 end statement: b = (! a);
    ;12 start statement : if (b) {
    %t1 = load i1, i1* %b
    br i1 %t1, label %ifTrue, label %ifFalse
    
ifTrue:
    ;12 start statement : {
    ;13 start statement : printInt(666);
    call void @print(i32 666)
    ;13 end statement: printInt(666);
    ;12 end statement: {
    br label %endif
    
ifFalse:
    ;12 start statement : {
    ;15 start statement : printInt(1);
    call void @print(i32 1)
    ;15 end statement: printInt(1);
    ;12 end statement: {
    br label %endif
    
endif:
    ;12 end statement: if (b) {
    ;17 start statement : return 0;
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
