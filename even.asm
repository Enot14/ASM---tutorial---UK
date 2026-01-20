[bits 64]

extern ExitProcess
extern WriteConsoleA
extern GetStdHandle

section .bss
    dummy resq 1

section .data
    msg_even db "even", 13, 10
    msg_even_len equ $ - msg_even
    msg_odd db "odd", 13, 10
    msg_odd_len equ $ - msg_odd

section .text
    global _start

_start:
    sub rsp, 40

    mov rcx, -11
    call GetStdHandle
    mov r12, rax

    ;Парне число (наприклад, 2, 4, 8, 202) — останній біт завжди 0.
    ;Непарне число (наприклад, 1, 3, 5, 203) — останній біт завжди 1.
    mov al, 200
    or al, 1    ;якщо останній біт числа = 0, то воно замінює його на 1, щоб число було непарним - 202 -> 203. 1001110 -> 1001111
    ; or з 1 вимикає біт, а з нулем нічого не робить, як додавання до 0
    ;якщо число непарне, то воно просто не змінює останній його біть, якщо останній біт = 1, тобто число НЕпарне, то функція просто не використовується
    ;and al, 1 ; порівняння останнього біту, якщо 0 - парне, 1 - не парне
    test al, 1
    jz even ; Jump if zero

    mov rcx, r12
    lea rdx, [rel msg_odd]
    mov r8, msg_odd_len
    lea r9, [rel dummy]
    mov qword [rsp + 32], 0
    call WriteConsoleA
    jmp finish
even:
    mov rcx, r12
    lea rdx, [rel msg_even]
    mov r8, msg_even_len
    lea r9, [rel dummy]
    mov qword [rsp + 32], 0
    call WriteConsoleA
    jmp finish
finish:
    add rsp, 40
    xor rcx, rcx
    call ExitProcess