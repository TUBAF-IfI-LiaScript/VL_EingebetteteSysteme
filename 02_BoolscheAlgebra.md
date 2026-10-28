<!--

author:   Sebastian Zug & André Dietrich & Fabian Bär & Copilot & Claude Code (Opus 5.5)
email:    sebastian.zug@informatik.tu-freiberg.de & andre.dietrich@informatik.tu-freiberg.de & fabian.baer@student.tu-freiberg.de
version:  0.1.0
language: de
narrator: Deutsch Female

import:   https://raw.githubusercontent.com/LiaTemplates/DigiSim/master/README.md
          https://raw.githubusercontent.com/liaTemplates/AVR8js/main/README.md
          https://raw.githubusercontent.com/TUBAF-IfI-LiaScript/VL_EingebetteteSysteme/master/config.md
          
-->

[![LiaScript](https://raw.githubusercontent.com/LiaScript/LiaScript/master/badges/course.svg)](https://liascript.github.io/course/?https://raw.githubusercontent.com/TUBAF-IfI-LiaScript/VL_EingebetteteSysteme/master/02_BoolscheAlgebra.md#1)

# Boolesche Algebra

| Parameter                | Kursinformationen                                                                                                                                                                          |
| ------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| **Veranstaltung:**       | @config.lecture                                                                                          |
| **Semester:**            | @config.semester                                                                                         |
| **Hochschule:**          | `Technische Universität Freiberg`                                                                        |
| **Inhalte:**             | `Boolesche Algebra, Axiome, Schaltfunktionen und technische Realisierung`                              |
| **Link auf GitHub:**     | https://github.com/TUBAF-IfI-LiaScript/VL_EingebetteteSysteme/blob/master/02_BoolscheAlgebra.md        |
| **Autoren:**             | @author                                                                                                  |

![](https://media.giphy.com/media/10PNyg7YOcaBQA/giphy-downsized.gif)

---------------------------------------------------------------------

**Fragen an die Veranstaltung**

+ Nennen Sie die Axiome der Booleschen Algebra.
+ Erläutern Sie das Dualitätsprinzip der Booleschen Algebra.
+ Wie viele Schaltfunktionen existieren für 2 Eingangsvariablen?
+ Nennen Sie 3 Beispiele, wie eine Schaltfunktion technisch umgesetzt werden kann.
+ Wie viele Zeilen hat die Wahrheitstafel einer Schaltfunktion mit $n$ Eingängen?
+ Geben Sie das de Morgansche Gesetz wieder.
+ Wie schreiben Sie eine Boolesche Funktion als Bedingung in C, und wie hilft die De Morgan'sche Regel beim Umformen?

<!-- kurslandkarte:knopf-start -->

<a href="https://tubaf-ifi-liascript.github.io/VL_EingebetteteSysteme/kurslandkarte/#termin=2" style="display: inline-block; padding: 0.5em 1.1em; background-color: #00718A; color: #ffffff; text-decoration: none; font-family: 'IBM Plex Sans', 'Segoe UI', system-ui, sans-serif; font-weight: 600;">🗺️ Diese Vorlesung in der Kurslandkarte →</a>

<!-- kurslandkarte:knopf-ende -->

---------------------------------------------------------------------

## Rückblick: Hausaufgabe aus Vorlesung 01

    --{{0}}--
Zuerst die Auflösung der Hausaufgabe aus der letzten Vorlesung. Beim Vergleich von Z1 und Z3 lohnt ein genauer Blick: Die Architektur ist dieselbe, nur die Bauelemente wechseln von Blechplatten zu Relais. Genau diese Trennung zwischen dem logischen Entwurf und seiner technischen Umsetzung zieht sich durch die heutige Vorlesung. Zuerst beschreiben wir mit der Booleschen Algebra, was eine Schaltung tun soll, danach betrachten wir, womit man sie baut.

**Z1 und Z3.** Beide Rechner von Konrad Zuse arbeiten binär mit Gleitkommazahlen und lesen ihr Programm von einem gelochten Filmstreifen. Die Z1 (1938) ist rein mechanisch aufgebaut: Verschiebbare Blechplatten speichern und verknüpfen die Bits. Sie lief mit etwa 1 Hz und arbeitete nie zuverlässig, weil sich die Bleche verklemmten. Die Z3 (1941) setzt dieselbe Architektur mit rund 2000 Relais um – ein Relais ist ein elektrisch betätigter Schalter. Damit wurde sie schneller und vor allem zuverlässig.

**„Bug“.** Der Begriff für einen technischen Fehler ist älter als der Computer; Thomas Edison benutzte ihn schon in den 1870er-Jahren. Bekannt wurde eine Episode von 1947: Im Relaisrechner Harvard Mark II fand das Team um Grace Hopper eine Motte, die ein Relais blockierte, und klebte sie mit dem Vermerk „First actual case of bug being found“ ins Logbuch.

> Heute geht es genau um die Bausteine, aus denen die Z3 bestand: Schalter, die nur zwei Zustände kennen – und die Mathematik, mit der man sie beschreibt.

## Digital vs. Analog

    --{{0}}--
Im Schichtenmodell aus der ersten Vorlesung stehen wir jetzt auf Ebene eins, der digitalen Logik. Darunter liegt die Physik mit Spannungen und Strömen, die sich stetig ändern. Die Frage lautet also, wie aus einer stetigen physikalischen Größe die Nullen und Einsen werden, mit denen alle Ebenen darüber arbeiten.

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
  Ebene 4  | Betriebssystem             |     Systemsoftware (fehlt beim ATmega328P)
           +----------------------------+

           +----------------------------+
  Ebene 3  | Instruktionsset            |     Maschinensprache
           +----------------------------+

           +----------------------------+  -.
  Ebene 2  | Mikroarchitektur           |   |
           +----------------------------+   |
                                            ⎬ Automaten, Speicher, Logik
           +----------------------------+   |       ╔═══════════════╗
  Ebene 1  | Digitale Logik             |   |    ◀══║ HIER SIND WIR!║
           +----------------------------+  -.       ╚═══════════════╝
                         ▲  Übergang analog → digital:
                         ║  Abtastung, Quantisierung, Pegel
           +----------------------------+
  Ebene 0  | E-Technik, Physik          |     Analoge Phänomene
           +----------------------------+                                      .
```

> __Frage:__ Was bedeutet der Übergang von der Ebene der physikalischen Phänomene (0) auf die Ebene der digitalen Logik (1)?

    --{{1}}--
Ein Digitalsignal entsteht in zwei Schritten, und beide verwerfen Information. Die Abtastung legt fest, wann gemessen wird, die Quantisierung, wie fein die Werte unterschieden werden. Im Diagramm sehen Sie das an der gestrichelten Treppe: Zwischen den Abtastzeitpunkten ist nichts bekannt, und aus sechs Komma zwei Volt und sechs Komma vier Volt wird beide Male sechs Volt. Drei Bit genügen für acht Stufen, denn zwei hoch drei ist acht.

                              {{1}}
********************************************************************************

Ein Analogsignal beschreibt den zeitlich kontinuierlichen Verlauf einer physikalischen Größe; es kann zu jedem Zeitpunkt jeden Wert annehmen:

+ Temperatur im Tagesverlauf
+ Spannungswert am IC innerhalb der letzten $n$ Nanosekunden
+ ...

Ein Digitalsignal entsteht daraus in zwei Schritten:

+ **Abtastung** – der Wert wird nur zu bestimmten Zeitpunkten erfasst (zeitdiskret),
+ **Quantisierung** – jeder Messwert wird auf eine von endlich vielen Stufen gerundet (wertdiskret).

Die Stufen werden als Binärzahlen kodiert; die Auflösung der Quantisierung gibt man deshalb in Bit an. Im Diagramm wird ein Signal alle 1 ms abgetastet und auf ganze Volt gerundet, das entspricht einem Wandler mit 3 Bit (8 Stufen von 0 bis 7 V). Wie der Analog-Digital-Wandler im ATmega328P das macht, sehen Sie in Vorlesung 13.

<lia-chart
option='{
  "legend": {"data": ["analoges Signal", "abgetastet und quantisiert"]},
  "xAxis": {
    "type": "category",
    "data": ["0","1","2","3","4","5","6","7","8","9","10"],
    "name": "Zeit in ms"
  },
  "yAxis": [{
    "type": "value",
    "name": "Spannung in V",
    "max": 7
  }],
  "series": [
  {
    "name": "analoges Signal",
    "data": [2.0, 3.6, 5.1, 6.2, 6.4, 5.5, 3.8, 2.2, 1.1, 0.9, 1.7],
    "type": "line",
    "smooth": "true",
    "showSymbol": false
  },
  {
    "name": "abgetastet und quantisiert",
    "data": [2, 4, 5, 6, 6, 6, 4, 2, 1, 1, 2],
    "type": "line",
    "step": "start",
    "lineStyle": {"width": "2", "type": "dashed"}
  }]
}'></lia-chart>

Die Abtastung und Bildung des Digitalsignals erfolgt üblicherweise in konstanten Zeitintervallen, allerdings ist dies nicht zwingend notwendig.

********************************************************************************

### Exkurs: Kontrastprogramm - Analoge Rechner

    --{{0}}--
Als Kontrast ein Rechner, der gar nicht digitalisiert. Im Analogrechner stellt eine Spannung die Rechengröße direkt dar; Addieren und Integrieren übernehmen Verstärkerschaltungen mit Widerständen und Kondensatoren. Programmiert wird durch Stecken von Verbindungen, abgelesen am Oszilloskop oder am Schreiber.

![Meda42](./images/02_BoolscheAlgebra/Analogrechner_MEDA_42TA.jpg "Analogrechner MEDA 42TA Aritma Prag Wuselig, Deutsch: Analogrechner MEDA 42TA Aritma Prag, Tschechoslowakei, um 1970, https://commons.wikimedia.org/wiki/File:Analogrechner_MEDA_42TA-DSC4445.jpg")<!-- width="50%" -->

Die Eingabe erfolgte durch Verbinden der Komponenten mittels Programmierschnüren, Steckern und Rechenimpedanzen (Widerstände für die Summatoren und Integratoren) auf der Programmiertafel.

> [!WARNING] Typische Fehlvorstellung
> „Der ENIAC wurde mit Steckern programmiert, also war er ein Analogrechner.“ Das Stecken erinnert an den Analogrechner, aber der ENIAC rechnete digital – mit Ziffern, nicht mit Spannungen als Rechengröße.

Zur Auswertung stand zur Verfügung:

+ 6-Strahl-Oszilloskop OPD 280 U
+ X-Y-Schreiber BAK 5 T
+ Digitalvoltmeter

    --{{0}}--
Die Tabelle zeigt den Preis der analogen Technik: Jede Temperaturänderung und jede Bauteiltoleranz verfälscht das Ergebnis unmittelbar. Ein Digitalsignal verträgt dagegen kleine Abweichungen, solange eindeutig bleibt, ob null oder eins gemeint ist. Wie groß diese Abweichungen sein dürfen, klären wir auf der nächsten Folie.

|           | Analoge Hardware                                 | Digitale Hardware                        |
| --------- | ------------------------------------------------ | ---------------------------------------- |
| Vorteile  | Multiplikation und Addition einfach realisierbar | unempfindlich gegen Störungen (Rauschen) |
|           | vergleichsweise schnell                          | einfacher Entwurf                        |
|           |                                                  | beliebig hohe Präzision möglich          |
| Nachteile | Temperaturabhängigkeit                           | vergleichsweise hoher Energieverbrauch   |
|           | nichtlineare Bauteile                            |                                          |
|           | Präzision durch Bauteiltoleranzen begrenzt       |                                          |
|           | Langzeitspeicherung von Daten schwierig          |                                          |

> Digitaltechnik ermöglicht eine einfache Realisierung robuster Hardware.

### Pegel

    --{{0}}--
Ein digitaler Baustein muss jede Spannung eindeutig als null oder eins deuten. Deshalb legt jeder Standard zwei erlaubte Bereiche fest, Low unten und High oben, und dazwischen einen verbotenen Bereich, für den nichts garantiert wird. Lesen Sie das Diagramm spaltenweise: Für jeden Baustein steht links, was ein Eingang akzeptiert, und rechts, was ein Ausgang liefert. Vergleichen Sie beide Spalten, bevor Sie die Frage beantworten.

{{0}}
<section>

> Digitalisierung: Aufteilung des kontinuierlichen Spektrums in erlaubte und verbotene Bereiche

Verschiedene Standards definieren unterschiedliche Spannungsbereiche für einen High- und einen Low-Pegel. Dazwischen befindet sich der verbotene Bereich. Links sehen Sie klassische TTL-Gatter, rechts die Werte des ATmega328P bei 5 V Versorgung aus dessen Datenblatt[^ATmega].

<!--
style="width: 80%; min-width: 420px; max-width: 720px;"
-->
```ascii
         TTL-Logikgatter (5 V)        ATmega328P (CMOS, 5 V)

         ^                            ^
Spannung |   |5.0|    |   |           |   |5.0|    |   |
V        |   |   |    |   |           |   |   |    |4.2|
         |   |   |    |   |           |   |3.0|    +---+
         |   |   |    |2.4|           |   +---+
         |   |2.0|    +---+           |
         |   +---+                    |   Verbotener Bereich
         |                            |
         |   Verbotener Bereich       |   +---+
         |                            |   |1.5|
         |   +---+                    |   |   |    +---+
         |   |0.8|    +---+           |   |   |    |0.9|
         |   |   |    |0.4|           |   |   |    |   |
         +------------------------>   +------------------------>
            Eingang  Ausgang             Eingang  Ausgang        .
```


> **Frage:** Warum ist der verbotene Bereich am Eingang schmaler als am Ausgang?

</section>

    --{{1}}--
Entscheidend ist die Asymmetrie: Ein Ausgang verspricht mehr, als ein Eingang verlangt. Beim ATmega328P liefert ein Ausgang im High-Zustand mindestens vier Komma zwei Volt, ein Eingang erkennt aber schon ab drei Volt sicher High. Die Lücke von eins Komma zwei Volt ist die Reserve für Spannungsabfälle auf Leitungen und für Störungen. Für Low gilt dasselbe: Der Ausgang liefert höchstens null Komma neun Volt, der Eingang akzeptiert bis eins Komma fünf Volt.

{{1}}
<section>

Ein Ausgang garantiert engere Grenzen, als ein Eingang verlangt. Bei TTL liefert ein Ausgang im High-Zustand mindestens 2,4 V, ein Eingang erkennt aber schon ab 2,0 V sicher High. Die Differenz von 0,4 V heißt **Störabstand**: So viel darf das Signal auf dem Weg durch Leitungen und Störungen verlieren, ohne falsch erkannt zu werden. Beim ATmega328P sind es im High-Bereich 4,2 V − 3,0 V = 1,2 V, im Low-Bereich 1,5 V − 0,9 V = 0,6 V.

**Ein Sensor liefert 2,0 V an einen digitalen Eingang des ATmega328P (5 V). Was liest `digitalRead()`?**

[( )] sicher `LOW`
[( )] sicher `HIGH`
[(X)] nicht vorhersagbar – die Spannung liegt im verbotenen Bereich
***************************************************************

2,0 V liegt zwischen 1,5 V und 3,0 V. Das Datenblatt garantiert dort weder Low noch High; das Ergebnis kann sich sogar von Messung zu Messung ändern.

***************************************************************

</section>

    --{{2}}--
Die Tabelle vergleicht drei Techniken, mit denen man Schalter baut: das Relais wie in der Z3, die bipolare TTL-Technik und die CMOS-Technik heutiger Mikrocontroller. Von links nach rechts werden die Schalter schneller, kleiner und sparsamer; galvanisch getrennt ist nur das Relais. Für Ihre Praxis wichtig ist die Zeile zur Störempfindlichkeit: Ein offener CMOS-Eingang hat keinen definierten Pegel, deshalb braucht ein Taster einen Pull-up-Widerstand.

     {{2}}
***************************************************************

<!-- data-type="none" -->
| Kriterium / Technologie | **Mechanisches Relais** | **TTL (Transistor-Transistor-Logik)** | **CMOS, z. B. Eingang des ATmega328P** |
|--------------------------|-------------------------|---------------------------------------|------------------------------------|
| **Funktionsprinzip** | Mechanischer Schalter mit elektromagnetischer Betätigung | Bipolare Transistorstufen (meist NPN) | MOSFET-Gatter mit hochohmigem Gateeingang |
| **Schaltzeit** | 5–20 ms | 10–50 ns | < 10 ns (intern) |
| **Stromverbrauch (aktiv)** | 100–500 mW | einige mW pro Gatter | < 1 µW (Eingang), wenige mW aktiv gesamt |
| **Eingangswiderstand** | < 1 kΩ (Spule) | ca. 1 kΩ | sehr hoch, Leckstrom ≤ 1 µA |
| **Schaltspannung (High)** | Abhängig von Spulenspannung (5–24 V üblich) | ≥ 2,0 V (bei 5 V Versorgung) | ≥ 0,6 × V<sub>CC</sub> (3,0 V bei 5 V) |
| **Schaltspannung (Low)** | 0 V | ≤ 0,8 V | ≤ 0,3 × V<sub>CC</sub> (1,5 V bei 5 V) |
| **Lebensdauer (Schaltzyklen)** | 10⁵ – 10⁷ | theoretisch unbegrenzt (keine Mechanik) | unbegrenzt (Halbleiter) |
| **Größe** | cm-Bereich | mm-Bereich (IC) | µm-Bereich (integriert) |
| **Isolation** | Galvanisch getrennt | Keine galvanische Trennung | Keine galvanische Trennung |
| **Empfindlichkeit gegenüber Störungen** | Gering | Mittel | Hoch, wenn der Eingang offen ist |
| **Kosten** | Hoch (0,5 – 2 €) | Mittel (Cent-Bereich pro Gatter) | Niedrig (Millionen Gatter pro Chip) |
| **Typische Anwendung** | Schaltsignale in Industrie oder Leistungselektronik | Klassische Logikschaltungen | Eingänge von Mikrocontrollern, integrierte Logiksysteme |

> **Hochohmig** heißt: Der Eingang nimmt praktisch keinen Strom auf. Ist er mit nichts verbunden, „schwebt“ seine Spannung und fängt jede Störung ein. Deshalb braucht ein Taster am ATmega328P einen Pull-up-Widerstand (Vorlesung 00): Er legt den offenen Eingang definiert auf High.

> Galvanische Trennung bedeutet, dass **kein direkter elektrischer Leiter** zwischen zwei Schaltungsteilen besteht. Die Information wird über andere physikalische Effekte übertragen, z. B.: Licht, Magnetfelder oder kapazitive Kopplung.

***************************************************************

## Motivation

    --{{0}}--
Bevor wir rechnen, ein Blick auf den einfachsten digitalen Baustein, den Schalter. Er kennt nur zwei Zustände, offen und geschlossen, und die Lampe folgt ihm. Was in den ersten Millisekunden nach dem Umschalten passiert, etwa das Prellen der Kontakte, blenden wir bewusst aus; uns interessiert nur der Zustand danach.

Nehmen wir folgende einfache Schaltung an:

![Stromkreis mit Batterie, einem Schalter und einer Lampe](./images/02_BoolscheAlgebra/Circut.png)<!-- width="60%" -->

Wir betrachten den Schalter mit seinen 2 Zuständen als Input und die Glühlampe als Output. Das Übergangsverhalten wird ignoriert.

| Input                | Output               |
| -------------------- | -------------------- |
| Schalter geschlossen | Lampe leuchtet       |
| Schalter offen       | Lampe leuchtet nicht |


    --{{1}}--
Mit zwei Schaltern entstehen die beiden Grundmuster, die Sie sprachlich schon kennen. In Reihe muss der Strom durch beide Schalter, die Lampe leuchtet also nur, wenn der erste und der zweite geschlossen sind. Parallel genügt ein geschlossener Weg, also der erste oder der zweite. Damit werden Und und Oder physikalisch greifbar.

                      {{1}}
****************************************************************
Für zwei Schalter (Inputs) lassen sich darauf aufbauend zwei grundlegende Schaltungsmuster entwerfen:

| Reihenschaltung | Parallelschaltung |
| --------------- | ----------------- |
| ![Zwei Schalter in Reihe](./images/02_BoolscheAlgebra/CircutSerial.png) <!-- width="80%" -->            | ![Zwei Schalter parallel](./images/02_BoolscheAlgebra/CircutParallel.png) <!-- width="80%" -->                    |
| Die Lampe leuchtet, wenn der erste und der zweite Schalter geschlossen werden               | Die Lampe leuchtet, wenn der erste oder der zweite Schalter (oder beide) geschlossen werden            |

****************************************************************

    --{{2}}--
Bei zwölf Schaltern hilft Hinschauen allein nicht mehr. Zählen Sie zuerst die Wege mit genau drei geschlossenen Schaltern und dann alle möglichen Stellungen; jeder weitere Schalter verdoppelt die Zahl der Kombinationen. Das Ergebnis zeigt, warum wir für Schaltungen Rechenregeln brauchen statt einer Liste aller Fälle.

{{2}}
<section>

![Netz aus zwölf Schaltern zwischen Batterie und Lampe](./images/02_BoolscheAlgebra/CircutComplex.png) <!-- width="80%" -->

**Mit genau drei geschlossenen Schaltern kann die Lampe leuchten. Auf wie viele Arten?**

[[6]]
***************************************************************

Von links bis zum Knoten in der Mitte braucht man mindestens zwei Schalter: einen aus dem oberen Paar und den Schalter rechts davon (2 Möglichkeiten) oder die beiden Schalter der unteren Reihe (1 Möglichkeit). Von dort zur Lampe genügt ein Schalter aus dem Paar rechts oben (2 Möglichkeiten). Das ergibt 3 · 2 = 6.

***************************************************************

**Wie viele Schalterstellungen gibt es insgesamt?**

[[4096]]
***************************************************************

Jeder der 12 Schalter ist offen oder geschlossen: $2^{12} = 4096$. Alle durchzuprobieren ist mühsam – das ist der Grund für die Abstraktion, die jetzt folgt.

***************************************************************

    --{{2}}--
Die Abstraktion ersetzt die Physik durch zwei Symbole, null und eins. Welche Spannung man eins nennt, ist eine Vereinbarung: Bei positiver Logik ist die hohe Spannung die Eins, bei negativer Logik die niedrige. Der Taster mit Pull-up-Widerstand ist ein solcher Fall, denn gedrückt liegt sein Eingang auf Low.

> Wir brauchen eine Abstraktion, um die Abbildung von digitalen Eingängen E auf einen digitalen Ausgang A repräsentieren und analysieren zu können.

Dazu beschreiben wir die Wirkung des elektrischen Stromes

+ Stromfluss / kein (oder ein sehr geringer) Stromfluss
+ Spannung / keine (oder eine sehr geringe) Spannung

... aus Sicht der Logik anhand von Zuständen

+ an / aus
+ wahr / falsch
+ 1 / 0

Welcher Spannung man die 1 zuordnet, ist eine Festlegung. Üblich ist **positive Logik**: hohe Spannung = 1. Bei **negativer Logik** (*active low*) steht die niedrige Spannung für „aktiv“. Ein Beispiel kennen Sie: Ein Taster mit Pull-up-Widerstand liefert gedrückt LOW.

> Wie aber können logische Grundverknüpfungen identifiziert werden? Auf welchem Wege lassen diese sich praktisch realisieren?

</section>

## Axiome und Gesetze

    --{{0}}--
Die Idee, Schlussfolgern in feste Regeln zu fassen, ist sehr alt; George Boole hat sie 1854 als Algebra formuliert. Den Schritt zur Technik machte Claude Shannon, als er zeigte, dass Relaisschaltungen genau diesen Regeln gehorchen. Seitdem kann man Schaltungen auf dem Papier vergleichen, umformen und vereinfachen, bevor man ein einziges Bauteil verdrahtet.

Historische Entwicklung:

+ Aristoteles (384-322 v.Chr.) begründet „Syllogistik“ Lehre von den logischen Schlussformen
+ Die Stoiker entwickeln daneben eine eigenständige Aussagenlogik; im Mittelalter führt die Scholastik beide Traditionen weiter.
+ George Boole (1815-1864) 1854 mathematische Formalisierung in _„An Investigation of the Laws of Thought on which are founded the Mathematical Theories of Logic and Probabilities"_.
+ Claude Shannon (1916-2001) zeigt in seiner Masterarbeit _„A Symbolic Analysis of Relay and Switching Circuits“_ (MIT 1937, veröffentlicht 1938), dass man Relaisschaltungen mit der Booleschen Algebra beschreiben und vereinfachen kann.

![Shannon](./images/02_BoolscheAlgebra/ClaudeShannon_MFO3807.jpg "Claude Shannon Jacobs, Konrad, Shannon, Claude, https://commons.wikimedia.org/wiki/File:ClaudeShannon_MFO3807.jpg")<!-- width="25%" -->

> Problem: Gibt es ein Verfahren:
>
> + um die Äquivalenz zweier Schaltungen formal nachzuweisen ?
> + um Schaltungen auf einfache Weise zu transformieren ?
> + um minimale Schaltungen zu entwerfen ?

__Lösung:__ Boolesche Algebra basierend auf den Vorarbeiten von G. Boole aus dem Jahre 1854

+ zwei Werte: 0 und 1
+ drei Operationen: die zweistelligen Verknüpfungen $+$ und $\cdot$ sowie die einstellige Negation $\overline{a}$
+ vier Axiome

    --{{0}}--
Für dieselben drei Operationen gibt es mehrere Schreibweisen. In dieser Vorlesung steht das Pluszeichen für Oder, der Malpunkt für Und und ein Strich über der Variablen für Nicht. Das Plus ist dabei kein Rechenplus, denn eins oder eins ergibt eins. In C haben dieselben Verknüpfungen eigene Operatoren, dazu mehr am Ende der Vorlesung.

<!-- data-type="none" -->
| Bedeutung | Schreibweise hier | Aussagenlogik | C          |
| --------- | ----------------- | ------------- | ---------- |
| ODER      | $a + b$           | $a \vee b$    | `a \|\| b` |
| UND       | $a \cdot b$ oder $ab$ | $a \wedge b$ | `a && b` |
| NICHT     | $\overline{a}$    | $\neg a$      | `!a`       |

> **Achtung:** $+$ ist hier kein Rechenplus. Es gilt $1 + 1 = 1$. Wie in der Schulmathematik bindet $\cdot$ stärker als $+$, und der Punkt darf entfallen: $ab + c = (a \cdot b) + c$.


Nach [Huntington](https://de.wikipedia.org/wiki/Edward_Vermilye_Huntington) ist eine Boolesche Algebra eine Menge $B$ mit zwei Verknüpfungen $+$ und $\cdot$, die für alle $a, b, c \in B$ die folgenden vier Axiome erfüllt. Ein Axiom ist eine Grundregel, die man nicht beweist; alles Weitere folgt daraus. Für Schaltungen genügt $B = \{0,1\}$, dort lassen sich alle Axiome an der Wertetabelle nachprüfen.

    --{{0}}--
Die vier Axiome treten jeweils als Paar auf, eine Zeile für Oder und eine für Und. Kommutativität erlaubt das Vertauschen, Distributivität das Ausmultiplizieren und Ausklammern, und zwar anders als in der Schulmathematik auch für Oder über Und. Null ist das neutrale Element für Oder, Eins das für Und. Das Komplement-Axiom schließlich sagt: a oder nicht a ergibt eins, a und nicht a ergibt null.

| Axiom                             | Definition |
| --------------------------------- | ---------- |
| Kommutativität                   | $\begin{aligned} a + b &= b + a \\ a \cdot b &= b \cdot a\end{aligned}$            |
| Distributivität                   | $\begin{aligned} a \cdot (b + c) &= (a \cdot b) + (a \cdot c) \\ a + (b \cdot c) &= (a + b) \cdot (a+c) \end{aligned}$            |
| Existenz neutraler Elemente       | $\begin{aligned}  0 + a &= a \\ 1\cdot a &= a\end{aligned}$           |
| Existenz von Komplementen         | zu jedem $a$ gibt es $\overline{a}$ mit $\begin{aligned}  a + \overline{a} &= 1 \\ a \cdot \overline{a} &= 0   \end{aligned}$      |

    --{{1}}--
Aus den vier Axiomen folgen alle weiteren Gesetze, man muss sie nicht zusätzlich annehmen. Besonders oft brauchen Sie später Idempotenz, Absorption und die De Morgan'sche Regel. De Morgan liest sich so: nicht, in Klammern a oder b, ist gleich nicht a und nicht b. Ein Nicht über einem ganzen Ausdruck negiert also jede Variable einzeln und macht aus Oder ein Und und umgekehrt.

                                    {{1}}
****************************************************************

Aus dieser Definition lassen sich die zugehörigen Gesetze der booleschen Algebra ableiten:

| Gesetz               | Definition                                                                                                                                 |
| -------------------- | ------------------------------------------------------------------------------------------------------------------------------------------ |
| Dominanz (Null- und Einselement) | $\begin{aligned} 1 + a &= 1 \\ 0 \cdot a &= 0\end{aligned}$                                                                     |
| Assoziativität       | $\begin{aligned} a + (b + c) &= (a + b) + c = a + b + c \\ a \cdot (b \cdot c) &= (a \cdot b) \cdot c = a \cdot b \cdot c\end{aligned}$    |
| Idempotenzgesetze    | $\begin{aligned} a + a &= a \\ a \cdot a &= a\end{aligned}$                                                                                |
| Absorptionsgesetz    | $\begin{aligned} a + (a \cdot b) &= a \\ a \cdot (a + b) &= a\end{aligned}$                                                                |
| Doppelnegation       | $\begin{aligned} a = \overline{\overline{a}}\end{aligned}$                                                                                 |
| De Morgan'sche Regel | $\begin{aligned} \overline{a + b} &= \overline{a} \cdot \overline{b} \\ \overline{a \cdot b} &= \overline{a} + \overline{b} \end{aligned}$ |

    --{{1}}--
Lesen Sie die Herleitung von links nach rechts; hinter jedem Gleichheitszeichen steht genau ein Axiom. Zuerst wird a oder a mit eins verknüpft, das erlaubt das neutrale Element, und dann wird diese Eins durch a oder nicht a ersetzt, das Komplement-Axiom rückwärts gelesen. Das Distributivgesetz fasst den Ausdruck zu a oder, in Klammern, a und nicht a zusammen. Die Klammer ist nach dem Komplement null, und a oder null ergibt a.

Wie so eine Ableitung aussieht, zeigt das Idempotenzgesetz – jeder Schritt verwendet genau ein Axiom:

$$
a + a = (a + a) \cdot 1 = (a + a)(a + \overline{a}) = a + a\overline{a} = a + 0 = a
$$

> **Für Vorerfahrene:** Leiten Sie ebenso $1 + a = 1$ und die De Morgan'sche Regel aus den vier Axiomen her. Hinweis für De Morgan: Zeigen Sie, dass $\overline{a}\,\overline{b}$ die beiden Komplement-Axiome für $a + b$ erfüllt, und begründen Sie, warum das Komplement eindeutig ist.

****************************************************************

    --{{2}}--
Das Dualitätsprinzip halbiert die Arbeit, denn die Gesetze kommen paarweise. Vertauschen Sie in einer gültigen Gleichung Und mit Oder sowie Null mit Eins, so erhalten Sie wieder eine gültige Gleichung. Die Tabelle zeigt solche Paare zeilenweise, etwa a oder nicht a ergibt eins und dual dazu a und nicht a ergibt null. Das funktioniert, weil schon die vier Axiome paarweise dual sind; jeder Beweis lässt sich deshalb Schritt für Schritt spiegeln.

                                     {{2}}
****************************************************************

> [!IMPORTANT] Merke
> **Dualitätsprinzip:** Zu jeder gültigen Gleichung der Booleschen Algebra gehört eine duale Gleichung, die ebenfalls gilt.

_Ersetzt man gleichzeitig in einem Axiom UND durch ODER und ODER durch UND sowie 1 durch 0 und 0 durch 1, so erhält man das zu diesem Axiom gehörige duale Axiom. Führt man diese Ersetzung in einem Theorem aus, so erhält man das zu diesem Theorem gehörige duale Theorem._

<!-- data-type="none" -->
| Form 1                 | Form 2                     |
| ---------------------- | -------------------------- |
| $0 + a = a$            | $1 \cdot a = a$            |
| $1 + a = 1$            | $ 0 \cdot a = 0        $   |
| $a + a = a$            | $ a \cdot a = a         $  |
| $a + \overline{a} = 1$ | $a \cdot \overline{a} = 0$ |

Am Beispiel des Distributivgesetzes

$$
\begin{aligned}
a \cdot (b+c) &= (a \cdot b)+(a \cdot c) \\
a+(b \cdot c) &= (a+b) \cdot (a+c)
\end{aligned}
$$


****************************************************************

## Anwendung

    --{{0}}--
Wozu das alles? Jeder Term einer Funktion wird später zu Gattern, und jedes eingesparte Gatter spart Chipfläche, Laufzeit und Energie. Im Beispiel wird zuerst a ausgeklammert; b oder nicht b ergibt eins, und a oder a und c ist nach dem Absorptionsgesetz einfach a. Die Variablen b und c haben auf das Ergebnis also gar keinen Einfluss.

                    {{0-1}}
****************************************************************

**Ziel der Umformung: Minimierung für die technische Realisierung**

> **Warum Minimierung?** Jeder Term wird später zu Gattern auf dem Chip. Weniger Terme und Variablen bedeuten weniger Gatter, weniger Fläche, kürzere Laufzeiten und geringeren Energieverbrauch. Auch der ATmega328P besteht intern aus solchen Gattern – sein Rechenwerk und sein Befehlsdekoder sind Schaltfunktionen (Vorlesung 10 und 11).

**Grundlegende Strategien zur Minimierung:** Nutze die Booleschen Gesetze zur schrittweisen Reduktion der Terme.

**Beispiel:** 

$a \cdot b + a \cdot \overline{b} + a \cdot c = a \cdot (b + \overline{b}) + a \cdot c = a \cdot 1 + a \cdot c = a + a \cdot c = a$ (Absorption!)

Aus drei Produkttermen wird eine einzige Variable.

****************************************************************

    --{{1}}--
Im ersten Beispiel steckt ein Kunstgriff. Der mittlere Term passt zu beiden Nachbarn: Mit dem ersten Term teilt er x eins und x zwei, mit dem dritten x eins und x drei. Weil a oder a wieder a ergibt, darf man ihn per Idempotenz verdoppeln, ohne die Funktion zu ändern. Eine Kopie verschmilzt dann mit dem ersten Term, die andere mit dem dritten, und es bleibt x eins x zwei oder x eins x drei.

                    {{1-2}}
****************************************************************

**Anwendungsbeispiel 1**

$$
\begin{aligned}
f(x_1, x_2, x_3) &= x_1 \cdot x_2 \cdot \overline{x_3} + x_1 \cdot x_2 \cdot x_3 + x_1 \cdot \overline{x_2} \cdot x_3 \\
&= x_1 \cdot x_2 \cdot \overline{x_3} +\textcolor{red}{x_1 \cdot x_2 \cdot x_3}  + x_1 \cdot x_2 \cdot x_3 + x_1 \cdot \overline{x_2} \cdot x_3 & \text{(Idempotenz)} \\
&= \textcolor{red}{x_1 \cdot x_2 \cdot ( \overline{x_3} + x_3)}  + x_1 \cdot x_2 \cdot x_3 + x_1 \cdot \overline{x_2} \cdot x_3 & \text{(Distributivität)} \\
&= x_1 \cdot x_2 \cdot ( \overline{x_3} + x_3)  + \textcolor{red}{x_1 \cdot x_3 \cdot x_2  + x_1  \cdot x_3 \cdot \overline{x_2}} & \text{(Kommutativität)} \\
&= x_1 \cdot x_2 \cdot ( \overline{x_3} + x_3)  + \textcolor{red}{x_1 \cdot x_3 \cdot (x_2  + \overline{x_2})} & \text{(Distributivität)} \\
&= x_1 \cdot x_2 \cdot \textcolor{red}{(1)}  + x_1 \cdot x_3 \cdot \textcolor{red}{(1)}  & \text{(Komplement)} \\
&= x_1 \cdot x_2  + x_1 \cdot x_3  & \text{(neutrales Element)}\\
\end{aligned}
$$

> **Bilanz:** Vorher drei UND-Gatter mit je drei Eingängen und ein ODER-Gatter mit drei Eingängen. Nachher zwei UND-Gatter und ein ODER-Gatter mit je zwei Eingängen. Ausgeklammert, $x_1(x_2 + x_3)$, genügen ein ODER- und ein UND-Gatter.

****************************************************************

    --{{2}}--
Das zweite Beispiel hat vier Variablen und fünf Terme. Suchen Sie zuerst Paare von Termen, die sich nur in einer einzigen Variablen unterscheiden, einmal negiert und einmal nicht. Solche Paare lassen sich zusammenfassen, und die betreffende Variable fällt heraus.

                    {{2-4}}
**Anwendungsbeispiel 2**

                    {{2-3}}
$$
\begin{aligned}
f(w,x,y,z) &=\overline{w}x\overline{y}\,\overline{z}+\overline{w}x\overline{y}z+w\overline{x}y\overline{z}+wx\overline{y}\,\overline{z}+wx\overline{y}z \\
\end{aligned}
$$

    --{{3}}--
Die Umformung fasst zweimal Paare zusammen, die sich nur in z unterscheiden, und danach die beiden Ergebnisse, die sich nur in w unterscheiden. Jedes Mal läuft dasselbe Muster ab: ausklammern, das Komplement ergibt eins, das neutrale Element lässt die Eins verschwinden. Der Term w, nicht x, y, nicht z hat keinen Partner und bleibt stehen. In der nächsten Vorlesung macht das KV-Diagramm solche Paare auf einen Blick sichtbar.

{{3-4}}
$$
\begin{aligned}
f(w,x,y,z) &=\overline{w}x\overline{y}\,\overline{z}+\overline{w}x\overline{y}z+w\overline{x}y\overline{z}+wx\overline{y}\,\overline{z}+wx\overline{y}z \\
&  =\overline{w}x\overline{y}\left(\overline{z}+z\right)+wx\overline{y}\left(\overline{z}+z\right)+w\overline{x}y\overline{z} & \text{(Kommutativität, 2 × Distributivität)}\\
 & =\overline{w}x\overline{y}\cdot 1+wx\overline{y}\cdot 1+w\overline{x}y\overline{z} & \text{(Komplement)}\\
 & =\overline{w}x\overline{y}+wx\overline{y}+w\overline{x}y\overline{z} & \text{(neutrales Element)}\\
 & =x\overline{y}\,\overline{w}+x\overline{y}w+w\overline{x}y\overline{z} & \text{(2 × Kommutativität)}\\
 & =x\overline{y}\left(\overline{w}+w\right)+w\overline{x}y\overline{z} & \text{(Distributivität)}\\
 & =x\overline{y}\cdot 1+w\overline{x}y\overline{z} & \text{(Komplement)}\\
 & =x\overline{y}+w\overline{x}y\overline{z} & \text{(neutrales Element)}
\end{aligned}
$$


{{3-4}}
> **Bilanz:** Vorher fünf Terme mit je vier Variablen, also fünf UND-Gatter mit vier Eingängen und ein ODER-Gatter mit fünf Eingängen. Nachher ein UND-Gatter mit zwei und eines mit vier Eingängen sowie ein ODER-Gatter mit zwei Eingängen.

    --{{4}}--
Im dritten Beispiel formen Sie selbst um. Gehen Sie von innen nach außen vor: Was ergibt die Klammer x eins oder nicht x eins, und was bewirken zwei Negationsstriche übereinander? Für den zweiten Term brauchen Sie die De Morgan'sche Regel.

{{4}}
**Anwendungsbeispiel 3**

{{4}}
$$
\begin{aligned}
f(x_1, x_2) &=\overline{\overline{\overline{x}_1 x_2(x_1 +\overline{x}_1)}}  + x_1\overline{x_2x_1} \\
\end{aligned}
$$

{{4}}
> Jetzt sind Sie dran! Die beiden äußeren Striche des ersten Terms reichen über den ganzen Ausdruck $\overline{x}_1 x_2(x_1 +\overline{x}_1)$. Welche Funktion ergibt sich?

{{4}}
<section>

[( )] $f = x_2$
[( )] $f = \overline{x}_1 x_2 + x_1 x_2$
[(X)] $f = \overline{x}_1 x_2 + x_1\overline{x}_2$, das exklusive ODER (XOR)
[( )] $f = 1$
***************************************************************

Probe mit der Wahrheitstafel: $f$ ist genau dann 1, wenn $x_1$ und $x_2$ verschieden sind. Diese Funktion heißt Antivalenz oder exklusives ODER, geschrieben $x_1 \oplus x_2$ (siehe die Tabelle der zweistelligen Funktionen weiter unten).

***************************************************************

</section>

    --{{5}}--
Die Lösung arbeitet den ersten Term von innen nach außen ab: Komplement, neutrales Element, Doppelnegation. Im zweiten Term löst De Morgan die Negation über x zwei und x eins auf, danach wird ausmultipliziert. Der entstehende Teilterm x eins und nicht x eins ist nach dem Komplement-Axiom null und fällt weg. Übrig bleiben genau die beiden Fälle, in denen x eins und x zwei verschieden sind, also das exklusive Oder.

{{5}}
$$
\begin{aligned}
f(x_1, x_2) &=\overline{\overline{\overline{x}_1 x_2(x_1 +\overline{x}_1)}}  + x_1\overline{x_2x_1} \\
&=\overline{\overline{\overline{x}_1 x_2 \cdot 1}}  + x_1\overline{x_2x_1} & \text{(Komplement: } x_1 +\overline{x}_1 = 1\text{)} \\
&=\overline{\overline{\overline{x}_1 x_2}}  + x_1\overline{x_2x_1} & \text{(Neutrales Element: } a \cdot 1 = a\text{)} \\
&=\overline{x}_1 x_2 + x_1\overline{x_2x_1} & \text{(Doppelnegation: } \overline{\overline{a}} = a\text{)} \\
&=\overline{x}_1 x_2 + x_1(\overline{x}_2 + \overline{x}_1) & \text{(De Morgan: } \overline{a \cdot b} = \overline{a} + \overline{b}\text{)} \\
&=\overline{x}_1 x_2 + x_1\overline{x}_2 + x_1\overline{x}_1 & \text{(Distributiv)} \\
&=\overline{x}_1 x_2 + x_1\overline{x}_2 + 0 & \text{(Komplement: } x_1\overline{x}_1 = 0\text{)} \\
&=\overline{x}_1 x_2 + x_1\overline{x}_2 & \text{(Neutrales Element: } a + 0 = a\text{)} \\
&=x_1 \oplus x_2 & \text{(Definition XOR: } a \oplus b = \overline{a}b + a\overline{b}\text{)} \\
\end{aligned}
$$

    --{{6}}--
Ein unübersichtlicher Ausdruck beschreibt hier am Ende eine einzige Grundfunktion. Ohne Umformung hätte man alle Negationen, Und- und Oder-Gatter einzeln verdrahtet. Ob sich ein Ausdruck vereinfachen lässt, sieht man ihm von außen selten an; deshalb lohnt das systematische Umformen.

{{6}}
> **Bilanz:** Aus einem Ausdruck mit fünf Negationen wird ein einziges XOR-Gatter.

## Schaltfunktionen

    --{{0}}--
Jetzt wechseln wir den Blickwinkel: Statt einzelner Ausdrücke betrachten wir Funktionen, die Bitmuster auf Bitmuster abbilden. Eine Funktion mit mehreren Ausgängen zerlegt man in mehrere Funktionen mit je einem Ausgang. Die Zahl zwei hoch zwei hoch n ergibt sich so: Die Wahrheitstafel hat zwei hoch n Zeilen, und jede Zeile kann unabhängig null oder eins sein. Ausdrücke und Schaltnetze gibt es für dieselbe Funktion viele, die Wahrheitstafel dagegen ist eindeutig.

+ Funktionen $f:\{0,1\}^n \rightarrow \{0,1\}^m$ mit $n, m \geq 1$ werden auch als Schaltfunktionen bezeichnet
+ Für $m = 1$, also $f:\{0,1\}^n \rightarrow \{0,1\}$, heißt die Schaltfunktion eine $n$-stellige Boolesche Funktion – in Worten: $n$ Eingänge, ein Ausgang, alles nur 0 oder 1
+ Jede Schaltfunktion $f:\{0,1\}^n \rightarrow \{0,1\}^m$ kann durch $m$ Boolesche Funktionen ausgedrückt werden
+ Jede Boolesche Funktion lässt sich beschreiben

  + durch eine Wahrheitstabelle / Wahrheitstafel 
  + durch einen booleschen Ausdruck (gebildet durch Boolesche Variablen und Operationen aus der Booleschen Algebra)
  + durch ein Schaltnetz aus logischen Gattern (ein Schaltnetz hat keinen Speicher; Schaltungen mit Speicher, sogenannte Schaltwerke, folgen ab Vorlesung 06)

+ Es gibt $2^{2^n}$ verschiedene $n$-stellige Boolesche Funktionen (also 16 zweistellige, 256 dreistellige, 65536 vierstellige, ...): Die Wahrheitstafel hat $2^n$ Zeilen, und in jeder Zeile kann $f$ den Wert 0 oder 1 haben.

> [!IMPORTANT] Merke
> Nur die Wahrheitstafel beschreibt eine Boolesche Funktion eindeutig. Zu jeder Funktion gibt es viele gleichwertige Ausdrücke und Schaltnetze.

    --{{1}}--
Ein Und-Term ist nur dann eins, wenn jeder seiner Faktoren eins ist. Eine Zeile der Tafel erhält also den Wert eins, sobald mindestens einer der fünf Terme für diese Belegung eins ergibt. Zählen Sie die Belegungen binär von null null null bis eins eins eins hoch, dann vergessen Sie keine.

{{1}}
> Stellen Sie eine Wahrheitstafel für folgende Schaltfunktion auf:

{{1}}
$$
\begin{aligned}
  f(x_1 , x_2, x_3) =&\overline{x}_1\cdot \overline{x}_2 \cdot \overline{x}_3 + \\
                     &\overline{x}_1\cdot \overline{x}_2 \cdot x_3 + \\
                     &x_1\cdot \overline{x}_2 \cdot x_3 + \\
                     &x_1\cdot x_2 \cdot \overline{x}_3 + \\
                     &x_1\cdot \overline{x}_2 \cdot \overline{x}_3 \\
\end{aligned}
$$

{{1}}
<section>

Bei drei Eingängen hat die Tafel $2^3 = 8$ Zeilen. Damit keine fehlt, zählen Sie die Eingänge binär von 000 bis 111 hoch. Tragen Sie für jede Zeile den Wert von $f$ ein:

[[0] [1]]
[( ) (X)] $x_1 x_2 x_3 = 000$
[( ) (X)] $x_1 x_2 x_3 = 001$
[(X) ( )] $x_1 x_2 x_3 = 010$
[(X) ( )] $x_1 x_2 x_3 = 011$
[( ) (X)] $x_1 x_2 x_3 = 100$
[( ) (X)] $x_1 x_2 x_3 = 101$
[( ) (X)] $x_1 x_2 x_3 = 110$
[(X) ( )] $x_1 x_2 x_3 = 111$

</section>

    --{{2}}--
Die Tafel zeigt den Zusammenhang in beiden Richtungen. Jeder Term der Funktion trifft genau eine Zeile, nämlich die, in der seine nicht negierten Variablen eins und seine negierten Variablen null sind. Umgekehrt gewinnt man aus jeder Tafel eine Funktion, indem man für jede Zeile mit eins den passenden Minterm bildet und alle mit Oder verknüpft. So lässt sich jede Wahrheitstafel in einen Ausdruck übersetzen, auch wenn dieser selten der kürzeste ist.

{{2}}
<!-- data-type="none" -->
| $x_1$ | $x_2$ | $x_3$ | f   | Term                                                      |
| ----- | ----- | ----- | --- | --------------------------------------------------------- |
| 0     | 0     | 0     | 1   | $\overline{x}_1\cdot \overline{x}_2 \cdot \overline{x}_3$ |
| 0     | 0     | 1     | 1   | $\overline{x}_1\cdot \overline{x}_2 \cdot x_3$            |
| 0     | 1     | 0     | 0   |                                                           |
| 0     | 1     | 1     | 0   |                                                           |
| 1     | 0     | 0     | 1   | $x_1\cdot \overline{x}_2 \cdot \overline{x}_3$            |
| 1     | 0     | 1     | 1   | $x_1\cdot \overline{x}_2 \cdot x_3$                       |
| 1     | 1     | 0     | 1   | $x_1\cdot x_2 \cdot \overline{x}_3$                       |
| 1     | 1     | 1     | 0   |                                                           |

{{2}}
Jeder Term der Funktion ist ein Produkt, in dem **jede** Variable genau einmal vorkommt – negiert oder nicht. Ein solcher Term heißt **Minterm**; er ist genau in einer Zeile der Tafel 1. Umgekehrt kann man aus jeder Wahrheitstafel die Funktion ablesen: Man verknüpft die Minterme aller Zeilen mit $f = 1$ durch ODER. Diese Form heißt kanonische disjunktive Normalform (KDNF); mehr dazu in Vorlesung 03.

    --{{3}}--
Wenn die Wahrheitstafel eine Funktion eindeutig festlegt, kann man alle Funktionen mit gleich vielen Eingängen vollständig aufzählen. Für einen Eingang sind das vier, für zwei Eingänge sechzehn. Die nächsten beiden Folien ordnen sie und geben ihnen Namen.

{{3}}
> Und die Schaltfunktionen? Kann man diese auch systematisch darstellen?

### Schaltfunktionen mit einem Eingang

    --{{0}}--
Mit einem Eingang hat die Tafel zwei Zeilen, also gibt es zwei hoch zwei, gleich vier Funktionen. Zwei davon beachten den Eingang gar nicht und liefern konstant null oder konstant eins. Bleiben die Identität, die den Eingang unverändert durchreicht, und die Negation, die ihn umkehrt; als Gatter heißt sie Inverter.

Die möglichen 4 Kombinationen einer Schaltfunktion mit einem Eingang lassen sich wie folgt gliedern:

<!-- data-type="none" -->
| Eingang | Nullfunktion | Identität | Negation            | Einsfunktion |
| ------- | ------------ | --------- | ------------------- | ------------ |
| $x = 0$ | 0            | 0         | 1                   | 1            |
| $x = 1$ | 0            | 1         | 0                   | 1            |
|         | $f(x)=0$     | $f(x)=x$  | $f(x)=\overline{x}$ | $f(x)=1$     |

### Schaltfunktionen mit zwei Eingängen

    --{{0}}--
Mit zwei Eingängen hat die Tafel vier Zeilen, also gibt es zwei hoch vier, gleich sechzehn Funktionen. Ihre Nummer ergibt sich aus der Ausgabespalte, gelesen von oben nach unten als Binärzahl. Beim Und steht dort null null null eins, das ist die Zahl eins, also f eins; beim Oder null eins eins eins, also f sieben.

Die möglichen 16 Kombinationen einer Schaltfunktion mit zwei Eingängen lassen sich wie folgt gliedern. Liest man die Ausgabespalte von oben nach unten als Binärzahl, erhält man ihre Nummer $f_0$ bis $f_{15}$.

<!-- data-type="none" -->
| Eingang x | Eingang y | $f_0$: Nullfunktion | $f_1$: Konjunktion (UND, AND) | $f_2$: Inhibition | $f_3$: Identität $x$ |
| --------- | --------- | ------------ | ----------------- | ---------------------------- | ---------- |
| $x = 0$   | $y = 0$   | 0            | 0                 | 0                            | 0          |
| $x = 0$   | $y = 1$   | 0            | 0                 | 0                            | 0          |
| $x = 1$   | $y = 0$   | 0            | 0                 | 1                            | 1          |
| $x = 1$   | $y = 1$   | 0            | 1                 | 0                            | 1          |
|           |           | $f(x,y)=0$   | $f(x,y)=x\cdot y$ | $f(x,y)=x\cdot \overline{y}$ | $f(x,y)=x$ |

<!-- data-type="none" -->
| Eingang x | Eingang y | $f_4$: Inhibition | $f_5$: Identität $y$ | $f_6$: Antivalenz (exklusives ODER, XOR, $x \oplus y$) | $f_7$: Disjunktion (ODER, OR) |
| --------- | --------- | ---------------------------- | ----------- | -------------------------------------------------- | ------------ |
| $x = 0$   | $y = 0$   | 0                            | 0           | 0                                                  | 0            |
| $x = 0$   | $y = 1$   | 1                            | 1           | 1                                                  | 1            |
| $x = 1$   | $y = 0$   | 0                            | 0           | 1                                                  | 1            |
| $x = 1$   | $y = 1$   | 0                            | 1           | 0                                                  | 1            |
|           |           | $f(x,y)=\overline{x}\cdot y$ | $f(x,y)= y$ | $f(x,y)=x\cdot \overline{y} + \overline{x}\cdot y$ | $f(x,y)=x+y$ |

    --{{0}}--
Sechs der sechzehn Funktionen sind alte Bekannte: die beiden Konstanten sowie Identität und Negation von nur einem Eingang. Die übrigen zehn hängen wirklich von beiden Eingängen ab, darunter Und, Oder, das exklusive Oder, NAND und NOR. Achten Sie auf das Muster der Nummern: f fünfzehn minus i ist immer die Negation von f i, so ist NAND mit der Nummer vierzehn die Negation von Und mit der Nummer eins.

<!-- data-type="none" -->
| Eingang x | Eingang y | $f_8$: negiertes ODER (NOR, Peirce-Funktion) | $f_9$: Äquivalenz (XNOR) | $f_{10}$: Negation $\overline{y}$ | $f_{11}$: Implikation $y \rightarrow x$ |
| --------- | --------- | ------------------------ | ---------------------------------------------------- | ---------------------- | ----------------------- |
| $x = 0$   | $y = 0$   | 1                        | 1                                                    | 1                      | 1                       |
| $x = 0$   | $y = 1$   | 0                        | 0                                                    | 0                      | 0                       |
| $x = 1$   | $y = 0$   | 0                        | 0                                                    | 1                      | 1                       |
| $x = 1$   | $y = 1$   | 0                        | 1                                                    | 0                      | 1                       |
|           |           | $f(x,y)=\overline{x+ y}$ | $f(x,y)= x\cdot y + \overline{x} \cdot \overline{y}$ | $f(x,y)=\overline{y}$ | $f(x,y)=x+\overline{y}$ |

<!-- data-type="none" -->
| Eingang x | Eingang y | $f_{12}$: Negation $\overline{x}$ | $f_{13}$: Implikation $x \rightarrow y$ | $f_{14}$: negiertes UND (NAND, Sheffer-Funktion) | $f_{15}$: Einsfunktion |
| --------- | --------- | --------------------- | -------------------------- | ----------------------------- | ------------ |
| $x = 0$   | $y = 0$   | 1                     | 1                          | 1                             | 1            |
| $x = 0$   | $y = 1$   | 1                     | 1                          | 1                             | 1            |
| $x = 1$   | $y = 0$   | 0                     | 0                          | 1                             | 1            |
| $x = 1$   | $y = 1$   | 0                     | 1                          | 0                             | 1            |
|           |           | $f(x,y)=\overline{x}$ | $f(x,y)= \overline{x} + y$ | $f(x,y)=\overline{x \cdot y}$ | $f(x,y)=1$   |

### Exkurs: Technische Realisierung

    --{{0}}--
Ein Gatter ist die technische Umsetzung einer Booleschen Funktion. Die beiden Bilder zeigen dieselbe Und-Funktion zweimal, einmal mit zwei Relais und einmal mit zwei Transistoren, jeweils in Reihe geschaltet. Das Prinzip ist die Reihenschaltung aus der Motivation, nur wird jeder Schalter jetzt elektrisch betätigt statt von Hand.

Ein Gatter ist eine (elektrotechnische) „Black Box“ mit einem, zwei oder
mehreren Eingängen $A,B,C,... \in \{0,1\}$ und genau einem Ausgang $Y\in \{0,1\}$
zur Realisierung einer Funktion $Y = f (A,B,C,...)$

![UND-Gatter aus zwei Relais in Reihe](./images/02_BoolscheAlgebra/RelaisAND.png)<!-- width="45%" -->
![UND-Gatter aus zwei Transistoren in Reihe](./images/02_BoolscheAlgebra/TransistorAND.png)<!-- width="45%" -->

Wir gehen bei der Frage der Schaltnetze in Vorlesung 04 nochmals auf die technische Realisierung ein.

    --{{1}}--
Das exklusive Oder entsteht nicht einfach durch Reihe oder Parallelschaltung. Der Ausgang soll eins sein, wenn genau einer der beiden Eingänge eins ist, nicht aber, wenn beide es sind. Ein Hinweis für Ihre Überlegung: Ein Relais kann einen Kontakt auch öffnen, statt ihn zu schließen.

{{1}}
> Und das exklusive ODER, hätten Sie eine Idee?

{{1}}
<!-- data-type="none" -->
| $S_1$ | $S_0$ | y   |
| ----- | ----- | --- |
| 0     | 0     | 0   |
| 0     | 1     | 1   |
| 1     | 0     | 1   |
| 1     | 1     | 0   |

    --{{2}}--
Jedes Relais betätigt hier zwei Kontakte gleichzeitig: einen Schließer, der bei Ansteuerung schließt, und einen Öffner, der dabei öffnet. Ein Strompfad führt über den Schließer von A und den Öffner von B, er leitet also bei A und nicht B. Der andere Pfad leitet entsprechend bei nicht A und B. Beide Pfade führen parallel zum Ausgang, und genau das ist die Formel des exklusiven Oder.

{{2}}
![XOR aus Relais](./images/02_BoolscheAlgebra/SchaltwerkXORLoesung.png "Realisierung einer XOR Funktion mit Relais Autor: 'Rk sTEk',  XOR in Relais-Logik - berichtigte Version, https://de.m.wikipedia.org/wiki/Datei:Relay_xor.svg")<!-- width="45%" -->

    --{{3}}--
Dieselbe Funktion lässt sich aus Grundgattern aufbauen, genau nach der Formel nicht a und b, oder a und nicht b. Jedes Und-Gatter erkennt einen der beiden Fälle, in denen die Eingänge verschieden sind, das Oder-Gatter fasst sie zusammen. Schalten Sie die Eingänge a und b in allen vier Kombinationen und vergleichen Sie die Lampe mit der Wahrheitstafel.

{{3}}
<section>

Dieselbe Funktion aus Gattern, $y = \overline{a}b + a\overline{b}$. Probieren Sie alle vier Eingangskombinationen aus:

``` json @DigiSim.evalJson
{"devices":{"a":{"label":"a","type":"Button","propagation":0,"position":{"x":0,"y":0}},"b":{"label":"b","type":"Button","propagation":0,"position":{"x":0,"y":110}},"na":{"label":"NICHT a","type":"Not","propagation":0,"bits":1,"position":{"x":100,"y":0}},"nb":{"label":"NICHT b","type":"Not","propagation":0,"bits":1,"position":{"x":100,"y":110}},"and1":{"label":"UND","type":"And","propagation":0,"bits":1,"position":{"x":230,"y":10}},"and2":{"label":"UND","type":"And","propagation":0,"bits":1,"position":{"x":230,"y":100}},"or1":{"label":"ODER","type":"Or","propagation":0,"bits":1,"position":{"x":360,"y":55}},"y":{"label":"y","type":"Lamp","propagation":0,"position":{"x":480,"y":60}}},"connectors":[{"from":{"id":"a","port":"out"},"to":{"id":"na","port":"in"}},{"from":{"id":"b","port":"out"},"to":{"id":"nb","port":"in"}},{"from":{"id":"na","port":"out"},"to":{"id":"and1","port":"in1"}},{"from":{"id":"b","port":"out"},"to":{"id":"and1","port":"in2"}},{"from":{"id":"a","port":"out"},"to":{"id":"and2","port":"in1"}},{"from":{"id":"nb","port":"out"},"to":{"id":"and2","port":"in2"}},{"from":{"id":"and1","port":"out"},"to":{"id":"or1","port":"in1"}},{"from":{"id":"and2","port":"out"},"to":{"id":"or1","port":"in2"}},{"from":{"id":"or1","port":"out"},"to":{"id":"y","port":"in"}}],"subcircuits":{}}
```

</section>

## Und im ATmega328P?

    --{{0}}--
Boolesche Funktionen schreiben Sie in C als Bedingungen. Das folgende Programm läuft auf einem simulierten ATmega328P. Es gibt zuerst die Wahrheitstafel aus und steuert dann eine Presse mit Zweihandbedienung.

In C verknüpfen die logischen Operatoren `&&` (UND), `||` (ODER) und `!` (NICHT) Wahrheitswerte; `0` bedeutet falsch, jeder andere Wert wahr. Eine Presse mit Zweihandbedienung darf nur auslösen, wenn beide Taster gedrückt sind und der Not-Aus nicht betätigt ist:

$$
f = \textit{links} \cdot \textit{rechts} \cdot \overline{\textit{notAus}}
$$

Starten Sie das Programm. Weil sich mit der Maus nicht zwei Taster gleichzeitig drücken lassen, stehen hier Schiebeschalter für die Taster: von links nach rechts der linke Taster (Pin 2), der rechte Taster (Pin 3) und der Not-Aus (Pin 4); die LED an Pin 13 zeigt, ob die Presse auslöst. Im Diagramm sehen Sie die Pegel aller vier Pins.

<div id="zweihand">
<wokwi-slide-switch pin="2"></wokwi-slide-switch>
<wokwi-slide-switch pin="3"></wokwi-slide-switch>
<wokwi-slide-switch pin="4"></wokwi-slide-switch>
<wokwi-led color="red" pin="13" label="Presse"></wokwi-led>
<avr-chart signals="D2, D3, D4, D13" window="4s" title="links, rechts, Not-Aus und Presse"></avr-chart>
</div>

```cpp Zweihandbedienung.ino
void setup() {
  Serial.begin(115200);
  pinMode(2, INPUT);    // Schalter links
  pinMode(3, INPUT);    // Schalter rechts
  pinMode(4, INPUT);    // Not-Aus
  pinMode(13, OUTPUT);  // LED: Presse löst aus

  // Wahrheitstafel und Probe der De Morgan'schen Regel
  Serial.println("a b | a&&b a||b !(a||b) !a&&!b");
  for (int a = 0; a <= 1; a++) {
    for (int b = 0; b <= 1; b++) {
      Serial.print(a); Serial.print(" "); Serial.print(b); Serial.print(" |   ");
      Serial.print(a && b);         Serial.print("    ");
      Serial.print(a || b);         Serial.print("      ");
      Serial.print(!(a || b));      Serial.print("       ");
      Serial.println(!a && !b);
    }
  }
}

void loop() {
  bool links  = digitalRead(2);
  bool rechts = digitalRead(3);
  bool notAus = digitalRead(4);

  digitalWrite(13, links && rechts && !notAus);
  delay(20);
}
```
@AVR8js.sketch(zweihand)

    --{{0}}--
Achten Sie in der seriellen Ausgabe auf die letzten beiden Spalten. Die eine berechnet nicht, in Klammern a oder b, die andere nicht a und nicht b, und für alle vier Belegungen stimmen sie überein. Das Programm prüft die De Morgan'sche Regel also durch Ausprobieren aller Fälle, genau wie eine Wahrheitstafel.

Die letzten beiden Spalten der Ausgabe sind gleich – das ist die De Morgan'sche Regel $\overline{a + b} = \overline{a} \cdot \overline{b}$. Sie brauchen sie beim Umschreiben von Bedingungen.

    --{{0}}--
Ein häufiger Fehler ist die Verwechslung der logischen Operatoren mit den bitweisen, die nur ein Zeichen haben. Die logischen fragen lediglich, ob ein Wert null ist oder nicht; die bitweisen verknüpfen jede Bitstelle einzeln. Für Bedingungen verwenden Sie die logischen Operatoren, die bitweisen brauchen wir erst, wenn wir einzelne Bits in Registern setzen.

> [!WARNING] Typische Fehlvorstellung
> **`&&` ist nicht `&`.** In C gibt es zu jedem logischen Operator einen bitweisen Zwilling: `&` statt `&&`, `|` statt `||`, `~` statt `!`. Die bitweisen Operatoren verknüpfen jedes Bit zweier Zahlen einzeln. Solange nur 0 und 1 vorkommen, liefern beide dasselbe – sonst nicht: `2 && 1` ist wahr (1), denn beide Werte sind ungleich 0, aber `2 & 1` ergibt 0, denn `0b10` und `0b01` haben kein gemeinsames gesetztes Bit. Außerdem wertet `&&` die rechte Seite gar nicht erst aus, wenn die linke schon falsch ist. Für Bedingungen verwenden Sie deshalb immer `&&`, `||` und `!`. Die bitweisen Operatoren brauchen wir in Vorlesung 12, um einzelne Bits in den Registern des ATmega328P zu setzen.

> Probieren Sie es aus: Ändern Sie die Bedingung so, dass die Presse auch dann nicht auslöst, wenn ein zusätzlicher Schalter „Gitter offen“ betätigt ist. Wie lautet die Funktion $f$ dann?

    --{{0}}--
Die beiden Fragen üben De Morgan in C. Ein Nicht vor einer Klammer wandert hinein; dabei wird jede Variable negiert, und aus Oder wird Und und umgekehrt. Prüfen Sie Ihre Antwort im Zweifel mit einer kleinen Wahrheitstafel.

**Welcher Ausdruck ist gleichwertig zu `!(a || b)`?**

[( )] `!a || !b`
[(X)] `!a && !b`
[( )] `a && b`
[( )] `!a && b`
***************************************************************

De Morgan: $\overline{a + b} = \overline{a} \cdot \overline{b}$. Die Bedingung ist nur dann wahr, wenn weder `a` noch `b` wahr ist.

***************************************************************

**Die Presse soll auslösen, wenn nicht gilt: „linker Taster losgelassen oder rechter Taster losgelassen“. Welche Bedingung ist das?**

[( )] `!links || !rechts`
[(X)] `links && rechts`
[( )] `links || rechts`
[( )] `!(links && rechts)`
***************************************************************

$\overline{\overline{\textit{links}} + \overline{\textit{rechts}}} = \overline{\overline{\textit{links}}} \cdot \overline{\overline{\textit{rechts}}} = \textit{links} \cdot \textit{rechts}$ – De Morgan und Doppelnegation.

***************************************************************

## Ihre Begriffe für die Kurslandkarte

Die [Kurslandkarte](https://tubaf-ifi-liascript.github.io/VL_EingebetteteSysteme/kurslandkarte/) wächst mit dem Semester, und Sie bestimmen mit, was hineinkommt. Ihre Antworten sammeln wir im Hörsaal gemeinsam über das LiaScript-Klassenzimmer; nach der Vorlesung werden die Begriffe dieser Woche in der Karte freigeschaltet.

**Welche Begriffe aus der heutigen Vorlesung gehören für Sie in die Kurslandkarte?**

[[___ ___ ___]]

**Wo begegnet Ihnen das, was heute dran war – in Ihrem Studiengang oder in Geräten Ihres Alltags?**

[[___ ___ ___]]

## Hausaufgaben

Bis zum Beginn der Übungen Ende November ersetzt die Hausaufgabe die Übung. Planen Sie 30–45 Minuten ein. Teil A prüfen Sie direkt hier, Teil B besprechen wir zu Beginn der nächsten Vorlesung.

**Teil A – mit Selbstkontrolle**

**Aufgabe 1:** Geben Sie für die folgende Schaltung eine Boolesche Funktion an und stellen Sie die Wahrheitstafel auf. Ein geschlossener Schalter entspricht 1.

![Schaltung aus den Schaltern S1, S2 und S3](./images/02_BoolscheAlgebra/Schaltwerk2.png)<!-- width="65%" -->

**In wie vielen Zeilen der Wahrheitstafel ist $f = 1$?**

[[3]]

**Welcher Ausdruck ist die vereinfachte Funktion?**

[( )] $S_1 + S_2 + S_3$
[(X)] $S_3(S_1 + S_2)$
[( )] $S_1 S_2 S_3$
[( )] $S_3$
***************************************************************

Links stehen S1 und S2 parallel, dann folgt S3 in Reihe, dann S2 und S3 parallel: $f = (S_1 + S_2) \cdot S_3 \cdot (S_2 + S_3)$. Mit dem Absorptionsgesetz ist $S_3 (S_2 + S_3) = S_3$, also $f = S_3 (S_1 + S_2)$. Die Lampe leuchtet bei $S_1S_2S_3 = 011, 101, 111$.

***************************************************************

**Aufgabe 2:** Entwerfen Sie nur mit den Gattern UND, ODER und NICHT Schaltnetze, die $P$ und $Q$ aus den Eingängen $X$, $Y$ und $Z$ erzeugen. Lösen Sie dazu zuerst das XOR mit seiner Definition auf. Vergleichen Sie $P$ und $Q$ mit Wahrheitstafeln.

$$
\begin{aligned}
P&=\left(X+\overline{Y}\right)\left(Y\oplus Z\right) \\
Q&=\overline{Y}Z+XY\overline{Z}
\end{aligned}
$$

**Welche Beziehung besteht zwischen $P$ und $Q$?**

[(X)] $P = Q$ für alle Eingaben
[( )] $P = \overline{Q}$ für alle Eingaben
[( )] $P$ und $Q$ unterscheiden sich in genau einer Zeile
[( )] es gibt keinen einfachen Zusammenhang
***************************************************************

Beide sind genau für $XYZ = 001, 101, 110$ gleich 1. Algebraisch: $P = (X+\overline{Y})(\overline{Y}Z + Y\overline{Z}) = X\overline{Y}Z + XY\overline{Z} + \overline{Y}Z = \overline{Y}Z + XY\overline{Z} = Q$, denn $\overline{Y}\,\overline{Y} = \overline{Y}$, $\overline{Y}Y = 0$ und mit Absorption $X\overline{Y}Z + \overline{Y}Z = \overline{Y}Z$.

***************************************************************

**Teil B – Besprechung in der nächsten Vorlesung**

**Aufgabe 3:** Lesen Sie das [Datenblatt des UND-Gatters SN74LVC2G08](https://www.ti.com/lit/ds/symlink/sn74lvc2g08-ep.pdf) von Texas Instruments:

+ Wie groß ist die maximale Verzögerung (_propagation delay_ $t_{pd}$), mit der der Ausgang dem Eingang folgt, bei einer Versorgungsspannung von 3,3 V?
+ Was bedeuten die Kreuze in der Wahrheitstafel (_Function table_)? (Der Begriff dafür kommt in Vorlesung 03.)
+ Können Sie mit dem Gatter auch eine Negation des Eingangssignals realisieren? Begründen Sie mit der Wahrheitstafel.

## Nächste Vorlesung

Am **Mittwoch, 04.11.**, geht es um Minimierung: Mit dem KV-Diagramm finden Sie die kürzeste Form einer Schaltfunktion, ohne lange Umformungsketten.

[^ATmega]: Microchip Technology: ATmega48A/PA/88A/PA/168A/PA/328/P megaAVR® Data Sheet, DS40002061B, 2020, Table 30-1 „Common DC characteristics“, [Link](https://ww1.microchip.com/downloads/en/DeviceDoc/ATmega48A-PA-88A-PA-168A-PA-328-P-DS-DS40002061B.pdf)
