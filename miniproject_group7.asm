


				LIST	P=18F4520, R=DEC	;define processor, decimal radix
				#include <P18F4520.INC>		;processor specific variable definitions


				CONFIG	OSC = HS, WDT = OFF, LVP = OFF, PBADEN = OFF


				CBLOCK	0x000

				DELAY_H
				DELAY_L
				CHECK
KEYCODE
TEMP
STORE
				ENDC

;------------------------------------------------------------------------------
				ORG		0x0000
				goto	Main				;go to start of main code

;------------------------------------------------------------------------------
;Start of main program
;
Main:			movlw	0x0F				;Set all Ports digital I/O
				movwf	ADCON1
				clrf	TRISD
				clrf	PORTD
				movlw	0xF0
				movwf	TRISC
				movlw 0x08
				movwf T0CON
				LFSR 0,0x040



		
MainLoop:		call	KeyScan
				call 	SOUND
				bra		MainLoop


SOUND:			addwf 	WREG, W
				addwf	PCL, F
				bra no_input
				bra SOUND1 ; sound1-12 c4-g5
				bra SOUND2  
				bra SOUND3
				bra SOUND4
				bra SOUND5
				bra SOUND6	
				bra SOUND7
				bra SOUND8
				bra SOUND9
				bra SOUND10
				bra SOUND11
				bra SOUND12
				bra START
				bra STOP
				bra PLAY	
				bra CLEAR

PLAYSOUND:		addwf 	WREG, W
				addwf	PCL, F
				bra no_input
				bra SOUND1
				bra SOUND2
				bra SOUND3
				bra SOUND4
				bra SOUND5
				bra SOUND6	
				bra SOUND7
				bra SOUND8
				bra SOUND9
				bra SOUND10
				bra SOUND11
				bra SOUND12
                bra START
				bra STOP
				bra PLAY	
                bra CLEAR
               
no_input:		movlw 0x17
				movwf TEMP 
				movlw 	0x00
				cpfseq CHECK
				call DOUBLE_CHECK
				movlw 0x5B
				movwf PORTD
				return
				
DOUBLE_CHECK: 	movlw 0x17
				cpfseq INDF0
				movff TEMP,INDF0
				return
				
START:			movlw 0x01
				movwf CHECK
				return
				
STOP:			movlw 0x00
				movwf CHECK
				return
				
CLEAR:			movlw 0x00
				movwf FSR0H
				movlw 0x3F
				movwf FSR0L
CLEARLOOP:		tstfsz PREINC0
				bra CLEARINSIDE
				movlw 0x00
				movwf FSR0H
				movlw 0x40
				movwf FSR0L
				return
				
CLEARINSIDE: 	clrf INDF0
				bra CLEARLOOP
				
PLAY:			movlw 0x00
				movwf FSR0H
				movlw 0x40
				movwf FSR0L
Loop: 			movff INDF0,STORE
				movff POSTINC0,WREG
				call PLAYSOUND
				movff STORE, WREG
				cpfseq INDF0
				bra PLAYINSIDE
				bra Loop
				return
				
PLAYINSIDE: 	tstfsz INDF0
				bra PLAYDELAY
				return
				
PLAYDELAY: 		call no_input 
				call Delay
				bra Loop
				


KeyScan:		clrf	KEYCODE
				setf	PORTC
				bcf		PORTC, RC0
				call 	DetectCol
				movf	WREG, F
				bnz		Output
				movlw	0x04
				addwf	KEYCODE
				setf	PORTC
				bcf		PORTC, RC1
				call 	DetectCol
				movf	WREG, F
				bnz		Output
				movlw	0x04
				addwf	KEYCODE
				setf	PORTC
				bcf		PORTC, RC2
				call 	DetectCol
				movf	WREG, F
				bnz		Output
				movlw	0x04
				addwf	KEYCODE
				setf	PORTC
				bcf		PORTC, RC3
				call 	DetectCol
				movf	WREG, F
				bz		ret
				bnz		Output

ret:			return

Output:			addwf	KEYCODE, W
				return

DetectCol:		btfss	PORTC, RC4
				retlw 	0x01
				btfss	PORTC, RC5
				retlw 	0x02
				btfss	PORTC, RC6
				retlw 	0x03
				btfss	PORTC, RC7
				retlw 	0x04
				retlw	0x00


SOUND1: movlw 0x01
movwf TEMP 
movlw 	0x00
cpfseq CHECK
movff TEMP,PREINC0				
movlw 0xF8
movwf TMR0H
movlw 0x88
movwf TMR0L
bcf INTCON,TMR0IF
comf PORTD
bsf T0CON, TMR0ON
SOUND1_LOOP: btfss INTCON, TMR0IF
bra SOUND1_LOOP
bcf T0CON,TMR0ON
RETURN



SOUND2: movlw 0x02
movwf TEMP 
movlw 	0x00
cpfseq CHECK
movff TEMP,PREINC0				
movlw 0xF9
movwf TMR0H
movlw 0x59
movwf TMR0L
bcf INTCON,TMR0IF
comf PORTD
bsf T0CON, TMR0ON
SOUND2_LOOP: btfss INTCON, TMR0IF
bra SOUND2_LOOP
bcf T0CON,TMR0ON
RETURN

