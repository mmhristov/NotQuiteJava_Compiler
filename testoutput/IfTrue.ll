

define i32 @main() {
init:
    ;1 start statement : {
    ;2 start statement : if (true) {
    br i1 1, label %ifTrue, label %ifFalse
    
ifTrue:
    ;2 start statement : {
    ;3 start statement : printInt(1);
    call void @print(i32 1)
    ;3 end statement: printInt(1);
    ;2 end statement: {
    br label %endif
    
ifFalse:
    ;2 start statement : {
    ;5 start statement : printInt(666);
    call void @print(i32 666)
    ;5 end statement: printInt(666);
    ;2 end statement: {
    br label %endif
    
endif:
    ;2 end statement: if (true) {
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
