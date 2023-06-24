*Draws a rope at the specified coordinates by D1 (top right)
ROPE
        MOVEM.L D0-D4, -(A7)
        
        MOVE.W D1, -(A7)
        MOVE.B #81, D0
        MOVE.L #NEOGREEN, D1
        TRAP #15
        
        MOVE.W (A7)+, D1
        
        MOVE.W #87, D0
        MOVE.W D1, D3
        ADDQ.W #4, D3
        CLR.W D2
        MOVE.W #ROPEBOTOM, D4
        TRAP #15
        
        MOVE.B #84, D0
        MOVE.W #7, D2
        MOVE.W #8, D4
        
.LINELOOP
        TRAP #15
        ADDQ.W #8, D2
        ADDQ.W #8, D4
        CMP #ROPEBOTOM, D2
        BLE .LINELOOP
        
        
        
        MOVEM.L (A7)+, D0-D4
        RTS

*~Font name~Courier New~
*~Font size~12~
*~Tab type~1~
*~Tab size~4~
