*-----------------------------------------------------------
* Background1
*-----------------------------------------------------------
HILLS1
        MOVEM.L D0-D4, -(A7)

*Set pen color for hills and trees
        MOVE.B #80, D0
        MOVE.L #BLACK, D1
        TRAP #15


*Set fill color for hills
        MOVE.B #81, D0
        MOVE.L #DRKGREEN, D1
        TRAP #15
        
*Draw fst hill
        MOVE.B #88, D0
        
        MOVE.W #-80, D1
        MOVE.W #20, D2
        MOVE.W #320, D3
        MOVE.W #280, D4
        
        TRAP #15
        
*Draw scnd hill
        MOVE.B #88, D0
        
        MOVE.W #600, D1
        MOVE.W #100, D2
        MOVE.W #700, D3
        MOVE.W #200, D4
        
        TRAP #15
        
        *Cover half of the elipse
        MOVE.B #81, D0
        MOVE.L #$00000000, D1
        TRAP #15
        
        MOVE.B #87, D0
        
        MOVE.W #500, D1
        MOVE.W #150, D2
        MOVE.W #540, D3
        MOVE.W #280, D4
        
        TRAP #15

*Draw tree top
        *Set fill color for trees
        MOVE.B #81, D0
        MOVE.L #DRKGREEN, D1
        TRAP #15
        
        MOVE.B #88, D0
        
        MOVE.W #380, D1
        MOVE.W #37, D2
        MOVE.W #460, D3
        MOVE.W #123, D4
        
        TRAP #15
        
        *Cover bottom half of the tree
        *set pen color
        MOVE.B #81, D0
        MOVE.L #$00000000, D1
        TRAP #15
        
        MOVE.B #87, D0
        
        MOVE.W #380, D1
        MOVE.W #86, D2
        MOVE.W #460, D3
        MOVE.W #123, D4
        
        TRAP #15
        
*Draw trunk
        *set pen color
        MOVE.B #81, D0
        MOVE.L #LGTGREEN, D1
        TRAP #15
        
        MOVE.B #87, D0
        
        MOVE.W #420, D1
        MOVE.W #86, D2
        MOVE.W #426, D3
        MOVE.W #150, D4
        
        TRAP #15        
        
        JSR BASEMENT
        MOVEM.L (A7)+, D0-D4
        
        RTS
        



*~Font name~Courier New~
*~Font size~12~
*~Tab type~1~
*~Tab size~4~
