*----------------------------------------------------------------
DEALDMG
* Subrutina que reduce TRUEHP y actualiza PIPHP como corresponde
* Permite darle un tiempo de invulnerabilidad
* INPUT:    None
* OUTPUT:   None
* MODIFIES: TRUEHP, PIPHP
*----------------------------------------------------------------
        MOVEM.L D0/D7, -(A7)
        
        CMP.W #PIPFLOOR+10, (PIPPOSY) *es invulnerable mientras este en el sotano
        BGT .END
        
        ;Play sound
        MOVE.B #SNDDAMAGE, D7
        TRAP #SNDPLTN
        
        MOVE.W (TRUEHP), D0
        SUB.W #1, D0
        MOVE.W D0, (TRUEHP)
        DIVU.W #INVTIM, D0
        MOVE.W D0, (PIPHP)
        BRA .END
        

.END    
        MOVEM.L (A7)+, D0/D7
        RTS
*----------------------------------------------------------------
UPDDMG
* Subrutina que actualiza el tiempo de invulnerabilidad
* INPUT:    None
* OUTPUT:   None
* MODIFIES: TRUEHP, PIPHP
*----------------------------------------------------------------
        MOVEM.L D0-D1, -(A7)
        MOVE.W (TRUEHP), D0
        MOVE.W D0, D1
        DIVU.W #INVTIM, D1
        MOVE.W D1, (PIPHP)
        ASR.L #8, D1
        TST.W D1
        BEQ .ENDUPD
        SUB.W #1, D0
        MOVE.W D0, (TRUEHP)

.ENDUPD
        MOVEM.L (A7)+, D0-D1
        RTS







*~Font name~Courier New~
*~Font size~12~
*~Tab type~1~
*~Tab size~4~
