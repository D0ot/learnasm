section .data

STDIN       equ 0
STDOUT      equ 1
STDERR      equ 2

SYS_EXIT    equ 0x01
SYS_FORK    equ 0x02
SYS_READ    equ 0x03
SYS_WRITE   equ 0x04
SYS_OPEN    equ 0x05

mystr db "Hello World",0xa,0x0

file_path db "elf",0x0

section .text
global _start
_start:
    ; emulate the there is a return address
    sub esp, 4 
    mov ebp, 0xdeafbeef
    push ebp
    mov ebp, esp
    sub esp, 4


    mov eax, 0x05
    mov ebx, file_path
    mov ecx, 0
    mov edx, 0
    int 0x80
    
    FILE_FD equ -4

    mov [ebp + FILE_FD], eax


    
    jmp exit




; eax : the string address
; ebx : the string length
; it will not affect registers
simple_puts:
    mov ecx, eax
    mov edx, ebx
    mov eax, 0x4
    mov ebx, STDOUT
    int 0x80
    ret

; eax : the null-terminated string's address
; return eax as length of string

asm_strlen:
    xor ecx, ecx
.loop:
    mov bl, [eax]
    cmp bl, 0
    je .ret
    inc ecx
    inc eax
    jmp .loop
.ret:
    mov eax, ecx
    ret
    
; eax : the null-terminated string's address
puts:
    push eax 
    call asm_strlen
    mov ebx, eax 
    pop eax
    call simple_puts
    ret

exit:
    mov eax,SYS_EXIT
    int 0x80