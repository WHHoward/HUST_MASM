.686     
.model flat, stdcall
ExitProcess PROTO STDCALL :DWORD
includelib  kernel32.lib
printf          PROTO C :VARARG
scanf         PROTO C :VARARG
process proto:dword
process_login proto C:dword
waitto proto C
change_me proto	C
includelib  libcmt.lib
includelib  legacy_stdio_definitions.lib

includelib	winmm.lib
.DATA
lpFmt1 db "����������û���",0ah,0dh,0
lpFmt2 db "�������������",0ah,0dh,0
lpFmt3 db "%s",0
lpFmt4 db "�û���������! ����%d�λ���",0ah,0dh,0
lpFmt5 db "û�л����ˣ������˳�",0ah,0dh,0
lpFmt6 db "���������! ����%d�λ���",0ah,0dh,0
lpFmt7 db "���ݲɼ����",0ah,0dh,0
lpFmt8 db "��Ϣ��ȷ",0ah,0dh,0
lpFmt9 db "�������",0ah,0dh,0
username db "wenhao",0,0,0
userpassword db "1234567",0,0,0
myname db 12 dup(0)
password db 12 dup(0)
countofchances db 0
sign dd 0
signofwait dd 0

public sign,signofwait
.STACK 200
compare1   macro string1,string2
	local L1,exit1,exit2,exit3	
	mov ecx, 0
	mov ebx, 0
	L1:
	MOV AL, byte ptr string1[EBX]
	MOV DL, byte ptr string2[ECX]
	cmp AL,DL
	jne exit1
	inc EBX
	inc ECX
	cmp AX, 0
	je exit2
	cmp DX, 0
	je exit1
	jmp L1
	exit1:
	mov sign, 0
	jmp exit3
	exit2:
	mov sign, 1
	jmp exit3
	exit3:
	mov ecx, 0
	mov ebx, 0
	ENDM

.CODE

main proc c
START:
	invoke process_login, 1
GGG:
	.if sign == 1
		invoke process, 5
		invoke waitto
		.if signofwait == 1
			jmp GGG	
			.elseif signofwait == 0
				invoke ExitProcess, 0
				.else
					invoke change_me
					jmp GGG
			.endif
	.else
		invoke ExitProcess, 0
	.endif
EXIT:
	invoke ExitProcess, 0
main endp
END