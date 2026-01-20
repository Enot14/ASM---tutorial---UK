[bits 64]

extern ExitProcess
extern WriteConsoleA
extern GetStdHandle

section .bss
    dummy resq 1

section .data
    num_char db '99 '
    len dq 3   
    num_1 db '0'
    win_msg db "Done!", 13, 10
    win_msg_len equ $ - win_msg

section .text
    global _start

_start:
    sub rsp, 40

    mov rcx, -11
    call GetStdHandle
    mov r12, rax

    mov r14, 100

check_loop:

    cmp r14, 0
    je finish

    mov rcx, r12
    lea rdx, [rel num_char]
    mov r8, [rel len]
    lea r9, [rel dummy]
    mov qword [rsp + 32], 0
    call WriteConsoleA

    cmp byte [rel num_char + 1], ' '
    je normal_dec

    cmp byte [rel num_char + 1], '0'
    je double_zero_dec


    dec byte [rel num_char + 1]
    dec r14
    jmp check_loop

double_zero_dec:
    cmp byte [rel num_char], '1'
    je ten_dec
    dec byte [rel num_char]
    mov byte [rel num_char + 1], '9'
    dec r14
    jmp check_loop
ten_dec:
    mov byte [rel num_char], ' '
    mov byte [rel num_char + 1], '9'
    dec r14
    dec qword [rel len]
    jmp check_loop
normal_dec:
    dec byte [rel num_char + 1]
    dec r14
    jmp check_loop
finish:
    mov rcx, r12
    lea rdx, [rel win_msg]
    mov r8, win_msg_len
    lea r9, [rel dummy]
    mov qword [rsp + 32], 0
    call WriteConsoleA
    
    add rsp, 40
    xor rcx, rcx
    call ExitProcess