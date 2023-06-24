*Draw a tree
TREE
        *Draw trunk
        MOVEM.L D0-D4, -(A7)
        MOVE.B #81, D0
        MOVE.L #DRKGREEN, D1
        TRAP #15
        MOVE.B #80, D0
        MOVE.L #LGTGREEN, D1
        TRAP #15
        
        MOVE.B #87, D0
        MOVE.W #570, D1
        MOVE.W #10, D2
        MOVE.W #590, D3
        MOVE.W #180, D4
        TRAP #15
        
        *Draw branch
        MOVE.B #84, D0
        MOVE.W #570, D1
        MOVE.W #80, D2
        MOVE.W #460, D3
        MOVE.W #60, D4
        TRAP #15
        
        MOVE.W #65, D2
        TRAP #15
        
        MOVE.B #89, D0
        MOVE.W #569, D1
        MOVE.W #66, D2
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
