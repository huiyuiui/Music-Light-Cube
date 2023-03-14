`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/12/27 01:35:41
// Design Name: 
// Module Name: Sound
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module Top (clk, rst, AN, seg, Dout, Aout, LED_1, LED_2, LED_3, LED_4, LED_5, LED_6, LED_7, LED_8);
//module Top (clk, rst, AN, seg, Dout, Aout, LED_D, LED_A);
input clk;
input rst;
input Dout;
input Aout;
output [3:0] AN;
output reg [0:6] seg;
output LED_1, LED_2, LED_3, LED_4, LED_5, LED_6, LED_7, LED_8;
wire [0:6] seg_3, seg_2, seg_1, seg_0;
assign LED_D = Dout;
assign LED_A = Aout;
wire dclk_0001s, dclk_00078125s;
Counter_0001s C1(clk, rst, dclk_0001s);
Counter_00078125s C2(clk, rst, dclk_00078125s);
//Counter_00078125s C2(clk, rst, dclk_00078125s);
//Sound S(dclk_0001s, clk, rst, AN, seg_3, seg_2, seg_1, seg_0, Dout, Aout, LED_1, LED_2, LED_3, LED_4, LED_5, LED_6, LED_7, LED_8);
Sound S(dclk_0001s, dclk_00078125s, rst, AN, seg_3, seg_2, seg_1, seg_0, Dout, Aout, LED_1, LED_2, LED_3, LED_4, LED_5, LED_6, LED_7, LED_8);
always @(*) begin
    case(AN)
        4'b1110: seg = seg_0;
        4'b1101: seg = seg_1;
        4'b1011: seg = seg_2;
        4'b0111: seg = seg_3;
        default: seg = seg_0;
    endcase
end
endmodule


module Sound (clk_0001, clk_00078125, rst, AN, seg_3, seg_2, seg_1, seg_0, Dout, Aout, L1, L2, L3, L4, L5, L6, L7, L8);
input clk_0001;
input clk_00078125;
input rst;
input Dout;
input Aout;
output reg [3:0] AN;
output reg [0:6] seg_3, seg_2, seg_1, seg_0;
output reg L1, L2, L3, L4, L5, L6, L7, L8;

reg [7:0] bit;
reg [3:0] count;
wire [3:0] next_count;
wire N1, N2, N3, N4, N5, N6, N7, N8;

always @(posedge clk_0001) begin
    case(AN)
        4'b1110: AN <= 4'b1101;
        4'b1101: AN <= 4'b1011;
        4'b1011: AN <= 4'b0111;
        4'b0111: AN <= 4'b1110;
        default: AN <= 4'b1110;
    endcase
end

always @(posedge clk_00078125) begin
    if(count == 4'd8) begin
        L1 <= bit[0];
        L2 <= bit[1];
        L3 <= bit[2];
        L4 <= bit[3];
        L5 <= bit[4];
        L6 <= bit[5];
        L7 <= bit[6];
        L8 <= bit[7];
        count <= 4'd0;
    end else begin
        L1 <= N1;
        L2 <= N2;
        L3 <= N3;
        L4 <= N4;
        L5 <= N5;
        L6 <= N6;
        L7 <= N7;
        L8 <= N8;
        count <= next_count;
    end
    bit[7:1] <= bit[6:0];
    bit[0] <= Aout;
end

assign next_count = count + 1'd1;
assign N1 = L1;
assign N2 = L2;
assign N3 = L3;
assign N4 = L4;
assign N5 = L5;
assign N6 = L6;
assign N7 = L7;
assign N8 = L8;

always @(*) begin
    if(Dout) begin
        seg_3 = 7'b1111111;
    end else begin
        seg_3 = 7'b0000001;
    end
//    if(Aout >= 200) begin
//        seg_3 = 7'b1111111;
//        seg_2 = 7'b0010010;
//        seg_1 = 7'b0000001;
//        seg_0 = 7'b0000001;
//    end else if (Aout >= 150) begin
//        seg_3 = 7'b1111111;
//        seg_2 = 7'b1001111;
//        seg_1 = 7'b0100100;
//        seg_0 = 7'b0000001;
//    end else if(Aout >= 100) begin
//        seg_3 = 7'b1111111;
//        seg_2 = 7'b1001111;
//        seg_1 = 7'b0000001;
//        seg_0 = 7'b0000001;
//    end else if(Aout >= 50) begin
//        seg_3 = 7'b1111111;
//        seg_2 = 7'b1111111;
//        seg_1 = 7'b0100100;
//        seg_0 = 7'b0000001;
//    end else begin
//        seg_3 = 7'b1111111;
//        seg_2 = 7'b1111111;
//        seg_1 = 7'b1111111;
//        seg_0 = 7'b0000001;
//    end
end

endmodule

module Counter_0001s(clk, rst, dclk);
input clk;
input rst;
output reg dclk;
reg [26:0] count, next_count;

 always @(posedge clk) begin
    if(rst == 1'd1) count <= 27'd0;
    else count <= next_count;
 end

always @(*) begin
    if(count == 27'd100000) begin
        dclk = 1'b1;
        next_count = 27'd0;
    end else begin
        dclk = 1'b0;
        next_count = count + 1'd1;
    end
end

endmodule

module Counter_00078125s(clk, rst, dclk);
input clk;
input rst;
output reg dclk;
reg [26:0] count, next_count;

 always @(posedge clk) begin
    if(rst == 1'd1) count <= 27'd0;
    else count <= next_count;
 end

always @(*) begin
    if(count == 27'd6944) begin
//    if(count == 27'd781250) begin
        dclk = 1'b1;
        next_count = 27'd0;
    end else begin
        dclk = 1'b0;
        next_count = count + 1'd1;
    end
end

endmodule