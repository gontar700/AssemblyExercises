setDS macro
    mov ax, @data
    mov ds, ax
endm

graphicMode macro
    mov ax,13h
    int 10h
endm

textMode macro
    mov ax, 03h
    int 10h
endm

quitGame macro
    mov ax,4c00h
    int 21h
endm



MODEL small
STACK 100h
DATASEG
    x DW 150
    y DW 90
    color DB 4
    len DB 20
CODESEG

drawPixel proc
    push ax bx cx dx
    mov cx, [x]
    mov dx, [y]
    mov al, [color]
    mov ah, 0ch
    int 10h
    pop dx cx bx ax
    mov ah, 0
    int 16h
    ret
drawPixel endp

drawLine proc
    push ax bx cx dx
    mov dl,[len]
    draw:
       mov cx, 234
       mov bx, [y]
       inc [x]
       call drawPixel
       dec dl
       jnz draw
ret
drawLine endp

start:
    setDS
    graphicMode
    CALL drawLine
 
exit:
    textMode
    quitGame
END start