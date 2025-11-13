' uranium_qb64.bas
' Marco da Venezia & Bishop, 2025 - U.BAS legacy pre-Windows
' Versione a orbite colorate e testo centrato
' Non didattico: dimostrazione d'effetto per schermi moderni

_Title "Uranium Atom - QB64 Edition"

Randomize Timer

' Ottiene la risoluzione disponibile
sw = _DesktopWidth - 30
sh = _DesktopHeight - 30
' per finestra leggermente piu' piccola del massimo
Screen _NewImage(sw, sh, 32)
' dall' angolo superiore destro
_ScreenMove 0, 0

' Centri e dimensioni dinamiche
xc = sw / 2
yc = sh / 2
atomRadius = yc

Const nucleusRadius = 40
Const numElectrons = 92
Const numNucleons = 238

Dim ex(numElectrons), ey(numElectrons), ea(numElectrons), eo(numElectrons)

' Orbite colorate
Dim orbitColor(7) As _Unsigned Long
orbitColor(1) = _RGB32(255, 80, 80) ' rosso
orbitColor(2) = _RGB32(255, 140, 0) ' arancio
orbitColor(3) = _RGB32(255, 255, 80) ' giallo
orbitColor(4) = _RGB32(80, 255, 80) ' verde
orbitColor(5) = _RGB32(80, 200, 255) ' azzurro
orbitColor(6) = _RGB32(160, 100, 255) ' viola
orbitColor(7) = _RGB32(255, 120, 255) ' magenta

' Inizializza orbite ed elettroni
For e = 1 To numElectrons
    ea(e) = Rnd * 2 * _Pi
    eo(e) = Int(Rnd * 7) + 1
Next

Dim pulse As Single: pulse = 0
text$ = "Press any key to exit"
tw = _PrintWidth(text$)
th = _FontHeight

Do
    pulse = pulse + .05
    redPulse = 200 + 55 * Sin(pulse)
    yellowPulse = 180 + 50 * Sin(pulse / 1.3)

    ' Persistenza visiva
    Line (0, 0)-(sw, sh), _RGB32(0, 0, 0, 40), BF

    ' Nucleo pulsante
    For i = 1 To numNucleons
        angle = Rnd * 2 * _Pi
        dist = nucleusRadius * Rnd
        x = xc + dist * Cos(angle)
        y = yc + dist * Sin(angle)
        If Rnd < 0.5 Then c = _RGB32(redPulse, 80, 80) Else c = _RGB32(yellowPulse, yellowPulse, 100)
        PSet (x, y), c
    Next

    ' Elettroni in moto
    For e = 1 To numElectrons
        ea(e) = ea(e) + (Rnd - .5) * 0.1
        orbit = eo(e) * (atomRadius / 8)
        ex(e) = xc + orbit * Cos(ea(e))
        ey(e) = yc + orbit * Sin(ea(e))
        Circle (ex(e), ey(e)), 1, orbitColor(eo(e))
        PSet (ex(e), ey(e)), orbitColor(eo(e))
    Next

    ' Testo centrato in basso
    _PrintString (xc - tw / 2, sh - th * 2), text$

    _Limit 30
Loop Until Len(InKey$)

