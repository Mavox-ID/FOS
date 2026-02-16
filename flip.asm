[BITS 16]
[ORG 0x7C00]

start:
    cli
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7C00
    sti

    mov ax, 0x0013
    int 0x10

    mov ax, 0xA000
    mov es, ax

main_loop:
    xor di, di

draw_pixels:
    mov ax, [seed]
    mov cx, 32749
    mul cx
    add ax, 7
    
    in al, 0x40
    xor ah, al
    mov [seed], ax

    mov [es:di], al
    
    inc di
    cmp di, 64000
    jne draw_pixels

check_keyboard:
    mov ah, 0x01
    int 0x16
    jz wait_delay
    
    mov ah, 0x00
    int 0x16

    cmp al, '+'
    je increase_speed
    cmp al, '='       
    je increase_speed
    cmp al, '-'
    je decrease_speed
    jmp wait_delay

increase_speed:
    cmp word [current_delay], 0
    je wait_delay
    sub word [current_delay], 100
    jmp wait_delay

decrease_speed:
    cmp word [current_delay], 4000
    jae freeze_screen
    add word [current_delay], 100
    jmp wait_delay

freeze_screen:
    mov word [current_delay], 4000
frozen_loop:
    mov ah, 0x00
    int 0x16
    cmp al, '+'
    je increase_speed
    cmp al, '='
    je increase_speed
    jmp frozen_loop

wait_delay:
    mov cx, [current_delay]
    jcxz main_loop
delay_loop:
    in al, 0x40
    loop delay_loop

    jmp main_loop

seed: dw 0x1337
current_delay: dw 1000

times 510-($-$$) db 0
dw 0xAA55
