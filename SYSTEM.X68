*-----------------------------------------------------------
* SYSTEM
*-----------------------------------------------------------

*-----------------------------------------------------------
SYSINIT
* Initilize System
* Input:    none
* Output:   none
* MODIFIES: none
*-----------------------------------------------------------
        JSR SCRINIT
        JSR UTLINIT
        JSR KBDINIT
        JSR SNDINIT
        JSR DMMINIT
        
;Instalar SCRPLOT en trap 0
        MOVE.L  #SCRPLOT, ($80+SCRUPTN*4)
;Instalar KBDUPD en trap 1
        MOVE.L  #KBDUPD, ($80+KBDUPTN*4)
;Instalar SNDPLAY al trap 2
        MOVE.L  #SNDPLAY, ($80+SNDPLTN*4)
;Instalar SNDPLAY al trap 3
        MOVE.L  #SNDSTOP, ($80+SNDSPTN*4)
;Instalar SCRTIM en la interrupcion 1
        MOVE.L  #SCRTIM, ($60+SCRINTN*4)
;Instalar FPSTIM en la interrupcion 1
        MOVE.L  #FPSTIM, ($60+FPSINTN*4)
        
;Pasar a modo Usuario y activar interrupciones
        MOVE.W  SR, -(A7)
        ANDI.W  #$D8FF, (A7)
        RTE
        
*-----------------------------------------------------------
SNDINIT
* Inicializa el sistema de sonido
* Input:    none
* Output:   none
* MODIFIES: none
*-----------------------------------------------------------
        MOVEM.L D0-D1/A0-A1, -(A7)
        CLR.B D1
        LEA .SNDLIST, A0
.LOOP   MOVE.L (A0)+, D0
        BEQ .DONE
        MOVE.L  D0, A1
        
        MOVE.B #71, D0
        TRAP #15
        ADDQ.B #1, D1
        
        BRA .LOOP
.DONE   MOVEM.L (A7)+, D0-D1/A0-A1
        RTS
.FSNDACCEPT  DC.B    'SND/accept.wav',0  *0
.FSNDBARREL  DC.B    'SND/barrel.wav',0  *1
.FSNDCRAB    DC.B    'SND/crab.wav',0    *2
.FSNDDAMAGE  DC.B    'SND/damage.wav',0  *3
.FSNDDEATH   DC.B    'SND/death.wav',0   *4
.FSNDINTRO   DC.B    'SND/intro.wav',0   *5
.FSNDJUMP    DC.B    'SND/jump.wav',0    *6
.FSNDMINE    DC.B    'SND/mine.wav',0    *7
.FSNDSHOOT   DC.B    'SND/shoot.wav',0   *8
.FSNDSTEP    DC.B    'SND/step.wav',0    *9
.FSNDTROPHY  DC.B    'SND/trophy.wav',0  *10


.SNDLIST    DC.L    .FSNDACCEPT, .FSNDBARREL, .FSNDCRAB, .FSNDDAMAGE, .FSNDDEATH, .FSNDINTRO, .FSNDJUMP, .FSNDMINE, .FSNDSHOOT, .FSNDSTEP, .FSNDTROPHY, 0
        
*-----------------------------------------------------------
SNDPLAY
* Play sound
* Input:    D7  sound id
* Output:   none
* MODIFIES: none
*-----------------------------------------------------------
        MOVEM.W D0-D1, -(A7)
        MOVE.B  #72, D0
        MOVE.B  D7, D1
        TRAP #15
        MOVEM.W (A7)+, D0-D1
        RTE

*-----------------------------------------------------------
SNDSTOP
* Stops sounds
* Input:    none
* Output:   none
* MODIFIES: none
*-----------------------------------------------------------
        MOVEM.W D0/D2, -(A7)
        MOVE.B  #76, D0
        MOVE.L  #3, D2
        TRAP #15
        MOVEM.W (A7)+, D0/D2
        RTE

*-----------------------------------------------------------
SCRINIT
* Initilize Screen: Set creeen res., Set windowed, clear,
* enable double buffer, enable timed interrupt
* Input:    none
* Output:   none
* MODIFIES: none
*-----------------------------------------------------------

        MOVEM.L D0-D3, -(A7)

