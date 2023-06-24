*Draws a signal at the coords specified by D1
SIGNAL
        MOVEM.L D0-D4, -(A7)
        
        MOVE.W D1, -(A7)
        *Change color
        MOVE.B #81, D0
        MOVE.L #LGTGREEN, D1
        TRAP #15
        MOVE.B #80, D0
        MOVE.L #LGTGREEN, D1
        TRAP #15
        
        MOVE.W (A7)+, D1
        
        *Draw triangle
        MOVE.B #84, D0
        MOVE.W D1, D3
        ADD.W #45, D3
        MOVE.W #PROPY-85, D4
        MOVE.W #PROPY-85,D2
        TRAP #15
        
        SUB.W #22, D3
        MOVE.W #PROPY-125, D4
        TRAP #15
        ADD.W #45, D1
        TRAP #15
        
        *Draw pole
        MOVE.W D1, -(A7)
        *Change color
        MOVE.B #80, D0
        MOVE.L #BLACK, D1
        TRAP #15     
        MOVE.W (A7)+, D1
        
        MOVE.B #87, D0
        SUB.W #25, D1
        MOVE.W D1, D3
        ADDQ.W #5, D3
        MOVE.W #PROPY-85, D2
        MOVE.W #PROPY, D4
        TRAP #15
        
        *Draw exclamation sign
        MOVE.W D1, -(A7)
        *Change color
        MOVE.B #80, D0
        MOVE.L #NEOGREEN, D1
        TRAP #15     
        MOVE.W (A7)+, D1
        
        MOVE.B #87, D0
        MOVE.W #PROPY-115, D2
        MOVE.W #PROPY-95, D4
        TRAP #15
        
        MOVE.B #88, D0
        MOVE.W #PROPY-92, D2
        MOVE.W #PROPY-88, D4
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
