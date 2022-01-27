EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 6 10
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Text HLabel 10400 2900 2    50   Output ~ 0
Mac~AS~
Text HLabel 10400 2300 2    50   Output ~ 0
Mac~VMA~
Text HLabel 10400 2600 2    50   Input ~ 0
Mac~DTACK~
Text HLabel 10400 2500 2    50   Input ~ 0
Mac~VPA~
Text HLabel 10400 2400 2    50   Input ~ 0
Mac~BERR~
Text HLabel 8400 3600 0    50   Input ~ 0
MacE
Text Label 8400 2000 2    50   ~ 0
A22
Text Label 8400 1900 2    50   ~ 0
A21
Text Label 8400 1800 2    50   ~ 0
A20
Text Label 8400 1700 2    50   ~ 0
A19
Text Label 8400 1600 2    50   ~ 0
A18
Text Label 8400 1500 2    50   ~ 0
A17
Text Label 8400 1400 2    50   ~ 0
A16
Text HLabel 8400 3400 0    50   Input ~ 0
C8M
Text HLabel 8400 2100 0    50   Input ~ 0
C16M
Text HLabel 10400 1100 2    50   Output ~ 0
ROM~CS~
Text HLabel 10400 2800 2    50   Output ~ 0
Mac~UDS~
Text HLabel 10400 2700 2    50   Output ~ 0
Mac~LDS~
Text HLabel 8400 3900 0    50   Input ~ 0
AccR~W~
Text HLabel 8400 4600 0    50   Output ~ 0
Dout~OE~
Text HLabel 8400 4500 0    50   Output ~ 0
Aout~OE~
Text HLabel 8400 4700 0    50   Output ~ 0
Din~OE~
Text HLabel 10400 3200 2    50   Output ~ 0
DinLE
Text HLabel 10400 4600 2    50   Output ~ 0
~RAS~
Text HLabel 10400 4700 2    50   Output ~ 0
L~WE~
Text HLabel 10400 4800 2    50   Output ~ 0
U~WE~
Text HLabel 8400 5000 0    50   Output ~ 0
Acc~VPA~
Text HLabel 8400 4100 0    50   Input ~ 0
Acc~AS~
Text HLabel 8400 4000 0    50   Input ~ 0
Acc~LDS~
Text HLabel 8400 4200 0    50   Input ~ 0
Acc~UDS~
Text HLabel 8400 4900 0    50   Output ~ 0
Acc~BERR~
Text HLabel 8400 3800 0    50   Output ~ 0
Acc~DTACK
Text Label 8400 1300 2    50   ~ 0
A15
Text Label 8400 1200 2    50   ~ 0
A14
Text Label 8400 1100 2    50   ~ 0
A13
Text Label 8400 3200 2    50   ~ 0
A12
Text Label 8400 3100 2    50   ~ 0
A11
Text Label 8400 3000 2    50   ~ 0
A10
Text Label 8400 2900 2    50   ~ 0
A9
Text Label 8400 2800 2    50   ~ 0
A8
Text Label 8400 2700 2    50   ~ 0
A7
Text Label 8400 2600 2    50   ~ 0
A6
Text Label 8400 2500 2    50   ~ 0
A5
Entry Wire Line
	10700 3700 10600 3800
Entry Wire Line
	10700 3800 10600 3900
Entry Wire Line
	10700 3600 10600 3700
Wire Wire Line
	10400 3700 10600 3700
Wire Wire Line
	10400 4500 10600 4500
Text Label 10400 4500 0    50   ~ 0
RA11
Text Label 10400 3700 0    50   ~ 0
RA8
Wire Wire Line
	8400 3200 8100 3200
Wire Wire Line
	8400 3100 8100 3100
Wire Wire Line
	8400 3000 8100 3000
Wire Wire Line
	8400 2800 8100 2800
Wire Wire Line
	8400 2700 8100 2700
Wire Wire Line
	8400 2600 8100 2600
Wire Wire Line
	8400 2500 8100 2500
Wire Wire Line
	8400 1100 8100 1100
Wire Wire Line
	8400 2900 8100 2900
Wire Bus Line
	8000 1000 7950 1000
Entry Wire Line
	8000 1700 8100 1800
Entry Wire Line
	8000 1800 8100 1900
Wire Wire Line
	8400 2000 8100 2000
Wire Wire Line
	8400 1900 8100 1900
Entry Wire Line
	8000 1400 8100 1500
Entry Wire Line
	8000 1600 8100 1700
Wire Wire Line
	8400 1800 8100 1800
Wire Wire Line
	8400 1600 8100 1600
Entry Wire Line
	8000 1200 8100 1300
Entry Wire Line
	8000 1300 8100 1400
Wire Wire Line
	8400 1500 8100 1500
Wire Wire Line
	8400 1400 8100 1400
