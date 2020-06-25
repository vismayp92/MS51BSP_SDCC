# MS51BSP_SDCC
Nuvoton MS51 series BSP for Small Device C Compiler (SDCC). <br>
Now support MS51FB9AE_MS51XB9AE_MS51XB9BE (MS51_16K). Hello World tested. 

## Usage
 1. Refer to "SampleCode/Template/Project_temp/SDCC/". Simply clone and double click "buildall.bat".
 
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
 1. Add asm macro to replace intrins.h
 2. Add "buildall.bat".
 3. Add "loadflash.bat".
