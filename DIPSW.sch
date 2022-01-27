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
L Device:R_Small R?
U 1 1 61A8BBE0
P 4050 3200
AR Path="/61A8BBE0" Ref="R?"  Part="1" 
AR Path="/61BD72BF/61A8BBE0" Ref="R?"  Part="1" 
AR Path="/61350D21/61A8BBE0" Ref="R?"  Part="1" 
AR Path="/61BE63BD/61A8BBE0" Ref="R?"  Part="1" 
AR Path="/61BE8523/61A8BBE0" Ref="R?"  Part="1" 
AR Path="/61A87B62/61A8BBE0" Ref="R4"  Part="1" 
AR Path="/61B15767/61A8BBE0" Ref="R?"  Part="1" 
F 0 "R4" H 4109 3246 50  0000 L CNN
F 1 "10k" H 4109 3155 50  0000 L CNN
F 2 "stdpads:R_0603" H 4050 3200 50  0001 C CNN
F 3 "~" H 4050 3200 50  0001 C CNN
F 4 "C25804" H 4050 3200 50  0001 C CNN "LCSC Part"
	1    4050 3200
	1    0    0    -1  
$EndComp
$Comp
L Device:R_Small R?
U 1 1 61A8BBE6
P 3750 3200
AR Path="/61A8BBE6" Ref="R?"  Part="1" 
AR Path="/61BD72BF/61A8BBE6" Ref="R?"  Part="1" 
AR Path="/61350D21/61A8BBE6" Ref="R?"  Part="1" 
AR Path="/61BE63BD/61A8BBE6" Ref="R?"  Part="1" 
AR Path="/61BE8523/61A8BBE6" Ref="R?"  Part="1" 
AR Path="/61A87B62/61A8BBE6" Ref="R3"  Part="1" 
AR Path="/61B15767/61A8BBE6" Ref="R?"  Part="1" 
F 0 "R3" H 3809 3246 50  0000 L CNN
F 1 "10k" H 3809 3155 50  0000 L CNN
F 2 "stdpads:R_0603" H 3750 3200 50  0001 C CNN
F 3 "~" H 3750 3200 50  0001 C CNN
F 4 "C25804" H 3750 3200 50  0001 C CNN "LCSC Part"
	1    3750 3200
	1    0    0    -1  
$EndComp
Wire Wire Line
	3750 3500 4050 3500
Wire Wire Line
	3750 3100 4050 3100
Wire Wire Line
	4650 3400 4650 3500
$Comp
L power:GND #PWR0118
U 1 1 61A8CA42
P 4650 3600
AR Path="/61A87B62/61A8CA42" Ref="#PWR0118"  Part="1" 
AR Path="/61B15767/61A8CA42" Ref="#PWR?"  Part="1" 
F 0 "#PWR0118" H 4650 3350 50  0001 C CNN
F 1 "GND" H 4650 3450 50  0000 C CNN
F 2 "" H 4650 3600 50  0001 C CNN
F 3 "" H 4650 3600 50  0001 C CNN
	1    4650 3600
	1    0    0    -1  
$EndComp
Connection ~ 4650 3500
$Comp
L Switch:SW_DIP_x03 SW?
U 1 1 61A8BBD9
P 4350 3600
AR Path="/61A8BBD9" Ref="SW?"  Part="1" 
AR Path="/61BD72BF/61A8BBD9" Ref="SW?"  Part="1" 
AR Path="/61350D21/61A8BBD9" Ref="SW?"  Part="1" 
AR Path="/61BE63BD/61A8BBD9" Ref="SW?"  Part="1" 
AR Path="/61BE8523/61A8BBD9" Ref="SW?"  Part="1" 
AR Path="/61A87B62/61A8BBD9" Ref="SW1"  Part="1" 
AR Path="/61B15767/61A8BBD9" Ref="SW?"  Part="1" 
F 0 "SW1" H 4350 3950 50  0000 C CNN
F 1 "OSCSEL" H 4350 3450 50  0000 C CNN
F 2 "stdpads:SW_DIP_SPSTx03_Slide_DSHP03TS_P1.27mm" H 4350 3600 50  0001 C CNN
F 3 "~" H 4350 3600 50  0001 C CNN
F 4 "C319051" H 4350 3600 50  0001 C CNN "LCSC Part"
	1    4350 3600
	1    0    0    -1  
$EndComp
Text HLabel 3350 3600 0    50   Output ~ 0
SW2
Wire Wire Line
	4650 3600 4650 3500
Connection ~ 4650 3600
Wire Wire Line
	3350 3600 3450 3600
$Comp
L Device:R_Small R?
U 1 1 61E3AF0C
P 3450 3200
AR Path="/61E3AF0C" Ref="R?"  Part="1" 
AR Path="/61BD72BF/61E3AF0C" Ref="R?"  Part="1" 
AR Path="/61350D21/61E3AF0C" Ref="R?"  Part="1" 
AR Path="/61BE63BD/61E3AF0C" Ref="R?"  Part="1" 
AR Path="/61BE8523/61E3AF0C" Ref="R?"  Part="1" 
AR Path="/61A87B62/61E3AF0C" Ref="R6"  Part="1" 
AR Path="/61B15767/61E3AF0C" Ref="R?"  Part="1" 
F 0 "R6" H 3509 3246 50  0000 L CNN
F 1 "10k" H 3509 3155 50  0000 L CNN
F 2 "stdpads:R_0603" H 3450 3200 50  0001 C CNN
F 3 "~" H 3450 3200 50  0001 C CNN
F 4 "C25804" H 3450 3200 50  0001 C CNN "LCSC Part"
	1    3450 3200
	1    0    0    -1  
$EndComp
Wire Wire Line
	3450 3100 3750 3100
Connection ~ 3450 3600
Wire Wire Line
	3450 3600 4050 3600
Text HLabel 3350 3400 0    50   Output ~ 0
SW0
Text HLabel 3350 3500 0    50   Output ~ 0
SW1
Wire Wire Line
	3350 3500 3750 3500
Connection ~ 3750 3500
Connection ~ 4050 3400
Wire Wire Line
	3350 3400 4050 3400
Wire Wire Line
	3450 3300 3450 3600
Connection ~ 3750 3100
Wire Wire Line
	3750 3300 3750 3500
Wire Wire Line
	4050 3300 4050 3400
$Comp
L power:+5V #PWR0115
U 1 1 6279FB2C
P 4050 3100
F 0 "#PWR0115" H 4050 2950 50  0001 C CNN
F 1 "+5V" H 4050 3250 50  0000 C CNN
F 2 "" H 4050 3100 50  0001 C CNN
F 3 "" H 4050 3100 50  0001 C CNN
	1    4050 3100
	1    0    0    -1  
$EndComp
Connection ~ 4050 3100
$EndSCHEMATC
