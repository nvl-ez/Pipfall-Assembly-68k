*-----------------------------------------------------------
* CRAB
*-----------------------------------------------------------
        INCLUDE "crab/crab1.X68"
        INCLUDE "crab/crab2.X68"
*---Initilize Crab-------------------------------------------------
CRABINIT
* Inicializa el cangrejo
* INPUT:    None
* OUTPUT:   None
* MODIFIES: None
*--------------------------------------------------------------------
        MOVE.W #0, (ATACKING)
        RTS

*---Update Crab----------------------------------------------------
CRABUPD
* Acltualiza el cangrejo
* INPUT:    None
* OUTPUT:   None
* MODIFIES: None
*--------------------------------------------------------------------
        MOVEM.W D0-D3/D7, -(A7)        

        ADD.W #1, (ATACKING)
        CMP.W #ATCKSP*2, (ATACKING)
        BNE .TSTDMG
        MOVE.W #0, (ATACKING)
        ;play sound
        TRAP #SNDSPTN
        MOVE.B #SNDCRAB, D7
        TRAP #SNDPLTN
.TSTDMG
        *Verifica si ha colisionado con el jugador
        
        MOVE.W (PIPPOSY), D1
        ADD.W #PIPH, D1
        CMP.W #PROPY-10, D1
        BLT .ENDUPD
        
        *D0-Costado izquierdo del barril
        *D1-Costado derecho del barril
        *D2-Costado izquierdo del jugador
        *D3-Costado derecho del jugador
        
        MOVE.W (ATACKING), D0
        CMP.W #ATCKSP, D0
        BLT .ATACK
        *Not atacking
        MOVE.W (PIPPOSX), D2
        MOVE.W D2, D3
        ADD.W #PIPW, D3
        MOVE.W #(SCRW/2)-60, D0
        MOVE.W #(SCRW/2)-38, D1
        
        CMP.W D3, D0
        BGT .NOATACK
        CMP.W D2, D1
        BLT .NOATACK
        JSR DEALDMG
.NOATACK
        MOVE.W #(SCRW/2)+60, D1
        MOVE.W #(SCRW/2)+38, D0
        CMP.W D3, D0
        BGT .ENDUPD
        CMP.W D2, D1
        BLT .ENDUPD
        JSR DEALDMG
        
        BRA .ENDUPD
.ATACK
        MOVE.W (PIPPOSX), D2
        MOVE.W D2, D3
        ADD.W #PIPW, D3
        MOVE.W #(SCRW/2)-60, D0
        MOVE.W #(SCRW/2)+60, D1
        
        CMP.W D3, D0
        BGT .ENDUPD
        CMP.W D2, D1
        BLT .ENDUPD
        JSR DEALDMG

.ENDUPD
        MOVEM.W (A7)+, D0-D3/D7
        RTS

*---Plot Crab------------------------------------------------------
CRABPLOT
* Pinta el cangrejo
* INPUT:    None
* OUTPUT:   None
* MODIFIES: None
*--------------------------------------------------------------------
        MOVEM.L D0-D4/A6, -(A7)
        *set pen color
        MOVE.B #81, D0
        MOVE.L #BLACK, D1
        TRAP #15
        MOVE.B #80, D0
        MOVE.L #NEOGREEN, D1
        TRAP #15
        
        *DRAW pond
        MOVE.B #88, D0
        MOVE.W #(SCRW/2)-60, D1
        MOVE.W #PROPY-30, D2
        MOVE.W #(SCRW/2)+60, D3
        MOVE.W #PROPY+30, D4
        TRAP #15

        *reset pen color
        MOVE.B #80, D0
        MOVE.L #BLACK, D1
        TRAP #15
        
        *Draw crabs
        MOVE.W (ATACKING), D0
        CMP.W #ATCKSP, D0
        BLT .ATACKANIM
        MOVE.W #NOATCKX, D1
        MOVE.W #NOATCKY, D2
        LEA CRAB1, A6
        JSR UTLDRAW
        BRA .ENDPLOT
.ATACKANIM
        MOVE.W #ATCKX, D1
        MOVE.W #ATCKY, D2
        LEA CRAB2, A6
        JSR UTLDRAW
        
        
.ENDPLOT
        MOVEM.L (A7)+, D0-D4/A6
        RTS



*~Font name~Courier New~
*~Font size~12~
*~Tab type~1~
*~Tab size~4~
