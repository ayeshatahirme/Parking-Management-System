; AddTwo.asm - adds two 32-bit integers.
; Chapter 3 example
INCLUDE Irvine32.inc

.data
op byte "*****************************Parking Management System*****************************",0
op1 byte "*****************************Login as Admininstrator*****************************",0
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

tvacy dd 50
tamount dd 0
tcount dd  0
am1 dd ?
am2 dd ?
am3 dd ?
opt1 dd ?
password dd ?
username dd ?

storage dd 150 dup(?) 

passfile byte "password.txt",0 
fhandler dword ?
temp dd ?

.code
main proc

mov edx,offset passfile
call openInputFile
mov edx, offset temp
mov ecx, 6
call readfromfile


call writestring
			

exit	
main endp
end main
