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




;((((((((((((((((((((((((( PROJECT )))))))))))))))))))))))
;------------------- PARKING MANAGEMENT SYSTEM ---------------
 
 INCLUDE Irvine32.inc 
 
.data 

count Dword 0
number Dword ?
datein Dword ?
monthin Dword ?
yearin Dword ?
header1 Byte 0dh,0ah,"------------------------ PARING MANAGEMENT SYSTEM ------------------------ ",0
msg1 Byte 0dh,0ah,"1. Park in  ",0 
msg2 Byte 0dh,0ah,"2. Park out  ",0
msg3 Byte 0dh,0ah,"3. Logout  ",0
msg4 Byte 0dh,0ah,"---------- YOUR VEHICLE IS PARKED IN ----------",0
msg5 Byte 0dh,0ah,"---------- YOUR VEHICLE IS PARKED OUT ----------",0
op Byte 0dh,0ah,"-> Select vehicle to park:  ",0
op1 Byte 0dh,0ah,"1. Motorbike  ",0
op2 Byte 0dh,0ah,"2. Car  ",0
op3 Byte 0dh,0ah,"3. Van  ",0
op4 Byte 0dh,0ah,"4. Back  ",0
op5 Byte 0dh,0ah,"5. Exit  ",0
data1 Byte 0dh,0ah,"Enter your bike's number:  ",0
date0 Byte 0dh,0ah,"Fill out following entry date details:  ",0
date1 Byte 0dh,0ah,"Date:  ",0
date2 Byte 0dh,0ah,"Month:  ",0
date3 Byte 0dh,0ah,"Year:  ",0
data3 Byte 0dh,0ah,"Enter your car's number:  ",0
data5 Byte 0dh,0ah,"Enter your van's number:  ",0
data7 Byte 0dh,0ah,"--------------------- Thanks for coming! Have a nice day. --------------------  ",0
header2 Byte 0dh,0ah,"-> Which vehicle you want to park out:  ",0
.code 
 
	main PROC
	
; *********************** MAIN PAGE ************************
	
	mainpage:										; Main page of system
		    mov edx, offset header1
			call WriteString
			call crlf

			mov edx, offset msg1						; showing parkin option
			call WriteString

			mov edx, offset msg2						; showing parkout option
			call WriteString

			mov edx, offset msg3						; showing logout option
			call WriteString
			call crlf
			call readint								; Input option to parkin, park out or to logout
			cmp eax, 2									; check what user wants (parkin, parkout, logout)

			jl parkin
			je parkout
			jg _exit

; ********************* PARKING IN CONDITION *********************

		parkin:										; Condition for parking in
			mov edx, offset op
			call WriteString
			call crlf
			mov edx, offset op1
			call WriteString

			mov edx, offset op2
			call WriteString

			mov edx, offset op3
			call WriteString

			mov edx, offset op4
			call WriteString

			mov edx, offset op5
			call WriteString
			call crlf
			call readint				; Input vehicle you want to park or exit from page
				
			cmp eax, 5					; ---- check what user wants 
			je _exit					; park bike, car or van
			cmp eax, 4					; or to go back -----
			je mainpage
			cmp eax, 2
				
			jl Tbike
			je Tcar
			jg Tvan
			
			;jmp parkin						; Returning back to parking in options
				
				
; *********************** PARKING OUT CONDITION **********************

		parkout:										; Condition for parking out
			mov edx, offset header2
			call WriteString
			call crlf

			mov edx, offset op1								; Showing vehicles user can park
			call WriteString

			mov edx, offset op2
			call WriteString

			mov edx, offset op3
			call WriteString
				
			mov edx, offset op4
			call WriteString

			mov edx, offset op5
			call WriteString
			call crlf
			call readint							; Input which vehicle to park out
				
			cmp eax, 5								; ---- check what user wants 
			je _exit								; park bike, car or van
			cmp eax, 4								; or to go back ----
			je mainpage
			cmp eax, 2
				
			jl Toutbike
			je Toutcar
			jg Toutvan

			jmp parkout
				

; ***************************** TAGS FOR PARKING IN ************************************

	Tbike:
		call parkbike
		jmp parkin
	Tcar:
		call parkcar
		jmp parkin
	Tvan:
		call parkvan
		jmp parkin

; ***************************** TAGS FOR PARKING OUT ************************************

	Toutbike:
		call bikeout
		jmp parkout
	Toutcar:
		call carout
		jmp parkout
	Toutvan:
		call vanout
		jmp parkout


; ***************************** EXIT PROGRAM ************************************
			_exit:									; Condition for exiting system
				mov edx, offset data7
				call WriteString
				call crlf
				exit
				main ENDP 



; ******************************************************************************************
; ********************************** P R O C E D U R E S ***********************************
; ******************************************************************************************
 
 ; ********* P A R K I N G - B I K E ********* 
 parkbike PROC												; Condition for parking bike
						mov edx, offset data1
						call WriteString
						call readint
						mov number, eax

						mov edx, offset date0
						call WriteString
						call crlf

						mov edx, offset date1
						call WriteString
						call readint						; Input date you parked
						mov datein, eax

						mov edx, offset date2
						call WriteString
						call readint						; Input month you parked
						mov monthin, eax

						mov edx, offset date3
						call WriteString
						call readint						; Input month you parked
						mov yearin, eax
						call crlf
						
						inc count
						
						mov edx, offset msg4
						call WriteString
						call crlf
						ret

parkbike ENDP

; ********* P A R K I N G - C A R ********* 
parkcar PROC												; Condition for parking car
						mov edx, offset data3
						call WriteString
						call readint
						mov number, eax

						mov edx, offset date0
						call WriteString

						mov edx, offset date1
						call WriteString
						call readint						; Input date you parked
						mov datein, eax

						mov edx, offset date2
						call WriteString
						call readint						; Input month you parked
						mov monthin, eax

						mov edx, offset date3
						call WriteString
						call readint						; Input year you parked
						mov yearin, eax	
						call crlf
						
						inc count

						mov edx, offset msg4
						call WriteString
						call crlf
						
						ret
parkcar ENDP

; ********* P A R K I N G - V A N ********* 
parkvan PROC												; Condition for parking van
						mov edx, offset data5
						call WriteString
						call readint
						mov number, eax

						mov edx, offset date0
						call WriteString

						mov edx, offset date1
						call WriteString
						call readint						; Input date you parked
						mov datein, eax

						mov edx, offset date2
						call WriteString
						call readint						; Input month you parked
						mov monthin, eax

						mov edx, offset date3
						call WriteString
						call readint						; Input year you parked
						mov yearin, eax
						call crlf
						
						inc count

						mov edx, offset msg4
						call WriteString
						call crlf
						
						ret
parkvan ENDP

; ********* P A R K I N G - B I K E O U T ********* 
bikeout PROC												; Condition for parking out bike
					mov edx, offset data1
						call WriteString
						call readint						; Input number of bike parked
						mov number, eax

						mov edx, offset date0
						call WriteString
						call crlf

						mov edx, offset date1
						call WriteString
						call readint						; Input date you parked
						mov datein, eax

						mov edx, offset date2
						call WriteString
						call readint						; Input month you parked
						mov monthin, eax

						mov edx, offset date3
						call WriteString
						call readint						; Input year you parked
						mov yearin, eax
						call crlf
						
						dec count

						mov edx, offset msg5
						call WriteString
						call crlf

						ret
bikeout ENDP

; ********* P A R K I N G - C A R O U T ********* 
carout PROC													; Condition for parking out car
						mov edx, offset data3
						call WriteString
						call readint						; Input number of car parked
						mov number, eax

						mov edx, offset date0
						call WriteString
						call crlf

						mov edx, offset date1
						call WriteString
						call readint						; Input date you parked
						mov datein, eax

						mov edx, offset date2
						call WriteString
						call readint						; Input month you parked
						mov monthin, eax

						mov edx, offset date3
						call WriteString
						call readint						; Input year you parked
						mov yearin, eax
						call crlf
						
						dec count

						mov edx, offset msg5
						call WriteString
						call crlf

						ret
carout ENDP

; ********* P A R K I N G - V A N O U T ********* 
vanout PROC													; Condition for parking out van
						mov edx, offset data5
						call WriteString
						call readint						; Input number of van parked
						mov number, eax

						mov edx, offset date0
						call WriteString

						mov edx, offset date1
						call WriteString
						call readint						; Input date you parked
						mov datein, eax

						mov edx, offset date2
						call WriteString
						call readint						; Input month you parked
						mov monthin, eax

						mov edx, offset date3
						call WriteString
						call readint						; Input year you parked
						mov yearin, eax
						call crlf
						
						dec count

						mov edx, offset msg5
						call WriteString
						call crlf

						ret
vanout ENDP

END main
