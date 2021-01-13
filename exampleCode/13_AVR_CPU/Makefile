TARGET  = main

CTRL    = atmega328p
STK     = arduino

CC      = avr-gcc
OC      = avr-objcopy
CPFLAGS = -mno-interrupts
LDFLAGS = -j .text -j .data

AVRDUDE = avrdude
AVRDUDE_FLAGS = -P /dev/ttyUSB0
AVRDUDE_FLAGS += -B 57600
AVRDUDE_FLAGS += -c $(STK)
AVRDUDE_FLAGS += -p m328p
AVRDUDE_FLAGS += -v -D -U flash:w:$(TARGET).hex:i

.PHONY: all

all:
	@echo "compiling"
	$(CC) -c -o $(TARGET).o  $(CPFLAGS) -Os -mmcu=$(CTRL) $(TARGET).c
	@echo "linking"
	@$(CC) -mmcu=$(CTRL) $(TARGET).o -o $(TARGET).elf
	@echo "generate properly output format"
	@$(OC) $(LDFLAGS) -O ihex $(TARGET).elf $(TARGET).hex
	avr-size --mcu=$(CTRL) $(TARGET).elf

program: all
	@echo "Programing the device"
	@echo  $(AVRDUDE_FLAGS)
	$(AVRDUDE) $(AVRDUDE_FLAGS)

asm:	all
	@echo "Generating assembler code"
	avr-objdump -d -S $(TARGET).elf >  $(TARGET).asm
	
clean:
	@echo "Cleaning"
	@rm -rf $(TARGET).hex $(TARGET).o $(TARGET).elf *~

com:    program
	@echo "Opening Serial connection"
	gtkterm -p /dev/ttyACM0 -s 9600 -r "-"
