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
    
    mov ax, 0B800h
    mov es,ax
    
    mov bx, 2000
    mov cx, 10
    mov di, 160
print: 
    mov byte ptr es:[2000+di], 58h
    mov byte ptr es:[2000+di+1], 20h
    add di,160
    LOOP print

exit:
mov ax, 4c00h
int 21h
END start
