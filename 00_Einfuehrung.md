<!--

author:   Sebastian Zug & André Dietrich & Fabian Bär
email:    sebastian.zug@informatik.tu-freiberg.de & andre.dietrich@informatik.tu-freiberg.de & fabian.baer@student.tu-freiberg.de
version:  0.0.1
language: de
narrator: Deutsch Female

import: https://raw.githubusercontent.com/LiaTemplates/NetSwarm-Simulator/master/README.md

-->

# 00 - Einführung

**TU Bergakademie Freiberg - Wintersemester 2020 / 21**

Link auf die aktuelle Vorlesung im Versionsmanagementsystem GitHub

[https://github.com/TUBAF-IfI-LiaScript/VL_EingebetteteSysteme/blob/00_Einfuehrung](https://github.com/TUBAF-IfI-LiaScript/VL_EingebetteteSysteme/blob/dev/00_Einfuehrung)

Die interaktive Form ist unter diese Link zu finden ->
[TODO]( )

---------------------------------------------------------------------

```c HelloWorld.c
#define ANSWER_TO_LIFE 42

void setup() {
  Serial.begin(9600);
  Serial.println("Herzlich willkommen");

  volatile byte a;

  asm ("ldi %0, %1\n\t"
      : "=r" (a)
      : "M" (ANSWER_TO_LIFE));

  Serial.print("Antwort auf alle Fragen ist:");
  Serial.println(a);
}

void loop() {
}
```

                                    {{1-2}}
*******************************************************************************

| Name                 | Email                                      |
|:---------------------|:-------------------------------------------|
| Sebastian Zug        | sebastian.zug@informatik.tu-freiberg.de    |
| Dr. Martin Reinhardt | martin.reinhardt@informatik.tu-freiberg.de |


*******************************************************************************

## Zielstellung

                                    {{0-2}}
*******************************************************************************

**Worum geht's?**

**... alles was Sie schon immer über Computer wissen wollten (und nicht zu fragen wagten) ...**


+ Digitale Grundlagen der Arbeitsweise von Computerhardware
+ Vermittlung von Grundwissen für den Entwurf von Hardware
+ Hardwarenahe Programmierung
+ Grundlagen eingebetteter Systeme

*******************************************************************************

                                    {{1-2}}
*******************************************************************************

<!--
style="width: 80%; min-width: 420px; max-width: 720px;"
-->
```ascii

                Abstraktionsebenen

           +----------------------------+ -.
  Ebene 6  | Problemorientierte Sprache |  |
           +----------------------------+  |
                                            > Anwendungssoftware
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
                                             >Automaten, Speicher, Logik
           +----------------------------+   |
  Ebene 1  | Digitale Logik             |   |
           +----------------------------+  -.

           +----------------------------+
  Ebene 0  | E-Technik, Physik          |     Analoge Phänomene
           +----------------------------+                                      .
```

*******************************************************************************


### Konzept der Veranstaltung

                                    {{0-1}}
*******************************************************************************

Als Plattform für die Online Vorlesung nutzen wir eine lokale Instanz von BigBlueButton. Den zugehörigen Link finden Sie auf der OPAL Webseite des Kurses.

Die Vorlesung wird in der präsenzfreien Zeit auf folgendem zeitlichen Muster basieren:

<!--
style="width: 80%; min-width: 420px; max-width: 720px;"
-->
```ascii
               | Mittwoch   |     +-------------------------------------------+
vorangegangene | Donnerstag | <-- | Bis Donnerstag sind die Materialien       |
Woche          | Freitag    |     | der kommenden Woche auf github hinterlegt |
               | ...        |     +-------------------------------------------+
               |------------|
aktuelle       | Montag     |
Woche          | Dienstag   | <---- Einreichen der 7 Fragen mit Antworten
               | Mittwoch   | <-+   Rückmeldungen und Fragen via Issues
               |            |   |  +------------------------------------------+
                                +--| Online Vorlesung, die die Inhalte der    |
                                   | anhand Ihrer Rückmeldungen diskutiert    |
                                   +------------------------------------------+
```

Hierfür kombinieren wir:

* __asynchronen / synchrone Online-Vorlesungen__ - Im Rahmen der synchronen Vorlesungen werden die zentralen Elemente vorgestellt. Da es aber in der großen Runde an der Möglichkeit der Interaktion wie in einer echte Vorlesung fehlt, fokussieren wir uns auf den Termin am __Mittwoch um 7:30__.
* __offline Diskussionen und Fragen__ - Die Fragen zu den praktischen Lehrinhalten erörtern wir über das Softwareentwicklungstool github. Damit haben Sie die Möglichkeit Fragen von allgemeinem Interesse in einer großen Runde zu besprechen.
* __asynchronen Übungen / synchronen Übungen__ - Die Übungen bestehen aus selbständig zu bearbeitenden Aufgaben, wobei einzelne Lösungen in Videokonferenzen besprochen werden.

Wie bringen Sie sich ein?:

* __Sieben Minuten für sieben Fragen__ ... Einbettung einer studentischen Zusammenfassung in jeden Foliensatz. Wir organisieren Sie in Gruppen von 2 Studenten, die zu Beginn jeder Veranstaltung die zentralen Aspekte der  vorangegangen Vorlesung komprimiert darstellt. __10 dieser Fragestellungen werden Eingang in die Klausur finden.__
* __Allgemeine Fragen/Antworten__ ... Dabei können Sie sich über github in die Diskussion einbringen.
* __Rückmeldungen/Verbesserungsvorschläge zu den Vorlesungsmaterialien__ ... *"Das versteht doch keine Mensch!"* ... dann korrigieren Sie uns. Alle Materialien sind Open Source. Senden Sie mir einen Pull-Request und werden Sie Mitautor.
* __Praktischen Übungsaufgaben__ ... Wir werden die Übungsaufgaben über die Plattform GitHub abwickeln und einzelne Aspekte dann in der Vorlesung/ Übungen besprechen.

Die Übungen beginnen in der Woche zum XXX. April! Dafür werden wir Aufgaben vorbereiten, mit denen die Inhalte der Vorlesung vertieft werden. Wir motivieren Sie sich dafür ein Gruppen von 2 oder 3 Studierenden zu organisieren. Die genauen Modalitäten werden noch bekannt gegeben.

*******************************************************************************


                                    {{3-4}}
*******************************************************************************

**Zeitaufwand und Engagement**

Mit der Veranstaltung verdienen Sie sich 6CP. Eine Hochrechnung mit der von der
Kultusministerkonferenz vorgegebenen Formel 1CP = 30 Zeitstunden bedeutet,
dass Sie dem Fach im Mittel über dem Semester __180 Stunden__ widmen sollten ...
entsprechend bleibt neben den Vorlesungen und Übungen genügend Zeit für die
Vor- und Nachbereitung der
Lehrveranstaltungen, die eigenständige Lösung von Übungsaufgaben sowie die
Prüfungsvorbereitung.

*"Erzähle mir und ich vergesse. Zeige mir und ich erinnere. Lass es mich tun und ich verstehe."*

(Konfuzius, chin. Phiolsoph 551-479 v. Chr.)

**Wie können Sie zum Gelingen der Veranstaltung beitragen**

* Stellen Sie Fragen, seinen Sie kommunikativ!
* Organisieren Sie sich in Arbeitsgruppen!
* Experimentieren Sie mit verschiedenen Entwicklungsumgebung um "Ihren Editor"
  zu finden
* Bringen Sie sich in studentischen Teams ein!

FOTO RCAP einfügen!

*******************************************************************************


                                    {{4-5}}
*******************************************************************************

**Literaturhinweise**

Literaturhinweise werden zu verschiedenen Themen als Links oder Referenzen
in die Unterlagen integriert.

Es existiert eine Vielzahl kommerzielle Angebote, die aber einzelne Aspekte
in freien Tutorial vorstellen. In der Regel gibt es keinen geschlossenen Kurs
sondern erfordert eine individuelle Suche nach spezifischen Inhalten.

| Medium         | Bemerkung                                                       | Links                                                                              |
| -------------- | --------------------------------------------------------------- | ---------------------------------------------------------------------------------- |
| Online Kurse   |   | |
|                |   | |
|                |   | |
| Videotutorials | How computers works?   | [Link](https://www.youtube.com/watch?v=cNN_tTXABUA) |
|                |   | |
| Bücher         | B. Becker, R. Drechsler, P. Molitor: Technische Informatik - Eine Einführung, Pearson Studium, 2005    | |
|                | David A. Patterson, John L. Hennessy: Computer Organization & Design    | |

*******************************************************************************

## Werkzeuge der Veranstaltung

Was sind die zentralen Tools unserer Veranstaltung?

* _???? Vorlesungstool_ -> BigBlueButton [Introduction](https://www.youtube.com/watch?v=uYYnryIM0Uw)
* _Entwicklungsplattform [GitHub](https://github.com/)_
* _Beschreibungssprache für Lerninhalte_ [LiaScript](https://liascript.github.io/)
* _Entwicklungsumgebung / Editor + Kompiler_

*******************************************************************************

### Markdown und LiaScript

                                 {{0-1}}
****************************************************************************

Markdown ist eine Auszeichnungssprache für die Gliederung und Formatierung von Texten und anderen Daten. Analog zu HTML oder LaTex werden die Eigenschaften und Organisation von Textelementen (Zeichen, Wörtern, Absätzen) beschrieben. Dazu werden entsprechende "Schlüsselworte", die sogenannten Tags verwandt.

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

Eine gute Einführung zu Markdown finden Sie zum Beispiel unter

* [MarkdownGuide](https://www.markdownguide.org/getting-started/)
* [GitHubMarkdownIntro](https://guides.github.com/features/mastering-markdown/)

Mit einem entsprechenden Editor und einigen Paketen macht das Ganze dann auch Spaß

* Wichtigstes Element ist ein Previewer, der es Ihnen erlaubt "online" die Korrektheit der Eingaben zu prüfen
* Tools zur Unterstützung komplexerer Eingaben wie zum Beispiel der Tabellen (zum Beispiel für Atom mit [markdown-table-editor](https://atom.io/packages/markdown-table-editor))
* Visualisierungsmethoden, die schon bei der Eingabe unterstützen
* Rechtschreibprüfung (!)

****************************************************************************


                                 {{1-2}}
****************************************************************************

Allerdings vermisst Markdown trotz seiner Einfachheit einige Features, die
für die Anwendbarkeit in der (Informatik-)Lehre sprechen:

* Ausführbarer Code
* Möglichkeiten zur Visualisierung
* Quizze Tests und Aufgaben
* spezifische Tools für die Modellierung Simulation etc.

```
@startuml

abstract class AbstractList
abstract AbstractCollection
interface List
interface Collection

List <|-- AbstractList
Collection <|-- AbstractCollection

Collection <|- List
AbstractCollection <|- AbstractList
AbstractList <|-- ArrayList

class ArrayList {
  Object[] elementData
  size()
}

enum TimeUnit {
  DAYS
  HOURS
  MINUTES
}

annotation SuppressWarnings

@enduml
```
@plantUML.eval

Eine Reihe von Einführungsvideos findet sich unter [Youtube](https://www.youtube.com/channel/UCyiTe2GkW_u05HSdvUblGYg). Die Dokumentation von LiaScript ist hier [verlinkt](https://liascript.github.io/course/?https://raw.githubusercontent.com/liaScript/docs/master/README.md#1)

Für den [Atom](https://atom.io/)-Editor von GitHub sind zwei LiaScript Plugins verfügbar, die die Arbeit signifikant vereinfachen.

****************************************************************************

### Github

Link zum GitHub des Kurses

[https://github.com/TUBAF-IfI-LiaScript/VL_EingebetteteSysteme](https://github.com/TUBAF-IfI-LiaScript/VL_EingebetteteSysteme)


## Aufgaben

1. Legen Sie sich einen GitHub Account an und experimentieren Sie damit.
