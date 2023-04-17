@.print_message_1 = private unnamed_addr constant [33 x i8] c"Nullpointer exception in line 4\0A\00", align 1
@.print_message_2 = private unnamed_addr constant [37 x i8] c"Index out of bounds error in line 4\0A\00", align 1
@.print_message_3 = private unnamed_addr constant [33 x i8] c"Nullpointer exception in line 5\0A\00", align 1
@.print_message_4 = private unnamed_addr constant [37 x i8] c"Index out of bounds error in line 5\0A\00", align 1
@.print_message_5 = private unnamed_addr constant [33 x i8] c"Nullpointer exception in line 6\0A\00", align 1
@.print_message_6 = private unnamed_addr constant [37 x i8] c"Index out of bounds error in line 6\0A\00", align 1
@.print_message_7 = private unnamed_addr constant [33 x i8] c"Nullpointer exception in line 7\0A\00", align 1
@.print_message_8 = private unnamed_addr constant [37 x i8] c"Index out of bounds error in line 7\0A\00", align 1
@.print_message_9 = private unnamed_addr constant [33 x i8] c"Nullpointer exception in line 8\0A\00", align 1
@.print_message_10 = private unnamed_addr constant [37 x i8] c"Index out of bounds error in line 8\0A\00", align 1
@.print_message_11 = private unnamed_addr constant [33 x i8] c"Nullpointer exception in line 9\0A\00", align 1
@.print_message_12 = private unnamed_addr constant [37 x i8] c"Index out of bounds error in line 9\0A\00", align 1
@.print_message_13 = private unnamed_addr constant [34 x i8] c"Nullpointer exception in line 10\0A\00", align 1
@.print_message_14 = private unnamed_addr constant [38 x i8] c"Index out of bounds error in line 10\0A\00", align 1
@.print_message_15 = private unnamed_addr constant [34 x i8] c"Nullpointer exception in line 11\0A\00", align 1
@.print_message_16 = private unnamed_addr constant [38 x i8] c"Index out of bounds error in line 11\0A\00", align 1
@.print_message_17 = private unnamed_addr constant [34 x i8] c"Nullpointer exception in line 12\0A\00", align 1
@.print_message_18 = private unnamed_addr constant [38 x i8] c"Index out of bounds error in line 12\0A\00", align 1
@.print_message_19 = private unnamed_addr constant [34 x i8] c"Nullpointer exception in line 13\0A\00", align 1
@.print_message_20 = private unnamed_addr constant [38 x i8] c"Index out of bounds error in line 13\0A\00", align 1
@.print_message_21 = private unnamed_addr constant [60 x i8] c"Nullpointer exception when reading array length in line 14\0A\00", align 1
@.print_message_22 = private unnamed_addr constant [29 x i8] c"Array Size must be positive\0A\00", align 1


%array_i32 = type {
     i32  ; length
    ,[0 x i32]  ; data
}

%"array_%array_i32*" = type {
     i32  ; length
    ,[0 x %array_i32*]  ; data
}

