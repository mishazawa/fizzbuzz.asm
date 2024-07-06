section .data
  number          db      "%d",          10, 0
  fizz            db      "%d Fizz",     10, 0
  buzz            db      "%d Buzz",     10, 0
  fizzBuzz        db      "%d FizzBuzz", 10, 0
  
  MATCH_FB        dq      15
  MATCH_F         dq      3
  MATCH_B         dq      5

section .bss

section .text
  global    fizzbuzz
  extern    printf
  extern    modulo

; fizzbuzz (rdi) -> void
fizzbuzz:
  push    rbp
  mov     rbp, rsp

  push    rdi                   ; store current value for later

  ; CHECK FIZZ BUZZ

  mov     rdi, [rsp]            ; set rdi (for consistency)
  mov     rsi, [MATCH_FB]
  mov     rdx, fizzBuzz         ; set message for print
  call    check_value

  cmp     rax, 0
  je      exit_fizzbuzz         ; early return prevent double check

  ; CHECK FIZZ

  mov     rdi, [rsp]            ; set rdi (for consistency)
  mov     rsi, [MATCH_F]
  mov     rdx, fizz             ; set message for print
  call    check_value

  cmp     rax, 0
  je      exit_fizzbuzz

  ; CHECK BUZZ

  mov     rdi, [rsp]            ; set rdi (for consistency)
  mov     rsi, [MATCH_B]
  mov     rdx, buzz             ; set message for print
  call    check_value

  
  cmp     rax, 0
  je      exit_fizzbuzz          ; early return

  ; NO MATCH PRINT NUMBER

  mov     rsi, [rsp]             ; set value for print
  mov     rdi, number            ; set default message
  xor     rax, rax
  call    printf

exit_fizzbuzz:
  pop     rdi

  add     rsp, -16

  leave
  ret

; check_val(n: rdi, fb: rsi, mess: rdx) -> rax
check_value:
  push    rbp
  mov     rbp, rsp

  push    rdx                    ; save template
  
  call    modulo
  
  pop     rdx                    ; restore template
  
  cmp     rax, 0
  jne     not_match              ; early return

  mov     rsi, rdi               ; set value for print
  mov     rdi, rdx               ; set message for print
  xor     rax, rax
  call    printf
  
  add     rsp, -16               ; align stack ?
  mov     rax, 0                 ; return 0 

not_match:
  leave
  ret