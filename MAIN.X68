*-----------------------------------------------------------
* Title      : Pipfall
* Written by : Nahuel Vazquez X6223579D
* Date       : 24 de noviembre de 2022
* Description: Este juego consiste en un port del minijuego
*              Pipfall encontrado en Fallout 4. Se ha 
*              adaptado a las limitaciones del 68K (no poder 
*              pintar sprites muy grandes).
*-----------------------------------------------------------
    ORG    $1000
    INCLUDE "SYSCONST.X68"
    INCLUDE "CONST.X68"
    INCLUDE "LIB/DMMCONST.X68"
    INCLUDE "LIB/DMMCODE.X68"
    INCLUDE "LIB/AGLCODE.X68"
    INCLUDE "LIB/UTLCODE.X68"
    INCLUDE "LIB/UTLCONST.X68"
    INCLUDE "SYSTEM.X68"
    
    INCLUDE "PIPBOY.X68"
    INCLUDE "SCORE.X68"
    INCLUDE "ENVIROMENT.X68"
    INCLUDE "DEALDMG.X68"
    INCLUDE "TITLESCR.X68"
    INCLUDE "SCORESCR.X68"
    
    
    
START:
*---Inicialización------------------------------------------
            
            ORI.W #$0700, SR
            JSR SYSINIT
            JSR TITLESCRINIT
            JSR PIPINIT
            JSR SBINIT
            
            
            CLR.W (ENVID)
            CLR.W (CURRENV)
            CLR.W (STATE)
            
            LEA ENVINIT, A1
            LEA ENVUPD, A2
            LEA ENVPLOT, A3
            MOVE.W #1, D0
            JSR AGLADD
.LOOP

*---Update--------------------------------------------------

;Read input devices

            TRAP #KBDUPTN

;Update game logic
            CMP.W #1, (STATE)
            BEQ .INGAMEUPD
            BGT .ENDUPD
            *Subrutina de la pantalla de inicio
            JSR TITLESCRUPD
            BRA .ENDUPD
            
.INGAMEUPD
            *Subrutinas del juego
            JSR AGLUPD
            JSR PIPUPD
            JSR UPDDMG
            JSR SBUPD
            BRA .ENDUPD

            
.ENDUPD

*---Sync----------------------------------------------------

.WINT       TST.B   (SCRINTCT)
            BEQ     .WINT
            CLR.B   (SCRINTCT)

*---Plot----------------------------------------------------
            *Incrementar el contador de frames
            ADDQ.B #1, (FPSCT)
            
            CMP.W #1, (STATE)
            BEQ .INGAMEPLOT
            BGT .SCOREPLOT
            *Subrutina de la pantalla de inicio
            JSR TITLESCRPLOT
            BRA .ENDPLOT
            
.INGAMEPLOT
            *Subrutinas del juego
            
            JSR AGLPLOT
            JSR PIPPLOT
            JSR SBPLOT
            BRA .ENDPLOT

.SCOREPLOT
            *Subrutinas de la pantalla de puntuacion
            JSR SCORESCRPLOT
            

.ENDPLOT
        
;Update double buffer
        MOVE.W (STATE), D6
        TRAP  #SCRUPTN
        
        BRA .LOOP
        SIMHALT

* Put variables and constants here
        INCLUDE "VARS.X68"
        INCLUDE "SYSVARS.X68"
        INCLUDE "LIB/DMMVARS.X68"
        INCLUDE "LIB/UTLVARS.X68"

    END    START        ; last line of source
































*~Font name~Courier New~
*~Font size~12~
*~Tab type~1~
*~Tab size~4~
