# BlinkLEDs Arduino Projekt

Dieses Projekt demonstriert das sequenzielle Blinken von vier LEDs auf einem Arduino.

## Funktionalität

Der Code schaltet nacheinander vier LEDs an den Pins 10-13 ein und aus:
- Jede LED leuchtet für 250ms
- Die Reihenfolge: Pin 13 → 12 → 11 → 10 → (wiederholt)
- Über die serielle Schnittstelle wird ausgegeben, welche LED gerade aktiv ist

## Hardware

- Arduino Uno/Nano (ATmega328P)
- 4 LEDs an Pins 10, 11, 12, 13
- Vorwiderstände für LEDs (220Ω empfohlen)

## Kompilierung

### Voraussetzungen
- avr-gcc Toolchain installiert
- Arduino IDE oder Arduino Core Dateien verfügbar

### Build-Befehle

```bash
# Projekt kompilieren und HEX-Datei erstellen
make

# Speicherverbrauch anzeigen
make size

# HEX-Datei Inhalt anzeigen
make hex

# Assembler-Code generieren (für Lernzwecke)
make asm

# Auf Arduino hochladen (COM-Port anpassen!)
make upload

# Aufräumen
make clean

# Hilfe anzeigen
make help
```

### Ausgabe-Dateien

Nach erfolgreicher Kompilierung finden Sie im `build/` Verzeichnis:
- `BlinkLEDs.hex` - Intel HEX-Datei für den Upload
- `BlinkLEDs.elf` - ELF-Datei mit Debug-Informationen
- `BlinkLEDs.asm` - Assembler-Listing (nach `make asm`)

## Konfiguration

Das Makefile ist für folgende Hardware konfiguriert:
- **MCU**: ATmega328P
- **Takt**: 16 MHz
- **Board**: Arduino Uno/Nano

Bei anderen Arduino-Boards müssen die entsprechenden Parameter im Makefile angepasst werden.

## Lernziele

Dieses Beispiel zeigt:
1. Arduino-Grundlagen (digitalWrite, delay, Serial)
2. Array-Verwendung für Pin-Verwaltung
3. Modulo-Operation für zyklische Wiederholung
4. Build-Prozess von Arduino-Code zu Maschinencode
5. Analyse der generierten HEX- und Assembler-Dateien