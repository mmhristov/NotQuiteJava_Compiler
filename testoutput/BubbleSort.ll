@.print_message_1 = private unnamed_addr constant [64 x i8] c"Nullpointer exception in line frontend.SourcePosition@340b9973\0A\00", align 1
@.print_message_2 = private unnamed_addr constant [64 x i8] c"Nullpointer exception in line frontend.SourcePosition@1d730606\0A\00", align 1
@.print_message_3 = private unnamed_addr constant [63 x i8] c"Nullpointer exception in line frontend.SourcePosition@fade1fc\0A\00", align 1
@.print_message_4 = private unnamed_addr constant [64 x i8] c"Nullpointer exception in line frontend.SourcePosition@39a8312f\0A\00", align 1
@.print_message_5 = private unnamed_addr constant [34 x i8] c"Nullpointer exception in line 44\0A\00", align 1
@.print_message_6 = private unnamed_addr constant [38 x i8] c"Index out of bounds error in line 44\0A\00", align 1
@.print_message_7 = private unnamed_addr constant [34 x i8] c"Nullpointer exception in line 45\0A\00", align 1
@.print_message_8 = private unnamed_addr constant [38 x i8] c"Index out of bounds error in line 45\0A\00", align 1
@.print_message_9 = private unnamed_addr constant [34 x i8] c"Nullpointer exception in line 48\0A\00", align 1
@.print_message_10 = private unnamed_addr constant [38 x i8] c"Index out of bounds error in line 48\0A\00", align 1
@.print_message_11 = private unnamed_addr constant [34 x i8] c"Nullpointer exception in line 49\0A\00", align 1
@.print_message_12 = private unnamed_addr constant [38 x i8] c"Index out of bounds error in line 49\0A\00", align 1
@.print_message_13 = private unnamed_addr constant [34 x i8] c"Nullpointer exception in line 50\0A\00", align 1
@.print_message_14 = private unnamed_addr constant [38 x i8] c"Index out of bounds error in line 50\0A\00", align 1
@.print_message_15 = private unnamed_addr constant [34 x i8] c"Nullpointer exception in line 65\0A\00", align 1
@.print_message_16 = private unnamed_addr constant [38 x i8] c"Index out of bounds error in line 65\0A\00", align 1
@.print_message_17 = private unnamed_addr constant [34 x i8] c"Nullpointer exception in line 76\0A\00", align 1
@.print_message_18 = private unnamed_addr constant [38 x i8] c"Index out of bounds error in line 76\0A\00", align 1
@.print_message_19 = private unnamed_addr constant [34 x i8] c"Nullpointer exception in line 77\0A\00", align 1
@.print_message_20 = private unnamed_addr constant [38 x i8] c"Index out of bounds error in line 77\0A\00", align 1
@.print_message_21 = private unnamed_addr constant [34 x i8] c"Nullpointer exception in line 78\0A\00", align 1
@.print_message_22 = private unnamed_addr constant [38 x i8] c"Index out of bounds error in line 78\0A\00", align 1
@.print_message_23 = private unnamed_addr constant [34 x i8] c"Nullpointer exception in line 79\0A\00", align 1
@.print_message_24 = private unnamed_addr constant [38 x i8] c"Index out of bounds error in line 79\0A\00", align 1
@.print_message_25 = private unnamed_addr constant [34 x i8] c"Nullpointer exception in line 80\0A\00", align 1
@.print_message_26 = private unnamed_addr constant [38 x i8] c"Index out of bounds error in line 80\0A\00", align 1
@.print_message_27 = private unnamed_addr constant [34 x i8] c"Nullpointer exception in line 81\0A\00", align 1
@.print_message_28 = private unnamed_addr constant [38 x i8] c"Index out of bounds error in line 81\0A\00", align 1
@.print_message_29 = private unnamed_addr constant [34 x i8] c"Nullpointer exception in line 82\0A\00", align 1
@.print_message_30 = private unnamed_addr constant [38 x i8] c"Index out of bounds error in line 82\0A\00", align 1
@.print_message_31 = private unnamed_addr constant [34 x i8] c"Nullpointer exception in line 83\0A\00", align 1
@.print_message_32 = private unnamed_addr constant [38 x i8] c"Index out of bounds error in line 83\0A\00", align 1
@.print_message_33 = private unnamed_addr constant [34 x i8] c"Nullpointer exception in line 84\0A\00", align 1
@.print_message_34 = private unnamed_addr constant [38 x i8] c"Index out of bounds error in line 84\0A\00", align 1
@.print_message_35 = private unnamed_addr constant [34 x i8] c"Nullpointer exception in line 85\0A\00", align 1
@.print_message_36 = private unnamed_addr constant [38 x i8] c"Index out of bounds error in line 85\0A\00", align 1
@.print_message_37 = private unnamed_addr constant [63 x i8] c"Nullpointer exception in line frontend.SourcePosition@85e6769\0A\00", align 1
@.print_message_38 = private unnamed_addr constant [29 x i8] c"Array Size must be positive\0A\00", align 1


%class_BBS = type {
     %vTable_BBS*  ; vTable
    ,%array_i32*  ; number
    ,i32  ; size
}

%vTable_BBS = type {
     i32(%class_BBS*, i32)*  ; Start
    ,i32(%class_BBS*)*  ; Sort
    ,i32(%class_BBS*)*  ; Print
    ,i32(%class_BBS*, i32)*  ; Init
}

%array_i32 = type {
     i32  ; length
    ,[0 x i32]  ; data
}

