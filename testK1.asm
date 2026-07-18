IDEAL
MODEL small
STACK 100h
DATASEG
    quit_msg db 10,13,'Exiting...$'
CODESEG
macro a
    mov ah, 1
    int 21h
    cmp al,61h ; 61h
endm
start:
    mov ax, @data
    mov ds, ax
input_loop: ; get input from the user
    a
    jne input_loop
;print exit msg
    mov dx,offset quit_msg
    mov ah,9h
    int 21h
    
exit:
    mov ax, 4c00h
    int 21h
END start
