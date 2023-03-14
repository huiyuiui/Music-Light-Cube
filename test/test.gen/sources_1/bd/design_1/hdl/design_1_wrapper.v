//Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2020.2 (win64) Build 3064766 Wed Nov 18 09:12:45 MST 2020
//Date        : Thu Jan 13 14:50:11 2022
//Host        : zun running 64-bit major release  (build 9200)
//Command     : generate_target design_1_wrapper.bd
//Design      : design_1_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module design_1_wrapper
   (Vaux6_v_n,
    Vaux6_v_p,
    clk_in1,
    sw);
  input Vaux6_v_n;
  input Vaux6_v_p;
  input clk_in1;
  input [6:0]sw;

  wire Vaux6_v_n;
  wire Vaux6_v_p;
  wire clk_in1;
  wire [6:0]sw;

  design_1 design_1_i
       (.Vaux6_v_n(Vaux6_v_n),
        .Vaux6_v_p(Vaux6_v_p),
        .clk_in1(clk_in1),
        .sw(sw));
endmodule