*Set screeen resolution
        MOVE.B  #33, D0
        MOVE.L  #SCRW<<16|SCRH,D1
        TRAP    #15

*Set windowed
        MOVE.L  #1, D1
        TRAP    #15

*Clear window
        MOVE.B  #11, D0
        MOVE.W  #$FF00, D1
        TRAP    #15
        
*Enable double buffer
        MOVE.B  #92, D0
        MOVE.B  #17, D1
        TRAP    #15
        
*Enable timed interrupt
        MOVE.B  #32, D0
        MOVE.B  #6, D1
        MOVE.B  #$80|SCRINTN, D2
        MOVE.L  #1000/SCRFPS, D3
        TRAP    #15
        
*Enable timed fps interrupt
        MOVE.B  #32, D0
        MOVE.B  #6, D1
        MOVE.B  #$80|FPSINTN, D2
        MOVE.L  #1000, D3
        TRAP    #15
        
*Clear Interrupt counters
        CLR.B   (SCRINTCT)
        CLR.B   (FPSCT)

        MOVEM.L (A7)+, D0-D3
        RTS

*-----------------------------------------------------------
KBDINIT
* Initilize Keyboard
* Input:    none
* Output:   none
* MODIFIES: none
*-----------------------------------------------------------
        CLR.B (KBDVAL)
        CLR.B (KBDEDGE)
        RTS

*-----------------------------------------------------------
SCRPLOT
* Update double buffer
* Input:    D6, specifies if to clear screen or not
* Output:   none
* MODIFIES: none
*-----------------------------------------------------------

        MOVEM.W D0-D1, -(A7)
        
;Switch double buffers
        MOVE.B  #94, D0
        TRAP    #15
;Clear screen

        TST.W D6
        BEQ .ENDSCRPLOT
        
        MOVE.B  #11, D0
        MOVE.W  #$FF00, D1
        TRAP    #15
.ENDSCRPLOT
        MOVEM.W (A7)+, D0-D1
        RTE


*-----------------------------------------------------------
SCRTIM
* Timed interrupt service rutine
* Input:    none
* Output:   none
* MODIFIES: none
*-----------------------------------------------------------

        ADDQ.B  #1, (SCRINTCT)
        ADDQ.B  #1, (SCRCYCCT)
        RTE

*-----------------------------------------------------------
FPSTIM
* Timed interrupt that updates the frames per second
* Input:    none
* Output:   none
* MODIFIES: none
*-----------------------------------------------------------

        MOVE.B  (FPSCT), (FPS)
        CLR.B (FPSCT)
        RTE

*-----------------------------------------------------------
KBDUPD
* Update keyboard info
* Input:    none
* Output:   none
* MODIFIES: none
*-----------------------------------------------------------
        
* 7
* 6
* 5: ESC
* 4: space
* 3: d
* 2: s
* 1: a
* 0: w
        MOVEM.L D0-D3,-(A7)
        CLR.L   D2
*Read first keys
        MOVE.B  #19, D0
        MOVE.L  #0<<24|0<<16|KBDESC<<8|KBDJUMP, D1
        TRAP    #15

*Convert to desired format
        JSR     .PACK

*Read next keys
        MOVE.L  #KBDD<<24|KBDS<<16|KBDA<<8|KBDW, D1
        TRAP    #15
        
*Convert to desired format
        JSR     .PACK

*Calculate KBDEDGE
        MOVE.B  (KBDVAL), D0
        NOT.B   D0
        AND.B   D2, D0
        MOVE.B  D0, (KBDEDGE)
        MOVE.B  D2, (KBDVAL)
        
        MOVEM.L (A7)+, D0-D3
        RTE

.PACK
        MOVE.W  #3, D3
.LOOP
        LSL.L   #8, D1
        ROXL.B  #1, D2
        DBRA.W D3, .LOOP
        RTS








*~Font name~Courier New~
*~Font size~12~
*~Tab type~1~
*~Tab size~4~
