EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 5 10
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L CPU_NXP_68000:MC68000FN U14
U 1 1 6187DB31
P 2300 3600
F 0 "U14" H 2300 5650 50  0000 C CNN
F 1 "MC68HC000FN20" H 2300 5550 50  0000 C CNN
F 2 "stdpads:PLCC-68" H 1550 5850 50  0001 C CNN
F 3 "http://www.nxp.com/files/32bit/doc/ref_manual/MC68000UM.pdf" H 2300 3600 50  0001 C CNN
	1    2300 3600
	1    0    0    -1  
$EndComp
Text HLabel 1300 3300 0    50   Input ~ 0
~VPA~
Text HLabel 1300 4300 0    50   Input ~ 0
~DTACK~
Text HLabel 3300 5800 2    50   Output ~ 0
R~W~
Text HLabel 3300 5700 2    50   Output ~ 0
~LDS~
Text HLabel 3300 5600 2    50   Output ~ 0
~UDS~
Text HLabel 3300 5500 2    50   Output ~ 0
~AS~
Text HLabel 1300 5000 0    50   BiDi ~ 0
~RESET~
Text HLabel 1300 1700 0    50   Input ~ 0
~IPL~0
Text HLabel 1300 1800 0    50   Input ~ 0
~IPL~1
Text HLabel 1300 1900 0    50   Input ~ 0
~IPL~2
Text HLabel 1300 4100 0    50   Input ~ 0
~BERR~
Text HLabel 1300 1400 0    50   Input ~ 0
CLK
Text Label 3300 3800 0    50   ~ 0
D0
Text Label 3300 3900 0    50   ~ 0
D1
Text Label 3300 4000 0    50   ~ 0
D2
Text Label 3300 4100 0    50   ~ 0
D3
Text Label 3300 4200 0    50   ~ 0
D4
Text Label 3300 4300 0    50   ~ 0
D5
Text Label 3300 4400 0    50   ~ 0
D6
Text Label 3300 4500 0    50   ~ 0
D7
Text Label 3300 4600 0    50   ~ 0
D8
Text Label 3300 4700 0    50   ~ 0
D9
Text Label 3300 4800 0    50   ~ 0
D10
Text Label 3300 4900 0    50   ~ 0
D11
Text Label 3300 5000 0    50   ~ 0
D12
Text Label 3300 5100 0    50   ~ 0
D13
Text Label 3300 5200 0    50   ~ 0
D14
Text Label 3300 5300 0    50   ~ 0
D15
Wire Wire Line
	3300 5300 3500 5300
Wire Wire Line
	3300 5200 3500 5200
Wire Wire Line
	3300 5100 3500 5100
Wire Wire Line
	3300 5000 3500 5000
Wire Wire Line
	3300 4900 3500 4900
Wire Wire Line
	3300 4800 3500 4800
Wire Wire Line
	3300 4700 3500 4700
Wire Wire Line
	3300 4600 3500 4600
Wire Wire Line
	3300 4500 3500 4500
Wire Wire Line
	3300 4400 3500 4400
Wire Wire Line
	3300 4300 3500 4300
Wire Wire Line
	3300 4200 3500 4200
Wire Wire Line
	3300 4100 3500 4100
Wire Wire Line
	3300 4000 3500 4000
Wire Wire Line
	3300 3900 3500 3900
Wire Wire Line
	3300 3800 3500 3800
Entry Wire Line
	3500 5300 3600 5400
Entry Wire Line
	3500 5200 3600 5300
Entry Wire Line
	3500 5100 3600 5200
Entry Wire Line
	3500 5000 3600 5100
Entry Wire Line
	3500 4900 3600 5000
Entry Wire Line
	3500 4800 3600 4900
Entry Wire Line
	3500 4700 3600 4800
Entry Wire Line
	3500 4600 3600 4700
Entry Wire Line
	3500 4500 3600 4600
Entry Wire Line
	3500 4400 3600 4500
Entry Wire Line
	3500 4300 3600 4400
Entry Wire Line
	3500 4200 3600 4300
Entry Wire Line
	3500 4100 3600 4200
Entry Wire Line
	3500 4000 3600 4100
Entry Wire Line
	3500 3900 3600 4000
Entry Wire Line
	3500 3800 3600 3900
Text HLabel 3650 3900 2    50   BiDi ~ 0
D[15..0]
Wire Wire Line
	3300 2900 3500 2900
Wire Wire Line
	3300 2800 3500 2800
