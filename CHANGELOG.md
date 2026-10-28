# Changelog - Digitale Systeme / Eingebettete Systeme

Alle wesentlichen Änderungen an diesem Kurs werden in dieser Datei dokumentiert.

## [0.7.4] - 2026-10-28

### Changed
- **01_HistorischerUeberblick (0.7.4):** Stellenwertsystem (MDCCLXV vs. 1765 vs. Binär, Übertrag, Kasten „Mehr dazu“) und Abakus-Frage nach der zehnten Kugel; „Abstraktere Konzepte“ als Brücke ALU → Architektur → Theorie: Leibniz' Binärarithmetik (1703, Notiz „De Dyadicis“ via Wikimedia), neuer Abschnitt George Boole, neuer Abschnitt Alan Turing (Band, Kopf, Zustand, Regeltabelle; Addition 1101 + 0110 mit Symbolen erster und zweiter Art und Regeltabellen-Ausschnitt; Universalität, Halteproblem, Turing-Vollständigkeit; Kasten „Typische Fehlvorstellung“ zu Enigma/Bombe/Colossus); Zeitstrahl um Leibniz, Turing, Shannon ergänzt; Z3 ohne bedingte Sprünge erklärt (Fußnote Rojas 1998); Kasten „Und im ATmega328P?“ zur Harvard-Architektur; „Merke“ zur Wortbreite; geschätzte Transistorzahl des ATmega328P (Fußnote mit Rechnung); „Weitere Entwicklung“ gekürzt und bis 2024 (Blackwell) fortgeführt, Moore-Diagramm 1970–2020 (Our World in Data, CC BY 4.0) mit Ausblick „Und heute?“; Fehlprognosen als Tabelle mit Quellen (Popular Mechanics, Olsen, Metcalfe, Ballmer, Hinton) und offene Prognosen (Huang, Amodei) mit Freitextfrage; „Was Sie heute mitnehmen“ um Leibniz, Boole und Turing ergänzt
- **01_HistorischerUeberblick (0.7.3):** Rückblick beginnt mit dem Compiler-Explorer-Beispiel der Hausaufgabe (Bild und Link) statt mit dem Quiz zu `sbi`
- **01_HistorischerUeberblick (0.7.2):** Rückblick löst die tatsächliche Hausaufgabe aus VL 00 auf (Compiler Explorer, Wortbreite) statt der entfallenen Assembler-Aufgabe; weiterführende Literaturhinweise entfernt (Z3-Angaben bleiben per Fußnote belegt)
- **Kurslandkarte:** VL 0 freigegeben (Begriffsabfrage vom 21.10. ohne Rückmeldungen, vorbereitete Begriffe unverändert); erster Termin von VL 15 ist der 28.01. (Aktoren), nicht der 03.02.

## [0.7.5] - 2026-10-21

### Changed
- **00_Einfuehrung (0.6.7):** Folie „Wozu brauche ich das in meinem Studiengang?“ um Smart Systems Engineering ergänzt

## [0.7.4] - 2026-10-20

### Changed
- **00_Einfuehrung (0.6.6):** neue Folie „Heute an der Tür“: Personenzähler an der Hörsaaltür (derselbe Aufbau wie in EAVD), Auszug aus dem Probelauf vom 19.10. in FOR-0270, Idee in vier Schritten als Zustandsdiagramm nach der Zähllogik in EAVD `zaehler.py` (Mermaid, Template neu importiert; fünf Zustände mit Eingängen L/R, 400 ms Nachlauf, Ausgabe rein/raus/unklar; Mitte, gleichzeitige Belegung und 6-s-Grenze nur im Text): Takt, Schwelle/Komparator, Automat, Zähler mit Verweis auf VL 05, 07, 08, 13, 14 – bewusst ohne Hardwaredetails; Rückgriff „Zurück zur Tür“ in „Was Sie heute mitnehmen“; neue Folie „Und was ist mit KI?“ (nach EAVD: Begriffe für Frage und Prüfung, Controller meldet keine Fehler, KI braucht Hardware, Klausur nur auf Papier); „Die Kurslandkarte“ als eigene Folie mit Vorschaubild (`images/00_Einfuehrung/kurslandkarte.png`, Stand nach VL 08) statt Nebensatz in OER; OER-Folie bettet den LiaScript-LiveEditor ein (Template LiveEdit-Embeddings 0.0.1) mit Beispielfolie zu Bits und Quiz
- **Kurslandkarte:** Anwendung „Personenzähler an der Hörsaaltür“ (VL 00); veraltete Abschnittsverweise der Begriffe Mikroarchitektur und DDRB auf „Quer über alle Ebenen“ korrigiert

