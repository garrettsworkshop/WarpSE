EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 8 10
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Wire Wire Line
	3950 2500 3950 2250
Wire Wire Line
	3950 2750 3950 2500
Connection ~ 3950 2500
Wire Wire Line
	3850 2500 3850 2350
Wire Wire Line
	3850 2650 3850 2500
Connection ~ 3850 2500
Wire Wire Line
	3850 2500 3950 2500
Wire Wire Line
	4050 2750 3950 2750
Wire Wire Line
	3950 2250 4050 2250
$Comp
L Device:R_Small R?
U 1 1 6141AC14
P 3750 2650
AR Path="/6141AC14" Ref="R?"  Part="1" 
AR Path="/61BD72BF/6141AC14" Ref="R?"  Part="1" 
AR Path="/61350D21/6141AC14" Ref="R2"  Part="1" 
AR Path="/61BE63BD/6141AC14" Ref="R?"  Part="1" 
AR Path="/61BE8523/6141AC14" Ref="R?"  Part="1" 
AR Path="/61A87B62/6141AC14" Ref="R?"  Part="1" 
F 0 "R2" V 3600 2650 50  0000 C CNN
F 1 "22" V 3700 2650 50  0000 C BNN
F 2 "stdpads:R_0603" H 3750 2650 50  0001 C CNN
F 3 "~" H 3750 2650 50  0001 C CNN
	1    3750 2650
	0    1    1    0   
$EndComp
$Comp
L Device:R_Small R?
U 1 1 6141A918
P 3750 2350
AR Path="/6141A918" Ref="R?"  Part="1" 
AR Path="/61BD72BF/6141A918" Ref="R?"  Part="1" 
AR Path="/61350D21/6141A918" Ref="R1"  Part="1" 
AR Path="/61BE63BD/6141A918" Ref="R?"  Part="1" 
AR Path="/61BE8523/6141A918" Ref="R?"  Part="1" 
AR Path="/61A87B62/6141A918" Ref="R?"  Part="1" 
F 0 "R1" V 3600 2350 50  0000 C CNN
F 1 "22" V 3700 2350 50  0000 C BNN
F 2 "stdpads:R_0603" H 3750 2350 50  0001 C CNN
F 3 "~" H 3750 2350 50  0001 C CNN
	1    3750 2350
	0    1    1    0   
$EndComp
$Comp
L power:GND #PWR?
U 1 1 613B7144
P 3500 4350
AR Path="/613B7144" Ref="#PWR?"  Part="1" 
AR Path="/61350D21/613B7144" Ref="#PWR0123"  Part="1" 
AR Path="/61BE63BD/613B7144" Ref="#PWR?"  Part="1" 
AR Path="/61BE8523/613B7144" Ref="#PWR?"  Part="1" 
AR Path="/61A87B62/613B7144" Ref="#PWR?"  Part="1" 
F 0 "#PWR0123" H 3500 4100 50  0001 C CNN
F 1 "GND" H 3500 4200 50  0000 C CNN
F 2 "" H 3500 4350 50  0001 C CNN
F 3 "" H 3500 4350 50  0001 C CNN
	1    3500 4350
	-1   0    0    -1  
$EndComp
$Comp
L Device:C_Small C?
U 1 1 613B713D
P 3500 4250
AR Path="/613B713D" Ref="C?"  Part="1" 
AR Path="/61350D21/613B713D" Ref="C6"  Part="1" 
AR Path="/61BE63BD/613B713D" Ref="C?"  Part="1" 
AR Path="/61BE8523/613B713D" Ref="C?"  Part="1" 
AR Path="/61A87B62/613B713D" Ref="C?"  Part="1" 
F 0 "C6" H 3550 4300 50  0000 L CNN
F 1 "2u2" H 3550 4200 50  0000 L CNN
F 2 "stdpads:C_0603" H 3500 4250 50  0001 C CNN
F 3 "~" H 3500 4250 50  0001 C CNN
	1    3500 4250
	1    0    0    -1  
$EndComp
Wire Wire Line
	3100 4150 3500 4150
