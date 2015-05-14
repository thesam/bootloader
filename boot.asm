; En bootladdare måste sluta med 0x55,0xaa
; En bootladdare måste vara 512 bytes
; Sector 1: Bootladdare
; Sector 2: Operativsystemet
; Bootladdaren laddas in till 0x7c00

org 0x7c00

mov bx, 0x8000 ; mål
mov ah, 2 ; 2 = read from disk
mov al, 1 ; 1 = antal sektorer att läsa
mov ch, 0 ; cylinder
mov cl, 2 ; sector 2 (se ovan)
mov dh, 0 ; head
int 13h ; Anropa BIOS via interrupt

jmp 0x8000

times 510-($-$$) db 0
db 0x55
db 0xaa
