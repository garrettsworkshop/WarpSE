EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 7 10
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
L Regulator_Linear:AP1117-33 U3
U 1 1 61B3AB93
P 5250 2100
F 0 "U3" H 5250 2300 50  0000 C CNN
F 1 "AZ1117CH-3.3" H 5250 2200 50  0000 C BNN
F 2 "stdpads:SOT-223" H 5250 2300 50  0001 C CNN
F 3 "http://www.diodes.com/datasheets/AP1117.pdf" H 5350 1850 50  0001 C CNN
	1    5250 2100
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR0129
U 1 1 61B3BD83
P 4850 2100
F 0 "#PWR0129" H 4850 1950 50  0001 C CNN
F 1 "+5V" H 4850 2250 50  0000 C CNN
F 2 "" H 4850 2100 50  0001 C CNN
F 3 "" H 4850 2100 50  0001 C CNN
	1    4850 2100
	1    0    0    -1  
$EndComp
Wire Wire Line
	4850 2100 4950 2100
Wire Wire Line
	5550 2100 5650 2100
$Comp
L power:GND #PWR0130
U 1 1 61B3CD29
P 5250 2400
F 0 "#PWR0130" H 5250 2150 50  0001 C CNN
F 1 "GND" H 5250 2250 50  0000 C CNN
F 2 "" H 5250 2400 50  0001 C CNN
F 3 "" H 5250 2400 50  0001 C CNN
	1    5250 2400
	1    0    0    -1  
$EndComp
$Comp
L power:+3V3 #PWR0131
U 1 1 61B3D39E
P 6050 2100
F 0 "#PWR0131" H 6050 1950 50  0001 C CNN
F 1 "+3V3" H 6050 2250 50  0000 C CNN
F 2 "" H 6050 2100 50  0001 C CNN
F 3 "" H 6050 2100 50  0001 C CNN
	1    6050 2100
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C3
U 1 1 61B3DF5F
P 4850 2250
F 0 "C3" H 4750 2300 50  0000 R CNN
F 1 "10u" H 4750 2200 50  0000 R CNN
F 2 "stdpads:C_0805" H 4850 2250 50  0001 C CNN
F 3 "~" H 4850 2250 50  0001 C CNN
	1    4850 2250
	1    0    0    -1  
$EndComp
Wire Wire Line
	4850 2400 5250 2400
Connection ~ 5250 2400
Wire Wire Line
	4850 2350 4850 2400
Wire Wire Line
	4850 2100 4850 2150
Connection ~ 4850 2100
$Comp
L Device:C_Small C7
U 1 1 61B3E861
P 5650 2250
F 0 "C7" H 5550 2300 50  0000 R CNN
F 1 "10u" H 5550 2200 50  0000 R CNN
F 2 "stdpads:C_0805" H 5650 2250 50  0001 C CNN
F 3 "~" H 5650 2250 50  0001 C CNN
	1    5650 2250
	-1   0    0    -1  
$EndComp
Wire Wire Line
	5250 2400 5650 2400
Wire Wire Line
	5650 2400 5650 2350
Wire Wire Line
	5650 2100 5650 2150
Connection ~ 5650 2100
$Comp
L Device:C_Small C9
U 1 1 61B3EE84
P 5650 3050
F 0 "C9" H 5550 3100 50  0000 R CNN
F 1 "10u" H 5550 3000 50  0000 R CNN
F 2 "stdpads:C_0805" H 5650 3050 50  0001 C CNN
F 3 "~" H 5650 3050 50  0001 C CNN
	1    5650 3050
	-1   0    0    -1  
$EndComp
Wire Wire Line
	5650 2100 6050 2100
Wire Wire Line
	6050 2100 6050 2150
Wire Wire Line
	6050 2350 6050 2400
Wire Wire Line
	6050 2400 5650 2400
