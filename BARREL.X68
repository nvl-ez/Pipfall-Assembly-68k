*-----------------------------------------------------------
* BARREL
* BARRELPOSX (W) (A0)
* Father Enviroment (W) 2(A0)
*-----------------------------------------------------------
        INCLUDE "BACKGROUNDS/barrel.X68"
*---Initilize Barrel-------------------------------------------------
BARRELINIT
* Inicializa el barril
* INPUT:    A0 pointer to instance variables
* OUTPUT:   None
* MODIFIES: None
*--------------------------------------------------------------------
            MOVE.W D7, -(A7)
            
            MOVE.W #BARRELX, (A0)
            MOVE.W (CURRENV), 2(A0)
            
            *Solo se reproduce el sonido cuando spawnea
            TRAP #SNDSPTN
            MOVE.B #SNDBARREL, D7
            TRAP #SNDPLTN
            
            MOVE.W (A7)+, D7
        RTS

*---Update Barrel----------------------------------------------------
BARRELUPD
* Acltualiza el barril
* INPUT:    A0 pointer to instance variables
* OUTPUT:   None
* MODIFIES: None
*--------------------------------------------------------------------
        
        MOVEM.W D0-D3, -(A7)
        *Actualiza la posicion del barril
        MOVE.W 2(A0), D0
        CMP.W (CURRENV), D0
        BNE .END
        
        MOVE.W (A0), D0
        CMP #-20, D0
        BGT .CONT
        JSR AGLKILL
        BRA .ENDMOVE

.CONT
        SUB.W #BARRELSP, D0
        MOVE.W D0, (A0)
.ENDMOVE
        
        *Verifica si ha colisionado con el jugador
        
        MOVE.W (PIPPOSY), D1
        ADD.W #PIPH, D1
        CMP.W #PROPY-10, D1
        BLT .END
        
        *D0-Costado izquierdo del barril
        *D1-Costado derecho del barril
        *D2-Costado izquierdo del jugador
        *D3-Costado derecho del jugador
        
        MOVE.W (PIPPOSX), D2
        MOVE.W D2, D3
        ADD.W #PIPW, D3
        MOVE.W D0, D1
        ADD.W #BARRELW, D1
        
        CMP.W D3, D0
        BGT .END
        
        CMP.W D2, D1
        BLT .END
        JSR DEALDMG
        
        
.END
        MOVEM.W (A7)+, D0-D3
        RTS

*---Plot Barrel------------------------------------------------------
BARRELPLOT
* Pinta el barril
* INPUT:    A0 pointer to instance variables
* OUTPUT:   None
* MODIFIES: None
*--------------------------------------------------------------------
        MOVEM.W D0-D1, -(A7)
        
        MOVE.W 2(A0), D0
        CMP.W (CURRENV), D0
        BNE .ENDPLOT
        
        MOVE.W (A0), D1
        JSR BARREL
        
.ENDPLOT
        MOVEM.W (A7)+, D0-D1
        RTS
















*~Font name~Courier New~
*~Font size~12~
*~Tab type~1~
*~Tab size~4~
