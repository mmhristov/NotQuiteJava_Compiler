

define i32 @main() {
init:
    %blablabloe = alloca i32
    ;1 start statement : {
    ;2 start statement : int blablabloe
    ;2 end statement: int blablabloe
    ;3 start statement : blablabloe = 7;
    store i32 7, i32* %blablabloe
    ;3 end statement: blablabloe = 7;
    ;4 start statement : while ((1 < blablabloe)) {
    br label %whileStart
    
whileStart:
    %t = load i32, i32* %blablabloe
    %resSltImpl = icmp slt i32 1, %t
    br i1 %resSltImpl, label %loopBodyStart, label %endloop
    
loopBodyStart:
    ;4 start statement : {
    ;5 start statement : printInt(blablabloe);
    %t1 = load i32, i32* %blablabloe
    call void @print(i32 %t1)
    ;5 end statement: printInt(blablabloe);
    ;6 start statement : blablabloe = (blablabloe - 1);
    %t2 = load i32, i32* %blablabloe
    %resSubImpl = sub i32 %t2, 1
    store i32 %resSubImpl, i32* %blablabloe
    ;6 end statement: blablabloe = (blablabloe - 1);
    ;4 end statement: {
    br label %whileStart
    
endloop:
    ;4 end statement: while ((1 < blablabloe)) {
    ;8 start statement : return 0;
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
