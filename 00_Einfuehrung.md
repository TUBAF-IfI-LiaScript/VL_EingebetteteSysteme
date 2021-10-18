<!--

author:   Sebastian Zug, André Dietrich & `fjangfaragesh`, `FnHm`, `gjaeger`
email:    sebastian.zug@informatik.tu-freiberg.de & andre.dietrich@informatik.tu-freiberg.de & fabian.baer@student.tu-freiberg.de
version:  0.0.1
language: de
narrator: Deutsch Female

import:   https://raw.githubusercontent.com/liascript-templates/plantUML/master/README.md
          https://raw.githubusercontent.com/LiaTemplates/NetSwarm-Simulator/master/README.md
          https://raw.githubusercontent.com/liaTemplates/DigiSim/master/README.md
          https://raw.githubusercontent.com/liaTemplates/AVR8js/main/README.md
-->

# Einführung

[![LiaScript](https://raw.githubusercontent.com/LiaScript/LiaScript/master/badges/course.svg)](https://liascript.github.io/course/?https://raw.githubusercontent.com/TUBAF-IfI-LiaScript/VL_EingebetteteSysteme/master/00_Einfuehrung.md#1)

| Parameter                | Kursinformationen                                                                                                                                                                          |
| ------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| **Veranstaltung:**       | `Eingebettete Systeme`                                                                                                                                                                     |
| **Semester**             | `Wintersemester 2021/22`                                                                                                                                                                      |
| **Hochschule:**          | `Technische Universität Freiberg`                                                                                                                                                          |
| **Inhalte:**             | `Motivation der Vorlesung "Eingebettete Systeme" und Beschreibung der Organisation der Veranstaltung`                                                                                      |
| **Link auf GitHub:** | [https://github.com/TUBAF-IfI-LiaScript/VL_Softwareentwicklung/blob/master/00_Einfuehrung.md](https://github.com/TUBAF-IfI-LiaScript/VL_EingebetteteSysteme/blob/master/00_Einfuehrung.md) |
| **Autoren**              | @author                                                                                                                                                                                    |

![](https://media.giphy.com/media/10PNyg7YOcaBQA/giphy-downsized.gif)

---------------------------------------------------------------------


## Zielstellung

Was steht im Modulhandbuch über diesen Kurs?

**Qualifikationsziele /Kompetenzen:**

_Mit der erfolgreichen Teilnahme an der Veranstaltung sollen die Studierenden in der Lage sein:_

+ _die Teilkomponenten eines Rechners ausgehend von der Boolschen Algebra sowie kombinatorischen und sequentiellen Schaltungen zu beschreiben und ausschnitthafte Teilelemente selbstständig entwerfen zu können._
+ _die Integration der Elemente und die Abläufe bei der Programmabarbeitung in verschiedenen Modellrechnern zu beherrschen und die Vor- und Nachteile verschiedener Konfigurationen bewerten zu können,_
+ _Architekturentwürfe auf reale Controller zu übertragen, die resultierenden Programmierkonzepte zu verstehen und anzuwenden_
+ _die konkrete Realisierung von eingebetteten Systemen in entsprechenden Anwendungen aus den Schaltplänen zu erfassen und die softwareseitigen Realisierungen daraus abzuleiten_

**Inhalte**

_Grundlegende Prinzipien der Modellierung digitaler Systeme: Boolsche Algebren und Funktionen, kombinatorische und sequentielle Schaltungen, Herleitung eines Modellrechners und Abbildung von dessen Funktionsweise, Einführung in die Entwicklung eingebetteter Systeme(Sensoren, Aktoren, elektrische Peripherie, Programmierkonzepte), Anwendungsfelder_

### Software

**Und was heißt das nun konkret? Worum geht es?**

Nehmen wir an, Sie realisieren ein Arduino Beispielprogramm wie dieses:

<div id="example1">
<wokwi-led color="red"   pin="13" label="13"></wokwi-led>
<wokwi-led color="green" pin="12" label="12"></wokwi-led>
<wokwi-led color="blue"  pin="11" label="11"></wokwi-led>
<wokwi-led color="blue"  pin="10" label="10"></wokwi-led>
<span id="simulation-time"></span>
</div>

```cpp
byte leds[] = {13, 12, 11, 10};
void setup() {
  Serial.begin(115200);
  for (byte i = 0; i < sizeof(leds); i++) {
    pinMode(leds[i], OUTPUT);
  }
}

int i = 0;
void loop() {
  Serial.print("LED: ");
  Serial.println(i);
  digitalWrite(leds[i], HIGH);
  delay(250);
  digitalWrite(leds[i], LOW);
  i = (i + 1) % sizeof(leds);
}
```
@AVR8js.sketch

{{2}}
Am Ende des Compiliervorganges entsteht daraus der sogenannte Maschinencode. Dieser ist die Sprache, die der Rechner originär versteht und der entsprechend ausgeführt werden kann.

{{2}}
```
:100000000C9472000C947E000C947E000C947E0084
:100010000C947E000C947E000C947E000C947E0068
:100020000C947E000C947E000C947E000C947E0058
…
:1000A0000C947E000C947E000C947E000C947E00D8
:1000B0000C947E000C947E000C947E000C947E00C8
:1000C0000C947E000C947E000C947E000C947E00B8
:1000D0000C947E000C947E000C947E000C947E00A8
:1000E0000C947E0011241FBECFEFD1E2DEBFCDBF46
:1000F00000E00CBF0E9480000C9483000C94000070
:0A010000279A2F98FFCFF894FFCF            45
:00000001FF
```

### Hardware

**Was heißt das denn nun der Rechner?**

![Diagramme](./images/00_Einfuehrung/IOpin.png)<!-- width="60%" -->

**Auf welche konkreten Systeme schauen wir dabei insbesondere?**

+ ATmega4808/4809
+ ATmega32

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
           +----------------------------+   |       ╔══════════════════╗
  Ebene 1  | Digitale Logik             |   |    ◀══║ HIER STARTEN WIR!║
           +----------------------------+  -.       ╚══════════════════╝

           +----------------------------+
  Ebene 0  | E-Technik, Physik          |     Analoge Phänomene
           +----------------------------+                                      .
```

### Anwendungen

**Und wie nützt mir das?**

![Diagramme](./images/00_Einfuehrung/Wetterstation.png)<!-- width="70%" -->

Wenn wir noch einen Schritt weitergehen, können wir die Daten auch an einen Server übergeben. Dieser übernimmt die Aufbereitung und Visualisierung.

<iframe width="450" height="260" style="border: 1px solid #cccccc;" src="https://thingspeak.com/channels/856893/charts/7?bgcolor=%23ffffff&color=%23d62020&days=3&dynamic=true&type=line"></iframe>

Hier lassen sich dann die eigentlichen "Untersuchungen" realisieren und zum Beispiel die Frage beantworten, ob die Sonne am Wochenende häufiger scheint.

![Diagramme](./images/00_Einfuehrung/AlleWetter.png)<!-- width="70%" -->

Die roten Punkte stellen die Verteilung der Wochenendmessungen der vergangenen Woche dar, während die blauen Kreuze die Wochentage illustrieren. Dunkelheit wird durch einen Wert nahe 1023 ausgedrückt, während helle Messituationen durch kleine Werte dargestellt werden.

**Aber ich will Webentwickler werden ... **

**Antwort A:**
Das Studium vermittelt ein breitgefächertes Weltbild und keine eng zugeschnittene Sicht.

**Antwort B:**
Die Fähigkeit in Algorithmen zu denken ist eine Grundlage wissenschaftlichen
Arbeitens.

**Antwort C:**
Am Ende steht Ihnen das Rüstzeug zur Verfügung kleine eingebettete C-Projekte
selbst anzugehen.

## Organisation

| Name                    | Email                                      |
|:----------------------- |:------------------------------------------ |
| Prof. Dr. Sebastian Zug | sebastian.zug@informatik.tu-freiberg.de    |
| Dr. Martin Reinhardt    | martin.reinhardt@informatik.tu-freiberg.de |

> Bitte melden Sie sich im OPAL unter [Eingebettete Systeme](https://bildungsportal.sachsen.de/opal/auth/RepositoryEntry/32295976976/CourseNode/102563572218999) für die Veranstaltung an. Dies ist im Kontext der Pandemiesituation Teil des Hygienekonzepts der Hochschule.

### Zeitplan

Die Veranstaltung wird sowohl für die Vorlesung als auch die Übung in Präsenz durchgeführt.

<!-- data-type="none" -->
| Veranstaltungen | Tag      | Zeitslot      | Ort      | Bemerkung     |
| --------------- | -------- | ------------- | -------- | ------------- |
| Vorlesung I     | Montag   | 16.00 - 17.30 | WIN-1005 | wöchentlich   |
| Vorlesung II    | Dienstag | 16.00 - 17.30 | WIN-1005 | gerade Wochen |

> Die zugehörigen Übungen starten am 8./9. Dezember und werden dann wöchentlich durchgeführt.

+ Übung 1 (Mm, ROB), Donnerstags, 14.00 - 15.30 Uhr, KKB-2097
+ Übung 2 (BAI), Mittwochs, 16.00-17.30 Uhr, KKB-2097

Wir gehen gegenwärtig noch davon aus, dass die Übungen auch in Präsenz stattfinden. Dort haben Sie dann insbesondere ab Januar Gelegenheit anhand spezifischer Mikrocontrollerschaltungen Ihre Fähigkeiten zu vertiefen.


### Prüfungsmodalitäten

> *Credit-Points:* 6

> *Arbeitsaufwand:* Der Zeitaufwand beträgt 180h und setzt sich zusammen aus **60h Präsenzzeit** und **120h Selbststudium**. Letzteres umfasst die Vor- und Nachbereitung der Lehrveranstaltung, die eigenständige Lösung von Übungsaufgaben sowie die Prüfungsvorbereitung.

> *Prüfungsform:* Die Veranstaltung wird mit einer schriftlichen Prüfung abgeschlossen. Diese wird als Open Book Klausur entworfen.

## Literaturempfehlungen

1. Umfassende Lehrbücher

   + David A. Patterson, John L. Hennessy: Computer Organization & Design
   + B. Becker, R. Drechsler, P. Molitor: Technische Informatik - Eine Einführung, Pearson Studium, 2005
   + Hoffmann, D. W.: Grundlagen der technischen Informatik, Hanser Verlag

2. Videos

   + Youtube – „How a CPU Works“ [Link](https://www.youtube.com/watch?v=cNN_tTXABUA)

Bei den jeweiligen Vorlesungsinhalten werden zusätzliche Materialien angegeben.

## Schreiben Sie an den Materialien mit!

                              {{0-1}}
****************************************************************************

Die Lehrmaterialien finden Sie unter GitHub, einer Webseite für das Versionsmanagement und die Projektverwaltung.

[https://github.com/TUBAF-IfI-LiaScript/VL_EingebetteteSysteme/blob/dev/01_HistorischerUeberblick.md](https://github.com/TUBAF-IfI-LiaScript/VL_EingebetteteSysteme/blob/dev/01_HistorischerUeberblick.md)

Die Unterlagen selbst sind in der Auszeichnungsprache LiaScipt verfasst und öffentlich verfügbar.

****************************************************************************

                         {{1-2}}
****************************************************************************

Markdown ist eine Auszeichnungssprache für die Gliederung und Formatierung von Texten und anderen Daten. Analog zu HTML oder LaTex werden die Eigenschaften und Organisation von Textelementen (Zeichen, Wörtern, Absätzen) beschrieben. Dazu werden entsprechende "Schlüsselworte", die sogenannten Tags, verwendet.

Markdown wurde von John Gruber und Aaron Swartz mit dem Ziel entworfen, die Komplexität der Darstellung so weit zu reduzieren, dass schon der Code sehr einfach lesbar ist. Als Auszeichnungselemente werden entsprechend möglichst kompakte Darstellungen genutzt.

```markdown HelloWorld.md
# Überschrift

__eine__ Betonung __in kursiver Umgebung__

* Punkt 1
* Punkt 2

Und noch eine Zeile mit einer mathematischen Notation $a=cos(b)$!
```

----------------------------------------------------------------------------<h1>Überschrift</h1>
<i>eine <em>Betonung</em> in kursiver Umgebung</i>
<ul>
<li>Punkt 1</li>
<li>Punkt 2</li>
</ul>
Und noch eine Zeile mit einer mathematischen Notation $a=cos(b)$!

----------------------------------------------------------------------------

Eine gute Einführung zu Markdown finden Sie zum Beispiel unter:

* [MarkdownGuide](https://www.markdownguide.org/getting-started/)
* [GitHubMarkdownIntro](https://guides.github.com/features/mastering-markdown/)

Mit einem entsprechenden Editor und einigen Paketen macht das Ganze dann auch Spaß.

* Wichtigstes Element ist ein Previewer, der es Ihnen erlaubt "online" die Korrektheit der Eingaben zu prüfen
* Tools zur Unterstützung komplexerer Eingaben wie zum Beispiel der Tabellen (zum Beispiel für Atom mit [markdown-table-editor](https://atom.io/packages/markdown-table-editor))
* Visualisierungsmethoden, die schon bei der Eingabe unterstützen
* Rechtschreibprüfung (!)

****************************************************************************


                                 {{2-3}}
****************************************************************************

Allerdings vermisst Markdown trotz seiner Einfachheit einige Features, die
für die Anwendbarkeit in der (Informatik-)Lehre sprechen:

* Ausführbarer Code
* Möglichkeiten zur Visualisierung
* Quizze, Tests und Aufgaben
* Spezifische Tools für die Modellierung, Simulationen etc.

```cpp     ArduinoSimulator.ino
void setup() {
  Serial.println("Hello stuff.");
}

void thing(char i) {
  switch(i) {
  case 0: Serial.println("a pear"); break;
  case 1: Serial.println("an apple"); break;
  case 2: Serial.println("an elephant"); break;
  case 3: Serial.println("an arduino"); break;
  }
}

void loop() {
  Serial.print("here's ");
  thing(random(4));
}
```
@NetSwarm.loop

??[Simulation: Noninverting Amplifier](https://www.falstad.com/circuit/circuitjs.html?ctz=CQAgzCAMB0l3BWEA2aB2ATAFi2TXIBODMARjUJAQA4Q0rIqBTAWlNICgBDEUyLFAPLJBvRkkZ94cFNCyEFipUqixk0uBlKF1yMGGpCN3MUNIZeaEewt8qUMRqpzlrhfRiR1GrTq-7DR3gTPiF1S2twuwkg+BAsFzdlWk9vaV9dAKNpEP4QDEhaYXzCsXtJDUYwRKTFag81Soz-A2zgnlD8hGsrLutxBylpfJrahVUvJu1M1tjIXIEwPOKlo3K5yVGxkVSpvz1ZobgF8ARbXrAzspijmRh5MZVdn2mWwNuOACc6C1pMKh2DHm33+3R+pkGwRBtjy-1IVwqx2hvCu-wKjERwPB6OxWBSQS+uL+FgwOkhSOxZP+YBw5Kx1Np1OIDgQxwASuDaGBfg5GAQ6LzVAgOAB3cFgzpg+ZiuHLOUCaXg+EwoQI0XYmSdHGKtF4iHYFLqtFkrVknUWGlGRa0xWdWVCApQdWdcwVMKGsUu5BFPJaHbO32kfoCDDIBUBkNhiFkCy2vIx6PhOMCe35cMcrVCQLYBwCVngdBIapoGIwYUAc3BYGZ-wIGKd8JD1C53tOFtbpAF4mdFyuK2ZtouzIwzfAA57IlWvECU9tM+WM8Cc8W2dHs0HIgwEuHUudO+szLw-s9h96I65vQ3JVoOIKHpKjDvD-ArcVOLArfPL-vxSDj9Kf5OmKT6AU+H4YuqYHhF+4FAREvDmPkQYIbGkHITYSGTmqwHIZcJJrth8FRhgOZRm+pEhjmlpwSR1pNlyNocI2+TUI+ZJ4fkJrgCyzrzk2VR5G+rGcZueqkseLGPqOW6bqOb5iWSBrXjRYmlLepRvmCX4yShNESohfq6fJN6lBxT6KhxH5clc3L3mZplXKG4ZYNo4BnlGWBaWR4DqmZUZHvkZG+Y57FnmawUWiObmTlF8wAPbgFUsbxEQPoTPAhBWN0W4OBaVQcAlyBFslBCELQCCwHANKKGgDxlSklWQJ2nYWEVPmFTFuapeUjVEFlyA5S1KCTgVKD0NyXVlT10iZUVA1IENyDjRwQA)

Eine Reihe von Einführungsvideos findet sich unter [Youtube](https://www.youtube.com/channel/UCyiTe2GkW_u05HSdvUblGYg). Die Dokumentation von LiaScript ist hier [verlinkt](https://liascript.github.io/course/?https://raw.githubusercontent.com/liaScript/docs/master/README.md#1)

***************************************************************************

## Trotz Simulation und Virtuellem ...

... braucht es aber auch immer etwas zum anfassen.

> Blick hinter eine Arduino-Anwendung

## Wie können Sie zum Gelingen der Veranstaltung beitragen?

* Stellen Sie Fragen, seinen Sie kommunikativ!

> Hinweis auf dem OPAL Forum!

* Organisieren Sie sich in Arbeitsgruppen!

> Hinweis auf Repl.it

> Hinweis auf ThinkerCAD

* Bringen Sie sich mit Implementierungen in die Veranstaltung ein.

## Und wenn Sie dann immer noch programmieren wollen ...

Dann wartet das __racetech__ Team auf Sie ... autonomes Fahren im Formular Student Kontext.

![WALL-E](./images/00_Einfuehrung/RaceTech.jpg)<!--
style="width: 80%; display: block; margin-left: auto; margin-right: auto;" -->



## Hausaufgabe

+ Legen Sie sich einen GitHub Account an ... und seien Sie der erste, der einen Typo in den Unterlagen findet und diesen als _Contributer_ korrigiert :-)