Wire Wire Line
	3300 2700 3500 2700
Wire Wire Line
	3300 2600 3500 2600
Wire Wire Line
	3300 2500 3500 2500
Wire Wire Line
	3300 2400 3500 2400
Wire Wire Line
	3300 2300 3500 2300
Wire Wire Line
	3300 2200 3500 2200
Wire Wire Line
	3300 2100 3500 2100
Wire Wire Line
	3300 2000 3500 2000
Wire Wire Line
	3300 1900 3500 1900
Wire Wire Line
	3300 1800 3500 1800
Wire Wire Line
	3300 1700 3500 1700
Wire Wire Line
	3300 1600 3500 1600
Wire Wire Line
	3300 1500 3500 1500
Wire Wire Line
	3300 1400 3500 1400
Entry Wire Line
	3500 2900 3600 3000
Entry Wire Line
	3500 2800 3600 2900
Entry Wire Line
	3500 2700 3600 2800
Entry Wire Line
	3500 2600 3600 2700
Entry Wire Line
	3500 2500 3600 2600
Entry Wire Line
	3500 2400 3600 2500
Entry Wire Line
	3500 2300 3600 2400
Entry Wire Line
	3500 2200 3600 2300
Entry Wire Line
	3500 2100 3600 2200
Entry Wire Line
	3500 2000 3600 2100
Entry Wire Line
	3500 1900 3600 2000
Entry Wire Line
	3500 1800 3600 1900
Entry Wire Line
	3500 1700 3600 1800
Entry Wire Line
	3500 1600 3600 1700
Entry Wire Line
	3500 1500 3600 1600
Entry Wire Line
	3500 1400 3600 1500
Wire Wire Line
	3300 3600 3500 3600
Wire Wire Line
	3300 3500 3500 3500
Wire Wire Line
	3300 3400 3500 3400
Wire Wire Line
	3300 3300 3500 3300
Wire Wire Line
	3300 3200 3500 3200
Wire Wire Line
	3300 3100 3500 3100
Wire Wire Line
	3300 3000 3500 3000
Entry Wire Line
	3500 3600 3600 3700
Entry Wire Line
	3500 3500 3600 3600
Entry Wire Line
	3500 3400 3600 3500
Entry Wire Line
	3500 3300 3600 3400
Entry Wire Line
	3500 3200 3600 3300
Entry Wire Line
	3500 3100 3600 3200
Entry Wire Line
	3500 3000 3600 3100
Text Label 3300 1400 0    50   ~ 0
A1
Text Label 3300 1500 0    50   ~ 0
A2
Text Label 3300 1600 0    50   ~ 0
A3
Text Label 3300 1700 0    50   ~ 0
A4
Text Label 3300 1800 0    50   ~ 0
A5
Text Label 3300 1900 0    50   ~ 0
A6
Text Label 3300 2000 0    50   ~ 0
A7
Text Label 3300 2100 0    50   ~ 0
A8
Text Label 3300 2200 0    50   ~ 0
A9
Text Label 3300 2300 0    50   ~ 0
A10
Text Label 3300 2400 0    50   ~ 0
A11
Text Label 3300 2500 0    50   ~ 0
A12
Text Label 3300 2600 0    50   ~ 0
A13
Text Label 3300 2700 0    50   ~ 0
A14
Text Label 3300 2800 0    50   ~ 0
A15
Text Label 3300 2900 0    50   ~ 0
A16
Text Label 3300 3000 0    50   ~ 0
A17
Text Label 3300 3100 0    50   ~ 0
A18
Text Label 3300 3200 0    50   ~ 0
A19
Text Label 3300 3300 0    50   ~ 0
A20
Text Label 3300 3400 0    50   ~ 0
A21
Text Label 3300 3500 0    50   ~ 0
A22
Text Label 3300 3600 0    50   ~ 0
A23
Text HLabel 3650 1500 2    50   Output ~ 0
A[23..1]
NoConn ~ 1300 2600
NoConn ~ 1300 2700
NoConn ~ 1300 2800
NoConn ~ 1300 2200
Wire Wire Line
	1300 2300 1200 2300
Wire Wire Line
	1200 2300 1200 2100
Wire Wire Line
	1200 2100 1300 2100
$Comp
L power:+5V #PWR0101
U 1 1 60E9BDD6
P 1200 2100
F 0 "#PWR0101" H 1200 1950 50  0001 C CNN
F 1 "+5V" H 1200 2250 50  0000 C CNN
F 2 "" H 1200 2100 50  0001 C CNN
F 3 "" H 1200 2100 50  0001 C CNN
	1    1200 2100
	1    0    0    -1  
