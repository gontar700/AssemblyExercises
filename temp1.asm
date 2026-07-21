MODEL small
STACK 100h

DATASEG
    x DB 42

CODESEG

start:
    mov ax, @data
    mov ds, ax

    mov al, [x]        ; AL = 42 (the number we want to print as TEXT)
    mov ah, 0            ; clear AH so AX holds the full value correctly
    mov bx, 10           ; divisor for splitting into digits

    xor cx, cx           ; CX = digit counter, starts at 0

splitDigits:
    xor dx, dx            ; clear DX before DIV (important! DIV uses DX:AX as dividend)
    div bx                  ; AX / 10 ? AX = quotient, DX = remainder (the digit)
    push dx                  ; save this digit on the stack
    inc cx                    ; count how many digits we pushed
    cmp ax, 0
    jne splitDigits            ; keep dividing until quotient becomes 0

printDigits:
    pop dx                       ; pop digits back off (reverses the order ? MSB first!)
    add dl, '0'                    ; convert 0-9 into ASCII character '0'-'9'
    mov ah, 02h                     ; DOS function: print single character
    int 21h
    dec cx
    jnz printDigits

exit:
    mov ax, 4c00h
    int 21h

END start
