
# ⚛️ BOHR.BAS (Simulatore di Elettroni e Fotoni)

Questo è un modello didattico, scritto in **Microsoft QuickBASIC** nel 1987, che simula in modo concettuale il **Modello Atomico di Bohr** e il fenomeno del **Salto Quantico**.

Il programma illustra il comportamento di un singolo elettrone che assorbe ed emette energia (fotoni) saltando tra livelli energetici discreti (orbitali). Gira in modalità grafica VGA (`SCREEN 12`, 640x480, 16 colori).

## ✨ Concetti Didattici Simuati

Questo simulatore è focalizzato sull'illustrazione di tre concetti chiave della fisica atomica:

### 1\. Livelli Energetici Discreti

Gli elettroni esistono solo su **orbitali fissi** (i cerchi concentrici grigi). Nel codice, questi sono definiti da un raggio costante (`sO = 60`) e non si muovono nello spazio intermedio.

### 2\. Salto Quantico (Quantum Jump)

L'elettrone cambia livello (variabile `orb`) in modo casuale, simulando l'interazione con l'energia esterna:

  * **Assorbimento di Fotone (Giallo):** Se l'elettrone salta a un livello superiore, un fotone giallo viene disegnato mentre si dirige verso il nucleo, rappresentando l'energia assorbita.
  * **Emissione di Fotone (Marrone):** Se l'elettrone cade a un livello inferiore, un fotone marrone viene disegnato mentre si allontana dal nucleo, rappresentando l'energia emessa.

### 3\. Nuvola di Probabilità

L'elettrone viene disegnato *casualmente* in un punto dell'orbita. Questo prefigura l'idea che, in ogni dato momento, l'elettrone si trova da qualche parte sulla "superficie" del suo guscio energetico, non seguendo una traiettoria definita.

### 4\. Il Nucleo di Quark (Bonus)

Il nucleo centrale mostra tre particelle (che alludono ai **Quark**) che "danzano" al suo interno, rappresentando la natura composita del protone.

-----

## ⚙️ Requisiti e Velocità di Esecuzione

Sebbene il codice possa essere eseguito in un interprete come **QBASIC** (ad esempio tramite DOSBox), l'animazione risulterà notevolmente più fluida se compilata.

| Modalità di Esecuzione | Velocità e Fluidità | Note |
| :--- | :--- | :--- |
| **QuickBASIC (compilato in EXE)** | Ottima fluidità (`.EXE` generato da QB 4.5 o successivi) | La velocità di esecuzione è 7-8 volte superiore all'interprete. **Raccomandata per l'esperienza vintage.** |
| **QB64/FreeBASIC (compilato a 32/64 bit)** | Estremamente veloce (potrebbe essere necessario il ritardo) | In ambienti moderni, è consigliato **de-commentare** la riga di ritardo (`' t = TIMER: WHILE TIMER - t < .2: WEND`) se l'animazione risulta troppo rapida. |
| **QBASIC (interprete)** | Lento / Bassa fluidità | Utile solo per ispezione e debug. |

-----

## 💻 Il Codice

Puoi salvare il codice qui sotto come `BOHR.BAS` e compilarlo o eseguirlo.

```
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


```

## 📜 Licenza

Questo progetto è rilasciato nel **Pubblico Dominio (Public Domain)**, in linea con lo spirito di condivisione e conservazione del software "vintage". Sentiti libero di usarlo, modificarlo e distribuirlo.