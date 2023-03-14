module TOP(
    input clk,
    input vauxp6,
    input vauxn6,
    input vauxp7,
    input vauxn7,
    input vauxp15,
    input vauxn15,
    input vauxp14,
    input vauxn14,
    input vp_in,
    input vn_in,
    input [1:0] sw,
    input [2:0] mode,
    output [15:0] led,
    output [3:0] an,
    output dp,
    output [6:0] seg,

    input rst,
    output pwm
);

wire [15:0] voice_1, voice_2;

XADCdemo XADCdemo1(
    clk,
    vauxp6,
    vauxn6,
    vauxp7,
    vauxn7,
    vauxp15,
    vauxn15,
    vauxp14,
    vauxn14,
    vp_in,
    vn_in,
    sw,
    led,
    an,
    dp,
    seg,
    voice_1,
    voice_2
); 

LED led1(clk, rst, mode, voice_2, pwm);

endmodule