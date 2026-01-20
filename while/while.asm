[bits 64]

extern ExitProcess
extern GetStdHandle
extern WriteConsoleA

section .bss
    dummy resq 1

section .data
    msg_1 db "Calculating...", 13, 10
    msg_len_1 equ $ - msg_1
    msg_2 db "All done!", 13, 10
    msg_len_2 equ $ - msg_2


section .text
    global _start

_start:
    sub rsp, 40

    mov rcx, -11
    call GetStdHandle
    mov r12, rax

    mov r13, 0
    mov r14, 3
check_loop:
    cmp r13, r14
    je equal

    mov rcx, r12
    mov r8, msg_len_1
    lea rdx, [rel msg_1]
    lea r9, [rel dummy]
    mov qword [rsp + 32], 0
    call WriteConsoleA

    add r13, 1

    jmp check_loop
equal:
    mov rcx, r12
    mov r8, msg_len_2
    lea rdx, [rel msg_2] 
    lea r9, [rel dummy]
    mov qword [rsp + 32], 0
    
    call WriteConsoleA

    jmp finish

finish:
    xor rcx, rcx
    call ExitProcess