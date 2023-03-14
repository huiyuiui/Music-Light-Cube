////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 1995-2013 Xilinx, Inc.  All rights reserved.
////////////////////////////////////////////////////////////////////////////////
//   ____  ____ 
//  /   /\/   / 
// /___/  \  /    Vendor: Xilinx 
// \   \   \/     Version : 14.7
//  \   \         Application : sch2hdl
//  /   /         Filename : Top.vf
// /___/   /\     Timestamp : 12/01/2014 17:59:05
// \   \  /  \ 
//  \___\/\___\ 
//
//Command: sch2hdl -intstyle ise -family spartan3e -verilog C:/Users/samue_000/Documents/FPGA/Projects/Stopwatch/sevensegdecoder/Top.vf -w C:/Users/samue_000/Documents/FPGA/Projects/Stopwatch/sevensegdecoder/Top.sch
//Design Name: Top
//Device: spartan3e
//Purpose:
//    This verilog netlist is translated from an ECS schematic.It can be 
//    synthesized and simulated, but it should not be modified. 
//
`timescale 1ns / 1ps

module DigitToSeg(in1, 
           in2, 
           in3, 
           in4,
           in5,
           in6,
           in7,
           in8, 
           mclk, 
           an, 
           dp,
           seg);

    input [3:0] in1;
    input [3:0] in2;
    input [3:0] in3;
    input [3:0] in4;
    input [3:0] in5;
    input [3:0] in6;
    input [3:0] in7;
    input [3:0] in8;
    input mclk;
    output [3:0] an;
    output [6:0] seg;
    output dp;
   
   //wire swt7;
   wire XLXN_94;
   wire [3:0] XLXN_102;
   wire [2:0] XLXN_109;
   
   sevensegdecoder  XLXI_6 (.nIn(XLXN_102[3:0]), //nin為實值
                           .ssOut(seg[6:0]));    //ssout為七段顯示器顯示的值

   mux4_4bus  XLXI_45 (.I0(in1[3:0]), //把八個4bit input去做選擇並且選擇的值給到七段顯示器去做顯示
                      .I1(in2[3:0]), 
                      .I2(in3[3:0]), 
                      .I3(in4[3:0]),
                      .I4(in5[3:0]), 
                      .I5(in6[3:0]), 
                      .I6(in7[3:0]), 
                      .I7(in8[3:0]),  
                      .Sel(XLXN_109[2:0]), //counter的Q從0到7作為選擇
                      .Y(XLXN_102[3:0])); //單個七段顯示器輸出的值
                      
   segClkDevider  XLXI_47 (.clk(mclk), 
                          .rst(), 
                          .clk_div(XLXN_94));//20000個原始clk為一週期, 七段顯示器的刷新頻率
                          
   //GND  XLXI_48 (.G(swt7));
   counter3bit  XLXI_49 (.clk(XLXN_94), 
                        .rst(), 
                        .Q(XLXN_109[2:0]));//Q會從0加到7並重複計數

   decoder_3_8  XLXI_50 (.I(XLXN_109[2:0]),
                        .dp(dp), 
                        .an(an[3:0]));
                        
endmodule
