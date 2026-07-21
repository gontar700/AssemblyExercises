ideal
model small
STACK 100h
DATASEG
; --------------------------
; Your variables here
; --------------------------
CODESEG
start:
    mov ax, @data
    mov ds, ax
    mov ah,1h
    mov al,0
    and ah,al
    
exit:
    mov ax, 4c00h
int 21h
END start
