//Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2020.2 (win64) Build 3064766 Wed Nov 18 09:12:45 MST 2020
//Date        : Wed Jan  5 09:56:39 2022
//Host        : zun running 64-bit major release  (build 9200)
//Command     : generate_target design_1.bd
//Design      : design_1
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "design_1,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=design_1,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=6,numReposBlks=6,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=0,numPkgbdBlks=0,bdsource=USER,da_board_cnt=4,da_clkrst_cnt=2,synth_mode=OOC_per_IP}" *) (* HW_HANDOFF = "design_1.hwdef" *) 
module design_1
   (Vaux6_v_n,
    Vaux6_v_p,
    clk_in1,
    reset_rtl_0,
    sw);
  (* X_INTERFACE_INFO = "xilinx.com:interface:diff_analog_io:1.0 Vaux6 V_N" *) input Vaux6_v_n;
  (* X_INTERFACE_INFO = "xilinx.com:interface:diff_analog_io:1.0 Vaux6 V_P" *) input Vaux6_v_p;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.CLK_IN1 CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.CLK_IN1, CLK_DOMAIN design_1_clk_in1, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0.000" *) input clk_in1;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.RESET_RTL_0 RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.RESET_RTL_0, INSERT_VIP 0, POLARITY ACTIVE_HIGH" *) input reset_rtl_0;
  input [6:0]sw;

  wire Net;
  wire Vaux6_1_V_N;
  wire Vaux6_1_V_P;
  wire clk_in1_1;
  wire clk_wiz_0_clk_out1;
  wire reset_rtl_0_1;
  wire [6:0]sw_1;
  wire [15:0]xadc_wiz_0_do_out;
  wire [0:0]xlconstant_0_dout;
  wire [15:0]xlconstant_1_dout;
  wire [11:0]xlslice_0_Dout;

  assign Vaux6_1_V_N = Vaux6_v_n;
  assign Vaux6_1_V_P = Vaux6_v_p;
  assign clk_in1_1 = clk_in1;
  assign reset_rtl_0_1 = reset_rtl_0;
  assign sw_1 = sw[6:0];
  design_1_clk_wiz_0_0 clk_wiz_0
       (.clk_in1(clk_in1_1),
        .clk_out1(clk_wiz_0_clk_out1),
        .reset(reset_rtl_0_1));
  design_1_ila_0_0 ila_0
       (.clk(clk_wiz_0_clk_out1),
        .probe0(xlslice_0_Dout),
        .probe1(Net));
  design_1_xadc_wiz_0_0 xadc_wiz_0
       (.daddr_in(sw_1),
        .dclk_in(clk_wiz_0_clk_out1),
        .den_in(Net),
        .di_in(xlconstant_1_dout),
        .do_out(xadc_wiz_0_do_out),
        .dwe_in(xlconstant_0_dout),
        .eoc_out(Net),
        .reset_in(1'b0),
        .vauxn6(Vaux6_1_V_N),
        .vauxp6(Vaux6_1_V_P),
        .vn_in(1'b0),
        .vp_in(1'b0));
  design_1_xlconstant_0_0 xlconstant_0
       (.dout(xlconstant_0_dout));
  design_1_xlconstant_1_0 xlconstant_1
       (.dout(xlconstant_1_dout));
  design_1_xlslice_0_0 xlslice_0
       (.Din(xadc_wiz_0_do_out),
        .Dout(xlslice_0_Dout));
endmodule
