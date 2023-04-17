

define i32 @main() {
init:
    %falsch = alloca i1
    ;1 start statement : {
    ;2 start statement : boolean falsch
    ;2 end statement: boolean falsch
    ;3 start statement : falsch = (4 < 1);
    %resSltImpl = icmp slt i32 4, 1
    store i1 %resSltImpl, i1* %falsch
    ;3 end statement: falsch = (4 < 1);
    ;4 start statement : if (falsch) {
    %t = load i1, i1* %falsch
    br i1 %t, label %ifTrue, label %ifFalse
    
ifTrue:
    ;4 start statement : {
    ;5 start statement : printInt((- 9));
    %minus_res = sub i32 0, 9
    call void @print(i32 %minus_res)
    ;5 end statement: printInt((- 9));
    ;4 end statement: {
    br label %endif
    
ifFalse:
    ;4 start statement : {
    ;7 start statement : printInt(11);
    call void @print(i32 11)
    ;7 end statement: printInt(11);
    ;4 end statement: {
    br label %endif
    
endif:
    ;4 end statement: if (falsch) {
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