Entry Wire Line
	8000 1000 8100 1100
Entry Wire Line
	8000 1100 8100 1200
Wire Wire Line
	8400 1300 8100 1300
Wire Wire Line
	8400 1200 8100 1200
Entry Wire Line
	8000 1900 8100 2000
Text HLabel 7950 1000 0    50   Input ~ 0
A[23..1]
Entry Wire Line
	8000 1500 8100 1600
Wire Wire Line
	8400 1700 8100 1700
$Comp
L Device:C_Small C?
U 1 1 616131D5
P 4700 7450
AR Path="/616131D5" Ref="C?"  Part="1" 
AR Path="/5F723173/616131D5" Ref="C27"  Part="1" 
F 0 "C27" H 4750 7500 50  0000 L CNN
F 1 "2u2" H 4750 7400 50  0000 L CNN
F 2 "stdpads:C_0603" H 4700 7450 50  0001 C CNN
F 3 "~" H 4700 7450 50  0001 C CNN
F 4 "C23630" H 4700 7450 50  0001 C CNN "LCSC Part"
	1    4700 7450
	1    0    0    -1  
$EndComp
Wire Wire Line
	4300 7350 4700 7350
Connection ~ 4700 7350
Wire Wire Line
	4700 7350 5100 7350
Wire Wire Line
	4300 7550 4700 7550
Connection ~ 4700 7550
Wire Wire Line
	4700 7550 5100 7550
$Comp
L Device:C_Small C?
U 1 1 616131E1
P 5100 7450
AR Path="/616131E1" Ref="C?"  Part="1" 
AR Path="/5F723173/616131E1" Ref="C28"  Part="1" 
F 0 "C28" H 5150 7500 50  0000 L CNN
F 1 "2u2" H 5150 7400 50  0000 L CNN
F 2 "stdpads:C_0603" H 5100 7450 50  0001 C CNN
F 3 "~" H 5100 7450 50  0001 C CNN
F 4 "C23630" H 5100 7450 50  0001 C CNN "LCSC Part"
	1    5100 7450
	1    0    0    -1  
$EndComp
Connection ~ 5100 7350
Wire Wire Line
	5100 7350 5500 7350
Connection ~ 5100 7550
Wire Wire Line
	5100 7550 5500 7550
$Comp
L Device:C_Small C?
U 1 1 616131EB
P 5500 7450
AR Path="/616131EB" Ref="C?"  Part="1" 
AR Path="/5F723173/616131EB" Ref="C29"  Part="1" 
F 0 "C29" H 5550 7500 50  0000 L CNN
F 1 "2u2" H 5550 7400 50  0000 L CNN
F 2 "stdpads:C_0603" H 5500 7450 50  0001 C CNN
F 3 "~" H 5500 7450 50  0001 C CNN
F 4 "C23630" H 5500 7450 50  0001 C CNN "LCSC Part"
	1    5500 7450
	1    0    0    -1  
$EndComp
Connection ~ 5500 7350
Wire Wire Line
	5500 7350 5900 7350
Connection ~ 5500 7550
Wire Wire Line
	5500 7550 5900 7550
$Comp
L power:+3V3 #PWR?
U 1 1 616131F5
P 4300 7350
AR Path="/616131F5" Ref="#PWR?"  Part="1" 
AR Path="/5F723173/616131F5" Ref="#PWR0158"  Part="1" 
F 0 "#PWR0158" H 4300 7200 50  0001 C CNN
F 1 "+3V3" H 4300 7500 50  0000 C CNN
F 2 "" H 4300 7350 50  0001 C CNN
F 3 "" H 4300 7350 50  0001 C CNN
	1    4300 7350
	1    0    0    -1  
$EndComp
Connection ~ 4300 7350
$Comp
L Device:C_Small C?
U 1 1 616131FC
P 4300 7450
AR Path="/616131FC" Ref="C?"  Part="1" 
AR Path="/5F723173/616131FC" Ref="C26"  Part="1" 
F 0 "C26" H 4350 7500 50  0000 L CNN
F 1 "2u2" H 4350 7400 50  0000 L CNN
F 2 "stdpads:C_0603" H 4300 7450 50  0001 C CNN
F 3 "~" H 4300 7450 50  0001 C CNN
F 4 "C23630" H 4300 7450 50  0001 C CNN "LCSC Part"
	1    4300 7450
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C?
U 1 1 61613208
P 6300 7450
AR Path="/61613208" Ref="C?"  Part="1" 
AR Path="/5F723173/61613208" Ref="C31"  Part="1" 
F 0 "C31" H 6350 7500 50  0000 L CNN
F 1 "2u2" H 6350 7400 50  0000 L CNN
F 2 "stdpads:C_0603" H 6300 7450 50  0001 C CNN
F 3 "~" H 6300 7450 50  0001 C CNN
F 4 "C23630" H 6300 7450 50  0001 C CNN "LCSC Part"
	1    6300 7450
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C?
U 1 1 6161320E
P 5900 7450
AR Path="/6161320E" Ref="C?"  Part="1" 
AR Path="/5F723173/6161320E" Ref="C30"  Part="1" 
F 0 "C30" H 5950 7500 50  0000 L CNN
F 1 "2u2" H 5950 7400 50  0000 L CNN
F 2 "stdpads:C_0603" H 5900 7450 50  0001 C CNN
F 3 "~" H 5900 7450 50  0001 C CNN
F 4 "C23630" H 5900 7450 50  0001 C CNN "LCSC Part"
	1    5900 7450
	1    0    0    -1  
