*-----------------------------------------------------------
* GAME VARIABLES
*-----------------------------------------------------------

*---SCORE-BOARD---------------------------------------------
PIPHP       DS.W    1   ;Vida del pipboy que se muestra
TRUEHP      DS.W    1   ;Vida real
TIME        DS.W    1   ;Contador de tiempo
TRUETIME    DS.W    1   ;tiempo en frames
SCORE       DS.W    1   ;Puntos recogidos


*---PIPBOY--------------------------------------------------
PIPPOSX     DS.W    1   ;Posicion del pipboy eje X
PIPPOSY     DS.W    1   ;Posicion del pipboy eje Y
PIPVELX     DS.W    1   ;Velocidad del pipboy eje X
PIPVELY     DS.W    1   ;Velocidad del pipboy eje Y
PIPREADY    DS.W    1   
PIPCLIMB    DS.W    1   ;Almacena si esta escalando
PIPJUMP     DS.W    1   ;Almacena si esta saltando
PIPANIM     DS.W    1   ;Animacion del pipboy que se va a dibujar
PIPPREV     DS.W    1   ;Almacena si se tiene que cargar la escena anterior
PIPNEXT     DS.W    1   ;Almacena si se tiene que cargar la escena siguiente
PIPHANG     DS.W    1
*---ENVIROMENT----------------------------------------------
ENVID       DS.W    1   ;Almacena la cantidad de Enviroments creados
CURRENV     DS.W    1   ;Almacena el Enviroment actual
*---ROPE----------------------------------------------------
ROPEPOSX    DS.W    1
ROPEVELX    DS.W    1
*---CRAB----------------------------------------------------
ATACKING    DS.W    1   ;Almacena si el cangrejo esta atacando o no
*---GAME----------------------------------------------------
STATE       DS.W    1   ;0 Title screen, 1 in game, 2 score screen












*~Font name~Courier New~
*~Font size~12~
*~Tab type~1~
*~Tab size~4~
