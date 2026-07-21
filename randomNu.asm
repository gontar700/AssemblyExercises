IDEAL
MODEL   small
STACK   100h
DATASEG
    Clock       equ es:6Ch
    EndMessage  db 'Done',13,10,'$'
    SumMessage  db 'The sum is: ',13,10,'$'
    divisorTable    db 100,10,1
CODESEG
proc printNumber
; enter ? number in dx:ax
; exit ? printing the number
    push ax bx dx
    mov bx,offset divisorTable
nextDigit:
    xor ah,ah   ; dx:ax = number
    div [byte ptr bx]    ; al = quotient, ah = remainder
    add al,'0'    
    call printCharacter     ; Display the quotient
    mov al,ah   ; ah = remainder
    add bx,1        ; bx = address of next divisor
    cmp [byte ptr bx],1 ; Have all divisors been done?
    jne nextDigit
    ; handle the last digit
    add al,'0'
    call printCharacter     ; Display the quotient
mov ah,2
    mov dl,13
    int 21h
    mov dl,10
    int 21h 
    pop dx bx ax
    ret
endp printNumber
proc printCharacter
; enter ? character in al
; exit ? printing the character
    push ax dx
    mov ah,2
    mov dl, al
    int 21h
    pop dx ax
    ret
endp printCharacter
start:
    mov ax, @data
    mov ds, ax
    ; initialize
    mov ax, 40h
    mov es, ax
    mov cx, 10
    mov bx, 0
    xor dx, dx
RandLoop:
    ; generate random number, cx number of times
    mov ax, [Clock]         ; read timer counter
    mov ah, [byte cs:bx]    ; read one byte from memory
    xor al, ah          ; xor memory and counter
    and al, 00000111b       ; leave result between 0-7
    inc al                  ; add 1 to al so al will be between 1 and 8
    inc bx
    add dx , ax
    call printNumber
    loop RandLoop
    
        ; print sum message
    push dx
    mov dx, offset SumMessage
    mov ah, 9h
    int 21h
    pop dx
    mov ax, dx
    call printNumber
    mov     ax, 4c00h
    int     21h
    
    ; print exit message
    mov dx, offset EndMessage
    mov ah, 9h
    int 21h
exit:
END start

