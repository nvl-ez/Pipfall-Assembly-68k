*Crate
*-----------------------------------------------------------
CRATE
* Draw a crate at specified coords (top left)
* Input:    D1, D2
* Output:   none
* MODIFIES: none
*-----------------------------------------------------------
        MOVEM.L D0-D4, -(A7)
        
        *CHange color to Crate background
        MOVE.L D1, -(A7)
        *set fill color
        MOVE.B #81, D0
        MOVE.L #BLACK, D1
        TRAP #15
        
        MOVE.L (A7)+, D1 *restablece la coord
        *Draw background
        MOVE.B #87, D0
        
        MOVE.W D1, D3
        ADD.W #70, D3
        MOVE.W D2, D4
        ADD.W #70, D4
        TRAP #15
        
        *Draw inside
        MOVE.L D1, -(A7)
        *change fill color
        MOVE.W #81, D0
        MOVE.L #GRGREEN, D1
        TRAP #15
        
        MOVE.L (A7)+,D1 *restablece la coord
        
        MOVE.W #87, D0
        
        ADD.W #10, D1
        ADD.W #10, D2
        SUB.W #10, D3
        SUB.W #10, D4
        TRAP #15
        
        MOVE.L D1, -(A7)
        *change fill color
        MOVE.W #81, D0
        MOVE.L #BLACK, D1
        TRAP #15
        MOVE.L (A7)+,D1 *restablece la coord
        
        MOVE.W #87, D0
        
        ADD.W #20, D1
        SUB.W #20, D3
        TRAP #15
        
        SUB.W #20, D1
        ADD.W #20, D3
        ADD.W #20, D2
        SUB.W #20, D4
        TRAP #15
         
        
        MOVEM.L (A7)+, D0-D4
        RTS

*~Font name~Courier New~
*~Font size~12~
*~Tab type~1~
*~Tab size~4~
