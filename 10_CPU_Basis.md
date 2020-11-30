<!--

author:   Sebastian Zug & André Dietrich & Fabian Bär
email:    sebastian.zug@informatik.tu-freiberg.de & andre.dietrich@informatik.tu-freiberg.de & fabian.baer@student.tu-freiberg.de
version:  0.0.2
language: de
narrator: Deutsch Female

import:  https://raw.githubusercontent.com/liascript-templates/plantUML/master/README.md

-->

# Rechnerarithmetik

**TU Bergakademie Freiberg - Wintersemester 2020 / 21**

Link auf die aktuelle Vorlesung im Versionsmanagementsystem GitHub

[https://github.com/TUBAF-IfI-LiaScript/VL_EingebetteteSysteme/blob/09_Rechnerarithmetik](https://github.com/TUBAF-IfI-LiaScript/VL_EingebetteteSysteme/blob/master/09_Rechnerarithmetik.md)

Die interaktive Form ist unter [diesem Link](https://liascript.github.io/course/?https://raw.githubusercontent.com/TUBAF-IfI-LiaScript/VL_EingebetteteSysteme/master/09_Rechnerarithmetik.md#1) zu finden

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
               |c88F              |
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

## Wortformate

Befehlsformat:

```text @plantUML
@startuml
ditaa
15         12 11                             0
+------------+-------------------------------+
|c00F OPCODE | cFF0 Operantenaddresse        |
+------------+-------------------------------+
@enduml
```

Datenformat:

```text @plantUML
@startuml
ditaa
   15
+-------+------------------------------------+
|cF00 V | cFF0                               |
+-------+------------------------------------+
@enduml
```

## Vom Modell ....... zum funktionsfähigen Rechner

```text @plantUML
@startuml
ditaa
+-----------+   Speicherbezogene Komponenten
|  Memory   |
|c33F       |<-----------------------+
+---+-------+                        |
    |  ^                             |
15  V  |              0   11         |          0
+------+---------------+ +-----------+-----------+
|Memory Buffer Register| |Memory Address Register|
|cAAF                  | |cAAF                   |
+----------------------+ +-----------------------+
@enduml
```

```text @plantUML
@startuml
ditaa
+-----------------------------+
|c88F    Z-Register           |
+-----------------------------+
|cFF4                         |     Datenpfadbezogene
|                             |         Komponenten
|             ALU             |
|                             |
+-----------+-----------------+
            |     ^
            V     |
+-----------------+-----------+
|c88F          A              |
+-----------------------------+
@enduml
```

```text @plantUML
@startuml
ditaa
              11                             0
             +-------------------------------+
             | cFF0 Program Counter          |
             +-------------------------------+

15         12 11                             0
+------------+-------------------------------+
|c00F OPCODE | cFF0 Operant                  |
+------------+-------------------------------+
      Instruction Register

+-----------------+
|cF88             |  +-----------+ +-------------+
| control unit    |  |c44F Run FF| |c44F State FF|
|                 |  +-----------+ +-------------+
+-----------------+

  Kontrolleinheit bezogene Komponenten
@enduml
```
