<!--

author:   Sebastian Zug & André Dietrich & Fabian Bär
email:    sebastian.zug@informatik.tu-freiberg.de & andre.dietrich@informatik.tu-freiberg.de & fabian.baer@student.tu-freiberg.de
version:  0.0.1
language: de
narrator: Deutsch Female

import: https://raw.githubusercontent.com/LiaTemplates/NetSwarm-Simulator/master/README.md

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
[[ ]] 16
[[?]] Überlegen Sie, wie viele Kombinationen die Ausgangswerte $y$ abbilden können

## Schaltnetze

> __Merke:__
>
> + Jedes Schaltnetz kann nur mit UND-, ODER- und NICHT-Gattern aufgebaut werden.
>
> + Jedes Schaltnetz kann nur mit NAND Gattern aufgebaut werden.
>
> + Jedes Schaltnetz kann nur mit NOR Gattern aufgebaut werden.

**n-zu-k Dekodierer**

3-8 Dekodierer


**n-zu-k Kodierer**

8-3 Dekodierer


**Multiplexer**




**Demultiplexer**
