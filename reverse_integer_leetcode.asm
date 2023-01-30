%include "io.inc"

   
section .text
global CMAIN


; leetcode medium exercise in NASM assembly

; reverses the digits of a signed 32 bit integer in eax
; the negative sign gets ignored

CMAIN:
    mov ebp, esp; for correct debugging
    
    mov eax, 1534236469 ; test number
    push ebx
    push ecx
    push edx
    
    ; reverse the integer in eax
    
    xor ecx, ecx
    xor edx, edx
    mov ebx, 10
    
    cmp eax, 0
    jge else
    
    ifnegative:
        neg eax
        push dword 1
        mov ebp, esp
        jmp unroll
    else:
        push dword 0
        mov ebp, esp

    
    unroll:
        cmp eax, 0
        je reverse
        idiv ebx
        push edx
        xor edx, edx
        inc ecx
        jmp unroll
    
    
    reverse: 
        dec ecx  
        imul ebx
        cmp eax, 214748364
        jg set_zero
        
        mov edx, [esp + 4 * ecx]
        add edx, 214748364
        jo set_zero
        add eax, [esp + 4 * ecx]
        cmp ecx, 0
        jg reverse
    
    mov esp, ebp
    
    pop ebx ;negative flag
    
    cmp ebx, 0
    je cleanup
    neg eax ;else negate

    cleanup:
    
    pop edx
    pop ecx
    pop ebx
    ret 
    
    ; just gotta check it with gdb because 
    ; I haven't figured out how to do hello world on windows yet
        
    set_zero:
        xor eax, eax
        mov esp, ebp
        add esp, 4
        jmp cleanup

    