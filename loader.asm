; Every x86 CPU starts in "real mode"
; BIOS loads the bootloader into memory at 0x7C00
; Bootloader must be 512 bytes
; Bootloader must end with signature bytes: 0x55,0xAA

use16

org 0x7c00

boot:
    mov bx, 0x8000  ; read buffer
    mov ah, 2   ; read
    mov al, 1   ; 1 sector at a time (512B)
    mov ch, 0   ; cylinder
    mov cl, 2   ; sector
    mov dh, 0  ; head
    int 0x13

    jmp 0x8000

times 510-($-$$) db 0
db 0x55
db 0xaa
