*-----------------------------------------------------------
* SYSTEM VARIABLES
*-----------------------------------------------------------

*---Keyboard variables--------------------------------------
KBDVAL      DS.B    1   *key state
KBDEDGE     DS.B    1   *key edge


*---Timed Interrupt variables-------------------------------
SCRINTCT    DS.B    1    *Contador de interrupciones
SCRCYCCT    DS.B    1    *Contador de frames
FPSCT       DS.B    1    *Contador de frames que se reinicia cada segundo
FPS         DS.B    1    *Contador de frames por segundo
            DS.W    0





*~Font name~Courier New~
*~Font size~12~
*~Tab type~1~
*~Tab size~4~
