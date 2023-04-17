

define i32 @main() {
init:
    %yes = alloca i1
    %si = alloca i1
    %nie = alloca i1
    %ikke = alloca i1
    ;1 start statement : {
    ;2 start statement : boolean yes
    ;2 end statement: boolean yes
    ;3 start statement : boolean si
    ;3 end statement: boolean si
    ;4 start statement : boolean nie
    ;4 end statement: boolean nie
    ;5 start statement : boolean ikke
    ;5 end statement: boolean ikke
    ;6 start statement : yes = true;
    store i1 1, i1* %yes
    ;6 end statement: yes = true;
    ;7 start statement : si = true;
    store i1 1, i1* %si
    ;7 end statement: si = true;
    ;8 start statement : nie = false;
    store i1 0, i1* %nie
    ;8 end statement: nie = false;
    ;9 start statement : ikke = false;
    store i1 0, i1* %ikke
    ;9 end statement: ikke = false;
    ;10 start statement : if ((yes && si)) {
    %t = load i1, i1* %yes
    %andResVar = alloca i1
    store i1 %t, i1* %andResVar
    br i1 %t, label %and_first_true, label %and_end
    
and_first_true:
    %t1 = load i1, i1* %si
    store i1 %t1, i1* %andResVar
    br label %and_end
    
and_end:
    %andRes = load i1, i1* %andResVar
    br i1 %andRes, label %ifTrue, label %ifFalse
    
ifTrue:
    ;10 start statement : {
    ;11 start statement : printInt(1);
    call void @print(i32 1)
    ;11 end statement: printInt(1);
    ;10 end statement: {
    br label %endif
    
ifFalse:
    ;10 start statement : {
    ;13 start statement : printInt(666);
    call void @print(i32 666)
    ;13 end statement: printInt(666);
    ;10 end statement: {
    br label %endif
    
endif:
    ;10 end statement: if ((yes && si)) {
    ;15 start statement : if ((yes && nie)) {
    %t2 = load i1, i1* %yes
    %andResVar1 = alloca i1
    store i1 %t2, i1* %andResVar1
    br i1 %t2, label %and_first_true1, label %and_end1
    
and_first_true1:
    %t3 = load i1, i1* %nie
    store i1 %t3, i1* %andResVar1
    br label %and_end1
    
and_end1:
    %andRes1 = load i1, i1* %andResVar1
    br i1 %andRes1, label %ifTrue1, label %ifFalse1
    
ifTrue1:
    ;15 start statement : {
    ;16 start statement : printInt(667);
    call void @print(i32 667)
    ;16 end statement: printInt(667);
    ;15 end statement: {
    br label %endif1
    
ifFalse1:
    ;15 start statement : {
    ;18 start statement : printInt(2);
    call void @print(i32 2)
    ;18 end statement: printInt(2);
    ;15 end statement: {
    br label %endif1
    
endif1:
    ;15 end statement: if ((yes && nie)) {
    ;20 start statement : if ((nie && si)) {
    %t4 = load i1, i1* %nie
    %andResVar2 = alloca i1
    store i1 %t4, i1* %andResVar2
    br i1 %t4, label %and_first_true2, label %and_end2
    
and_first_true2:
    %t5 = load i1, i1* %si
    store i1 %t5, i1* %andResVar2
    br label %and_end2
    
and_end2:
    %andRes2 = load i1, i1* %andResVar2
    br i1 %andRes2, label %ifTrue2, label %ifFalse2
    
ifTrue2:
    ;20 start statement : {
    ;21 start statement : printInt(668);
    call void @print(i32 668)
    ;21 end statement: printInt(668);
    ;20 end statement: {
    br label %endif2
    
ifFalse2:
    ;20 start statement : {
    ;23 start statement : printInt(3);
    call void @print(i32 3)
    ;23 end statement: printInt(3);
    ;20 end statement: {
    br label %endif2
    
endif2:
    ;20 end statement: if ((nie && si)) {
    ;25 start statement : if ((ikke && nie)) {
    %t6 = load i1, i1* %ikke
    %andResVar3 = alloca i1
    store i1 %t6, i1* %andResVar3
    br i1 %t6, label %and_first_true3, label %and_end3
    
and_first_true3:
    %t7 = load i1, i1* %nie
    store i1 %t7, i1* %andResVar3
    br label %and_end3
    
and_end3:
    %andRes3 = load i1, i1* %andResVar3
    br i1 %andRes3, label %ifTrue3, label %ifFalse3
    
ifTrue3:
    ;25 start statement : {
    ;26 start statement : printInt(669);
    call void @print(i32 669)
    ;26 end statement: printInt(669);
    ;25 end statement: {
    br label %endif3
    
ifFalse3:
    ;25 start statement : {
    ;28 start statement : printInt(4);
    call void @print(i32 4)
    ;28 end statement: printInt(4);
    ;25 end statement: {
    br label %endif3
    
endif3:
    ;25 end statement: if ((ikke && nie)) {
    ;31 start statement : if (((yes && si) && (si && yes))) {
    %t8 = load i1, i1* %yes
    %andResVar4 = alloca i1
    store i1 %t8, i1* %andResVar4
    br i1 %t8, label %and_first_true4, label %and_end4
    
and_first_true4:
    %t9 = load i1, i1* %si
    store i1 %t9, i1* %andResVar4
    br label %and_end4
    
and_end4:
    %andRes4 = load i1, i1* %andResVar4
    %andResVar5 = alloca i1
    store i1 %andRes4, i1* %andResVar5
    br i1 %andRes4, label %and_first_true5, label %and_end6
    
and_first_true5:
    %t10 = load i1, i1* %si
    %andResVar6 = alloca i1
    store i1 %t10, i1* %andResVar6
    br i1 %t10, label %and_first_true6, label %and_end5
    
and_first_true6:
    %t11 = load i1, i1* %yes
    store i1 %t11, i1* %andResVar6
    br label %and_end5
    
and_end5:
    %andRes5 = load i1, i1* %andResVar6
    store i1 %andRes5, i1* %andResVar5
    br label %and_end6
    
and_end6:
    %andRes6 = load i1, i1* %andResVar5
    br i1 %andRes6, label %ifTrue4, label %ifFalse4
    
ifTrue4:
    ;31 start statement : {
    ;32 start statement : printInt(5);
    call void @print(i32 5)
    ;32 end statement: printInt(5);
    ;31 end statement: {
    br label %endif4
    
ifFalse4:
    ;31 start statement : {
    ;34 start statement : printInt(670);
    call void @print(i32 670)
    ;34 end statement: printInt(670);
    ;31 end statement: {
    br label %endif4
    
endif4:
    ;31 end statement: if (((yes && si) && (si && yes))) {
    ;36 start statement : if (((yes && nie) && (si && yes))) {
    %t12 = load i1, i1* %yes
    %andResVar7 = alloca i1
    store i1 %t12, i1* %andResVar7
    br i1 %t12, label %and_first_true7, label %and_end7
    
and_first_true7:
    %t13 = load i1, i1* %nie
    store i1 %t13, i1* %andResVar7
    br label %and_end7
    
and_end7:
    %andRes7 = load i1, i1* %andResVar7
    %andResVar8 = alloca i1
    store i1 %andRes7, i1* %andResVar8
    br i1 %andRes7, label %and_first_true8, label %and_end9
    
and_first_true8:
    %t14 = load i1, i1* %si
    %andResVar9 = alloca i1
    store i1 %t14, i1* %andResVar9
    br i1 %t14, label %and_first_true9, label %and_end8
    
and_first_true9:
    %t15 = load i1, i1* %yes
    store i1 %t15, i1* %andResVar9
    br label %and_end8
    
and_end8:
    %andRes8 = load i1, i1* %andResVar9
    store i1 %andRes8, i1* %andResVar8
    br label %and_end9
    
and_end9:
    %andRes9 = load i1, i1* %andResVar8
    br i1 %andRes9, label %ifTrue5, label %ifFalse5
    
ifTrue5:
    ;36 start statement : {
    ;37 start statement : printInt(671);
    call void @print(i32 671)
    ;37 end statement: printInt(671);
    ;36 end statement: {
    br label %endif5
    
ifFalse5:
    ;36 start statement : {
    ;39 start statement : printInt(6);
    call void @print(i32 6)
    ;39 end statement: printInt(6);
    ;36 end statement: {
    br label %endif5
    
endif5:
    ;36 end statement: if (((yes && nie) && (si && yes))) {
    ;41 start statement : if (((yes && si) && (nie && yes))) {
    %t16 = load i1, i1* %yes
    %andResVar10 = alloca i1
    store i1 %t16, i1* %andResVar10
    br i1 %t16, label %and_first_true10, label %and_end10
    
and_first_true10:
    %t17 = load i1, i1* %si
    store i1 %t17, i1* %andResVar10
    br label %and_end10
    
and_end10:
    %andRes10 = load i1, i1* %andResVar10
    %andResVar11 = alloca i1
    store i1 %andRes10, i1* %andResVar11
    br i1 %andRes10, label %and_first_true11, label %and_end12
    
and_first_true11:
    %t18 = load i1, i1* %nie
    %andResVar12 = alloca i1
    store i1 %t18, i1* %andResVar12
    br i1 %t18, label %and_first_true12, label %and_end11
    
and_first_true12:
    %t19 = load i1, i1* %yes
    store i1 %t19, i1* %andResVar12
    br label %and_end11
    
and_end11:
    %andRes11 = load i1, i1* %andResVar12
    store i1 %andRes11, i1* %andResVar11
    br label %and_end12
    
and_end12:
    %andRes12 = load i1, i1* %andResVar11
    br i1 %andRes12, label %ifTrue6, label %ifFalse6
    
ifTrue6:
    ;41 start statement : {
    ;42 start statement : printInt(672);
    call void @print(i32 672)
    ;42 end statement: printInt(672);
    ;41 end statement: {
    br label %endif6
    
ifFalse6:
    ;41 start statement : {
    ;44 start statement : printInt(7);
    call void @print(i32 7)
    ;44 end statement: printInt(7);
    ;41 end statement: {
    br label %endif6
    
endif6:
    ;41 end statement: if (((yes && si) && (nie && yes))) {
    ;46 start statement : if (((yes && si) && (yes && nie))) {
    %t20 = load i1, i1* %yes
    %andResVar13 = alloca i1
    store i1 %t20, i1* %andResVar13
    br i1 %t20, label %and_first_true13, label %and_end13
    
and_first_true13:
    %t21 = load i1, i1* %si
    store i1 %t21, i1* %andResVar13
    br label %and_end13
    
and_end13:
    %andRes13 = load i1, i1* %andResVar13
    %andResVar14 = alloca i1
    store i1 %andRes13, i1* %andResVar14
    br i1 %andRes13, label %and_first_true14, label %and_end15
    
and_first_true14:
    %t22 = load i1, i1* %yes
    %andResVar15 = alloca i1
    store i1 %t22, i1* %andResVar15
    br i1 %t22, label %and_first_true15, label %and_end14
    
and_first_true15:
    %t23 = load i1, i1* %nie
    store i1 %t23, i1* %andResVar15
    br label %and_end14
    
and_end14:
    %andRes14 = load i1, i1* %andResVar15
    store i1 %andRes14, i1* %andResVar14
    br label %and_end15
    
and_end15:
    %andRes15 = load i1, i1* %andResVar14
    br i1 %andRes15, label %ifTrue7, label %ifFalse7
    
ifTrue7:
    ;46 start statement : {
    ;47 start statement : printInt(673);
    call void @print(i32 673)
    ;47 end statement: printInt(673);
    ;46 end statement: {
    br label %endif7
    
ifFalse7:
    ;46 start statement : {
    ;49 start statement : printInt(8);
    call void @print(i32 8)
    ;49 end statement: printInt(8);
    ;46 end statement: {
    br label %endif7
    
endif7:
    ;46 end statement: if (((yes && si) && (yes && nie))) {
    ;51 start statement : return 0;
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
