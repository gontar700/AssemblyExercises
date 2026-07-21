IDEAL
MODEL   small
STACK   100h
DATASEG
    Clock       equ es:6Ch
    EndMessage  db 'Done',13,10,'$'
    SumMessage  db 'The sum is: ',13,10,'$'
    divisorTable    db 100,10,1
    HouseText   db 'Fistuks house$'
CODESEG
proc sky
; enter ? no parameters
; exit ? create square  at specific location
    mov ah,06h
    xor al,al       ; full screen ? no scrolled line
    mov bh,00110000b    ; blue
    mov ch, 0  ; top row 
    mov cl, 0  ; left column
    mov dh, 14   ; bottomrow
    mov dl, 80; ; rigth column
    int 10h
    ret
    
endp sky
proc lowerP
; enter ? no parameters
; exit ? create square  at specific location
    mov ah,06h
    xor al,al       ; full screen ? no scrolled line
    mov bh,01100000b    ; white
    mov ch, 15  ; top row
    mov cl, 0  ; left column
    mov dh, 80   ; bottom row
    mov dl, 80; ; left column
    int 10h
    ret
endp lowerP
proc walls
; enter ? no parameters
; exit ? create square  at specific location
    mov ah,06h
    xor al,al       ; full screen ? no scrolled line
    mov bh,01110000b    ; white
    mov ch, 15  ; top row
    mov cl, 20  ; left column
    mov dh, 24   ;bottom row
    mov dl, 60; ; right column
    int 10h
    ret
    endp walls
proc roof
    mov ah, 06h
    xor al, al
    mov bh, 01000000b

    mov ch, 12
    mov cl, 20
    mov dh, 14
    mov dl, 60
    int 10h

    mov si, 2
again:
    sub ch, 3
    add cl, 4
    sub dh, 3
    sub dl, 4

    mov ah, 06h        ; <-- re-set before every call inside the loop
    xor al, al          ; <-- re-set before every call inside the loop
    mov bh, 01000000b     ; <-- re-set too, just to be safe (some BIOS calls can clobber bh as well)

    int 10h

    dec si
    cmp si, 0
    jne again
    ret
endp roof

proc wind1
    mov ah,06h
    xor al,al       ; full screen ? no scrolled line
    mov bh,01001000b    
    mov ch, 17  ; top row
    mov cl, 23  ; left column
    mov dh, 20   ;bottom row
    mov dl, 28; ; right column
    int 10h
    ret    
    endp wind1
proc wind2
    mov ah,06h
    xor al,al       ; full screen ? no scrolled line
    mov bh,01001000b    
    mov ch, 17  ; top row
    mov cl, 52  ; left column
    mov dh, 20   ;bottom row
    mov dl, 57 ; right column
    int 10h
    ret     
    endp wind2
    
    proc houseText
    mov ah, 02h        ; set cursor position
    mov bh, 0            ; video page 0
    mov dh, 19             ; row ? roughly middle of the wall (15 to 24)
    mov dl, 26              ; column ? just inside the wall's left edge (20 to 60)
    int 10h

    mov dx, offset HouseText
    mov ah, 09h          ; print string ($-terminated)
    int 21h
    ret
    endp houseText
    
    
start: 
    mov ax, @data
    mov ds, ax
    call sky
    call lowerP
    call walls
    call roof
    call wind1
    call wind2
    call houseText

    ; wait for a keypress before exiting, so the drawing stays visible
    mov ah, 01h
    int 21h

    mov ax, 4c00h
    int 21h
exit:
END start

