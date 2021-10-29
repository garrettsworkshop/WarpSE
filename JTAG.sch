EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 9 10
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Text HLabel 4750 3550 2    50   Output ~ 0
TCK
Text HLabel 4750 3750 2    50   Output ~ 0
TDI
Text HLabel 4750 3450 2    50   Output ~ 0
TMS
Text HLabel 4750 3650 2    50   Input ~ 0
TDO
$Comp
L Connector_Generic:Conn_02x07_Odd_Even J2
U 1 1 61B2217D
P 4450 3650
F 0 "J2" H 4500 4050 50  0000 C CNN
F 1 "JTAG" H 4500 3250 50  0000 C CNN
F 2 "Connector:Tag-Connect_TC2070-IDC-FP_2x07_P1.27mm_Vertical" H 4450 3650 50  0001 C CNN
F 3 "~" H 4450 3650 50  0001 C CNN
	1    4450 3650
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0127
U 1 1 61B22961
P 4250 3950
F 0 "#PWR0127" H 4250 3700 50  0001 C CNN
F 1 "GND" H 4255 3777 50  0000 C CNN
F 2 "" H 4250 3950 50  0001 C CNN
F 3 "" H 4250 3950 50  0001 C CNN
	1    4250 3950
	1    0    0    -1  
$EndComp
Wire Wire Line
	4250 3350 4250 3450
Connection ~ 4250 3950
Connection ~ 4250 3450
Wire Wire Line
	4250 3450 4250 3550
Connection ~ 4250 3550
Wire Wire Line
	4250 3550 4250 3650
Connection ~ 4250 3650
Wire Wire Line
	4250 3650 4250 3750
Connection ~ 4250 3750
Wire Wire Line
	4250 3750 4250 3850
Connection ~ 4250 3850
Wire Wire Line
	4250 3850 4250 3950
$Comp
L power:+3V3 #PWR0128
U 1 1 61B2334F
P 4750 3350
F 0 "#PWR0128" H 4750 3200 50  0001 C CNN
F 1 "+3V3" H 4750 3500 50  0000 C CNN
F 2 "" H 4750 3350 50  0001 C CNN
F 3 "" H 4750 3350 50  0001 C CNN
	1    4750 3350
	1    0    0    -1  
$EndComp
NoConn ~ 4750 3850
NoConn ~ 4750 3950
$EndSCHEMATC
