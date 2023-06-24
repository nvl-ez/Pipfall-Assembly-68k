SQTREES
        MOVEM.L D0-D4, -(A7)
        
        MOVE.W #-10, D1
        JSR SQTREE
        
        MOVE.W #280, D1
        JSR SQTREE
        
        MOVE.W #360, D1
        JSR SQTREE
        
        MOVE.W #460, D1
        JSR PINE
        
        MOVE.W #520, D1
        JSR SQTREE
        
        MOVE.W #665, D1
        JSR SQTREE
        
*Set pen color for hill
        MOVE.B #80, D0
        MOVE.L #DRKGREEN, D1
        TRAP #15


*Set fill color for hill
        MOVE.B #81, D0
        MOVE.L #DRKGREEN, D1
        TRAP #15
        
*Draw hill
        MOVE.B #88, D0
        
        MOVE.W #45, D1
        MOVE.W #90, D2
        MOVE.W #250, D3
        MOVE.W #210, D4
        TRAP #15
        
        JSR BASEMENT
        MOVEM.L (A7)+, D0-D4
        RTS

*~Font name~Courier New~
*~Font size~12~
*~Tab type~1~
*~Tab size~4~
