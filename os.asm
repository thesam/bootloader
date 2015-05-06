use16

org 0x7e00

main:
    xor ax, ax
    mov ah, 6
    mov al, 0
    xor bx, bx
    mov bh, 1fh
    xor cx, cx
    mov dx, 184fh
    int 10h

    xor ax, ax
    mov ah, 2
    xor bx, bx
    xor dx, dx
    int 10h

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

.msg db "This is the operating system!", 0
