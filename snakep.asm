eraseSquare proc
    push [color]
    push [x]
    push [y]
    mov ax,0
    mov [color],ax
    call drawSquare
    pop [y]
    pop [x]
    pop [color]
    ret
endp eraseSquare 

drawPixel proc
    push ax cx dx 
    mov ax, [color]
    mov cx,[x]
    mov dx,[y]
    mov ah,0ch
    int 10h
    pop dx cx ax
ret
endp drawPixel

drawLine proc
    push cx 
    push [x]
    mov cl,[len]
    mov ch,0h
    again:
        call drawPixel
        dec[x]
    loop again
    pop [x] 
    pop cx
    ret 
endp drawLine

drawSquare proc
    push [y] 
    push cx
    mov cl,[len]
    mov ch, 0h
again2:
    call drawLine
    dec [y]
    loop again2
    pop cx 
    pop [y]
ret
endp drawSquare

drawBorder proc
    push ax
    push bx
    push [color]
    push [x]
    push [y]

    mov ax, [borderColor]
    mov [color], ax

    ; top row
    mov [y], 0
    mov [x], 0
top_loop:
    call drawPixel
    inc [x]
    cmp [x], 320
    jl top_loop

    ; bottom row
    mov [y], 199
    mov [x], 0
bottom_loop:
    call drawPixel
    inc [x]
    cmp [x], 320
    jl bottom_loop

    ; left column
    mov [x], 0
    mov [y], 0
left_loop:
    call drawPixel
    inc [y]
    cmp [y], 200
    jl left_loop

    ; right column
    mov [x], 319
    mov [y], 0
right_loop:
    call drawPixel
    inc [y]
    cmp [y], 200
    jl right_loop

    pop [y]
    pop [x]
    pop [color]
    pop bx
    pop ax
    ret
endp drawBorder