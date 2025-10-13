# Digitale Systeme / Eingebettete Systeme

[![LiaScript](https://raw.githubusercontent.com/LiaScript/LiaScript/master/badges/course.svg)](https://liascript.github.io/course/?https://raw.githubusercontent.com/TUBAF-IfI-LiaScript/VL_EingebetteteSysteme/master/)

**Interaktiver Kurs für Informatik-Studierende im 1. Semester**

## 📚 Kursübersicht

Dieser Kurs vermittelt die Grundlagen digitaler Systeme vom theoretischen Fundament bis zur praktischen Implementierung auf Mikrocontrollern. Der Aufbau folgt einem systematischen Bottom-Up-Ansatz:

### 🎯 Lernziele

- Verstehen der Teilkomponenten eines Rechners ausgehend von Schaltnetzen/-werken
- Selbstständiges Entwerfen ausschnittweiser Rechner-Teilelemente
- Praktische Programmierung eingebetteter Systeme mit AVR-Mikrocontrollern

### 📖 Vorlesungsstruktur (16 Sessions)

| Nr. | Thema | Schwerpunkt |
|-----|-------|-------------|
| [00](00_Einfuehrung.md) | Einführung | Motivation und Organisation |
| [01](01_HistorischerUeberblick.md) | Historischer Überblick | Entwicklung der Rechentechnik |
| [02](02_BoolscheAlgebra.md) | Boolesche Algebra | Theoretische Grundlagen |
| [03](03_Minimierung.md) | Minimierung | Karnaugh-Veitch-Diagramme |
| [04](04_Schaltnetze.md) | Schaltnetze | Quine-McCluskey-Verfahren |
| [05](05_Standardschaltnetze.md) | Standardschaltnetze | Multiplexer, Decoder, Encoder |
| [06](06_FlipFlops.md) | FlipFlops | Sequenzielle Logik |
| [07](07_Schaltwerke.md) | Schaltwerke | Endliche Automaten |
| [08](08_StandardSchaltwerke.md) | Standardschaltwerke | Register, Zähler |
| [09](09_Rechnerarithmetik.md) | Rechnerarithmetik | Zahlensysteme, Addierer |
| [10](10_CPU_Basis.md) | CPU-Grundlagen | ALU, Von-Neumann-Architektur |
| [11](11_Modell_CPU.md) | Modell-CPU | Praktische CPU-Simulation |
| **12** | **Pipeline** | **⚠️ Noch zu erstellen** |
| [13](13_AVR_CPU.md) | AVR-CPU | Mikrocontroller-Programmierung |
| [14](14_ADC.md) | Analog-Digital-Wandler | Sensorik |
| [15](15_TimerUndInterrupts.md) | Timer & Interrupts | Echtzeit-Programmierung |
| [16](16_Aktoren.md) | Aktoren | Servo- und Schrittmotoren |

## 🛠 Interaktive Features

### Simulatoren
- **DigiSim**: Digitale Schaltungssimulation
- **AVR8js**: AVR-Mikrocontroller-Simulation im Browser
- **NetSwarm**: Netzwerk-Simulationen

### Praktische Beispiele
- Arduino-basierte Projekte
- AVR-Assembler-Programme
- Hardware-nahe C-Programmierung

## 🚀 Kurs starten

### Online (Empfohlen)
Klicken Sie auf das LiaScript-Badge oben oder besuchen Sie:
```
https://liascript.github.io/course/?https://raw.githubusercontent.com/TUBAF-IfI-LiaScript/VL_EingebetteteSysteme/master/00_Einfuehrung.md
```

### Lokal
```bash
git clone https://github.com/TUBAF-IfI-LiaScript/VL_EingebetteteSysteme.git
```

## 📁 Repository-Struktur

```
├── 00_Einfuehrung.md              # Kurseinführung
├── 01_HistorischerUeberblick.md   # Geschichte der Rechentechnik
├── ...                            # Weitere Vorlesungen
├── 16_Aktoren.md                  # Aktor-Ansteuerung
├── exampleCode/                   # Praktische Beispiele
├── files/                         # Schaltungsdateien
├── images/                        # Grafiken und Diagramme
├── material/                      # Zusätzliche Materialien
├── programs/                      # Interaktive Tools
├── config.md                      # Kurs-Konfiguration
└── CHANGELOG.md                   # Änderungsverlauf
```

## 🔄 Aktuelle Version

**Version 0.1.0** (Oktober 2025)
- Vollständig überarbeitete Tabellen-Struktur
- Korrigierte Links und Metadaten
- Verbesserte Inhaltsbeschreibungen

Siehe [CHANGELOG.md](CHANGELOG.md) für detaillierte Änderungen.

## 👥 Team

### 🎓 Hauptautoren (alle 16 Vorlesungen)
- **Prof. Sebastian Zug** - Kursleitung und Inhalte  
  📧 sebastian.zug@informatik.tu-freiberg.de
- **André Dietrich** - LiaScript-Integration und technische Umsetzung  
  📧 andre.dietrich@informatik.tu-freiberg.de  
- **Fabian Bär** - Studentische Mitarbeit und Beispielcodes  
  📧 fabian.baer@student.tu-freiberg.de

### 👨‍💻 Community-Mitwirkende
*Basierend auf Git-Historie - **30 verschiedene Autoren** haben beigetragen:*

**🏆 Top Contributors (10+ Commits):**
- **Fabian Bär** - 50 Commits (Git: fjangfaragesh + Fabian Bär)
- **Tylona** - 37 Commits  
- **fb89zila** - 33 Commits
- **Gernot Zacharias** - 10 Commits

**📝 Aktive Mitwirkende (5+ Commits):**
- **gelbeforelle** - 6 Commits
- **Florian2501** - 5 Commits
- **Leander Jakschik** - 5 Commits

**🔧 Header-Erwähnte Mitwirkende:**
- **FnHm**, **gjaeger1**, **ShyFlyGuy**, **Lalelele** - Co-Autoren in Datei-Headern

**👥 Weitere 19 Community-Mitglieder** mit kleineren Beiträgen

### 📋 Autorschafts-Details
- **Git-Repository**: 30 verschiedene Autoren, 356+ Commits von Sebastian Zug (Hauptautor)
- **Datei-Header**: Sebastian Zug & André Dietrich & Fabian Bär (Standard-Autorschaft)
- **Community-Beiträge**: Besonders stark von studentischen GitHub-Usern geprägt

### 🤖 KI-Unterstützung
- **GitHub Copilot Teaching-Agent** - Strukturelle Verbesserungen und didaktische Optimierung (ab 2025-10-13)

## 📧 Kontakt

- **E-Mail**: sebastian.zug@informatik.tu-freiberg.de
- **Institution**: Technische Universität Bergakademie Freiberg
- **GitHub**: [TUBAF-IfI-LiaScript](https://github.com/TUBAF-IfI-LiaScript)

## 📄 Lizenz

Dieser Kurs steht unter einer offenen Lizenz. Weitere Details finden Sie in der jeweiligen Lizenz-Datei.

---

*Powered by [LiaScript](https://liascript.github.io) - Interactive Markdown for Education*