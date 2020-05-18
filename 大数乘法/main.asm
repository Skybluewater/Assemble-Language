.386
.model flat,stdcall
option casemap:none
includelib msvcrt.lib
printf PROTO C:dword,:vararg
scanf PROTO C:dword,:vararg
.data
std1 DWORD 120 dup(0)
std2 DWORD 120 dup(0)
s1 DWORD 120 dup(0)
s2 DWORD 120 dup(0)
result DWORD 300 dup(0)
Temp DWORD 0
i DWORD ?
j DWORD ?
len DWORD ?
Fact DWORD 0
szFmt byte 'Please enter the multiple number:', 0ah, 0
szIn byte '%c',0
szOut byte '%d',0
szAns byte 'The answer is:',0ah,0
szNeg byte '-',0
.code
main proc
	xor ebx,ebx
	mov eax,120
	mov i,eax
	xor ebx,ebx
	invoke printf,offset szFmt
L1:
	invoke scanf,offset szIn,offset Temp
	mov eax,i
	mov ebx,Temp
	cmp ebx,10
	je L2
	cmp ebx,45
	je E1
	DEC eax
	mov i,eax
	mov std1[eax*4],ebx
	xor ebx,ebx
	mov j,ebx
	jmp L1
E1:
	mov ebx,1
	xor Fact,ebx
	jmp L1
L2:
	mov eax,i
	mov ebx,j
	cmp eax,120
	je L3
	mov ecx,std1[eax*4]
	sub ecx,48
	mov s1[ebx*4],ecx
	inc eax
	inc ebx
	mov i,eax
	mov j,ebx
	jmp L2
L3:
	invoke printf,offset szFmt
	xor ebx,ebx
	mov eax,120
	mov i,eax
L4:
	invoke scanf,offset szIn,offset Temp
	mov eax,i
	mov ebx,Temp
	cmp ebx,10
	je L5
	cmp ebx,45
	je EQ2
	DEC eax
	mov i,eax
	mov std2[eax*4],ebx
	xor ebx,ebx
	mov j,ebx
	jmp L4
EQ2:
	mov ebx,1
	xor Fact,ebx
	jmp L4
L5:
	mov eax,i
	mov ebx,j
	cmp eax,120
	je L6
	mov ecx,std2[eax*4]
	sub ecx,48
	mov s2[ebx*4],ecx
	inc ebx
	inc eax
	mov i,eax
	mov j,ebx
	jmp L5
L6:
	;mov eax,3
	;invoke printf,offset szOut,s1[eax*4]
	mov eax,0
	mov i,eax
	mov ebx,0
	mov j,ebx
L7:
	mov eax,i
	cmp eax,120
	je L8
L10:
	mov ebx,j
	cmp ebx,120
	je L9
	mov ecx,s1[eax*4]
	mov edx,s2[ebx*4]
	imul ecx,edx
	mov edx,eax
	add edx,ebx
	add result[edx*4],ecx
	inc ebx
	mov j,ebx
	jmp L10
L9:
	mov ebx,0
	mov j,ebx
	inc eax
	mov i,eax
	jmp L7
L8:
	mov ebx,j
	cmp ebx,300
	je L11
	mov eax,result[ebx*4]
	mov ecx,10
	sub edx,edx
	idiv ecx
	mov result[ebx*4],edx
	inc ebx
	mov j,ebx
	add result[ebx*4],eax
	jmp L8
L11:
	mov eax,300
	mov i,eax
L12:
	mov eax,i
	cmp eax,0
	je L13
	dec eax
	mov i,eax
	cmp result[eax*4],0
	je L12
	jmp L13
L13:
	mov len,eax
	mov ebx,0
	mov j,ebx
L14:
	mov ebx,j
	cmp ebx,len
	jg L15
	mov ecx,result[eax*4]
	mov s2[ebx*4],ecx
	dec eax
	inc ebx
	mov j,ebx
	jmp L14
L15:
	invoke printf,offset szAns
	mov eax,0
	mov ebx,Fact
	cmp ebx,0
	je L16
	invoke printf,offset szNeg
	mov eax,0
L16:
	cmp eax,len
	jg L0
	mov i,eax
	mov j,ebx
	invoke printf,offset szOut,s2[eax*4]
	mov eax,i
	mov ebx,j
	inc eax
	jmp L16
L0:
	ret
main endp
end main
