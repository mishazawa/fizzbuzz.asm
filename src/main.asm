section .data
  iterations      dq      1000

section .bss

section .text
  global    main
  extern    fizzbuzz

main:
  push      rbp
  mov       rbp, rsp

  mov       rcx, [iterations]

loop_start:

  push      rcx               ; save counter
  mov       rdi, rcx          ; pass to fizzbuzz
  call      fizzbuzz          ; call function
  pop       rcx               ; restore counter

  dec       rcx               ; decrement counter
  jne       loop_start        ; loop 

  leave                       ; cleanup function

  ret