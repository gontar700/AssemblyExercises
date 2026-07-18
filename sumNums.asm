model small
STACK 100h
DATASEG

sum DW 1           

CODESEG

sumOf proc      
    xor dx,dx
    xor cx,cx
    mov dl,al; dl = 7
    mov cl,bl ; cl = 23
    sub cl,al ; cl = cl - al = 23 -  7 = 16. ; why ? we will loop 16 numbers: 7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22
    addLoop:
        inc al; al = 8 , last al = 23
        add dx, ax ; dl = 7+8
        loop addLoop
ret
endp sumOf


start:
    mov ax, @data
    mov ds, ax

    mov ax, 7
    mov bx, 23
     
    call sumOf
    add [sum], dx
    
    
        ; ---- convert sum to ASCII string ----
    MOV AX, sum
    MOV BX, 10
    XOR CX, CX              ; digit counter

CONVERT:
    XOR DX, DX
    DIV BX                  ; AX / 10 -> AX=quotient, DX=remainder
    ADD DL, '0'             ; convert remainder to ASCII
    PUSH DX                 ; push digit onto stack (reverses order)
    INC CX
    CMP AX, 0
    JNZ CONVERT

    ; ---- pop digits off stack in correct order and print ----
PRINT_DIGITS:
    POP DX
    MOV AH, 02h
    INT 21h
    LOOP PRINT_DIGITS
    

exit:
    mov ax, 4c00h
    int 21h
END start