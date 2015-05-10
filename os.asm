use16

org 0x8000

main:
    call clear_screen

    xor dx, dx
    mov dh, 0
    call move_cursor


    mov si, msg
    call print_string

    xor dx, dx
    mov dh, 1
    call move_cursor

    mov si, prompt
    call print_string

    jmp $

move_cursor: ; dh=row
  mov al, 0
  mov ah, 2
  xor bx, bx
  int 10h
  ret

clear_screen:
  xor ax, ax
  mov ah, 6
  mov al, 0
  xor bx, bx
  mov bh, 1fh
  xor cx, cx
  mov dx, 184fh
  int 10h ; Scroll screen
  ret

print_string: ; si = string to print
.loop:
    lodsb
    or al, al
    jz .done
    mov ah, 0x0e
    int 0x10  ; Print character
    jmp .loop
.done:
  ret

msg db "This is the operating system!", 0
prompt db "$ ", 0