define i32 @main() {
init:
    %arr = alloca %"array_%array_i32*"*
    ;1 start statement : {
    ;2 start statement : int[][] arr
    ;2 end statement: int[][] arr
    ;3 start statement : arr = (new int[][2]);
    %newArray2 = call %"array_%array_i32*"* @newArray(i32 2)
    store %"array_%array_i32*"* %newArray2, %"array_%array_i32*"** %arr
    ;3 end statement: arr = (new int[][2]);
    ;4 start statement : arr[0] = (new int[2]);
    %t = load %"array_%array_i32*"*, %"array_%array_i32*"** %arr
    %isNull = icmp eq %"array_%array_i32*"* %t, null
    br i1 %isNull, label %whenIsNull, label %notNull
    
whenIsNull:
    ; ERROR: Nullpointer exception in line 4
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([33 x i8], [33 x i8]* @.print_message_1, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
notNull:
    %length_addr = getelementptr %"array_%array_i32*", %"array_%array_i32*"* %t, i32 0, i32 0
    %len = load i32, i32* %length_addr
    %smallerZero = icmp slt i32 0, 0
    %lenMinusOne = sub i32 %len, 1
    %greaterEqualLen = icmp slt i32 %lenMinusOne, 0
    %outOfBounds = or i1 %smallerZero, %greaterEqualLen
    br i1 %outOfBounds, label %outOfBounds1, label %indexInRange
    
outOfBounds1:
    ; ERROR: Index out of bounds error in line 4
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([37 x i8], [37 x i8]* @.print_message_2, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
indexInRange:
    %indexAddr = getelementptr %"array_%array_i32*", %"array_%array_i32*"* %t, i32 0, i32 1, i32 0
    %newArray3 = call %array_i32* @newArray1(i32 2)
    store %array_i32* %newArray3, %array_i32** %indexAddr
    ;4 end statement: arr[0] = (new int[2]);
    ;5 start statement : arr[1] = (new int[2]);
    %t1 = load %"array_%array_i32*"*, %"array_%array_i32*"** %arr
    %isNull1 = icmp eq %"array_%array_i32*"* %t1, null
    br i1 %isNull1, label %whenIsNull1, label %notNull1
    
whenIsNull1:
    ; ERROR: Nullpointer exception in line 5
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([33 x i8], [33 x i8]* @.print_message_3, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
notNull1:
    %length_addr1 = getelementptr %"array_%array_i32*", %"array_%array_i32*"* %t1, i32 0, i32 0
    %len1 = load i32, i32* %length_addr1
    %smallerZero1 = icmp slt i32 1, 0
    %lenMinusOne1 = sub i32 %len1, 1
    %greaterEqualLen1 = icmp slt i32 %lenMinusOne1, 1
    %outOfBounds2 = or i1 %smallerZero1, %greaterEqualLen1
    br i1 %outOfBounds2, label %outOfBounds3, label %indexInRange1
    
outOfBounds3:
    ; ERROR: Index out of bounds error in line 5
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([37 x i8], [37 x i8]* @.print_message_4, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
indexInRange1:
    %indexAddr1 = getelementptr %"array_%array_i32*", %"array_%array_i32*"* %t1, i32 0, i32 1, i32 1
    %newArray4 = call %array_i32* @newArray1(i32 2)
    store %array_i32* %newArray4, %array_i32** %indexAddr1
    ;5 end statement: arr[1] = (new int[2]);
    ;6 start statement : arr[0][0] = 1;
    %t2 = load %"array_%array_i32*"*, %"array_%array_i32*"** %arr
    %isNull2 = icmp eq %"array_%array_i32*"* %t2, null
    br i1 %isNull2, label %whenIsNull2, label %notNull2
    
whenIsNull2:
    ; ERROR: Nullpointer exception in line 6
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([33 x i8], [33 x i8]* @.print_message_5, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
notNull2:
    %length_addr2 = getelementptr %"array_%array_i32*", %"array_%array_i32*"* %t2, i32 0, i32 0
    %len2 = load i32, i32* %length_addr2
    %smallerZero2 = icmp slt i32 0, 0
    %lenMinusOne2 = sub i32 %len2, 1
    %greaterEqualLen2 = icmp slt i32 %lenMinusOne2, 0
    %outOfBounds4 = or i1 %smallerZero2, %greaterEqualLen2
    br i1 %outOfBounds4, label %outOfBounds5, label %indexInRange2
    
outOfBounds5:
    ; ERROR: Index out of bounds error in line 6
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([37 x i8], [37 x i8]* @.print_message_6, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
indexInRange2:
    %indexAddr2 = getelementptr %"array_%array_i32*", %"array_%array_i32*"* %t2, i32 0, i32 1, i32 0
    %t3 = load %array_i32*, %array_i32** %indexAddr2
    %isNull3 = icmp eq %array_i32* %t3, null
    br i1 %isNull3, label %whenIsNull3, label %notNull3
    
whenIsNull3:
    ; ERROR: Nullpointer exception in line 6
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([33 x i8], [33 x i8]* @.print_message_5, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
notNull3:
    %length_addr3 = getelementptr %array_i32, %array_i32* %t3, i32 0, i32 0
    %len3 = load i32, i32* %length_addr3
    %smallerZero3 = icmp slt i32 0, 0
    %lenMinusOne3 = sub i32 %len3, 1
    %greaterEqualLen3 = icmp slt i32 %lenMinusOne3, 0
    %outOfBounds6 = or i1 %smallerZero3, %greaterEqualLen3
    br i1 %outOfBounds6, label %outOfBounds7, label %indexInRange3
    
outOfBounds7:
    ; ERROR: Index out of bounds error in line 6
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([37 x i8], [37 x i8]* @.print_message_6, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
indexInRange3:
    %indexAddr3 = getelementptr %array_i32, %array_i32* %t3, i32 0, i32 1, i32 0
    store i32 1, i32* %indexAddr3
    ;6 end statement: arr[0][0] = 1;
    ;7 start statement : arr[0][1] = 1;
    %t4 = load %"array_%array_i32*"*, %"array_%array_i32*"** %arr
    %isNull4 = icmp eq %"array_%array_i32*"* %t4, null
    br i1 %isNull4, label %whenIsNull4, label %notNull4
    
whenIsNull4:
    ; ERROR: Nullpointer exception in line 7
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([33 x i8], [33 x i8]* @.print_message_7, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
notNull4:
    %length_addr4 = getelementptr %"array_%array_i32*", %"array_%array_i32*"* %t4, i32 0, i32 0
    %len4 = load i32, i32* %length_addr4
    %smallerZero4 = icmp slt i32 0, 0
    %lenMinusOne4 = sub i32 %len4, 1
    %greaterEqualLen4 = icmp slt i32 %lenMinusOne4, 0
    %outOfBounds8 = or i1 %smallerZero4, %greaterEqualLen4
    br i1 %outOfBounds8, label %outOfBounds9, label %indexInRange4
    
outOfBounds9:
    ; ERROR: Index out of bounds error in line 7
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([37 x i8], [37 x i8]* @.print_message_8, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
indexInRange4:
    %indexAddr4 = getelementptr %"array_%array_i32*", %"array_%array_i32*"* %t4, i32 0, i32 1, i32 0
    %t5 = load %array_i32*, %array_i32** %indexAddr4
    %isNull5 = icmp eq %array_i32* %t5, null
    br i1 %isNull5, label %whenIsNull5, label %notNull5
    
whenIsNull5:
    ; ERROR: Nullpointer exception in line 7
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([33 x i8], [33 x i8]* @.print_message_7, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
notNull5:
    %length_addr5 = getelementptr %array_i32, %array_i32* %t5, i32 0, i32 0
    %len5 = load i32, i32* %length_addr5
    %smallerZero5 = icmp slt i32 1, 0
    %lenMinusOne5 = sub i32 %len5, 1
    %greaterEqualLen5 = icmp slt i32 %lenMinusOne5, 1
    %outOfBounds10 = or i1 %smallerZero5, %greaterEqualLen5
    br i1 %outOfBounds10, label %outOfBounds11, label %indexInRange5
    
outOfBounds11:
    ; ERROR: Index out of bounds error in line 7
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([37 x i8], [37 x i8]* @.print_message_8, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
indexInRange5:
    %indexAddr5 = getelementptr %array_i32, %array_i32* %t5, i32 0, i32 1, i32 1
    store i32 1, i32* %indexAddr5
    ;7 end statement: arr[0][1] = 1;
    ;8 start statement : arr[1][0] = 1;
    %t6 = load %"array_%array_i32*"*, %"array_%array_i32*"** %arr
    %isNull6 = icmp eq %"array_%array_i32*"* %t6, null
    br i1 %isNull6, label %whenIsNull6, label %notNull6
    
whenIsNull6:
    ; ERROR: Nullpointer exception in line 8
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([33 x i8], [33 x i8]* @.print_message_9, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
notNull6:
    %length_addr6 = getelementptr %"array_%array_i32*", %"array_%array_i32*"* %t6, i32 0, i32 0
    %len6 = load i32, i32* %length_addr6
    %smallerZero6 = icmp slt i32 1, 0
    %lenMinusOne6 = sub i32 %len6, 1
    %greaterEqualLen6 = icmp slt i32 %lenMinusOne6, 1
    %outOfBounds12 = or i1 %smallerZero6, %greaterEqualLen6
    br i1 %outOfBounds12, label %outOfBounds13, label %indexInRange6
    
outOfBounds13:
    ; ERROR: Index out of bounds error in line 8
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([37 x i8], [37 x i8]* @.print_message_10, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
indexInRange6:
    %indexAddr6 = getelementptr %"array_%array_i32*", %"array_%array_i32*"* %t6, i32 0, i32 1, i32 1
    %t7 = load %array_i32*, %array_i32** %indexAddr6
    %isNull7 = icmp eq %array_i32* %t7, null
    br i1 %isNull7, label %whenIsNull7, label %notNull7
    
whenIsNull7:
    ; ERROR: Nullpointer exception in line 8
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([33 x i8], [33 x i8]* @.print_message_9, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
notNull7:
    %length_addr7 = getelementptr %array_i32, %array_i32* %t7, i32 0, i32 0
    %len7 = load i32, i32* %length_addr7
    %smallerZero7 = icmp slt i32 0, 0
    %lenMinusOne7 = sub i32 %len7, 1
    %greaterEqualLen7 = icmp slt i32 %lenMinusOne7, 0
    %outOfBounds14 = or i1 %smallerZero7, %greaterEqualLen7
    br i1 %outOfBounds14, label %outOfBounds15, label %indexInRange7
    
outOfBounds15:
    ; ERROR: Index out of bounds error in line 8
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([37 x i8], [37 x i8]* @.print_message_10, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
indexInRange7:
    %indexAddr7 = getelementptr %array_i32, %array_i32* %t7, i32 0, i32 1, i32 0
    store i32 1, i32* %indexAddr7
    ;8 end statement: arr[1][0] = 1;
    ;9 start statement : arr[1][1] = 1;
    %t8 = load %"array_%array_i32*"*, %"array_%array_i32*"** %arr
    %isNull8 = icmp eq %"array_%array_i32*"* %t8, null
    br i1 %isNull8, label %whenIsNull8, label %notNull8
    
whenIsNull8:
    ; ERROR: Nullpointer exception in line 9
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([33 x i8], [33 x i8]* @.print_message_11, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
notNull8:
    %length_addr8 = getelementptr %"array_%array_i32*", %"array_%array_i32*"* %t8, i32 0, i32 0
    %len8 = load i32, i32* %length_addr8
    %smallerZero8 = icmp slt i32 1, 0
    %lenMinusOne8 = sub i32 %len8, 1
    %greaterEqualLen8 = icmp slt i32 %lenMinusOne8, 1
    %outOfBounds16 = or i1 %smallerZero8, %greaterEqualLen8
    br i1 %outOfBounds16, label %outOfBounds17, label %indexInRange8
    
outOfBounds17:
    ; ERROR: Index out of bounds error in line 9
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([37 x i8], [37 x i8]* @.print_message_12, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
indexInRange8:
    %indexAddr8 = getelementptr %"array_%array_i32*", %"array_%array_i32*"* %t8, i32 0, i32 1, i32 1
    %t9 = load %array_i32*, %array_i32** %indexAddr8
    %isNull9 = icmp eq %array_i32* %t9, null
    br i1 %isNull9, label %whenIsNull9, label %notNull9
    
whenIsNull9:
    ; ERROR: Nullpointer exception in line 9
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([33 x i8], [33 x i8]* @.print_message_11, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
notNull9:
    %length_addr9 = getelementptr %array_i32, %array_i32* %t9, i32 0, i32 0
    %len9 = load i32, i32* %length_addr9
    %smallerZero9 = icmp slt i32 1, 0
    %lenMinusOne9 = sub i32 %len9, 1
    %greaterEqualLen9 = icmp slt i32 %lenMinusOne9, 1
    %outOfBounds18 = or i1 %smallerZero9, %greaterEqualLen9
    br i1 %outOfBounds18, label %outOfBounds19, label %indexInRange9
    
outOfBounds19:
    ; ERROR: Index out of bounds error in line 9
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([37 x i8], [37 x i8]* @.print_message_12, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
indexInRange9:
    %indexAddr9 = getelementptr %array_i32, %array_i32* %t9, i32 0, i32 1, i32 1
    store i32 1, i32* %indexAddr9
    ;9 end statement: arr[1][1] = 1;
    ;10 start statement : printInt(arr[0][0]);
    %t10 = load %"array_%array_i32*"*, %"array_%array_i32*"** %arr
    %isNull10 = icmp eq %"array_%array_i32*"* %t10, null
    br i1 %isNull10, label %whenIsNull10, label %notNull10
    
whenIsNull10:
    ; ERROR: Nullpointer exception in line 10
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([34 x i8], [34 x i8]* @.print_message_13, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
notNull10:
    %length_addr10 = getelementptr %"array_%array_i32*", %"array_%array_i32*"* %t10, i32 0, i32 0
    %len10 = load i32, i32* %length_addr10
    %smallerZero10 = icmp slt i32 0, 0
    %lenMinusOne10 = sub i32 %len10, 1
    %greaterEqualLen10 = icmp slt i32 %lenMinusOne10, 0
    %outOfBounds20 = or i1 %smallerZero10, %greaterEqualLen10
    br i1 %outOfBounds20, label %outOfBounds21, label %indexInRange10
    
outOfBounds21:
    ; ERROR: Index out of bounds error in line 10
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([38 x i8], [38 x i8]* @.print_message_14, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
indexInRange10:
    %indexAddr10 = getelementptr %"array_%array_i32*", %"array_%array_i32*"* %t10, i32 0, i32 1, i32 0
    %t11 = load %array_i32*, %array_i32** %indexAddr10
    %isNull11 = icmp eq %array_i32* %t11, null
    br i1 %isNull11, label %whenIsNull11, label %notNull11
    
whenIsNull11:
    ; ERROR: Nullpointer exception in line 10
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([34 x i8], [34 x i8]* @.print_message_13, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
notNull11:
    %length_addr11 = getelementptr %array_i32, %array_i32* %t11, i32 0, i32 0
    %len11 = load i32, i32* %length_addr11
    %smallerZero11 = icmp slt i32 0, 0
    %lenMinusOne11 = sub i32 %len11, 1
    %greaterEqualLen11 = icmp slt i32 %lenMinusOne11, 0
    %outOfBounds22 = or i1 %smallerZero11, %greaterEqualLen11
    br i1 %outOfBounds22, label %outOfBounds23, label %indexInRange11
    
outOfBounds23:
    ; ERROR: Index out of bounds error in line 10
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([38 x i8], [38 x i8]* @.print_message_14, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
indexInRange11:
    %indexAddr11 = getelementptr %array_i32, %array_i32* %t11, i32 0, i32 1, i32 0
    %t12 = load i32, i32* %indexAddr11
    call void @print(i32 %t12)
    ;10 end statement: printInt(arr[0][0]);
    ;11 start statement : printInt(arr[0][1]);
    %t13 = load %"array_%array_i32*"*, %"array_%array_i32*"** %arr
    %isNull12 = icmp eq %"array_%array_i32*"* %t13, null
    br i1 %isNull12, label %whenIsNull12, label %notNull12
    
whenIsNull12:
    ; ERROR: Nullpointer exception in line 11
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([34 x i8], [34 x i8]* @.print_message_15, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
notNull12:
    %length_addr12 = getelementptr %"array_%array_i32*", %"array_%array_i32*"* %t13, i32 0, i32 0
    %len12 = load i32, i32* %length_addr12
    %smallerZero12 = icmp slt i32 0, 0
    %lenMinusOne12 = sub i32 %len12, 1
    %greaterEqualLen12 = icmp slt i32 %lenMinusOne12, 0
    %outOfBounds24 = or i1 %smallerZero12, %greaterEqualLen12
    br i1 %outOfBounds24, label %outOfBounds25, label %indexInRange12
    
outOfBounds25:
    ; ERROR: Index out of bounds error in line 11
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([38 x i8], [38 x i8]* @.print_message_16, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
indexInRange12:
    %indexAddr12 = getelementptr %"array_%array_i32*", %"array_%array_i32*"* %t13, i32 0, i32 1, i32 0
    %t14 = load %array_i32*, %array_i32** %indexAddr12
    %isNull13 = icmp eq %array_i32* %t14, null
    br i1 %isNull13, label %whenIsNull13, label %notNull13
    
whenIsNull13:
    ; ERROR: Nullpointer exception in line 11
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([34 x i8], [34 x i8]* @.print_message_15, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
notNull13:
    %length_addr13 = getelementptr %array_i32, %array_i32* %t14, i32 0, i32 0
    %len13 = load i32, i32* %length_addr13
    %smallerZero13 = icmp slt i32 1, 0
    %lenMinusOne13 = sub i32 %len13, 1
    %greaterEqualLen13 = icmp slt i32 %lenMinusOne13, 1
    %outOfBounds26 = or i1 %smallerZero13, %greaterEqualLen13
    br i1 %outOfBounds26, label %outOfBounds27, label %indexInRange13
    
outOfBounds27:
    ; ERROR: Index out of bounds error in line 11
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([38 x i8], [38 x i8]* @.print_message_16, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
indexInRange13:
    %indexAddr13 = getelementptr %array_i32, %array_i32* %t14, i32 0, i32 1, i32 1
    %t15 = load i32, i32* %indexAddr13
    call void @print(i32 %t15)
    ;11 end statement: printInt(arr[0][1]);
    ;12 start statement : printInt(arr[1][0]);
    %t16 = load %"array_%array_i32*"*, %"array_%array_i32*"** %arr
    %isNull14 = icmp eq %"array_%array_i32*"* %t16, null
    br i1 %isNull14, label %whenIsNull14, label %notNull14
    
whenIsNull14:
    ; ERROR: Nullpointer exception in line 12
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([34 x i8], [34 x i8]* @.print_message_17, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
notNull14:
    %length_addr14 = getelementptr %"array_%array_i32*", %"array_%array_i32*"* %t16, i32 0, i32 0
    %len14 = load i32, i32* %length_addr14
    %smallerZero14 = icmp slt i32 1, 0
    %lenMinusOne14 = sub i32 %len14, 1
    %greaterEqualLen14 = icmp slt i32 %lenMinusOne14, 1
    %outOfBounds28 = or i1 %smallerZero14, %greaterEqualLen14
    br i1 %outOfBounds28, label %outOfBounds29, label %indexInRange14
    
outOfBounds29:
    ; ERROR: Index out of bounds error in line 12
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([38 x i8], [38 x i8]* @.print_message_18, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
indexInRange14:
    %indexAddr14 = getelementptr %"array_%array_i32*", %"array_%array_i32*"* %t16, i32 0, i32 1, i32 1
    %t17 = load %array_i32*, %array_i32** %indexAddr14
    %isNull15 = icmp eq %array_i32* %t17, null
    br i1 %isNull15, label %whenIsNull15, label %notNull15
    
whenIsNull15:
    ; ERROR: Nullpointer exception in line 12
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([34 x i8], [34 x i8]* @.print_message_17, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
notNull15:
    %length_addr15 = getelementptr %array_i32, %array_i32* %t17, i32 0, i32 0
    %len15 = load i32, i32* %length_addr15
    %smallerZero15 = icmp slt i32 0, 0
    %lenMinusOne15 = sub i32 %len15, 1
    %greaterEqualLen15 = icmp slt i32 %lenMinusOne15, 0
    %outOfBounds30 = or i1 %smallerZero15, %greaterEqualLen15
    br i1 %outOfBounds30, label %outOfBounds31, label %indexInRange15
    
outOfBounds31:
    ; ERROR: Index out of bounds error in line 12
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([38 x i8], [38 x i8]* @.print_message_18, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
indexInRange15:
    %indexAddr15 = getelementptr %array_i32, %array_i32* %t17, i32 0, i32 1, i32 0
    %t18 = load i32, i32* %indexAddr15
    call void @print(i32 %t18)
    ;12 end statement: printInt(arr[1][0]);
    ;13 start statement : printInt(arr[1][1]);
    %t19 = load %"array_%array_i32*"*, %"array_%array_i32*"** %arr
    %isNull16 = icmp eq %"array_%array_i32*"* %t19, null
    br i1 %isNull16, label %whenIsNull16, label %notNull16
    
whenIsNull16:
    ; ERROR: Nullpointer exception in line 13
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([34 x i8], [34 x i8]* @.print_message_19, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
notNull16:
    %length_addr16 = getelementptr %"array_%array_i32*", %"array_%array_i32*"* %t19, i32 0, i32 0
    %len16 = load i32, i32* %length_addr16
    %smallerZero16 = icmp slt i32 1, 0
    %lenMinusOne16 = sub i32 %len16, 1
    %greaterEqualLen16 = icmp slt i32 %lenMinusOne16, 1
    %outOfBounds32 = or i1 %smallerZero16, %greaterEqualLen16
    br i1 %outOfBounds32, label %outOfBounds33, label %indexInRange16
    
outOfBounds33:
    ; ERROR: Index out of bounds error in line 13
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([38 x i8], [38 x i8]* @.print_message_20, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
indexInRange16:
    %indexAddr16 = getelementptr %"array_%array_i32*", %"array_%array_i32*"* %t19, i32 0, i32 1, i32 1
    %t20 = load %array_i32*, %array_i32** %indexAddr16
    %isNull17 = icmp eq %array_i32* %t20, null
    br i1 %isNull17, label %whenIsNull17, label %notNull17
    
whenIsNull17:
    ; ERROR: Nullpointer exception in line 13
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([34 x i8], [34 x i8]* @.print_message_19, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
notNull17:
    %length_addr17 = getelementptr %array_i32, %array_i32* %t20, i32 0, i32 0
    %len17 = load i32, i32* %length_addr17
    %smallerZero17 = icmp slt i32 1, 0
    %lenMinusOne17 = sub i32 %len17, 1
    %greaterEqualLen17 = icmp slt i32 %lenMinusOne17, 1
    %outOfBounds34 = or i1 %smallerZero17, %greaterEqualLen17
    br i1 %outOfBounds34, label %outOfBounds35, label %indexInRange17
    
outOfBounds35:
    ; ERROR: Index out of bounds error in line 13
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([38 x i8], [38 x i8]* @.print_message_20, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
indexInRange17:
    %indexAddr17 = getelementptr %array_i32, %array_i32* %t20, i32 0, i32 1, i32 1
    %t21 = load i32, i32* %indexAddr17
    call void @print(i32 %t21)
    ;13 end statement: printInt(arr[1][1]);
    ;14 start statement : printInt(arr.length);
    %t22 = load %"array_%array_i32*"*, %"array_%array_i32*"** %arr
    %isNull18 = icmp eq %"array_%array_i32*"* %t22, null
    br i1 %isNull18, label %whenIsNull18, label %notNull18
    
whenIsNull18:
    ; ERROR: Nullpointer exception when reading array length in line 14
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([60 x i8], [60 x i8]* @.print_message_21, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
notNull18:
    %length_addr18 = getelementptr %"array_%array_i32*", %"array_%array_i32*"* %t22, i32 0, i32 0
    %len18 = load i32, i32* %length_addr18
    call void @print(i32 %len18)
    ;14 end statement: printInt(arr.length);
    ;15 start statement : return 0;
    ret i32 0
    

}

define %"array_%array_i32*"* @newArray(i32 %size) {
init:
    %sizeLessThanZero = icmp slt i32 %size, 0
    br i1 %sizeLessThanZero, label %negativeSize, label %goodSize
    
negativeSize:
    ; ERROR: Array Size must be positive
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([29 x i8], [29 x i8]* @.print_message_22, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
goodSize:
    %arraySizeInBytes = mul i32 %size, 8
    %arraySizeWitLen = add i32 %arraySizeInBytes, 4
    %mallocRes = call i8* @malloc(i32 %arraySizeWitLen)
    %newArray2 = bitcast i8* %mallocRes to %"array_%array_i32*"*
    %sizeAddr = getelementptr %"array_%array_i32*", %"array_%array_i32*"* %newArray2, i32 0, i32 0
    store i32 %size, i32* %sizeAddr
    %iVar = alloca i32
    store i32 0, i32* %iVar
    br label %loopStart
    
loopStart:
    %i = load i32, i32* %iVar
    %smallerSize = icmp slt i32 %i, %size
    br i1 %smallerSize, label %loopBody, label %loopEnd
    
loopBody:
    %iAddr = getelementptr %"array_%array_i32*", %"array_%array_i32*"* %newArray2, i32 0, i32 1, i32 %i
    store %array_i32* null, %array_i32** %iAddr
    %nextI = add i32 %i, 1
    store i32 %nextI, i32* %iVar
    br label %loopStart
    
loopEnd:
    ret %"array_%array_i32*"* %newArray2
    

}

define %array_i32* @newArray1(i32 %size) {
init:
    %sizeLessThanZero = icmp slt i32 %size, 0
    br i1 %sizeLessThanZero, label %negativeSize, label %goodSize
    
negativeSize:
    ; ERROR: Array Size must be positive
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([29 x i8], [29 x i8]* @.print_message_22, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
goodSize:
    %arraySizeInBytes = mul i32 %size, 4
    %arraySizeWitLen = add i32 %arraySizeInBytes, 4
    %mallocRes = call i8* @malloc(i32 %arraySizeWitLen)
    %newArray2 = bitcast i8* %mallocRes to %array_i32*
    %sizeAddr = getelementptr %array_i32, %array_i32* %newArray2, i32 0, i32 0
    store i32 %size, i32* %sizeAddr
    %iVar = alloca i32
    store i32 0, i32* %iVar
    br label %loopStart
    
loopStart:
    %i = load i32, i32* %iVar
    %smallerSize = icmp slt i32 %i, %size
    br i1 %smallerSize, label %loopBody, label %loopEnd
    
loopBody:
    %iAddr = getelementptr %array_i32, %array_i32* %newArray2, i32 0, i32 1, i32 %i
    store i32 0, i32* %iAddr
    %nextI = add i32 %i, 1
    store i32 %nextI, i32* %iVar
    br label %loopStart
    
loopEnd:
    ret %array_i32* %newArray2
    

}


declare noalias i8* @malloc(i32)

declare i32 @printf(i8*, ...)

declare void @exit(i32)

@.printstr = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1
define void @print(i32 %i) {
    %temp = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.printstr, i32 0, i32 0), i32 %i)
    ret void
}
