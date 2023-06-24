*--------------------------------------------------------------------
* SCOREBOARD
*--------------------------------------------------------------------

*---Initilize Score Board--------------------------------------------
SBINIT
* Inicializa el Score Board
* INPUT:    None
* OUTPUT:   None
* MODIFIES: None
*--------------------------------------------------------------------
        MOVE.W #5, (PIPHP)
        MOVE.W #INVTIM*5, (TRUEHP)
        MOVE.W #SCRFPS*60, (TRUETIME)
        CLR.W (SCORE)
        RTS

*---Update Score Board-----------------------------------------------
SBUPD
* Acltualiza el Score Board
* INPUT:    None
* OUTPUT:   None
* MODIFIES: None
*--------------------------------------------------------------------
        MOVEM.L D0/D7, -(A7)
        
        *Testea que no se haya quedado sin tiempo
        TST.W (TIME)
        BNE .TSTHP
        MOVE.W #2, (STATE)
        BRA .ENDUPD

.TSTHP
        *Testea que no se haya quedado sin vida
        TST.W (PIPHP)
        BNE .TSTTROPHY
        MOVE.W #2, (STATE)
        
        ;Play death sound
        TRAP #SNDSPTN
        MOVE.B #SNDDEATH, D7
        TRAP #SNDPLTN
        
        BRA .ENDUPD

.TSTTROPHY
        *Testea que no haya recogido todos los trofeos
        CMP.W #3, (SCORE)
        BNE .TIMEUPD
        MOVE.W #2, (STATE)
        BRA .ENDUPD
        
.TIMEUPD
        *Actualiza el tiempo
        MOVE.W (TRUETIME), D0
        SUBQ.W #1, D0
        MOVE.W D0, (TRUETIME)
        DIVU.W #SCRFPS, D0
        MOVE.W D0, (TIME)
        
        
.ENDUPD
        MOVEM.L (A7)+, D0/D7
        RTS

*---Plot Score Board-------------------------------------------------
SBPLOT
* Pinta el Score Board
* INPUT:    None
* OUTPUT:   None
* MODIFIES: None
*--------------------------------------------------------------------

        MOVEM.L D0-D2/A1, -(A7)

*Change color and font
        MOVE.B #81,D0
        MOVE.L #SBBKCOL, D1
        TRAP #15
        
        MOVE.B #21,D0
        MOVE.L #SBPNCOL, D1
        CLR.B D2
        MOVE.B #0, D2
        TRAP #15
        
*Print HP
        *Mover cursor
        MOVE.B #11, D0
        CLR.L D1
        MOVE.W #HPPOS, D1
        TRAP #15
        
        *Print HP variable
        MOVE.B #3, D0
        MOVE.W (PIPHP), D1
        TRAP #15
        
        *Print HP texto
        MOVE.B #14, D0
        LEA .TXT1, A1
        TRAP #15
        
*Print time
        *Mover cursor
        MOVE.B #11, D0
        MOVE.W #TIMEPOS, D1
        TRAP #15
        
        *Print HP variable
        MOVE.B #3, D0
        MOVE.W (TIME), D1
        TRAP #15
        
*Print Points
        *Mover cursor
        MOVE.B #11, D0
        CLR.L D1
        MOVE.W #SCOREPOS, D1
        TRAP #15
        
        *Print HP variable
        MOVE.B #3, D0
        MOVE.W (SCORE), D1
        TRAP #15
        
        *Print HP texto
        MOVE.B #14, D0
        LEA .TXT2, A1
        TRAP #15
        
*Print FPS
        *Mover cursor
        MOVE.B #11, D0
        CLR.L D1
        MOVE.W #FPSPOS, D1
        TRAP #15
        
        *Print FPS texto1
        MOVE.B #14, D0
        LEA .TXT3, A1
        TRAP #15
        
        *Print FPS constante
        MOVE.B #3, D0
        MOVE.W #SCRFPS, D1
        TRAP #15
        
        *Print FPS texto2
        MOVE.B #14, D0
        LEA .TXT4, A1
        TRAP #15
        
        *Print FPS variable
        MOVE.B #3, D0
        MOVE.B (FPS), D1
        TRAP #15
        
        *Print FPS texto3
        MOVE.B #14, D0
        LEA .TXT5, A1
        TRAP #15
        
        MOVEM.L (A7)+, D0-D2/A1
        RTS
.TXT1   DC.B    '/5 HP',0
.TXT2   DC.B    '/3 Trophys',0
.TXT3   DC.B    'GOAL: ',0
.TXT4   DC.B    ' FPS - ACTUAL: ',0
.TXT5   DC.B    ' FPS',0
        DS.W    1








*~Font name~Courier New~
*~Font size~12~
*~Tab type~1~
*~Tab size~4~
