*-----------------------------------------------------------
* ENVIROMENT
* ID             (A0) W
* Background    2(A0) L
* Center Prop   4(A0) W
* Rope          6(A0) W
* Mines         8(A0) W
* Barrels      10(A0) W
*-----------------------------------------------------------
        INCLUDE "BACKGROUNDS/basement.X68"
        INCLUDE "BACKGROUNDS/pine.X68"
        INCLUDE "BACKGROUNDS/sqtree.X68"
        INCLUDE "BACKGROUNDS/tree.X68"
        INCLUDE "BACKGROUNDS/hills1.X68"
        INCLUDE "BACKGROUNDS/hills2.X68"
        INCLUDE "BACKGROUNDS/pines.X68"
        INCLUDE "BACKGROUNDS/sqtrees.X68"
        INCLUDE "BARREL.X68"
        INCLUDE "TOXIC.X68"
        INCLUDE "FIREBALL.X68"
        INCLUDE "TROPHY.X68"
        INCLUDE "LADDER.X68"
        INCLUDE "MINE.X68"
        INCLUDE "CRAB.X68"
        INCLUDE "ROPE.X68"
        
        
*---Initilize Enviroment-------------------------------------------------
ENVINIT
* Inicializa Enviroment
* INPUT:    A0 pointer to instance variables
* OUTPUT:   None
* MODIFIES: None
*--------------------------------------------------------------------
        MOVEM.L D0/A1-A3, -(A7)

        *Almacena el id del enviroment actual
        MOVE.W (ENVID), (A0)
        MOVE.W (A0), D0
        ADDQ.W #1, D0
        MOVE.W D0, (ENVID)
        
        *Elige un fondo
        JSR UTLRAND
        AND.L #$00000003, D0
        MOVE.W D0, 2(A0)
        
        *Elige Center Prop
        *Inicializa los cangrejos para cuando se muestren
        JSR CRABINIT
        
        JSR UTLRAND
        AND.L #$00000003, D0
        MOVE.W D0, 4(A0)

        *Elige si hay cuerda
        JSR UTLRAND
        AND.L #$00000001, D0
        MOVE.W D0, 6(A0)
        JSR ROPEINIT
        
        *Elige si hay minas
        JSR UTLRAND
        AND.L #$00000001, D0
        TST.W D0
        BEQ .TSTTROPHY
        LEA MINEINIT, A1
        LEA MINEUPD, A2
        LEA MINEPLOT, A3
        MOVE.W #4, D0
        JSR AGLADD

.TSTTROPHY
        *elige si hay trofeo
        JSR UTLRAND
        AND.L #$00000003, D0
        TST.W D0
        BNE .TSTBARRELS
        LEA TROPHYINIT, A1
        LEA TROPHYUPD, A2
        LEA TROPHYPLOT, A3
        MOVE.W #5, D0
        JSR AGLADD
        
.TSTBARRELS
        *Elige si hay Barriles
        JSR UTLRAND
        AND.L #$00000001, D0
        MOVE.W D0, 10(A0)
        
        MOVEM.L (A7)+, D0/A1-A3
        RTS
*---Update Enviroment----------------------------------------------------
ENVUPD
* Acltualiza Enviroment
* INPUT:    A0 pointer to instance variables
* OUTPUT:   None
* MODIFIES: None
*--------------------------------------------------------------------
        MOVEM.L D0/A1-A3, -(A7)
        
        MOVE.W (A0), D0
        CMP.W (CURRENV), D0
        BNE .ENDUPD
        
        *Actualiza el prop del centro
        MOVE.W 4(A0), D0
        TST.W D0
        BEQ .NEXT2
        CMP.W #2, D0
        BLT .UPDLADDER
        BEQ .UPDCRABS
        BGT .UPDFIREBALLS
        BRA .NEXT2
.UPDLADDER
        JSR LADDERUPD
        BRA .NEXT2
.UPDCRABS
        JSR CRABUPD
        BRA .NEXT2
.UPDFIREBALLS
        *Updates the fireballs
        MOVE.W 4(A0), D0
        CMP.W #3, D0
        BLT .NEXT2
        
        ADDQ.W #1, D0
        MOVE.W D0, 4(A0)
        CMP #4, D0
        BEQ .NEWFIRE
        CMP #FIRETIM, D0
        BEQ .NEWFIRE
        CMP #FIRETIM*2, D0
        BEQ .NEWFIRE
        BLT .NEXT2
        CMP #FIRETIM*3, D0
        BNE .NEXT2
        MOVE.W #3, 4(A0)
        BRA .NEXT2
.NEWFIRE
        LEA FIREINIT, A1
        LEA FIREUPD, A2
        LEA FIREPLOT, A3
        MOVE.W #3, D0
        JSR AGLADD

.NEXT2
        
        *Actualiza la cuerda
        MOVE.W 6(A0), D0
        TST.W D0
        BEQ .NEXT4
        JSR ROPEUPD
.NEXT4
        
        *Updates the barrels
        MOVE.W 10(A0), D0
        TST.W D0
        BEQ .ENDUPD
        
        ADDQ.W #1, D0
        MOVE.W D0, 10(A0)
        CMP #2, D0
        BEQ .NEWBARREL
        CMP #BARRELTIM, D0
        BEQ .NEWBARREL
        CMP #BARRELTIM*2, D0
        BEQ .NEWBARREL
        BLT .ENDUPD
        MOVE.W #0, 10(A0)
        BRA .ENDUPD
.NEWBARREL
        LEA BARRELINIT, A1
        LEA BARRELUPD, A2
        LEA BARRELPLOT, A3
        MOVE.W #2, D0
        JSR AGLADD

        
.ENDUPD
        MOVEM.L (A7)+, D0/A1-A3
        RTS

*---Plot ENVIROMENT------------------------------------------------------
ENVPLOT
* Pinta Enviroment
* INPUT:    A0 pointer to instance variables
* OUTPUT:   None
* MODIFIES: None
*--------------------------------------------------------------------
        MOVE.W D0, -(A7)
        
        MOVE.W (A0), D0
        CMP.W (CURRENV), D0
        BNE .DONE
        
        *Pinta el fondo
        MOVE.W 2(A0), D0
        TST.W D0
        BEQ .DRAWHILLS1
        CMP.W #2, D0
        BLT .DRAWHILLS2
        BEQ .DRAWPINES
            ;DRAWSQTREES
        JSR SQTREES
        BRA .CONT
.DRAWHILLS1
        JSR HILLS1
        BRA .CONT
.DRAWHILLS2
        JSR HILLS2
        BRA .CONT
.DRAWPINES
        JSR PINES
.CONT
        
        *Dibuja el prop del centro
        MOVE.W 4(A0), D0
        TST.W D0
        BEQ .CONT2
        CMP.W #2, D0
        BLT .DRAWLADDER
        BEQ .DRAWCRABS
            ;DRAWTOXIC
        JSR TOXICPLOT
        BRA .CONT2
.DRAWLADDER
        JSR LADDER
        BRA .CONT2
.DRAWCRABS
        JSR CRABPLOT
.CONT2
        
        *Dibuja la cuerda
        MOVE.W 6(A0), D0
        TST.W D0
        BEQ .DONE
        JSR ROPEPLOT


.DONE
        MOVE.W (A7)+, D0
        RTS


















*~Font name~Courier New~
*~Font size~12~
*~Tab type~1~
*~Tab size~4~
