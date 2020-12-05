<!--

author:   Sebastian Zug & André Dietrich & Fabian Bär
email:    sebastian.zug@informatik.tu-freiberg.de & andre.dietrich@informatik.tu-freiberg.de & fabian.baer@student.tu-freiberg.de
version:  0.0.2
language: de
narrator: Deutsch Female

import:  https://raw.githubusercontent.com/liascript-templates/plantUML/master/README.md

mark: <span style="background-color: @0;
                                  display: flex;
                                  width: calc(100% + 32px);
                                  margin: -16px;
                                  padding: 6px 16px 6px 16px;
                                  ">@1</span>
red:  @mark(#FF888888,@0)
blue: @mark(lightblue,@0)
gray: @mark(gray,@0)
-->

# Rechnerarithmetik

**TU Bergakademie Freiberg - Wintersemester 2020 / 21**

Link auf die aktuelle Vorlesung im Versionsmanagementsystem GitHub

[https://github.com/TUBAF-IfI-LiaScript/VL_EingebetteteSysteme/blob/10_CPU_Basis.md](https://github.com/TUBAF-IfI-LiaScript/VL_EingebetteteSysteme/blob/master/10_CPU_Basis.md)

Die interaktive Form ist unter [diesem Link](https://liascript.github.io/course/?https://raw.githubusercontent.com/TUBAF-IfI-LiaScript/VL_EingebetteteSysteme/master/10_CPU_Basis.md#1) zu finden


---------------------------------------------------------------------

** Fragen an die Veranstaltung**

+ Welche Funktionalität sollte eine ALU bereitstellen?
+ Welcher Trade-Off ist mit der Entscheidung über die Wortbreite einer
+ CPU und der Breite des möglichen OP-Codes verbunden?
+ Welche Register gehören zum Programmiermodell eines Rechners?
+ Welche Register sind für das Laden der Programmbefehle erforderlich und wir arbeiten sie zusammen?
+ Erklären Sie die Vorgänge in der Fetch- und Execute-Phase der Befehlsabarbeitung.

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

           +----------------------------+  -.      ╔═══════════════╗
  Ebene 2  | Mikroarchitektur           |   |   ◀══║ HIER SIND WIR!║
           +----------------------------+   |      ╚═══════════════╝
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
## Interpretation der Befehle

```text @plantUML
@startuml
ditaa
                           Instruction Register                                                                    
                        +---------+------------+                                                                   
                        |OPCODE   |            |                                                                   
                        +-+-+-+-+-+------------+                                                                   
                         | | | |                                                                                   
                         V V V V                                                                                   
         +-----------------------------------------------------------------+                                       
         |                       1 aus 16 Dekodierer                       |                                       
         |                                                                 |                                       
         +--+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+--+                                       
            |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |                                          
            |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |                                          
           HLT JMA JMP SRJ CSA RAL INP OUT NOT LDA STA ADD XOR IOR AND NOP                                         
            |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |                                          
            V   V   V   V   V   V   V   V   V   V   V   V   V   V   V   V                                          
         +-----------------------------------------------------------------+  Steuersignale:                       
         |cF41                                                             +---> ALU,                              
         |                                                                 |     Register Kontrolle,               
         |                                                                 +---> Speicher Kontrolle,               
Clock--->|             Sequentielles Schaltnetz                            |     ...                               
         |                                                                 | ...                                   
         |                                                                 |  Flags:                               
         |                                                                 |<--- Signum, Zero, Overflow, Carry, ...
         +-----------------------------------------------------------------+                                       
@enduml
```
