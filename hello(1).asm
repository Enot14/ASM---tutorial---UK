_start:
    sub rsp, 40          ; Shadow space для виклику функцій

    ; Твої обчислення
    xor rax, rax         ; Обнуляємо RAX (тепер там 0)
    mov rax, 10          ; RAX = 10
    add rax, 5           ; RAX = 15
    sub rax, 2           ; RAX = 13

    ; Пауза (щоб встигнути побачити вікно)
    lea rcx, [rel pause_cmd]
    call system

    ; Готуємо код виходу
    mov rcx, rax         ; Переносимо результат (13) в RCX для ExitProcess
    call ExitProcess