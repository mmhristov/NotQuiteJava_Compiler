

define i32 @main() {
init:
    %b = alloca i1
    ;1 start statement : {
    ;2 start statement : boolean b
    ;2 end statement: boolean b
    ;3 start statement : b = (false && false);
    %andResVar = alloca i1
    store i1 0, i1* %andResVar
    br i1 0, label %and_first_true, label %and_end
    
and_first_true:
    store i1 0, i1* %andResVar
    br label %and_end
    
and_end:
    %andRes = load i1, i1* %andResVar
    store i1 %andRes, i1* %b
    ;3 end statement: b = (false && false);
    ;4 start statement : b = (false && true);
    %andResVar1 = alloca i1
    store i1 0, i1* %andResVar1
    br i1 0, label %and_first_true1, label %and_end1
    
and_first_true1:
    store i1 1, i1* %andResVar1
    br label %and_end1
    
and_end1:
    %andRes1 = load i1, i1* %andResVar1
    store i1 %andRes1, i1* %b
    ;4 end statement: b = (false && true);
    ;5 start statement : b = (true && false);
    %andResVar2 = alloca i1
    store i1 1, i1* %andResVar2
    br i1 1, label %and_first_true2, label %and_end2
    
and_first_true2:
    store i1 0, i1* %andResVar2
    br label %and_end2
    
and_end2:
    %andRes2 = load i1, i1* %andResVar2
    store i1 %andRes2, i1* %b
    ;5 end statement: b = (true && false);
    ;6 start statement : b = (true && true);
    %andResVar3 = alloca i1
    store i1 1, i1* %andResVar3
    br i1 1, label %and_first_true3, label %and_end3
    
and_first_true3:
    store i1 1, i1* %andResVar3
    br label %and_end3
    
and_end3:
    %andRes3 = load i1, i1* %andResVar3
    store i1 %andRes3, i1* %b
    ;6 end statement: b = (true && true);
    ;7 start statement : b = (! true);
    %neg_res = icmp eq i1 0, 1
    store i1 %neg_res, i1* %b
    ;7 end statement: b = (! true);
    ;8 start statement : b = (! false);
    %neg_res1 = icmp eq i1 0, 0
    store i1 %neg_res1, i1* %b
    ;8 end statement: b = (! false);
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
