<!--

author:   Sebastian Zug & André Dietrich & Fabian Bär
email:    sebastian.zug@informatik.tu-freiberg.de & andre.dietrich@informatik.tu-freiberg.de & fabian.baer@student.tu-freiberg.de
version:  0.0.3
language: de
narrator: Deutsch Female

import:   https://github.com/liascript/CodeRunner
          https://raw.githubusercontent.com/TUBAF-IfI-LiaScript/VL_EingebetteteSysteme/master/config.md
-->

[![LiaScript](https://raw.githubusercontent.com/LiaScript/LiaScript/master/badges/course.svg)](https://liascript.github.io/course/?https://raw.githubusercontent.com/TUBAF-IfI-LiaScript/VL_EingebetteteSysteme/master/03_Minimierung.md#1)

# Minimierung von Boolesche Funktionen

| Parameter            | Kursinformationen                                                                                                                                                                          |
| -------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| **Veranstaltung:**   | @config.lecture                                                                                                                                                                            |
| **Semester**         | @config.semester                                                                                                                                                                           |
| **Hochschule:**      | `Technische Universität Freiberg`                                                                                                                                                          |
| **Inhalte:**         | `Minimierung boolescher Funktionen`                                                                                                                                                        |
| **Link auf GitHub:** | [https://github.com/TUBAF-IfI-LiaScript/VL_EingebetteteSysteme/blob/master/00_Einfuehrung.md](https://github.com/TUBAF-IfI-LiaScript/VL_EingebetteteSysteme/blob/master/03_Minimierung.md) |
| **Autoren**          | @author                                                                                                                                                                                    |

![](https://media.giphy.com/media/10PNyg7YOcaBQA/giphy-downsized.gif)

---------------------------------------------------------------------

** Fragen an die Veranstaltung**

+ Nennen Sie 3 Beispiele, wie eine Schaltfunktion technisch umgesetzt werden kann.
+ Welcher Unterschied besteht zwischen der DNF und der KDNF?
+ Welcher Unterschied besteht zwischen der DNF und der KNF?
+ Geben Sie das De-Morgansche Gesetz wieder.
+ Welchem Grundkonzept folgt das Diagramm von Karnaugh-Veitch?
+ Welche Areale können im Diagramm zusammengefasst werden?
+ Worin unterscheidet sich das Vorgehen mit dem Karnaugh-Veitch-Diagramm für Min- und Maxterme?

---------------------------------------------------------------------

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
  Ebene 3  | Instruktionsset            |     Maschinensprache
           +----------------------------+

           +----------------------------+  -.
  Ebene 2  | Mikroarchitektur           |   |
           +----------------------------+   |
                                            ⎬ Automaten, Speicher, Logik
           +----------------------------+   |       ╔═══════════════╗
  Ebene 1  | Digitale Logik             |   |   ◀══║ HIER SIND WIR!║
           +----------------------------+  -.       ╚═══════════════╝

           +----------------------------+
  Ebene 0  | E-Technik, Physik          |     Analoge Phänomene
           +----------------------------+                                      .
```

---------------------------------------------------------------------

## Wie weit waren wir gekommen?

$$
\begin{aligned}
f(x_1, x_2, x_3, x_4) &= x_3\overline{x}_1+ x_4\overline{x}_3\overline{x}_2 + \overline{x}_4x_3x_2\overline{x}_1 + x_4x_3\overline{x}_2x_1 \\
g(x_1, x_2, x_3, x_4) &= x_3\overline{x}_1 + x_4\overline{x}_2
\end{aligned}
$$

Weisen Sie nach, dass die Terme äquivalent sind. Wie gehen Sie vor?

{{1}}
$$
\begin{aligned}
f(x_1, x_2, x_3, x_4) &= x_3\overline{x}_1+ x_4\overline{x}_3\overline{x}_2 + \overline{x}_4x_3x_2\overline{x}_1 + x_4x_3\overline{x}_2x_1 \\
&= x_3\overline{x}_1  + \overline{x}_4x_3x_2\overline{x}_1 + x_4x_3\overline{x}_2x_1   + x_4\overline{x}_3\overline{x}_2 & (Kommutativgesetz) \\
&= x_3\overline{x}_1 + x_4x_3\overline{x}_2x_1   + x_4\overline{x}_3\overline{x}_2 & (Absorptionsgesetz) \\
\end{aligned}
$$

{{1}}
Mmmmh, scheinbar keine weitere Vereinfachung möglich ... sollten die beiden Gleichungen nicht äquivalent sein? Worin liegt unser Denkfehler?


       {{2}}
********************************************************************************

Alternativ können wir den Nachweis der Äquivalenz auch über die Wertetabellen darstellen. Das funktioniert natürlich nur bis zu einer gewissen Größe. Aber die Wertetabelle macht auch deutlich, dass wir mit unseren schon minimierten Termen $x_3\overline{x}_1$ deutlich mehr Terme einschließen!

<!-- data-type="none" style="table-layout: fixed; max-width:800px;"-->
| $x_4$                                 | $x_3$ | $x_2$                                 | $x_1$ | $f$ |                                                           |
| ------------------------------------- | ----- | ------------------------------------- | ----- | --- | --------------------------------------------------------- |
| 0                                     | 0     | 0                                     | 0     | 0   |                                                           |
| 0                                     | 0     | 0                                     | 1     | 0   |                                                           |
| 0                                     | 0     | 1                                     | 0     | 0   |                                                           |
| 0                                     | 0     | 1                                     | 1     | 0   |                                                           |
| 0                                     | 1     | 0                                     | 0     | 1   | $x_3\overline{x}_1$                                       |
| 0                                     | 1     | 0                                     | 1     | 0   |                                                           |
| 0                                     | 1     | 1                                     | 0     | 1   | $\overline{x}_4x_3x_2\overline{x}_1$, $x_3\overline{x}_1$ |
| 0                                     | 1     | 1                                     | 1     | 0   |                                                           |
| <span style="color: #ff0000">1</span> | 0     | <span style="color: #ff0000">0</span> | 0     | 1   | $x_4\overline{x}_3\overline{x}_2$                         |
| <span style="color: #ff0000">1</span> | 0     | <span style="color: #ff0000">0</span> | 1     | 1   | $x_4\overline{x}_3\overline{x}_2$                         |
| 1                                     | 0     | 1                                     | 0     | 0   |                                                           |
| 1                                     | 0     | 1                                     | 1     | 0   |                                                           |
| <span style="color: #ff0000">1</span> | 1     | <span style="color: #ff0000">0</span> | 0     | 1   | $x_3\overline{x}_1$                                       |
| <span style="color: #ff0000">1</span> | 1     | <span style="color: #ff0000">0</span> | 1     | 1   | $x_4x_3\overline{x}_2x_1$                                 |
| 1                                     | 1     | 1                                     | 0     | 1   | $x_3\overline{x}_1$                                       |
| 1                                     | 1     | 1                                     | 1     | 0   |                                                           |


********************************************************************************

{{3}}
$$
\begin{aligned}
f(x_1, x_2, x_3, x_4) &= x_3\overline{x}_1+ x_4\overline{x}_3\overline{x}_2 + \overline{x}_4x_3x_2\overline{x}_1 + x_4x_3\overline{x}_2x_1 \\
&= x_3\overline{x}_1  + \overline{x}_4x_3x_2\overline{x}_1 + x_4x_3\overline{x}_2x_1   + x_4\overline{x}_3\overline{x}_2 & (Kommutativgesetzt) \\
&= x_3\overline{x}_1 + x_4x_3\overline{x}_2x_1   + x_4\overline{x}_3\overline{x}_2 & (Absorbtionsgesetz) \\
&= x_3 (\overline{x}_1 + x_4\overline{x}_2x_1)   + x_4\overline{x}_3\overline{x}_2 & (Distributivgesetz) \\
&= x_3 ((\overline{x}_1 + x_4) \cdot (\overline{x}_1 +\overline{x}_2) \cdot (\overline{x}_1 +x_1))   + x_4\overline{x}_3\overline{x}_2 & (Idempotenzgesetz) \\
&= x_3 ((\overline{x}_1 + x_4) \cdot (\overline{x}_1 +\overline{x}_2) \cdot (1))   + x_4\overline{x}_3\overline{x}_2 & (Neutrales Element) \\
&= x_3 ((\overline{x}_1 + x_4) \cdot (\overline{x}_1 +\overline{x}_2)) + x_4\overline{x}_3\overline{x}_2 & (Distributivgesetz) \\
&= x_3 (\overline{x}_1 + (x_4 \cdot \overline{x}_2))+ x_4\overline{x}_3\overline{x}_2 & (Distributivgesetz) \\
&= x_3\overline{x}_1 + x_3x_4\overline{x}_2+ x_4\overline{x}_3\overline{x}_2 & (Distributivgesetz) \\
&= x_3\overline{x}_1 + x_4\overline{x}_2(x_3 + \overline{x}_3) & (Distributivgesetz) \\
&= x_3\overline{x}_1 + x_4\overline{x}_2(x_3 + \overline{x}_3) & (Idempotenz/Neutrales Element) \\
&= x_3\overline{x}_1 + x_4\overline{x}_2 & (Fertig) \\
\end{aligned}
$$


      {{3}}
********************************************************************************
Wir sind bei einer Gleichung mit

+ 9 `AND` Verknüpfungen mit teilweise 4 Eingängen
+ 3 `OR` Verknüpfungen mit 4 Eingängen

gestartet und bei

+ 2 `AND` Verknüpfungen mit 2 Eingängen
+ 1 `OR` Verknüpfungen mit 2 Eingängen

geendet. Allerdings kann die manuelle Lösung der Gleichungen kein Lösungsansatz für realistische Logiken sein. Welche Methodik bietet sich also an?

********************************************************************************


## Aufstellen der Normalform


   {{0-1}}
********************************************************************************

| Format                                          | Bedeutung   |
| ----------------------------------------------- | ----------- |
| Wahrheitstafel                                  | eindeutig   |
| allgemeine Boolesche Funktion                   | uneindeutig |
| Normalformdarstellung einer Booleschen Funktion | eindeutig   |
| Schaltnetz                                      | uneindeutig |

********************************************************************************

       {{1-2}}
********************************************************************************

Für die Darstellung der Normalform benötigen wir zunächst weitere Begriffsdefinitionen.

**Produktterm**

+ einfache Variable (ggf. negiert)
+ Konjunktion mehrerer Variablen (ggf. negiert)
+ Beispiele: $x$, $y$, $x\cdot y \cdot \overline{x}$

**Summenterm**

+ wie Produktterm, jedoch Disjunktion statt Konjunktion
+ Beispiele: $x$, $y$, $x + y$, $x + y + z$

**Minterm**

+ Produktterm, in dem jede Variable einer booleschen Funktion genau einmal vorkommt (einfach oder negiert)
+ Beispiel:  $x\cdot y \cdot \overline{z}$ ist ein Minterm der Funktion $f(x,y,z)$

**Maxterm**

+ Summenterm, in dem jede Variable einer booleschen Funktion genau einmal vorkommt (einfach oder negiert)
+ Beispiel: $x + y + z$ ist ein Maxterm der Funktion $f(x,y,z)$

********************************************************************************

   {{2-3}}
********************************************************************************

Und nun in der Kombination ....

**Disjunktive Normalform (DNF, Summe von Produkt-Mintermen)**

+ Disjunktion von Produkttermen
+ Beispiel: $( x \cdot y ) + ( x \cdot y \cdot z )$

**Konjunktive Normalform**

+ Konjunktion von Summentermen
+ Beispiel: $w \cdot ( x + y ) \cdot ( x + y + z )$

**Kanonische Disjunktive Normalform (KDNF)**

+ eindeutige Darstellung einer booleschen Funktion f als Disjunktion von Mintermen
+ Beispiel: $( \overline{x} \cdot y \cdot z ) + ( x \cdot \overline{y} \cdot \overline{z} ) + ( \overline{x} \cdot y \cdot \overline{z} )$ ist KDNF von $f(x,y,z)$

**Kanonische Konjunktive Normalform (KKNF)**

+ eindeutige Darstellung einer booleschen Funktion f als Konjunktion von Maxtermen
+ Beispiel: $( x + \overline{y} ) \cdot ( \overline{x} + y ) \cdot ( \overline{x} + \overline{y} )$ ist KKNF von $f(x,y)$
********************************************************************************

       {{3-4}}
********************************************************************************

> "KDNF = Disjunktion von Mintermen"

>  Jede Boolesche Funktion läßt sich als genau eine KDNF darstellen!

Bildung der KDNF für n -stellige Boolesche Funktion $f$:

+ für jede Zeile der Wahrheitstabelle mit $f(x_1, x_2, ..., x_n) = 1$ wird ein Minterm aufgestellt
+ hierin wird jede Variable $x_i$ negiert, wenn in der entsprechenden Zeile der Wert der Variablen 0 ist

Am Beispiel der Übungsaufgabe vom Begin der Vorlesung ergibt sich daraus:

<!-- data-type="none" style="table-layout: fixed; max-width:700px;"-->
| $x_4$ | $x_3$ | $x_2$ | $x_1$ | $f$ | Minterme                                        |
| ----- | ----- | ----- | ----- | --- | ----------------------------------------------- |
| 0     | 0     | 0     | 0     | 0   |                                                 |
| 0     | 0     | 0     | 1     | 0   |                                                 |
| 0     | 0     | 1     | 0     | 0   |                                                 |
| 0     | 0     | 1     | 1     | 0   |                                                 |
| 0     | 1     | 0     | 0     | 1   | $\overline{x}_4x_3\overline{x}_2\overline{x}_1$ |
| 0     | 1     | 0     | 1     | 0   |                                                 |
| 0     | 1     | 1     | 0     | 1   | $\overline{x}_4x_3x_2\overline{x}_1$            |
| 0     | 1     | 1     | 1     | 0   |                                                 |
| 1     | 0     | 0     | 0     | 1   | $x_4\overline{x}_3\overline{x}_2\overline{x}_1$ |
| 1     | 0     | 0     | 1     | 1   | $x_4\overline{x}_3\overline{x}_2x_1$            |
| 1     | 0     | 1     | 0     | 0   |                                                 |
| 1     | 0     | 1     | 1     | 0   |                                                 |
| 1     | 1     | 0     | 0     | 1   | $x_4x_3\overline{x}_2\overline{x}_1$            |
| 1     | 1     | 0     | 1     | 1   | $x_4x_3\overline{x}_2x_1$                       |
| 1     | 1     | 1     | 0     | 1   | $x_4x_3x_2\overline{x}_1$                       |
| 1     | 1     | 1     | 1     | 0   |                                                 |

Damit ergibt sich die Kanonisch Disjunktiven Normalform obiger Wahrheitstafel zu

$$
\begin{aligned}
f(x_1, x_2, x_3, x_4) =& \overline{x}_4x_3\overline{x}_2\overline{x}_1 + \\
                       &\overline{x}_4x_3x_2\overline{x}_1 + \\
                       & x_4\overline{x}_3\overline{x}_2\overline{x}_1 + \\
                       & x_4\overline{x}_3\overline{x}_2x_1 + \\
                       & x_4x_3\overline{x}_2\overline{x}_1 + \\
                       & x_4x_3\overline{x}_2x_1 +\\
                       & x_4x_3x_2\overline{x}_1\\
\end{aligned}
$$

Vergleichen Sie die Darstellung mit dem Resultat der Einstiegsübung!

> Die Darstellung als KDNF ist abgesehen von Reihenfolge eindeutig!

********************************************************************************

{{4-5}}
********************************************************************************

> "KKNF = Konjunktion von Maxtermen"

>  Jede Boolesche Funktion läßt sich als genau eine KKNF darstellen!

Bildung der KKNF für n -stellige Boolesche Funktion $f$:

+ für jede Zeile der Wahrheitstabelle mit $f(x_1, x_2, ..., x_n) = 0$ wird ein Maxterm aufgestellt
+ hierin wird jede Variable $x_i$ negiert, wenn in der entsprechenden Zeile der Wert der Variablen 1 ist

Am Beispiel der Übungsaufgabe vom Begin der Vorlesung ergibt sich daraus:

<!-- data-type="none"-->
| $x_4$ | $x_3$ | $x_2$ | $x_1$ | $f$ | Maxterme                                                      |
| ----- | ----- | ----- | ----- | --- | ------------------------------------------------------------- |
| 0     | 0     | 0     | 0     | 0   | $x_4+x_3+x_2+x_1$                                             |
| 0     | 0     | 0     | 1     | 0   | $x_4+x_3+x_2+\overline{x}_1$                                  |
| 0     | 0     | 1     | 0     | 0   | $x_4+x_3+\overline{x}_2+x_1$                                  |
| 0     | 0     | 1     | 1     | 0   | $x_4+x_3+\overline{x}_2+\overline{x}_1$                       |
| 0     | 1     | 0     | 0     | 1   |                                                               |
| 0     | 1     | 0     | 1     | 0   | $x_4+\overline{x}_3+x_2+\overline{x}_1$                       |
| 0     | 1     | 1     | 0     | 1   |                                                               |
| 0     | 1     | 1     | 1     | 0   | $x_4+\overline{x}_3+\overline{x}_2+\overline{x}_1$            |
| 1     | 0     | 0     | 0     | 1   |                                                               |
| 1     | 0     | 0     | 1     | 1   |                                                               |
| 1     | 0     | 1     | 0     | 0   | $\overline{x}_4+x_3+\overline{x}_2+x_1$                       |
| 1     | 0     | 1     | 1     | 0   | $\overline{x}_4+x_3+\overline{x}_2+\overline{x}_1$            |
| 1     | 1     | 0     | 0     | 1   |                                                               |
| 1     | 1     | 0     | 1     | 1   |                                                               |
| 1     | 1     | 1     | 0     | 1   |                                                               |
| 1     | 1     | 1     | 1     | 0   | $\overline{x}_4+\overline{x}_3+\overline{x}_2+\overline{x}_1$ |

Damit ergibt sich die Kanonisch Konjunktive Normalform obiger Wahrheitstafel zu

$$
\begin{aligned}
f(x_1, x_2, x_3, x_4) =& x_4+x_3+x_2+x_1 \cdot \\
                &x_4+x_3+x_2+\overline{x}_1 \cdot \\
                & x_4+x_3+\overline{x}_2+x_1 \cdot \\
                & x_4+x_3+\overline{x}_2+\overline{x}_1 \cdot \\
                & x_4+\overline{x}_3+x_2+\overline{x}_1 \cdot \\
                & x_4+\overline{x}_3+\overline{x}_2+\overline{x}_1 \cdot \\
                & \overline{x}_4+x_3+\overline{x}_2+x_1 \cdot \\
                & \overline{x}_4+x_3+\overline{x}_2+\overline{x}_1 \cdot\\
                & \overline{x}_4+\overline{x}_3+\overline{x}_2+\overline{x}_1
\end{aligned}
$$

> Die Darstellung als KKNF ist abgesehen von Reihenfolge eindeutig!

********************************************************************************

    {{5}}
********************************************************************************
> Satz:  Jede KDNF kann in eine KKNF umgewandelt, jede KKNF kann in eine KDNF umgewandelt werden.

>  Zwei Darstellungen Boolescher Funktionen sind äquivalent, wenn sie durch Umformungen gemäß den Sätzen der Booleschen Algebra auf die gleiche KDNF bzw. KKNF zurückgeführt werden können

Welche Form erweist sich in welcher Situation als günstiger?

Eine KDNF ist günstiger als eine KKNF, wenn nur für wenige Kombinationen der Eingabewerte $f(x_1, x_2, ..., x_n) = 1$ gilt. Umgekehrt, wenn nur für wenige Kombinationen der Eingabewerte $f(x_1, x_2, ..., x_n) = 0$ gilt, ist die KKNF vorzuziehen.

Für die `OR` Funktion bedeutet das (wenig überraschend):

<!-- data-type="none" style="table-layout: fixed; max-width:300px;"-->
| $x$ | $y$ | $f$ |
| --- | --- | --- |
| 0   | 0   | 0   |
| 0   | 1   | 1   |
| 1   | 0   | 1   |
| 1   | 1   | 1   |

KDNF: $f = \overline{x}\cdot y+ x\cdot\overline{y} + x \cdot y$

KKNF: $f =x+y$

********************************************************************************

## Minimierung von Schaltfunktionen mit dem KV-Diagramm

+ Wann heißt eine Darstellung minimal ?

   + kleinste Anzahl an Gattern ?
   + kleinste Anzahl an Verbindungsleitungen ?
   + kleinste Anzahl an Produkttermen bzw. Summentermen ?

Lösungsmöglichkeiten:

1.  geeignetes Umformen mit Gesetzen der Booleschen Algebra
2.  Einsatz eines graphischen Verfahrens (z.B. ein Karnaugh-Veith-Diagramm), nur möglich bei Schaltfunktionen mit wenigen Variablen
3. algorithmisches Minimieren (z.B. Verfahren nach Quine-Mc-Cluskey), geeignet auch für Schaltfunktionen mit vielen Variablen

Ausgangspunkt für die Minimierung von Booleschen Ausdrücken ist das neutrale
Element einer Operation. Für eine `ODER` Verknüpfung bewirkt eine falsche Aussage und für eine `UND` Operation eine wahre Aussage keine Veränderung des Gesamtausdruckes.

| Disjunktive Normalform | Konjunktive Normalform |
|------------------------|------------------------|
| $\begin{aligned} f(x,y)&= x \cdot y + x \cdot \overline{y} \\ &=  x \cdot (y + \overline{y}) \\ &= x\cdot (1) \end{aligned}$  |   $\begin{aligned} f(x,y) &= (x + y) \cdot (x + \overline{y}) \\ &= x + (y \cdot \overline{y}) \\ &=x+(0)\end{aligned}$ |
| Wenn sich in einer disjunktiven Normalform zwei Summanden nur in genau einer komplementären Variablen unterscheiden, so können beide Summanden durch ihren gemeinsamen Teil ersetzt werden! | Wenn sich in einer konjunktiven Normalform zwei Produkte nur in genau einer komplementären Variablen unterscheiden, so können beide Produkte durch ihren gemeinsamen Teil ersetzt werden! |

### Karnaugh-Veitch-Diagramme - Konzept

       {{0-2}}
********************************************************************************

Jede zweistellige Boolesche Funktion lässt sich  mit den Kombinationen ihrer Variablen in einer tabellarischen Darstellung visualisieren:

$A= \overline{x} \cdot \overline{y} + \overline{x} \cdot y + x \cdot \overline{y} + x \cdot y$

<!-- data-type="none" style="table-layout: fixed; max-width:300px;"-->
|                | $\overline{x}$                    | $x$                    |
| -------------- | --------------------------------- | ---------------------- |
| $\overline{y}$ | $\overline{x} \cdot \overline{y}$ | $x \cdot \overline{y}$ |
| $y$            | $\overline{x} \cdot y$            | $x \cdot y$            |

Mit dieser verschobenen Wahrheitstafel lässt sich der Fingerabdruck einer booleschen Funktion darstellen.

Bespiel 1: $f= x \cdot \overline{y} + x \cdot y$

<!-- data-type="none" style="table-layout: fixed; max-width:300px;"-->
|                | $\overline{x}$ | $x$ |
| -------------- | -------------- | --- |
| $\overline{y}$ | 0              | 1   |
| $y$            | 0              | 1   |


Bespiel 2: $f= x \cdot \overline{y} + \overline{x} \cdot y$

<!-- data-type="none" style="table-layout: fixed; max-width:300px;"-->
|                | $\overline{x}$ | $x$ |
| -------------- | -------------- | --- |
| $\overline{y}$ | 0              | 1   |
| $y$            | 1              | 0   |


********************************************************************************

       {{1-2}}
********************************************************************************
Dieses Konzept lässt sich auf Funktionen mit beliebig vielen Variablen übertragen. 
Wichtig dabei ist, dass benachbarte Kombinationen von Variablen sich nur in **einer** Variable unterscheiden. (Siehe [Gray-Code](https://itwissen.info/Gray-Code-Gray-code.html))

> Der Gray-Code ist ein stetiger Code, bei dem sich benachbarte Codewörter nur in einer einzigen binären Ziffer unterscheiden.
>
><!-- data-type="none" -->
> | Dezimalzahl | Binärcode | Gray-Code |
> | ----------- | --------- | --------- |
> | 0           | 000       | 000       |
> | 1           | 001       | 001       |
> | 2           | 010       | 011       |
> | 3           | 011       | 010       |

<!-- data-type="none" style="table-layout: fixed; max-width:700px;"-->
|                | $\overline{x}\,\overline{y}$                      | $\overline{x}y$                        | $xy$ | $x\overline{y}$ |
| -------------- | ------------------------------------------------ | -------------------------------------- | ---- | --------------- |
| $\overline{z}$ | $\overline{x}\cdot\overline{y}\cdot\overline{z}$ | $\overline{x}\cdot y\cdot\overline{z}$ | $x\cdot y\cdot\overline{z}$     |    $x\cdot\overline{y}\cdot\overline{z}$             |
| $z$ | $\overline{x}\cdot\overline{y}\cdot z$ | $\overline{x}\cdot y\cdot z$ | $x\cdot y\cdot z$     |    $x\cdot\overline{y}\cdot z$             |

> Jeweils nur ein Wechsel von einer Variable pro Zeilen-/Spaltenübergang! Karnaugh-Veitch-Diagramme werden dabei geometrisch als Torus interpretiert!

********************************************************************************

       {{2-3}}
********************************************************************************

Vorgehen zur Minimierung der KDNF einer $n$-stelligen Funktion $f$

1. wird für jeden Minterm mit $f(x_1,...,x_n) = 1$ eine 1 im Diagramm eingetragen
2. wird für jeden Maxterm mit $f(x_1,...,x_n) = 0$ eine 0 im Diagramm eingetragen;
3. werden möglichst wenige und möglichst große zusammenhängende Bereiche (Schleifen) aus Einsen markiert, wobei

   + jeder Bereich aus $2^k$ Elementen (mit $0 \leq k \leq n$) besteht;
   + alle Einsen überdeckt werden müssen;

4. werden die markierten Bereiche nach der Resolutionsregel zu Produkttermen zusammengefasst, die summiert werden.

<!-- data-type="none" style="table-layout: fixed; max-width:300px;"-->
|                              | $\overline{w}\,\overline{x}$ | $\overline{w}x$                     | $wx$ | $w\overline{x}$ |
| ---------------------------- | ---------------------------- | ----------------------------------- | ---- | --------------- |
| $\overline{y}\,\overline{z}$ | 0                            | <!-- style="background: red" --> 1 | 0    | 0               |
| $\overline{y} z$             | 0                            | <!-- style="background: red" -->1  | 0    | 0               |
| $y z$                        | 0                            | 0                                   | 0    | 0               |
| $y \overline{z}$             | 0                            | 0                                   | 0    | 0               |

Welcher Ausdruck steht hinter dem markierten Bereich?

$$
\begin{aligned}
f &=\overline{w}x\overline{y}\,\overline{z} +  \overline{w}x\overline{y} z \\
  &=\overline{w}x\overline{y} (\overline{z} +  z) \\
  &=\overline{w}x\overline{y} \cdot 1 \\
  &=\overline{w}x\overline{y} \\
\end{aligned}
$$


********************************************************************************

       {{3}}
********************************************************************************

Beispiel 1: $\overline{w}\,\overline{y}$

<!-- data-type="none" style="table-layout: fixed; max-width:300px;"-->
|                              | $\overline{w}\,\overline{x}$       | $\overline{w}x$                    | $wx$ | $w\overline{x}$ |
| ---------------------------- | ---------------------------------- | ---------------------------------- | ---- | --------------- |
| $\overline{y}\,\overline{z}$ | <!-- style="background: red" --> 1 | <!-- style="background: red" --> 1 | 0    | 0               |
| $\overline{y} z$             | <!-- style="background: red" --> 1 | <!-- style="background: red" --> 1 | 0    | 0               |
| $y z$                        | 0                                  | 0                                  | 1    | 0               |
| $y \overline{z}$             | 0                                  | 0                                  | 1    | 0               |


Beispiel 2: $wxy$

<!-- data-type="none" style="table-layout: fixed; max-width:300px;"-->
|                              | $\overline{w}\,\overline{x}$ | $\overline{w}x$ | $wx$                               | $w\overline{x}$ |
| ---------------------------- | ---------------------------- | --------------- | ---------------------------------- | --------------- |
| $\overline{y}\,\overline{z}$ | 1                            | 1               | 0                                  | 0               |
| $\overline{y} z$             | 1                            | 1               | 0                                  | 0               |
| $y z$                        | 0                            | 0               | <!-- style="background: red" --> 1 | 0               |
| $y \overline{z}$             | 0                            | 0               | <!-- style="background: red" --> 1 | 0               |

********************************************************************************

     {{4}}
********************************************************************************

Wählen Sie immer die größtmöglichen Schleifen und vermeiden Sie "Einzelelemente".

Falsch - $f =\overline{w}\,\overline{y} + \overline{w}xyz$

<!-- data-type="none" style="table-layout: fixed; max-width:300px;"-->
|                             | $\overline{w}\,\overline{x}$ | $\overline{w}x$ | $wx$ | $w\overline{x}$ |
| --------------------------- | --------------------------- | --------------- | ---- | --------------- |
| $\overline{y}\,\overline{z}$ | <span style="background-color: #ff0000">1</span>                           | <span style="background-color: #ff0000">1</span>                 | 0    | 0               |
| $\overline{y} z$            | <span style="background-color: #ff0000">1</span>                            | <span style="background-color: #ff0000">1</span>                 | 0    | 0               |
| $y z$                       | 0                           | <span style="background-color: #0000ff">1</span>                | 0    | 0               |
| $y \overline{z}$            | 0                           | 0               | 0    | 0               |

Richtig - $f = \overline{w}\,\overline{y} + \overline{w}xz$

<!-- data-type="none" style="table-layout: fixed; max-width:300px;"-->
|                             | $\overline{w}\,\overline{x}$ | $\overline{w}x$ | $wx$ | $w\overline{x}$ |
| --------------------------- | --------------------------- | --------------- | ---- | --------------- |
| $\overline{y}\,\overline{z}$ | <span style="background-color: #ff0000">1</span>                          | <span style="background-color: #ff0000">1</span>               | 0    | 0               |
| $\overline{y} z$            | <span style="background-color: #ff0000">1</span>                           |   <span style="background-color: #ff0000">1</span>   <span style="background-color: #00ff00">1</span>          | 0    | 0               |
| $y z$                       | 0                           | <span style="background-color: #00ff00">1</span>                |0    | 0               |
| $y \overline{z}$            | 0                           | 0               | 0    | 0               |

> Die Uni Marburg bietet eine gute Online Visualisierung des KV-Diagrammes an: https://www.mathematik.uni-marburg.de/~thormae/lectures/ti1/code/karnaughmap/

********************************************************************************

### Beispiele

     {{0-5}}
********************************************************************************

<!-- data-type="none" style="table-layout: fixed; max-width:300px;"-->
|                | $\overline{w}\,\overline{x}$ | $\overline{w}x$                    | $wx$ | $w\overline{x}$ |
| -------------- | ---------------------------- | ---------------------------------- | ---- | --------------- |
| $\overline{z}$ | 0                            | <!-- style="background: red" --> 1 | 0    | 0               |
| $z$            | 0                            | <!-- style="background: red" --> 1 | 0    | 0               |

********************************************************************************

     {{1-5}}
********************************************************************************

 $f = \overline{w}x$

<!-- data-type="none" style="table-layout: fixed; max-width:300px;"-->
|                | $\overline{w}\,\overline{x}$            | $\overline{w}x$                     | $wx$                                | $w\overline{x}$                    |
| -------------- | --------------------------------------- | ----------------------------------- | ----------------------------------- | ---------------------------------- |
| $\overline{z}$ | 0                                       | 0                                   | 0                                   | 0                                  |
| $z$            | <!-- style="background: red" --> 1 | <!-- style="background: red" -->  1 | <!-- style="background: red" -->  1 |  <!-- style="background: red" --> 1 |

********************************************************************************

     {{2-5}}
********************************************************************************

$f = z$

<!-- data-type="none" style="table-layout: fixed; max-width:300px;"-->
|                             | $\overline{w}\,\overline{x}$ | $\overline{w}x$                                  | $wx$                                             | $w\overline{x}$ |
| --------------------------- | --------------------------- | ------------------------------------------------ | ------------------------------------------------ | --------------- |
| $\overline{y}\,\overline{z}$ | 0                           | <!-- style="background: red" -->  1 | <!-- style="background: red" -->  1 | 0               |
| $\overline{y} z$            | 0                           | 0                                                | 0                                                | 0               |
| $y z$                       | 0                           | 0                                                | 0                                                | 0               |
| $y \overline{z}$            | 0                           | <!-- style="background: red" -->  1 | <!-- style="background: red" -->  1 | 0               |

********************************************************************************

     {{3-5}}
********************************************************************************

 $f = x\overline{z}$

<!-- data-type="none" style="table-layout: fixed; max-width:300px;"-->
|                             | $\overline{w}\,\overline{x}$                      | $\overline{w}x$ | $wx$ | $w\overline{x}$ |
| --------------------------- | ------------------------------------------------ | --------------- | ---- | --------------- |
| $\overline{y}\,\overline{z}$ | <!-- style="background: red" -->  1|    0             | 0    | <!-- style="background: red" -->  1              |
| $\overline{y} z$            | 0                                                | 0               | 0    | 0               |
| $y z$                       | 0                                                | 0               | 0    | 0               |
| $y \overline{z}$            | <!-- style="background: red" -->  1| 0               | 0    | <!-- style="background: red" -->  1             |


 ********************************************************************************

      {{4-5}}
 ********************************************************************************
 $f = \overline{x}\,\overline{z}$

<!-- data-type="none" style="table-layout: fixed; max-width:300px;"-->
|                              | $\overline{w}\,\overline{x}$ | $\overline{w}x$ | $wx$ | $w\overline{x}$ |
| ---------------------------- | ---------------------------- | --------------- | ---- | --------------- |
| $\overline{y}\,\overline{z}$ | 1                            | 0               | 0    | 1               |
| $\overline{y} z$             | 0                            | 1               | 1    | 1               |
| $y z$                        | 0                            | 0               | 0    | 1               |
| $y \overline{z}$             | 1                            | 0               | 0    | 1               |

> Hausaufgabe ...

********************************************************************************

        {{5}}
********************************************************************************

Und jetzt Sie!

<!-- data-type="none" style="table-layout: fixed; max-width:300px;"-->
| A   | B   | C   | Y   |
| --- | --- | --- | --- |
| 0   | 0   | 0   | 1   |
| 0   | 0   | 1   | 1   |
| 0   | 1   | 0   | 1   |
| 0   | 1   | 1   | 0   |
| 1   | 0   | 0   | 1   |
| 1   | 0   | 1   | 0   |
| 1   | 1   | 0   | 0   |
| 1   | 1   | 1   | 0   |

********************************************************************************

        {{6}}
********************************************************************************

<!-- data-type="none" style="table-layout: fixed; max-width:300px;"-->
|                | $\overline{A}\,\overline{B}$ | $\overline{A}B$ | $AB$ | $A\overline{B}$ |
| -------------- | ---------------------------- | --------------- | ---- | --------------- |
| $\overline{C}$ | 1                            | 1               | 0    | 1               |
| $C$            | 1                            | 0               | 0    | 0               |

$\overline{A}\,\overline{B} + \overline{A}\,\overline{C} + \overline{B}\,\overline{C}$

********************************************************************************

### Optimierungskriterien

<!-- data-type="none" style="table-layout: fixed; max-width:300px;"-->
|                              | $\overline{w}\,\overline{x}$ | $\overline{w}x$                     | $wx$                                | $w\overline{x}$ |
| ---------------------------- | ---------------------------- | ----------------------------------- | ----------------------------------- | --------------- |
| $\overline{y}\,\overline{z}$ | 1                            | 1                                   | 0                                   | 1               |
| $\overline{y} z$             | 0                            | <!-- style="background: red" -->  1 | <!-- style="background: red" -->  1 | 1               |
| $y z$                        | 0                            | <!-- style="background: red" -->  1 | <!-- style="background: red" -->  1 | 0               |
| $y \overline{z}$             | 0                            | 0                                   | 0                                   | 0               |

Welche Möglichkeiten haben wir ausgehend von der ersten Gruppe?

Variante 1: $\color{red} xz + \color{green}\overline{x}\,\overline{y}\,\overline{z} + \color{blue}\overline{w}x\overline{y} + \color{magenta}w\overline{x}\,\overline{y}$ (10 Operationen)

<!-- data-type="none" style="table-layout: fixed; max-width:300px;"-->
|                              | $\overline{w}\,\overline{x}$                     | $\overline{w}x$                                                                       | $wx$                                | $w\overline{x}$                                                                                     |
| ---------------------------- | ------------------------------------------------ | ------------------------------------------------------------------------------------- | ----------------------------------- | --------------------------------------------------------------------------------------------------- |
| $\overline{y}\,\overline{z}$ | <span style="background-color: #00ff00">1</span> | <span style="background-color: #0000ff">1</span>                                      | 0                                   | <span style="background-color: #00ff00">1</span>   <span style="background-color: #ff00ff">_</span> |
| $\overline{y} z$             | 0                                                | <!-- style="background: red" -->  1  <span style="background-color: #0000ff">_</span> | <!-- style="background: red" -->  1 | <span style="background-color: #ff00ff">1</span>                                                    |
| $y z$                        | 0                                                | <!-- style="background: red" -->  1                                                   | <!-- style="background: red" -->  1 | 0                                                                                                   |
| $y \overline{z}$             | 0                                                | 0                                                                                     | 0                                   | 0                                                                                                   |

Variante 2: $\color{red} xz + \color{green}\overline{x}\,\overline{y}\,\overline{z} + \color{blue}\overline{w}x\overline{y} + \color{magenta}w\overline{y}z$ (10 Operationen)

<!-- data-type="none" style="table-layout: fixed; max-width:300px;"-->
|                              | $\overline{w}\,\overline{x}$                     | $\overline{w}x$                                                                     | $wx$                                                                                 | $w\overline{x}$                                  |
| ---------------------------- | ------------------------------------------------ | ----------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------ | ------------------------------------------------ |
| $\overline{y}\,\overline{z}$ | <span style="background-color: #00ff00">1</span> | <span style="background-color: #0000ff">1</span>                                    | 0                                                                                    | <span style="background-color: #00ff00">1</span> |
| $\overline{y} z$             | 0                                                | <!-- style="background: red" -->  1<span style="background-color: #0000ff">_</span> | <!-- style="background: red" -->  1 <span style="background-color: #ff00ff">_</span> | <span style="background-color: #ff00ff">1</span> |
| $y z$                        | 0                                                | <!-- style="background: red" -->  1                                                 | <!-- style="background: red" -->  1                                                  | 0                                                |
| $y \overline{z}$             | 0                                                | 0                                                                                   | 0                                                                                    | 0                                                |

Variante 3: $\color{red} xz + \color{green}\overline{w}\,\overline{y}\,\overline{z} +  \color{magenta}w\overline{x}\,\overline{y}$ (7 Operationen)

<!-- data-type="none" style="table-layout: fixed; max-width:300px;"-->
|                              | $\overline{w}\,\overline{x}$                     | $\overline{w}x$                                  | $wx$                                | $w\overline{x}$                                  |
| ---------------------------- | ------------------------------------------------ | ------------------------------------------------ | ----------------------------------- | ------------------------------------------------ |
| $\overline{y}\,\overline{z}$ | <span style="background-color: #00ff00">1</span> | <span style="background-color: #00ff00">1</span> | 0                                   | <span style="background-color: #ff00ff">1</span> |
| $\overline{y} z$             | 0                                                | <!-- style="background: red" -->  1              | <!-- style="background: red" -->  1 | <span style="background-color: #ff00ff">1</span> |
| $y z$                        | 0                                                | <!-- style="background: red" -->  1              | <!-- style="background: red" -->  1 | 0                                                |
| $y \overline{z}$             | 0                                                | 0                                                | 0                                   | 0                                                |

> Überlappung lohnt sich nur, wenn dadurch größere Schleifen entstehen und zum Beispiel eine isolierte `1` vermieden wird.

### Karnaugh-Veitch für Maxterme

Das Karnaugh-Veitch-Diagramm lässt sich analog für Produkte von Summen aufstellen. Im Unterschied zur Minterm-Variante werden hier aber die Nullen erfasst - diese entsprechen ja auch den resultierenden Maxtermen.

Nehmen wir folgende Wahrheitstafel an:

<!-- data-type="none" style="table-layout: fixed; max-width:300px;"-->
| $w$ | $x$ | $y$ | $z$ | $A$ |
| --- | --- | --- | --- | --- |
| 0   | 0   | 0   | 0   | 1   |
| 0   | 0   | 0   | 1   | 0   |
| 0   | 0   | 1   | 0   | 1   |
| 0   | 0   | 1   | 1   | 0   |
| 0   | 1   | 0   | 0   | 0   |
| 0   | 1   | 0   | 1   | 1   |
| 0   | 1   | 1   | 0   | 0   |
| 0   | 1   | 1   | 1   | 1   |
| 1   | 0   | 0   | 0   | 1   |
| 1   | 0   | 0   | 1   | 1   |
| 1   | 0   | 1   | 0   | 0   |
| 1   | 0   | 1   | 1   | 0   |
| 1   | 1   | 0   | 0   | 0   |
| 1   | 1   | 0   | 1   | 1   |
| 1   | 1   | 1   | 0   | 0   |
| 1   | 1   | 1   | 1   | 1   |

8 Maxterme vs. 8 Minterme


<!-- data-type="none" style="table-layout: fixed; max-width:300px;"-->
|                              | $\overline{w}\,\overline{x}$                     | $\overline{w}x$                                  | $wx$                                             | $w\overline{x}$                                  |
| ---------------------------- | ------------------------------------------------ | ------------------------------------------------ | ------------------------------------------------ | ------------------------------------------------ |
| $\overline{y}\,\overline{z}$ | 1                                                | <span style="background-color: #00ff00">0</span> | <span style="background-color: #00ff00">0</span> | 1                                                |
| $\overline{y} z$             | <span style="background-color: #ff0000">0</span> | 1                                                | 1                                                | 1                                                |
| $y z$                        | <span style="background-color: #ff0000">0</span> | 1                                                | 1                                                | <span style="background-color: #0000ff">0</span> |
| $y \overline{z}$             | 1                                                | <span style="background-color: #00ff00">0</span> | <span style="background-color: #00ff00">0</span> | <span style="background-color: #0000ff">0</span> |


Ablesen der KNF:

- Zusammenfassung der Nullwerte (Summentermen) - $\overline{w}+\overline{x}+z, x+\overline{z}, w+\overline{x}+y$
- Invertieren der Eingangsvariablen - $w+x+\overline{z}, \overline{x}+z, \overline{w}+x+\overline{y}$
- Aufstellen der KNF - $A = (w+x+\overline{z}) \cdot (\overline{x}+z) \cdot (\overline{w}+x+\overline{y})$

> Da dies ein wenig durch die _Brust ins Auge_ gedacht ist, wird folgendes Vorgehen empfohlen, das die Negation der KDNF nutzt:

- Zusammenfassen der Nullwerte als negierte DNF - $\overline{A}_{DNF} = \overline{w}\,\overline{x}z + x\overline{z} +  w\overline{x}y$
- Anwendung des de-morganschen Gesetzes - $A_{DNF} = \overline{ \overline{w}\,\overline{x}\,z +  x\overline{z} +  w\overline{x}y} = (w+x+\overline{z})(\overline{x} + z)(\overline{w}+x+\overline{y})$

> **Aufgabe:** Weisen Sie die Äquivalenz der Gleichungen für die KNF $A_{KNF} = (w+x+\overline{z})(\overline{x} + z)(\overline{w}+x+\overline{y})$  und die DNF $A_{DNF} = \overline{w}\,\overline{x}\,\overline{z}+xz+w\overline{x}\overline{y}$ nach.

## Dont-Care-Einträge in der Wahrheitstafel

                               {{0-2}}
********************************************************************************

In einigen Fällen bildet die Wahrheitstafel Kombinationen der Eingangswerte ab,
die für die Ausgabe gar nicht relevant sind. In diesem Fall spricht man von sogenannten `don't care` Ausgaben. Letztendlich ist uns das Funktionsergebnis für diese Fälle egal. Aus den `don't care` Fällen können entsprechend weitere Minimierungen hergeleitet werden.

Ein sehr anschauliches Anwendungsbeispiel dafür sind Sieben-Segment-Anzeigen,
die aus 7 + 1 (Punkt) Leds bestehen und insbesondere zur Darstellung von Zahlenwerten genutzt werden.

https://cdn-reichelt.de/documents/datenblatt/A500/SA52-11%23KIN.pdf

Acht Eingänge pro Element würde die Zahl der verfügbaren Pins eines Controllers recht schnell aufbrauchen und ist auch nicht nötig. Wir wollen ja nur maximal die Zahlen von 0-9 darstellen. Diese können wir als 10 Zustände mit ... Leitungen abbilden

Folglich ergeben sich 6 Eingangskombinationen, die für unsere Ausgabe irrelevant sind.

![Bild](./images/04_Schaltnetze/bcd_animation.gif)<!-- width="50%" -->

********************************************************************************

                               {{1-3}}
********************************************************************************

Betrachten wir die Wahrheitstafel für das "d" Element.

<!-- data-type="none" style="table-layout: fixed; max-width:300px;"-->
| $w$ | $x$ | $y$ | $z$ | $d$                                   |
| --- | --- | --- | --- | ------------------------------------- |
| 0   | 0   | 0   | 0   | 1                                     |
| 0   | 0   | 0   | 1   | 0                                     |
| 0   | 0   | 1   | 0   | 1                                     |
| 0   | 0   | 1   | 1   | 1                                     |
| 0   | 1   | 0   | 0   | 0                                     |
| 0   | 1   | 0   | 1   | 1                                     |
| 0   | 1   | 1   | 0   | 1                                     |
| 0   | 1   | 1   | 1   | 0                                     |
| 1   | 0   | 0   | 0   | 1                                     |
| 1   | 0   | 0   | 1   | 1                                     |
| 1   | 0   | 1   | 0   | <span style="color: #ff0000">D</span> |
| 1   | 0   | 1   | 1   | <span style="color: #ff0000">D</span> |
| 1   | 1   | 0   | 0   | <span style="color: #ff0000">D</span> |
| 1   | 1   | 0   | 1   | <span style="color: #ff0000">D</span> |
| 1   | 1   | 1   | 0   | <span style="color: #ff0000">D</span> |
| 1   | 1   | 1   | 1   | <span style="color: #ff0000">D</span> |

********************************************************************************

                               {{2-6}}
********************************************************************************

<!-- data-type="none" style="table-layout: fixed; max-width:300px;"-->
|                              | $\overline{w}\,\overline{x}$ | $\overline{w}x$ | $wx$ | $w\overline{x}$ |
| ---------------------------- | ---------------------------- | --------------- | ---- | --------------- |
| $\overline{y}\,\overline{z}$ | 1                            | 0               | D    | 1               |
| $\overline{y} z$             | 0                            | 1               | D    | 1               |
| $y z$                        | 1                            | 0               | D    | D               |
| $y \overline{z}$             | 1                            | 1               | D    | D               |

Welche Gleichung für `d` lesen Sie daraus ab?

********************************************************************************

                               {{3-6}}
********************************************************************************

$d = w + y\overline{z} + \overline{x}y +  x\overline{y}z + \overline{x}\,\overline{z}$

********************************************************************************

                                {{5-6}}
********************************************************************************

Die Korrektheit unserer Lösung können Sie in einer Simulationsumgebung evaluieren.

https://goldi-labs.net/BEAST.php#

![7 Segementanzeige](./images/03_Minimierung/7_segement_Anzeige.png)

Die gezeigte Lösung findet sich im Projektrepository.

********************************************************************************

## Zusammenfassung

Regeln zur Bildung der Schleifen:

+ Fangen Sie mit isolierten Zellen an. Die entsprechenden Minterme können nicht mehr vereinfacht werden.
+ Falls keine isolierten Zellen existieren, fange bei denen mit den wenigsten gleichwertigen Nachbarzellen an.
+ Suche die Schleifen mit der größten Überdeckung von Zellen. Die Schleifen umfassen jeweils $2^n$ mit $(n= 0,1,2,...)$ benachbarte Zellen. Starten Sie mit den kleinsten Schleifen.
+ Überlappungen führen nur dann zu minimaleren Ausdrücken, wenn dadurch größere Schleifen gebildet werden können.
+ Die minimale Funktion besteht aus der kleinsten Schleifenmenge, die alle individuell möglichst groß sind.


**Und wie geht es weiter?**

Wir brauchen offensichtlich eine Möglichkeit, die Minimierung automatisiert durchzuführen. Hierzu gibt es verschiedene Methoden, die wir in den nächsten Kapiteln kennenlernen werden.

```python Minimize.py
from sympy.logic import SOPform
from sympy import symbols
x3, x2, x1, x0 = symbols('x3 x2 x1 x0')

minterms = [[0, 1, 1, 0],
[0, 1, 1, 1],
[1, 0, 0, 0],
[1, 0, 0, 1],
[1, 0, 1, 0],
[1, 0, 1, 1],
[1, 1, 0, 0],
[1, 1, 0, 1],
[1, 1, 1, 0]]
result = SOPform([x3, x2, x1, x0], minterms)
print("Minimized result:")
print(result)
```
@LIA.eval(`["main.py"]`, `none`, `python3 main.py`)

Die Dokumentation zum Sympy Paket von Python finden Sie unter https://docs.sympy.org/latest/modules/logic.html 

## Hausaufgaben

+ Lösen Sie das Minimierungsproblem der Einstiegsaufgabe mit dem Karnaugh-Veitch-Diagramm.
+ Stellen Sie die Wahrheitstafel für ein weiteres Element der Sieben-Segmentanzeige auf. Minimieren Sie den Ausdruck.
+ Erstellen Sie mit dem Python-Beispiel eine eigene (willkürliche) Wahrheitstafel und vereinfachen Sie diese mit dem Karnaugh-Veitch-Diagramm und auf analytischem Wege.

> Für das Training oder die Probe bei der Erledigung der Hausaufgaben können Sie die Werkzeuge der TU Ilmenau verwenden, die die besprochenen Inhalte wunderbar zusammenfasst.
>
> https://www.goldi-labs.de/SANE/view3
>
> ![SANE](./images/03_Minimierung/SANE.png)

