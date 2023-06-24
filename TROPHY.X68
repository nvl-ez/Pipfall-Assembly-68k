*-----------------------------------------------------------
* TROPHY
* Parent Enviroment (W) (A0)
* Used (W) 2(A0)
*-----------------------------------------------------------
        INCLUDE "BACKGROUNDS/trophy.X68"
*---Initilize TROPHY-------------------------------------------------
TROPHYINIT
* Inicializa el trofeo
* INPUT:    None
* OUTPUT:   None
* MODIFIES: None
*--------------------------------------------------------------------
        MOVE.W (CURRENV), (A0)
        RTS

*---Update TROPHY----------------------------------------------------
TROPHYUPD
* Acltualiza el trofeo
* INPUT:    None
* OUTPUT:   None
* MODIFIES: None
*--------------------------------------------------------------------
        MOVEM.W D0-D3/D7, -(A7)        
        MOVE.W (A0), D0
        CMP.W (CURRENV), D0
        BNE .ENDUPD        
        *No se recoge si esta en el sotano
        CMP.W #PIPFLOOR+10, (PIPPOSY) 
        BGT .ENDUPD
        *Verifica si ha colisionado con el jugador
        
        MOVE.W (PIPPOSY), D1
        ADD.W #PIPH, D1
        CMP.W #PROPY-10, D1
        BLT .ENDUPD
        
        *D0-Costado izquierdo del barril
        *D1-Costado derecho del barril
        *D2-Costado izquierdo del jugador
        *D3-Costado derecho del jugador
        
        MOVE.W (PIPPOSX), D2
        MOVE.W D2, D3
        ADD.W #PIPW, D3
        MOVE.W #TROPHYX, D0
        MOVE.W D0, D1
        ADD.W #TROPHYW, D1
        
        CMP.W D3, D0
        BGT .ENDUPD
        
        CMP.W D2, D1
        BLT .ENDUPD
        MOVE.W #1, 2(A0)
        ADD.W #1, (SCORE)
        JSR AGLKILL
        
        ;Play sound
        TRAP #SNDSPTN
        MOVE.B #SNDTROPHY, D7
        TRAP #SNDPLTN
        
.ENDUPD
        MOVEM.W (A7)+, D0-D3/D7
        RTS

*---Plot TROPHY------------------------------------------------------
TROPHYPLOT
* Pinta el trofeo
* INPUT:    None
* OUTPUT:   None
* MODIFIES: None
*--------------------------------------------------------------------
        MOVEM.L D0-D2/A6, -(A7)
        
        MOVE.W (A0), D0
        CMP.W (CURRENV), D0
        BNE .ENDPLOT
        
        MOVE.W #TROPHYX, D1
        MOVE.W #PROPY-75, D2
        LEA TROPHY, A6
        JSR UTLDRAW
        
.ENDPLOT
        MOVEM.L (A7)+, D0-D2/A6
        RTS







*~Font name~Courier New~
*~Font size~12~
*~Tab type~1~
*~Tab size~4~
