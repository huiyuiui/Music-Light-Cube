
�
:Ignoring repo path (%s) because it contains no board files4048*	planAhead2�
�C:/Users/user/Desktop/Programing/Logic C:/Users/user/Desktop/Programing/Logic Design/Advance/Project/project/vivado_proj/Basys-3-XADC.runs/synth_1/Design/Advance/Project/project/vivado_proj/Basys-3-XADC.board2default:defaultZ12-9135h px� 
>
Refreshing IP repositories
234*coregenZ19-234h px� 
�
�Failed to load user IP repository '%s'; %s
If this directory should no longer be in your list of user repositories, go to the IP Settings dialog and remove it.
1318*coregen2N
:c:/Users/user/Desktop/Programing/Logic Design/Advance/repo2default:default22
Can't find the specified path.2default:defaultZ19-2248h px� 
|
"Loaded Vivado IP repository '%s'.
1332*coregen23
C:/Xilinx/Vivado/2020.2/data/ip2default:defaultZ19-2313h px� 
�
�The host OS only allows 260 characters in a normal path. The IP cache path is more than 80 characters. If you experience issues with IP caching, please consider changing the IP cache to a location with a shorter path. Alternately consider using the OS subst command to map part of the path to a drive letter. 
Current IP cache path is %s 2293*coregen2{
gc:/Users/user/Desktop/Programing/Logic Design/Advance/Project/project/vivado_proj/Basys-3-XADC.cache/ip2default:defaultZ19-4995h px� 
�
Command: %s
53*	vivadotcl2�
xsynth_design -top XADCdemo -part xc7a35tcpg236-1 -flatten_hierarchy none -directive RuntimeOptimized -fsm_extraction off2default:defaultZ4-113h px� 
:
Starting synth_design
149*	vivadotclZ4-321h px� 
�
@Attempting to get a license for feature '%s' and/or device '%s'
308*common2
	Synthesis2default:default2
xc7a35t2default:defaultZ17-347h px� 
�
0Got license for feature '%s' and/or device '%s'
310*common2
	Synthesis2default:default2
xc7a35t2default:defaultZ17-349h px� 
V
Loading part %s157*device2#
xc7a35tcpg236-12default:defaultZ21-403h px� 
�
HMultithreading enabled for synth_design using a maximum of %s processes.4828*oasys2
22default:defaultZ8-7079h px� 
a
?Launching helper process for spawning children vivado processes4827*oasysZ8-7078h px� 
`
#Helper process launched with PID %s4824*oasys2
153762default:defaultZ8-7075h px� 
�
%s*synth2�
wStarting RTL Elaboration : Time (s): cpu = 00:00:04 ; elapsed = 00:00:04 . Memory (MB): peak = 1017.906 ; gain = 0.000
2default:defaulth px� 
�
synthesizing module '%s'%s4497*oasys2
XADCdemo2default:default2
 2default:default2�
�C:/Users/user/Desktop/Programing/Logic Design/Advance/Project/project/vivado_proj/Basys-3-XADC.srcs/sources_1/imports/hdl/XADCdemo.v2default:default2
232default:default8@Z8-6157h px� 
[
%s
*synth2C
/	Parameter S_IDLE bound to: 0 - type: integer 
2default:defaulth p
x
� 
a
%s
*synth2I
5	Parameter S_FRAME_WAIT bound to: 1 - type: integer 
2default:defaulth p
x
� 
a
%s
*synth2I
5	Parameter S_CONVERSION bound to: 2 - type: integer 
2default:defaulth p
x
� 
�
synthesizing module '%s'%s4497*oasys2

xadc_wiz_12default:default2
 2default:default2�
�C:/Users/user/Desktop/Programing/Logic Design/Advance/Project/project/vivado_proj/Basys-3-XADC.runs/synth_1/.Xil/Vivado-46052-zun/realtime/xadc_wiz_1_stub.v2default:default2
52default:default8@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2

xadc_wiz_12default:default2
 2default:default2
12default:default2
12default:default2�
�C:/Users/user/Desktop/Programing/Logic Design/Advance/Project/project/vivado_proj/Basys-3-XADC.runs/synth_1/.Xil/Vivado-46052-zun/realtime/xadc_wiz_1_stub.v2default:default2
52default:default8@Z8-6155h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
eos_out2default:default2

xadc_wiz_12default:default2
XLXI_72default:default2�
�C:/Users/user/Desktop/Programing/Logic Design/Advance/Project/project/vivado_proj/Basys-3-XADC.srcs/sources_1/imports/hdl/XADCdemo.v2default:default2
622default:default8@Z8-7071h px� 
�
Kinstance '%s' of module '%s' has %s connections declared, but only %s given4757*oasys2
XLXI_72default:default2

xadc_wiz_12default:default2
222default:default2
212default:default2�
�C:/Users/user/Desktop/Programing/Logic Design/Advance/Project/project/vivado_proj/Basys-3-XADC.srcs/sources_1/imports/hdl/XADCdemo.v2default:default2
622default:default8@Z8-7023h px� 
�
-case statement is not full and has no default155*oasys2�
�C:/Users/user/Desktop/Programing/Logic Design/Advance/Project/project/vivado_proj/Basys-3-XADC.srcs/sources_1/imports/hdl/XADCdemo.v2default:default2
1132default:default8@Z8-155h px� 
�
synthesizing module '%s'%s4497*oasys2
bin2dec2default:default2
 2default:default2�
�C:/Users/user/Desktop/Programing/Logic Design/Advance/Project/project/vivado_proj/Basys-3-XADC.srcs/sources_1/imports/hdl/bin2dec.v2default:default2
192default:default8@Z8-6157h px� 
[
%s
*synth2C
/	Parameter S_IDLE bound to: 0 - type: integer 
2default:defaulth p
x
� 
[
%s
*synth2C
/	Parameter S_DONE bound to: 1 - type: integer 
2default:defaulth p
x
� 
]
%s
*synth2E
1	Parameter S_DIVIDE bound to: 2 - type: integer 
2default:defaulth p
x
� 
a
%s
*synth2I
5	Parameter S_NEXT_DIGIT bound to: 3 - type: integer 
2default:defaulth p
x
� 
^
%s
*synth2F
2	Parameter S_CONVERT bound to: 4 - type: integer 
2default:defaulth p
x
� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
bin2dec2default:default2
 2default:default2
22default:default2
12default:default2�
�C:/Users/user/Desktop/Programing/Logic Design/Advance/Project/project/vivado_proj/Basys-3-XADC.srcs/sources_1/imports/hdl/bin2dec.v2default:default2
192default:default8@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2

DigitToSeg2default:default2
 2default:default2�
�C:/Users/user/Desktop/Programing/Logic Design/Advance/Project/project/vivado_proj/Basys-3-XADC.srcs/sources_1/imports/hdl/DigitToSeg.v2default:default2
232default:default8@Z8-6157h px� 
�
synthesizing module '%s'%s4497*oasys2#
sevensegdecoder2default:default2
 2default:default2�
�C:/Users/user/Desktop/Programing/Logic Design/Advance/Project/project/vivado_proj/Basys-3-XADC.srcs/sources_1/imports/hdl/sevensegdecoder.v2default:default2
232default:default8@Z8-6157h px� 
�
default block is never used226*oasys2�
�C:/Users/user/Desktop/Programing/Logic Design/Advance/Project/project/vivado_proj/Basys-3-XADC.srcs/sources_1/imports/hdl/sevensegdecoder.v2default:default2
302default:default8@Z8-226h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2#
sevensegdecoder2default:default2
 2default:default2
32default:default2
12default:default2�
�C:/Users/user/Desktop/Programing/Logic Design/Advance/Project/project/vivado_proj/Basys-3-XADC.srcs/sources_1/imports/hdl/sevensegdecoder.v2default:default2
232default:default8@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
	mux4_4bus2default:default2
 2default:default2�
�C:/Users/user/Desktop/Programing/Logic Design/Advance/Project/project/vivado_proj/Basys-3-XADC.srcs/sources_1/imports/hdl/mux4_4bus.v2default:default2
232default:default8@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
	mux4_4bus2default:default2
 2default:default2
42default:default2
12default:default2�
�C:/Users/user/Desktop/Programing/Logic Design/Advance/Project/project/vivado_proj/Basys-3-XADC.srcs/sources_1/imports/hdl/mux4_4bus.v2default:default2
232default:default8@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2!
segClkDevider2default:default2
 2default:default2�
�C:/Users/user/Desktop/Programing/Logic Design/Advance/Project/project/vivado_proj/Basys-3-XADC.srcs/sources_1/imports/hdl/segClkDevider.v2default:default2
222default:default8@Z8-6157h px� 
g
%s
*synth2O
;	Parameter constantNumber bound to: 10000 - type: integer 
2default:defaulth p
x
� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2!
segClkDevider2default:default2
 2default:default2
52default:default2
12default:default2�
�C:/Users/user/Desktop/Programing/Logic Design/Advance/Project/project/vivado_proj/Basys-3-XADC.srcs/sources_1/imports/hdl/segClkDevider.v2default:default2
222default:default8@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
counter3bit2default:default2
 2default:default2�
�C:/Users/user/Desktop/Programing/Logic Design/Advance/Project/project/vivado_proj/Basys-3-XADC.srcs/sources_1/imports/hdl/counter3bit.v2default:default2
12default:default8@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
counter3bit2default:default2
 2default:default2
62default:default2
12default:default2�
�C:/Users/user/Desktop/Programing/Logic Design/Advance/Project/project/vivado_proj/Basys-3-XADC.srcs/sources_1/imports/hdl/counter3bit.v2default:default2
12default:default8@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
decoder_3_82default:default2
 2default:default2�
�C:/Users/user/Desktop/Programing/Logic Design/Advance/Project/project/vivado_proj/Basys-3-XADC.srcs/sources_1/imports/hdl/decoder3_8.v2default:default2
222default:default8@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
decoder_3_82default:default2
 2default:default2
72default:default2
12default:default2�
�C:/Users/user/Desktop/Programing/Logic Design/Advance/Project/project/vivado_proj/Basys-3-XADC.srcs/sources_1/imports/hdl/decoder3_8.v2default:default2
222default:default8@Z8-6155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2

DigitToSeg2default:default2
 2default:default2
82default:default2
12default:default2�
�C:/Users/user/Desktop/Programing/Logic Design/Advance/Project/project/vivado_proj/Basys-3-XADC.srcs/sources_1/imports/hdl/DigitToSeg.v2default:default2
232default:default8@Z8-6155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
XADCdemo2default:default2
 2default:default2
92default:default2
12default:default2�
�C:/Users/user/Desktop/Programing/Logic Design/Advance/Project/project/vivado_proj/Basys-3-XADC.srcs/sources_1/imports/hdl/XADCdemo.v2default:default2
232default:default8@Z8-6155h px� 
�
%s*synth2�
wFinished RTL Elaboration : Time (s): cpu = 00:00:05 ; elapsed = 00:00:05 . Memory (MB): peak = 1017.906 ; gain = 0.000
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
M
%s
*synth25
!Start Handling Custom Attributes
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
�Finished Handling Custom Attributes : Time (s): cpu = 00:00:05 ; elapsed = 00:00:06 . Memory (MB): peak = 1017.906 ; gain = 0.000
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
�Finished RTL Optimization Phase 1 : Time (s): cpu = 00:00:05 ; elapsed = 00:00:06 . Memory (MB): peak = 1017.906 ; gain = 0.000
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2 
00:00:00.0072default:default2
1017.9062default:default2
0.0002default:defaultZ17-268h px� 
K
)Preparing netlist for logic optimization
349*projectZ1-570h px� 
>

Processing XDC Constraints
244*projectZ1-262h px� 
=
Initializing timing engine
348*projectZ1-569h px� 
�
$Parsing XDC File [%s] for cell '%s'
848*designutils2�
�c:/Users/user/Desktop/Programing/Logic Design/Advance/Project/project/vivado_proj/Basys-3-XADC.srcs/sources_1/ip/xadc_wiz_1/xadc_wiz_1/xadc_wiz_1_in_context.xdc2default:default2
XLXI_7	2default:default8Z20-848h px� 
�
-Finished Parsing XDC File [%s] for cell '%s'
847*designutils2�
�c:/Users/user/Desktop/Programing/Logic Design/Advance/Project/project/vivado_proj/Basys-3-XADC.srcs/sources_1/ip/xadc_wiz_1/xadc_wiz_1/xadc_wiz_1_in_context.xdc2default:default2
XLXI_7	2default:default8Z20-847h px� 
�
Parsing XDC File [%s]
179*designutils2�
�C:/Users/user/Desktop/Programing/Logic Design/Advance/Project/project/vivado_proj/Basys-3-XADC.srcs/constrs_1/imports/constraints/Basys3_Master.xdc2default:default8Z20-179h px� 
�
Finished Parsing XDC File [%s]
178*designutils2�
�C:/Users/user/Desktop/Programing/Logic Design/Advance/Project/project/vivado_proj/Basys-3-XADC.srcs/constrs_1/imports/constraints/Basys3_Master.xdc2default:default8Z20-178h px� 
�
�Implementation specific constraints were found while reading constraint file [%s]. These constraints will be ignored for synthesis but will be used in implementation. Impacted constraints are listed in the file [%s].
233*project2�
�C:/Users/user/Desktop/Programing/Logic Design/Advance/Project/project/vivado_proj/Basys-3-XADC.srcs/constrs_1/imports/constraints/Basys3_Master.xdc2default:default2.
.Xil/XADCdemo_propImpl.xdc2default:defaultZ1-236h px� 
H
&Completed Processing XDC Constraints

245*projectZ1-263h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2
00:00:002default:default2
1081.0312default:default2
0.0002default:defaultZ17-268h px� 
~
!Unisim Transformation Summary:
%s111*project29
%No Unisim elements were transformed.
2default:defaultZ1-111h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common24
 Constraint Validation Runtime : 2default:default2
00:00:002default:default2 
00:00:00.0062default:default2
1081.0312default:default2
0.0002default:defaultZ17-268h px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
~Finished Constraint Validation : Time (s): cpu = 00:00:11 ; elapsed = 00:00:12 . Memory (MB): peak = 1081.031 ; gain = 63.125
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
V
%s
*synth2>
*Start Loading Part and Timing Information
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
J
%s
*synth22
Loading part: xc7a35tcpg236-1
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
�Finished Loading Part and Timing Information : Time (s): cpu = 00:00:11 ; elapsed = 00:00:12 . Memory (MB): peak = 1081.031 ; gain = 63.125
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
Z
%s
*synth2B
.Start Applying 'set_property' XDC Constraints
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
�Finished applying 'set_property' XDC Constraints : Time (s): cpu = 00:00:11 ; elapsed = 00:00:12 . Memory (MB): peak = 1081.031 ; gain = 63.125
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
�Finished RTL Optimization Phase 2 : Time (s): cpu = 00:00:11 ; elapsed = 00:00:12 . Memory (MB): peak = 1081.031 ; gain = 63.125
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
L
%s
*synth24
 Start RTL Component Statistics 
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
K
%s
*synth23
Detailed RTL Component Info : 
2default:defaulth p
x
� 
:
%s
*synth2"
+---Adders : 
2default:defaulth p
x
� 
X
%s
*synth2@
,	   2 Input   32 Bit       Adders := 1     
2default:defaulth p
x
� 
X
%s
*synth2@
,	   2 Input    3 Bit       Adders := 1     
2default:defaulth p
x
� 
X
%s
*synth2@
,	   2 Input    2 Bit       Adders := 1     
2default:defaulth p
x
� 
=
%s
*synth2%
+---Registers : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	               32 Bit    Registers := 2     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	               29 Bit    Registers := 1     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	               16 Bit    Registers := 4     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	                5 Bit    Registers := 1     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	                4 Bit    Registers := 1     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	                3 Bit    Registers := 2     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	                2 Bit    Registers := 2     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	                1 Bit    Registers := 2     
2default:defaulth p
x
� 
9
%s
*synth2!
+---Muxes : 
2default:defaulth p
x
� 
X
%s
*synth2@
,	   6 Input   32 Bit        Muxes := 1     
2default:defaulth p
x
� 
X
%s
*synth2@
,	   2 Input   32 Bit        Muxes := 1     
2default:defaulth p
x
� 
X
%s
*synth2@
,	   4 Input   16 Bit        Muxes := 1     
2default:defaulth p
x
� 
X
%s
*synth2@
,	   6 Input    3 Bit        Muxes := 1     
2default:defaulth p
x
� 
X
%s
*synth2@
,	   6 Input    2 Bit        Muxes := 1     
2default:defaulth p
x
� 
X
%s
*synth2@
,	   2 Input    2 Bit        Muxes := 1     
2default:defaulth p
x
� 
X
%s
*synth2@
,	   5 Input    2 Bit        Muxes := 1     
2default:defaulth p
x
� 
X
%s
*synth2@
,	   6 Input    1 Bit        Muxes := 4     
2default:defaulth p
x
� 
X
%s
*synth2@
,	   3 Input    1 Bit        Muxes := 1     
2default:defaulth p
x
� 
X
%s
*synth2@
,	   2 Input    1 Bit        Muxes := 4     
2default:defaulth p
x
� 
X
%s
*synth2@
,	   4 Input    1 Bit        Muxes := 3     
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
O
%s
*synth27
#Finished RTL Component Statistics 
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
H
%s
*synth20
Start Part Resource Summary
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s
*synth2j
VPart Resources:
DSPs: 90 (col length:60)
BRAMs: 100 (col length: RAMB18 60 RAMB36 30)
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
K
%s
*synth23
Finished Part Resource Summary
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
W
%s
*synth2?
+Start Cross Boundary and Area Optimization
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
�Finished Cross Boundary and Area Optimization : Time (s): cpu = 00:00:14 ; elapsed = 00:00:15 . Memory (MB): peak = 1081.031 ; gain = 63.125
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
R
%s
*synth2:
&Start Applying XDC Timing Constraints
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
�Finished Applying XDC Timing Constraints : Time (s): cpu = 00:00:23 ; elapsed = 00:00:24 . Memory (MB): peak = 1108.223 ; gain = 90.316
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
E
%s
*synth2-
Start Technology Mapping
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
|Finished Technology Mapping : Time (s): cpu = 00:00:23 ; elapsed = 00:00:24 . Memory (MB): peak = 1137.547 ; gain = 119.641
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
?
%s
*synth2'
Start IO Insertion
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
H
%s
*synth20
Start Final Netlist Cleanup
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
K
%s
*synth23
Finished Final Netlist Cleanup
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
vFinished IO Insertion : Time (s): cpu = 00:00:26 ; elapsed = 00:00:28 . Memory (MB): peak = 1137.547 ; gain = 119.641
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
O
%s
*synth27
#Start Renaming Generated Instances
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
�Finished Renaming Generated Instances : Time (s): cpu = 00:00:26 ; elapsed = 00:00:28 . Memory (MB): peak = 1137.547 ; gain = 119.641
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
M
%s
*synth25
!Start Handling Custom Attributes
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
�Finished Handling Custom Attributes : Time (s): cpu = 00:00:26 ; elapsed = 00:00:28 . Memory (MB): peak = 1137.547 ; gain = 119.641
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
K
%s
*synth23
Start Writing Synthesis Report
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
A
%s
*synth2)

Report BlackBoxes: 
2default:defaulth p
x
� 
O
%s
*synth27
#+------+--------------+----------+
2default:defaulth p
x
� 
O
%s
*synth27
#|      |BlackBox name |Instances |
2default:defaulth p
x
� 
O
%s
*synth27
#+------+--------------+----------+
2default:defaulth p
x
� 
O
%s
*synth27
#|1     |xadc_wiz_1    |         1|
2default:defaulth p
x
� 
O
%s
*synth27
#+------+--------------+----------+
2default:defaulth p
x
� 
A
%s*synth2)

Report Cell Usage: 
2default:defaulth px� 
F
%s*synth2.
+------+---------+------+
2default:defaulth px� 
F
%s*synth2.
|      |Cell     |Count |
2default:defaulth px� 
F
%s*synth2.
+------+---------+------+
2default:defaulth px� 
F
%s*synth2.
|1     |xadc_wiz |     1|
2default:defaulth px� 
F
%s*synth2.
|2     |BUFG     |     1|
2default:defaulth px� 
F
%s*synth2.
|3     |CARRY4   |    17|
2default:defaulth px� 
F
%s*synth2.
|4     |DSP48E1  |     1|
2default:defaulth px� 
F
%s*synth2.
|5     |LUT1     |     3|
2default:defaulth px� 
F
%s*synth2.
|6     |LUT2     |    18|
2default:defaulth px� 
F
%s*synth2.
|7     |LUT3     |    28|
2default:defaulth px� 
F
%s*synth2.
|8     |LUT4     |    27|
2default:defaulth px� 
F
%s*synth2.
|9     |LUT5     |    41|
2default:defaulth px� 
F
%s*synth2.
|10    |LUT6     |    21|
2default:defaulth px� 
F
%s*synth2.
|11    |FDRE     |   163|
2default:defaulth px� 
F
%s*synth2.
|12    |IBUF     |    13|
2default:defaulth px� 
F
%s*synth2.
|13    |OBUF     |    28|
2default:defaulth px� 
F
%s*synth2.
+------+---------+------+
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
�Finished Writing Synthesis Report : Time (s): cpu = 00:00:26 ; elapsed = 00:00:28 . Memory (MB): peak = 1137.547 ; gain = 119.641
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
r
%s
*synth2Z
FSynthesis finished with 0 errors, 0 critical warnings and 0 warnings.
2default:defaulth p
x
� 
�
%s
*synth2�
~Synthesis Optimization Runtime : Time (s): cpu = 00:00:19 ; elapsed = 00:00:26 . Memory (MB): peak = 1137.547 ; gain = 56.516
2default:defaulth p
x
� 
�
%s
*synth2�
�Synthesis Optimization Complete : Time (s): cpu = 00:00:26 ; elapsed = 00:00:28 . Memory (MB): peak = 1137.547 ; gain = 119.641
2default:defaulth p
x
� 
B
 Translating synthesized netlist
350*projectZ1-571h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2 
00:00:00.0042default:default2
1137.5472default:default2
0.0002default:defaultZ17-268h px� 
f
-Analyzing %s Unisim elements for replacement
17*netlist2
182default:defaultZ29-17h px� 
j
2Unisim Transformation completed in %s CPU seconds
28*netlist2
02default:defaultZ29-28h px� 
K
)Preparing netlist for logic optimization
349*projectZ1-570h px� 
u
)Pushed %s inverter(s) to %s load pin(s).
98*opt2
02default:default2
02default:defaultZ31-138h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2
00:00:002default:default2
1137.5472default:default2
0.0002default:defaultZ17-268h px� 
~
!Unisim Transformation Summary:
%s111*project29
%No Unisim elements were transformed.
2default:defaultZ1-111h px� 
U
Releasing license: %s
83*common2
	Synthesis2default:defaultZ17-83h px� 
�
G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
372default:default2
52default:default2
02default:default2
02default:defaultZ4-41h px� 
^
%s completed successfully
29*	vivadotcl2 
synth_design2default:defaultZ4-42h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2"
synth_design: 2default:default2
00:00:312default:default2
00:00:342default:default2
1137.5472default:default2
119.6412default:defaultZ17-268h px� 
�
 The %s '%s' has been generated.
621*common2

checkpoint2default:default2�
xC:/Users/user/Desktop/Programing/Logic Design/Advance/Project/project/vivado_proj/Basys-3-XADC.runs/synth_1/XADCdemo.dcp2default:defaultZ17-1381h px� 
�
%s4*runtcl2z
fExecuting : report_utilization -file XADCdemo_utilization_synth.rpt -pb XADCdemo_utilization_synth.pb
2default:defaulth px� 
�
Exiting %s at %s...
206*common2
Vivado2default:default2,
Fri Jan  7 00:18:54 20222default:defaultZ17-206h px� 


End Record