model small
STACK 100h
DATASEG
; --------------------------
; Your variables here
; --------------------------
mask DB 0

CODESEG

printEven macro
    mov DL, "E"
    mov AH, 02h
    INT 21h
endm

printOdd macro 
    mov DL,'O'
    mov AH, 02h
    INT 21h
endm

print4 macro 
    mov DL, '4'
    mov AH, 02h
    INT 21h
endm

printN4 macro 
    mov DL, '5'
    mov AH, 02h
    INT 21h
endm

printN macro 
    mov DL, 'N'
    mov AH, 02h
    INT 21h
endm


start:
    mov ax, @data
    mov ds, ax
    ;CHECK ZUGI
    mov mask,01h
    mov ah, [ds:0000]
    and ah, [mask]
    jz zugi
    printOdd 
    jmp exit
zugi:
    printEven       
exit:
    mov ax, 4c00h
    int 21h
END start