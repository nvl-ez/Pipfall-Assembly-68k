PINES
        MOVEM.L D0-D4, -(A7)
        
        MOVE.W #165, D1
        JSR PINE
        
        MOVE.W #260, D1
        JSR PINE
        
        MOVE.W #330, D1
        JSR PINE
        
        MOVE.W #362, D1
        JSR PINE
        
        JSR TREE
        
        MOVE.W #540, D1
        JSR SQTREE
        
        JSR BASEMENT
        
        MOVEM.L (A7)+, D0-D4
        RTS

*~Font name~Courier New~
*~Font size~12~
*~Tab type~1~
*~Tab size~4~
