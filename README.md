# ⚛️ ATOM SIMULATOR (Revival 1987-90)

Questo progetto raccoglie una serie di simulazioni atomiche sviluppate da Marco da Venezia fra il 1987 e 1990, fino al 2025 con l'assistenza di Bishop.
Le simulazioni spaziano da diversi esperimenti scritti in **QuicKBASIC 4.5/7.1** con grafica VGA (`SCREEN 12`, 640x480, 16 colori) pensate per rendere visivamente comprensibili i concetti di struttura atomica e orbite elettroniche, fino ad una versione in **QB64** non didattica, ma d'effetto grazie alle prestazioni dei moderni PC.

-----


## ⚙️ Requisiti e Velocità di Esecuzione

Per apprezzare al meglio l'animazione, il codice dovrebbe essere compilato.

| Modalità di Esecuzione | Velocità e Fluidità | Note |
| :--- | :--- | :--- |
| **QuickBASIC (compilato in EXE)** | Ottima fluidità (`.EXE` generato da QB 4.5 o successivi) | La velocità di esecuzione è 7-8 volte superiore all'interprete. **Raccomandata per l'esperienza vintage.** |
| **QB64/FreeBASIC (compilato a 32/64 bit)** | Estremamente veloce | In ambienti moderni, se l'animazione è troppo rapida, si consiglia di **de-commentare** la riga di ritardo nel loop principale (`' t0 = TIMER...`) per rallentare il *framerate*. |
| **QBASIC (interprete)** | Lento / Bassa fluidità | Utile solo per ispezione e debug. |

-----


## 📜 Licenza

Questo progetto è rilasciato nel **Pubblico Dominio (Public Domain)**.

-----
