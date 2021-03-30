.586P
.model flat,stdcall

includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\user32.lib

extern ExitProcess@4:near
extern GetStdHandle@4:near
extern CloseHandle@4:near
extern lstrlenA@4:near
extern WriteConsoleA@20:near
extern ReadConsoleA@20:near

_DATA SEGMENT

    hin dd 0 
    hout dd 0
    sz1 db "Initial data: ",0,255 dup(0)
    sz2 db "Result data:  ",0,255 dup(0)
    cnt dd 0
    szBuffer db 32 dup(0)
    var dd 0
    ;-------МАСИВ-------
    array db 00110110b, 01101101b, 01111111b, 10111110b
    num dd 4
    ;-------------------

_DATA ENDS

_TEXT SEGMENT
START:

    push -10
    call GetStdHandle@4
    mov hin,eax
    
    push -11
    call GetStdHandle@4
    mov hout,eax

    mov eax,num
    mov var,eax
    
    push offset sz1
    call lstrlenA@4
    
    mov ebx, offset sz1
    add ebx, eax
    mov edx, offset array

_loop3:
    mov ecx,8
    mov al, byte ptr[edx]
    inc edx
    _loop2:
        test al,al
        js _s
        mov byte ptr[ebx],'0'
        jmp _ns
    _s:
        mov byte ptr[ebx],'1'
    _ns:
        shl al,1
        inc ebx
        loop _loop2
    mov byte ptr[ebx],' '
    inc ebx
    dec var
    jnz _loop3

    mov byte ptr[ebx],13
    mov byte ptr[ebx+1],10
    mov byte ptr[ebx+2],0

    push offset sz1
    call lstrlenA@4

    push 0
    push offset cnt
    push eax
    push offset sz1
    push [hout]
    call WriteConsoleA@20
    
;------ОСНОВНОЙ КОД------

    mov ebx,offset array
    mov eax,0
    mov ecx,num
    
_loop1:
    mov al,byte ptr[ebx]
    
    test al,al
    jp _p
    sar al,1 
    jmp _np
_p:
    shl al,1
_np:

    mov byte ptr[ebx],al
    inc ebx
    loop _loop1

;------------------------

    mov eax,num
    mov var,eax
    
    push offset sz2
    call lstrlenA@4
    
    mov ebx, offset sz2
    add ebx, eax
    mov edx, offset array

_loop5:
    mov ecx,8
    mov al, byte ptr[edx]
    inc edx
    _loop4:
        test al,al
        js _s2
        mov byte ptr[ebx],'0'
        jmp _ns2
    _s2:
        mov byte ptr[ebx],'1'
    _ns2:
        shl al,1
        inc ebx
        loop _loop4
    mov byte ptr[ebx],' '
    inc ebx
    dec var
    jnz _loop5

    mov byte ptr[ebx],13
    mov byte ptr[ebx+1],10
    mov byte ptr[ebx+2],0

    push offset sz2
    call lstrlenA@4

    push 0
    push offset cnt
    push eax
    push offset sz2
    push [hout]
    call WriteConsoleA@20


    push 0
    push offset cnt
    push 32
    push offset szBuffer
    push [hin]
    call ReadConsoleA@20

    push hin
    call CloseHandle@4
    
    push hout
    call CloseHandle@4

    push 0
    call ExitProcess@4

_TEXT ENDS

END START
