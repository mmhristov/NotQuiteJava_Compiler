@.print_message_1 = private unnamed_addr constant [33 x i8] c"Nullpointer exception in line 4\0A\00", align 1
@.print_message_2 = private unnamed_addr constant [37 x i8] c"Index out of bounds error in line 4\0A\00", align 1
@.print_message_3 = private unnamed_addr constant [29 x i8] c"Array Size must be positive\0A\00", align 1


%array_i32 = type {
     i32  ; length
    ,[0 x i32]  ; data
}

%"array_%array_i32*" = type {
     i32  ; length
    ,[0 x %array_i32*]  ; data
}

%"array_%\22array_%array_i32*\22*" = type {
     i32  ; length
    ,[0 x %"array_%array_i32*"*]  ; data
}

define i32 @main() {
init:
    %a = alloca %"array_%\22array_%array_i32*\22*"*
    ;1 start statement : {
    ;2 start statement : int[][][] a
    ;2 end statement: int[][][] a
    ;3 start statement : a = (new int[][][5]);
    %newArray1 = call %"array_%\22array_%array_i32*\22*"* @newArray(i32 5)
    store %"array_%\22array_%array_i32*\22*"* %newArray1, %"array_%\22array_%array_i32*\22*"** %a
    ;3 end statement: a = (new int[][][5]);
    ;4 start statement : printInt(a[0][0][1]);
    %t = load %"array_%\22array_%array_i32*\22*"*, %"array_%\22array_%array_i32*\22*"** %a
    %isNull = icmp eq %"array_%\22array_%array_i32*\22*"* %t, null
    br i1 %isNull, label %whenIsNull, label %notNull
    
whenIsNull:
    ; ERROR: Nullpointer exception in line 4
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([33 x i8], [33 x i8]* @.print_message_1, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
notNull:
    %length_addr = getelementptr %"array_%\22array_%array_i32*\22*", %"array_%\22array_%array_i32*\22*"* %t, i32 0, i32 0
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
    %indexAddr = getelementptr %"array_%\22array_%array_i32*\22*", %"array_%\22array_%array_i32*\22*"* %t, i32 0, i32 1, i32 0
    %t1 = load %"array_%array_i32*"*, %"array_%array_i32*"** %indexAddr
    %isNull1 = icmp eq %"array_%array_i32*"* %t1, null
    br i1 %isNull1, label %whenIsNull1, label %notNull1
    
whenIsNull1:
    ; ERROR: Nullpointer exception in line 4
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([33 x i8], [33 x i8]* @.print_message_1, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
notNull1:
    %length_addr1 = getelementptr %"array_%array_i32*", %"array_%array_i32*"* %t1, i32 0, i32 0
    %len1 = load i32, i32* %length_addr1
    %smallerZero1 = icmp slt i32 0, 0
    %lenMinusOne1 = sub i32 %len1, 1
    %greaterEqualLen1 = icmp slt i32 %lenMinusOne1, 0
    %outOfBounds2 = or i1 %smallerZero1, %greaterEqualLen1
    br i1 %outOfBounds2, label %outOfBounds3, label %indexInRange1
    
outOfBounds3:
    ; ERROR: Index out of bounds error in line 4
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([37 x i8], [37 x i8]* @.print_message_2, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
indexInRange1:
    %indexAddr1 = getelementptr %"array_%array_i32*", %"array_%array_i32*"* %t1, i32 0, i32 1, i32 0
    %t2 = load %array_i32*, %array_i32** %indexAddr1
    %isNull2 = icmp eq %array_i32* %t2, null
    br i1 %isNull2, label %whenIsNull2, label %notNull2
    
whenIsNull2:
    ; ERROR: Nullpointer exception in line 4
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([33 x i8], [33 x i8]* @.print_message_1, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
notNull2:
    %length_addr2 = getelementptr %array_i32, %array_i32* %t2, i32 0, i32 0
    %len2 = load i32, i32* %length_addr2
    %smallerZero2 = icmp slt i32 1, 0
    %lenMinusOne2 = sub i32 %len2, 1
    %greaterEqualLen2 = icmp slt i32 %lenMinusOne2, 1
    %outOfBounds4 = or i1 %smallerZero2, %greaterEqualLen2
    br i1 %outOfBounds4, label %outOfBounds5, label %indexInRange2
    
outOfBounds5:
    ; ERROR: Index out of bounds error in line 4
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([37 x i8], [37 x i8]* @.print_message_2, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
indexInRange2:
    %indexAddr2 = getelementptr %array_i32, %array_i32* %t2, i32 0, i32 1, i32 1
    %t3 = load i32, i32* %indexAddr2
    call void @print(i32 %t3)
    ;4 end statement: printInt(a[0][0][1]);
    ;5 start statement : return 0;
    ret i32 0
    

}

define %"array_%\22array_%array_i32*\22*"* @newArray(i32 %size) {
init:
    %sizeLessThanZero = icmp slt i32 %size, 0
    br i1 %sizeLessThanZero, label %negativeSize, label %goodSize
    
negativeSize:
    ; ERROR: Array Size must be positive
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([29 x i8], [29 x i8]* @.print_message_3, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
goodSize:
    %arraySizeInBytes = mul i32 %size, 8
    %arraySizeWitLen = add i32 %arraySizeInBytes, 4
    %mallocRes = call i8* @malloc(i32 %arraySizeWitLen)
    %newArray1 = bitcast i8* %mallocRes to %"array_%\22array_%array_i32*\22*"*
    %sizeAddr = getelementptr %"array_%\22array_%array_i32*\22*", %"array_%\22array_%array_i32*\22*"* %newArray1, i32 0, i32 0
    store i32 %size, i32* %sizeAddr
    %iVar = alloca i32
    store i32 0, i32* %iVar
    br label %loopStart
    
loopStart:
    %i = load i32, i32* %iVar
    %smallerSize = icmp slt i32 %i, %size
    br i1 %smallerSize, label %loopBody, label %loopEnd
    
loopBody:
    %iAddr = getelementptr %"array_%\22array_%array_i32*\22*", %"array_%\22array_%array_i32*\22*"* %newArray1, i32 0, i32 1, i32 %i
    store %"array_%array_i32*"* null, %"array_%array_i32*"** %iAddr
    %nextI = add i32 %i, 1
    store i32 %nextI, i32* %iVar
    br label %loopStart
    
loopEnd:
    ret %"array_%\22array_%array_i32*\22*"* %newArray1
    

}


declare noalias i8* @malloc(i32)

declare i32 @printf(i8*, ...)

declare void @exit(i32)

@.printstr = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1
define void @print(i32 %i) {
    %temp = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.printstr, i32 0, i32 0), i32 %i)
    ret void
}
