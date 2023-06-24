*Draw Basement
        INCLUDE "BACKGROUNDS/crate.X68"
BASEMENT
        MOVEM.W D0-D5, -(A7)
        
*Draw top path line
        *set fill color
        MOVE.B #81, D0
        MOVE.L #DRKGREEN, D1
        TRAP #15
        
        MOVE.B #87, D0
        
        MOVE.W #0, D1
        MOVE.W #150, D2
        MOVE.W #657, D3
        MOVE.W #154, D4
        
        TRAP #15
*Clear path
       *set fill color
        MOVE.B #81, D0
        MOVE.L #BLACK, D1
        TRAP #15
        
        MOVE.B #87, D0
        
        MOVE.W #0, D1
        MOVE.W #155, D2
        MOVE.W #657, D3
        MOVE.W #259, D4
        TRAP #15
        
        *set pen color
        MOVE.B #80, D0
        MOVE.L #BLACK, D1
        TRAP #15
        
*Draw bottom path line
        *set fill color
        MOVE.B #81, D0
        MOVE.L #NEOGREEN, D1
        TRAP #15
        
        MOVE.B #87, D0
        
        MOVE.W #0, D1
        MOVE.W #260, D2
        MOVE.W #657, D3
        MOVE.W #264, D4
        
        TRAP #15

*Draw concrete
        *set pen color
        MOVE.B #81, D0
        MOVE.L #GRAY, D1
        TRAP #15
        
        MOVE.B #87, D0
        
        MOVE.W #0, D1
        MOVE.W #264, D2
        MOVE.W #657, D3
        MOVE.W #325, D4
        
        TRAP #15
        
*Draw basement top line
        *set pen color
        MOVE.B #81, D0
        MOVE.L #DRKGREEN, D1
        TRAP #15
        
        MOVE.B #87, D0
        
        MOVE.W #0, D1
        MOVE.W #325, D2
        MOVE.W #657, D3
        MOVE.W #329, D4
        
        TRAP #15

*Draw basement background
        *set pen color
        MOVE.B #81, D0
        MOVE.L #GRGREEN, D1
        TRAP #15
        
        MOVE.B #87, D0
        
        MOVE.W #0, D1
        MOVE.W #329, D2
        MOVE.W #657, D3
        MOVE.W #495, D4
        
        TRAP #15

*Draw basement floor
        *set pen color
        MOVE.B #81, D0
        MOVE.L #LGTGREEN, D1
        TRAP #15
        
        MOVE.B #87, D0
        
        MOVE.W #0, D1
        MOVE.W #495, D2
        MOVE.W #657, D3
        MOVE.W #525, D4
        
        TRAP #15
        
*Decorate basement
        
        *Draw first bolts and line
        *set fill color
        MOVE.B #81, D0
        MOVE.L #DRKGREEN, D1
        TRAP #15
       
        MOVE.B #88, D0
        
        MOVE.W #16, D1
        MOVE.W #21, D3
        
        MOVE.W #4, D5
        
.BOLTLOOP
        *Draw firsrt 3 bolts
        MOVE.W #335, D2
        MOVE.W #340, D4
        TRAP #15
        
        ADD.W #67, D2
        ADD.W #67, D4
        TRAP #15
        
        ADD.W #67, D2
        ADD.W #67, D4
        TRAP #15
        
        *Draw line
        MOVE.B #87, D0
        
        ADDQ.W #6, D1
        ADDQ.W #4, D3
        SUB.W #140, D2
        ADD.W #21, D4
        TRAP #15
        
        *Move sencond 3 bolts
        
        MOVE.B #88, D0
        
        ADDQ.W #4, D1
        ADDQ.W #6, D3
        MOVE.W #335, D2
        MOVE.W #340, D4
        TRAP #15
        
        ADD.W #67, D2
        ADD.W #67, D4
        TRAP #15
        
        ADD.W #67, D2
        ADD.W #67, D4
        TRAP #15
        
        ADD.W #142, D1
        ADD.W #142, D3
        
        DBRA D5, .BOLTLOOP *repeat for the other 5 lines
        
        *Draw Crates
        
        MOVE.W #65, D1
        MOVE.W #335, D2
        JSR CRATE
        MOVE.W #65, D1
        MOVE.W #415, D2
        JSR CRATE
        MOVE.W #517, D1
        MOVE.W #335, D2
        JSR CRATE
        MOVE.W #517, D1
        MOVE.W #415, D2
        JSR CRATE
        
        MOVEM.W (A7)+, D0-D5
        RTS







*~Font name~Courier New~
*~Font size~12~
*~Tab type~1~
*~Tab size~4~
