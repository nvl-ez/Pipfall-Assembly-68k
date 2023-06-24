*-----------------------------------------------------------
* PIPBOY
*-----------------------------------------------------------
        INCLUDE "pipboy/standing.X68"
        INCLUDE "pipboy/running1L.X68"
        INCLUDE "pipboy/running2L.X68"
        INCLUDE "pipboy/running3L.X68"
        INCLUDE "pipboy/running4L.X68"
        INCLUDE "pipboy/running5L.X68"
        INCLUDE "pipboy/running6L.X68"
        INCLUDE "pipboy/running1R.X68"
        INCLUDE "pipboy/running2R.X68"
        INCLUDE "pipboy/running3R.X68"
        INCLUDE "pipboy/running4R.X68"
        INCLUDE "pipboy/running5R.X68"
        INCLUDE "pipboy/running6R.X68"
        INCLUDE "pipboy/climbing1.X68"
        INCLUDE "pipboy/climbing2.X68"
        INCLUDE "pipboy/dead.X68"
        INCLUDE "pipboy/hanging.X68"
        INCLUDE "pipboy/jump1L.X68"
        INCLUDE "pipboy/jump2L.X68"
        INCLUDE "pipboy/jump1R.X68"
        INCLUDE "pipboy/jump2R.X68"
*---Initilize Pipboy-------------------------------------------------
PIPINIT
* Inicializa el pipboy
* INPUT:    None
* OUTPUT:   None
* MODIFIES: None
*--------------------------------------------------------------------
        MOVE.W #PIPSTARTX, (PIPPOSX)
        MOVE.W #PIPFLOOR, (PIPPOSY)
        CLR.W (PIPANIM)
        CLR.W (PIPVELY)
        CLR.W (PIPJUMP)
        CLR.W (PIPHANG)
        CLR.W (PIPREADY)
        CLR.W (PIPCLIMB)
        RTS

*---Update Pipboy----------------------------------------------------
PIPUPD
* Acltualiza el pipboy
* INPUT:    None
* OUTPUT:   None
* MODIFIES: None
*--------------------------------------------------------------------
        MOVEM.L D0-D4/D7/A1-A3, -(A7)  
        *Update Climbing position
        CLR.W D3
        MOVE.W (PIPPOSX), D0
        TST.W (PIPREADY)
        BEQ .UPDPOSX
        MOVE.W (PIPPOSY), D1
        BTST.B #2, (KBDVAL)
        BEQ .CHKDWN1
        ADD.W #PIPCLIMBSP, D3  
        MOVE.W #1, (PIPCLIMB)
.CHKDWN1
        BTST.B #0, (KBDVAL)
        BEQ .NEXT1
        SUB.W #PIPCLIMBSP, D3
        MOVE.W #1, (PIPCLIMB)
        
.NEXT1  TST.W D3
        BEQ .FLOORTST
        MOVE.B #SNDSTEP, D7 ;Si se esta moviendo reproducir el sonido de caminar
        TRAP #SNDPLTN
        ADD.W D3, D1
.FLOORTST
        *Testea si esta tocando el sotano o la tierra
        CMP.W #PIPFLOOR, D1
        BGT .NEXT2
        CLR.W (PIPCLIMB)
        BRA .UPDPOSX
.NEXT2
        CMP.W #PIPBASE, D1
        BLT .NEXT3
        CLR.W (PIPCLIMB)
        BRA .UPDPOSX
.NEXT3
        TST.W (PIPCLIMB)

        BNE .CONT6


.UPDPOSX
        *Update X position   
        CLR.W D3
        BTST.B #3, (KBDVAL)
        BEQ .CHKDWN2
        ADD.W #PIPSPEEDX, D3  
.CHKDWN2
        BTST.B #1, (KBDVAL)
        BEQ .CONT1
        SUB.W #PIPSPEEDX, D3
        
.CONT1  TST.W D3
        BEQ .YUPD
        MOVE.B #SNDSTEP, D7 ;Si se esta moviendo reproducir el sonido de caminar
        TRAP #SNDPLTN
        ADD.W D3, D0
.YUPD
      *Update Y Position
        MOVE.W (PIPPOSY), D1
        MOVE.W (PIPVELY), D2
        TST.W  (PIPJUMP)        *Testea si esta en el aire
        BNE .CONT2              
            
        BTST.B #4, (KBDEDGE)     ;Testea si el espacio esta pulsado
        BEQ .CONT4
        
        TRAP #SNDSPTN
        MOVE.B #SNDJUMP, D7 ;Reproduce el sonido de saltar
        TRAP #SNDPLTN
        TST.W (PIPHANG)         ;Salta de la cuerda
        BEQ .CONTJUMP
        MOVE.W (ROPEPOSX), D0
        TST D3
        BMI .JUMPR
        ADDQ.W #8, D0
        BRA .JUMPROPE
