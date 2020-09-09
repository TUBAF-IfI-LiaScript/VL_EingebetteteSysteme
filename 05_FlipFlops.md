<!--

author:   Sebastian Zug & André Dietrich & Fabian Bär
email:    sebastian.zug@informatik.tu-freiberg.de & andre.dietrich@informatik.tu-freiberg.de & fabian.baer@student.tu-freiberg.de
version:  0.0.4
language: de
narrator: Deutsch Female

import: https://raw.githubusercontent.com/LiaTemplates/NetSwarm-Simulator/master/README.md
import:   https://raw.githubusercontent.com/LiaTemplates/DigiSim/master/README.md

-->

# 05 - FlipFlops

**TU Bergakademie Freiberg - Wintersemester 2020 / 21**

Link auf die aktuelle Vorlesung im Versionsmanagementsystem GitHub

[https://github.com/TUBAF-IfI-LiaScript/VL_EingebetteteSysteme/blob/00_Einfuehrung](https://github.com/TUBAF-IfI-LiaScript/VL_EingebetteteSysteme/blob/dev/00_Einfuehrung)

Die interaktive Form ist unter diese Link zu finden ->
[TODO]( )

---------------------------------------------------------------------

** Fragen an die Veranstaltung**

+ Erläutern Sie die Notwendigkeit von Speicherelementen für die Umsetzung eines Rechners?
+ Worin besteht der Unterschied zwischen Schaltfunktionen/Schaltnetzen und Schaltwerken?
+ Beschreiben Sie die Eingangsbelegungen und korrespondierenden Zustandsänderungen am RS-Flip-Flop.
+ Welche anderen Flip-Flop-Typen kennen sie, vor liegen die Vorteile gegenüber dem RS-Flip-Flop?
+ Erläutern Sie die Begriffe „zustandsgesteuert“ und „flankengesteuert“.
+ Welche Kernelemente hat ein Schaltwerk? Worin unterscheiden sich die Varianten von Mealy und Moore?
+ Welches Vorgehen ist für die Umsetzung eines Schaltwerkes notwendig?
+ An welcher Stelle ist die invertierte Wahrheitstabelle eines Flip-Flops wichtig?

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

## Einführung sequenzieller Logik

Kombinatorische Logik wird durch Schaltnetze repräsentiert, die durch zyklenfreie Graphen dargestellt werden können, sprich es gibt keine Eigenschaften:

1. Zustandslos: Ausgabe ist nur von der Eingabe abhängig;
2. One-Way: keine Rückkopplungen im Schaltnetz;
3. 0-Verzögerung: keine Berücksichtigung der Gatterlaufzeit.

Frage: Können wir die bisherigen Konzepte und Techniken der logischen Schaltungen einsetzen, um wesentliche Elemente eines Rechners zu beschreiben wie z.B. :
+ Ablaufsteuerungen
+ Speicherelemente
+ Takterzeuger

> Merke: Es fehlt ein Speicher!

Was geschieht in einer digitalen Schaltung bei der Rückkopplung eines Gatterausganges ?

### Erster Ansatz

__Verwendung eines rückgekoppelten AND-Bausteins.__

![Bild](./images/05_FlipFlops/UND_gate_feedback.png)

| $A(t)$ | $Y(t)$ | $Y(t+\Delta t)$ | $Y(t+2\Delta t)$ | $Y(t+3\Delta t)$ |
| ------ | ------ | --------------- | ---------------- | ---------------- |
| 1      | 1      | 1               | 1                | 1                |
| 0      | 1      | 0               | 0                | 0                |
| 1      | 0      | 0               | 0                | 0                |
| 0      | 0      | 0               | 0                | 0                |

| $A(t)$ | $Y(t+\Delta t)$ | $Y(t+2\Delta t)$ | $Y(t+3\Delta t)$ |
| ------ | --------------- | ---------------- | ---------------- |
| 1      | $Y(t)$          | $Y(t)$           | $Y(t)$           |
| 0      | 0               | 0                | 0                |

Offenbar behalten wir bei der Eingabe von 1 den aktuellen Zustand bei. Aus der Eingabe einer 0 folgt das "Löschen" des Zustandes.

### Zweiter Ansatz

__Verwendung eines rückgekoppelten OR-Bausteins.__

![Bild](./images/05_FlipFlops/OR_gate_feedback.png)

| $A(t)$ | $Y(t)$ | $Y(t+\Delta t)$ | $Y(t+2\Delta t)$ | $Y(t+3\Delta t)$ |
| ------ | ------ | --------------- | ---------------- | ---------------- |
| 1      | 1      | 1               | 1                | 1                |
| 0      | 1      | 1               | 1                | 1                |
| 1      | 0      | 1               | 1                | 1                |
| 0      | 0      | 0               | 0                | 0                |

| $A(t)$ | $Y(t+\Delta t)$ | $Y(t+2\Delta t)$ | $Y(t+3\Delta t)$ |
| ------ | --------------- | ---------------- | ---------------- |
| 1      | 1               | 1                | 1                |
| 0      | $Y(t)$          | $Y(t)$           | $Y(t)$           |

...

``` json @DigiSim.evalJson
{"devices":{"a":{"label":"A","type":"Button","propagation":0,"position":{"x":-85,"y":55}},"y":{"label":"Y","type":"Lamp","propagation":0,"position":{"x":275,"y":60}},"or":{"label":"or","type":"Or","propagation":0,"bits":1,"position":{"x":85,"y":70}}},"connectors":[{"from":{"id":"or","port":"out"},"to":{"id":"y","port":"in"}},{"from":{"id":"a","port":"out"},"to":{"id":"or","port":"in2"}},{"from":{"id":"or","port":"out"},"to":{"id":"or","port":"in1"},"vertices":[{"x":40,"y":50}]}],"subcircuits":{}}
```

### Dritter Ansatz (SR-Latch)
__Gesteuerte Rückkopplung über OR-Baustein.__

Wir fügen eine weitere Eingangsgröße hinzu, die die Logik des Speichers auf der Basis des rückgekoppelten OR vervollständigt. Durch die Einbettung des AND Gatters können wir die Rückkopplung kontrollieren! Die Rückkopplung einer 1 erfolgt nur dann, wenn unser `R` Eingang nicht selbst eine 1 abbildet. Sobald wir an S eine 1 anlegen, wird diese auf Y sichtbar und gespeichert.

![Bild](./images/05_FlipFlops/rs_latch.png)

| $R(t)$ | $S(t)$ | $Y(t)$ | $Y(t+2\Delta t)$ | Bedeutung      |
| ------ | ------ | ------ | ---------------- | -------------- |
| 0      | 0      | 0      | 0                | Speichern$^*$  |
| 0      | 0      | 1      | 1                | Speichern$^*$  |
| 0      | 1      | 0      | 1                | Setzen         |
| 0      | 1      | 1      | 1                | Setzen$^*$     |
| 1      | 0      | 0      | 0                | Rücksetzen$^*$ |
| 1      | 0      | 1      | 0                | Rücksetzen     |
| 1      | 1      | 0      | 0                | Vermeiden$^*$  |
| 1      | 1      | 1      | 0                | Vermeiden      |

Die mit * markierten Einträge sind jeweils flüchtig. Sie werden im nächsten Zyklus durch den Zustand ohne Stern gleicher Kategorie überschrieben.

``` json @DigiSim.evalJson
{"devices":{"s":{"label":"S","type":"Button","propagation":0,"position":{"x":0,"y":0}},"r":{"label":"R","type":"Button","propagation":0,"position":{"x":0,"y":55}},"y":{"label":"Y","type":"Lamp","propagation":0,"position":{"x":430,"y":25}},"or":{"label":"or","type":"Or","propagation":0,"bits":1,"position":{"x":135,"y":-45}},"and":{"label":"and","type":"And","propagation":0,"bits":1,"position":{"x":255,"y":-10}},"not":{"label":"not","type":"Not","propagation":0,"bits":1,"position":{"x":130,"y":50}}},"connectors":[{"from":{"id":"r","port":"out"},"to":{"id":"not","port":"in"}},{"from":{"id":"not","port":"out"},"to":{"id":"and","port":"in2"}},{"from":{"id":"s","port":"out"},"to":{"id":"or","port":"in2"}},{"from":{"id":"or","port":"out"},"to":{"id":"and","port":"in1"}},{"from":{"id":"and","port":"out"},"to":{"id":"or","port":"in1"},"vertices":[{"x":270,"y":-75}]},{"from":{"id":"and","port":"out"},"to":{"id":"y","port":"in"}}],"subcircuits":{}}
```


Daraus folgt die Wertetabelle eines RS-Flip-Flops. Anhand dieser Darstellung wird klar, dass die Eingangsgrößen $R$ und $S$ ihre Kürzel aus gutem Grund tragen `Reset` und `Set`.

| $R(t)$ | $S(t)$ | $Y'(t) = Y(t+2\Delta t)$ |
| ------ | ------ | ------------------------ |
| 0      | 0      | $Y(t)$                   |
| 0      | 1      | 1                        |
| 1      | 0      | 0                        |
| 1      | 1      | nicht erlaubt            |

Nun können wir mit dem Theorem von de Morgan einige Anpassungen vornehmen:

$$\begin{aligned} Y' &= (Y + S) \cdot \overline{R} \\
                     &= \overline{\overline{Y+S} + R}
\end{aligned}$$

Damit sind wir in der Lage unseren bistabilen Speicher mit zwei Gattern gleichen Typs zu realisieren.

![Bild](./images/05_FlipFlops/asynchronous_latch.png)

Die Darstellung des Flip-Flops kann auch mit Hilfe von NAND Bausteinen erfolgen. Beachten Sie dabei die entsprechend Anpassung der Einganggrößen.

![Bild](./images/05_FlipFlops/RS_with_NOR_and_NAND.png)

``` json @DigiSim.evalJson
{"devices":{"s":{"label":"S","type":"Button","propagation":0,"position":{"x":0,"y":0}},"r":{"label":"R","type":"Button","propagation":0,"position":{"x":0,"y":95}},"nots":{"label":"~S","type":"Button","propagation":0,"position":{"x":0,"y":180}},"notr":{"label":"~R","type":"Button","propagation":0,"position":{"x":0,"y":285}},"q1":{"label":"Q","type":"Lamp","propagation":0,"position":{"x":365,"y":85}},"notq1":{"label":"~Q","type":"Lamp","propagation":0,"position":{"x":370,"y":10}},"q2":{"label":"Q","type":"Lamp","propagation":0,"position":{"x":370,"y":205}},"notq2":{"label":"~Q","type":"Lamp","propagation":0,"position":{"x":365,"y":295}},"nor1":{"label":"nor","type":"Nor","propagation":0,"bits":1,"position":{"x":180,"y":80}},"nor2":{"label":"nor","type":"Nor","propagation":0,"bits":1,"position":{"x":175,"y":5}},"nand1":{"label":"nand","type":"Nand","propagation":0,"bits":1,"position":{"x":185,"y":185}},"nand2":{"label":"nand","type":"Nand","propagation":0,"bits":1,"position":{"x":185,"y":270}}},"connectors":[{"from":{"id":"s","port":"out"},"to":{"id":"nor2","port":"in1"}},{"from":{"id":"r","port":"out"},"to":{"id":"nor1","port":"in2"}},{"from":{"id":"nor2","port":"out"},"to":{"id":"notq1","port":"in"}},{"from":{"id":"nor1","port":"out"},"to":{"id":"q1","port":"in"}},{"from":{"id":"nor2","port":"out"},"to":{"id":"nor1","port":"in1"},"vertices":[{"x":255,"y":75}]},{"from":{"id":"nor1","port":"out"},"to":{"id":"nor2","port":"in2"},"vertices":[{"x":260,"y":55}]},{"from":{"id":"nots","port":"out"},"to":{"id":"nand1","port":"in1"}},{"from":{"id":"notr","port":"out"},"to":{"id":"nand2","port":"in2"}},{"from":{"id":"nand1","port":"out"},"to":{"id":"nand2","port":"in1"},"vertices":[{"x":265,"y":245}]},{"from":{"id":"nand2","port":"out"},"to":{"id":"nand1","port":"in2"},"vertices":[{"x":265,"y":260}]},{"from":{"id":"nand1","port":"out"},"to":{"id":"q2","port":"in"}},{"from":{"id":"nand2","port":"out"},"to":{"id":"notq2","port":"in"}}],"subcircuits":{}}
```



Diese Kombination wird in einem eignen Symbol abstrahiert. Dabei wird unser Ausgang Y nun mit Q bezeichnet.

![Bild](./images/05_FlipFlops/SR_Latch_Symbol.svg.png)<!-- style="width: 15%; max-width: 500px" -->

## Anwendungsbeispiele

__Anwendungsbeispiel 1__

![Bild](./images/05_FlipFlops/latch_temperature_monitoring.png)

Das nachfolgende Diagramm muss noch angepasst werden!!!

<!--
style="width: 80%; min-width: 420px; max-width: 720px;"
-->
```ascii

    |       +------+      +------+      +------+      +------+
Clk |       |      |      |      |      |      |      |      |
    | ------+      +------+      +------+      +------+      +------
    |     +------+                        +--+    +--+
T   |     | :    |                        |  |    |  |
    | ----+ :    +------------------------+  +----+  +--------------
    |       :        +--+   +---+         :   +----+
R   |       :        |  |   |   |         :   |    |
    | ------:--------+  +---+   +---------:---+    +----------------
    |       :  +---------------+          :  +---+                    1
A   |       :  |            :  |          :  |:  |
    |-------:--+            :  +----------:--+:  +------------------- 0
    +-------:--:------------:--:----------:--::--:-------------------->        .
             2t              2t            2t  2t
```



__Anwendungsbeispiel 2__


Entprellen eines Schalters



__Anwendungsbeispiel 3__

Rechts Links Lauf eines Motors

## Asynchrone und synchrone Schaltwerke

![Bild](./images/05_FlipFlops/motivation_cycles.png)

Wann sind die Werte am Ausgang Q gültig? Die Laufzeit der Schaltnetze bestimmt das Verhalten des Speicherelements!

> Zielstellung: Spezifische Zeiträume zur Übernahme von Eingabe und Ausgabewerten

__asynchrone Schaltwerke__

+ gesteuert durch Veränderung der Eingangssignale
+ Zeitpunkt, an dem wieder stabile Ausgangssignale vorliegen, ist nur durch Gatterlaufzeit festgelegt
+ aufwendiger Entwurf (Zeit ist „Echtzeit“)
+ sehr schnelle Schaltwerke möglich

__synchrone Schaltwerke__

+ gesteuert durch zentralen Takt
+ Übernahme der Änderung eines Eingangssignals erfolgt nur zu festen Zeiten (Zeiträumen oder Zeitpunkten)
+ einfacher, systematischer Entwurf (Zeit ist „Taktzeit“)
+ langsamste Komponente bestimmt maximale Taktfrequenz

### Syncrones SR-Latch

Für die Realisierung eines synchronisierten Flankenwechsels wird der Eingang unseres Flip-Flops um einen Takt `Clk` erweitert. Die Signale an R und S werden nur übernommen, wenn Taktsignal Clk aktiv ist:

+ bei Clk = 0 sind R und S irrelevant (d = „don't care“)
+ bei Clk = 1 stellt sich der neue Folgezustand Q ́ ein

| $R(t)$                                | $S(t)$                                | $Clk(t)$ | $Q'(t)$       |
| ------------------------------------- | ------------------------------------- | -------- | ------------- |
| <span style="color: #ff0000">d</span> | <span style="color: #ff0000">d</span> | 0        | $Q$        |
| 0                                     | 0                                     | 1        | $Q$              |
| 1                                     | 1                                     | 1        | 1             |
| 1                                     | 0                                     | 1        | 0              |
| 1                                     | 1                                     | 1        | nicht erlaubt |

Beachten Sie, dass sich mit dem <span style="color: #ff0000">d</span> Zustand die Wertetabelle deutlich verkürzt.

![Bild](./images/05_FlipFlops/synchronizedRS_NOR.png)

Welches Verhalten des Flip-Flops folgt daraus in der zeitlichen Abfolge.

<!--
style="width: 80%; min-width: 420px; max-width: 720px;"
-->
```ascii

    |       +------+      +------+      +------+      +------+
Clk |       |      |      |      |      |      |      |      |
    | ------+      +------+      +------+      +------+      +------
    |     +------+                        +--+    +--+
S   |     | :    |                        |  |    |  |
    | ----+ :    +------------------------+  +----+  +--------------
    |       :        +--+   +---+         :   +----+
R   |       :        |  |   |   |         :   |    |
    | ------:--------+  +---+   +---------:---+    +----------------
    |       :  +---------------+          :  +---+                    1
Q   |       :  |            :  |          :  |:  |
    |-------:--+            :  +----------:--+:  +------------------- 0
    +-------:--:------------:--:----------:--::--:-------------------->        .
             2t              2t            2t  2t
```



### D-Latch

...

``` json @DigiSim.evalJson
{"devices":{"d":{"label":"D","type":"Button","propagation":0,"position":{"x":-110,"y":110}},"e":{"label":"E","type":"Button","propagation":0,"position":{"x":-110,"y":210}},"q":{"label":"Q","type":"Lamp","propagation":0,"position":{"x":395,"y":130}},"notq":{"label":"~Q","type":"Lamp","propagation":0,"position":{"x":395,"y":230}},"nand1":{"label":"nand","type":"Nand","propagation":0,"bits":1,"position":{"x":235,"y":225}},"nand2":{"label":"nand","type":"Nand","propagation":0,"bits":1,"position":{"x":230,"y":125}},"nand3":{"label":"nand","type":"Nand","propagation":0,"bits":1,"position":{"x":55,"y":120}},"nand4":{"label":"nand","type":"Nand","propagation":0,"bits":1,"position":{"x":85,"y":215}}},"connectors":[{"from":{"id":"nand2","port":"out"},"to":{"id":"nand1","port":"in1"}},{"from":{"id":"nand1","port":"out"},"to":{"id":"nand2","port":"in2"}},{"from":{"id":"nand1","port":"out"},"to":{"id":"notq","port":"in"}},{"from":{"id":"nand2","port":"out"},"to":{"id":"q","port":"in"}},{"from":{"id":"e","port":"out"},"to":{"id":"nand4","port":"in2"}},{"from":{"id":"e","port":"out"},"to":{"id":"nand3","port":"in2"}},{"from":{"id":"d","port":"out"},"to":{"id":"nand3","port":"in1"}},{"from":{"id":"nand3","port":"out"},"to":{"id":"nand4","port":"in1"}},{"from":{"id":"nand3","port":"out"},"to":{"id":"nand2","port":"in1"}},{"from":{"id":"nand4","port":"out"},"to":{"id":"nand1","port":"in2"}}],"subcircuits":{}}
```

**Praktisches Beispiel**

Schaltung basierend auf 74HC00 IC (4x NAND)

![74HC00](./images/05_FlipFlops/nand_ic2_small.jpg)

Schaltung planen:

![Bauplan](./images/05_FlipFlops/dlatch_plan.png)

Aufbauen:

![Schaltung gebaut](./images/05_FlipFlops/dlatch_board.jpg)
## Übungsaufgaben

+ Weisen Sie nach, dass der zweite Ausgang P am RS-Flip-Flop den invertierten Wert von Q realisiert.
