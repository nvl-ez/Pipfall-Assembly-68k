*-----------------------------------------------------------
* GAME CONSTANTS
*-----------------------------------------------------------

*---PROP-CONSTS---------------------------------------------
PROPY            EQU 220            ;Altura a la que se generan los items
*ROPE
ROPEBOTOM        EQU 130            ;determina la parte inferior de la cuerda
ROPEMAX          EQU 457            ;maxima coord horizontal
ROPEMIN          EQU 200            ;minima coord horizontal
ROPESPEED        EQU 3              ;velocidad de la cuerda
*SIGNAL
LSIGNAL          EQU 200            ;pos horizontal de la primera señal
RSIGNAL          EQU 390            ;pos horizontal de la segunda señal
*MINE
LMINE            EQU 175            ;pos horizontal de la primera mina
RMINE            EQU SCRW-175       ;pos horizontal de la segunda mina
MINEW            EQU 30             ;anchura de la hitbox de una mina
MINEANIMSP       EQU 5              ;velocidad de la explosion
MINEANIMX        EQU 100
MINEANIMY        EQU PROPY-50       ;pos vertical de las minas
*BARREL
BARRELSP         EQU 5              ;Velocidad de los barriles
BARRELX          EQU 675            ;posicion horizontal en la que aparecen
BARRELTIM        EQU 30             ;tiempo entre barriles
BARRELW          EQU 28             ;anchura de la hitbox de un barril
BARRELH          EQU 20             ;altura de la hitbox de un barril
*FIREBALL
FIREY            EQU -10            ;altura en la que aparece la bola de fuego
FIRESP           EQU 5              ;velocidad con la que cae
FIRETIM          EQU 100            ;tiempo entre bolas de fuego
FIREW            EQU 10             ;anchura de la hitbox de la bola
*ENVIROMENT
RXTRIGGER        EQU SCRW-10        ;pos en la que se genera el siguiente enviroment
LXTRIGGER        EQU 10             ;pos en la que se carga el enviroment anterior
*CRAB
ATCKSP           EQU 40             ;tiempo de cada animacion
ATCKY            EQU PROPY-26       ;posicion y del sprite atacando
ATCKX            EQU (SCRW/2)-22    ;posicion x del sprite atacando
NOATCKY          EQU PROPY-13       ;posicion y del sprite sin atacar
NOATCKX          EQU (SCRW/2)-38    ;posicion x del sprite sin atacar 
*TROPHY
TROPHYX          EQU SCRW-40        ;posicion horizontal en la que aparece el trofeo
TROPHYW          EQU 20             ;anchura de la hitbox del trofeo
*LADDER
LADDERX          EQU 300            
LADDERW          EQU 50


*---PIPBOY-CONSTS-------------------------------------------
      
PIPSPEEDX        EQU 5             ;Magnitud de la velocidad
PIPSPEEDY        EQU 20           ;Magnitud de la velocidad vertical
PIPCLIMBSP       EQU 10           ;Magnitud de la velocidad al escalar
PIPSTARTX        EQU 50             ;Posicion horizontal en le que aparece al principio
PIPENDX          EQU SCRW-50        ;Posicon horizontal en la que aparece al retroceder de un enviroment
ROPEBOTOM        EQU 130            ;determina la parte inferior de la cuerda
PIPGRAV          EQU 2              ;gravedad con la que cae
PIPH             EQU 75             ;altura del personaje
PIPFLOOR         EQU PROPY-PIPH     ;posicion y del suelo en la parte superior
PIPBASE          EQU 495-PIPH       ;posicion y del suelo en la parte inferior
PIPW             EQU 35             ;anchura de la hitbox del personaje (mas angosta para mejorar jugabilidad)
PIPHANGH         EQU ROPEBOTOM-PIPH-10  ;altura en la que aparece cuando cuelga de la cuerda
PIPANIMSP        EQU 5              ;velocidad de las animaciones
INVTIM           EQU 30           ;tiempo de invulnerabilidad

*---DRAWING-COLORS------------------------------------------

DRKGREEN        EQU $00113410
LGTGREEN        EQU $00106110
NEOGREEN        EQU $0011ac10
BLACK           EQU $00000000
GRAY            EQU $00111810
GRGREEN         EQU $00111101

*---GENERATION-BORARD-CONSTS--------------------------------

SBPNCOL         EQU NEOGREEN        ;Color del texto
SBBKCOL         EQU BLACK           ;Color del fondo del texto
HPPOS           EQU $0302           ;Posicion de la vida
TIMEPOS         EQU $2702           ;Posicion del tiempo
SCOREPOS        EQU $0303           ;Posicion de los puntos
FPSPOS          EQU $3400           ;Posicion de los FPS

*---SCORE-SCREEN-CONSTS-------------------------------------

ENVPPOS          EQU $0508
HPPPOS           EQU $050B
TIMPPOS          EQU $050E
TROPPOS          EQU $0511
TOTPPOS          EQU $0514



*~Font name~Courier New~
*~Font size~12~
*~Tab type~1~
*~Tab size~4~