Wire Wire Line
	3100 4350 3500 4350
$Comp
L power:+3V3 #PWR?
U 1 1 613B7131
P 3100 4150
AR Path="/613B7131" Ref="#PWR?"  Part="1" 
AR Path="/61350D21/613B7131" Ref="#PWR0122"  Part="1" 
AR Path="/61BE63BD/613B7131" Ref="#PWR?"  Part="1" 
AR Path="/61BE8523/613B7131" Ref="#PWR?"  Part="1" 
AR Path="/61A87B62/613B7131" Ref="#PWR?"  Part="1" 
F 0 "#PWR0122" H 3100 4000 50  0001 C CNN
F 1 "+3V3" H 3100 4300 50  0000 C CNN
F 2 "" H 3100 4150 50  0001 C CNN
F 3 "" H 3100 4150 50  0001 C CNN
	1    3100 4150
	1    0    0    -1  
$EndComp
Connection ~ 3100 4150
$Comp
L Device:C_Small C?
U 1 1 613B711A
P 3100 4250
AR Path="/613B711A" Ref="C?"  Part="1" 
AR Path="/61350D21/613B711A" Ref="C5"  Part="1" 
AR Path="/61BE63BD/613B711A" Ref="C?"  Part="1" 
AR Path="/61BE8523/613B711A" Ref="C?"  Part="1" 
AR Path="/61A87B62/613B711A" Ref="C?"  Part="1" 
F 0 "C5" H 3150 4300 50  0000 L CNN
F 1 "2u2" H 3150 4200 50  0000 L CNN
F 2 "stdpads:C_0603" H 3100 4250 50  0001 C CNN
F 3 "~" H 3100 4250 50  0001 C CNN
	1    3100 4250
	1    0    0    -1  
$EndComp
Text HLabel 3650 2650 0    50   Output ~ 0
RCLK
Text HLabel 3650 2350 0    50   Output ~ 0
MCLK
$Comp
L GW_Logic:Oscillator_4P U?
U 1 1 61BF03AA
P 4400 2250
AR Path="/61BF03AA" Ref="U?"  Part="1" 
AR Path="/61BD72BF/61BF03AA" Ref="U?"  Part="1" 
AR Path="/61350D21/61BF03AA" Ref="U4"  Part="1" 
AR Path="/61BE63BD/61BF03AA" Ref="U?"  Part="1" 
AR Path="/61BE8523/61BF03AA" Ref="U?"  Part="1" 
AR Path="/61A87B62/61BF03AA" Ref="U?"  Part="1" 
F 0 "U4" H 4400 2550 50  0000 C BNN
F 1 "20M" H 4400 2500 50  0000 C CNN
F 2 "stdpads:Crystal_SMD_3225-4Pin_3.2x2.5mm" H 4400 2250 50  0001 C CNN
F 3 "" H 4400 2250 50  0001 C CNN
	1    4400 2250
	-1   0    0    -1  
$EndComp
$Comp
L GW_Logic:Oscillator_4P U?
U 1 1 61BF03A4
P 4400 2750
AR Path="/61BF03A4" Ref="U?"  Part="1" 
AR Path="/61BD72BF/61BF03A4" Ref="U?"  Part="1" 
AR Path="/61350D21/61BF03A4" Ref="U5"  Part="1" 
AR Path="/61BE63BD/61BF03A4" Ref="U?"  Part="1" 
AR Path="/61BE8523/61BF03A4" Ref="U?"  Part="1" 
AR Path="/61A87B62/61BF03A4" Ref="U?"  Part="1" 
F 0 "U5" H 4400 3050 50  0000 C BNN
F 1 "25M" H 4400 3000 50  0000 C CNN
F 2 "stdpads:Crystal_SMD_3225-4Pin_3.2x2.5mm" H 4400 2750 50  0001 C CNN
F 3 "" H 4400 2750 50  0001 C CNN
	1    4400 2750
	-1   0    0    -1  