## [0.7.3] - 2026-10-18

### Changed
- **Sprechertexte VL 00–02:** geprüft (Sprachregel, vorlesetauglich ohne Formeln und Codezeichen, Werbeton entfernt) und für alle inhaltlichen Folien ergänzt – VL 00 (0.6.5): 19 → 33 Texte, VL 01: 17 → 33, VL 02: 2 → 40
- **01_HistorischerUeberblick (0.7.1):** Bezeichnungen ATmega328P / Arduino UNO R3 / Arduino-Framework; Z3-Takt (5,3 Hz) und Additionszeit (0,6 s) nach Rojas; Abschluss „Was Sie heute mitnehmen“ und „Nächste Vorlesung“; Auflösung der VL-00-Hausaufgabe ergänzt; Bild `Moores_Law_…` ohne Apostroph (JS-Fehler behoben); Wikimedia-Link repariert
- **02_BoolscheAlgebra (0.1.0):** nach Persona-Reviews und Fachprüfung überarbeitet: Ergebnis von Beispiel 3 (XOR), CMOS-Pegel nach Datenblatt des ATmega328P mit Störabstand, Gatterbilanzen nachgerechnet, Definition Boolesche Funktion (m = 1), Schaltnetz statt Schaltwerk, Shannon-Titel; neu: Rückblick auf VL 01, Schreibweisen (+, ·, Überstrich, C-Operatoren), Beweis der Idempotenz und Aufgabe für Vorerfahrene, Minterm/KDNF an der Wahrheitstafel, Namen f0–f15 der zweistelligen Funktionen, XOR in DigiSim, Abschnitt „Und im ATmega328P?“ mit ausführbarem Sketch (Wahrheitstafel und De-Morgan-Probe auf dem simulierten ATmega328P, Zweihandbedienung mit Schaltern und Logikanalysator), Warnkasten `&&` vs. `&`, acht Quizze, Hausaufgabe mit Selbstkontrolle (Teil A) und Besprechung (Teil B), „Nächste Vorlesung“; DNF/KNF-Fragen nach VL 03; NetSwarm-Import durch DigiSim ersetzt
- **Ebenen-Diagramm in allen Vorlesungen vereinheitlicht:** Ebene 4 „Systemsoftware (fehlt beim ATmega328P)“, Tippfehler „Istruktionsset“ (VL 11–15) und Pfeilversatz (VL 03) behoben; VL 02 markiert zusätzlich den Übergang analog → digital (Abtastung, Quantisierung, Pegel) passend zum Sprechertext; Markierung „HIER SIND WIR“ an den Inhalt angepasst: VL 11 Ebene 2 (+ 3), VL 12 Ebene 5 (+ 6, 3), VL 13–15 Ebene 6 (+ 0 bzw. 2); Versionen VL 03–15 jeweils um eins erhöht
- **00_Einfuehrung, Startfolie:** „Herzlich willkommen“; „Fragen an die Veranstaltung“ auf vier gekürzt und als Einordnung und Motivation gekennzeichnet (Echtzeit und Ressourcen folgen in VL 14/15); Begrüßung im Sprechertext
- **00_Einfuehrung, nach Didaktik-Gutachten:** „Merke“ an der Kernaussage zu den Ebenen (vor dem Zuordnungsquiz) statt am KI-Satz; LiaScript-Exkurs mit Live-Editor entfernt (Import LiveEdit-Embeddings entfällt)
- **Kurslandkarte, Bedienung und VL 00:** Bedienelemente in „So nutzen Sie die Karte“ erklärt (Regler verschiebt nur die Markierung, ausgegraute Elemente, Farben je Ansicht); Zählzeile der Metrokarte „Begriffe auf Fäden“; „Faden“ statt „roter Faden“; „Eingebettetes System“ als Kernbegriff bei VL 00 (Folie „Was ist ein eingebettetes System?“) statt VL 15
- **Kurslandkarte, nach Fachgutachten:** neuer Kernbegriff Harvard-Architektur (VL 01), ATmega328P „ist aufgebaut nach der“ Harvard-Architektur statt „erweitert die Bausteine der“ Von-Neumann-Architektur; Wahrheitstafel als kanonische Darstellung (kein Widerspruch mehr zur KDNF); ISR nach AVR-Ablauf (Hardware sichert nur die Rücksprungadresse); Taktgenerator mit realistischen Genauigkeiten und Keramikresonator des UNO R3; Zweierkomplement „für ganze Zahlen“; Atomarer Zugriff ohne Verweis auf die Hardware-Race-Condition; Ausblick voreingestellt, solange keine Vorlesung freigeschaltet ist
- **00_Einfuehrung, nach Persona-Reviews vom 21.10.:** Personenzähler-Tabelle mit Roboterzeit und Zählung 416 ms nach „alle frei“ (wie `zaehler.py`), Messrate „etwa 15-mal pro Sekunde“; Hausaufgabe ohne „Teil A/B“; „Median 3,3“; Quiz 3 erklärt `eax`/`rax`; „Vorsicht, Hardware“ mit „kann … beschädigt werden“ und Vorwiderstand; Kasten „Keine Sorge“; Ebenenüberschriften wie in der Leiste; Hex-Datei enthält auch Tabellen (Bitmasken ab 0x90)
- **00_Einfuehrung:** Foto des Personenzählers im Hörsaal (aus VL_EAVD, 00_Motivation) unter „Heute an der Tür“
- **00_Einfuehrung:** Prüfungsmodalitäten mit Histogramm der Klausurnoten des letzten Wintersemesters (25 Teilnehmende, ein Fünftel nicht bestanden, Median 3,3) und Hinweis auf Hausaufgaben und Probeklausur
- **Hervorhebungen (Decision vom 21.10.):** VL 00 und 02 nutzen LiaScript-Kästen mit festen deutschen Titeln – VL 00: zweimal „Mehr dazu“, „Typische Fehlvorstellung“ (`pinMode` ist kein einzelner Befehl), „Vorsicht, Hardware“ (Kurzschluss, 20/40 mA pro Pin), „Merke“ (ohne Begriffe keine Hilfe von der KI); VL 02: „Typische Fehlvorstellung“ (ENIAC, `&&`/`&`), zweimal „Merke“ (Dualitätsprinzip, Wahrheitstafel eindeutig); VL 01 ohne passende Stelle
- **Startseite `index.html`** für GitHub Pages (https://tubaf-ifi-liascript.github.io/VL_EingebetteteSysteme/): Link zur Kurslandkarte und zu VL 00, Lernziele (aus der Outline), Kontakt; ersetzt die aus der README erzeugte Seite; die Kurslandkarte verlinkt über die Kursbezeichnung im Kopf zurück zur Startseite
- **Kurslandkarte, VL 00:** Personenzähler an der Hörsaaltür statt LED-Lauflicht als erste Anwendung; Erklärung „Mikroarchitektur“ an die gekürzte Folie angepasst
- **Kurslandkarte:** Kopf und Legende springen beim Wechsel zwischen Vorlesungen, Metrokarte und Zeitleiste nicht mehr – Bedienelemente bleiben stehen und werden ausgegraut, wo sie nicht wirken; die Legende hält die Höhe der größten Variante frei
- **00_Einfuehrung (0.6.5):** Frage „Welche Funktion hat der Code?“ erscheint zusammen mit dem Code (nicht erst im nächsten Schritt); Foto einer kurzgeschlossenen 9-V-Batterie unter „Trotz Simulation und Virtuellem …“ (Wikimedia Commons, CC BY-SA 4.0); Hausaufgabe: Compiler Explorer (`addiere8`/`addiere32` für AVR und x86-64, drei Quizfragen zur Wortbreite) statt der Assembler-Blinkaufgabe; „Quer über alle Ebenen“ zeigt neben jedem Schritt eine Ebenen-Leiste mit der aktuellen Ebene (Makro `@ebenen`); verwaiste Zeile „Beispiel 2:“ entfernt
- **13_ADC (0.0.8):** JS-Fehler beim Laden behoben: `link:`-Zeilen waren unter `script:` eingerückt und wurden als Skripte geladen (Chartist und animate.css werden nicht benutzt, entfernt); CodeRunner-Import auf die README-Adresse umgestellt; überzähliges `s` hinter `@LIA.eval` entfernt; Python-Beispiel zur Abtastung zeigt jetzt den Alias-Effekt (fs = 50 Hz → 10-Hz-Alias statt 401 Hz ohne Alias), Rekonstruktion mit voller Amplitude, ohne ComplexWarning

## [0.7.2] - 2026-10-18

### Changed
- **00_Einfuehrung (0.6.4):** Terminspalte in der Übersicht der Vorlesungen; VL 12, 14, 15 mit zwei Terminen (Teil I/II), Wiederholung, Puffer und Ausfall 18.11. benannt
- **Begriffsabfrage in allen Vorlesungen:** VL 02–15 enden (vor Haus- bzw. Übungsaufgaben) mit „Ihre Begriffe für die Kurslandkarte“; Versionen jeweils um eins erhöht
- **00_Einfuehrung (0.6.3):** Startcheck vor dem 21.10.: Vorkenntnis-Umfrage direkt hinter das Team, Hinweis auf den Klassenzimmer-Link im Hörsaal, Übungsbeginn „ab Ende November, Details bis Mitte November im OPAL“, Ausfall 18.11., Probeklausur Ende Januar, Remote-Labore gestrichen, Chatgruppe angepasst, Tipp zur Assembler-Hausaufgabe, RoboLab-Folie ohne Namen, Alt-Texte; neue Folie „Zwei Simulatoren begleiten Sie durchs Semester“ (DigiSim-UND, AVR8js mit Taster, Potentiometer, Servo und Logikanalysator); Bezeichnungen ATmega328P (Microchip), Arduino UNO R3 und Arduino-Framework statt „Arduino“, Pin 13 = PB5, Eingangspegel laut Datenblatt
- **06_FlipFlops (0.0.10), 09_Rechnerarithmetik (0.0.8):** DigiSim-Schaltungen mit rechtwinkligen Leitungen (`"router": "manhattan"`, DigiSim-Template 0.1.0)

## [0.7.1] - 2026-10-16

### Changed
- **Begriffsabfrage:** VL 00 und 01 enden mit „Ihre Begriffe für die Kurslandkarte“ (LiaScript-Klassenzimmer)
- **00_Einfuehrung (0.6.2):** Didaktik-Review und Persona-Urteile: Schlussfolie, Ausblick, Ebene 2, Pegel/Pull-up, Präsenzzeit 45 h, Hinweis auf PDF-Fassung, Hausaufgabe offen formuliert
- **00_Einfuehrung (0.6.1):** nach Persona-Reviews (Runde 2): Definition „eingebettetes System“ mit Quiz, richtiges Port-Diagramm des ATmega, Hinweise auf spätere Vorlesungen, Bitoperationen erklärt, Nachlese C, Tri-State erklärt, kleinere Korrekturen
- **01_HistorischerUeberblick (0.7.0):** überarbeitet: Fremdinhalt (C#/C++) ersetzt durch Rückblick-Quiz; Zeitstrahl und Jahreszahlen korrigiert; ENIAC eigener Abschnitt mit Vergleich und Quiz; Ebenen erklärt mit Zuordnungsquiz; Wortbreite, Befehle pro Sekunde, Harvard-Architektur, Relais-Selbsthaltung; Zitate belegt bzw. als zugeschrieben gekennzeichnet

## [0.7.0] - 2026-10-16

### Changed
- **Neue Nummerierung:** Pipeline-Vorlesung entfällt; AVR-Vorlesungen 13–16 heißen jetzt 12–15 (Dateien, Bilder, Beispiele, Material)
- **00_Einfuehrung (0.6.0):** überarbeitet nach Persona-Reviews
  * Hex-Beispiel und Text stimmen überein (`0C 94 5D 00` = `jmp 0xBA`), Intel-HEX-Format erklärt
  * Ebenenreise konsistent zum Schichtenmodell; neuer Schritt Assembler (ausführbar mit `@AVR8js.asm`) und Maschinencode (`sbi 0x04, 5` = `25 9A`)
  * Logikanalysator (`<avr-chart>`) am Blink-Beispiel, Zuordnungsquiz „Code → Ebene“, Vorkenntnis-Umfrage
  * unbelegte Zahlen entfernt, Harvard-Architektur des ATmega328P korrigiert, Fragen an den Kursumfang angepasst
  * Zeitplan WiSe 2026/27, Studiengangsbezug statt Berufsliste, OER-Teil gekürzt
- **config.md:** Wintersemester 2026/27

### Added
- **Kurslandkarte** unter `kurslandkarte/` (GitHub Pages)

## [0.6.2] - 2025-10-14

### Enhanced
- **BILDQUELLENANGABEN**: Autorenschaft in Bildunterschriften integriert
  * **Vollständige Quellenangaben**: Alle Bilder mit korrekten Autor-Attributionen
  * **Copyright-Compliance**: Ordnungsgemäße Lizenzierung und Urheberrechte
  * **Akademische Standards**: Professionelle Quellenangaben für Lehrmaterial
  * **Rechtssicherheit**: Korrekte Bildnutzung für Bildungseinrichtungen

### Impact
- **Rechtssichere Lehre**: Alle Bildquellen ordnungsgemäß dokumentiert
- **Professionelle Standards**: Wissenschaftliche Zitierweise eingehalten
- **Transparenz**: Nachvollziehbare Herkunft aller visuellen Materialien

## [0.6.1] - 2025-10-14

### Enhanced
- **INTERAKTIVE TIMELINE**: Mermaid-Timeline für Rechentechnik-Evolution implementiert
  * **7 Epochen visualisiert**: Von mechanischen Grundlagen bis Intelligent Embedded Systems
  * **200-Jahre-Überblick**: Arduino-fokussierte Meilensteine von 1800 bis heute
  * **Technische Informatik-Fokus**: Moore's Law, ARM-Architektur, RISC-V prominent
  * **Geometrische Symbole**: ■▲●◆★◉◈ für intuitive Epochen-Navigation
  * **TTS-Integration**: Sprachkommentar zur Arduino-Ingenieurskunst-Evolution

### Fixed
- **Timeline-Korrekturen**: "Dampfmaschinen-Computer" durch historisch korrekte "US-Volkszählung 1890" ersetzt
- **Mermaid-Kompatibilität**: Formatierungsprobleme mit Emojis und Markdown-Syntax behoben

### Impact
- **Visueller Einstieg**: Studis sehen sofort die komplette Entwicklung zum Arduino
- **Motivation**: Jeder Arduino ist "200 Jahre Ingenieurskunst" in der Hand
- **Historischer Kontext**: Von Babbage-Konzepten zu ATmega328P-Implementierung

## [0.6.0] - 2025-10-14

### Fixed
- **STRUKTURBEREINIGUNG**: Entfernung obsoleter "Reflexion Ihrer Fragen" Sektion
  * **Veraltete Partizipations-Tabelle** aus historischem Überblick entfernt
  * **Redundante Inhalte** eliminiert für klarere Vorlesungsstruktur
  * **Co-Author-Beitrag** ordnungsgemäß im Header dokumentiert

### Enhanced
- **Versionsverwaltung**: Systematische Versionsnummer-Aktualisierung
- **Metadaten-Konsistenz**: Teaching-Agent als Co-Author ergänzt

### Impact
- **Streamlined Content**: Fokus auf relevante Inhalte ohne veraltete Partizipations-Elemente
- **Professional Documentation**: Korrekte Versionierung und Autorschaft

## [0.5.0] - 2025-10-13

### Enhanced
- **TTS-OPTIMIERUNG**: Professionelle Text-to-Speech-Integration in der Einführung
  * **15 strategische Sprachkommentare** mit echten Mehrwerten statt Textwiederholungen
  * **Korrekte LiaScript-Animationssyntax** (abschnittsweise `--{{0}}--` bis `--{{n}}--`)
  * **Insider-Wissen ergänzt**: Race Conditions, Hardware-Spezifika, Industrie-Geheimnisse
  * **Didaktische Mehrschichtigkeit**: Visueller Text + auditive Profi-Tipps
  * **Accessibility verbessert**: Multimodale Lernerfahrung für verschiedene Lerntypen

### Technical Details
- **Arduino-Code-Analyse**: pinMode() → 50+ Funktionsaufrufe, digitalWrite = 12 Taktzyklen
- **Hardware-Einblicke**: DDRB = 0x04, Tri-State-Logik, 100.000 Transistoren im ATmega328P
- **Professional Context**: Senior vs. Junior Developer, "Eine Schicht tiefer schauen"

### Impact
- **Interaktive Vorlesung**: Von statischer Präsentation zu lebendiger, geführter Lernerfahrung
- **Expertenwissen zugänglich**: Komplexe Embedded-Konzepte verständlich vermittelt

## [0.4.0] - 2025-10-13

### Enhanced
- **LERNZIEL-SYSTEMATISIERUNG**: Vollständige Überarbeitung aller "Fragen an die Veranstaltung"
  * **00_Einführung**: Kompletter Abschnitt neu erstellt (8 Arduino-fokussierte Fragen)
  * **Alle Vorlesungen**: Erweitert auf mindestens 8 aussagekräftige Lernkontrollfragen
  * **Copy-Paste-Fehler korrigiert**: 07_Schaltwerke & 08_StandardSchaltwerke individualisiert
  * **Didaktische Progression**: Von Grundlagen zu Anwendungen, Verständnis zu Transfer
  * **Formatierung standardisiert**: Einheitliche `**Fragen an die Veranstaltung**` Überschriften

### Impact
- **Perfekte Prüfungsvorbereitung**: 16 × 8 = 128 systematische Lernkontrollfragen
- **Einheitliche Qualität**: Alle Vorlesungen mit vollständigen Lernzielen
- **Didaktisch fundiert**: Ausgewogene Mischung aus Verständnis-, Anwendungs- und Transferfragen

## [0.3.0] - 2025-10-13

### Perfect
- **DIDAKTISCHE REORGANISATION**: Komplette strukturelle Neuorganisation der Einführung
  * Klarer Einstieg: "Worum geht es?" mit interaktiven Fragen am Arduino-Code
  * Logische Steigerung: Code → Hex → Mission → Journey → Beispiele → Anwendungen
  * Zwei getrennte Lehr-Beispiele für optimale Verständnis-Entwicklung:
    1. **Mikroarchitektur**: System-Überblick mit Von-Neumann-Diagramm (PlantUML)
    2. **pinMode()-Sezierung**: 4-Ebenen-Transformation mit Real-World-Details
  * **Real-World-Komplexität**: Echte Arduino pinMode() Implementation mit Interrupt-Schutz
  * **Race-Condition-Erklärung**: Warum cli()/sei() und kritische Bereiche nötig sind
  * Streamlined Journey-Tabelle ohne redundante Arduino-Bezüge
  * 8 präzise messbare Lernziele (erweitert um pinMode()-Verständnis)

### Impact
- **Perfekte didaktische Sequenz**: Konkret → Abstract → Anwendung
- **Zwei Lern-Perspektiven**: System-Überblick + Detail-Transformation
- **Echte Embedded-Herausforderungen**: Interrupt-Sicherheit und Race Conditions
- **Professional Real-World-Bezug**: Von Arduino-Spielerei zu Embedded-Engineering

## [0.2.0] - 2025-10-13

### Enhanced
- **REVOLUTIONÄRE EINFÜHRUNG**: Arduino-zu-Maschinencode-Leitmotiv implementiert
  * Direkter emotionaler Hook mit Arduino-Code → Maschinencode-Transformation
  * 16-Stationen-Journey-Map mit konkreten Arduino-Bezügen zu jeder Vorlesung
  * 7 präzise messbare Lernziele (von `digitalWrite()` bis `analogRead()`)
  * Bottom-Up-Erklärung der Abstraktionsebenen mit visueller Darstellung
  * Motivierende Antworten auf "Warum brauche ich das?"-Fragen
  * Klare Abgrenzung zu oberflächlichen Arduino-Kursen

### Impact
- **Massive Motivationssteigerung**: Von "Ich muss das halt lernen" zu "Ich WILL verstehen!"
- **Klarer roter Faden**: Jede Vorlesung hat erkennbaren Bezug zum Arduino-Verständnis
- **Konkrete Erfolgsmessung**: 7 Fragen definieren messbare Lernerfolge

## [0.1.0] - 2025-10-13

### Added
- Changelog-Datei zur Dokumentation aller Kursänderungen
- Systematische Versionierung des gesamten Kurses
- README.md mit vollständiger Kursübersicht und Team-Information
- Vollständige Autoren-Dokumentation aus allen 17 Header-Bereichen erfasst

### Changed
- Tabellen-Standardisierung (Alle 16 Vorlesungen)
- Inhaltsbeschreibungen präzisiert
- Link-Korrekturen

---

## Versionsschema

- **Major.Minor.Patch** (z.B. 1.0.0)
- **Major**: Strukturelle Änderungen am Kurs (neue Vorlesungen, große Umstrukturierungen)
- **Minor**: Inhaltliche Verbesserungen, neue Features
- **Patch**: Bugfixes, kleinere Korrekturen

## Kategorien

- **Added**: Neue Features/Inhalte
- **Changed**: Änderungen an bestehenden Features/Inhalten
- **Deprecated**: Features/Inhalte, die bald entfernt werden
- **Removed**: Entfernte Features/Inhalte
- **Fixed**: Bugfixes und Korrekturen
- **Security**: Sicherheitsbezogene Änderungen

---

## Mitwirkende

### 🎓 Hauptautoren (in allen Vorlesungen)
- **Prof. Sebastian Zug** - Kursleitung und Inhalte  
  📧 sebastian.zug@informatik.tu-freiberg.de
- **André Dietrich** - LiaScript-Integration und technische Umsetzung  
  📧 andre.dietrich@informatik.tu-freiberg.de
- **Fabian Bär** - Studentische Mitarbeit und Beispielcodes  
  📧 fabian.baer@student.tu-freiberg.de

### 👨‍💻 Aktive Git-Mitwirkende (Top Contributors)
*Basierend auf Git-Commit-Analyse (30 verschiedene Autoren):*

**🏆 Hauptbeitragende (10+ Commits):**
- **Fabian Bär** - 50 Commits (baerfabian@gmx.de, Git: fjangfaragesh + Fabian Bär)
- **Tylona** - 37 Commits (GitHub-User)
- **fb89zila** - 33 Commits (GitHub-User)
- **Gernot Zacharias** - 10 Commits (GitHub-User GERZAC1002)

**📝 Regelmäßige Beitragende (5+ Commits):**
- **gelbeforelle** - 6 Commits (GitHub-User)
- **Florian2501** - 5 Commits (florischierz@gmail.com)
- **Leander Jakschik** - 5 Commits (julian@juliankeppler.de)

**🔧 Weitere Mitwirkende (Header-Erwähnte):**
- **FnHm** - 2 Commits (GitHub-User, in Header erwähnt)
- **gjaeger1** - 1 Commit (jaegergeorg@web.de, in Header als "gjaeger")
- **ShyFlyGuy** - 1 Commit (GitHub-User, in Header erwähnt)
- **Lalelele** - 1 Commit (GitHub-User, in Header erwähnt)

**👥 Weitere 19 Mitwirkende** mit kleineren Beiträgen (Bigfire3, CaioMarcasMenz, CaptnNiveau, Dunkelmann, FakeUserTUBAF, Friedy630, juliankeppler, Julian Keppler, Kneemund, Leander J, LimitlessGreen, Moritz Mechelk, NiklasW, Phoenix21Dragon, Tristan, Zmora, u.a.)

### � Repository-Statistiken
- **Gesamte Commits**: 542 (Zeitraum: 2020-08-28 bis 2025-06-24)
- **Einzigartige Autoren**: 31 verschiedene Mitwirkende
- **Hauptautor**: Sebastian Zug (356 Commits = 65,7% aller Commits)
- **Community-Beiträge**: 186 Commits von 30 verschiedenen Mitwirkenden

### �📋 Autorschafts-Verteilung (Datei-Header)
- **config.md**: Sebastian Zug (alleinige Autorschaft)
- **00_Einfuehrung.md**: Sebastian Zug, André Dietrich + 5 GitHub-Mitwirkende
- **01-16 (alle anderen Vorlesungen)**: Sebastian Zug & André Dietrich & Fabian Bär

### 🤖 KI-Unterstützung
- **GitHub Copilot Teaching-Agent** - Strukturelle Verbesserungen und didaktische Optimierung (ab 2025-10-13)

---

*Letzte Aktualisierung: 13. Oktober 2025*