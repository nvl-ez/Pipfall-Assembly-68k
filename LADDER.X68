*-----------------------------------------------------------
* LADDER
*-----------------------------------------------------------
        INCLUDE "BACKGROUNDS/ladder.X68"

*---Update Ladder----------------------------------------------------
LADDERUPD
* Acltualiza la escalera
* INPUT:    None
* OUTPUT:   None
* MODIFIES: None
*--------------------------------------------------------------------
        MOVEM.W D0-D3, -(A7)        
        
        *Verifica si ha colisionado con el jugador
        
        MOVE.W (PIPPOSY), D1
        ADD.W #PIPH, D1
        CMP.W #PROPY-10, D1
        BLT .NOTREADY
        
        *D0-Costado izquierdo del barril
        *D1-Costado derecho del barril
        *D2-Costado izquierdo del jugador
        *D3-Costado derecho del jugador
        
        MOVE.W (PIPPOSX), D2
        MOVE.W D2, D3
        ADD.W #PIPW, D3
        MOVE.W #LADDERX, D0
        MOVE.W D0, D1
        ADD.W #LADDERW , D1
        
        CMP.W D3, D0
        BGT .NOTREADY
        
        CMP.W D2, D1
        BLT .NOTREADY
        MOVE.W #1, (PIPREADY)
        BRA .ENDUPD
.NOTREADY
        CLR.W (PIPREADY)

.ENDUPD
        MOVEM.W (A7)+, D0-D3
        RTS

*---Plot Ladder------------------------------------------------------
LADDERPLOT
* Pinta la escalera
* INPUT:    None
* OUTPUT:   None
* MODIFIES: None
*--------------------------------------------------------------------
        JSR LADDER
        RTS






*~Font name~Courier New~
*~Font size~12~
*~Tab type~1~
*~Tab size~4~
