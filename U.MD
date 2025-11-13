# URANIUM.BAS e U2.BAS

URANIUM.BAS è un rappresentazione dell'atomo di Uranio scritta nel 1990 con data da definirsi per il completamento comprendente tutti gli atomi della tavola periodica;

U2.BAS è il suo completamento, scritto in data 2025, comprensivo di DATA e input utente per inserire un numero atomico da 1 (Idrogeno) a 118 (Oganesson) cosicché il programma disegnerà una rappresentazione animata di quell'atomo.


\![Placeholder: screenshot]


## ?? Caratteristiche comuni

  * **Grafica VGA:** Utilizza `SCREEN 12` 640x480 16 colori.
  * **Animazione fluida:** Il nucleo "pulsa" per simular l'interazione forte mentre gli elettroni orbitano a velocità diverse colorati in base al livello orbitale per un effetto visivo dinamico e ipnotico.
  * **Distribuzione degli elettroni:** Utilizza una formula basata sulla radice cubica per distribuire gli elettroni in modo visivamente bilanciato tra gli orbitali.

  ### ?? Caratteristica principale dell'ultima versione (U2.BAS)

- Supporto a tutti gli isotopi stabili degli elementi fino al **numero atomico 118** tramite tabelle DATA.
- Input unico: numero atomico; il programma legge automaticamente il numero di neutroni più comune.

-----

## ?? Il Codice di U2.BAS

