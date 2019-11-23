; AddTwo.asm - adds two 32-bit integers.
; Chapter 3 example
INCLUDE Irvine32.inc

.data
op byte "************************************Welcome To Parking Management System************************************",0
op1 byte "*******************************************Login as Admininstrator*********************************************",0
op2 byte "Enter UserName: ",0
op3 byte "Enter Password: ",0

op4 byte "Press 1 for Parking In ",0
op5 byte "Press 2 for Parking Out ",0

op6 byte '*****************MENU*********************$'
op7 byte "Press 1 for bikes",0
opt7 byte "Enter vehical No.",0
opt8 byte "Enter date in.",0
opt9 byte "Enter date out",0
;op7 byte "Press 1 for bike",0
op8 byte "Press 2 for cars",0
op9 byte "Press 3 for van",0
op10 byte "Press 4 to show the record",0
op11 byte "Press 5 to delete the record",0
op12 byte "Press 6 to exit",0
msg1 db "Parking Is Full.",0
msg2 db "Wrong input.",0
msg3 db "car.",0
msg4 db "bus. ",0
msg5 db "record",0
msg6 db "there is more space: ",0
msg7 db "the total amount is: ",0
msg8 db "the total numbers of vehicles parked: ",0
msg9 db "the total number of bikes parked: ",0
msg10 db "the total number of cars parked: ",0
msg11 db "the total number of vans parked ",0
msg12 db "***Record deleted successfully***",0
msg13 db "Wrong Password Enter Again",0
msg14 db "Successfully Login ",0

tvacy dword 50
tamount dword 0
tcount dword  0
am1 dword ?
am2 dword ?
am3 dword ?
select dword ?
password byte 20 dup(?)
username byte 20 dup(?)

storage dword 150 dup(?) 

passfile byte "password.txt",0 
fhandler dword ?

tempuser byte ?
temppass byte ?
;tempo    byte 6 DUP(?)                                                     ;Array to store read files


.code

main proc

call crlf
mov edx,offset op                         
call writestring                            ;------To Write 
call crlf                                   ;      welcm msg-----
call crlf

call crlf
mov edx,offset op1                         
call writestring                            ;------To Write 
call crlf                                   ;      Login msg-----
call crlf

jmp goout									;in order to avoid the running of wrong tag 

wrong:                                      ;in case if password is wrong

mov edx, offset msg13
call writestring							;to show the msg of wrong input
call crlf
jmp goout 

goout:

mov edx,offset op2                      
call writestring                            ;------To Write Enter user name msg-----

mov edx,offset username
mov ecx, sizeof username
call readString  							; Enter user name
call crlf  

;mov edx,offset username
;call writestring                            ;username output
        

mov edx,offset op3                      
call writestring                            ;------To Write Enter password msg-----

mov edx,offset password
mov ecx, sizeof password
call readString  							; Enter password
call crlf 

;mov edx,offset password					;password output
;call writestring
 
                                 ;Check IF password is right or wrong   / File Handling


mov edx,offset passfile             ;passing file's offset to open in edx  
call openInputFile                  ;open input file  
mov fhandler,eax                    ;storing file handler

mov edx, offset tempuser			;reading user name
mov ecx, 4                          ;giving size to read
call readfromfile					

;mov edx, offset tempuser
;call writestring

mov eax,fhandler					;moving file handler in eax
mov edx, offset temppass			
mov ecx, 6							;reading password
call readfromfile

;mov edx,offset temppass
;call writestring

INVOKE Str_compare, ADDR temppass, ADDR password  ;comparring the credentials of the system
jne wrong


T1:		
mov edx, offset msg14
call writestring
jmp _exit

_exit:
exit	
main endp

END main