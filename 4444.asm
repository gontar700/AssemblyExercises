model small
STACK 20h
DATASEG
    str1 db 'Hello World!!!$'
    str2 db 20; array 20 cells definition


CODESEG
start:

    mov ax, @data
    mov ds, ax

    lea si,str1; load effective address of str1
    lea di, str2; load effective address of str2
again:
    mov al,[si] ; copies one byte each time
    mov [di], al
    inc si
    inc di
cmp al,'$';
jne again

lea dx, str2;
mov AH, 09H
INT 21H

exit:
    mov ax, 4c00h
    int 21h
END start