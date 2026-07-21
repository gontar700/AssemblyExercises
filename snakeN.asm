model small
stack 100h



DATASEG
    x dw 160
    y dw 100
    color dw 4h
    len db 15
    borderColor dw 0Eh    ; yellow
    tmpX        dw ?
    tmpY        dw ?
   
    
    
CODESEG
include snakep.asm


setDS macro
    mov ax, @data
    mov ds, ax
endm
textmode macro
    mov ax,3h
    int 10h  
endm
; graphic mode
graphicm macro
    mov ax,13h
    int 10h
endm
wait4key macro
   mov ah,00h
    int 16h
endm

moveRight proc
    add [x], 5
ret
endp

moveLeft proc
    sub [x], 5
ret
endp 

moveUp proc
    sub [y], 5
ret
endp

moveDown proc
    add [y], 5
ret
endp




start:
    setDS
    graphicm
    call drawBorder
    call drawSquare
loopg:
mov ah, 0
        int 16h
        cmp ah, 4Dh          ; right arrow scan code
        je move_right
        cmp ah, 4Bh          ; left arrow scan code
        je move_left
        cmp ah, 48h          ; up arrow scan code
        je move_up
        cmp ah, 50h          ; down arrow scan code
        je move_down
        cmp ah, 01h
        jmp exit    
    move_right:
        call eraseSquare
        call moveRight
        call drawSquare
        jmp loopg
        
    move_left:
        call eraseSquare
        call moveLeft
        call drawSquare
        jmp loopg
        
    move_up: 
        call eraseSquare
        call moveUp
        call drawSquare
        jmp loopg
    move_down: 
        call eraseSquare
        call moveDown
        call drawSquare
        jmp loopg
exit:
    mov ax, 4c00h
    int 21h
    
       
END start







 

