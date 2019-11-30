start:     
#start=demo33.exe#


.model small                            ;defines the memory model to be used for the ALP
.data                                   ;data segment begins here
        msg1 db 10d,13d,":::::::::::::::::::: MULTIPLAYER SHOOTING GAME::::::::::::::::::::::::::::::$"  
        msg2 db 10d,13d,"::                                                                         ::$"
        msg3 db 10d,13d,"::           PLAYER 1 :: UP = W  ::  DOWN = S  ::  SHOOT = SPACE           ::$"
        msg4 db 10d,13d,"::           PLAYER 2 :: UP = 8  ::  DOWN = 5  ::  SHOOT = 0               ::$"
        msg5 db 10d,13d,"::                                                                         ::$"
        msg6 db 10d,13d,"::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::$" 

.code                                   ;code segment begins here
        mov ax,@data                    ;moving base address of data to ax
        mov ds,ax                       ;moving contents of ax into ds
        lea dx,msg1                      ;load the offset address of msg
        mov ah,09h                      ;to display contents at dx                     
        int 21h                         ;call the kernel  
        
        lea dx,msg2
        mov ah,09h
        int 21h      
        
        lea dx,msg3
        mov ah,09h
        int 21h
        
        lea dx,msg4
        mov ah,09h
        int 21h
        
        lea dx,msg5
        mov ah,09h
        int 21h
        
        lea dx,msg6
        mov ah,09h
        int 21h
   printn
   printn 'INPUT:'



include 'emu8086.inc'

x1 db ?        ;player 1
x2 db ?        ;player 2
  
mov x1,0d
mov x2,0d 

;printn ':::::::::::::::::::: MULTIPLAYER SHOOTING GAME:::::::::::::::::::::::::::::::'
;printn '::                                                                         ::'
;printn '::           PLAYER 1 :: UP = W  ::  DOWN = S  ::  SHOOT = SPACE           ::'
;printn '::           PLAYER 2 :: UP = 8  ::  DOWN = 5  ::  SHOOT = 0               ::'
;printn '::                                                                         ::'
;printn ':::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::'


input:

; mov dh,x1     ;p1
;    mov dl,x2     ;p2   
     
     mov ax,0 
    in al,5
    mov si,ax
    
    mov ax,0
    in al,6
    mov di,ax 
    
     s77:
        mov ax,0 
        in al,5   
        inc al
        dec al
        jnz ne: 
            call clrscr   
            printn 'GAME OVER'
            printn 'RESULT OF THE MATCH : BLUE Killed RED'
            print   'LIFE OF BLUE       : '
            mov ax,di
            call print_num
            PRINTN
            print   'LIFE OF RED        : 0'
            
        ne:
        mov ax,0
        in al,6 
        inc al
        dec al 
         jnz neE:
            call clrscr   
            printn 'GAME OVER'
            printn 'RESULT OF THE MATCH : RED Killed BLUE'
            print   'LIFE OF RED       : '
            mov ax,SI
            call print_num
            PRINTN
            print   'LIFE OF BLUE       : 0'
        neE:
     
    mov ah,1
    int 21h  
    
    
    cmp al,77h ;w p1 up  
    jnz s1
        dec x1
        out 4,al
        jmp s7
        
    s1:
    cmp al,73h ;s p1 down
    jnz s2
        inc x1
        out 4,al
        jmp s7
    
    s2:
    cmp al,38h ;8 p2 up
    jnz s3
        dec x2
        out 4,al
        jmp s7
     
    s3:
    cmp al,35h ;5 p2 down
    jnz s4
        inc x2
        out 4,al   
        jmp s7
        
    
    s4:     ;space is pressed
        cmp al,20h
     ;   jz shoot1
        out 4,al
    
    s5:
        cmp al,30h
     ;   jz shoot2
        out 4,al
       
    s6:
        cmp al,72h
        jz start    
      ;   jmp input 
         
   
        
        
        
     
    s7:   
        mov cx,1d
        l:
        mov al,99d
        loop l
        out 4,al
        jmp input 


display:  
    
    mov dh,x1     ;p1
    mov dl,x2     ;p2   
    
      cmp dh,dl     ;p1-p2
;    js left
       
        pr:       ;p2 comes first      
            printn
            dec dh
            jnz pr
            
        print 'p1-->'
        jmp input
      
;    left:
 ;
  ;       sub dl,dh
   ;       ;p1 comes first
    ;    pl:
     ;       printn
  ;          dec dl
      ;      jnz pl
                 
       ; print '                  <--p2'
    
   ; same:
    ;    printn 'p1-->        <--p2'    
    jmp input:


shoot1:
    mov si,4
  ;  sh:
   ;     print '------'
    ;    dec si
     ;   jnz sh
    ;print '--->'    
            
     mov dh,x1     ;p1
    mov dl,x2     ;p2   
    cmp dh,dl
    jnz miss1 
        printn
        print 'p1 killed p2'
    hlt
    
shoot2:
     mov dh,x1     ;p1
    mov dl,x2     ;p2   
    cmp dh,dl
    jnz miss2
        printn
        print 'p2 killed p1'
    hlt                                                     
    
miss1:
miss2:

jmp input
         


hlt
clrscr:
;    mov bh,x1
 ;   mov bl,x2
  ;  cmp bh,bl
   ; js noo
    ;    mov ah,bl
     ;   jmp nooo
;    noo:
 ;       mov ah,bh
  ;  nooo:
    MOV AH, bl    ; Scroll up function
    XOR AL, AL     ; Clear entire screen
    XOR CX, CX     ; Upper left corner CH=row, CL=column
    MOV DX, 184FH  ; lower right corner DH=row, DL=column 
    MOV BH, 1Eh    ; YellowOnBlue
    INT 10H
ret  
            

define_print_num_uns  
define_print_num 

 