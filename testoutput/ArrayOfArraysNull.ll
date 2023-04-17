@.print_message_1 = private unnamed_addr constant [33 x i8] c"Nullpointer exception in line 5\0A\00", align 1
@.print_message_2 = private unnamed_addr constant [37 x i8] c"Index out of bounds error in line 5\0A\00", align 1
@.print_message_3 = private unnamed_addr constant [59 x i8] c"Nullpointer exception when reading array length in line 9\0A\00", align 1
@.print_message_4 = private unnamed_addr constant [29 x i8] c"Array Size must be positive\0A\00", align 1


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
    %x = alloca %array_i32*
    ;1 start statement : {
    ;2 start statement : int[][] arr
    ;2 end statement: int[][] arr
    ;3 start statement : arr = (new int[][2]);
    %newArray1 = call %"array_%array_i32*"* @newArray(i32 2)
    store %"array_%array_i32*"* %newArray1, %"array_%array_i32*"** %arr
    ;3 end statement: arr = (new int[][2]);
    ;4 start statement : int[] x
    ;4 end statement: int[] x
    ;5 start statement : if ((arr[1] == null)) printInt(1);
    %t = load %"array_%array_i32*"*, %"array_%array_i32*"** %arr
    %isNull = icmp eq %"array_%array_i32*"* %t, null
    br i1 %isNull, label %whenIsNull, label %notNull
    
whenIsNull:
    ; ERROR: Nullpointer exception in line 5
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([33 x i8], [33 x i8]* @.print_message_1, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
notNull:
    %length_addr = getelementptr %"array_%array_i32*", %"array_%array_i32*"* %t, i32 0, i32 0
    %len = load i32, i32* %length_addr
    %smallerZero = icmp slt i32 1, 0
    %lenMinusOne = sub i32 %len, 1
    %greaterEqualLen = icmp slt i32 %lenMinusOne, 1
    %outOfBounds = or i1 %smallerZero, %greaterEqualLen
    br i1 %outOfBounds, label %outOfBounds1, label %indexInRange
    
outOfBounds1:
    ; ERROR: Index out of bounds error in line 5
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([37 x i8], [37 x i8]* @.print_message_2, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
indexInRange:
    %indexAddr = getelementptr %"array_%array_i32*", %"array_%array_i32*"* %t, i32 0, i32 1, i32 1
    %t1 = load %array_i32*, %array_i32** %indexAddr
    %castValue = bitcast i8* null to %array_i32*
    %resEqImpl = icmp eq %array_i32* %t1, %castValue
    br i1 %resEqImpl, label %ifTrue, label %ifFalse
    
ifTrue:
    ;6 start statement : printInt(1);
    call void @print(i32 1)
    ;6 end statement: printInt(1);
    br label %endif
    
ifFalse:
    ;8 start statement : printInt(2);
    call void @print(i32 2)
    ;8 end statement: printInt(2);
    br label %endif
    
endif:
    ;5 end statement: if ((arr[1] == null)) printInt(1);
    ;9 start statement : printInt(arr.length);
    %t2 = load %"array_%array_i32*"*, %"array_%array_i32*"** %arr
    %isNull1 = icmp eq %"array_%array_i32*"* %t2, null
    br i1 %isNull1, label %whenIsNull1, label %notNull1
    
whenIsNull1:
    ; ERROR: Nullpointer exception when reading array length in line 9
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([59 x i8], [59 x i8]* @.print_message_3, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
notNull1:
    %length_addr1 = getelementptr %"array_%array_i32*", %"array_%array_i32*"* %t2, i32 0, i32 0
    %len1 = load i32, i32* %length_addr1
    call void @print(i32 %len1)
    ;9 end statement: printInt(arr.length);
    ;10 start statement : return 0;
    ret i32 0
    

}

define %"array_%array_i32*"* @newArray(i32 %size) {
init:
    %sizeLessThanZero = icmp slt i32 %size, 0
    br i1 %sizeLessThanZero, label %negativeSize, label %goodSize
    
negativeSize:
    ; ERROR: Array Size must be positive
    call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([29 x i8], [29 x i8]* @.print_message_4, i32 0, i32 0))
    call void @exit(i32 222)
    unreachable

    
goodSize:
    %arraySizeInBytes = mul i32 %size, 8
    %arraySizeWitLen = add i32 %arraySizeInBytes, 4
    %mallocRes = call i8* @malloc(i32 %arraySizeWitLen)
    %newArray1 = bitcast i8* %mallocRes to %"array_%array_i32*"*
    %sizeAddr = getelementptr %"array_%array_i32*", %"array_%array_i32*"* %newArray1, i32 0, i32 0
    store i32 %size, i32* %sizeAddr
    %iVar = alloca i32
    store i32 0, i32* %iVar
    br label %loopStart
    
loopStart:
    %i = load i32, i32* %iVar
    %smallerSize = icmp slt i32 %i, %size
    br i1 %smallerSize, label %loopBody, label %loopEnd
    
loopBody:
    %iAddr = getelementptr %"array_%array_i32*", %"array_%array_i32*"* %newArray1, i32 0, i32 1, i32 %i
    store %array_i32* null, %array_i32** %iAddr
    %nextI = add i32 %i, 1
    store i32 %nextI, i32* %iVar
    br label %loopStart
    
loopEnd:
    ret %"array_%array_i32*"* %newArray1
    

}


declare noalias i8* @malloc(i32)

declare i32 @printf(i8*, ...)

declare void @exit(i32)

@.printstr = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1
define void @print(i32 %i) {
    %temp = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.printstr, i32 0, i32 0), i32 %i)
    ret void
}
