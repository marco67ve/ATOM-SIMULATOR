' URANIUM.BAS
' Simulazione atomica Uranio
' QB & VGA SCREEN 12 - pref. 80386
' Marco da Venezia, 1990

CONST elettroni = 92 ' numero atomico
CONST nucleoni = 235 ' 143 neutroni + 92 protoni
CONST rN = 12        ' raggio nucleo
CONST xC = 320       ' x centro VGA
CONST yC = 240       ' y centro VGA

RANDOMIZE TIMER

SCREEN 12

' Dati orbitali
DIM angolo(elettroni)
DIM raggio(elettroni)
DIM colorE(elettroni)

FOR i = 1 TO elettroni
    ' Distribuzione angolare casuale
    angolo(i) = RND * 6.28318
    ' Raggio per le 7 orbite dell'uranio
    raggio(i) = 50 + ((i - 1) MOD 7) * 25
    ' Colore secondo l'orbita
    orbita = (i - 1) MOD 7
    SELECT CASE orbita
        CASE 0:  colorE(i) = 7   ' bianco
        CASE 1:  colorE(i) = 13  ' magenta chiaro
        CASE 2:  colorE(i) = 12  ' rosso chiaro
        CASE 3:  colorE(i) = 14  ' giallo
        CASE 4:  colorE(i) = 10  ' verde chiaro
        CASE 5:  colorE(i) = 11  ' ciano chiaro
        CASE ELSE: colorE(i) = 9 ' blu chiaro (alta energia)
    END SELECT
NEXT

WHILE INKEY$ <> CHR$(27)

    ' Area nucleo
    LINE (xC - rN - 2, yC - rN - 2)-(xC + rN + 2, yC + rN + 2), 0, BF ' pulisce area
    ' CIRCLE (xC, yC), rN, 9 ' deremarcare per vedere circonferenza nucleo

    ' Nucleoni (pixel danzanti)
    FOR i = 1 TO nucleoni
        a = RND * 6.28318
        b = RND * rN
        x = xC + b * COS(a)
        y = yC + b * SIN(a)
        IF i > 143 THEN c = 12 ELSE c = 14
        PSET (x, y), c
    NEXT

    ' Pulisce orbite
    FOR i = 1 TO elettroni
        x = xC + COS(angolo(i)) * raggio(i)
        y = yC + SIN(angolo(i)) * raggio(i)
        PSET (x, y), 0
    NEXT

    ' Aggiorna posizioni e disegna nuovi elettroni
    FOR i = 1 TO elettroni
        angolo(i) = angolo(i) + .05 + (i MOD 5) * .002 ' sfasamento
        IF angolo(i) > 6.28318 THEN angolo(i) = angolo(i) - 6.28318
        x = xC + COS(angolo(i)) * raggio(i)
        y = yC + SIN(angolo(i)) * raggio(i)
        PSET (x, y), colorE(i)
    NEXT

    ' t0 = TIMER: DO WHILE TIMER < t0 + .03: LOOP ' deremarcare per rallentare 486 veloci

WEND

' Implementare DATA di tutti gli atomi per U2.BAS

