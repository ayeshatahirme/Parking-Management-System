; AddTwo.asm - adds two 32-bit integers.
; Chapter 3 example
INCLUDE Irvine32.inc

.data
opt byte "            *************************Welcome To Parking Management System************************************",0
opt1 byte "           ********************************Login as Admininstrator*********************************************",0
opt2 byte "Enter UserName: ",0
opt3 byte "Enter Password: ",0

msg1 Byte 0dh,0ah,"1. Park in  ",0 
msg2 Byte 0dh,0ah,"2. Park out  ",0
msg3 Byte 0dh,0ah,"3. Logout  ",0
msg33 Byte 0dh,0ah,"4. View Records  ",0
msg4 Byte 0dh,0ah,"---------- YOUR VEHICLE IS PARKED IN ----------",0
msg5 Byte 0dh,0ah,"---------- YOUR VEHICLE IS PARKED OUT ----------",0
op Byte 0dh,0ah,"-> Menu:  ",0
op1 Byte 0dh,0ah,"1. Motorbike  ",0
op2 Byte 0dh,0ah,"2. Car  ",0
op3 Byte 0dh,0ah,"3. Van  ",0
op4 Byte 0dh,0ah,"4. Back  ",0
op5 Byte 0dh,0ah,"5. Exit  ",0
data1 Byte 0dh,0ah,"Enter your bike's number in Format [XXX-00-X00]:  ",0
date0 Byte 0dh,0ah,"Fill out following entry date details:  ",0
date1 Byte 0dh,0ah,"Enter DateIn in format [19-03-2019]: ",0
date2 Byte 0dh,0ah,"Enter DateOut in format [19-03-2019]: ",0

data3 Byte 0dh,0ah,"Enter your car's number [XXX-00-X00]:  ",0
data5 Byte 0dh,0ah,"Enter your van's number [XXX-00-X00]:  ",0
data7 Byte 0dh,0ah,"--------------------- Thanks for coming! Have a nice day. --------------------  ",0
header2 Byte 0dh,0ah,"-> Which vehicle you want to park out:  ",0
callamount Byte 0dh,0ah,"Totalamount is:  ",0
noMatch Byte 0dh,0ah,"Your car is not found ",0

msg6 db "there is more space: ",0
msg7 db "the total amount is: ",0
msg8 db "the total numbers of vehicles parked: ",0
msg9 db "the total number of bikes parked: ",0
msg10 db "the total number of cars parked: ",0
msg11 db "the total number of vans parked ",0
msg12 db "***Record deleted successfully***",0
msg13 db "Wrong Password or username Enter Again",0
msg14 db "Successfully Login ",0
msg15 db "Sorry! Parking is Full ",0


msg16 db "                ",0
msg17 db "Vehical Numbers:",0
msg18 db "Date In:        ",0
msg19 db "Date Out:       ",0

tvacy dword 50
tamount dword 0
;totalcount dword  0
bikeamount dword 100
caramount dword 150
vanamount dword 200
totalamount dword ?

occvacancy dword 0
loopcontrolvar dword 0


count Dword 0
number Dword ?
datein dword ?
monthin dword ?
yearin dword ?
password byte 20 dup(?)
username byte 20 dup(?)

passfile byte "password.txt",0 


fhandler dword ?



tempuser byte 20 dup(?)
temppass byte 20 dup (?)




carno byte 55 dup(0)
adin byte 55 dup(0)                 ;Arrays to store credentials
adout byte 55 dup(0)



vNo byte 11 dup(0)
din byte 11 dup(0)				;Variables to enter credentials
dout byte 11 dup(0)

compre byte 11 dup(0)     ;variable to store date to be matched

siz dword 11   ;used to calculate next variable
cal dword ?    ;calculate where is the next variable in array

i dword 0       ; to store the loop incremntation
flag dword 0    ;flag used in park out
flag1 dword 0    ;flag used in park out
temp dword ?     ;to store the loop ecx value in parkout 

.code

main proc

call crlf
mov edx,offset opt                         
call writestring                            ;------To Write 
call crlf                                   ;      welcm msg-----
call crlf

call crlf
mov edx,offset opt1                         
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

mov edx,offset opt2                      
call writestring                            ;------To Write Enter user name msg-----

mov edx,offset username
mov ecx, sizeof username
call readString  							; Enter user name
call crlf  

