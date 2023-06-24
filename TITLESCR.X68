*-----------------------------------------------------------
* Title Screen
*-----------------------------------------------------------
        INCLUDE "BACKGROUNDS/logo.X68"
*---Initilize Title Screen-------------------------------------------------
TITLESCRINIT
* Inicializa la pantalla de inicio
* INPUT:    None
* OUTPUT:   None
* MODIFIES: None
*--------------------------------------------------------------------
        *Se pinta el logo solo una vaz para que no vaya muy lento
        MOVEM.L D1-D2/A6, -(A7)
        MOVE.W #35, D1
        MOVE.W #50, D2
        LEA LOGO, A6
        JSR UTLDRAW
        MOVEM.L (A7)+, D1-D2/A6
        RTS

*---Update Title Screen----------------------------------------------------
TITLESCRUPD
* Acltualiza la pantalla de inicio
* INPUT:    None
* OUTPUT:   None
* MODIFIES: None
*--------------------------------------------------------------------
        MOVE.W D7, -(A7)
        *Play sound
        MOVE.B #SNDINTRO, D7
        TRAP #SNDPLTN
        
        BTST.B #5, (KBDVAL)
        BEQ .ENDUPD
        *Cambia la pantalla si se pulsa ESC
        MOVE.W #1, (STATE)
        TRAP #SNDSPTN
        MOVE.B #SNDACCEPT, D7
        TRAP #SNDPLTN
        
.ENDUPD 
        MOVE.W (A7)+, D7
        RTS

*---Plot Title Screen------------------------------------------------------
TITLESCRPLOT
* Pinta la pantalla de inicio
* INPUT:    None
* OUTPUT:   None
* MODIFIES: None
*--------------------------------------------------------------------
        MOVEM.L D0-D4/A0, -(A7)
        
        BTST.B #4, (SCRCYCCT)
        BEQ .PRINTTXT
        
        *Cover the text
        MOVE.B #81, D0
        MOVE.L #BLACK, D1
        TRAP #15
        MOVE.B #80, D0
        TRAP #15
        
        MOVE.B #88, D0
        MOVE.W #0, D1
        MOVE.W #320, D2
        MOVE.W #600, D3
        MOVE.W #400, D4
        TRAP #15
        BRA .ENDPLOT
        
        
        
.PRINTTXT
        *Change color and font
        MOVE.B #81,D0
        MOVE.L #BLACK, D1
        TRAP #15
        
        MOVE.B #21,D0
        MOVE.L #NEOGREEN, D1
        CLR.B D2
        TRAP #15
        
        LEA .TXT1, A0
        MOVE.B #25, D0
        JSR UTLPRINT
        
.ENDPLOT
        MOVEM.L (A7)+, D0-D4/A0
        RTS


.TXT1   DC.B 'Press ESC to Start the Game',0
        DS.W 0







*~Font name~Courier New~
*~Font size~12~
*~Tab type~1~
*~Tab size~4~
