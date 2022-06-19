; Auteur: LL
; Date  : 07.08.2010, Affichage de texte simple
;
; Aide  :  http://www.osdever.net/tutorials/hello_btldr.php?the_id=85
;          http://forum.osdev.org/viewtopic.php?f=1&t=21555&start=0
;          http://www.asmfr.com/forum/sujet-PROBLEME-RETOUR-LIGNE_1151801.aspx

bits 16 ; Programme en 16 bits

org 7c00h ;Permet d indiquer a quel partie commence le code sur le bios //100h pour dos

jmp Boot  ;Appelle la fonction de boot

Boot:     ; Label de la fonction principale
	mov ax, 0x0000  ;Location du segment de registre
	mov ds, ax      ; Oblige de passer en 2x
	mov si, strTitre ; Place la phrase dans les si
	call ChargerEcran ; Charge les param video
	call Ecrire
	jmp $ ; Boucle infinie
	
ChargerEcran :
	mov ah, 0eh ; Fonction de caracteres
	mov bl, 07h ; Couleur de l ecran
	mov bh, 00h

Ecrire : 
	.NouvChar    ;Label du new char
	lodsb        ; Charge les SI pour les mettre dans al et 
	             ; permet d incrementer si a chaque fois et donc de passer
	or al, al    ; sur chaque caractere
	jz .RetDebut  ;Retourne au debut
	int 10h       ;Permet de rendre la main au bios, stop la video
	jmp .NouvChar ; Caractere suivant
	.RetDebut     ;Label de retour au debut
	ret ;retour au debut

; Donnees	
strTitre db 10, "Small Boot Loader - MOL",10, 13, "*********************", 13, 10,10, "Chargement du kernel en cours...",10,13  ; Phrase de base du bootloader

times 510 - ($ - $$) db 0 ;Place des 0 sur le reste des secteurs
dw 0aa55h ; Nombre magique pour le bootloader
