[bits 64]

extern ExitProcess
extern GetStdHandle
extern WriteConsoleA
extern Sleep

section .bss
    dummy resq 1

section .data
    msg_try db "Trying to swith collor...", 13, 10
    msg_try_len equ $ - msg_try
    msg_done db "Done!", 13, 10
    msg_done_len equ $ - msg_done
    msg_allready db "Key allready working!", 13, 10
    msg_allready_len equ $ - msg_allready
    msg_successull db "everything is working successfully!", 13, 10
    msg_successull_len equ $ - msg_successull

section .text
    global _start

_start:
    sub rsp, 40

    mov rcx, -11
    call GetStdHandle
    mov r12, rax

    mov rbx, 1   ;координата клавіші(q)
    ; клавіші повинн підсвічуватись від q - \
    mov r15, 1  ;клавіша вимкнута

    mov r14, 8
check_loop:
    cmp r14, 0
    je finish

    test r15, rbx
    jnz pass

    mov rcx, r12
    lea rdx, [rel msg_try]
    mov r8, msg_try_len
    lea r9, [rel dummy]
    mov qword [rsp + 32], 0
    call WriteConsoleA

    mov rcx, 2500
    call Sleep

    or r15, rbx

    mov rcx, r12
    lea rdx, [rel msg_done]
    mov r8, msg_done_len
    lea r9, [rel dummy]
    mov qword [rsp + 32], 0
    call WriteConsoleA
    dec r14
    shl rbx, 1
    ;jmp finish
    jmp check_loop 
pass:
    mov rcx, r12
    lea rdx, [rel msg_allready]
    mov r8, msg_allready_len
    lea r9, [rel dummy]
    mov qword [rsp + 32], 0
    call WriteConsoleA
    shl rbx, 1
    dec r14
    mov rcx, 1000
    call Sleep
    jmp check_loop
finish:
    mov rcx, r12
    lea rdx, [rel msg_successull]
    mov r8, msg_successull_len
    lea r9, [rel dummy]
    mov qword [rsp + 32], 0
    call WriteConsoleA
    
    add rsp, 40
    xor rcx, rcx
    call ExitProcess