HILLS2
        MOVEM.L D0-D4, -(A7)
        
        MOVE.W #20, D1
        JSR PINE
        
        MOVE.W #60, D1
        JSR PINE
        
        MOVE.W #595, D1
        JSR PINE
        
        MOVE.W #640, D1
        JSR PINE
        
*Set pen color for hills
        MOVE.B #80, D0
        MOVE.L #DRKGREEN, D1
        TRAP #15


*Set fill color for hills
        MOVE.B #81, D0
        MOVE.L #DRKGREEN, D1
        TRAP #15
        
*Draw fst hill
        MOVE.B #88, D0
        
        MOVE.W #140, D1
        MOVE.W #75, D2
        MOVE.W #350, D3
        MOVE.W #225, D4
        TRAP #15
        
*Draw scnd hill
        MOVE.W #330, D1
        MOVE.W #75, D2
        MOVE.W #540, D3
        MOVE.W #225, D4
        TRAP #15
        

        
        JSR BASEMENT
        MOVEM.L (A7)+, D0-D4
        RTS



*~Font name~Courier New~
*~Font size~12~
*~Tab type~1~
*~Tab size~4~
