' HH.BAS - Hydrogen & Higgs
' Marco da Venezia, 1989-90
' CPU min. 286/16MHz, ok 386/33MHz
' Rappresentazione dell'atomo di idrogeno NON in scala:
' con il protone di raggio 10 pixel, la nuvola elettronica avrebbe un raggio
' di 10^5 ö 10^6 pixel; elettrone e quark (entit… "puntiformi") avrebbero un
' raggio simbolico pari a 0.001 pixel; l'interazione forte Š indicata con un
' cerchietto intermittente al centro circoscrivente i tre quark; il campo di
' Higgs (1964) permea lo "spaziotempo" ed e' rappresentato dallo sfondo nero.

CONST rP = 10  ' raggio protone
CONST rA = 239 ' raggio atomico
CONST x1 = 320 ' x centro VGA (400 o 512 lib SVGA)
CONST y1 = 240 ' y centro VGA (300 o 384  ''  '' )

SCREEN 12

RANDOMIZE TIMER

WHILE INKEY$ = ""
   
    CLS

     CIRCLE (x1, y1), rA - 1, 8 ' evidenzia zona atom.
     CIRCLE (x1, y1), rP + 1, 8 ' evidenzia zona quark
  
    ' interazione forte: circle pulsante al centro per 486
     frame = frame + 2
     rForte = 6 + INT(5 * SIN(frame / 10!)) ' raggio pulsante tra 0 e 11
     CIRCLE (x1, y1), rForte, 7

    ' Protone: 3 quark, 2 pixel rossi (Up) e 1 blu (Down) danzanti in rP
    FOR i = 1 TO 3
        DO
            x = INT(2 * rP * RND) - rP
            y = INT(2 * rP * RND) - rP
            xy = x ^ 2 + y ^ 2
        LOOP WHILE xy > rP ^ 2 ' distanza > 10 pixel
        IF i = 3 THEN c = 9 ELSE c = 12 ' blu e rosso intensi
        PSET (x1 + x, y1 + y), c
    NEXT

    ' Elettrone: pixel gialli furiosi in area di raggio rA
    ' impostare TO: 1000~486, 500~386, 100~286 (20~8086 penoso)
    FOR i = 1 TO 500
        DO
            x = INT(RND * 2 * rA) - rA
            y = INT(RND * 2 * rA) - rA
            xy = x ^ 2 + y ^ 2
        LOOP UNTIL xy < rA ^ 2
        PSET (x1 + x, y1 + y), 14 ' giallo
    NEXT

    't = TIMER: WHILE TIMER - t < .05: WEND ' rallenta per vedere con 486
    
WEND

