# MS51BSP_SDCC
Nuvoton MS51 series BSP for Small Device C Compiler (SDCC). <br>
Now support MS51FB9AE_MS51XB9AE_MS51XB9BE (MS51_16K). Hello World tested. 

## Usage
 1. Download and install SDCC. Check "Add to system path" in the end of installation. <br>
    http://sdcc.sourceforge.net/
 2. Download and install Nuvoton Nu-Link command tool. Add to system path manually. <br>
    https://www.nuvoton.com/tool-and-software/software-development-tool/programmer
 3. Restart your computer.
 4. Refer to "SampleCode/Template/Project_temp/SDCC/". Simply clone and double click "buildall.bat".

## Nuvoton MS51FB9AE
 - It's a 25-cent 1T machine cycle enhanced 8051 microcontroller.
 - Internal 24MHz high-speed oscillator.
 - Internal 10KHz low-speed oscillator provide low power operating.
 - 16KB program flash with 128-Byte security protection area.
 - 256-Byte IRAM and additional 1KB XRAM.
 - 12-bit ADC, 16-bit PWM, two UART and one I2C.
 - Pin interrupt on most I/O pins.
 - Support ICP (In-circuit programming)
 - Support ISP (In-system programming)
 - Support IAP (In-application programming), provide EEPROM purpose.
 - Pin to pin compatible with N76E003AT20 and STM8S003.

## Change
 1. SFR define.
```
/* Keil */
sfr P0 = 0x80;
sbit P07 = P0^7;

/* SDCC */
__sfr __at (0x80) P0;
__sbit __at (0x87) P07;
```

 2. __code, __data, __xdata

## Add or replace
 1. Add asm macro to replace Keil's intrins.h
 2. Add "buildall.bat".
 3. Add "loadflash.bat".
 4. Add "putchar.c" for printf().
