<!--

author:   Sebastian Zug & André Dietrich & Fabian Bär
email:    sebastian.zug@informatik.tu-freiberg.de & andre.dietrich@informatik.tu-freiberg.de & fabian.baer@student.tu-freiberg.de
version:  0.0.1
language: de
narrator: Deutsch Female

import: https://raw.githubusercontent.com/LiaTemplates/NetSwarm-Simulator/master/README.md

-->

# 02 - Boolsche Algebra

**TU Bergakademie Freiberg - Wintersemester 2020 / 21**

Link auf die aktuelle Vorlesung im Versionsmanagementsystem GitHub

[https://github.com/TUBAF-IfI-LiaScript/VL_EingebetteteSysteme/blob/00_Einfuehrung](https://github.com/TUBAF-IfI-LiaScript/VL_EingebetteteSysteme/blob/dev/00_Einfuehrung)

Die interaktive Form ist unter diesem Link zu finden ->
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

## Digital vs. Analog

                              --{{0}}--
Was bedeutet der Übergang von der Ebene der physikalischen Phänomene (0) auf die
Ebene der digitalen Logik (2)?

Ein Digitalsignal ist ein Signal, welches durch diskrete Werte repräsentiert
wird und seine zeitliche Entwicklung beschreibt. Es kann aus einem Analogsignal
heraus abgeleitet werden, dass einen zeitlich-kontinuierlichen Verlauf einer
physikalischen Größe repräsentiert:

+ Temperatur im Tagesverlauf
+ Spannungswert am IC innerhalb der letzten $n$ Nanosekunden
+ ...

Die Umwandlung eines Analogsignals in ein Digitalsignal geschieht durch
Quantisierung und Abtastung, welche zu definierten Zeitpunkten erfolgt. Digitale
Werte sind üblicherweise als Binärzahlen kodiert. Ihre Quantisierung wird somit
in Bits angegeben.

<e-charts
option='{
  "xAxis": {
    "type": "category",
    "data": ["00", "01","02","03","04","05"],
    "name": "Zeitschritt"
  },
  "yAxis": [{
    "type": "value",
    "name": "Wert"
  }],
  "series": [
  {
    "data": [820, 932,601,1234,1290,1430],
    "type":"line",
    "smooth": "true"
  },
  {
  "data": [820, 932,601,1234,1290,1430],
    "type":"line",
    "step": "end",
    "lineStyle": {
              "color": "green",
              "width": "4",
              "type": "dashed"
                 },
    "itemStyle": {
                     "borderWidth": "3",
                     "borderColor": "yellow",
                     "color": "blue"
                 }
  }]
}'></e-charts>


<div id="functionPlot"></div>

Die Abtastung und Bildung des Digitalsignals erfolgt üblicherweise in konstanten Zeitintervallen, allerdings ist dies nicht zwingend notwendig.

**Beispiel**

Messung verschiedener Witterungsdaten für den Standort Freiberg im vergangenen Jahr.

 <iframe src="https://thingspeak.com/channels/856893/charts/1?bgcolor=%23ffffff&color=%23d62020&days=15&dynamic=true&type=line
" width="500" height="250"></iframe>

Der Datensatz besteht aus über 200.000 Datenpunkten, die minütlich erfasst wurden. Dies ist mit Blick auf die Dynamik der Witterung sicher etwas übertrieben.
[https://thingspeak.com/channels/856893](https://thingspeak.com/channels/856893)
