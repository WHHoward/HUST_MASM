.686     
.model flat, stdcall
 ExitProcess PROTO STDCALL :DWORD
 includelib  kernel32.lib  ; ExitProcess 在 kernel32.lib中实现
 printf          PROTO C :VARARG
 scanf         PROTO C :VARARG
 includelib  libcmt.lib
 includelib  legacy_stdio_definitions.lib

.DATA
lpFmt  db "%s", 0ah, 0dh, 0
lpFmt2 db "wrong", 0ah, 0dh, 0
lpFmt3 db "right", 0ah, 0dh, 0
lpFmt4 db "%d",0ah,0dh,0
lpFmt5 db "please input your password",0ah,0dh,0
lpFmt6 db "%s",0
lpFmt7 db "The length of password is 7",0ah,0dh,0
lpFmt8 db "Wrong on length",0ah,0dh,0    
LOWF DB 100 dup(0)
MIDF DB 100 dup(0)
HIGHF DB 12 dup(0)
ccl DD 0
ccm DD 0
cch DD 0
SAMID  DB '000001' 
a   DD  256809    
b   DD  -1023       
cc   DD   1265    
f   DD   0 


.STACK 200

.CODE
main proc c
here:
mov eax, a
imul eax,5
mov f, eax
mov eax, b
add f, eax
mov eax, cc
sub f, eax
mov eax, 100
add f, eax
mov eax, f
mov ebx,128
mov edx, 0
idiv ebx
mov f, eax
invoke printf, offset lpFmt4,eax
mov eax, f
cmp eax, 100
je L1
jmp L2

L1:
	mov ebx, sdword ptr SAMID[0]
	mov edx, ccm
	mov sdword ptr MIDF[edx], ebx
	mov ebx, sdword ptr SAMID[4]
	mov sdword ptr MIDF[edx+4], ebx
	mov ebx, sdword ptr SAMID[8]
	mov sdword ptr MIDF[edx+8], ebx
	mov ebx, sdword ptr SAMID[12]
	mov sdword ptr MIDF[edx+12], ebx
	mov ebx, sdword ptr SAMID[16]
	mov sdword ptr MIDF[edx+16], ebx
	mov bx, sword ptr SAMID[20]
	mov sword ptr MIDF[edx+20], bx
	add edx, 22
	mov ccm, edx
	jmp exithere
L2:
	cmp eax, 100
	jg L3
	mov ebx, sdword ptr SAMID[0]
	mov edx, ccl
	mov sdword ptr LOWF[edx], ebx
	mov ebx, sdword ptr SAMID[4]
	mov sdword ptr LOWF[edx+4], ebx
	mov ebx, sdword ptr SAMID[8]
	mov sdword ptr LOWF[edx+8], ebx
	mov ebx, sdword ptr SAMID[12]
	mov sdword ptr LOWF[edx+12], ebx
	mov ebx, sdword ptr SAMID[16]
	mov sdword ptr LOWF[edx+16], ebx
	mov bx, sword ptr SAMID[20]
	mov sword ptr LOWF[edx+20], bx
	add edx, 22
	mov ccl, edx
	jmp exithere
L3:
	mov ebx, sdword ptr SAMID[0]
	mov edx, cch
	mov sdword ptr HIGHF[edx], ebx
	mov ebx, sdword ptr SAMID[4]
	mov sdword ptr HIGHF[edx+4], ebx
	mov ebx, sdword ptr SAMID[8]
	mov sdword ptr HIGHF[edx+8], ebx
	mov ebx, sdword ptr SAMID[12]
	mov sdword ptr HIGHF[edx+12], ebx
	mov ebx, sdword ptr SAMID[16]
	mov sdword ptr HIGHF[edx+16], ebx
	mov bx, sword ptr SAMID[20]
	mov sword ptr HIGHF[edx+20], bx
	add edx, 22
	mov cch, edx
	jmp exithere

exithere:
invoke ExitProcess, 0


invoke ExitProcess, 0
main endp
END