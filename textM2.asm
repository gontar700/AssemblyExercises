model small
STACK 100h
DATASEG
msg   DB 'Hello, this is a message!',13,10,'$';
CODESEG

printEven macro
    mov DL, 'E'
    mov AH, 02h
    INT 21h
endm

printOdd macro
    mov DL, 'O'
    mov AH, 02h
    INT 21h
endm

printMessage macro
    mov DX, offset msg
    mov AH, 09h
    INT 21h
endm

addressM macro
    mov ax, @data
    mov ds, ax
endm

start:
addressM

mov ax,0B800h
mov es,ax

;computer upper left screen
mov es:[140],43h
mov es:[141],01000001b
mov es:[142],6fh
mov es:[143],01000001b
mov es:[144],6dh
mov es:[145],01000001b  

;name center screen
mov byte ptr es:[2000],44h
mov es:[2001],20h  

mov byte ptr es:[2002],61h
mov es:[2003],55h

mov byte ptr es:[2004],6Eh
mov es:[2005],90h

mov byte ptr es:[2006],69h
mov es:[2007],20h 

mov byte ptr es:[2008],65h
mov es:[2009],55h

mov byte ptr es:[2010],6Ch
mov es:[2011],15h   
        
exit:
    mov ax, 4c00h
    int 21h
END start