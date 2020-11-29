<!--

author:   Sebastian Zug & André Dietrich & Fabian Bär
email:    sebastian.zug@informatik.tu-freiberg.de & andre.dietrich@informatik.tu-freiberg.de & fabian.baer@student.tu-freiberg.de
version:  0.0.2
language: de
narrator: Deutsch Female

import:  https://raw.githubusercontent.com/liascript-templates/plantUML/master/README.md

import: https://raw.githubusercontent.com/LiaTemplates/DigiSim/master/README.md
-->

# Rechnerarithmetik

**TU Bergakademie Freiberg - Wintersemester 2020 / 21**

Link auf die aktuelle Vorlesung im Versionsmanagementsystem GitHub

[https://github.com/TUBAF-IfI-LiaScript/VL_EingebetteteSysteme/blob/09_Rechnerarithmetik](https://github.com/TUBAF-IfI-LiaScript/VL_EingebetteteSysteme/blob/master/09_Rechnerarithmetik.md)

Die interaktive Form ist unter [diesem Link](https://liascript.github.io/course/?https://raw.githubusercontent.com/TUBAF-IfI-LiaScript/VL_EingebetteteSysteme/master/09_Rechnerarithmetik.md#1) zu finden

## Halbaddierer

``` json @DigiSim.evalJson
{"devices":{"a":{"label":"a","type":"Button","propagation":0,"position":{"x":15,"y":0}},"b":{"label":"b","type":"Button","propagation":0,"position":{"x":15,"y":50}},"s":{"label":"s","type":"Lamp","propagation":1,"position":{"x":315,"y":45}},"cout":{"label":"cout","type":"Lamp","propagation":1,"position":{"x":315,"y":0}},"xor":{"label":"a xor b","type":"Xor","propagation":1,"bits":1,"position":{"x":160,"y":50}},"and":{"label":"a and b","type":"And","propagation":1,"bits":1,"position":{"x":155,"y":-5}}},"connectors":[{"from":{"id":"a","port":"out"},"to":{"id":"and","port":"in1"}},{"from":{"id":"b","port":"out"},"to":{"id":"and","port":"in2"}},{"from":{"id":"and","port":"out"},"to":{"id":"cout","port":"in"}},{"from":{"id":"a","port":"out"},"to":{"id":"xor","port":"in1"}},{"from":{"id":"b","port":"out"},"to":{"id":"xor","port":"in2"}},{"from":{"id":"xor","port":"out"},"to":{"id":"s","port":"in"}}],"subcircuits":{}}
```

## Volladdierer

``` json @DigiSim.evalJson
{"devices":{"a":{"label":"a","type":"Button","propagation":0,"position":{"x":15,"y":0}},"b":{"label":"b","type":"Button","propagation":0,"position":{"x":15,"y":50}},"cin":{"label":"cin","type":"Button","propagation":0,"position":{"x":15,"y":100}},"s":{"label":"s","type":"Lamp","propagation":1,"position":{"x":470,"y":70}},"cout":{"label":"cout","type":"Lamp","propagation":1,"position":{"x":540,"y":-5}},"xor1":{"label":"a xor b","type":"Xor","propagation":1,"bits":1,"position":{"x":140,"y":20}},"xor2":{"label":"(a xor b) xor cin","type":"Xor","propagation":1,"bits":1,"position":{"x":275,"y":75}},"and1":{"label":"(a xor b) and cin","type":"And","propagation":1,"bits":1,"position":{"x":290,"y":25}},"and2":{"label":"a and b","type":"And","propagation":1,"bits":1,"position":{"x":210,"y":-25}},"or":{"label":"((a xor b) and cin) or (a and b)","type":"Or","propagation":1,"bits":1,"position":{"x":380,"y":-30}}},"connectors":[{"from":{"id":"xor2","port":"out"},"to":{"id":"s","port":"in"}},{"from":{"id":"xor1","port":"out"},"to":{"id":"xor2","port":"in1"}},{"from":{"id":"cin","port":"out"},"to":{"id":"xor2","port":"in2"}},{"from":{"id":"a","port":"out"},"to":{"id":"xor1","port":"in1"}},{"from":{"id":"b","port":"out"},"to":{"id":"xor1","port":"in2"}},{"from":{"id":"cin","port":"out"},"to":{"id":"and1","port":"in2"},"vertices":[{"x":225,"y":115}]},{"from":{"id":"xor1","port":"out"},"to":{"id":"and1","port":"in1"}},{"from":{"id":"a","port":"out"},"to":{"id":"and2","port":"in1"}},{"from":{"id":"b","port":"out"},"to":{"id":"and2","port":"in2"},"vertices":[{"x":105,"y":25}]},{"from":{"id":"and1","port":"out"},"to":{"id":"or","port":"in2"}},{"from":{"id":"and2","port":"out"},"to":{"id":"or","port":"in1"}},{"from":{"id":"or","port":"out"},"to":{"id":"cout","port":"in"}}],"subcircuits":{}}
```

## Hypothetische ALU mit 8 Funktionen

```text @plantUML
@startuml
ditaa
             Daten                 Daten
               |                     |
               |                     |
+--------------|---------------+     |
| +------+     |               |     |
| |      |     |               :     |     Funktionsauswahl
| |      V     V               V     V         |||
| | +----+-----+-----+    +----+-----+-----+   |||
| | |cBFB Register A |    |cBFB Register B |   |||    Registerauswahl
| | +---+------------+    +---------+------+   |||           |
| |     |                           |          |||           |
| |     |        +------------------+          |||           |
| |     |        |                  |          |||           |
| |     +--------+-----------+      |          |||           |
| |     |        |           |      |          |||           |
| |     V        V           V      V          |||           |
| | +----------------+    +----------------+   |||           |
| | |c808            |<-  |c808            |<--+||           |
| | |  Multiplexer   |<-  |  Multiplexer   |<---+|           |
| | |                |<-  |                |<----+           |
| | ++-+-+-+-+-+-+-+-+    ++-+-+-+-+-+-+-+-+                 |
| |  | | | | | | | |       | | | | | | | |                   |
| |  | | | | | | | |       V V V V V V V V                   |
| |  | | | | | | | +----------------------------------+      |
| |  | | | | | | +-----------------------------+      |      |
| |  | | | | | +------------------------+      |      |      |
| |  | | | | +-------------------+      |      |      |      |
| |  | | | +--------------+      |      |      |      |      |
| |  | | +---------+      |      |      |      |      |      |
| |  | +----+      |      |      |      |      |      |      |
| |  |      |      |      |      |      |      |      |      |
| |  |  |   |  |   |  |   |  |   |  |   |  |   |  |   |  |   |
| |  V  V   V  V   V  V   V  V   V  V   V  V   V  V   V  V   |
| | +----+ +----+ +----+ +----+ +----+ +----+ +----+ +----+  |
| | | 000| | 001| | 010| | 011| | 100| | 101| | 110| | 111|  |
| | |cFF4| |cFF4| |cFF4| |cFF4| |cFF4| |cFF4| |cFF4| |cFF4|  |
| | | OR | |AND | |EXOR| |ADD | |SUB | |MUL | |DIV | | SL |  |
| | +-+--+ +-+--+ +-+--+ +-+--+ +-+--+ +-+--+ +-+--+ +-+--+  |
| |   :      :      :      :      :      :      :      :     |
| |   +------+------+------+---+--+------+------+------+     |
| |                            |                             |
| |                            V                             |
| |                 +----------+----------+                  |
| |                 |cCCB DeMuxer/Selektor|<-----------------+
| |                 +---+-+---------------+
| |                     : :
| +---------------------+ |
|                         |
+-------------------------+
@enduml
```
@plantUML

Abstrakte Darstellung

```text @plantUML
@startuml
ditaa
           +-----+-----+
           |  A  |  B  |
    Daten  +-----+-----+
<--------->+cFF4       |
           |           |
 Kontrolle |    ALU    |
---------->+           |
           |           |
   Status  |           |
<----------+           |
           +-----------+
@enduml
```
@plantUML

## Herausforderung Datenzugriff

```text @plantUML
@startuml
ditaa
               +------------------+
               |c44F              |
               |     Speicher     |
               |                  |
               +-----------+------+
                       ^   |
                       |   |
+----------+  Adresse  |   |               +-----+-----+
|cF88      +-----------+   |               |  A  |  B  |
|          |               |        Daten  +-----+-----+
|          |               |    <--------->+cFF4       |
|  Steuer- |               |               |           |
|   werk   |               |     Kontrolle |    ALU    |
|          |               +-------------->+           |
|          |                               |           |
+----------+                               +-----------+
@enduml
```
@plantUML



```text @plantUML
@startuml
ditaa
               +------------------+
               |c44F              |                     
               |     Speicher     |
               |                  |
               +---------+-+------+
                       ^ | ^
                       | | |
+----------+  Adresse  | | |               +-----+-----+
|cF88      +-----------+ | |               |  A  |  B  |
|          |             | |        Daten  +-----+-----+
|          |   Befehl    | +-------------->+cFF4       |
|  Steuer- |<------------+                 |           |
|   werk   |                     Kontrolle |    ALU    |
|          +------------------------------>+           |
|          |                               |           |
|          |                       Status  |           |
|          |<------------------------------+           |
+----------+                               +-----------+
@enduml
```
@plantUML

```text @plantUML
@startuml
ditaa
               +------------------+
               |c88F              |
               |     Speicher     |
               |                  |
               +---------+-+------+
                       ^ | ^
                       | | |
+----------+  Adresse  | | |               +-----+-----+
|cF88      +-----------+ | |               |  A  |  B  |
|          |             | |        Daten  +-----+-----+
|          |   Befehl    | +-------------->+cFF4       |
|  Steuer- |<------------+                 |           |
|   werk   |                     Kontrolle |    ALU    |
|          +------------------------------>+           |
|          |                               |           |
|          |                       Status  |           |
|          |<------------------------------+           |
|          |                               |           |
|          | Kontrolle                     |           |
|          +-------------+         Daten   |           |
|          |             | +-------------->|           |
|          |  Status     | |               |           |
|          |<----------+ | |               |           |
+----------+           | | |               +-----------+
                       | | |
                       | V V
               +-------+-----------+
               |c8F8               |
               |    Ein/Ausgabe    |
               |                   |
               +-------------------+
@enduml
```
@plantUML

## 1945:  Von-Neumann Architektur

```text @plantUML
@startuml
ditaa
  ^  |
  |  V
+-+----+    +----------------------------+
|c8F8  |    |c88F   Speicherwerk         |
|      |<-->|   +--------+  +--------+   |
|      |    |   |Programm|  | Daten  |   |
|      |    |   +--------+  +--------+   |
|      |    +------+---------------------+
|      |        ^  |             ^
| E/A- |        :  |             |
| Werk |        |  V             V
|      |    +---+------+    +------------+
|      |    |cF88      |    | Rechenwerk |
|      |    |          |    |cFF4        |
|      |    |          |<-=-+ +--------+ |
|      |<-=-+Steuerwerk|    | |Register| |
|      |    |          +-=->| +--------+ |
|      |    |          |    | |  ALU   | |
|      |    |          |    | +--------+ |
+------+    +----------+    +------------+
@enduml
```
@plantUML
