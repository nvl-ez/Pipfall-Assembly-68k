*-----------------------------------------------------------
* MINE
* Father Enviroment (W) A0
* AnimationM1 (W) 2(A0)
* AnimationM2 (W) 4(A0)
*-----------------------------------------------------------
        INCLUDE "explosion/mine.X68"
        INCLUDE "explosion/explosion1.X68"
        INCLUDE "explosion/explosion2.X68"
        INCLUDE "explosion/explosion3.X68"
*---Initilize Mine---------------------------------------------------
MINEINIT
* Inicializa la mina
* INPUT:    None
* OUTPUT:   None
* MODIFIES: None
*--------------------------------------------------------------------
        MOVE.W (CURRENV), (A0)
        MOVE.W #0, 2(A0)
        MOVE.W #0, 4(A0)
        RTS

*---Update Mine------------------------------------------------------
MINEUPD
* Acltualiza la mina
* INPUT:    None
* OUTPUT:   None
* MODIFIES: None
*--------------------------------------------------------------------
        MOVEM.W D0-D3, -(A7)
        
        MOVE.W (A0), D0
        CMP.W (CURRENV), D0
        BNE .ENDUPD
        
        CMP.W #PIPFLOOR+100, (PIPPOSY) *No actualizar minas si esta en el sotano
        BGT .ENDUPD
        
        *Calcular colision con la mina 1
        MOVE.W 2(A0), D0
        TST.W D0
        BEQ .CHECKM1
        CMP.W #MINEANIMSP*3, D0
        BEQ .CHECKANIM2
        ADDQ.W #1, D0
        MOVE.W D0, 2(A0)

        
.CHECKM1
        MOVE.W (PIPPOSY), D1
        ADD.W #PIPH, D1
        CMP.W #PROPY-10, D1
        BLT .CHECKANIM2
        
        *D0-Costado izquierdo del barril
        *D1-Costado derecho del barril
        *D2-Costado izquierdo del jugador
        *D3-Costado derecho del jugador
        
        MOVE.W (PIPPOSX), D2
        MOVE.W D2, D3
        ADD.W #PIPW, D3
        MOVE.W #LMINE, D0
        MOVE.W D0, D1
        ADD.W #MINEW, D1
        
        CMP.W D3, D0
        BGT .CHECKANIM2
        
        CMP.W D2, D1
        BLT .CHECKANIM2
        ADD.W #1, 2(A0)
        JSR DEALDMG
        
.CHECKANIM2
        *Calcular colision con la mina 1
        MOVE.W 4(A0), D0
        TST.W D0
        BEQ .CHECKM2
        CMP.W #MINEANIMSP*3, D0
        BEQ .ENDUPD
        ADDQ.W #1, D0
        MOVE.W D0, 4(A0)
        
.CHECKM2
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
        MOVE.W #RMINE, D0
        MOVE.W D0, D1
        ADD.W #MINEW, D1
        
        CMP.W D3, D0
        BGT .ENDUPD
        
        CMP.W D2, D1
        BLT .ENDUPD
        ADD.W #1, 4(A0)
        JSR DEALDMG

        
.ENDUPD
        MOVEM.W (A7)+, D0-D3
        RTS

*---Plot Mine--------------------------------------------------------
MINEPLOT
* Pinta la Mina
* INPUT:    None
* OUTPUT:   None
* MODIFIES: None
*--------------------------------------------------------------------
        MOVEM.L D0-D2/A6, -(A7)
        MOVE.W (A0), D0
        CMP.W (CURRENV), D0
        BNE .ENDPLOT
        
        MOVE.W 2(A0), D0
        TST.W D0
        BNE .M1ANIM1
        MOVE.W #LMINE, D1
        MOVE.W #PROPY, D2
        JSR MINE
        BRA .M2
.M1ANIM1
        CMP.W #MINEANIMSP, D0
        BGT .M1ANIM2
        MOVE.W #MINEANIMX, D1
        MOVE.W #MINEANIMY, D2
        LEA EXPLOSION1, A6
        JSR UTLDRAW
        BRA .M2
.M1ANIM2
        CMP.W #MINEANIMSP*2, D0
        BGT .M1ANIM3
        MOVE.W #MINEANIMX, D1
        MOVE.W #MINEANIMY, D2
        LEA EXPLOSION2, A6
        JSR UTLDRAW
        BRA .M2
.M1ANIM3
        CMP.W #MINEANIMSP*3, D0
        BGE .M2
        MOVE.W #MINEANIMX, D1
        MOVE.W #MINEANIMY, D2
        LEA EXPLOSION3, A6
        JSR UTLDRAW
.M2
        
        MOVE.W 4(A0), D0
        TST.W D0
        BNE .M2ANIM1
        MOVE.W #RMINE, D1
        MOVE.W #PROPY, D2
        JSR MINE
        BRA .ENDPLOT
.M2ANIM1
        CMP.W #MINEANIMSP, D0
        BGT .M2ANIM2
        MOVE.W #SCRW-MINEANIMX*2-50, D1
        MOVE.W #MINEANIMY, D2
        LEA EXPLOSION1, A6
        JSR UTLDRAW
        BRA .ENDPLOT
.M2ANIM2
        CMP.W #MINEANIMSP*2, D0
        BGT .M2ANIM3
        MOVE.W #SCRW-MINEANIMX*2-50, D1
        MOVE.W #MINEANIMY, D2
        LEA EXPLOSION2, A6
        JSR UTLDRAW
        BRA .ENDPLOT
.M2ANIM3
        CMP.W #MINEANIMSP*3, D0
        BGE .ENDPLOT
        MOVE.W #SCRW-MINEANIMX*2-50, D1
        MOVE.W #MINEANIMY, D2
        LEA EXPLOSION3, A6
        JSR UTLDRAW
        

        
.ENDPLOT
        MOVEM.L (A7)+, D0-D2/A6
        RTS




*~Font name~Courier New~
*~Font size~12~
*~Tab type~1~
*~Tab size~4~
