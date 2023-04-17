

define i32 @main() {
init:
    %blablabloe = alloca i32
    %vier = alloca i32
    %neun = alloca i32
    ;1 start statement : {
    ;2 start statement : int blablabloe
    ;2 end statement: int blablabloe
    ;3 start statement : int vier
    ;3 end statement: int vier
    ;4 start statement : int neun
    ;4 end statement: int neun
    ;5 start statement : vier = 4;
    store i32 4, i32* %vier
    ;5 end statement: vier = 4;
    ;6 start statement : neun = 9;
    store i32 9, i32* %neun
    ;6 end statement: neun = 9;
    ;7 start statement : if (((vier + 10) < neun)) {
    %t = load i32, i32* %vier
    %resAddImpl = add i32 %t, 10
    %t1 = load i32, i32* %neun
    %resSltImpl = icmp slt i32 %resAddImpl, %t1
    br i1 %resSltImpl, label %ifTrue, label %ifFalse
    
ifTrue:
    ;7 start statement : {
    ;8 start statement : blablabloe = 44;
    store i32 44, i32* %blablabloe
    ;8 end statement: blablabloe = 44;
    ;7 end statement: {
    br label %endif
    
ifFalse:
    ;7 start statement : {
    ;10 start statement : blablabloe = 77;
    store i32 77, i32* %blablabloe
    ;10 end statement: blablabloe = 77;
    ;7 end statement: {
    br label %endif
    
endif:
    ;7 end statement: if (((vier + 10) < neun)) {
    ;12 start statement : printInt(blablabloe);
    %t2 = load i32, i32* %blablabloe
    call void @print(i32 %t2)
    ;12 end statement: printInt(blablabloe);
    ;13 start statement : return 0;
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
