# BlinkLEDs Arduino Project Makefile
# Für ATmega328P (Arduino Uno/Nano)

# Projektname (muss mit .ino Datei übereinstimmen)
PROJECT = BlinkLEDs

# Mikrocontroller Konfiguration
MCU = atmega328p
F_CPU = 16000000UL
BOARD = arduino

# Arduino Pfade (aus IDE extrahiert)
ARDUINO_BASE = /home/sz/.arduino15/packages/arduino
ARDUINO_AVR_VERSION = 1.8.6
ARDUINO_CORE = $(ARDUINO_BASE)/hardware/avr/$(ARDUINO_AVR_VERSION)/cores/arduino
ARDUINO_VARIANT = $(ARDUINO_BASE)/hardware/avr/$(ARDUINO_AVR_VERSION)/variants/standard

# Compiler und Tools (exakte Pfade aus Arduino IDE)
ARDUINO_TOOLS = $(ARDUINO_BASE)/tools/avr-gcc/7.3.0-atmel3.6.1-arduino7/bin
CC = $(ARDUINO_TOOLS)/avr-gcc
CXX = $(ARDUINO_TOOLS)/avr-g++
OBJCOPY = $(ARDUINO_TOOLS)/avr-objcopy
OBJDUMP = $(ARDUINO_TOOLS)/avr-objdump
SIZE = $(ARDUINO_TOOLS)/avr-size
AR = $(ARDUINO_TOOLS)/avr-ar

# Compiler Flags (exakt wie Arduino IDE)
CFLAGS = -c -g -Os -w -std=gnu++11 -fpermissive -fno-exceptions -ffunction-sections -fdata-sections
CFLAGS += -fno-threadsafe-statics -Wno-error=narrowing -MMD -flto -mmcu=$(MCU) -DF_CPU=$(F_CPU)L
CFLAGS += -DARDUINO=10607 -DARDUINO_AVR_UNO -DARDUINO_ARCH_AVR
CXXFLAGS = $(CFLAGS)

# Linker Flags (wie Arduino IDE)
LDFLAGS = -w -Os -g -flto -fuse-linker-plugin -Wl,--gc-sections -mmcu=$(MCU)

# Include Pfade
INCLUDES = -I$(ARDUINO_CORE) -I$(ARDUINO_VARIANT)

# Verwende vorkompilierte Arduino Core (wie Arduino IDE)
PRECOMPILED_CORE = /home/sz/.cache/arduino/cores/arduino_avr_uno_3a9c044c476d4b5de6b80f4b3bb17278/core.a

# Projekt Dateien
PROJECT_SOURCES = $(PROJECT).ino
PROJECT_OBJECTS = build/$(PROJECT).o

# Standard Ziele
.PHONY: all clean upload size hex asm

all: build/$(PROJECT).hex

# Hauptziel: HEX-Datei erstellen
build/$(PROJECT).hex: build/$(PROJECT).elf
	@echo "Erstelle HEX-Datei..."
	$(OBJCOPY) -O ihex -R .eeprom build/$(PROJECT).elf build/$(PROJECT).hex
	@echo "HEX-Datei erstellt: build/$(PROJECT).hex"

# ELF-Datei linken
build/$(PROJECT).elf: $(PROJECT_OBJECTS)
	@echo "Linke ELF-Datei..."
	$(CC) $(LDFLAGS) -o $@ $^ $(PRECOMPILED_CORE) -lm

# Arduino .ino zu .cpp konvertieren und kompilieren
build/$(PROJECT).o: $(PROJECT).ino | build
	@echo "Kompiliere $(PROJECT).ino..."
	@echo '#include "Arduino.h"' > build/$(PROJECT).cpp
	@cat $(PROJECT).ino >> build/$(PROJECT).cpp
	$(CXX) $(CXXFLAGS) $(INCLUDES) -c build/$(PROJECT).cpp -o $@

# Build-Verzeichnisse erstellen
build:
	mkdir -p build

# Größeninformationen anzeigen
size: build/$(PROJECT).elf
	@echo "Speicherverbrauch:"
	$(SIZE) -A build/$(PROJECT).elf

# Assembler-Code generieren (für Lernzwecke)
asm: build/$(PROJECT).elf
	@echo "Generiere Assembler-Listing..."
	$(OBJDUMP) -d build/$(PROJECT).elf > build/$(PROJECT).asm
	@echo "Assembler-Code: build/$(PROJECT).asm"

# HEX-Datei anzeigen (formatiert)
hex: build/$(PROJECT).hex
	@echo "HEX-Datei Inhalt:"
	@cat build/$(PROJECT).hex

# Upload per avrdude (COM-Port anpassen!)
upload: build/$(PROJECT).hex
	avrdude -p$(MCU) -carduino -P/dev/ttyUSB0 -b115200 -D -Uflash:w:build/$(PROJECT).hex:i

# Aufräumen
clean:
	rm -rf build/

# Hilfe
help:
	@echo "Verfügbare Ziele:"
	@echo "  all     - Kompiliert das Projekt und erstellt die HEX-Datei"
	@echo "  hex     - Zeigt den Inhalt der HEX-Datei an"
	@echo "  asm     - Generiert Assembler-Listing für Analyse"
	@echo "  size    - Zeigt Speicherverbrauch an"
	@echo "  upload  - Upload auf Arduino (Port anpassen!)"
	@echo "  clean   - Löscht alle generierten Dateien"
	@echo "  help    - Zeigt diese Hilfe an"

# Automatische Abhängigkeiten
-include $(shell find build -name "*.d" 2>/dev/null)