$EndComp
Connection ~ 1200 2100
$Comp
L power:+5V #PWR0102
U 1 1 60E9C1DC
P 2200 1000
F 0 "#PWR0102" H 2200 850 50  0001 C CNN
F 1 "+5V" H 2200 1150 50  0000 C CNN
F 2 "" H 2200 1000 50  0001 C CNN
F 3 "" H 2200 1000 50  0001 C CNN
	1    2200 1000
	1    0    0    -1  
$EndComp
Wire Wire Line
	2200 1000 2400 1000
Connection ~ 2200 1000
$Comp
L power:GND #PWR0103
U 1 1 60EA198C
P 2500 6200
F 0 "#PWR0103" H 2500 5950 50  0001 C CNN
F 1 "GND" H 2500 6050 50  0000 C CNN
F 2 "" H 2500 6200 50  0001 C CNN
F 3 "" H 2500 6200 50  0001 C CNN
	1    2500 6200
	1    0    0    -1  
$EndComp
Wire Wire Line
	2500 6200 2400 6200
Connection ~ 2500 6200
Connection ~ 2200 6200
Wire Wire Line
	2200 6200 2100 6200
Connection ~ 2400 6200
Wire Wire Line
	2400 6200 2200 6200
Wire Bus Line
	3650 1500 3600 1500
Wire Bus Line
	3650 3900 3600 3900
$Comp
L power:+5V #PWR?
U 1 1 6161AC98
P 1300 7200
AR Path="/6161AC98" Ref="#PWR?"  Part="1" 
AR Path="/60D70CB4/6161AC98" Ref="#PWR?"  Part="1" 
AR Path="/5F72F108/6161AC98" Ref="#PWR0104"  Part="1" 
F 0 "#PWR0104" H 1300 7050 50  0001 C CNN
F 1 "+5V" H 1300 7350 50  0000 C CNN
F 2 "" H 1300 7200 50  0001 C CNN
F 3 "" H 1300 7200 50  0001 C CNN
	1    1300 7200
	1    0    0    -1  
$EndComp
Wire Wire Line
	1300 7200 1700 7200
$Comp
L Device:C_Small C?
U 1 1 6161ACA0
P 1700 7300
AR Path="/6161ACA0" Ref="C?"  Part="1" 
AR Path="/60D70CB4/6161ACA0" Ref="C?"  Part="1" 
AR Path="/5F72F108/6161ACA0" Ref="C2"  Part="1" 
F 0 "C2" H 1750 7350 50  0000 L CNN
F 1 "10u" H 1750 7250 50  0000 L CNN
F 2 "stdpads:C_0805" H 1700 7300 50  0001 C CNN
F 3 "~" H 1700 7300 50  0001 C CNN
	1    1700 7300
	1    0    0    -1  
$EndComp
Connection ~ 1300 7200
$Comp
L Device:C_Small C?
U 1 1 6161ACA7
P 1300 7300
AR Path="/6161ACA7" Ref="C?"  Part="1" 
AR Path="/60D70CB4/6161ACA7" Ref="C?"  Part="1" 
AR Path="/5F72F108/6161ACA7" Ref="C1"  Part="1" 
F 0 "C1" H 1350 7350 50  0000 L CNN
F 1 "10u" H 1350 7250 50  0000 L CNN
F 2 "stdpads:C_0805" H 1300 7300 50  0001 C CNN
F 3 "~" H 1300 7300 50  0001 C CNN
	1    1300 7300
	1    0    0    -1  
$EndComp
Wire Wire Line
	1300 7400 1700 7400
Wire Wire Line
	1300 4800 1300 5000
NoConn ~ 1300 3100
NoConn ~ 1300 3200
$Comp
L power:GND #PWR0126
U 1 1 61B1134E
P 1700 7400
F 0 "#PWR0126" H 1700 7150 50  0001 C CNN
F 1 "GND" H 1700 7250 50  0000 C CNN
F 2 "" H 1700 7400 50  0001 C CNN
F 3 "" H 1700 7400 50  0001 C CNN
	1    1700 7400
	1    0    0    -1  
$EndComp
Connection ~ 1700 7400
Wire Bus Line
	3600 3900 3600 5400
Wire Bus Line
	3600 1500 3600 3700
$EndSCHEMATC
