.686     
.model flat, stdcall
ExitProcess PROTO STDCALL :DWORD
includelib  kernel32.lib  ; ExitProcess 在 kernel32.lib中实现
printf          PROTO C :VARARG
includelib  libcmt.lib
includelib  legacy_stdio_definitions.lib
printf          PROTO C :VARARG
getchar 	   PROTO C :VARARG
gets 	   PROTO C :VARARG
scanf         PROTO C :VARARG
outputMIDF proto C
public ccm
public MIDME
public process
public input
.DATA
lpFmt9 db "%s",0
lpFmt10 db "%u",0ah,0dh,0
lpFmt11 db 0ah,0dh,0
lpFmt7 db "数据采集完毕",0ah,0dh,0
lpFmt8 db "输入R重新执行process，输入Q退出程序",0ah,0dh,0
lpFmt1 db "R",0ah,0dh,0
lpFmt2 db "Q",0ah,0dh,0
lpFmt13 db "%c",0ah,0dh,0
controlchar db 0,0,0,0
tempchar db	0,0,0,0
COUNT dd 0
COUNTOFINPUT DD 0
ccl DD 0
ccm DD 0
cch DD 0
dateofMIDF DD 0
ME STRUCT
	SAMID DB 6 DUP(0)
	SDA   DD 0
	SDB	  DD 0
	SDC   DD 0
	SF    DD 0
ME ENDS
INPUT  ME  <'1',321,432,10>
       ME  <'2',2540,1,1>
       ME  <'3',2540,432,432>
	   ME 19997 DUP(<>)
HIGHME ME 20000 DUP(<>)
MIDME  ME 20000 DUP(<>)
LOWME  ME 20000 DUP(<>)
.STACK 200
	

.CODE
;现在需要设置在process执行后让用户输入，如果输入R,则重新执行process，如果输入Q则退出程序,其他输入则省略		
process proc ptimes:dword
	local tempccm:dword
	mov tempccm, 0
	mov count, 0
	mov COUNTOFINPUT, 0
	mov ccm, 0
	mov ccl, 0
	mov cch, 0
	here:
	mov edx, ptimes
	cmp count, edx
	ja exithere
	mov edx, COUNTOFINPUT	
	mov eax, INPUT[edx].SDA
	lea eax, [eax + eax * 4]
	add eax, INPUT[edx].SDB
	sub eax, INPUT[edx].SDC
	add eax, 100
	sar eax, 7
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
		invoke outputMIDF
		ret
process endp
END
