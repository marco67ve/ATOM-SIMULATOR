' BOHR.BAS
' Marco da Venezia, 1987

SCREEN 12

RANDOMIZE TIMER

xc = 320: yc = 240  ' coordinate centro VGA
sO = 60             ' step orbitali
rP = 10             ' raggio area protone (3 quark)
rE = 3              ' raggio area elettrone

DIM r(4), col(4)
FOR i = 1 TO 4
    r(i) = sO * i   ' raggio orbitali
    col(i) = 8 + i  ' colori elettrone in orbitali (blu, verde, ciano, rosso, intensi)
NEXT

DO
    flashes = INT(RND * 10) + 5
    FOR f = 1 TO flashes
       
        theta = RND * 2 * 3.14159
        xe = xc + r(orb) * COS(theta)
        ye = yc + r(orb) * SIN(theta)

        CIRCLE (xe, ye), rE, col(orb) ' disegna elettrone
        PAINT (xe, ye), col(orb)      ' pieno per migliore visibilit…
        LOCATE 2, 10: PRINT "Orbitale n."; orb
        t = TIMER: WHILE TIMER - t < .2: WEND ' ritardo
       
        delta = INT(RND * 3) - 1
        orb = orb + delta
        IF orb < 1 THEN orb = 1
        IF orb > 4 THEN orb = 4
       
        IF orb > fotone THEN
            ' un fotone colpisce l'elettrone
            x1F = 0: y1F = 0: x2F = xe: y2F = ye: c = 14
        END IF

        IF orb < fotone THEN
            ' l'elettrone emette un fotone
            x1F = xe: y1F = ye: x2F = 2 * xc: y2F = 2 * yc: c = 6
        END IF

        IF orb <> fotone THEN
            LINE (x1F, y1F)-(x2F, y2F), c
            t = TIMER: WHILE TIMER - t < .1: WEND
            LINE (x1F, y1F)-(x2F, y2F), 0
        END IF
       
        fotone = orb

        LINE (xe - 3, ye - 3)-(xe + 3, ye + 3), 0, BF ' cancella elettrone
        LINE (xc - rP - 3, yc - rP - 3)-(xc + rP + 3, yc + rP + 3), 0, BF ' cancella area protone
        FOR i = 1 TO 4
            CIRCLE (xc, yc), sO * i, 8  ' orbitali (grigi)
        NEXT

        FOR i = 1 TO 3
            DO
                x = INT(2 * rP * RND) - rP
                y = INT(2 * rP * RND) - rP
                xy = x ^ 2 + y ^ 2
            LOOP WHILE xy > rP ^ 2
            IF i = 3 THEN c = 13 ELSE c = 14 ' magenta e giallo intensi
            CIRCLE (xc + x, yc + y), rE, c   ' per i quark danzanti
            PAINT (xc + x, yc + y), c        ' pieni per migliore visibilit…
        NEXT
    NEXT

LOOP WHILE INKEY$ = ""


