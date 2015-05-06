; CPU starts in "real mode"
; BIOS loads the bootloader into memory at 0x7C00
; Bootloader must be 512 bytes
; Bootloader must end with signature bytes: 0x55,0xAA

use16

org 0x7c00

boot:
    ; initialize segment registers
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    ; load rust code into 0x7e00 so we can jump to it later
    mov bx, 0x7e00  ; read buffer
    mov ah, 2   ; read
    mov al, 1   ; 1 sector at a time (512B)
    mov ch, 0   ; cylinder
    ;  Sector 1 is the first sector and contains this bootloader code (512 bytes). The Rust code starts at sector 2.
    mov cl, 2   ; sector
    mov dh, 0  ; head
    int 0x13
    jc error

    ; initialize stack
    mov sp, 0x7bfe

    jmp 0x7e00

error:
    mov si, .msg
.loop:
    lodsb
    or al, al
    jz .done
    mov ah, 0x0e
    int 0x10
    jmp .loop
.done:
    jmp $
    .msg db "rOSt: could not read disk", 0

times 510-($-$$) db 0
db 0x55
db 0xaa