$EndComp
Connection ~ 5900 7350
Wire Wire Line
	5900 7350 6300 7350
Connection ~ 6300 7550
Connection ~ 5900 7550
Wire Wire Line
	5900 7550 6300 7550
$Comp
L power:GND #PWR?
U 1 1 616151A9
P 6700 7550
AR Path="/616151A9" Ref="#PWR?"  Part="1" 
AR Path="/5F723173/616151A9" Ref="#PWR0159"  Part="1" 
F 0 "#PWR0159" H 6700 7300 50  0001 C CNN
F 1 "GND" H 6700 7400 50  0000 C CNN
F 2 "" H 6700 7550 50  0001 C CNN
F 3 "" H 6700 7550 50  0001 C CNN
	1    6700 7550
	-1   0    0    -1  
$EndComp
$Comp
L Device:C_Small C?
U 1 1 616151AF
P 6700 7450
AR Path="/616151AF" Ref="C?"  Part="1" 
AR Path="/5F723173/616151AF" Ref="C32"  Part="1" 
F 0 "C32" H 6750 7500 50  0000 L CNN
F 1 "2u2" H 6750 7400 50  0000 L CNN
F 2 "stdpads:C_0603" H 6700 7450 50  0001 C CNN
F 3 "~" H 6700 7450 50  0001 C CNN
F 4 "C23630" H 6700 7450 50  0001 C CNN "LCSC Part"
	1    6700 7450
	1    0    0    -1  
$EndComp
Wire Wire Line
	6300 7350 6700 7350
Connection ~ 6700 7550
Wire Wire Line
	6300 7550 6700 7550
Connection ~ 6300 7350
$Comp
L power:+3V3 #PWR0160
U 1 1 6164065B
P 9100 800
F 0 "#PWR0160" H 9100 650 50  0001 C CNN
F 1 "+3V3" H 9100 950 50  0000 C CNN
F 2 "" H 9100 800 50  0001 C CNN
F 3 "" H 9100 800 50  0001 C CNN
	1    9100 800 
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0161
U 1 1 6164325E
P 9800 6200
F 0 "#PWR0161" H 9800 5950 50  0001 C CNN
F 1 "GND" H 9800 6050 50  0000 C CNN
F 2 "" H 9800 6200 50  0001 C CNN
F 3 "" H 9800 6200 50  0001 C CNN
	1    9800 6200
	1    0    0    -1  
$EndComp
Text HLabel 8400 3700 0    50   Input ~ 0
FCLK
Text HLabel 10400 3100 2    50   Output ~ 0
ADoutLE0
Text HLabel 10400 3000 2    50   Output ~ 0
ADoutLE1
Text HLabel 8400 4800 0    50   Input ~ 0
~RESET~
Entry Wire Line
	10700 4400 10600 4500
Wire Bus Line
	10700 3300 10750 3300
Text HLabel 10750 3300 2    50   Output ~ 0
RA[11..0]
Connection ~ 9700 6200
Wire Wire Line
	9600 6200 9500 6200
Connection ~ 9600 6200
Connection ~ 9500 6200
Wire Wire Line
	9500 6200 9400 6200
Wire Wire Line
	9400 6200 9300 6200
Connection ~ 9400 6200
Connection ~ 9300 6200
Wire Wire Line
	9300 6200 9200 6200
Wire Wire Line
	9200 6200 9100 6200
Connection ~ 9200 6200
Connection ~ 9800 6200
Wire Wire Line
	9700 6200 9600 6200
Wire Wire Line
	9800 6200 9700 6200
Connection ~ 9600 800 
Wire Wire Line
	9600 800  9700 800 
Wire Wire Line
	9500 800  9600 800 
Connection ~ 9500 800 
Connection ~ 9400 800 
Wire Wire Line
	9400 800  9500 800 
Wire Wire Line
	9300 800  9400 800 
Connection ~ 9300 800 
Connection ~ 9200 800 
Connection ~ 9100 800 
Wire Wire Line
	9200 800  9300 800 
Wire Wire Line
	9100 800  9200 800 
