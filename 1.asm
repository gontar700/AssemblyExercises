MODEL SMALL
STACK 100h
dataseg
timesToExecute db 1

codeseg
start: 
    mov cx,0
    again:
        mov dl, 'x'
        mov ah, 2h
        int 21h
    loop again

exit:
mov ax, 4c00h
int 21h
END start