$Debug
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
