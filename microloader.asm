bits 16

org 7c00h

jmp Boot  ; jump to boot function

Boot:
	mov ax, 0x0000
	mov ds, ax
	mov si, strLoading ; use loading string
	call LoadScreen ; load video settings
	call Write
	jmp $ ; infinite loop
	
LoadScreen :
	mov ah, 0eh
	mov bl, 07h ; screen color
	mov bh, 00h

Write :
	.NewChar:
		lodsb
		or al, al
		jz .RetStart
		int 10h
		jmp .NewChar
	.RetStart:
		ret

; Data
strLoading db 10, "Micro loader",10, 13, "************", 13, 10,10, "Loading kernel...",10,13

times 510 - ($ - $$) db 0 ;0 on other sectors
dw 0aa55h ; magic number