```
' U2.BAS - ATOM SIMULATOR COMPLETE
' Simulazione atomica con input utente e orbite definite con nome elemento
' QB & VGA SCREEN 12
' Marco da Venezia & Bishop, 2025 - Revival del 1990 da URANIUM.BAS

CONST xC = 320
CONST yC = 240

' === INPUT NUMERO ATOMICO ===
INPUT "Numero atomico Z (1-118) "; Z
IF Z < 1 OR Z > 118 THEN Z = 92  ' default Uranio

' === LETTURA NEUTRONI DA DATA ===
RESTORE 1
FOR i = 1 TO Z: READ N: NEXT
Neutrons = N

numPE = Z  ' protoni = elettroni = numero atomico

' === LETTURA NOME ELEMENTO DA DATA ===
RESTORE 2
FOR i = 1 TO Z: READ ElemName$: NEXT

RANDOMIZE TIMER
SCREEN 12

' === CALCOLO NUMERO ORBITE in base al numero atomico ===
numOrbit = INT((numPE + Neutrons) ^ .33) + 1
IF numOrbit < 1 THEN numOrbit = 1
IF numOrbit > 7 THEN numOrbit = 7

' === ORBITE ELETTRONICHE ===
DIM angle(numPE)
DIM radius(numPE)
DIM colorE(numPE)

FOR i = 1 TO numPE
    ' Distribuzione angolare regolare
    angle(i) = (i - 1) * (2 * 3.14159 / numPE)
    ' Raggio orbitale dinamico in base al numero di orbite
    radius(i) = 50 + ((i - 1) MOD numOrbit) * 25
    ' Colore progressivo in base al livello orbitale
    orbitLevel = ((i - 1) MOD numOrbit)
    SELECT CASE orbitLevel
        CASE 0: colorE(i) = 9     ' blu
        CASE 1: colorE(i) = 11    ' ciano
        CASE 2: colorE(i) = 10    ' verde chiaro
        CASE 3: colorE(i) = 14    ' giallo
        CASE 4: colorE(i) = 12    ' rosso
        CASE 5: colorE(i) = 13    ' magenta
        CASE ELSE: colorE(i) = 15 ' bianco (extra)
    END SELECT
NEXT

COLOR 8: LOCATE 30, 57: PRINT "Premi ESC per terminare";

t = 0

' === LOOP PRINCIPALE ===
DO
    ' --- NUCLEO ---
    rBase = 12
    rPulse = SIN(t) * 1   ' raggio di pulse, variare *.1-2 per +/- effetto
    rNuc = rBase + rPulse ' raggio del nucleo pulsante
    LINE (xC - rNuc - 2, yC - rNuc - 2)-(xC + rNuc + 2, yC + rNuc + 2), 0, BF
    CIRCLE (xC, yC), rNuc, 8
    PAINT (xC, yC), 0
    t = t + 1            ' frequenza di pulse, variare +.1ö1 per +/- effetto

    ' --- NUCLEONI (punti casuali tremolanti) ---
    FOR i = 1 TO numPE + Neutrons
        a = RND * 6.28318
        d = RND * rNuc
        x = xC + d * COS(a)
        y = yC + d * SIN(a)
        IF i <= Neutrons THEN c = 12 ELSE c = 14
        PSET (x, y), c ' protoni
    NEXT

    ' --- CANCELLA ORBITE PRECEDENTI ---
    FOR i = 1 TO numPE
        x = xC + COS(angle(i)) * radius(i)
        y = yC + SIN(angle(i)) * radius(i)
        PSET (x, y), 0
    NEXT

    ' --- AGGIORNA POSIZIONI ELETTRONI ---
    FOR i = 1 TO numPE
        angle(i) = angle(i) + .05 + (i MOD 5) * .002
        IF angle(i) > 6.28318 THEN angle(i) = angle(i) - 6.28318
        x = xC + COS(angle(i)) * radius(i)
        y = yC + SIN(angle(i)) * radius(i)
        PSET (x, y), colorE(i)
    NEXT

    ' t0 = TIMER: DO WHILE TIMER < t0 + .01: LOOP ' deremarcare se CPU > 386

    ' Effetto arcobaleno del simbolo atomico
    ' spostare prima del loop con mex ESC se PC lento
    COLOR INT(RND * 15): LOCATE 2, 3: PRINT "Atomo: "; ElemName$

    IF INKEY$ = CHR$(27) THEN EXIT DO
LOOP

END

1 ' === DATI NEUTRONI (1-118) ===
DATA 0,2,4,5,6,6,7,8,10,10,12,12,14,14,16,16,18,22,20,20,24,26,28,28,30,30,32,30,34,34
DATA 38,40,42,44,44,48,48,50,50,50,52,54,55,58,58,60,60,62,64,68,68,70,74,74,78,78,80,82
DATA 82,82,84,88,88,90,92,92,94,96,96,98,98,102,104,104,106,108,110,112,114,114,116,118
DATA 120,122,126,126,125,125,136,137,138,140,142,142,143,144,146,148,150,150,152,152,154
DATA 157,157,157,163,163,163,165,163,169,169,171,171,173,173,176,175,177,177,176

2 ' === DATI NOMI ELEMENTI (1-118) ===
DATA "H","He","Li","Be","B","C","N","O","F","Ne","Na","Mg","Al","Si","P","S","Cl","Ar","K","Ca"
DATA "Sc","Ti","V","Cr","Mn","Fe","Co","Ni","Cu","Zn","Ga","Ge","As","Se","Br","Kr","Rb","Sr","Y","Zr"
DATA "Nb","Mo","Tc","Ru","Rh","Pd","Ag","Cd","In","Sn","Sb","Te","I","Xe","Cs","Ba","La","Ce","Pr"
DATA "Nd","Pm","Sm","Eu","Gd","Tb","Dy","Ho","Er","Tm","Yb","Lu","Hf","Ta","W","Re","Os","Ir","Pt"
DATA "Au","Hg","Tl","Pb","Bi","Po","At","Rn","Fr","Ra","Ac","Th","Pa","U","Np","Pu","Am","Cm","Bk"
DATA "Cf","Es","Fm","Md","No","Lr","Rf","Db","Sg","Bh","Hs","Mt","Ds","Rg","Cn","Nh","Fl","Mc","Lv"
DATA "Ts","Og"

```