.JUMPR
        SUB.W #8+PIPW, D0
.JUMPROPE
        MOVE.W #0, (PIPHANG)
        MOVE.W #1, (PIPJUMP)
        BRA .CONT6

.CONTJUMP
        SUB.W #PIPSPEEDY, D2
        MOVE.W D2, (PIPVELY)
        MOVE.W #1, (PIPJUMP)
        BRA .CONT3
.CONT2
        ADD.W #PIPGRAV, D2 
        MOVE.W D2, (PIPVELY)   
.CONT3
        ADD.W D2, D1          *Añade la velocidad a la pos
.CONT4
        
        
        CMP.W #PIPFLOOR+100, D1
        BLT .TOUCHFLOOR
        
        CMP.W #PIPBASE, D1 *reinicia el salto cuando toca el sotano
        BLE .CONT5
        MOVE.W #PIPBASE, D1
        MOVE.W #0, (PIPJUMP)
        MOVE.W #0, (PIPVELY)
        BRA .CONT5
        
.TOUCHFLOOR
        CMP.W #PIPFLOOR, D1 *reinicia el salto cuando toca el suelo
        BLE .CONT5
        MOVE.W #PIPFLOOR, D1
        MOVE.W #0, (PIPJUMP)
        MOVE.W #0, (PIPVELY)
.CONT5

        MOVE.W (PIPHANG), D4 *Evalua si esta colgando
        TST.W D4
        BEQ .CONT6
        MOVE.W #0, (PIPVELY)
        MOVE.W #PIPHANGH, D1
        MOVE.W (ROPEPOSX), D0
        SUB.W #41, D0
        
.CONT6
        MOVE.W D1, (PIPPOSY)
        MOVE.W D0, (PIPPOSX)
        
        *Update the animation
        
        *Animar esta colgando
        TST.W D4
        BEQ .NOTHANGING
        MOVE.W #PIPANIMSP*17, (PIPANIM)
        BRA .DONE
.NOTHANGING 

        *Animar escalando
        MOVE.W (PIPCLIMB), D4
        TST.W D4        
        BEQ .NOTCLIMBING  
        ADDQ.W #1, (PIPANIM)
        CMP.W #PIPANIMSP*14, (PIPANIM)
        BGT .CLIMBING
        MOVE.W #PIPANIMSP*14+1, (PIPANIM)
.CLIMBING
        CMP.W #PIPANIMSP*16, (PIPANIM)
        BLT .DONE
        MOVE.W #PIPANIMSP*14+1, (PIPANIM)
        BRA .DONE
.NOTCLIMBING
        TST D3
        BEQ .NOTMOVE
        BPL .RMOVE
        
        TST D2  
        BEQ .NOTJUMPL
        BMI .FALLINGL
        MOVE.W #PIPANIMSP*6+1, (PIPANIM)
        BRA .DONE
.FALLINGL
        MOVE.W #PIPANIMSP*7, (PIPANIM)
        BRA .DONE
        
.NOTJUMPL
        
        CMP.W #PIPANIMSP*6, (PIPANIM)
        BGE .RESETANIML
        ADD.W #1, (PIPANIM)
        BRA .DONE
        
.RESETANIML
        MOVE.W #1, (PIPANIM)
        BRA .DONE
        
.RMOVE
        
        TST D2  
        BEQ .NOTJUMPR
        BMI .FALLINGR
        MOVE.W #PIPANIMSP*13+1, (PIPANIM)
        BRA .DONE
.FALLINGR
        MOVE.W #PIPANIMSP*14, (PIPANIM)
        BRA .DONE
        
.NOTJUMPR
        
        CMP.W #PIPANIMSP*7+1, (PIPANIM)
        BLT .RESETANIMR
        CMP.W #PIPANIMSP*13, (PIPANIM)
        BGE .RESETANIMR
        ADD.W #1, (PIPANIM)
        BRA .DONE
        
.RESETANIMR
        MOVE.W #PIPANIMSP*7+1, (PIPANIM)
        BRA .DONE
        
.NOTMOVE
        MOVE.W #0, (PIPANIM)
        
.DONE
        *Check if has to load right enviroment
        MOVE.W (PIPPOSX), D0
        CMP.W #RXTRIGGER, D0
        BLS .CHECKL
        ADD.W #1, (CURRENV)
        MOVE.W #PIPSTARTX, (PIPPOSX)
        *Check if has to create new enviroment
        MOVE.W (ENVID), D1
        CMP.W (CURRENV), D1
        BNE .ENDUPD
        LEA ENVINIT, A1
        LEA ENVUPD, A2
        LEA ENVPLOT, A3
        MOVE.W #1, D0
        JSR AGLADD
        BRA .ENDUPD
