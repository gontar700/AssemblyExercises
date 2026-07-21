model small
stack 100h



DATASEG
    x dB 48
    
    
CODESEG
MOV DL OFFSET X
MOV AH, 02h      ; function 02h = print character
INT 21h          ; call DOS interrupt
    
       
END start







 