SOUND3: movlw 0x03
movwf TEMP 
movlw 	0x00
cpfseq CHECK
movff TEMP,PREINC0				
movlw 0xFA
movwf TMR0H
movlw 0x13
movwf TMR0L
bcf INTCON,TMR0IF
comf PORTD
bsf T0CON, TMR0ON
SOUND3_LOOP: btfss INTCON, TMR0IF
bra SOUND3_LOOP
bcf T0CON,TMR0ON
RETURN



SOUND4: movlw 0x04
movwf TEMP 
movlw 	0x00
cpfseq CHECK
movff TEMP,PREINC0				
movlw 0xFA
movwf TMR0H
movlw 0x68
movwf TMR0L
bcf INTCON,TMR0IF
comf PORTD
bsf T0CON, TMR0ON
SOUND4_LOOP: btfss INTCON, TMR0IF
bra SOUND4_LOOP
bcf T0CON,TMR0ON
RETURN

SOUND5: movlw 0x05
movwf TEMP 
movlw 	0x00
cpfseq CHECK
movff TEMP,PREINC0				
movlw 0xFB
movwf TMR0H
movlw 0x04
movwf TMR0L
bcf INTCON,TMR0IF
comf PORTD
bsf T0CON, TMR0ON
SOUND5_LOOP: btfss INTCON, TMR0IF
bra SOUND5_LOOP
bcf T0CON,TMR0ON
RETURN



SOUND6: movlw 0x06
movwf TEMP 
movlw 	0x00
cpfseq CHECK
movff TEMP,PREINC0				
movlw 0xFB
movwf TMR0H
movlw 0x8F
movwf TMR0L
bcf INTCON,TMR0IF
comf PORTD
bsf T0CON, TMR0ON
SOUND6_LOOP: btfss INTCON, TMR0IF
bra SOUND6_LOOP
bcf T0CON,TMR0ON
RETURN

SOUND7: movlw 0x07
movwf TEMP 
movlw 	0x00
cpfseq CHECK
movff TEMP,PREINC0				
movlw 0xFC
movwf TMR0H
movlw 0x0B
movwf TMR0L
bcf INTCON,TMR0IF
comf PORTD
bsf T0CON, TMR0ON
SOUND7_LOOP: btfss INTCON, TMR0IF
bra SOUND7_LOOP
bcf T0CON,TMR0ON
RETURN



SOUND8: movlw 0x08
movwf TEMP 
movlw 	0x00
cpfseq CHECK
movff TEMP,PREINC0				
movlw 0xFC
movwf TMR0H
movlw 0x44
movwf TMR0L
bcf INTCON,TMR0IF
comf PORTD
bsf T0CON, TMR0ON
SOUND8_LOOP: btfss INTCON, TMR0IF
bra SOUND8_LOOP
bcf T0CON,TMR0ON
RETURN

SOUND9: movlw 0x09
movwf TEMP 
movlw 	0x00
cpfseq CHECK
movff TEMP,PREINC0				
movlw 0xFC
movwf TMR0H
movlw 0xAC
movwf TMR0L
bcf INTCON,TMR0IF
comf PORTD
bsf T0CON, TMR0ON
SOUND9_LOOP: btfss INTCON, TMR0IF
bra SOUND9_LOOP
bcf T0CON,TMR0ON
RETURN



SOUND10: movlw 0x0A
movwf TEMP 
movlw 	0x00
cpfseq CHECK
movff TEMP,PREINC0				
movlw 0xFD
movwf TMR0H
movlw 0x09
movwf TMR0L
bcf INTCON,TMR0IF
comf PORTD
bsf T0CON, TMR0ON
SOUND10_LOOP: btfss INTCON, TMR0IF
bra SOUND10_LOOP
bcf T0CON,TMR0ON
RETURN

SOUND11: movlw 0x0B
movwf TEMP 
movlw 	0x00
cpfseq CHECK
movff TEMP,PREINC0				
movlw 0xFD
movwf TMR0H
movlw 0x34
movwf TMR0L
bcf INTCON,TMR0IF
comf PORTD
bsf T0CON, TMR0ON
SOUND11_LOOP: btfss INTCON, TMR0IF
bra SOUND11_LOOP
bcf T0CON,TMR0ON
RETURN



SOUND12: movlw 0x0C
movwf TEMP 
movlw 	0x00
cpfseq CHECK
movff TEMP,PREINC0				
movlw 0xFD
movwf TMR0H
movlw 0x82
movwf TMR0L
bcf INTCON,TMR0IF
comf PORTD
bsf T0CON, TMR0ON
SOUND12_LOOP: btfss INTCON, TMR0IF
bra SOUND12_LOOP
bcf T0CON,TMR0ON
RETURN






;.......................................
Delay: 			movlw 0xCC
				movwf	DELAY_H
				movwf	DELAY_L
DelayLoop:		decfsz	DELAY_L
				bra		DelayLoop
				decfsz	DELAY_H
				bra		DelayLoop

		
				return

		END