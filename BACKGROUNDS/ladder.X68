*Draw Ladder
LADDER
        MOVEM.L D0-D5, -(A7)
    
        *Print lid
        MOVE.B #81, D0
        MOVE.L #DRKGREEN, D1
        TRAP #15
        
        MOVE.B #88, D0
        
        MOVE.W #280, D1
        MOVE.W #190, D2
        MOVE.W #289, D3
        MOVE.W #240, D4
        TRAP #15
        
        MOVE.W #283, D1
        MOVE.W #180, D2
        MOVE.W #291, D3
        MOVE.W #250, D4
        TRAP #15
        
        *Print hole
        MOVE.W #285, D1
        MOVE.W #250, D2
        MOVE.W #365, D3
        MOVE.W #270, D4
        TRAP #15
        
        MOVE.B #81, D0
        MOVE.L #GRAY, D1
        TRAP #15
        
        MOVE.B #87, D0
        MOVE.W #300, D1
        MOVE.W #255, D2
        MOVE.W #350, D3
        MOVE.W #325, D4
        TRAP #15
        
        *Print ladder
        MOVE.B #81, D0
        MOVE.L #LGTGREEN, D1
        TRAP #15
        
        MOVE.B #87, D0
        MOVE.W #300, D1
        MOVE.W #240, D2
        MOVE.W #305, D3
        MOVE.W #490, D4
        TRAP #15
        
        MOVE.W #345, D1
        MOVE.W #240, D2
        MOVE.W #350, D3
        MOVE.W #490, D4
        TRAP #15
        
        MOVE.W #5, D5
        MOVE.W #300, D1
        MOVE.W #270, D2
        MOVE.W #350, D3
        MOVE.W #275, D4
.STEPLOOP
        TRAP #15
        ADD.W #40, D2
        ADD.W #40, D4
        DBRA D5, .STEPLOOP

        MOVEM.L (A7)+, D0-D5
        RTS


*~Font name~Courier New~
*~Font size~12~
*~Tab type~1~
*~Tab size~4~
