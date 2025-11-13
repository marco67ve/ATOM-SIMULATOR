
# ⚛️ H*.BAS - Simulatore dell'Atomo di Idrogeno (1989-2008)

Questo progetto è una "capsula del tempo" informatica. Include due versioni di un simulatore visivo dell'atomo di Idrogeno:

1.  **`HH.BAS` (1989-90):** La versione originale per **QuickBASIC 4.5**, ottimizzata (e limitata) dall'hardware dell'epoca (CPU 286/386).
2.  **`HYDROGEN.BAS` (2008):** Una revisione moderna per **QB64**, che sfrutta la potenza delle CPU moderne e le risoluzioni grafiche superiori.

Entrambi i programmi mostrano una rappresentazione concettuale dell'atomo di Idrogeno, non in scala, evidenziando i suoi componenti fondamentali in un ambiente grafico VGA (`SCREEN 12`) o moderno.

## ✨ Concetti Didattici Simuati

Il simulatore non mira a una precisione scientifica in scala (come indicato nei commenti, sarebbe impossibile), ma a visualizzare concetti chiave:

  * **Il Protone (Nucleo):** Rappresentato come un'area (`rP`) contenente 3 "quark danzanti" (due rossi per l'Up, uno blu per il Down).
  * **La Nuvola Elettronica:** L'elettrone non è una pallina su un'orbita fissa (modello planetario), ma è rappresentato come una "nuvola di probabilità" (modello di Bohr/quantistico), disegnando migliaia di pixel gialli in posizioni casuali all'interno del raggio atomico.
  * **La Forza Forte:** Un cerchio pulsante al centro (`rForte`) simboleggia l'intensa e breve portata della Forza Nucleare Forte Residua che confina i quark.
  * **Il "Vuoto":** Come notato nei commenti, lo sfondo nero rappresenta lo spaziotempo (il "vuoto") che permea l'atomo, e in cui esistono campi come quello di Higgs (anche se non visualizzato direttamente).

## ⚙️ L'Evoluzione: 1990 vs 2008

Il confronto tra i due file `.BAS` è una lezione sull'evoluzione dell'hardware:

  * **Gestione della Velocità (1990):** La versione `HH.BAS` doveva **tarare manualmente** il numero di elettroni disegnati in base alla CPU (`100~286`, `500~386`). I processori più veloci (486) richiedevano addirittura un **ciclo di ritardo manuale** (`TIMER`) per non essere *troppo* rapidi.
  * **Gestione della Velocità (2008):** La versione `HYDROGEN.BAS` non si preoccupa della potenza della CPU (imposta `cicliElettroni = 1000` e sa che funzionerà) e usa il comando moderno `_Limit 30` per garantire un *framerate* stabile, risolvendo elegantemente entrambi i problemi del passato.
  * **Risoluzione:** Si passa dal `SCREEN 12` fisso (640x480) a una risoluzione dinamica e widescreen (`_NewImage(xDisplay, yDisplay, 256)`) calcolata in base all'altezza desiderata.

-----

## 💻 Codice 1: `HH.BAS` (QuickBASIC 4.5, 1989-90)

```
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
```


## 💻 Codice 2: `HYDROGEN.BAS` (QB64, 2008)

```
' HYDROGEN.BAS - Simulazione visiva dell'atomo di idrogeno
' Adattamento (2008) QB64 da HH.BAS QB 4.5 (1989-90)
' By Marco da Venezia

Const Blu = 9
Const Rosso = 12
Const Giallo = 14
Const rProtone = 10
Const cicliElettroni = 1000

yDisplay = 720 ' impostare altezza a piacere secondo il display
xDisplay = yDisplay * 16 / 9

Screen _NewImage(xDisplay, yDisplay, 256)

xCentro = xDisplay / 2
yCentro = yDisplay / 2

Randomize Timer

' --- Ciclo principale ---
Do
    Cls

    Circle (xCentro, yCentro), yDisplay / 2 - 1, 8 ' zona atomo
    Circle (xCentro, yCentro), rProtone + 1, 8 ' zona quark

    ' Interazione forte (effetto pulsante)
    frame = frame + 2
    rForte = (rProtone / 2 + 1) + Int((rProtone / 2) * Sin(frame / rProtone))
    Circle (xCentro, yCentro), rForte, 7

    ' Quark danzanti (2 rossi, 1 blu) entro raggio protone
    For i = 1 To 3
        Do
            x = Int(Rnd * 2 * rProtone + 1) - rProtone
            y = Int(Rnd * 2 * rProtone + 1) - rProtone
        Loop While x ^ 2 + y ^ 2 > rProtone ^ 2 ' distanza > raggio prototone
        If i < 3 Then c = Rosso Else c = Blu
        PSet (xCentro + x, yCentro + y), c
    Next

    ' Elettrone furioso: pixel gialli entro raggio mezza altezza display
    For j = 1 To cicliElettroni
        Do
            x = Int(Rnd * yDisplay + 1) - yDisplay / 2
            y = Int(Rnd * yDisplay + 1) - yDisplay / 2
        Loop While x ^ 2 + y ^ 2 > (yDisplay / 2) ^ 2
        PSet (xCentro + x, yCentro + y), Giallo
    Next

    _Limit 30 ' limita frame

Loop Until InKey$ = Chr$(27)
```

## 📜 Licenza

Questo progetto è rilasciato nel **Pubblico Dominio (Public Domain)**.

-----