@globalVTable_BBS = constant %vTable_BBS  {
    i32(%class_BBS*, i32)* @Start,
    i32(%class_BBS*)* @Sort,
    i32(%class_BBS*)* @Print,
    i32(%class_BBS*, i32)* @Init
}


define i32 @Start(%class_BBS* %this, i32 %sz) {
init:
    %sz1 = alloca i32
    store i32 %sz, i32* %sz1
    %aux01 = alloca i32
    ;16 start statement : {
    ;17 start statement : int aux01
    ;17 end statement: int aux01
    ;18 start statement : aux01 = this.Init(sz);
    %isNull = icmp eq %class_BBS* %this, null
    br i1 %isNull, label %whenIsNull, label %notNull
    
whenIsNull:
    ; ERROR: Nullpointer exception in line frontend.SourcePosition@340b9973
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([64 x i8], [64 x i8]* @.print_message_1, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
notNull:
    %ptrVTablePointer = getelementptr %class_BBS, %class_BBS* %this, i32 0, i32 0
    %ptrVTable = load %vTable_BBS*, %vTable_BBS** %ptrVTablePointer
    %ptrMethod = getelementptr %vTable_BBS, %vTable_BBS* %ptrVTable, i32 0, i32 3
    %method = load i32(%class_BBS*, i32)*, i32(%class_BBS*, i32)** %ptrMethod
    %t = load i32, i32* %sz1
    %Init_result = call i32 %method(%class_BBS* %this, i32 %t)
    store i32 %Init_result, i32* %aux01
    ;18 end statement: aux01 = this.Init(sz);
    ;19 start statement : aux01 = this.Print();
    %isNull1 = icmp eq %class_BBS* %this, null
    br i1 %isNull1, label %whenIsNull1, label %notNull1
    
whenIsNull1:
    ; ERROR: Nullpointer exception in line frontend.SourcePosition@1d730606
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([64 x i8], [64 x i8]* @.print_message_2, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
notNull1:
    %ptrVTablePointer1 = getelementptr %class_BBS, %class_BBS* %this, i32 0, i32 0
    %ptrVTable1 = load %vTable_BBS*, %vTable_BBS** %ptrVTablePointer1
    %ptrMethod1 = getelementptr %vTable_BBS, %vTable_BBS* %ptrVTable1, i32 0, i32 2
    %method1 = load i32(%class_BBS*)*, i32(%class_BBS*)** %ptrMethod1
    %Print_result = call i32 %method1(%class_BBS* %this)
    store i32 %Print_result, i32* %aux01
    ;19 end statement: aux01 = this.Print();
    ;20 start statement : printInt(99999);
    call void @print(i32 99999)
    ;20 end statement: printInt(99999);
    ;21 start statement : aux01 = this.Sort();
    %isNull2 = icmp eq %class_BBS* %this, null
    br i1 %isNull2, label %whenIsNull2, label %notNull2
    
whenIsNull2:
    ; ERROR: Nullpointer exception in line frontend.SourcePosition@fade1fc
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([63 x i8], [63 x i8]* @.print_message_3, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
notNull2:
    %ptrVTablePointer2 = getelementptr %class_BBS, %class_BBS* %this, i32 0, i32 0
    %ptrVTable2 = load %vTable_BBS*, %vTable_BBS** %ptrVTablePointer2
    %ptrMethod2 = getelementptr %vTable_BBS, %vTable_BBS* %ptrVTable2, i32 0, i32 1
    %method2 = load i32(%class_BBS*)*, i32(%class_BBS*)** %ptrMethod2
    %Sort_result = call i32 %method2(%class_BBS* %this)
    store i32 %Sort_result, i32* %aux01
    ;21 end statement: aux01 = this.Sort();
    ;22 start statement : aux01 = this.Print();
    %isNull3 = icmp eq %class_BBS* %this, null
    br i1 %isNull3, label %whenIsNull3, label %notNull3
    
whenIsNull3:
    ; ERROR: Nullpointer exception in line frontend.SourcePosition@39a8312f
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([64 x i8], [64 x i8]* @.print_message_4, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
notNull3:
    %ptrVTablePointer3 = getelementptr %class_BBS, %class_BBS* %this, i32 0, i32 0
    %ptrVTable3 = load %vTable_BBS*, %vTable_BBS** %ptrVTablePointer3
    %ptrMethod3 = getelementptr %vTable_BBS, %vTable_BBS* %ptrVTable3, i32 0, i32 2
    %method3 = load i32(%class_BBS*)*, i32(%class_BBS*)** %ptrMethod3
    %Print_result1 = call i32 %method3(%class_BBS* %this)
    store i32 %Print_result1, i32* %aux01
    ;22 end statement: aux01 = this.Print();
    ;23 start statement : return 0;
    ret i32 0
    

}

define i32 @Sort(%class_BBS* %this) {
init:
    %nt = alloca i32
    %i = alloca i32
    %aux02 = alloca i32
    %aux04 = alloca i32
    %aux05 = alloca i32
    %aux06 = alloca i32
    %aux07 = alloca i32
    %j = alloca i32
    %t = alloca i32
    ;27 start statement : {
    ;28 start statement : int nt
    ;28 end statement: int nt
    ;29 start statement : int i
    ;29 end statement: int i
    ;30 start statement : int aux02
    ;30 end statement: int aux02
    ;31 start statement : int aux04
    ;31 end statement: int aux04
    ;32 start statement : int aux05
    ;32 end statement: int aux05
    ;33 start statement : int aux06
    ;33 end statement: int aux06
    ;34 start statement : int aux07
    ;34 end statement: int aux07
    ;35 start statement : int j
    ;35 end statement: int j
    ;36 start statement : int t
    ;36 end statement: int t
    ;37 start statement : i = (size - 1);
    %ptrField = getelementptr %class_BBS, %class_BBS* %this, i32 0, i32 2
    %t1 = load i32, i32* %ptrField
    %resSubImpl = sub i32 %t1, 1
    store i32 %resSubImpl, i32* %i
    ;37 end statement: i = (size - 1);
    ;38 start statement : aux02 = (0 - 1);
    %resSubImpl1 = sub i32 0, 1
    store i32 %resSubImpl1, i32* %aux02
    ;38 end statement: aux02 = (0 - 1);
    ;39 start statement : while ((aux02 < i)) {
    br label %whileStart
    
whileStart:
    %t2 = load i32, i32* %aux02
    %t3 = load i32, i32* %i
    %resSltImpl = icmp slt i32 %t2, %t3
    br i1 %resSltImpl, label %loopBodyStart, label %endloop1
    
loopBodyStart:
    ;39 start statement : {
    ;40 start statement : j = 1;
    store i32 1, i32* %j
    ;40 end statement: j = 1;
    ;42 start statement : while ((j < (i + 1))) {
    br label %whileStart1
    
whileStart1:
    %t4 = load i32, i32* %j
    %t5 = load i32, i32* %i
    %resAddImpl = add i32 %t5, 1
    %resSltImpl1 = icmp slt i32 %t4, %resAddImpl
    br i1 %resSltImpl1, label %loopBodyStart1, label %endloop
    
loopBodyStart1:
    ;42 start statement : {
    ;43 start statement : aux07 = (j - 1);
    %t6 = load i32, i32* %j
    %resSubImpl2 = sub i32 %t6, 1
    store i32 %resSubImpl2, i32* %aux07
    ;43 end statement: aux07 = (j - 1);
    ;44 start statement : aux04 = number[aux07];
    %ptrField1 = getelementptr %class_BBS, %class_BBS* %this, i32 0, i32 1
    %t7 = load %array_i32*, %array_i32** %ptrField1
    %isNull = icmp eq %array_i32* %t7, null
    br i1 %isNull, label %whenIsNull, label %notNull
    
whenIsNull:
    ; ERROR: Nullpointer exception in line 44
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([34 x i8], [34 x i8]* @.print_message_5, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
notNull:
    %t8 = load i32, i32* %aux07
    %length_addr = getelementptr %array_i32, %array_i32* %t7, i32 0, i32 0
    %len = load i32, i32* %length_addr
    %smallerZero = icmp slt i32 %t8, 0
    %lenMinusOne = sub i32 %len, 1
    %greaterEqualLen = icmp slt i32 %lenMinusOne, %t8
    %outOfBounds = or i1 %smallerZero, %greaterEqualLen
    br i1 %outOfBounds, label %outOfBounds1, label %indexInRange
    
outOfBounds1:
    ; ERROR: Index out of bounds error in line 44
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([38 x i8], [38 x i8]* @.print_message_6, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
indexInRange:
    %indexAddr = getelementptr %array_i32, %array_i32* %t7, i32 0, i32 1, i32 %t8
    %t9 = load i32, i32* %indexAddr
    store i32 %t9, i32* %aux04
    ;44 end statement: aux04 = number[aux07];
    ;45 start statement : aux05 = number[j];
    %ptrField2 = getelementptr %class_BBS, %class_BBS* %this, i32 0, i32 1
    %t10 = load %array_i32*, %array_i32** %ptrField2
    %isNull1 = icmp eq %array_i32* %t10, null
    br i1 %isNull1, label %whenIsNull1, label %notNull1
    
whenIsNull1:
    ; ERROR: Nullpointer exception in line 45
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([34 x i8], [34 x i8]* @.print_message_7, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
notNull1:
    %t11 = load i32, i32* %j
    %length_addr1 = getelementptr %array_i32, %array_i32* %t10, i32 0, i32 0
    %len1 = load i32, i32* %length_addr1
    %smallerZero1 = icmp slt i32 %t11, 0
    %lenMinusOne1 = sub i32 %len1, 1
    %greaterEqualLen1 = icmp slt i32 %lenMinusOne1, %t11
    %outOfBounds2 = or i1 %smallerZero1, %greaterEqualLen1
    br i1 %outOfBounds2, label %outOfBounds3, label %indexInRange1
    
outOfBounds3:
    ; ERROR: Index out of bounds error in line 45
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([38 x i8], [38 x i8]* @.print_message_8, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
indexInRange1:
    %indexAddr1 = getelementptr %array_i32, %array_i32* %t10, i32 0, i32 1, i32 %t11
    %t12 = load i32, i32* %indexAddr1
    store i32 %t12, i32* %aux05
    ;45 end statement: aux05 = number[j];
    ;46 start statement : if ((aux05 < aux04)) {
    %t13 = load i32, i32* %aux05
    %t14 = load i32, i32* %aux04
    %resSltImpl2 = icmp slt i32 %t13, %t14
    br i1 %resSltImpl2, label %ifTrue, label %ifFalse
    
ifTrue:
    ;46 start statement : {
    ;47 start statement : aux06 = (j - 1);
    %t15 = load i32, i32* %j
    %resSubImpl3 = sub i32 %t15, 1
    store i32 %resSubImpl3, i32* %aux06
    ;47 end statement: aux06 = (j - 1);
    ;48 start statement : t = number[aux06];
    %ptrField3 = getelementptr %class_BBS, %class_BBS* %this, i32 0, i32 1
    %t16 = load %array_i32*, %array_i32** %ptrField3
    %isNull2 = icmp eq %array_i32* %t16, null
    br i1 %isNull2, label %whenIsNull2, label %notNull2
    
whenIsNull2:
    ; ERROR: Nullpointer exception in line 48
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([34 x i8], [34 x i8]* @.print_message_9, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
notNull2:
    %t17 = load i32, i32* %aux06
    %length_addr2 = getelementptr %array_i32, %array_i32* %t16, i32 0, i32 0
    %len2 = load i32, i32* %length_addr2
    %smallerZero2 = icmp slt i32 %t17, 0
    %lenMinusOne2 = sub i32 %len2, 1
    %greaterEqualLen2 = icmp slt i32 %lenMinusOne2, %t17
    %outOfBounds4 = or i1 %smallerZero2, %greaterEqualLen2
    br i1 %outOfBounds4, label %outOfBounds5, label %indexInRange2
    
outOfBounds5:
    ; ERROR: Index out of bounds error in line 48
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([38 x i8], [38 x i8]* @.print_message_10, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
indexInRange2:
    %indexAddr2 = getelementptr %array_i32, %array_i32* %t16, i32 0, i32 1, i32 %t17
    %t18 = load i32, i32* %indexAddr2
    store i32 %t18, i32* %t
    ;48 end statement: t = number[aux06];
    ;49 start statement : number[aux06] = number[j];
    %ptrField4 = getelementptr %class_BBS, %class_BBS* %this, i32 0, i32 1
    %t19 = load %array_i32*, %array_i32** %ptrField4
    %isNull3 = icmp eq %array_i32* %t19, null
    br i1 %isNull3, label %whenIsNull3, label %notNull3
    
whenIsNull3:
    ; ERROR: Nullpointer exception in line 49
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([34 x i8], [34 x i8]* @.print_message_11, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
notNull3:
    %t20 = load i32, i32* %aux06
    %length_addr3 = getelementptr %array_i32, %array_i32* %t19, i32 0, i32 0
    %len3 = load i32, i32* %length_addr3
    %smallerZero3 = icmp slt i32 %t20, 0
    %lenMinusOne3 = sub i32 %len3, 1
    %greaterEqualLen3 = icmp slt i32 %lenMinusOne3, %t20
    %outOfBounds6 = or i1 %smallerZero3, %greaterEqualLen3
    br i1 %outOfBounds6, label %outOfBounds7, label %indexInRange3
    
outOfBounds7:
    ; ERROR: Index out of bounds error in line 49
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([38 x i8], [38 x i8]* @.print_message_12, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
indexInRange3:
    %indexAddr3 = getelementptr %array_i32, %array_i32* %t19, i32 0, i32 1, i32 %t20
    %ptrField5 = getelementptr %class_BBS, %class_BBS* %this, i32 0, i32 1
    %t21 = load %array_i32*, %array_i32** %ptrField5
    %isNull4 = icmp eq %array_i32* %t21, null
    br i1 %isNull4, label %whenIsNull4, label %notNull4
    
whenIsNull4:
    ; ERROR: Nullpointer exception in line 49
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([34 x i8], [34 x i8]* @.print_message_11, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
notNull4:
    %t22 = load i32, i32* %j
    %length_addr4 = getelementptr %array_i32, %array_i32* %t21, i32 0, i32 0
    %len4 = load i32, i32* %length_addr4
    %smallerZero4 = icmp slt i32 %t22, 0
    %lenMinusOne4 = sub i32 %len4, 1
    %greaterEqualLen4 = icmp slt i32 %lenMinusOne4, %t22
    %outOfBounds8 = or i1 %smallerZero4, %greaterEqualLen4
    br i1 %outOfBounds8, label %outOfBounds9, label %indexInRange4
    
outOfBounds9:
    ; ERROR: Index out of bounds error in line 49
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([38 x i8], [38 x i8]* @.print_message_12, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
indexInRange4:
    %indexAddr4 = getelementptr %array_i32, %array_i32* %t21, i32 0, i32 1, i32 %t22
    %t23 = load i32, i32* %indexAddr4
    store i32 %t23, i32* %indexAddr3
    ;49 end statement: number[aux06] = number[j];
    ;50 start statement : number[j] = t;
    %ptrField6 = getelementptr %class_BBS, %class_BBS* %this, i32 0, i32 1
    %t24 = load %array_i32*, %array_i32** %ptrField6
    %isNull5 = icmp eq %array_i32* %t24, null
    br i1 %isNull5, label %whenIsNull5, label %notNull5
    
whenIsNull5:
    ; ERROR: Nullpointer exception in line 50
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([34 x i8], [34 x i8]* @.print_message_13, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
notNull5:
    %t25 = load i32, i32* %j
    %length_addr5 = getelementptr %array_i32, %array_i32* %t24, i32 0, i32 0
    %len5 = load i32, i32* %length_addr5
    %smallerZero5 = icmp slt i32 %t25, 0
    %lenMinusOne5 = sub i32 %len5, 1
    %greaterEqualLen5 = icmp slt i32 %lenMinusOne5, %t25
    %outOfBounds10 = or i1 %smallerZero5, %greaterEqualLen5
    br i1 %outOfBounds10, label %outOfBounds11, label %indexInRange5
    
outOfBounds11:
    ; ERROR: Index out of bounds error in line 50
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([38 x i8], [38 x i8]* @.print_message_14, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
indexInRange5:
    %indexAddr5 = getelementptr %array_i32, %array_i32* %t24, i32 0, i32 1, i32 %t25
    %t26 = load i32, i32* %t
    store i32 %t26, i32* %indexAddr5
    ;50 end statement: number[j] = t;
    ;46 end statement: {
    br label %endif
    
ifFalse:
    ;52 start statement : nt = 0;
    store i32 0, i32* %nt
    ;52 end statement: nt = 0;
    br label %endif
    
endif:
    ;46 end statement: if ((aux05 < aux04)) {
    ;53 start statement : j = (j + 1);
    %t27 = load i32, i32* %j
    %resAddImpl1 = add i32 %t27, 1
    store i32 %resAddImpl1, i32* %j
    ;53 end statement: j = (j + 1);
    ;42 end statement: {
    br label %whileStart1
    
endloop:
    ;42 end statement: while ((j < (i + 1))) {
    ;55 start statement : i = (i - 1);
    %t28 = load i32, i32* %i
    %resSubImpl4 = sub i32 %t28, 1
    store i32 %resSubImpl4, i32* %i
    ;55 end statement: i = (i - 1);
    ;39 end statement: {
    br label %whileStart
    
endloop1:
    ;39 end statement: while ((aux02 < i)) {
    ;57 start statement : return 0;
    ret i32 0
    

}

define i32 @Print(%class_BBS* %this) {
init:
    %j = alloca i32
    ;61 start statement : {
    ;62 start statement : int j
    ;62 end statement: int j
    ;63 start statement : j = 0;
    store i32 0, i32* %j
    ;63 end statement: j = 0;
    ;64 start statement : while ((j < size)) {
    br label %whileStart
    
whileStart:
    %t = load i32, i32* %j
    %ptrField = getelementptr %class_BBS, %class_BBS* %this, i32 0, i32 2
    %t1 = load i32, i32* %ptrField
    %resSltImpl = icmp slt i32 %t, %t1
    br i1 %resSltImpl, label %loopBodyStart, label %endloop
    
loopBodyStart:
    ;64 start statement : {
    ;65 start statement : printInt(number[j]);
    %ptrField1 = getelementptr %class_BBS, %class_BBS* %this, i32 0, i32 1
    %t2 = load %array_i32*, %array_i32** %ptrField1
    %isNull = icmp eq %array_i32* %t2, null
    br i1 %isNull, label %whenIsNull, label %notNull
    
whenIsNull:
    ; ERROR: Nullpointer exception in line 65
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([34 x i8], [34 x i8]* @.print_message_15, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
notNull:
    %t3 = load i32, i32* %j
    %length_addr = getelementptr %array_i32, %array_i32* %t2, i32 0, i32 0
    %len = load i32, i32* %length_addr
    %smallerZero = icmp slt i32 %t3, 0
    %lenMinusOne = sub i32 %len, 1
    %greaterEqualLen = icmp slt i32 %lenMinusOne, %t3
    %outOfBounds = or i1 %smallerZero, %greaterEqualLen
    br i1 %outOfBounds, label %outOfBounds1, label %indexInRange
    
outOfBounds1:
    ; ERROR: Index out of bounds error in line 65
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([38 x i8], [38 x i8]* @.print_message_16, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
indexInRange:
    %indexAddr = getelementptr %array_i32, %array_i32* %t2, i32 0, i32 1, i32 %t3
    %t4 = load i32, i32* %indexAddr
    call void @print(i32 %t4)
    ;65 end statement: printInt(number[j]);
    ;66 start statement : j = (j + 1);
    %t5 = load i32, i32* %j
    %resAddImpl = add i32 %t5, 1
    store i32 %resAddImpl, i32* %j
    ;66 end statement: j = (j + 1);
    ;64 end statement: {
    br label %whileStart
    
endloop:
    ;64 end statement: while ((j < size)) {
    ;68 start statement : return 0;
    ret i32 0
    

}

define i32 @Init(%class_BBS* %this, i32 %sz) {
init:
    %sz1 = alloca i32
    store i32 %sz, i32* %sz1
    ;72 start statement : {
    ;73 start statement : size = sz;
    %ptrField = getelementptr %class_BBS, %class_BBS* %this, i32 0, i32 2
    %t = load i32, i32* %sz1
    store i32 %t, i32* %ptrField
    ;73 end statement: size = sz;
    ;74 start statement : number = (new int[sz]);
    %ptrField1 = getelementptr %class_BBS, %class_BBS* %this, i32 0, i32 1
    %t1 = load i32, i32* %sz1
    %newArray1 = call %array_i32* @newArray(i32 %t1)
    store %array_i32* %newArray1, %array_i32** %ptrField1
    ;74 end statement: number = (new int[sz]);
    ;76 start statement : number[0] = 20;
    %ptrField2 = getelementptr %class_BBS, %class_BBS* %this, i32 0, i32 1
    %t2 = load %array_i32*, %array_i32** %ptrField2
    %isNull = icmp eq %array_i32* %t2, null
    br i1 %isNull, label %whenIsNull, label %notNull
    
whenIsNull:
    ; ERROR: Nullpointer exception in line 76
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([34 x i8], [34 x i8]* @.print_message_17, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
notNull:
    %length_addr = getelementptr %array_i32, %array_i32* %t2, i32 0, i32 0
    %len = load i32, i32* %length_addr
    %smallerZero = icmp slt i32 0, 0
    %lenMinusOne = sub i32 %len, 1
    %greaterEqualLen = icmp slt i32 %lenMinusOne, 0
    %outOfBounds = or i1 %smallerZero, %greaterEqualLen
    br i1 %outOfBounds, label %outOfBounds1, label %indexInRange
    
outOfBounds1:
    ; ERROR: Index out of bounds error in line 76
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([38 x i8], [38 x i8]* @.print_message_18, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
indexInRange:
    %indexAddr = getelementptr %array_i32, %array_i32* %t2, i32 0, i32 1, i32 0
    store i32 20, i32* %indexAddr
    ;76 end statement: number[0] = 20;
    ;77 start statement : number[1] = 7;
    %ptrField3 = getelementptr %class_BBS, %class_BBS* %this, i32 0, i32 1
    %t3 = load %array_i32*, %array_i32** %ptrField3
    %isNull1 = icmp eq %array_i32* %t3, null
    br i1 %isNull1, label %whenIsNull1, label %notNull1
    
whenIsNull1:
    ; ERROR: Nullpointer exception in line 77
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([34 x i8], [34 x i8]* @.print_message_19, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
notNull1:
    %length_addr1 = getelementptr %array_i32, %array_i32* %t3, i32 0, i32 0
    %len1 = load i32, i32* %length_addr1
    %smallerZero1 = icmp slt i32 1, 0
    %lenMinusOne1 = sub i32 %len1, 1
    %greaterEqualLen1 = icmp slt i32 %lenMinusOne1, 1
    %outOfBounds2 = or i1 %smallerZero1, %greaterEqualLen1
    br i1 %outOfBounds2, label %outOfBounds3, label %indexInRange1
    
outOfBounds3:
    ; ERROR: Index out of bounds error in line 77
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([38 x i8], [38 x i8]* @.print_message_20, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
indexInRange1:
    %indexAddr1 = getelementptr %array_i32, %array_i32* %t3, i32 0, i32 1, i32 1
    store i32 7, i32* %indexAddr1
    ;77 end statement: number[1] = 7;
    ;78 start statement : number[2] = 12;
    %ptrField4 = getelementptr %class_BBS, %class_BBS* %this, i32 0, i32 1
    %t4 = load %array_i32*, %array_i32** %ptrField4
    %isNull2 = icmp eq %array_i32* %t4, null
    br i1 %isNull2, label %whenIsNull2, label %notNull2
    
whenIsNull2:
    ; ERROR: Nullpointer exception in line 78
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([34 x i8], [34 x i8]* @.print_message_21, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
notNull2:
    %length_addr2 = getelementptr %array_i32, %array_i32* %t4, i32 0, i32 0
    %len2 = load i32, i32* %length_addr2
    %smallerZero2 = icmp slt i32 2, 0
    %lenMinusOne2 = sub i32 %len2, 1
    %greaterEqualLen2 = icmp slt i32 %lenMinusOne2, 2
    %outOfBounds4 = or i1 %smallerZero2, %greaterEqualLen2
    br i1 %outOfBounds4, label %outOfBounds5, label %indexInRange2
    
outOfBounds5:
    ; ERROR: Index out of bounds error in line 78
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([38 x i8], [38 x i8]* @.print_message_22, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
indexInRange2:
    %indexAddr2 = getelementptr %array_i32, %array_i32* %t4, i32 0, i32 1, i32 2
    store i32 12, i32* %indexAddr2
    ;78 end statement: number[2] = 12;
    ;79 start statement : number[3] = 18;
    %ptrField5 = getelementptr %class_BBS, %class_BBS* %this, i32 0, i32 1
    %t5 = load %array_i32*, %array_i32** %ptrField5
    %isNull3 = icmp eq %array_i32* %t5, null
    br i1 %isNull3, label %whenIsNull3, label %notNull3
    
whenIsNull3:
    ; ERROR: Nullpointer exception in line 79
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([34 x i8], [34 x i8]* @.print_message_23, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
notNull3:
    %length_addr3 = getelementptr %array_i32, %array_i32* %t5, i32 0, i32 0
    %len3 = load i32, i32* %length_addr3
    %smallerZero3 = icmp slt i32 3, 0
    %lenMinusOne3 = sub i32 %len3, 1
    %greaterEqualLen3 = icmp slt i32 %lenMinusOne3, 3
    %outOfBounds6 = or i1 %smallerZero3, %greaterEqualLen3
    br i1 %outOfBounds6, label %outOfBounds7, label %indexInRange3
    
outOfBounds7:
    ; ERROR: Index out of bounds error in line 79
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([38 x i8], [38 x i8]* @.print_message_24, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
indexInRange3:
    %indexAddr3 = getelementptr %array_i32, %array_i32* %t5, i32 0, i32 1, i32 3
    store i32 18, i32* %indexAddr3
    ;79 end statement: number[3] = 18;
    ;80 start statement : number[4] = 2;
    %ptrField6 = getelementptr %class_BBS, %class_BBS* %this, i32 0, i32 1
    %t6 = load %array_i32*, %array_i32** %ptrField6
    %isNull4 = icmp eq %array_i32* %t6, null
    br i1 %isNull4, label %whenIsNull4, label %notNull4
    
whenIsNull4:
    ; ERROR: Nullpointer exception in line 80
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([34 x i8], [34 x i8]* @.print_message_25, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
notNull4:
    %length_addr4 = getelementptr %array_i32, %array_i32* %t6, i32 0, i32 0
    %len4 = load i32, i32* %length_addr4
    %smallerZero4 = icmp slt i32 4, 0
    %lenMinusOne4 = sub i32 %len4, 1
    %greaterEqualLen4 = icmp slt i32 %lenMinusOne4, 4
    %outOfBounds8 = or i1 %smallerZero4, %greaterEqualLen4
    br i1 %outOfBounds8, label %outOfBounds9, label %indexInRange4
    
outOfBounds9:
    ; ERROR: Index out of bounds error in line 80
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([38 x i8], [38 x i8]* @.print_message_26, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
indexInRange4:
    %indexAddr4 = getelementptr %array_i32, %array_i32* %t6, i32 0, i32 1, i32 4
    store i32 2, i32* %indexAddr4
    ;80 end statement: number[4] = 2;
    ;81 start statement : number[5] = 11;
    %ptrField7 = getelementptr %class_BBS, %class_BBS* %this, i32 0, i32 1
    %t7 = load %array_i32*, %array_i32** %ptrField7
    %isNull5 = icmp eq %array_i32* %t7, null
    br i1 %isNull5, label %whenIsNull5, label %notNull5
    
whenIsNull5:
    ; ERROR: Nullpointer exception in line 81
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([34 x i8], [34 x i8]* @.print_message_27, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
notNull5:
    %length_addr5 = getelementptr %array_i32, %array_i32* %t7, i32 0, i32 0
    %len5 = load i32, i32* %length_addr5
    %smallerZero5 = icmp slt i32 5, 0
    %lenMinusOne5 = sub i32 %len5, 1
    %greaterEqualLen5 = icmp slt i32 %lenMinusOne5, 5
    %outOfBounds10 = or i1 %smallerZero5, %greaterEqualLen5
    br i1 %outOfBounds10, label %outOfBounds11, label %indexInRange5
    
outOfBounds11:
    ; ERROR: Index out of bounds error in line 81
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([38 x i8], [38 x i8]* @.print_message_28, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
indexInRange5:
    %indexAddr5 = getelementptr %array_i32, %array_i32* %t7, i32 0, i32 1, i32 5
    store i32 11, i32* %indexAddr5
    ;81 end statement: number[5] = 11;
    ;82 start statement : number[6] = 6;
    %ptrField8 = getelementptr %class_BBS, %class_BBS* %this, i32 0, i32 1
    %t8 = load %array_i32*, %array_i32** %ptrField8
    %isNull6 = icmp eq %array_i32* %t8, null
    br i1 %isNull6, label %whenIsNull6, label %notNull6
    
whenIsNull6:
    ; ERROR: Nullpointer exception in line 82
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([34 x i8], [34 x i8]* @.print_message_29, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
notNull6:
    %length_addr6 = getelementptr %array_i32, %array_i32* %t8, i32 0, i32 0
    %len6 = load i32, i32* %length_addr6
    %smallerZero6 = icmp slt i32 6, 0
    %lenMinusOne6 = sub i32 %len6, 1
    %greaterEqualLen6 = icmp slt i32 %lenMinusOne6, 6
    %outOfBounds12 = or i1 %smallerZero6, %greaterEqualLen6
    br i1 %outOfBounds12, label %outOfBounds13, label %indexInRange6
    
outOfBounds13:
    ; ERROR: Index out of bounds error in line 82
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([38 x i8], [38 x i8]* @.print_message_30, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
indexInRange6:
    %indexAddr6 = getelementptr %array_i32, %array_i32* %t8, i32 0, i32 1, i32 6
    store i32 6, i32* %indexAddr6
    ;82 end statement: number[6] = 6;
    ;83 start statement : number[7] = 9;
    %ptrField9 = getelementptr %class_BBS, %class_BBS* %this, i32 0, i32 1
    %t9 = load %array_i32*, %array_i32** %ptrField9
    %isNull7 = icmp eq %array_i32* %t9, null
    br i1 %isNull7, label %whenIsNull7, label %notNull7
    
whenIsNull7:
    ; ERROR: Nullpointer exception in line 83
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([34 x i8], [34 x i8]* @.print_message_31, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
notNull7:
    %length_addr7 = getelementptr %array_i32, %array_i32* %t9, i32 0, i32 0
    %len7 = load i32, i32* %length_addr7
    %smallerZero7 = icmp slt i32 7, 0
    %lenMinusOne7 = sub i32 %len7, 1
    %greaterEqualLen7 = icmp slt i32 %lenMinusOne7, 7
    %outOfBounds14 = or i1 %smallerZero7, %greaterEqualLen7
    br i1 %outOfBounds14, label %outOfBounds15, label %indexInRange7
    
outOfBounds15:
    ; ERROR: Index out of bounds error in line 83
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([38 x i8], [38 x i8]* @.print_message_32, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
indexInRange7:
    %indexAddr7 = getelementptr %array_i32, %array_i32* %t9, i32 0, i32 1, i32 7
    store i32 9, i32* %indexAddr7
    ;83 end statement: number[7] = 9;
    ;84 start statement : number[8] = 19;
    %ptrField10 = getelementptr %class_BBS, %class_BBS* %this, i32 0, i32 1
    %t10 = load %array_i32*, %array_i32** %ptrField10
    %isNull8 = icmp eq %array_i32* %t10, null
    br i1 %isNull8, label %whenIsNull8, label %notNull8
    
whenIsNull8:
    ; ERROR: Nullpointer exception in line 84
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([34 x i8], [34 x i8]* @.print_message_33, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
notNull8:
    %length_addr8 = getelementptr %array_i32, %array_i32* %t10, i32 0, i32 0
    %len8 = load i32, i32* %length_addr8
    %smallerZero8 = icmp slt i32 8, 0
    %lenMinusOne8 = sub i32 %len8, 1
    %greaterEqualLen8 = icmp slt i32 %lenMinusOne8, 8
    %outOfBounds16 = or i1 %smallerZero8, %greaterEqualLen8
    br i1 %outOfBounds16, label %outOfBounds17, label %indexInRange8
    
outOfBounds17:
    ; ERROR: Index out of bounds error in line 84
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([38 x i8], [38 x i8]* @.print_message_34, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
indexInRange8:
    %indexAddr8 = getelementptr %array_i32, %array_i32* %t10, i32 0, i32 1, i32 8
    store i32 19, i32* %indexAddr8
    ;84 end statement: number[8] = 19;
    ;85 start statement : number[9] = 5;
    %ptrField11 = getelementptr %class_BBS, %class_BBS* %this, i32 0, i32 1
    %t11 = load %array_i32*, %array_i32** %ptrField11
    %isNull9 = icmp eq %array_i32* %t11, null
    br i1 %isNull9, label %whenIsNull9, label %notNull9
    
whenIsNull9:
    ; ERROR: Nullpointer exception in line 85
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([34 x i8], [34 x i8]* @.print_message_35, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
notNull9:
    %length_addr9 = getelementptr %array_i32, %array_i32* %t11, i32 0, i32 0
    %len9 = load i32, i32* %length_addr9
    %smallerZero9 = icmp slt i32 9, 0
    %lenMinusOne9 = sub i32 %len9, 1
    %greaterEqualLen9 = icmp slt i32 %lenMinusOne9, 9
    %outOfBounds18 = or i1 %smallerZero9, %greaterEqualLen9
    br i1 %outOfBounds18, label %outOfBounds19, label %indexInRange9
    
outOfBounds19:
    ; ERROR: Index out of bounds error in line 85
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([38 x i8], [38 x i8]* @.print_message_36, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
indexInRange9:
    %indexAddr9 = getelementptr %array_i32, %array_i32* %t11, i32 0, i32 1, i32 9
    store i32 5, i32* %indexAddr9
    ;85 end statement: number[9] = 5;
    ;87 start statement : return 0;
    ret i32 0
    

}

define i32 @main() {
init:
    ;1 start statement : {
    ;2 start statement : printInt(new BBS().Start(10));
    %newObject = call %class_BBS* @constructor_BBS()
    %isNull = icmp eq %class_BBS* %newObject, null
    br i1 %isNull, label %whenIsNull, label %notNull
    
whenIsNull:
    ; ERROR: Nullpointer exception in line frontend.SourcePosition@85e6769
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([63 x i8], [63 x i8]* @.print_message_37, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
notNull:
    %ptrVTablePointer = getelementptr %class_BBS, %class_BBS* %newObject, i32 0, i32 0
    %ptrVTable = load %vTable_BBS*, %vTable_BBS** %ptrVTablePointer
    %ptrMethod = getelementptr %vTable_BBS, %vTable_BBS* %ptrVTable, i32 0, i32 0
    %method = load i32(%class_BBS*, i32)*, i32(%class_BBS*, i32)** %ptrMethod
    %Start_result = call i32 %method(%class_BBS* %newObject, i32 10)
    call void @print(i32 %Start_result)
    ;2 end statement: printInt(new BBS().Start(10));
    ;3 start statement : return 0;
    ret i32 0
    

}

define %class_BBS* @constructor_BBS() {
constructorBlock:
    %mallocVar = call i8* @malloc(i32 ptrtoint (%class_BBS* getelementptr (%class_BBS, %class_BBS* null, i32 1) to i32))
    %newClass = bitcast i8* %mallocVar to %class_BBS*
    %sizeVar = getelementptr %class_BBS, %class_BBS* %newClass, i32 0, i32 0
    store %vTable_BBS* @globalVTable_BBS, %vTable_BBS** %sizeVar
    %fieldTempVar_number = getelementptr %class_BBS, %class_BBS* %newClass, i32 0, i32 1
    store %array_i32* null, %array_i32** %fieldTempVar_number
    %fieldTempVar_size = getelementptr %class_BBS, %class_BBS* %newClass, i32 0, i32 2
    store i32 0, i32* %fieldTempVar_size
    ret %class_BBS* %newClass
    

}

define %array_i32* @newArray(i32 %size) {
init:
    %sizeLessThanZero = icmp slt i32 %size, 0
    br i1 %sizeLessThanZero, label %negativeSize, label %goodSize
    
negativeSize:
    ; ERROR: Array Size must be positive
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([29 x i8], [29 x i8]* @.print_message_38, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
goodSize:
    %arraySizeInBytes = mul i32 %size, 4
    %arraySizeWitLen = add i32 %arraySizeInBytes, 4
    %mallocRes = call i8* @malloc(i32 %arraySizeWitLen)
    %newArray1 = bitcast i8* %mallocRes to %array_i32*
    %sizeAddr = getelementptr %array_i32, %array_i32* %newArray1, i32 0, i32 0
    store i32 %size, i32* %sizeAddr
    %iVar = alloca i32
    store i32 0, i32* %iVar
    br label %loopStart
    
loopStart:
    %i = load i32, i32* %iVar
    %smallerSize = icmp slt i32 %i, %size
    br i1 %smallerSize, label %loopBody, label %loopEnd
    
loopBody:
    %iAddr = getelementptr %array_i32, %array_i32* %newArray1, i32 0, i32 1, i32 %i
    store i32 0, i32* %iAddr
    %nextI = add i32 %i, 1
    store i32 %nextI, i32* %iVar
    br label %loopStart
    
loopEnd:
    ret %array_i32* %newArray1
    

}


declare noalias i8* @malloc(i32)

declare i32 @printf(i8*, ...)

declare void @exit(i32)

@.printstr = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1
define void @print(i32 %i) {
    %temp = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.printstr, i32 0, i32 0), i32 %i)
    ret void
}
