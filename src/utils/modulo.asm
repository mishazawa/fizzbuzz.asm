section .text
  global    modulo

; modulo (rdi, rsi) -> rax
modulo:
  push      rbp
  mov       rbp, rsp

  xor       rdx, rdx

  mov       rax, rdi      ; set a
  mov       rbx, rsi      ; set b
  div       rbx           ; a/b

  mov       rax, rdx      ; return argument
  
  leave
  ret