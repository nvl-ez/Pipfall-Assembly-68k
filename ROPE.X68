*-----------------------------------------------------------
* ROPE
*-----------------------------------------------------------
        INCLUDE "BACKGROUNDS/rope.X68"
*---Initilize Rope-------------------------------------------------
ROPEINIT
* Inicializa la cuerda
* INPUT:    None
* OUTPUT:   None
* MODIFIES: None
*--------------------------------------------------------------------
        MOVE.W #ROPEMIN, (ROPEPOSX)
        MOVE.W #ROPESPEED, (ROPEVELX)
        RTS

*---Update Rope----------------------------------------------------
ROPEUPD
* Acltualiza la cuerda
* INPUT:    None
* OUTPUT:   None
* MODIFIES: None
*--------------------------------------------------------------------
        MOVEM.W D0-D3, -(A7)
        
        MOVE.W (ROPEPOSX), D0
        CMP.W #ROPEMIN, D0
        BLS .PSVEL
        CMP.W #ROPEMAX, D0
        BGT .NGVEL
        BRA .DONE
        
.PSVEL
        MOVE.W #ROPESPEED, (ROPEVELX)
        BRA .DONE
.NGVEL
        MOVE.W #-ROPESPEED, (ROPEVELX)
        BRA .DONE
.DONE
        ADD.W (ROPEVELX), D0
        MOVE.W D0, (ROPEPOSX)
        
        *Verifica si ha colisionado con el jugador
        
        MOVE.W (PIPPOSY), D1
        ADD.W #PIPH, D1
        CMP.W #ROPEBOTOM, D1
        BGT .ENDUPD
        
        *D0-Costado izquierdo del barril
        *D1-Costado derecho del barril
        *D2-Costado izquierdo del jugador
        *D3-Costado derecho del jugador
        
        MOVE.W (PIPPOSX), D2
        MOVE.W D2, D3
        ADD.W #PIPW, D3
        MOVE.W D0, D1
        ADD.W #4, D1
        
        CMP.W D3, D0
        BGT .ENDUPD
        
        CMP.W D2, D1
        BLT .ENDUPD
        MOVE.W #1, (PIPHANG)
        MOVE.W #0, (PIPJUMP)


.ENDUPD
        MOVEM.W (A7)+, D0-D3
        RTS

*---Plot ROPE------------------------------------------------------
ROPEPLOT
* Pinta la cuerda
* INPUT:    None
* OUTPUT:   None
* MODIFIES: None
*--------------------------------------------------------------------
        MOVE.W D1, -(A7)
        
        MOVE.W (ROPEPOSX), D1
        JSR ROPE
        
        MOVE.W (A7)+, D1
        RTS





*~Font name~Courier New~
*~Font size~12~
*~Tab type~1~
*~Tab size~4~