$Comp
L CPLD_Xilinx:XC95144XL-TQ100 U1
U 1 1 6318B3C7
P 9400 3500
F 0 "U1" H 9400 3800 50  0000 C CNN
F 1 "XC95144XL-TQ100" H 9400 3700 50  0000 C CNN
F 2 "stdpads:TQFP-100_14x14mm_P0.5mm" H 9400 3500 50  0001 C CNN
F 3 "https://www.xilinx.com/support/documentation/data_sheets/ds056.pdf" H 9400 3500 50  0001 C CNN
F 4 "C45126" H 9400 3500 50  0001 C CNN "LCSC Part"
	1    9400 3500
	1    0    0    -1  
$EndComp
Text Label 8400 5400 2    50   ~ 0
A4
Text Label 8400 5300 2    50   ~ 0
A3
Text Label 8400 5200 2    50   ~ 0
A2
Text Label 8400 5100 2    50   ~ 0
A1
Entry Wire Line
	8000 2800 8100 2900
Entry Wire Line
	8000 3000 8100 3100
Entry Wire Line
	8000 2600 8100 2700
Entry Wire Line
	8000 2700 8100 2800
Entry Wire Line
	8000 2400 8100 2500
Entry Wire Line
	8000 2500 8100 2600
Entry Wire Line
	8000 2900 8100 3000
Entry Wire Line
	8000 3100 8100 3200
Text Label 8400 3500 2    50   ~ 0
A23
Entry Wire Line
	8000 5000 8100 5100
Entry Wire Line
	8000 5200 8100 5300
Entry Wire Line
	8000 5100 8100 5200
Entry Wire Line
	8000 5300 8100 5400
Wire Wire Line
	8100 5400 8400 5400
Wire Wire Line
	8100 5100 8400 5100
Wire Wire Line
	8100 5300 8400 5300
Wire Wire Line
	8100 5200 8400 5200
Wire Wire Line
	8400 3500 8100 3500
Entry Wire Line
	8000 3400 8100 3500
Wire Wire Line
	10600 3800 10400 3800
Text Label 10400 3900 0    50   ~ 0
RA9
Text Label 10400 3800 0    50   ~ 0
RA10
Wire Wire Line
	10400 3900 10600 3900
Entry Wire Line
	10700 1500 10600 1600
Entry Wire Line
	10700 1600 10600 1700
Entry Wire Line
	10700 1800 10600 1900
Entry Wire Line
	10700 1700 10600 1800
Entry Wire Line
	10700 3400 10600 3500
Entry Wire Line
	10700 3300 10600 3400
Entry Wire Line
	10700 3500 10600 3600
Wire Wire Line
	10400 3400 10600 3400
Text Label 10400 3400 0    50   ~ 0
RA1
Text Label 10400 3600 0    50   ~ 0
RA0
Wire Wire Line
	10600 3600 10400 3600
Text Label 10400 1800 0    50   ~ 0
RA2
Text Label 10400 1600 0    50   ~ 0
RA3
Text Label 10400 1500 0    50   ~ 0
RA4
Text Label 10400 1700 0    50   ~ 0
RA5
Text Label 10400 1900 0    50   ~ 0
RA6
Text Label 10400 3500 0    50   ~ 0
RA7
Wire Wire Line
	10400 3500 10600 3500
Wire Wire Line
	10400 1900 10600 1900
Wire Wire Line
	10400 1700 10600 1700
Wire Wire Line
	10400 1500 10600 1500
Wire Wire Line
	10400 1600 10600 1600
Wire Wire Line
	10400 1800 10600 1800
Text HLabel 10400 1300 2    50   Output ~ 0
~OE~
Text HLabel 10400 1200 2    50   Output ~ 0
~CAS~
Text HLabel 8400 4300 0    50   Output ~ 0
ROM~WE~
Wire Bus Line
	10700 1400 10750 1400
Text HLabel 10750 1400 2    50   Output ~ 0
RA[11..0]
Entry Wire Line
	10700 1400 10600 1500
Text HLabel 10400 4900 2    50   Input ~ 0
SW0
Text HLabel 10400 4200 2    50   Input ~ 0
SW1
Text HLabel 10400 4100 2    50   Output ~ 0
CKEN
Text HLabel 10400 5600 2    50   Input ~ 0
TDI
Text HLabel 10400 5700 2    50   Input ~ 0
TMS
Text HLabel 10400 5800 2    50   Input ~ 0
TCK
Text HLabel 10400 5900 2    50   Output ~ 0
TDO
NoConn ~ 8400 2300
NoConn ~ 8400 2400
Text HLabel 10400 4300 2    50   Input ~ 0
SW2
Wire Bus Line
	10700 1400 10700 1800
Wire Bus Line
	10700 3300 10700 4400
Wire Bus Line
	8000 1000 8000 5300
$EndSCHEMATC
