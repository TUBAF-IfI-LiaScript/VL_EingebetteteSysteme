<!--

author:   Sebastian Zug & André Dietrich & Fabian Bär
email:    sebastian.zug@informatik.tu-freiberg.de & andre.dietrich@informatik.tu-freiberg.de & fabian.baer@student.tu-freiberg.de
version:  0.0.1
language: de
narrator: Deutsch Female

import:  https://raw.githubusercontent.com/liascript-templates/plantUML/master/README.md

-->

# Rechnerarithmetik

**TU Bergakademie Freiberg - Wintersemester 2020 / 21**

Link auf die aktuelle Vorlesung im Versionsmanagementsystem GitHub

[https://github.com/TUBAF-IfI-LiaScript/VL_EingebetteteSysteme/blob/00_Einfuehrung](https://github.com/TUBAF-IfI-LiaScript/VL_EingebetteteSysteme/blob/master/09_Rechnerarithmetik.md)

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
