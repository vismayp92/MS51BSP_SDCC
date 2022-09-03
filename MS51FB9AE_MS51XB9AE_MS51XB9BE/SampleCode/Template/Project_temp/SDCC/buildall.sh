#!/bin/bash

# Linux compilation script for sample helloworld program

set -e

if [ -z "$1" ]; then
	echo "ERROR: Invalid Syntax"
	echo "USAGE: ./buildall.sh <your_prog_name>"
	echo "EXAMPLE: ./buildall.sh helloworld"
	exit 1
fi

PRONAME=$1
LIBPATH="../../../../../Library"

# Choose your oscillator frequency.
#FOSC_160000
#FOSC_166000
T_FOSC="FOSC_240000"

mkdir -p Objects
cd ./Objects

# Compile individual libs
echo "INFO: Compiling libs ..."
sdcc -c ${LIBPATH}/StdDriver/src/common.c -I ${LIBPATH}/StdDriver/inc -I ${LIBPATH}/Device/Include -o ./common.rel
sdcc -c ${LIBPATH}/StdDriver/src/delay.c -I ${LIBPATH}/StdDriver/inc -I ${LIBPATH}/Device/Include -o ./delay.rel
sdcc -c ${LIBPATH}/StdDriver/src/eeprom.c -I ${LIBPATH}/StdDriver/inc -I ${LIBPATH}/Device/Include -o ./eeprom.rel
sdcc -c ${LIBPATH}/StdDriver/src/eeprom_sprom.c -I ${LIBPATH}/StdDriver/inc -I ${LIBPATH}/Device/Include -o ./eeprom_sprom.rel
sdcc -c ${LIBPATH}/StdDriver/src/IAP.c -I ${LIBPATH}/StdDriver/inc -I ${LIBPATH}/Device/Include -o ./IAP.rel
sdcc -c ${LIBPATH}/StdDriver/src/IAP_SPROM.c -I ${LIBPATH}/StdDriver/inc -I ${LIBPATH}/Device/Include -o ./IAP_SPROM.rel
sdcc -c ${LIBPATH}/StdDriver/src/isr.c -I ${LIBPATH}/StdDriver/inc -I ${LIBPATH}/Device/Include -o ./isr.rel
sdcc -c ${LIBPATH}/StdDriver/src/spi.c -I ${LIBPATH}/StdDriver/inc -I ${LIBPATH}/Device/Include -o ./spi.rel
sdcc -c ${LIBPATH}/StdDriver/src/sys.c -I ${LIBPATH}/StdDriver/inc -I ${LIBPATH}/Device/Include -o ./sys.rel
sdcc -c ${LIBPATH}/StdDriver/src/timer.c -I ${LIBPATH}/StdDriver/inc -I ${LIBPATH}/Device/Include -o ./timer.rel -D ${T_FOSC}
sdcc -c ${LIBPATH}/StdDriver/src/uart.c -I ${LIBPATH}/StdDriver/inc -I ${LIBPATH}/Device/Include -o ./uart.rel
sdcc -c ${LIBPATH}/StdDriver/src/watchdog.c -I ${LIBPATH}/StdDriver/inc -I ${LIBPATH}/Device/Include -o ./watchdog.rel
sdcc -c ${LIBPATH}/putchar.c -I ${LIBPATH}/StdDriver/inc -I ${LIBPATH}/Device/Include -o ./putchar.rel

# Linking the main program
echo; echo "INFO: Linking the program: ${PRONAME} ..."
rm -f ${PRONAME}.ihx
sdcc ../../${PRONAME}.c --iram-size 256 --xram-size 1024 putchar.rel sys.rel uart.rel -I ${LIBPATH}/StdDriver/inc -I ${LIBPATH}/Device/Include

cd ..

#Packing ihx
#rm -rf ${PRONAME}.hex
#echo; echo "INFO: Packing intel hex ..."
#packihx ${PRONAME}.ihx > ${PRONAME}.hex

# Generating nuvoton flashing compatible bin
echo; echo "INFO: Generating the main bin ..."
rm -f main.bin
sdobjcopy -Iihex -Obinary ./Objects/${PRONAME}.ihx main.bin

# Simulate

#echo; echo "Simulating the intel hex ..."
#s51 ${PRONAME}.hex

echo; echo "INFO: Done Processing ... Press Any key to Exit ..."
read no_input