;mov edx,offset username
;call writestring                            ;username output
        

mov edx,offset opt3                      
call writestring                            ;------To Write Enter password msg-----

mov edx,offset password
mov ecx, sizeof password
call readString  							; Enter password
call crlf 

;mov edx,offset password					;password output
;call writestring



; ********* C H E C K I N G - 1 S T - P A S S W O R D - A N D - U S E R N A M E  ********* 
                                        

call pass1										   ;Calling function to read from file

													;Check if user name is right
INVOKE Str_compare, ADDR tempuser, ADDR username ;comparring the credentials of the system
jne wrong												;if correct check password

												 ;Check IF password is right or wrong
INVOKE Str_compare, ADDR temppass, ADDR password ;comparring the credentials of the system
jne wrong                                       ;if wrong check senond pssword
jmp T1											 ;jmp if password is right


T1:		

mov edx, offset msg14
call writestring

; *********************** MAIN PAGE ************************
	
	mainpage:										; Main page of system

			mov edx, offset msg1						; showing parkin option
			call WriteString

			mov edx, offset msg2						; showing parkout option
			call WriteString

			mov edx, offset msg3						; showing logout option
			call WriteString

			mov edx, offset msg33						; showing View Records option
			call WriteString

			call crlf
			call readint								; Input option to parkin, park out or to logout
			cmp eax, 4									 ; if option is 4 then check if user wants to view records
			je viewR
			cmp eax, 2									; check what user wants (parkin, parkout, logout)

			jl parkin
			je parkout
			jg goout

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
				
 ; *********************** View Records **********************
 viewR:
            call viewRecords

			jmp mainpage

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

						CMP occvacancy, 3
						jge Full                     ;If Vacany is Full

;             ------------E N T E R -  B I K E ' S - N U M B E R------------

						mov edx, offset data1       ;msg to write number
						call WriteString

						mov edx,offset vNo
						mov ecx,sizeof vNo			;take vehical no from user
						call readstring

						mov edx, offset vNo
						call WriteString			;printing that no

						;mov edx,offset vNo
						;mov esi, offset carno

						mov ecx,sizeof vNo			;In loop give sizeof vehical number

						mov eax,occvacancy       ;moving occupied vacay in eax like 3 for example
						mul siz					;multiplying it with 11 (size of each) 33
						mov cal,eax					;mov it in cal

						call crlf
						call writeint			;checking the value
						call crlf

						mov esi,eax				;give esi that size like 33
						mov edx,0				;give edx the starting address of variable which stores bike's number

						;             ------------C O D E - T O - S T O R E - I N - L O O P------------

						copy:
					    mov al, vNo[edx]
					    mov carno[esi],al
						inc edx
						inc esi
						loop copy

				 ;             ------------E N T E R -  D A T E - I N------------

				 mov edx, offset date1       ;msg to write number
						call WriteString

						mov edx,offset din
						mov ecx,sizeof din			;take Date in from user
						call readstring

						mov edx, offset din
						call WriteString			;printing that date

						;mov edx,offset vNo
						;mov esi, offset carno

						mov ecx,sizeof din			;In loop give sizeof vehical number

						mov eax,occvacancy       ;moving occupied vacay in eax like 3 for example
						mul siz					;multiplying it with 11 (size of each) 33
						mov cal,eax					;mov it in cal

						call crlf
						call writeint			;checking the value
						call crlf

						mov esi,eax				;give esi that size like 33
						mov edx,0				;give edx the starting address of variable which stores bike's number

						;             ------------C O D E - T O - S T O R E - I N - L O O P------------

						copy1:
					    mov al, din[edx]
					    mov adin[esi],al
						inc edx
						inc esi
						loop copy1


						inc occvacancy		;updated total occupied vacay

					;	mov esi,11
					;	mov al , carno[esi]
					;	call writechar
	
						mov esi,0
						mov ecx,33
						co:
					    mov al, carno[esi]
					    call writechar
						inc esi
						loop co

						mov esi,0
						mov ecx,33
						co1:
					    mov al, adin[esi]
					    call writechar
						inc esi
						loop co1

						jmp exit1


						Full:
						mov edx, offset msg15			;in case of full vacancy
						call WriteString
						jmp exit1

						exit1:
						ret

parkbike ENDP

