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
Wire Wire Line
	4050 3400 4050 3300
$Comp
L Device:R_Small R?
U 1 1 61A8BBE0
P 4050 3100
AR Path="/61A8BBE0" Ref="R?"  Part="1" 
AR Path="/61BD72BF/61A8BBE0" Ref="R?"  Part="1" 
AR Path="/61350D21/61A8BBE0" Ref="R?"  Part="1" 
AR Path="/61BE63BD/61A8BBE0" Ref="R?"  Part="1" 
AR Path="/61BE8523/61A8BBE0" Ref="R?"  Part="1" 
AR Path="/61A87B62/61A8BBE0" Ref="R4"  Part="1" 
AR Path="/61B15767/61A8BBE0" Ref="R?"  Part="1" 
F 0 "R4" H 4109 3146 50  0000 L CNN
F 1 "10k" H 4109 3055 50  0000 L CNN
F 2 "stdpads:R_0603" H 4050 3100 50  0001 C CNN
F 3 "~" H 4050 3100 50  0001 C CNN
	1    4050 3100
	1    0    0    -1  
$EndComp
$Comp
L Device:R_Small R?
U 1 1 61A8BBE6
P 3750 3100
AR Path="/61A8BBE6" Ref="R?"  Part="1" 
AR Path="/61BD72BF/61A8BBE6" Ref="R?"  Part="1" 
AR Path="/61350D21/61A8BBE6" Ref="R?"  Part="1" 
AR Path="/61BE63BD/61A8BBE6" Ref="R?"  Part="1" 
AR Path="/61BE8523/61A8BBE6" Ref="R?"  Part="1" 
AR Path="/61A87B62/61A8BBE6" Ref="R3"  Part="1" 
AR Path="/61B15767/61A8BBE6" Ref="R?"  Part="1" 
F 0 "R3" H 3809 3146 50  0000 L CNN
F 1 "10k" H 3809 3055 50  0000 L CNN
F 2 "stdpads:R_0603" H 3750 3100 50  0001 C CNN
F 3 "~" H 3750 3100 50  0001 C CNN
	1    3750 3100
	1    0    0    -1  
$EndComp
Wire Wire Line
	3650 3300 4050 3300
Wire Wire Line
	3750 3500 4050 3500
Wire Wire Line
	3750 3200 3750 3400
Wire Wire Line
	4050 3300 4050 3200
Connection ~ 4050 3300
Wire Wire Line
	3750 3000 4050 3000
Connection ~ 4050 3000
Wire Wire Line
	4650 3400 4650 3500
$Comp
L power:+3V3 #PWR?
U 1 1 61A8C306
P 4050 3000
AR Path="/5F723173/61A8C306" Ref="#PWR?"  Part="1" 
AR Path="/61A8C306" Ref="#PWR?"  Part="1" 
AR Path="/61BD72BF/61A8C306" Ref="#PWR?"  Part="1" 
AR Path="/61350D21/61A8C306" Ref="#PWR?"  Part="1" 
AR Path="/61BE63BD/61A8C306" Ref="#PWR?"  Part="1" 
AR Path="/61BE8523/61A8C306" Ref="#PWR?"  Part="1" 
AR Path="/61A87B62/61A8C306" Ref="#PWR0115"  Part="1" 
AR Path="/61B15767/61A8C306" Ref="#PWR?"  Part="1" 
F 0 "#PWR0115" H 4050 2850 50  0001 C CNN
F 1 "+3V3" H 4050 3150 50  0000 C CNN
F 2 "" H 4050 3000 50  0001 C CNN
F 3 "" H 4050 3000 50  0001 C CNN
	1    4050 3000
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0118
U 1 1 61A8CA42
P 4650 3500
AR Path="/61A87B62/61A8CA42" Ref="#PWR0118"  Part="1" 
AR Path="/61B15767/61A8CA42" Ref="#PWR?"  Part="1" 
F 0 "#PWR0118" H 4650 3250 50  0001 C CNN
F 1 "GND" H 4650 3350 50  0000 C CNN
F 2 "" H 4650 3500 50  0001 C CNN
F 3 "" H 4650 3500 50  0001 C CNN
	1    4650 3500
	1    0    0    -1  
$EndComp
Connection ~ 4650 3500
$Comp
L Switch:SW_DIP_x02 SW?
U 1 1 61A8BBD9
P 4350 3500
AR Path="/61A8BBD9" Ref="SW?"  Part="1" 
AR Path="/61BD72BF/61A8BBD9" Ref="SW?"  Part="1" 
AR Path="/61350D21/61A8BBD9" Ref="SW?"  Part="1" 
AR Path="/61BE63BD/61A8BBD9" Ref="SW?"  Part="1" 
AR Path="/61BE8523/61A8BBD9" Ref="SW?"  Part="1" 
AR Path="/61A87B62/61A8BBD9" Ref="SW1"  Part="1" 
AR Path="/61B15767/61A8BBD9" Ref="SW?"  Part="1" 
F 0 "SW1" H 4350 3750 50  0000 C CNN
F 1 "OSCSEL" H 4350 3350 50  0000 C CNN
F 2 "stdpads:SW_DIP_SPSTx02_Slide_DSHP02TS_P1.27mm" H 4350 3500 50  0001 C CNN
F 3 "~" H 4350 3500 50  0001 C CNN
	1    4350 3500
	1    0    0    -1  
$EndComp
Wire Wire Line
	3750 3400 3650 3400
Connection ~ 3750 3400
Wire Wire Line
	3750 3400 3750 3500
Text HLabel 3650 3300 0    50   Output ~ 0
SW0
Text HLabel 3650 3400 0    50   Output ~ 0
SW1
$EndSCHEMATC
