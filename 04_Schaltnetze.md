<!--

author:   Sebastian Zug & André Dietrich & Fabian Bär
email:    sebastian.zug@informatik.tu-freiberg.de & andre.dietrich@informatik.tu-freiberg.de & fabian.baer@student.tu-freiberg.de
version:  0.0.2
language: de
narrator: Deutsch Female

import: https://raw.githubusercontent.com/LiaTemplates/NetSwarm-Simulator/master/README.md
import:   https://raw.githubusercontent.com/LiaTemplates/DigiSim/master/README.md

-->

# 04 - Schaltnetze

**TU Bergakademie Freiberg - Wintersemester 2020 / 21**

Link auf die aktuelle Vorlesung im Versionsmanagementsystem GitHub

[https://github.com/TUBAF-IfI-LiaScript/VL_EingebetteteSysteme/blob/00_Einfuehrung](https://github.com/TUBAF-IfI-LiaScript/VL_EingebetteteSysteme/blob/dev/00_Einfuehrung)

Die interaktive Form ist unter diese Link zu finden ->
[TODO]( )

---------------------------------------------------------------------

** Fragen an die Veranstaltung**

+ Grenzen Sie die Begriffe Schaltnetz und Schaltfunktion voneinander ab.
+ Erklären Sie die Idee von Multiplexern und Kodierern.
+ Welche Besonderheit besteht bei der Ableitung der Schaltfunktionen für einen Dekodierer? Was ist ein SLPD und welche Ausprägungen kennen Sie davon.
+ Wie lassen sich mit einem Multiplexer beliebige Wahrheitstafeln abbilden. Welche Grenzen hat dieser Ansatz?
+ Welche Gatterkombinationen sind geeignet um beliebige Schaltfunktionen damit umzusetzen?


<!--
style="width: 80%; min-width: 420px; max-width: 720px;"
-->
```ascii

                Abstraktionsebenen

           +----------------------------+ -.
  Ebene 6  | Problemorientierte Sprache |  |
           +----------------------------+  |
                                           ⎬ Anwendungssoftware
           +----------------------------+  |
  Ebene 5  | Assemblersprache           |  |
           +----------------------------+ -.

           +----------------------------+
  Ebene 4  | Betriebssystem             |     Systemsoftware
           +----------------------------+

           +----------------------------+
  Ebene 3  | Istruktionsset             |     Maschinensprache
           +----------------------------+

           +----------------------------+  -.
  Ebene 2  | Mikroarchitektur           |   |
           +----------------------------+   |
                                            ⎬ Automaten, Speicher, Logik
           +----------------------------+   |       ╔═══════════════╗
  Ebene 1  | Digitale Logik             |   |    ◀══║ HIER SIND WIR!║
           +----------------------------+  -.       ╚═══════════════╝

           +----------------------------+
  Ebene 0  | E-Technik, Physik          |     Analoge Phänomene
           +----------------------------+                                      .
```

---------------------------------------------------------------------

## Gatter

Ein Logikgatter, auch nur Gatter ist die technische Realisierung einer booleschen Funktion, die binäre Eingangssignale zu einem binären Ausgangssignal verarbeitet. Die Eingangssignale werden durch Implementierung logischer Operatoren, wie der Konjunktion (Und-Gatter), der Disjunktion (Oder-Gatter), der Kontravalenz (Exklusiv-Oder-Gatter) oder der Negation (Nicht-Gatter) zu einem einzigen logischen Ergebnis umgewandelt und auf das Ausgangssignal abgebildet.

Gatterfunktionen können zudem einen negierten Ausgang abbilden: NAND-Gatter (Nicht-Und), NOR-Gatter (Nicht-Oder), XNOR-Gatter (Nicht-Exklusiv-Oder).


| Funktion                                                                                                           | IEC 60617-12 : 1997                                           | ANSI/IEEE Std 91/91a-1991                                        |
| ------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------- | ---------------------------------------------------------------- |
| $\begin{aligned} UN&D \\ Y &= A\cdot B \\ Y&=A\wedge B\end{aligned}$                                               | ![Bild](./images/04_Schaltnetze/188px-IEC_AND_label.svg.png)  | ![Bild](./images/04_Schaltnetze/188px-Logic-gate-and-us.svg.png) |
| $\begin{aligned} OR  & \\ Y &= A+ B \\ Y&=A\vee B\end{aligned}$                                                    | ![Bild](./images/04_Schaltnetze/188px-IEC_OR_label.svg.png)   | ![Bild](./images/04_Schaltnetze/188px-Or-gate-en.svg.png)        |
| $\begin{aligned} NO&T \\ Y &= \overline{A} \\ Y&=A\end{aligned}$                                                   | ![Bild](./images/04_Schaltnetze/188px-IEC_NOT_label.svg.png)  | ![Bild](./images/04_Schaltnetze/188px-Not-gate-en.svg.png)       |
| $\begin{aligned} NA&ND \\ Y &= \overline{A\cdot B} \\ Y&=A\overline{\wedge} B = \overline{A\wedge B}\end{aligned}$ | ![Bild](./images/04_Schaltnetze/188px-IEC_NAND_label.svg.png) | ![Bild](./images/04_Schaltnetze/188px-Nand-gate-en.svg.png)      |
| $\begin{aligned} NO&R \\ Y &= \overline{A + B} \\ Y&=A\overline{\vee} B = \overline{A\vee B} \end{aligned}$        | ![Bild](./images/04_Schaltnetze/188px-IEC_NOR_label.svg.png)  | ![Bild](./images/04_Schaltnetze/188px-Nor-gate-en.svg.png)       |
| $\begin{aligned} NO&R \\ Y &= A \oplus B \\ Y&=A\underline{\vee} B\end{aligned}$                                   | ![Bild](./images/04_Schaltnetze/188px-IEC_XOR_label.svg.png)  | ![Bild](./images/04_Schaltnetze/188px-Xor-gate-en.svg.png)       |
| $\begin{aligned} NO&R \\ Y &= A \odot B \\ Y&=A\underline{\vee} B =\overline{A\underline{\vee}B}\end{aligned}$                                                                 | ![Bild](./images/04_Schaltnetze/188px-IEC_XNOR_label.svg.png)  | ![Bild](./images/04_Schaltnetze/188px-Xnor-gate-en.svg.png)       |

Im englischen Sprachraum waren und sind die amerikanischen Symbole (rechte Spalte) üblich. Die IEC-Symbole sind international auf beschränkte Akzeptanz gestoßen und werden in der amerikanischen Literatur (fast) durchgängig ignoriert.

_Frage:_ Wie viele Schaltfunktionen lassen sich mit zwei Eingängen umsetzen? Ist obige Aufzählung also vollständig?

[[ ]] 2
[[ ]] 6 wie oben gezeigt
[[ ]] 8
[[X]] 16
[[?]] Überlegen Sie, wie viele Kombinationen die Ausgangswerte $y$ abbilden können

## Schaltnetze

> __Merke:__
>
> + Jedes Schaltnetz kann nur mit UND-, ODER- und NICHT-Gattern aufgebaut werden.
>
> + Jedes Schaltnetz kann nur mit NAND Gattern aufgebaut werden.
>
> + Jedes Schaltnetz kann nur mit NOR Gattern aufgebaut werden.

### Beispiel: nur mit NAND

**NOT**

$ \overline{a} = \overline{a \cdot a} $

``` json @DigiSim.evalJson
{"devices":{"a":{"label":"a","type":"Button","propagation":0,"position":{"x":0,"y":0}},"y":{"label":"not a","type":"Lamp","propagation":0,"position":{"x":305,"y":0}},"nand1":{"label":"NAND Gate","type":"Nand","propagation":0,"bits":1,"position":{"x":155,"y":-5}}},"connectors":[{"from":{"id":"a","port":"out"},"to":{"id":"nand1","port":"in1"}},{"from":{"id":"a","port":"out"},"to":{"id":"nand1","port":"in2"}},{"from":{"id":"nand1","port":"out"},"to":{"id":"y","port":"in"}}],"subcircuits":{}}
```

**AND**

$ a \cdot b = \overline{\overline{a \cdot a}} $

``` json @DigiSim.evalJson
{"devices":{"a":{"label":"a","type":"Button","propagation":0,"position":{"x":0,"y":0}},"b":{"label":"b","type":"Button","propagation":0,"position":{"x":0,"y":50}},"y":{"label":"a and b","type":"Lamp","propagation":0,"position":{"x":465,"y":20}},"nand1":{"label":"NAND Gate","type":"Nand","propagation":0,"bits":1,"position":{"x":135,"y":15}},"nand2":{"label":"NAND Gate","type":"Nand","propagation":0,"bits":1,"position":{"x":290,"y":15}}},"connectors":[{"from":{"id":"a","port":"out"},"to":{"id":"nand1","port":"in1"}},{"from":{"id":"b","port":"out"},"to":{"id":"nand1","port":"in2"}},{"from":{"id":"nand1","port":"out"},"to":{"id":"nand2","port":"in1"}},{"from":{"id":"nand1","port":"out"},"to":{"id":"nand2","port":"in2"}},{"from":{"id":"nand2","port":"out"},"to":{"id":"y","port":"in"}}],"subcircuits":{}}
```

**OR**

$ a + b = \overline{\overline{a} \cdot \overline{b}} $

``` json @DigiSim.evalJson
{"devices":{"a":{"label":"a","type":"Button","propagation":0,"position":{"x":0,"y":0}},"b":{"label":"b","type":"Button","propagation":0,"position":{"x":0,"y":50}},"y":{"label":"a or b","type":"Lamp","propagation":0,"position":{"x":480,"y":20}},"nand1":{"label":"NAND Gate","type":"Nand","propagation":0,"bits":1,"position":{"x":140,"y":55}},"nand2":{"label":"NAND Gate","type":"Nand","propagation":0,"bits":1,"position":{"x":310,"y":15}},"nand3":{"label":"NAND Gate","type":"Nand","propagation":0,"bits":1,"position":{"x":140,"y":-5}}},"connectors":[{"from":{"id":"a","port":"out"},"to":{"id":"nand3","port":"in1"}},{"from":{"id":"a","port":"out"},"to":{"id":"nand3","port":"in2"}},{"from":{"id":"b","port":"out"},"to":{"id":"nand1","port":"in1"}},{"from":{"id":"b","port":"out"},"to":{"id":"nand1","port":"in2"}},{"from":{"id":"nand3","port":"out"},"to":{"id":"nand2","port":"in1"}},{"from":{"id":"nand1","port":"out"},"to":{"id":"nand2","port":"in2"}},{"from":{"id":"nand2","port":"out"},"to":{"id":"y","port":"in"}}],"subcircuits":{}}
```


### Weitere Schaltnetze

#### n-zu-k Dekodierer

Dekodiert n Eingänge zu k Ausgängen.

n: Anzahl Eingänge

k: Anzahl Ausgänge

$ k = 2^n $

**3-8 Dekodierer**

$ y_0 = \overline{A} \cdot \overline{B} \cdot \overline{C} $

$ y_1 = \overline{A} \cdot \overline{B} \cdot C $

$ y_2 = \overline{A} \cdot B \cdot \overline{C} $

$ y_3 = \overline{A} \cdot B \cdot C $

...

``` json @DigiSim.evalJson
{"devices":{"a":{"label":"A","type":"Button","propagation":0,"position":{"x":-90,"y":65}},"b":{"label":"B","type":"Button","propagation":0,"position":{"x":-90,"y":115}},"c":{"label":"C","type":"Button","propagation":0,"position":{"x":-100,"y":210}},"y0":{"label":"y0","type":"Lamp","propagation":0,"position":{"x":590,"y":45}},"y1":{"label":"y1","type":"Lamp","propagation":0,"position":{"x":590,"y":105}},"y2":{"label":"y2","type":"Lamp","propagation":0,"position":{"x":595,"y":175}},"y3":{"label":"y3","type":"Lamp","propagation":0,"position":{"x":590,"y":230}},"y4":{"label":"y4","type":"Lamp","propagation":0,"position":{"x":595,"y":285}},"y5":{"label":"y5","type":"Lamp","propagation":0,"position":{"x":590,"y":345}},"y6":{"label":"y6","type":"Lamp","propagation":0,"position":{"x":595,"y":415}},"y7":{"label":"y7","type":"Lamp","propagation":0,"position":{"x":595,"y":480}},"notA":{"label":"NOT a","type":"Not","propagation":0,"bits":1,"position":{"x":55,"y":90}},"notB":{"label":"NOT b","type":"Not","propagation":0,"bits":1,"position":{"x":40,"y":165}},"notC":{"label":"NOT c","type":"Not","propagation":0,"bits":1,"position":{"x":35,"y":375}},"and1":{"label":"~A and ~B","type":"And","propagation":0,"bits":1,"position":{"x":230,"y":95}},"and2":{"label":"~A and B","type":"And","propagation":0,"bits":1,"position":{"x":230,"y":195}},"and3":{"label":"A and ~B","type":"And","propagation":0,"bits":1,"position":{"x":235,"y":290}},"and4":{"label":"A and B","type":"And","propagation":0,"bits":1,"position":{"x":230,"y":410}},"and5":{"label":"~A and ~B and ~C","type":"And","propagation":0,"bits":1,"position":{"x":420,"y":40}},"and6":{"label":"~A and ~B and C","type":"And","propagation":0,"bits":1,"position":{"x":430,"y":100}},"and7":{"label":"~A and B and ~C","type":"And","propagation":0,"bits":1,"position":{"x":435,"y":170}},"and8":{"label":"~A and B and C","type":"And","propagation":0,"bits":1,"position":{"x":440,"y":225}},"and9":{"label":"A and ~B and ~C","type":"And","propagation":0,"bits":1,"position":{"x":430,"y":280}},"and10":{"label":"A and ~B and C","type":"And","propagation":0,"bits":1,"position":{"x":430,"y":340}},"and11":{"label":"A and B and ~C","type":"And","propagation":0,"bits":1,"position":{"x":435,"y":410}},"and12":{"label":"A and B and C","type":"And","propagation":0,"bits":1,"position":{"x":445,"y":475}}},"connectors":[{"from":{"id":"a","port":"out"},"to":{"id":"notA","port":"in"}},{"from":{"id":"b","port":"out"},"to":{"id":"notB","port":"in"}},{"from":{"id":"c","port":"out"},"to":{"id":"notC","port":"in"}},{"from":{"id":"and1","port":"out"},"to":{"id":"and5","port":"in1"}},{"from":{"id":"and1","port":"out"},"to":{"id":"and6","port":"in1"}},{"from":{"id":"and2","port":"out"},"to":{"id":"and7","port":"in1"}},{"from":{"id":"and2","port":"out"},"to":{"id":"and8","port":"in1"}},{"from":{"id":"and3","port":"out"},"to":{"id":"and9","port":"in1"}},{"from":{"id":"and3","port":"out"},"to":{"id":"and10","port":"in1"}},{"from":{"id":"and4","port":"out"},"to":{"id":"and11","port":"in1"}},{"from":{"id":"and4","port":"out"},"to":{"id":"and12","port":"in1"}},{"from":{"id":"notA","port":"out"},"to":{"id":"and1","port":"in1"}},{"from":{"id":"notB","port":"out"},"to":{"id":"and1","port":"in2"}},{"from":{"id":"notA","port":"out"},"to":{"id":"and2","port":"in1"}},{"from":{"id":"b","port":"out"},"to":{"id":"and2","port":"in2"},"vertices":[{"x":130,"y":160}]},{"from":{"id":"a","port":"out"},"to":{"id":"and3","port":"in1"},"vertices":[{"x":10,"y":215}]},{"from":{"id":"notB","port":"out"},"to":{"id":"and3","port":"in2"}},{"from":{"id":"a","port":"out"},"to":{"id":"and4","port":"in1"},"vertices":[{"x":10,"y":225},{"x":155,"y":395}]},{"from":{"id":"b","port":"out"},"to":{"id":"and4","port":"in2"},"vertices":[{"x":130,"y":160}]},{"from":{"id":"c","port":"out"},"to":{"id":"and6","port":"in2"},"vertices":[{"x":295,"y":265}]},{"from":{"id":"notC","port":"out"},"to":{"id":"and5","port":"in2"},"vertices":[{"x":330,"y":335}]},{"from":{"id":"c","port":"out"},"to":{"id":"and8","port":"in2"},"vertices":[{"x":310,"y":275}]},{"from":{"id":"notC","port":"out"},"to":{"id":"and7","port":"in2"},"vertices":[{"x":330,"y":335},{"x":370,"y":295}]},{"from":{"id":"notC","port":"out"},"to":{"id":"and9","port":"in2"},"vertices":[{"x":335,"y":335}]},{"from":{"id":"notC","port":"out"},"to":{"id":"and11","port":"in2"},"vertices":[{"x":320,"y":345}]},{"from":{"id":"c","port":"out"},"to":{"id":"and10","port":"in2"}},{"from":{"id":"c","port":"out"},"to":{"id":"and12","port":"in2"},"vertices":[{"x":360,"y":370}]},{"from":{"id":"and5","port":"out"},"to":{"id":"y0","port":"in"}},{"from":{"id":"and6","port":"out"},"to":{"id":"y1","port":"in"}},{"from":{"id":"and7","port":"out"},"to":{"id":"y2","port":"in"}},{"from":{"id":"and8","port":"out"},"to":{"id":"y3","port":"in"}},{"from":{"id":"and9","port":"out"},"to":{"id":"y4","port":"in"}},{"from":{"id":"and10","port":"out"},"to":{"id":"y5","port":"in"}},{"from":{"id":"and11","port":"out"},"to":{"id":"y6","port":"in"}},{"from":{"id":"and12","port":"out"},"to":{"id":"y7","port":"in"}}],"subcircuits":{}}
```


#### n-zu-k Kodierer**

Kodiert n Eingänge zu k Ausgängen

Genau einer der Eingänge muss 1 sein.

**8-3 Kodierer**

$ y_0 = x_1 + x_3 + x_5 + x_7 $

$ y_1 = x_2 + x_3 + x_6 + x_7 $

$ y_2 = x_4 + x_5 + x_6 + x_7 $


``` json @DigiSim.evalJson
{"devices":{"x0":{"label":"x0","type":"Button","propagation":0,"position":{"x":0,"y":0}},"x1":{"label":"x1","type":"Button","propagation":0,"position":{"x":0,"y":50}},"x2":{"label":"x2","type":"Button","propagation":0,"position":{"x":0,"y":105}},"x3":{"label":"x3","type":"Button","propagation":0,"position":{"x":0,"y":160}},"x4":{"label":"x4","type":"Button","propagation":0,"position":{"x":0,"y":215}},"x5":{"label":"x5","type":"Button","propagation":0,"position":{"x":0,"y":265}},"x6":{"label":"x6","type":"Button","propagation":0,"position":{"x":0,"y":320}},"x7":{"label":"x7","type":"Button","propagation":0,"position":{"x":0,"y":375}},"y0":{"label":"y0","type":"Lamp","propagation":0,"position":{"x":570,"y":185}},"y1":{"label":"y1","type":"Lamp","propagation":0,"position":{"x":530,"y":210}},"y2":{"label":"y2","type":"Lamp","propagation":0,"position":{"x":485,"y":240}},"or1":{"label":"x1 or x3","type":"Or","propagation":0,"bits":1,"position":{"x":190,"y":80}},"or2":{"label":"x5 or x7","type":"Or","propagation":0,"bits":1,"position":{"x":195,"y":140}},"or3":{"label":"x1 or x3 or x5 or x7","type":"Or","propagation":0,"bits":1,"position":{"x":345,"y":120}},"or4":{"label":"x2 or x3","type":"Or","propagation":0,"bits":1,"position":{"x":200,"y":200}},"or5":{"label":"x6 or x7","type":"Or","propagation":0,"bits":1,"position":{"x":205,"y":290}},"or6":{"label":"x2 or x3 or x6 or x7","type":"Or","propagation":0,"bits":1,"position":{"x":350,"y":225}},"or7":{"label":"x4 or x5","type":"Or","propagation":0,"bits":1,"position":{"x":200,"y":360}},"or8":{"label":"x4 or x5 or x6 or x7","type":"Or","propagation":0,"bits":1,"position":{"x":360,"y":320}}},"connectors":[{"from":{"id":"x1","port":"out"},"to":{"id":"or1","port":"in1"}},{"from":{"id":"x3","port":"out"},"to":{"id":"or1","port":"in2"}},{"from":{"id":"x5","port":"out"},"to":{"id":"or2","port":"in1"},"vertices":[{"x":135,"y":170}]},{"from":{"id":"x7","port":"out"},"to":{"id":"or2","port":"in2"},"vertices":[{"x":145,"y":310}]},{"from":{"id":"x2","port":"out"},"to":{"id":"or4","port":"in1"}},{"from":{"id":"x3","port":"out"},"to":{"id":"or4","port":"in2"}},{"from":{"id":"x6","port":"out"},"to":{"id":"or5","port":"in1"},"vertices":[{"x":90,"y":335}]},{"from":{"id":"x7","port":"out"},"to":{"id":"or5","port":"in2"}},{"from":{"id":"x4","port":"out"},"to":{"id":"or7","port":"in1"},"vertices":[{"x":95,"y":290}]},{"from":{"id":"x5","port":"out"},"to":{"id":"or7","port":"in2"}},{"from":{"id":"or1","port":"out"},"to":{"id":"or3","port":"in1"}},{"from":{"id":"or2","port":"out"},"to":{"id":"or3","port":"in2"}},{"from":{"id":"or4","port":"out"},"to":{"id":"or6","port":"in1"}},{"from":{"id":"or5","port":"out"},"to":{"id":"or6","port":"in2"}},{"from":{"id":"or5","port":"out"},"to":{"id":"or8","port":"in1"}},{"from":{"id":"or7","port":"out"},"to":{"id":"or8","port":"in2"}},{"from":{"id":"or3","port":"out"},"to":{"id":"y0","port":"in"}},{"from":{"id":"or6","port":"out"},"to":{"id":"y1","port":"in"}},{"from":{"id":"or8","port":"out"},"to":{"id":"y2","port":"in"}}],"subcircuits":{}}
```

#### Multiplexer




#### Demultiplexer
