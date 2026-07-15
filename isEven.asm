model small
stack 100h
dataseg
numTocheck db 00001011b
mask db 00000001b
evenMsg db 'This number is EVEN! Have a nice day.$'
oddMsg db 'This number is ODD! Have a nice day.$'
codeseg
start:
clean_screen:
    mov ax, 0600h      ; AH=06 (scroll up), AL=00 (clear entire screen)
    mov bh, 07h        ; attribute (white on black)
    mov cx, 0000h      ; top-left corner
    mov dx, 184Fh      ; bottom-right corner (row 24, col 79)
    int 10h

xor dx,dx
mov ah,numTocheck
mov bh, mask
AND ah,bh
jnz odd
zugi:
mov dx,offset evenMsg
mov ah,9h
int 21h
jmp exit
odd:
mov dx, offset oddMsg     
mov ah,9h
int 21h
exit:
mov ax, 4c00h
int 21h
END start