.CHECKL
        CMP.W #LXTRIGGER, D0
        BGT .ENDUPD
        *Test that you're not in the first screen
        MOVE.W (CURRENV), D1
        CMP.W #0, D1
        BNE .LOADPREV
        MOVE.W #LXTRIGGER+1, (PIPPOSX)
        BRA .ENDUPD
        
.LOADPREV 
        MOVE.W (CURRENV), D0
        SUBQ.W #1, D0
        MOVE.W D0, (CURRENV)
        MOVE.W #PIPENDX, (PIPPOSX)
.ENDUPD
        MOVEM.L (A7)+, D0-D4/D7/A1-A3
        RTS

*---Plot Pipboy------------------------------------------------------
PIPPLOT
* Pinta el pipboy
* INPUT:    None
* OUTPUT:   None
* MODIFIES: None
*--------------------------------------------------------------------
        MOVEM.L D1-D2/A6, -(A7)
        
        TST.W (PIPANIM)
        BEQ .ANIM0
        CMP.W #PIPANIMSP, (PIPANIM)
        BLS .ANIM2
        CMP.W #PIPANIMSP*2, (PIPANIM)
        BLS .ANIM4
        CMP.W #PIPANIMSP*3, (PIPANIM)
        BLS .ANIM6
        CMP.W #PIPANIMSP*4, (PIPANIM)
        BLS .ANIM8
        CMP.W #PIPANIMSP*5, (PIPANIM)
        BLS .ANIM10
        CMP.W #PIPANIMSP*6, (PIPANIM)
        BLS .ANIM12
        CMP.W #PIPANIMSP*6+1, (PIPANIM)
        BEQ .ANIM13
        CMP.W #PIPANIMSP*7, (PIPANIM)
        BEQ .ANIM14
        CMP.W #PIPANIMSP*8, (PIPANIM)
        BLS .ANIM16
        CMP.W #PIPANIMSP*9, (PIPANIM)
        BLS .ANIM18
        CMP.W #PIPANIMSP*10, (PIPANIM)
        BLS .ANIM20
        CMP.W #PIPANIMSP*11, (PIPANIM)
        BLS .ANIM22
        CMP.W #PIPANIMSP*12, (PIPANIM)
        BLS .ANIM24
        CMP.W #PIPANIMSP*13, (PIPANIM)
        BLS .ANIM26
        CMP.W #PIPANIMSP*13+1, (PIPANIM)
        BEQ .ANIM27
        CMP.W #PIPANIMSP*14, (PIPANIM)
        BEQ .ANIM28
        CMP.W #PIPANIMSP*15, (PIPANIM)
        BLS .ANIM30
        CMP.W #PIPANIMSP*16, (PIPANIM)
        BLS .ANIM32
        CMP.W #PIPANIMSP*17, (PIPANIM)
        BEQ .ANIM33
        CMP.W #PIPANIMSP*18, (PIPANIM)
        BEQ .ANIM34

.ANIM0
        LEA STANDING, A6
        BRA .DRAW
.ANIM2
        LEA RUNNING1L, A6
        BRA .DRAW
.ANIM4
        LEA RUNNING2L, A6
        BRA .DRAW
.ANIM6
        LEA RUNNING3L, A6
        BRA .DRAW
.ANIM8
        LEA RUNNING4L, A6
        BRA .DRAW
.ANIM10
        LEA RUNNING5L, A6
        BRA .DRAW
.ANIM12
        LEA RUNNING6L, A6
        BRA .DRAW
.ANIM13
        LEA JUMP1L, A6
        BRA .DRAW
.ANIM14
        LEA JUMP2L, A6
        BRA .DRAW
.ANIM16
        LEA RUNNING1R, A6
        BRA .DRAW
.ANIM18
        LEA RUNNING2R, A6
        BRA .DRAW
.ANIM20
        LEA RUNNING3R, A6
        BRA .DRAW
.ANIM22
        LEA RUNNING4R, A6
        BRA .DRAW
.ANIM24
        LEA RUNNING5R, A6
        BRA .DRAW
.ANIM26
        LEA RUNNING6R, A6
        BRA .DRAW
.ANIM27
        LEA JUMP1R, A6
        BRA .DRAW
.ANIM28
        LEA JUMP2R, A6
        BRA .DRAW
.ANIM30
        LEA CLIMBING1, A6
        BRA .DRAW
.ANIM32
        LEA CLIMBING2, A6
        BRA .DRAW
.ANIM33
        LEA HANGING, A6
        BRA .DRAW
.ANIM34
        LEA DEAD, A6
        BRA .DRAW
.DRAW
        MOVE.W (PIPPOSY), D2
        MOVE.W (PIPPOSX), D1
        JSR UTLDRAW
        
        MOVEM.L (A7)+, D1-D2/A6
        RTS






















*~Font name~Courier New~
*~Font size~12~
*~Tab type~1~
*~Tab size~4~
