*Dibuja un arbol cuadrado en la posicion horizontal especificada por D1

SQTREE
*Dibuja el tronco
        MOVEM.L D0-D4, -(A7)
        
        MOVE.W D1, -(A7)
        *set fill color
        MOVE.B #81, D0
        MOVE.L #LGTGREEN, D1
        TRAP #15
        MOVE.W (A7)+, D1
        
        MOVE.B #87, D0
        MOVE.W D1, D3
        ADDQ.W #4, D3
        MOVE.W #140, D2
        MOVE.W #150, D4
        TRAP #15
        
*Dibuja las hojas
        
        MOVE.W D1, -(A7)
        *set pen color
        MOVE.B #81, D0
        MOVE.L #DRKGREEN, D1
        TRAP #15
        MOVE.W (A7)+, D1
        
        *Dibuja las hojas
        MOVE.B #87, D0
        SUB.W #10, D1
        ADD.W #10, D3
        MOVE.W #75, D2
        MOVE.W #140, D4
        TRAP #15
        
        *Reset pen color
        MOVE.B #80, D0
        MOVE.L #BLACK, D1
        TRAP #15
        
        MOVEM.L (A7)+, D0-D4
        RTS






*~Font name~Courier New~
*~Font size~12~
*~Tab type~1~
*~Tab size~4~
