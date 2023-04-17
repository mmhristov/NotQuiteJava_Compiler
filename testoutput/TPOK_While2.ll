

define i32 @main() {
init:
    %blablabloe = alloca i32
    %weitermachen = alloca i1
    ;1 start statement : {
    ;2 start statement : int blablabloe
    ;2 end statement: int blablabloe
    ;3 start statement : boolean weitermachen
    ;3 end statement: boolean weitermachen
    ;4 start statement : weitermachen = true;
    store i1 1, i1* %weitermachen
    ;4 end statement: weitermachen = true;
    ;5 start statement : blablabloe = 7;
    store i32 7, i32* %blablabloe
    ;5 end statement: blablabloe = 7;
    ;6 start statement : while (weitermachen) {
    br label %whileStart
    
whileStart:
    %t = load i1, i1* %weitermachen
    br i1 %t, label %loopBodyStart, label %endloop
    
loopBodyStart:
    ;6 start statement : {
    ;7 start statement : printInt(99);
    call void @print(i32 99)
    ;7 end statement: printInt(99);
    ;8 start statement : if ((weitermachen && (blablabloe < 0))) {
    %t1 = load i1, i1* %weitermachen
    %andResVar = alloca i1
    store i1 %t1, i1* %andResVar
    br i1 %t1, label %and_first_true, label %and_end
    
and_first_true:
    %t2 = load i32, i32* %blablabloe
    %resSltImpl = icmp slt i32 %t2, 0
    store i1 %resSltImpl, i1* %andResVar
    br label %and_end
    
and_end:
    %andRes = load i1, i1* %andResVar
    br i1 %andRes, label %ifTrue, label %ifFalse
    
ifTrue:
    ;8 start statement : {
    ;9 start statement : weitermachen = false;
    store i1 0, i1* %weitermachen
    ;9 end statement: weitermachen = false;
    ;8 end statement: {
    br label %endif
    
ifFalse:
    ;8 start statement : {
    ;8 end statement: {
    br label %endif
    
endif:
    ;8 end statement: if ((weitermachen && (blablabloe < 0))) {
    ;12 start statement : blablabloe = (blablabloe - 1);
    %t3 = load i32, i32* %blablabloe
    %resSubImpl = sub i32 %t3, 1
    store i32 %resSubImpl, i32* %blablabloe
    ;12 end statement: blablabloe = (blablabloe - 1);
    ;6 end statement: {
    br label %whileStart
    
endloop:
    ;6 end statement: while (weitermachen) {
    ;14 start statement : return 0;
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
