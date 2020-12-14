<!--

author:   Sebastian Zug & André Dietrich & Fabian Bär
email:    sebastian.zug@informatik.tu-freiberg.de & andre.dietrich@informatik.tu-freiberg.de & fabian.baer@student.tu-freiberg.de
version:  0.0.4
language: de
narrator: Deutsch Female

import:  https://raw.githubusercontent.com/liascript-templates/plantUML/master/README.md
         https://github.com/LiaTemplates/Pyodide

mark: <span style="background-color: @0;
                                  display: flex;
                                  width: calc(100% + 32px);
                                  margin: -16px;
                                  padding: 6px 16px 6px 16px;
                                  ">@1</span>
red:  @mark(#FF888888,@0)
blue: @mark(#898AE3,@0)
gray: @mark(gray,@0)
-->

# RISC vs. CISC

**TU Bergakademie Freiberg - Wintersemester 2020 / 21**

Link auf die aktuelle Vorlesung im Versionsmanagementsystem GitHub

[https://github.com/TUBAF-IfI-LiaScript/VL_EingebetteteSysteme/blob/11_Modell_CPU.md](https://github.com/TUBAF-IfI-LiaScript/VL_EingebetteteSysteme/blob/master/11_Modell_CPU.md)

Die interaktive Form ist unter [diesem Link](https://liascript.github.io/course/?https://raw.githubusercontent.com/TUBAF-IfI-LiaScript/VL_EingebetteteSysteme/master/11_Modell_CPU.md#1) zu finden

---------------------------------------------------------------------

** Fragen an die Veranstaltung**

+ Was bedeutet der Begriff der semantischen Lücke?
+ Wie versuchen CISC Systeme diese zu schließen?
+ Warum kann der Geschwindigkeitsgewinn, der mit Pipelining möglich ist nicht mit CISC Systemen umgesetzt werden?
+ Welche Pipelininghindernisse sind Ihnen bekannt? Welche Lösungsstrategien?
+ Was sind die Kernparameter einer RISC Computers?
+ Grenzen Sie RISC und CISC Systeme gegeneinander ab.
+ Welcher Strategie folgen aktuelle Controller?

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
           +----------------------------+         ╔═══════════════╗
                                               ◀══║ HIER SIND WIR!║
           +----------------------------+  -.     ╚═══════════════╝
  Ebene 2  | Mikroarchitektur           |   |
           +----------------------------+   |
                                            ⎬ Automaten, Speicher, Logik
           +----------------------------+   |
  Ebene 1  | Digitale Logik             |   |
           +----------------------------+  -.

           +----------------------------+
  Ebene 0  | E-Technik, Physik          |     Analoge Phänomene
           +----------------------------+                                      .
```

---------------------------------------------------------------------

## Ausgangspunkt

Enstehungsgründe für umfangreiche Maschinenbefehlssätze:

+ Geschwindigkeitsunterschied zwischen CPU und Hauptspeicher
+ Mikroprogrammierung
+ Kompakter Code
+ Unterstützung höherer Programmiersprachen
+ Aufwärtskompatibilität
+ Marktstrategie

## Lösungsansatz

| Kriterium                            | Einzelner Arbeiter                                                        | Gruppe                                                                                            | Fließband                                                                                |
| ------------------------------------ | ------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------- |
| Organisationsform                    | Jeder Arbeit baut ein vollständiges Auto                                  | Gruppen realisieren die Fahrzeuge parallel                                                        | Ein Fließband verbindet Arbeitsstationen, an denen ein spezielle Arbeit ausgeführt wird  |
| Spezialisierung                      | gering                                                                    | mittel                                                                                            | hoch                                                                                     |
| Fertigkeiten                         | hoch                                                                      | mittel                                                                                            | gering                                                                                   |
| Robustheit und Koordinierungsaufwand | Robust gegen Ausfälle und unterschiedliche Arbeitsgeschwindigkeiten       | Robust gegen Ausfälle und unterschiedliche Arbeitsgeschwindigkeiten im Vergleich zu anderen Teams | Empfindlich gegen Ausfälle und unterschiedliche Arbeitsgeschwindigkeiten                 |
| Erhöhung des Durchsatzes             | Erhöhung der Arbeitsleitung in Abstimmung mit der Gruppenarbeit einzelnen |                                                                                                   | Erhöhung der Arbeitsleitung des einzelnen in Abstimmung mit der Taktrate des Fließbandes |
|                                      | Erhöhung der Mitarbeiterzahl                                              | Erhöhung der Teamzahl                                                                             | Erhöhung der Anzahl der Fließbänder                                                      |

Ransom Eli Olds verwendete bereits 1902 für die Produktion seiner „Oldsmobile“ bewegliche Holzgestelle, auf denen die Fahrgestelle von Station zu Station geschoben wurden. Henry Ford mechanisierte und verfeinerte dieses Prinzip, indem er mit Hilfe seines Ingenieurs Charles E. Sorensen und des Vorarbeiters Lewis im Jahr 1913 ein permanentes Fließband aufbaute und so die erste „moving assembly line“ installierte.

![Fließbandverarbeitung](https://upload.wikimedia.org/wikipedia/commons/d/d6/A-line1913.jpg)<!-- width="50%" --> [^1]

[^1]: 1913 photograph Ford company, USA, https://commons.wikimedia.org/wiki/File:A-line1913.jpg

```text @plantUML.png
@startuml
ditaa

Sequentielle Abarbeitung
:            :            :            :            :            :
+----------+ +-----+ +--------+ +------+ +---------+
|cF88      | |cFF4 | |c88F    | |c8F8  | |cD10     |
+----------+ +-----+ +--------+ +------+ +---------+
:            :            :            :            :+----------+ +-----+
:            :            :            :            :|cF88      | |cFF4 |
:            :            :            :            :+----------+ +-----+
:            :            :            :            :             :

<--------- Fertigungsdauer eines Fahrzeuges -------> <-----
@enduml
```


```text @plantUML.png
@startuml
ditaa

Pipline Abarbeitung

+----------+ +----------+ +----------+ +----------+ +----------+ +----------+
|cF88      | |cF88      | |cF88      | |cF88      | |cF88      | |cF88      |
+----------+ +----------+ +----------+ +----------+ +----------+ +----------+
:            +-----+      +-----+      +-----+      +-----+    : +-----+    :
:            |cFF4 |      |cFF4 |      |cFF4 |      |cFF4 |    : |cFF4 |    :
:            +-----+      +-----+      +-----+      +-----+    : +-----+    :
:            :            +--------+   +--------+   +--------+ : +--------+ :
:            :            |c88F    |   |c88F    |   |c88F    | : |c88F    | :
:            :            +--------+   +--------+   +--------+ : +--------+ :
:            :            :            +-------+    +-------+  : +-------+  :
:            :            :            |c8F8   |    |c8F8   |  : |c8F8   |  :
:            :            :            +-------+    +-------+  : +-------+  :
:            :            :            :            +---------+: +---------+:
:            :            :            :            |cD10     |: |cD10     |:
:            :            :            :            +---------+: +---------+:


<--------------------- Befüllen der Pipeline ----------------->

@enduml
```

Gegen wir davon aus, dass $n$ Operationen ausgeführt werden sollen. Die Tiefe der Pipeline ergibt sich zu $k$. Entsprechend sind bei der sequenziellen Arbeit also $n \cdot k$ Zeitslots notwendig. Im Pipelinemodus werden lediglich $(n-1)$ Schritte zum Befüllen der Pipeline gebraucht. Danach folgt mit jedem Takt eine abgeschlossene Operation.

$$
S = \frac{n \cdot k}{k + (n-1)}
$$

```python
import numpy as np
import matplotlib.pyplot as plt

def S(n, k):
  return (n * k) / (k + (n-1))

n = np.arange(0.0, 500.0, 5.0)

fig, ax = plt.subplots()

#for k in [2, 10, 25, 50, 100]:


S = np.array([S(ni, k) for ni in n])
print(S)

ax.plot(n, S)

ax.grid(True, linestyle='-.')
ax.tick_params(labelcolor='r', labelsize='medium', width=3)

plt.show()

plot(fig) # <- this is required to plot the fig also on the LiaScript canvas
```
@Pyodide.eval

## Pipeline im Rechner

Unser bisheriger Modellrechner kombiniert 2 Phasen, die Fetch und die Execute Phase. Können wir das Pipeliningkonzept darauf anwenden?

Dagegen spricht:

+ die unterschiedliche Konstellation der Befehle - Einzyklus und Zweizyklus-Befehle
+ die "Wiederverwendung" der Komponenten bei den Zweizyklus-Befehlen.

Entsprechend schauen wir uns die Frage des Pipelining an einem alternativen System an.

| Abkürzung | Bezeichnung                             | Funktion                                                                                                       |
| --------- | --------------------------------------- | -------------------------------------------------------------------------------------------------------------- |
| IF        | Instruction Fetch                       | Die nächste Instruktion wird unter Benutzung des Programmzählers (PC) geladen                                  |
| ID        | Instruction Decode and Operand Fetching | OPCODE und die Operanden in der Instruktion werden ausgewertet und die entsprechenden Kontrollsignale erzeugt. |
| EX        | Instruction Execution                   | durch den OPCODE spezifizierte Funktion wird ausgeführt                                                        |
| ME        | Memory Access                           | Daten werden aus dem Speicher geladen oder in den Speicher geschrieben                                         |
| WB        | Write Back                              | Resultat der Berechnung wird in ein Zielregister übertragen                                                    |

## Hausaufgaben