; ********* P A R K I N G - C A R ********* 
parkcar PROC												; Condition for parking car
				
						CMP occvacancy, 3
						jge Full                     ;If Vacany is Full

;             ------------E N T E R -  B I K E ' S - N U M B E R------------

						mov edx, offset data3       ;msg to write number
						call WriteString

						mov edx,offset vNo
						mov ecx,sizeof vNo			;take vehical no from user
						call readstring

						mov edx, offset vNo
						call WriteString			;printing that no

						;mov edx,offset vNo
						;mov esi, offset carno

						mov ecx,sizeof vNo			;In loop give sizeof vehical number

						mov eax,occvacancy       ;moving occupied vacay in eax like 3 for example
						mul siz					;multiplying it with 11 (size of each) 33
						mov cal,eax					;mov it in cal

						call crlf
						call writeint			;checking the value
						call crlf

						mov esi,eax				;give esi that size like 33
						mov edx,0				;give edx the starting address of variable which stores bike's number

						;             ------------C O D E - T O - S T O R E - I N - L O O P------------

						copy:
					    mov al, vNo[edx]
					    mov carno[esi],al
						inc edx
						inc esi
						loop copy

				 ;             ------------E N T E R -  D A T E - I N------------

				        mov edx, offset date1       ;msg to write number
						call WriteString

						mov edx,offset din
						mov ecx,sizeof din			;take Date in from user
						call readstring

						mov edx, offset din
						call WriteString			;printing that date

						;mov edx,offset vNo
						;mov esi, offset carno

						mov ecx,sizeof din			;In loop give sizeof vehical number

						mov eax,occvacancy       ;moving occupied vacay in eax like 3 for example
						mul siz					;multiplying it with 11 (size of each) 33
						mov cal,eax					;mov it in cal

						call crlf
						call writeint			;checking the value
						call crlf

						mov esi,eax				;give esi that size like 33
						mov edx,0				;give edx the starting address of variable which stores bike's number

						;             ------------C O D E - T O - S T O R E - I N - L O O P------------

						copy1:
					    mov al, din[edx]
					    mov adin[esi],al
						inc edx
						inc esi
						loop copy1


						inc occvacancy		;updated total occupied vacay

					;	mov esi,11
					;	mov al , carno[esi]
					;	call writechar
	
						mov esi,0
						mov ecx,33
						co:
					    mov al, carno[esi]
					    call writechar
						inc esi
						loop co

						mov esi,0
						mov ecx,33
						co1:
					    mov al, adin[esi]
					    call writechar
						inc esi
						loop co1

						jmp exit1


						Full:
						mov edx, offset msg15			;in case of full vacancy
						call WriteString
						jmp exit1

						exit1:
						ret
parkcar ENDP

; ********* P A R K I N G - V A N ********* 
parkvan PROC			
						CMP occvacancy, 3
						jge Full                     ;If Vacany is Full

;             ------------E N T E R -  B I K E ' S - N U M B E R------------

						mov edx, offset data5       ;msg to write number
						call WriteString

						mov edx,offset vNo
						mov ecx,sizeof vNo			;take vehical no from user
						call readstring

						mov edx, offset vNo
						call WriteString			;printing that no

						;mov edx,offset vNo
						;mov esi, offset carno

						mov ecx,sizeof vNo			;In loop give sizeof vehical number

						mov eax,occvacancy       ;moving occupied vacay in eax like 3 for example
						mul siz					;multiplying it with 11 (size of each) 33
						mov cal,eax					;mov it in cal

						call crlf
						call writeint			;checking the value
						call crlf

						mov esi,eax				;give esi that size like 33
						mov edx,0				;give edx the starting address of variable which stores bike's number

						;             ------------C O D E - T O - S T O R E - I N - L O O P------------

						copy:
					    mov al, vNo[edx]
					    mov carno[esi],al
						inc edx
						inc esi
						loop copy

				 ;             ------------E N T E R -  D A T E - I N------------

				 mov edx, offset date1       ;msg to write number
						call WriteString

						mov edx,offset din
						mov ecx,sizeof din			;take Date in from user
						call readstring

						mov edx, offset din
						call WriteString			;printing that date

						;mov edx,offset vNo
						;mov esi, offset carno

						mov ecx,sizeof din			;In loop give sizeof vehical number

						mov eax,occvacancy       ;moving occupied vacay in eax like 3 for example
						mul siz					;multiplying it with 11 (size of each) 33
						mov cal,eax					;mov it in cal

						call crlf
						call writeint			;checking the value
						call crlf

						mov esi,eax				;give esi that size like 33
						mov edx,0				;give edx the starting address of variable which stores bike's number

						;             ------------C O D E - T O - S T O R E - I N - L O O P------------

						copy1:
					    mov al, din[edx]
					    mov adin[esi],al
						inc edx
						inc esi
						loop copy1


						inc occvacancy		;updated total occupied vacay

					;	mov esi,11
					;	mov al , carno[esi]
					;	call writechar
	
						mov esi,0
						mov ecx,33
						co:
					    mov al, carno[esi]
					    call writechar
						inc esi
						loop co

						mov esi,0
						mov ecx,33
						co1:
					    mov al, adin[esi]
					    call writechar
						inc esi
						loop co1

						jmp exit1


						Full:
						mov edx, offset msg15			;in case of full vacancy
						call WriteString
						jmp exit1

						exit1:
						
						ret
