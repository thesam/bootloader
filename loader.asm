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
    jc error

    jmp 0x8000

error:
    mov si, .msg
.loop:
    lodsb
    or al, al
    jz .done
    mov ah, 0x0e
    ; TODO: ah to print string instead?
    int 0x10
    jmp .loop
.done:
    jmp $
    .msg db "Error: could not read disk", 0

times 510-($-$$) db 0
db 0x55
db 0xaa
