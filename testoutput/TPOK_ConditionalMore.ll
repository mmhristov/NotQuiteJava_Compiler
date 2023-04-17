

define i32 @main() {
init:
    %blablabloe = alloca i32
    ;1 start statement : {
    ;2 start statement : int blablabloe
    ;2 end statement: int blablabloe
    ;3 start statement : if ((4 < 2)) {
    %resSltImpl = icmp slt i32 4, 2
    br i1 %resSltImpl, label %ifTrue, label %ifFalse
    
ifTrue:
    ;3 start statement : {
    ;4 start statement : blablabloe = 44;
    store i32 44, i32* %blablabloe
    ;4 end statement: blablabloe = 44;
    ;3 end statement: {
    br label %endif
    
ifFalse:
    ;3 start statement : {
    ;6 start statement : blablabloe = 22;
    store i32 22, i32* %blablabloe
    ;6 end statement: blablabloe = 22;
    ;3 end statement: {
    br label %endif
    
endif:
    ;3 end statement: if ((4 < 2)) {
    ;8 start statement : printInt(blablabloe);
    %t = load i32, i32* %blablabloe
    call void @print(i32 %t)
    ;8 end statement: printInt(blablabloe);
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