parkvan ENDP

 ; ********* V I E W - R E C O R D S ********* 
viewRecords PROC

						mov edx,offset msg17				;To print Number
						call writestring

					;	mov eax,occvacancy                 ;Trying to make value for ECX
					;	mul siz

 						mov esi,0							
						mov ecx, lengthof carno

						co:
					    mov al, carno[esi]
					    call writechar					;LOOP TO PRINT CAR NUMBERs
						inc esi
						loop co

						call Crlf
						call crlf
						mov edx,offset msg18				;To print Datein
						call writestring

						mov esi,0
						mov ecx,33

						co1:
					    mov al, adin[esi]
					    call writechar					;LOOP TO PRINT DATE IN
						inc esi
						loop co1

						call Crlf
						call crlf
						mov edx,offset msg19				;To print Date out
						call writestring

						mov esi,0
						mov ecx,33

						co2:
					    mov al, adout[esi]
					    call writechar					;LOOP TO PRINT DATE IN
						inc esi
						loop co2

						RET

 viewRecords ENDP

; ********* P A R K I N G - B I K E O U T ********* 
bikeout PROC												; Condition for parking out bike
					    mov edx, offset data1
						call WriteString

	;             ------------E N T E R -  B I K E ' S - N U M B E R------------

						mov edx,offset vNo
						mov ecx,sizeof vNo					;input car's number
						call readstring
						

						mov esi,0
						;mov edx,0
						mov ecx, 3

						loop1:
						mov edx,0
						mov temp,ecx
						mov ecx,siz
						mov eax,esi
						call writeint           
						loop2:
						mov al,carno[esi]
						;call writechar
						mov compre[edx],al
						inc esi
						inc edx
						loop loop2
								     																			;mov edx,offset vNo
																												;call writestring
																												;mov edx,offset compre
																												;call writestring
						INVOKE Str_compare, ADDR vNo, ADDR compre
						je found

						mov ecx,temp
						loop loop1
						jmp notFound
						
						found:
						mov edx,offset data1
						call writestring
						jmp _exit

						notFound:
						mov edx,offset NoMatch
						call writestring
						jmp _exit

						_exit:
						ret
bikeout ENDP

; ********* P A R K I N G - C A R O U T ********* 
carout PROC													; Condition for parking out car
						mov edx, offset data3
						call WriteString
						

						ret
carout ENDP

; ********* P A R K I N G - V A N O U T ********* 
vanout PROC													; Condition for parking out van
						mov edx, offset data5
						call WriteString
						

						ret
vanout ENDP





;           ***************************************************************************************************
;           ************************************ P R O C E D U R E S ******************************************
;           ***************************************************************************************************


; ********* R E A D I N G - P A S S W O R D 1 ********* 


pass1 PROC						    ;Procedure to read from file 1

                                     ;File Handling

mov edx,offset passfile             ;passing file's offset to open in edx  
call openInputFile                  ;open input file  
mov fhandler,eax                    ;storing file handler

mov edx, offset tempuser			;reading user name
mov ecx, 3                          ;giving size to read
call readfromfile					

;mov edx, offset tempuser
;call writestring

mov eax,fhandler					;moving file handler in eax
mov edx, offset temppass			
mov ecx, 6							;reading password
call readfromfile

;mov edx,offset temppass
;call writestring

;call closefile
RET
pass1 endp

END main

