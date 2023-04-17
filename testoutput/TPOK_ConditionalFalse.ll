

define i32 @main() {
init:
    ;1 start statement : {
    ;2 start statement : if (false) {
    br i1 0, label %ifTrue, label %ifFalse
    
ifTrue:
    ;2 start statement : {
    ;3 start statement : printInt(2);
    call void @print(i32 2)
    ;3 end statement: printInt(2);
    ;2 end statement: {
    br label %endif
    
ifFalse:
    ;2 start statement : {
    ;5 start statement : printInt(3);
    call void @print(i32 3)
    ;5 end statement: printInt(3);
    ;2 end statement: {
    br label %endif
    
endif:
    ;2 end statement: if (false) {
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
