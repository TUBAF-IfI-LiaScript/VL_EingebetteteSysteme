<!--

author:   Sebastian Zug & André Dietrich & Fabian Bär
email:    sebastian.zug@informatik.tu-freiberg.de & andre.dietrich@informatik.tu-freiberg.de & fabian.baer@student.tu-freiberg.de
version:  0.0.4
language: de
narrator: Deutsch Female

import:  https://raw.githubusercontent.com/liascript-templates/plantUML/master/README.md
         https://raw.githubusercontent.com/LiaTemplates/DigiSim/master/README.md

-->

# 06 - Schaltwerke

**TU Bergakademie Freiberg - Wintersemester 2020 / 21**

Link auf die aktuelle Vorlesung im Versionsmanagementsystem GitHub

[https://github.com/TUBAF-IfI-LiaScript/VL_EingebetteteSysteme/blob/00_Einfuehrung](https://github.com/TUBAF-IfI-LiaScript/VL_EingebetteteSysteme/blob/dev/00_Einfuehrung)

Die interaktive Form ist unter diese Link zu finden ->
[TODO]( )

---------------------------------------------------------------------

** Fragen an die Veranstaltung**

+


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


### Wiederholung: Beschreibung von Flip-Flops

__Wahrheitstafel__ zeigt die Eingaben, die notwendig sind, um eine bestimmte Zustandsänderung herbeizuführen.

| $R(t)$ | $S(t)$ | $Q(t+1)$      |
| ------ | ------ | ------------- |
| 0      | 0      | $Q$           |
| 0      | 1      | 1             |
| 1      | 0      | 0             |
| 1      | 1      | nicht erlaubt |

__Invertierte Wahrheitstafel__ zeigt die Eingaben, die notwendig sind, um eine bestimmte Zustandsänderung herbeizuführen.

| $Q(t)$ | $Q(t+1)$ | $S$ | $R$ |
| ------ | -------- | --- | --- |
| 0      | 0        | 0   | d   |
| 0      | 1        | 1   | 0   |
| 1      | 0        | 0   | 1   |
| 1      | 1        | d   | 0   |

> Merke: Die invertierte Wahrheitstafel beantwortet die Frage, wie die Eingänge beschaltet werden müssen, um einen bestimmten Zustand zu realsieren.

Stellen Sie die invertierten Wahrheitstafeln für den JK und den D Flip-Flop auf!

## Motivation

Wie fügen


### Grundkonzept

Wie kann man systematisch ein synchrones Schaltwerk ausgehend von
der Problembeschreibung entwerfen ?

Automat ist gekennzeichnet durch:

+ beliebige (jedoch endliche) Menge von Zuständen
+ Zustandsübergänge in jedem Takt abhängig von Eingangssignalen
+ Ausgangssignale werden durch ein Schaltnetz generiert

Mathematisch kann ein Deterministischer Endlicher Automat als Tupel $A = (Q, \Sigma, \delta, q_0, F)$

+ Q ist eine endliche Zustandsmenge.
+ $\Sigma$ ist das endliche Eingabealphabet, also die Menge erlaubter Eingabesymbole.
+ $\delta : Q \times \Sigma \rightarrow Q $ ist die Übergangsfunktion (oder Transitionsfunktion). Sie ordnet jedem Paar bestehend aus einem Zustand $q\in Q$ und einem Eingabesymbol $a\in \Sigma$ einen Nachfolgezustand $p\in Q$ zu.
+ $q\in Q$ ist der Startzustand (auch Anfangszustand oder Initalzustand).
+ $F\subseteq Q$ ist die Menge der akzeptierenden Zustände, die sogenannten Finalzustände (oder Endzustände).

Beispiele:

__Zustand einer Tür__

Darstellung als Graph

```text @plantUML
@startuml
digraph finite_state_machine {
    rankdir=LR;

    node [shape = point ]; qi
    node[shape=circle]
    A[label="{auf}"];
    B[label="{zu}"];

    qi -> A;
    A  -> A  [ label = "schließen" ];
    A  -> B  [ label = "öffnen" ];
    B  -> B  [ label = "öffnen" ];
    B  -> A  [ label = "schließen" ];
}
@enduml
```
@plantUML


Darstellung in einer Übergangstabelle

|                     | "Öffnen"            | "Schließen"               |
| ------------------- | ------------------- | ------------------------- |
| Zustand offen       | offen (unverändert) | geschlossen               |
| Zustand geschlossen | offen               | geschlossen (unverändert) |

__Codeschloss für die Erfassung der Sequenzfolge `7022`__


```text @plantUML
@startuml
digraph finite_state_machine {
    node [shape = point ]; qi
    node[shape=Mrecord]
    A[label="{A|geschlossen}"];
    B[label="{B|geschlossen}"];
    C[label="{C|geschlossen}"];
    D[label="{D|geschlossen}"];
    E[label="{E|geöffnet}"];

    qi -> A;
    A  -> A  [ label = "E != 7" ];
    A  -> B  [ label = "E == 7" ];
    B  -> B  [ label = "E != 0" ];
    B  -> C  [ label = "E == 0" ];
    C  -> D  [ label = "E == 2" ];
    C  -> A  [ label = "E != 2" ];
    D  -> E  [ label = "E == 2" ];
    D  -> A  [ label = "E != 2" ];
    E  -> A  [ label = "" ];
}
@enduml
```
@plantUML

Welche Beschränkungen sehen Sie in diesem Entwurf? Was passiert bei der Sequenzfolge `707022`?

Unterschiedliche Formate!!!


## Entwurfsprozess

Binärsequenzdetektor der drei aufeinander folgende `1` erkennt. Dabei gehen wir davon aus, dass die Übernahme der Werte mit den steigenden Flanken des Taktsignales erfolgt.

<!--
style="width: 80%; min-width: 420px; max-width: 720px;"
-->
```ascii
      |   +---+   +---+   +---+   +---+   +---+   +---+   +---+   +---+   +---+
Takt  |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |
      |---+   +---+   +---+   +---+   +---+   +---+   +---+   +---+   +---+   +
      |
      | +------+        +------+        +-------------------------------+
E     | | 1    | 0      | 1    |  0     | 1       1       1       1     | 0
      |-+      +--------+      +--------+                               +-------
      |
      |                                                 +---------------+
A     |                                                 | 1       1     | 0
      |-------------------------------------------------+               +-------
      +-------------------------------------------------------------------------->
```


```text @plantUML
@startuml
digraph finite_state_machine {
    rankdir=LR;

    node [shape = point ]; qi
    node[shape=circle]
    A[label="A"];
    B[label="B"];
    C[label="C"];
    D[label="D"];

    qi -> A;
    A  -> A  [ label = "E=0 \n A=0" ];
    A  -> B  [ label = "E=1 \n A=0" ];
    B  -> A  [ label = "E=0 \n A=0" ];
    B  -> C  [ label = "E=1 \n A=0" ];
    C  -> A  [ label = "E=0 \n A=0" ];
    C  -> D  [ label = "E=1 \n A=1", fontcolor=blue ];
    D  -> D  [ label = "E=1 \n A=1", fontcolor=blue ];
    D  -> A  [ label = "E=0 \n A=0" ];
}
@enduml
```
@plantUML

Zustandsübergänge

| aktueller Zustand | Eingabe E | neuer Zustand |
| ----------------- | --------- | ------------- |
| A                 | 0         | A             |
| B                 | 0         | A             |
| C                 | 0         | A             |
| D                 | 0         | A             |
| A                 | 1         | B             |
| B                 | 1         | C             |
| C                 | 1         | D             |
| D                 | 1         | D             |


Kodierung

Für unsere digitalen Bauteile müssen wir die Zustände aber mit `1` und `0` kodieren.

| Zustände | Flip-Flops | Mögliche Zustände |
| -------- | ---------- | ----------------- |
| 1        | 1          | 2                 |
| 2        | 1          | 2                 |
| 3        | 2          | 4                 |
| 4        | 2          | 4                 |
| 5        | 3          | 8                 |
| ...      |            |                   |
| 8        | 3          | 8                 |
| 9        | 4          | 16                |
| ...      |            |                   |

Da wir insgesamt 4 Zustände haben braucht es $\lceil log_2(4)\rceil = 2$ Speicherelemente, also Flip-Flops.
Die zwei Flip-Flops werden im folgenden als `F` und `G` bezeichnet. Die Ausgabe bezeichnen wir mit `X`.

Mit unserem Schaltwerk wollen wir also eine Funktion abbilden, die die Ausgabe `X` in Abhängigkeit von (historischen) `E` Eingaben generiert. Um letztgenannten Anteil zu integrieren, braucht es die Zustände die in `F` und `G` erfasst sind.

| Zustand | Flip-Flop F | Flip-Flop G |
| ------- | ----------- | ----------- |
| A       | 0           | 0           |
| B       | 0           | 1           |
| C       | 1           | 0           |
| D       | 1           | 1           |

Damit ergibt sich dann eine neue Zustandstabelle

<table><tr>
<td>
Zustandstabelle

| Zustand | F   | G   | E   | Zustand' | F'  | G'  |
| ------- | --- | --- | --- | -------- | --- | --- |
| A       | 0   | 0   | 0   | A        | 0   | 0   |
| B       | 0   | 1   | 0   | A        | 0   | 0   |
| C       | 1   | 0   | 0   | A        | 0   | 0   |
| D       | 1   | 1   | 0   | A        | 0   | 0   |
| A       | 0   | 0   | 1   | B        | 0   | 1   |
| B       | 0   | 1   | 1   | C        | 1   | 0   |
| C       | 1   | 0   | 1   | D        | 1   | 1   |
| D       | 1   | 1   | 1   | D        | 1   | 1   |
</td>
<td>
Ausgaben

| F   | G   | E   | A   |
| --- | --- | --- | --- |
| 0   | 0   | 0   | 0   |
| 0   | 1   | 0   | 0   |
| 1   | 0   | 0   | 0   |
| 1   | 1   | 0   | 0   |
| 0   | 0   | 1   | 0   |
| 0   | 1   | 1   | 0   |
| 1   | 0   | 1   | 1   |
| 1   | 1   | 1   | 1   |
</td>
</tr></table>

Realisierung der Schaltfunktion

![Bild](./images/06_Schaltwerke/Schaltwerk_Detektor.png)

Um die entsprechende Schaltfunktionen für die Änderung der Zustände und die Ausgabe aufzustellen, brauchen wir die invertierte Wahrheitstafel des intendierten Flip-Flops.

> __Merke:__  Unterschiedliche Flip-Flops für die Speicherung der Zustände führen zu  unterschiedlichen Beschaltungen!

<table><tr>
<td>
Zustandstabelle

| F   | G   | E   | F'                                    | G'                                    |
| --- | --- | --- | ------------------------------------- | ------------------------------------- |
| 0   | 0   | 0   | 0                                     | 0                                     |
| 0   | 1   | 0   | 0                                     | 0                                     |
| 1   | 0   | 0   | 0                                     | 0                                     |
| 1   | 1   | 0   | 0                                     | 0                                     |
| 0   | 0   | 1   | 0                                     | <span style="color: #ff0000">1</span> |
| 0   | 1   | 1   | <span style="color: #ff0000">1</span> | 0                                     |
| 1   | 0   | 1   | <span style="color: #ff0000">1</span> | <span style="color: #ff0000">1</span> |
| 1   | 1   | 1   | <span style="color: #ff0000">1</span> | <span style="color: #ff0000">1</span> |

</td>
<td>
Ausgaben

| F   | G   | E   | A   |
| --- | --- | --- | --- |
| 0   | 0   | 0   | 0   |
| 0   | 1   | 0   | 0   |
| 1   | 0   | 0   | 0   |
| 1   | 1   | 0   | 0   |
| 0   | 0   | 1   | 0   |
| 0   | 1   | 1   | 0   |
| 1   | 0   | 1   | <span style="color: #ff0000">1</span>   |
| 1   | 1   | 1   | <span style="color: #ff0000">1</span>   |
</td>
</tr>
<tr>
<td>
$$
\begin{aligned}
F` &= \overline{F}GE + F\overline{G}E + FGE  \\
   &= GE + FE \\
G` &= \overline{F}\overline{G}E + F\overline{G}E + FGE  \\
   &= \overline{G}E + FE
\end{aligned}
$$
</td>
<td>
$$
\begin{aligned}
A = F\overline{G}E + FGE = FE
\end{aligned}
$$
</td>
</tr>
</table>

!!! Evaluation im Simulator

## Allgemeines Vorgehen

1. Schritt: Spezifikation des Zustandsdiagramms
2. Schritt: Transformation in eine Zustandstabelle
3. Schritt: Zuordnung von Zuständen zu Flip-Flop Belegungen (Assignment)
4. Schritt: Erstellung der Wahrheitstafel für Zustände und Ausgaben
5. Schritt: Ableitung einer KNF oder DNF
6. Schritt: Minimierung

## Automaten Typen

**Mealy-Automat**

George H. Mealy (1927 – 2010, IBM)

<!--
style="width: 80%; min-width: 420px; max-width: 720px;"
-->
```ascii
  +------------------------------------------+
  |   +--------------+     +--------------+  |
  +-->|              |     |              |  |   +--------------+
      | Eingabelogik |---->| Speicher     |--+-->|              |    Y
---+->| (Schaltnetz) |     | (Flip-Flops) |      | Ausgabelogik |---->
 E |  +--------------+     +--------------+      | (Schaltnetz) |
   +-------------------------------------------->|              |
                                                 +--------------+

                                                                               .
```



```text @plantUML
@startuml
digraph finite_state_machine {
    rankdir=LR;

    node [shape = point ]; qi
    node[shape=circle]
    A[label="A"];
    B[label="B"];
    C[label="C"];
    D[label="D"];

    qi -> A;
    A  -> A  [ label = "E=0 \n A=0" ];
    A  -> B  [ label = "E=1 \n A=0" ];
    B  -> A  [ label = "E=0 \n A=0" ];
    B  -> C  [ label = "E=1 \n A=0" ];
    C  -> A  [ label = "E=0 \n A=0" ];
    C  -> D  [ label = "E=1 \n A=1", fontcolor=blue ];
    D  -> D  [ label = "E=1 \n A=1", fontcolor=blue ];
    D  -> A  [ label = "E=0 \n A=0" ];
}
@enduml
```
@plantUML

**Die Ausgabe Y hängt jedoch die Ausgabelogik vom aktuellen Zustand und vom Eingabesignal E ab**


**Moor-Automat**

Edward Forrest Moore (1925 – 2003, Bell Labs)

<!--
style="width: 80%; min-width: 420px; max-width: 720px;"
-->
```ascii
  +------------------------------------------+
  |   +--------------+     +--------------+  |   +--------------+
  +-->|              |     |              |  |   |              |   Y
      | Eingabelogik |---->| Speicher     |--+-->| Ausgabelogik |---->
----->| (Schaltnetz) |     | (Flip-Flops) |      | (Schaltnetz) |
 E    +--------------+     +--------------+      +--------------+
                                                                               .
```

```text @plantUML
@startuml
digraph finite_state_machine {
    rankdir=LR;

    node [shape = point ]; qi
    node[shape=circle]
    A[label="A, 0"];
    B[label="B, 0"];
    C[label="C, 0"];
    D[label="D, 1"];

    qi -> A;
    A  -> A  [ label = "E=0" ];
    A  -> B  [ label = "E=1" ];
    B  -> A  [ label = "E=0" ];
    B  -> C  [ label = "E=1" ];
    C  -> A  [ label = "E=0" ];
    C  -> D  [ label = "E=1"];
    D  -> D  [ label = "E=1"];
    D  -> A  [ label = "E=0" ];
}
@enduml
```
@plantUML

**Die Ausgabelogik bestimmt Ausgabe Y hängt nur vom aktuellen Zustand ab.**

Der Mealy-Automat ist die generellere Form. Der Moore-Automat unterbindet den Einfluss des Einganges. Eine weitere Spezialisierung ist der sogenannte Medwedew-Automat, bei dem ganz auf die Ausgabelogik verzichtet wird.



|          | Mealy-Automat                                            | Moore-Automat                                                                                           |
| -------- | -------------------------------------------------------- | ------------------------------------------------------------------------------------------------------- |
| Vorteile | schnellere Reaktion auf Veränderung der Eingabesignale E | taktsynchrone Ausgabe A, asynchron auftretende Störungen der Eingabesignale wirken sich nicht auf A aus |
|          | Realisierung ist mit einer kleineren Anzahl an Zuständen möglich, wenn mehrere Zustandsübergänge zu einem Zustand verschiedene Ausgaben erfordern                                                          |  geringerer Schaltungsaufwand für Ausgabelogik, wenn Ausgabe A eigentlich nur vom Zustand abhängt                                                                                                       |


## Übungsaufgaben

+ Recherchieren Sie die Einsatzmöglichkeiten des Medwedew-Automaten. In welchem Rahmen macht dessen Beschränkung Sinn?
+
