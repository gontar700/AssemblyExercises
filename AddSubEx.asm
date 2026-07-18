model small
STACK 100h
DATASEG

arr db 0AAh, 2, 3, 4, 5, 6, 7, 8, 11, 12

CODESEG
start:
    mov ax, @data
    mov ds, ax

    mov cx, 5
    mov ah, 0
    mov si, 0
addarray:
    add ah, [arr + si]
    add si, 2
    loop addarray
    ; AH now holds the sum (34)

    mov al, ah        ; move sum into AL
    xor ah, ah        ; clear AH, so AX correctly = sum
    mov bl, 10        ; divisor = 10
    mov cx, 0         ; digit counter

convert:
    xor ah, ah        ; clear AH before each division
    div bl            ; AL = AX/10 (quotient), AH = remainder (digit)
    push ax           ; save digit (in AH) on stack
    inc cx
    cmp al, 0
    jne convert

print_loop:
    pop ax            ; restore digit into AH
    mov dl, ah
    add dl, '0'       ; convert to ASCII
    mov ah, 02h
    int 21h
    loop print_loop

exit:
    mov ax, 4c00h
    int 21h
END start