$EndComp
$Comp
L power:+3V3 #PWR?
U 1 1 61BF039E
P 4050 2150
AR Path="/5F723173/61BF039E" Ref="#PWR?"  Part="1" 
AR Path="/61BF039E" Ref="#PWR?"  Part="1" 
AR Path="/61BD72BF/61BF039E" Ref="#PWR?"  Part="1" 
AR Path="/61350D21/61BF039E" Ref="#PWR0117"  Part="1" 
AR Path="/61BE63BD/61BF039E" Ref="#PWR?"  Part="1" 
AR Path="/61BE8523/61BF039E" Ref="#PWR?"  Part="1" 
AR Path="/61A87B62/61BF039E" Ref="#PWR?"  Part="1" 
F 0 "#PWR0117" H 4050 2000 50  0001 C CNN
F 1 "+3V3" H 4050 2300 50  0000 C CNN
F 2 "" H 4050 2150 50  0001 C CNN
F 3 "" H 4050 2150 50  0001 C CNN
	1    4050 2150
	1    0    0    -1  
$EndComp
$Comp
L power:+3V3 #PWR?
U 1 1 61BF0398
P 4050 2650
AR Path="/5F723173/61BF0398" Ref="#PWR?"  Part="1" 
AR Path="/61BF0398" Ref="#PWR?"  Part="1" 
AR Path="/61BD72BF/61BF0398" Ref="#PWR?"  Part="1" 
AR Path="/61350D21/61BF0398" Ref="#PWR0116"  Part="1" 
AR Path="/61BE63BD/61BF0398" Ref="#PWR?"  Part="1" 
AR Path="/61BE8523/61BF0398" Ref="#PWR?"  Part="1" 
AR Path="/61A87B62/61BF0398" Ref="#PWR?"  Part="1" 
F 0 "#PWR0116" H 4050 2500 50  0001 C CNN
F 1 "+3V3" H 4050 2800 50  0000 C CNN
F 2 "" H 4050 2650 50  0001 C CNN
F 3 "" H 4050 2650 50  0001 C CNN
	1    4050 2650
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 61BF038C
P 4750 2750
AR Path="/5F72F108/61BF038C" Ref="#PWR?"  Part="1" 
AR Path="/61BF038C" Ref="#PWR?"  Part="1" 
AR Path="/61BD72BF/61BF038C" Ref="#PWR?"  Part="1" 
AR Path="/61350D21/61BF038C" Ref="#PWR0114"  Part="1" 
AR Path="/61BE63BD/61BF038C" Ref="#PWR?"  Part="1" 
AR Path="/61BE8523/61BF038C" Ref="#PWR?"  Part="1" 
AR Path="/61A87B62/61BF038C" Ref="#PWR?"  Part="1" 
F 0 "#PWR0114" H 4750 2500 50  0001 C CNN
F 1 "GND" H 4750 2600 50  0000 C CNN
F 2 "" H 4750 2750 50  0001 C CNN
F 3 "" H 4750 2750 50  0001 C CNN
	1    4750 2750
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 61BF0386
P 4750 2250
AR Path="/5F72F108/61BF0386" Ref="#PWR?"  Part="1" 
AR Path="/61BF0386" Ref="#PWR?"  Part="1" 
AR Path="/61BD72BF/61BF0386" Ref="#PWR?"  Part="1" 
AR Path="/61350D21/61BF0386" Ref="#PWR0113"  Part="1" 
AR Path="/61BE63BD/61BF0386" Ref="#PWR?"  Part="1" 
AR Path="/61BE8523/61BF0386" Ref="#PWR?"  Part="1" 
AR Path="/61A87B62/61BF0386" Ref="#PWR?"  Part="1" 
F 0 "#PWR0113" H 4750 2000 50  0001 C CNN
F 1 "GND" H 4750 2100 50  0000 C CNN
F 2 "" H 4750 2250 50  0001 C CNN
F 3 "" H 4750 2250 50  0001 C CNN
	1    4750 2250
	1    0    0    -1  
$EndComp
Text HLabel 4750 2150 2    50   Input ~ 0
CK20EN
Text HLabel 4750 2650 2    50   Input ~ 0
CK25EN
Connection ~ 3500 4350
$EndSCHEMATC
