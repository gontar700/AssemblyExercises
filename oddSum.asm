MODEL small
DATASEG
     mat DW 0ffh, 2, 3, 4, 5, 6, 7, 8, 0abh, 0a9h
CODESEG
start:
    mov ax, @data
    mov ds, ax
    
    mov cx,4
    xor dx,dx
    lea bx,mat
    mov si,2
again:
    add dl,[bx+si]
    add si,2
    loop again

; --- convert sum to ASCII string ---
    MOV ax,dx
    MOV CX, 0                   ; digit counter
    MOV BX, 10
CONVERT_LOOP:
    XOR DX, DX
    DIV BX                      ; AX / 10 ->     
    ADD DL, '0'                 ; convert remainder 
    PUSH DX                     ; save digit on stack 
    INC CX
    CMP AX, 0
    JNZ CONVERT_LOOP

PRINT_LOOP:
    POP DX
    MOV AH, 02h
    INT 21h
    LOOP PRINT_LOOP
    
exit:
    mov ax, 4c00h
int 21h
END start
    
exit:
    mov ax, 4c00h
int 21h
END start
