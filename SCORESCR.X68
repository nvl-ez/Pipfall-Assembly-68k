*-----------------------------------------------------------
* Title Screen
*-----------------------------------------------------------

*---------------------------------------------------------------------------------------------------------------
SCORESCRPLOT
* Pinta la pantalla de puntuacion
* INPUT:    None
* OUTPUT:   None
* MODIFIES: None
*--------------------------------------------------------------------
        MOVEM.L D0-D4/A0-A1/A6, -(A7)
        *Change color and font
        MOVE.B #81,D0
        MOVE.L #BLACK, D1
        TRAP #15
        
        MOVE.B #21,D0
        MOVE.L #NEOGREEN, D1
        CLR.B D2
        TRAP #15
        
*Testea que no se haya quedado sin vida
        TST.W (PIPHP)
        BNE .TSTTIME
        LEA .DEADTXT, A0
        MOVE.B #2, D0
        JSR UTLPRINT
        LEA DEAD, A6
        BRA .CALCPOINTS

.TSTTIME
*Testea que no se haya quedado sin tiempo
        TST.W (TIME)
        BNE .ALLTROPHYS
        LEA .TIMETXT, A0
        MOVE.B #2, D0
        JSR UTLPRINT
        LEA DEAD, A6
        BRA .CALCPOINTS
        
.ALLTROPHYS
        LEA .VICTORYTXT, A0
        MOVE.B #2, D0
        JSR UTLPRINT
        LEA STANDING, A6

.CALCPOINTS
*Calcula los puntos obtenidos
        CLR.L D1
        
*Puntos de Enviroment
        *Mover cursor
        MOVE.B #11, D0
        MOVE.W #ENVPPOS, D1
        TRAP #15
        
        *Print ENV constante
        MOVE.B #14, D0
        LEA .ENVTXT, A1
        TRAP #15
        
        *Print ENV variable
        MOVE.B #3, D0
        MOVE.W (ENVID), D1
        TRAP #15
        
*Puntos de vida
        *Mover cursor
        MOVE.B #11, D0
        MOVE.W #HPPPOS, D1
        TRAP #15
        
        *Print HP constante
        MOVE.B #14, D0
        LEA .HEALTHTXT, A1
        TRAP #15
        
        *Print HP variable
        MOVE.B #3, D0
        MOVE.W (PIPHP), D1
        TRAP #15
        
        *Print multiplicador HP
        MOVE.B #14, D0
        LEA .HPMULTTXT, A1
        TRAP #15
        
*Puntos de tiempo
        *Mover cursor
        MOVE.B #11, D0
        MOVE.W #TIMPPOS, D1
        TRAP #15
        
        *Print Tiempo constante
        MOVE.B #14, D0
        LEA .TIMTXT, A1
        TRAP #15
        
        *Print Tiempo variable
        MOVE.B #3, D0
        MOVE.W (TIME), D1
        TRAP #15
        
        *Print multiplicador Tiempo
        MOVE.B #14, D0
        LEA .TIMMULTXT, A1
        TRAP #15

*Puntos de trofeo
        *Mover cursor
        MOVE.B #11, D0
        MOVE.W #TROPPOS, D1
        TRAP #15
        
        *Print Trofeo constante
        MOVE.B #14, D0
        LEA .TROPHYTXT, A1
        TRAP #15
        
        *Print Trofeo variable
        MOVE.B #3, D0
        MOVE.W (SCORE), D1
        TRAP #15

*Dibuja linea separadora

        *set fill color
        MOVE.B #81, D0
        MOVE.L #NEOGREEN, D1
        TRAP #15
        *dibuja linea
        MOVE.B #87, D0
        MOVE.W #50, D1
        MOVE.W #280, D2
        MOVE.W #SCRW-50, D3
        MOVE.W #285, D4
        TRAP #15
        *reset fill color
        MOVE.B #81, D0
        MOVE.L #BLACK, D1
        TRAP #15
        
*Puntos Totales
        *Mover cursor
        MOVE.B #11, D0
        MOVE.W #TOTPPOS, D1
        TRAP #15
        
        *Print Puntos totales constante
        MOVE.B #14, D0
        LEA .POINTSTXT, A1
        TRAP #15
        
        *Print Puntos totales variable
        MOVE.W (ENVID), D1
        MOVE.W (PIPHP), D0
        MULU.W #10, D0
        ADD.W D0, D1
        MOVE.W (TIME), D0
        MULU.W #5, D0
        ADD.W D0, D1
        MULU.W (SCORE), D1
        MOVE.B #3, D0
        TRAP #15

*Muestra PipBoy
        MOVE.W #370, D1
        MOVE.W #150, D2
        JSR UTLDRAW

*Imprime mensaje
        BTST.B #4, (SCRCYCCT)
        BNE .ENDPLOT
        
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
        MOVEM.L (A7)+, D0-D4/A0-A1/A6
        RTS


.DEADTXT    DC.B 'Game Over: You Died',0
.TIMETXT    DC.B 'Game Over: Time Ran Out',0
.VICTORYTXT DC.B 'Congratulations: You Won',0
.POINTSTXT  DC.B 'Total Points: ',0
.ENVTXT     DC.B 'Places Discovered: ',0
.HEALTHTXT  DC.B 'Health Points Left: ',0
.HPMULTTXT  DC.B ' * 10',0
.TROPHYTXT  DC.B 'Trophys Obtained: ',0
.TIMTXT     DC.B 'Remaning Time: ',0
.TIMMULTXT  DC.B ' * 5',0
.TXT1   DC.B 'Thank You for Playing',0
            DS.W 0



*~Font name~Courier New~
*~Font size~12~
*~Tab type~1~
*~Tab size~4~
