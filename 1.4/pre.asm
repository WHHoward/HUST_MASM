.686     
.model flat, stdcall
ExitProcess PROTO STDCALL :DWORD
includelib  kernel32.lib  ; ExitProcess �� kernel32.lib��ʵ��
printf          PROTO C :VARARG
scanf         PROTO C :VARARG

includelib  libcmt.lib
includelib  legacy_stdio_definitions.lib

includelib	winmm.lib
timeGetTime PROTO
.DATA
lpFmt  db "%s", 0ah, 0dh, 0
lpFmt2 db "wrong", 0ah, 0dh, 0
lpFmt3 db "right", 0ah, 0dh, 0
lpFmt4 db "%u",0ah,0dh,0
lpFmt5 db "please input your password",0ah,0dh,0
lpFmt6 db "%u",0ah,0dh,0
lpFmt7 db "The length of password is 7",0ah,0dh,0
lpFmt8 db "Wrong on length",0ah,0dh,0    
LOWF DB 100 dup(0)
MIDF DB 100 dup(0)
HIGHF DB 12 dup(0)
COUNT DW 0
COUNTOFINPUT DD 0
ccl DD 0
ccm DD 0
cch DD 0
SAMID  DB '000001' 
a   DD  256809    
b   DD  -1023       
cc   DD   1265    
f   DD   0 

ME STRUCT
	SAMID DB 6 DUP(0)
	SDA   DD 0
	SDB	  DD 0
	SDC   DD 0
	SF    DD 0
ME ENDS

INPUT  ME  <'1',321,432,10>
       ME  <'2',12654,544,342>
       ME  <'3',32100654,432,10>
	   ME 19997 DUP(<>)
HIGHME ME 20000 DUP(<>)
MIDME  ME 20000 DUP(<>)
LOWME  ME 20000 DUP(<>)
pretime DD 0
nowtime DD 0
fitime DD 0
temp DW 0
.STACK 200

.CODE
main proc c
RDTSC
mov pretime, eax
here:
.if COUNT>20000
	jmp exithere
.endif
mov edx, COUNTOFINPUT
mov eax, INPUT[edx].SDA
imul eax,5
mov INPUT[edx].SF, eax
mov eax, INPUT[edx].SDB
add INPUT[edx].SF, eax
mov eax, INPUT[edx].SDC
sub INPUT[edx].SF, eax
mov eax, 100
add INPUT[edx].SF, eax
mov eax, INPUT[edx].SF
mov ebx,128
mov edx, 0
idiv ebx
mov edx, COUNTOFINPUT
mov INPUT[edx].SF, eax
inc COUNT
cmp eax, 100
je L1
jmp L2

L1:
	mov edx, COUNTOFINPUT
	mov eax,ccm
	mov ebx, sdword ptr INPUT[edx]
	mov sdword ptr MIDME[eax], ebx
	mov ebx, sdword ptr INPUT[edx+4]
	mov sdword ptr MIDME[eax+4], ebx
	mov ebx, sdword ptr INPUT[edx+8]
	mov sdword ptr MIDME[eax+8], ebx
	mov ebx, sdword ptr INPUT[edx+12]
	mov sdword ptr MIDME[eax+12], ebx
	mov ebx, sdword ptr INPUT[edx+16]
	mov sdword ptr MIDME[eax+16], ebx
	mov bx, sword ptr INPUT[edx+20]
	mov sword ptr MIDME[eax+20], bx
	add edx, 22
	mov COUNTOFINPUT, edx
	add eax, 22
	mov ccm, eax
	jmp here
L2:
	cmp eax, 100
	jg L3
	mov edx, COUNTOFINPUT
	mov eax,ccl
	mov ebx, sdword ptr INPUT[edx]
	mov sdword ptr LOWME[eax], ebx
	mov ebx, sdword ptr INPUT[edx+4]
	mov sdword ptr LOWME[eax+4], ebx
	mov ebx, sdword ptr INPUT[edx+8]
	mov sdword ptr LOWME[eax+8], ebx
	mov ebx, sdword ptr INPUT[edx+12]
	mov sdword ptr LOWME[eax+12], ebx
	mov ebx, sdword ptr INPUT[edx+16]
	mov sdword ptr LOWME[eax+16], ebx
	mov bx, sword ptr INPUT[edx+20]
	mov sword ptr LOWME[eax+20], bx
	add edx, 22
	mov COUNTOFINPUT, edx
	add eax, 22
	mov ccl, eax
	jmp here
L3:
	mov edx, COUNTOFINPUT
	mov eax,cch
	mov ebx, sdword ptr INPUT[edx]
	mov sdword ptr HIGHME[eax], ebx
	mov ebx, sdword ptr INPUT[edx+4]
	mov sdword ptr HIGHME[eax+4], ebx
	mov ebx, sdword ptr INPUT[edx+8]
	mov sdword ptr HIGHME[eax+8], ebx
	mov ebx, sdword ptr INPUT[edx+12]
	mov sdword ptr HIGHME[eax+12], ebx
	mov ebx, sdword ptr INPUT[edx+16]
	mov sdword ptr HIGHME[eax+16], ebx
	mov bx, sword ptr INPUT[edx+20]
	mov sword ptr HIGHME[eax+20], bx
	add edx, 22
	mov COUNTOFINPUT, edx
	add eax, 22
	mov cch, eax
	jmp here

exithere:
RDTSC
mov nowtime, eax
invoke printf, offset lpFmt4, pretime
invoke printf, offset lpFmt4, nowtime
mov edx, nowtime
sub edx, pretime
mov fitime,edx
invoke printf, offset lpFmt4, fitime
invoke ExitProcess, 0
invoke ExitProcess, 0
main endp
END