IDEAL  
MODEL small 
STACK 100h
DATASEG
; --------------------------
; Your variables here
; --------------------------
CODESEG
start:
    mov ax, @data
    mov ds, ax
    mov SI, 400h
    mov AX , [SI]
    MOV SI, 1300H
    MOV DI, 1200H
    MOV [SI], ax
    MOV [DI], ax                               
exit:
    mov ax, 4c00h
int 21h
END start