Connection ~ 5650 2400
Connection ~ 6050 2100
$Comp
L GW_Power:AZ1117CH2 U6
U 1 1 61B4296A
P 5250 2900
F 0 "U6" H 5250 3100 50  0000 C CNN
F 1 "AZ1117CH2-3.3" H 5250 3000 50  0000 C BNN
F 2 "stdpads:SOT-223" H 5250 3100 50  0001 C CNN
F 3 "http://www.diodes.com/datasheets/AP1117.pdf" H 5350 2650 50  0001 C CNN
	1    5250 2900
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR0136
U 1 1 61B42970
P 4850 2900
F 0 "#PWR0136" H 4850 2750 50  0001 C CNN
F 1 "+5V" H 4850 3050 50  0000 C CNN
F 2 "" H 4850 2900 50  0001 C CNN
F 3 "" H 4850 2900 50  0001 C CNN
	1    4850 2900
	1    0    0    -1  
$EndComp
Wire Wire Line
	4850 2900 4950 2900
Wire Wire Line
	5550 2900 5650 2900
$Comp
L power:GND #PWR0137
U 1 1 61B42978
P 5250 3200
F 0 "#PWR0137" H 5250 2950 50  0001 C CNN
F 1 "GND" H 5250 3050 50  0000 C CNN
F 2 "" H 5250 3200 50  0001 C CNN
F 3 "" H 5250 3200 50  0001 C CNN
	1    5250 3200
	1    0    0    -1  
$EndComp
$Comp
L power:+3V3 #PWR0139
U 1 1 61B4297E
P 6050 2900
F 0 "#PWR0139" H 6050 2750 50  0001 C CNN
F 1 "+3V3" H 6050 3050 50  0000 C CNN
F 2 "" H 6050 2900 50  0001 C CNN
F 3 "" H 6050 2900 50  0001 C CNN
	1    6050 2900
	1    0    0    -1  
$EndComp
$Comp
L Device:C_Small C4
U 1 1 61B42984
P 4850 3050
F 0 "C4" H 4750 3100 50  0000 R CNN
F 1 "10u" H 4750 3000 50  0000 R CNN
F 2 "stdpads:C_0805" H 4850 3050 50  0001 C CNN
F 3 "~" H 4850 3050 50  0001 C CNN
	1    4850 3050
	1    0    0    -1  
$EndComp
Wire Wire Line
	4850 3200 5250 3200
Connection ~ 5250 3200
Wire Wire Line
	4850 3150 4850 3200
Wire Wire Line
	4850 2900 4850 2950
Connection ~ 4850 2900
$Comp
L Device:C_Small C8
U 1 1 61B4298F
P 6050 2250
F 0 "C8" H 5950 2300 50  0000 R CNN
F 1 "10u" H 5950 2200 50  0000 R CNN
F 2 "stdpads:C_0805" H 6050 2250 50  0001 C CNN
F 3 "~" H 6050 2250 50  0001 C CNN
	1    6050 2250
	-1   0    0    -1  
$EndComp
Wire Wire Line
	5250 3200 5650 3200
Wire Wire Line
	5650 3200 5650 3150
Wire Wire Line
	5650 2900 5650 2950
Connection ~ 5650 2900
$Comp
L Device:C_Small C10
U 1 1 61B42999
P 6050 3050
F 0 "C10" H 5950 3100 50  0000 R CNN
F 1 "10u" H 5950 3000 50  0000 R CNN
F 2 "stdpads:C_0805" H 6050 3050 50  0001 C CNN
F 3 "~" H 6050 3050 50  0001 C CNN
	1    6050 3050
	-1   0    0    -1  
$EndComp
Wire Wire Line
	5650 2900 6050 2900
Wire Wire Line
	6050 2900 6050 2950
Wire Wire Line
	6050 3150 6050 3200
Wire Wire Line
	6050 3200 5650 3200
Connection ~ 5650 3200
Connection ~ 6050 2900
$EndSCHEMATC
