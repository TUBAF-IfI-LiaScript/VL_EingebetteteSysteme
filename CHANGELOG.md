# Changelog - Digitale Systeme / Eingebettete Systeme

Alle wesentlichen Änderungen an diesem Kurs werden in dieser Datei dokumentiert.

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