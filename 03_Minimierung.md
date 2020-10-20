<!--

author:   Sebastian Zug & André Dietrich & Fabian Bär
email:    sebastian.zug@informatik.tu-freiberg.de & andre.dietrich@informatik.tu-freiberg.de & fabian.baer@student.tu-freiberg.de
version:  0.0.1
language: de
narrator: Deutsch Female

import: https://raw.githubusercontent.com/LiaTemplates/NetSwarm-Simulator/master/README.md

-->

# 03 - Minimierung boolscher Ausdrücke

**TU Bergakademie Freiberg - Wintersemester 2020 / 21**

Link auf die aktuelle Vorlesung im Versionsmanagementsystem GitHub

[https://github.com/TUBAF-IfI-LiaScript/VL_EingebetteteSysteme/blob/00_Einfuehrung](https://github.com/TUBAF-IfI-LiaScript/VL_EingebetteteSysteme/blob/dev/00_Einfuehrung)

Die interaktive Form ist unter diese Link zu finden ->
[TODO]( )

---------------------------------------------------------------------

** Fragen an die Veranstaltung**

+ Nennen Sie die Axiome der Boolschen Algebra.
+ Erläutern Sie das Dualitätsprinzip der Boolschen Algebra.
+ Wie viele Schaltfunktionen existieren für 2 Eingangsvariablen?
+ Nennen Sie 3 Beispiele, wie eine Schaltfunktion technisch umgesetzt werden kann.
+ Welcher Unterschied besteht zwischen der DNF und der KDNF?
+ Welcher Unterschied besteht zwischen der DNF und der KNF?
+ Geben Sie das de Morgansche Gesetz wieder.

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

## Ansatzpunkt

                                --{{0}}--
Ausgangspunkt für die Minimierung von Boolschen Ausdrücken ist das neutrale
Element einer Operation. Für eine `ODER` Verknüpfung bewirkt eine falsche Aussage und für eine `UND` Operation eine wahre Aussage keine Veränderung des Gesamtausdruckes.

_"Wenn es regnet UND WAHR"_  hängt nur von der Wettersituation ab


| Disjunktive Normalform | Konjunktive Normalform |
|------------------------|------------------------|
| $\begin{aligned} f(x,y)&= x \cdot y + x \cdot \overline{y} \\ &=  x \cdot (y + \overline{y}) \\ &= x\cdot (1) \end{aligned}$  |   $\begin{aligned} f(x,y) &= (x + y) \cdot (x + \overline{y}) \\ &= x + (y + \overline{y}) \\ &=x+(0)\end{aligned}$ |
| Wenn sich in einer disjunktiven Normalform zwei Summanden nur in genau einer komplementären Variablen unterscheiden, so können beide Summanden durch ihren gemeinsamen Teil ersetzt werden! | Wenn sich in einer konjunktiven Normalform zwei Produkte nur in genau einer komplementären Variablen unterscheiden, so können beide Produkte durch ihren gemeinsamen Teil ersetzt werden! |


## Anwendungsfall

Nehmen wir an, dass wir die Logik einer Kaffeemaschine umsetzen wollen. Diese
verfügt über verschiedene Eingänge wie Sensoren an der Heizplatte, einem
Füllstandsmesser, Drucksensorik usw. Wir gehen davon aus, dass diese lediglich
digitale Ausgaben generiert.

Die Variable $y$ gibt entsprechend einen Fehlerzustand wieder und ist zum
Beispiel mit einer LED verknüpft. Ab Zustand 6 bis 14 soll diese Leuchten.

| $x_3$ | $x_2$ | $x_1$ | $x_0$ | $y$ | Zustand                  |
| ----- | ----- | ----- | ----- | --- | ------------------------ |
| 0     | 0     | 0     | 0     | 0   | 0  - Initialisierung     |
| 0     | 0     | 0     | 1     | 0   | 1  - Heizplatte erwärmen |
| 0     | 0     | 1     | 0     | 0   | 2  - Wasserkocher an     |
| 0     | 0     | 1     | 1     | 0   | 3  -                     |
| 0     | 1     | 0     | 0     | 0   | 4  -                     |
| 0     | 1     | 0     | 1     | 0   | 5  -                     |
| 0     | 1     | 1     | 0     | 1   | 6  - Wasser fehlt        |
| 0     | 1     | 1     | 1     | 1   | 7  - Kaffeefach geöffnet |
| 1     | 0     | 0     | 0     | 1   | 8  - Druckabfall         |
| 1     | 0     | 0     | 1     | 1   | 9  - ...                 |
| 1     | 0     | 1     | 0     | 1   | 10  -                    |
| 1     | 0     | 1     | 1     | 1   | 11  -                    |
| 1     | 1     | 0     | 0     | 1   | 12  -                    |
| 1     | 1     | 0     | 1     | 1   | 13  -                    |
| 1     | 1     | 1     | 0     | 1   | 14  -  Wartung fällig    |
| 1     | 1     | 1     | 1     | 0   | 15  -  Kaffee fertig     |

Wie muss also die Schaltung für diese Aufgabe umgesetzt werden? Wir gehen davon
aus, dass diese Schaltfunktion mit NAND-Gattern umgesetzt werden soll.

### Schritt 1: Aufstellen der Gleichungen

**Disjuktive Normalform (DNF, Summe von Produkt-Mintermen)**

+ Disjunktion von Produkttermen
+ Beispiel: $( x \cdot y ) + ( x \cdot y \cdot z )$

**Konjunktive Normalform**

+ Konjunktion von Summentermen
+ Beispiel: $w \cdot ( x + y ) \cdot ( x + y + z )$

**Kanonische Disjunktive Normalform (KDNF)**

+ eindeutige Darstellung einer booleschen Funktion f als Disjunktion von Mintermen
+ Beispiel: $( x \cdot y \cdot z ) + ( x \cdot y \cdot z ) + ( x \cdot y \cdot z )$ ist KDNF von $f(x,y,z)$

**Kanonische Konjunktive Normalform (KKNF)**

+ eindeutige Darstellung einer booleschen Funktion f als Konjunktion von Maxtermen
+  Beispiel: $( x + y ) \cdot ( x + y ) \cdot ( x + y )$ ist KKNF von $f(x,y)$


| $x_3$ | $x_2$ | $x_1$ | $x_0$ | $y$ | Minterme                                                             | Maxterme                                                            |
| ----- | ----- | ----- | ----- | --- | -------------------------------------------------------------------- | ------------------------------------------------------------------- |
| 0     | 0     | 0     | 0     | 0   |                                                                      | $x_3 + x_2 + x_1 + x_0$                                             |
| 0     | 0     | 0     | 1     | 0   |                                                                      | $x_3 + x_2 + x_1 + \overline{x_0}$                                  |
| 0     | 0     | 1     | 0     | 0   |                                                                      | $x_3 + x_2 + \overline{x_1} + x_0$                                  |
| 0     | 0     | 1     | 1     | 0   |                                                                      | $x_3 + x_2 + \overline{x_1} + \overline{x_0}$                       |
| 0     | 1     | 0     | 0     | 0   |                                                                      | $x_3 + \overline{x_2} + x_1 + x_0$                                  |
| 0     | 1     | 0     | 1     | 0   |                                                                      | $x_3 + \overline{x_2} + x_1 + \overline{x_0}$                       |
| 0     | 1     | 1     | 0     | 1   | $\overline{x_3} \cdot x_2 \cdot x_1 \cdot \overline{x_0}$            |                                                                     |
| 0     | 1     | 1     | 1     | 1   | $\overline{x_3} \cdot x_2 \cdot x_1 \cdot x_0$                       |                                                                     |
| 1     | 0     | 0     | 0     | 1   | $x_3 \cdot \overline{x_2} \cdot \overline{x_1} \cdot \overline{x_0}$ |                                                                     |
| 1     | 0     | 0     | 1     | 1   | $x_3 \cdot \overline{x_2} \cdot \overline{x_1} \cdot x_0$            |                                                                     |
| 1     | 0     | 1     | 0     | 1   | $x_3 \cdot \overline{x_2} \cdot x_1 \cdot \overline{x_0}$            |                                                                     |
| 1     | 0     | 1     | 1     | 1   | $x_3 \cdot \overline{x_2} \cdot x_1 \cdot x_0$                       |                                                                     |
| 1     | 1     | 0     | 0     | 1   | $x_3 \cdot x_2 \cdot \overline{x_1} \cdot \overline{x_0}$            |                                                                     |
| 1     | 1     | 0     | 1     | 1   | $x_3 \cdot x_2 \cdot \overline{x_1} \cdot x_0$                       |                                                                     |
| 1     | 1     | 1     | 0     | 1   | $x_3 \cdot x_2 \cdot x_1 \cdot \overline{x_0}$                       |                                                                     |
| 1     | 1     | 1     | 1     | 0   |                                                                      | $\overline{x_3} + \overline{x_2} + \overline{x_1} + \overline{x_0}$ |

### Schritt 2: Vereinfachen der Mintherme - Stufe I



## Übungsaufgaben

Weisen Sie nach, dass die im Beispiel aufgeführten Min- und Maxterme eine identische Aussage treffen.
