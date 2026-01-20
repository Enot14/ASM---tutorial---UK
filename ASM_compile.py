import os
def format(file_name, file_to_work_with_asm, current_path):
    if os.path.exists(file_to_work_with_asm):
        print('formating...')
        os.system(f'nasm -f win64 {file_name}.asm -o {file_name}.obj')
        print(f'done, file {file_name}.obj ready.')
        print(f'path to file > {current_path + file_name}')
    else:
        print(f'[!] Error: path > {file_to_work_with_asm} <- dont exists.')

def link(file_name, file_to_work_with_obj, current_path):
    if os.path.exists(file_to_work_with_obj):
        print('linkilng...')
        os.system(f'ld {file_name}.obj -o {file_name}.exe -lkernel32')
        print(f'done, file {file_name}.exe ready.')
        print(f'path to file > {current_path + file_name}')
    else:
        print(f'[!] Error: path > {file_to_work_with_obj} <- dont exists.')

def avaible_commands():
    cmds = ['format - format .asm file to .obj file',
            'link - linking .obj file to .exe file',
            'run - runs assembly programm in shell',
            'full - format + link + run',
            'cd - change dir',
            'clear - clening console/terminal',
            'exit - close programm',
            'list - shows files/dirs in current directory',]
    for c in cmds:
        print('#' + c)

def run(file_name, file_to_work_with_exe):
    if os.path.exists(file_to_work_with_exe):
        print(f'starting {file_name}.exe...\nout >>>')
        os.system(f'.\\{file_name}')
    else:
        print(f'[!] Error: file with path > {file_to_work_with_exe} <- dont exists')
def clear_console():
    os.system('cls')

def change_dir(current_path):
    new_path = input('enter new path > ')
    if os.path.exists(new_path):
        os.chdir(new_path)
        print(f'new path > {new_path}')
    else:
        print('[!] Error: this path is dont exists')
    
def list(current_path):
    for file in os.listdir(current_path):
        print(file)

def main():
    print('#############################################################')
    print('################ ASM COMPILER, CREATOR: ENOT ################')
    print('################ AVAIBLE COMMANDS: ##########################')
    avaible_commands()
    print('#############################################################')
    file_name = input('enter file name to work > ') 
    while True:
        script_dir = os.path.dirname(os.path.abspath(__file__))
        os.chdir(script_dir)
        current_path = os.getcwd()
        file_to_work_with_asm = os.path.join(current_path, file_name + '.asm')
        file_to_work_with_obj = os.path.join(current_path, file_name + '.obj')
        file_to_work_with_exe = os.path.join(current_path, file_name + '.exe')
        if not os.path.exists(file_to_work_with_asm):
            print(f'\n[!] Error: {file_name}.asm not found in {current_path}')
            file_name = input('Enter correct file name (or "exit") > ')
            if file_name == 'exit': break
            continue
        print(f'\ncurrent path > {current_path} | target > {file_name}.asm')
        user_void = input('>>> ').strip().lower()
        if user_void == 'exit':
            break
        elif user_void == 'format':
            format(file_name, file_to_work_with_asm, current_path)
        elif user_void == 'link':
            link(file_name, file_to_work_with_obj, current_path)
        elif user_void == 'run':
            run(file_name, file_to_work_with_exe)
        elif user_void == 'full':
            format(file_name, file_to_work_with_asm, current_path)
            link(file_name, file_to_work_with_obj, current_path)
            run(file_name, file_to_work_with_exe)
        elif user_void == 'cd':
            change_dir(current_path)
        elif user_void == 'list':
            list(current_path)
        elif user_void == 'clear':
            clear_console()
        elif user_void == 'change file':
            file_name = input('enter new file name > ')
        elif user_void == 'help':
            avaible_commands()
    
if __name__ == "__main__":
    main()