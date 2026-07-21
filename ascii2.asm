ideal
model small
stack 100h

DATASEG
    x dB 65

CODESEG
start:
    mov ax, @data
    mov ds, ax

    MOV DL, x         ; load the value stored at x (not its address)
    MOV AH, 02h       ; function 02h = print character
    INT 21h           ; call DOS interrupt

    mov ah, 4Ch       ; (optional but good practice) exit to DOS
    int 21h

END start