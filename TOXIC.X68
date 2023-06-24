*-------------------------------------------------------------------
* TOXIC
*-------------------------------------------------------------------
        INCLUDE "signal/signal.X68"
*---Plot Toxic-------------------------------------------------------
TOXICPLOT
* Pinta las señales de peligro 
* INPUT:    None
* OUTPUT:   None
* MODIFIES: None
*--------------------------------------------------------------------
        MOVEM.L D1-D2/A6, -(A7)
        
        MOVE.W #LSIGNAL, D1
        MOVE.W #PROPY, D2
        JSR SIGNAL
        MOVE.W #RSIGNAL, D1
        JSR SIGNAL
        
        MOVEM.L (A7)+, D1-D2/A6
        RTS














*~Font name~Courier New~
*~Font size~12~
*~Tab type~1~
*~Tab size~4~
