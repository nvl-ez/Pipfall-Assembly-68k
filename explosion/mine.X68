*Draws a mine at the Y coord
MINE
        MOVEM.L D0-D4, -(A7)
        
        MOVE.W D1, -(A7)
        
        *set pen color
        MOVE.B #81, D0
        MOVE.L #NEOGREEN, D1
        TRAP #15
        
        MOVE.W (A7)+, D1 *Recupero la coordenada
        
        MOVE.B #88, D0
        MOVE.W #PROPY-13, D2
        MOVE.W D1, D3
        ADD.W #30, D3
        MOVE.W #220, D4
        TRAP #15
        
        MOVE.W #PROPY-13, D2
        MOVE.W #PROPY-5, D4
        TRAP #15
        
        MOVE.W #PROPY-11, D2
        MOVE.W #PROPY-8, D4
        ADD.W #13, D1
        SUB.W #13, D3
        TRAP #15
        
        MOVEM.L (A7)+, D0-D4
        RTS


*~Font name~Courier New~
*~Font size~12~
*~Tab type~1~
*~Tab size~4~
