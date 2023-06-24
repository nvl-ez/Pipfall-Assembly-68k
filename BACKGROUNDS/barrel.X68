*Draws a Barrel at the coordinate specified by D1
BARREL
        MOVEM.L D0-D4, -(A7)
        
        MOVE.W D1, -(A7)
        
        *set pen color
        MOVE.B #81, D0
        MOVE.L #BLACK, D1
        TRAP #15
        MOVE.B #80, D0
        MOVE.L #NEOGREEN, D1
        TRAP #15
        
        MOVE.W (A7)+, D1
        
*Draw top circle
        MOVE.B #88, D0
        MOVE.W D1, D3
        ADDQ.W #5, D1
        ADD.W #BARRELW, D3
        MOVE.W #PROPY-30, D2
        MOVE.W #PROPY-10, D4
        TRAP #15
        
        MOVE.W D1, -(A7)
        
        *set pen color
        MOVE.B #80, D0
        MOVE.L #BLACK, D1
        TRAP #15
        
        MOVE.W (A7)+, D1
        
*Cover bottom half of the circle
        MOVE.B #87, D0
        MOVE.W #PROPY-20, D2
        TRAP #15
        
        MOVE.W D1, -(A7)
        
        *set pen color
        MOVE.B #80, D0
        MOVE.L #NEOGREEN, D1
        TRAP #15
        
        MOVE.W (A7)+, D1
        
*Draw second circle
        MOVE.B #88, D0
        SUBQ.W #5, D1
        SUBQ.W #5, D3
        MOVE.W #PROPY-10, D2
        MOVE.W #PROPY+10, D4
        TRAP #15

*Draw first line
        MOVE.B #84, D0
        MOVE.W #PROPY, D2
        MOVE.W #PROPY-20, D4
        SUB.W #18, D3
        TRAP #15
*Draw Second line
        ADD.W #BARRELW-5, D1
        ADD.W #BARRELW-5, D3
        TRAP #15
        
        MOVE.B #80, D0
        MOVE.L #BLACK, D1
        TRAP #15
        
        MOVEM.L (A7)+, D0-D4
        RTS




*~Font name~Courier New~
*~Font size~12~
*~Tab type~1~
*~Tab size~4~
