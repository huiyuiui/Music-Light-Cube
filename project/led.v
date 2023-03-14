`define whit 24'hf0f0f0 //white
`define dark 24'h000000
`define red 24'h8ef591
`define ored 24'h8efd01
`define oran 24'h45ff00
`define yora 24'h8ffe01
`define yell 24'hccfb00
`define ygre 24'hff007f
`define gree 24'hb52450
`define bgre 24'h8b1e7c
`define blue 24'h6541af
`define bvio 24'h4275ff
`define viol 24'h1f7aa0
`define rvio 24'h31abaa

`define t248 35'd24800000000
`define t234 35'd23300000000
`define t196 35'd19500000000
`define t179 35'd17800000000
`define t159 35'd15800000000
`define t140 35'd14000000000
`define t122 35'd12100000000
`define t83 35'd8300000000 //83s
`define t66 35'd6500000000 //66s
`define t9 35'd900000000 //9s
`define t3 35'd300000000 //3s
`define t1 35'd100000000 //1s
`define t06 35'd60000000 //0.6s
`define t05 35'd50000000 //0.5s
`define t04 35'd40000000 //0.4s
`define t01 35'd10000000 //0.1s
`define t0099 35'd9900000 //0.099s
`define t0098 35'd9800000 //0.098s
`define t0097 35'd9700000 //0.097s
`define t0096 35'd9600000 //0.096s
`define t0095 35'd9500000 //0.095s
`define t0094 35'd9400000 //0.094s
`define t0093 35'd9300000 //0.093s
`define t005 35'd5000000 //0.05s
`define t001 35'd1000000 //0.01s
`define t0005 35'd500000 //0.005s

`define voice_hhigh 16'h900
`define voice_high 16'h840
`define voice_hmid 16'h700
`define voice_mid 16'h600
`define voice_lmid 16'h500
`define voice_low 16'h420
`define voice_llow 16'h300

module LED(
    input clk,
    input rst,
    input [2:0] sel_mode,
    input [15:0] voice,
    output pwm
);

parameter RST = 15'd30000; //300µs*100Mhz

reg [2:0] mode;
reg [23:0] GRB;
reg [23:0] G [7:0] [3:0] [3:0];
reg [6:0] number, next_number; //2^7 = 128
reg start, next_start;
wire done, time_3, time_1, time_06, time_05, time_04, time_01, time_RST, time_001, time_005;
wire time_0093, time_0094, time_0095, time_0096, time_0097, time_0098, time_0099, time_0005;
wire time_9, time_66, time_83, time_122, time_140, time_159, time_179, time_196, time_234, time_248;
reg [6:0] mode7state, next_mode7state;
wire [2:0] nx, ny, nz, mode7x1, mode7y1, mode7z1, mode7x2, mode7y2, mode7z2;
reg mode0state, next_mode0state;
reg [2:0] mode1x [1:0] [3:0] [3:0];
reg [2:0] mode1y [1:0] [3:0] [3:0];
reg [2:0] mode1z [1:0] [3:0] [3:0];
reg [2:0] mode1dx [1:0] [3:0] [3:0];
reg [3:0] mode1color, next_mode1color;
reg [23:0] mode1GRB, mode2GRB;
reg mode1speed, mode3speed;
reg [1:0] mode2state2, next_mode2state2;
reg [2:0] mode2state, next_mode2state;
wire [4:0] rand, randcolor;
reg [4:0] mode3state, next_mode3state;
reg [1:0] mode3dir, next_mode3dir;
reg [3:0] mode4state, next_mode4state;
reg [1:0] mode6z [31:0];
reg mode6dz [31:0];
PWM pwm_1(clk, rst, GRB, start, done, pwm); 
COUNT #(`t1) count_1(clk, rst, time_1);
COUNT #(`t01) count_2(clk, rst, time_01);
COUNT #(RST) count_3(clk, rst | (start), time_RST);
COUNT #(`t001) count_4(clk, rst, time_001);
COUNT #(`t3) count_5(clk, rst, time_3);
COUNT #(`t005) count_6(clk, rst, time_005);
COUNT #(`t05) count_7(clk, rst, time_05);
COUNT #(`t04) count_8(clk, rst, time_04);
COUNT #(`t06) count_9(clk, rst, time_06);
COUNT #(`t0093) count_0093(clk, rst, time_0093);
COUNT #(`t0094) count_10(clk, rst, time_0094);
COUNT #(`t0095) count_11(clk, rst, time_0095);
COUNT #(`t0096) count_12(clk, rst, time_0096);
COUNT #(`t0097) count_13(clk, rst, time_0097);
COUNT #(`t0098) count_14(clk, rst, time_0098);
COUNT #(`t0099) count_15(clk, rst, time_0099);
COUNT #(`t0005) count_16(clk, rst, time_0005);
COUNT #(`t248) count_17(clk, rst, time_248);
COUNT #(`t234) count_18(clk, rst, time_234);
COUNT #(`t196) count_19(clk, rst, time_196);
COUNT #(`t179) count_20(clk, rst, time_179);
COUNT #(`t159) count_21(clk, rst, time_159);
COUNT #(`t122) count_22(clk, rst, time_122);
COUNT #(`t83 ) count_23(clk, rst, time_83);
COUNT #(`t66 ) count_24(clk, rst, time_66);
COUNT #(`t140 ) count_25(clk, rst, time_140);
COUNT #(`t9 ) count_26(clk, rst, time_9);
To_xyz to_xymode7z1(number, nx, ny, nz);
To_xyz to_xymode7z2(mode7state, mode7x1, mode7y1, mode7z1);
To_xyz to_xyz_3(mode7state+1'b1, mode7x2, mode7y2, mode7z2);
LFSR lfsr_1(clk, rst, rand);
LFSR lfsr_2(clk, rst, randcolor);

always @(posedge clk) begin
    if(rst) begin
        start <= 1'b0;
        number <= 6'd0;
        mode7state <= 7'd0;
        mode0state <= 1'b0;
        mode1color <= 4'd0;
        mode2state <= 3'd0;
        mode2state2 <= 2'd0;
        mode3state <= 5'd0;
        mode3dir <= 2'd0;
        mode4state <= 4'd0;
    end
    else begin
        start <= next_start;
        number <= next_number;
        mode7state <= next_mode7state;
        mode0state <= next_mode0state;
        mode1color <= next_mode1color;
        mode2state <= next_mode2state;
        mode2state2 <= next_mode2state2;
        mode3state <= next_mode3state;
        mode3dir <= next_mode3dir;
        mode4state <= next_mode4state;
    end
end

//selmode mode4state
always @(*) begin
    if(sel_mode==3'd4) begin
        case(mode4state) 
            4'd0: begin
                mode = 3'd7;
                next_mode4state = (time_9 ? mode4state+1'b1 : mode4state);
            end
            4'd1: begin
                mode = 3'd6;
                next_mode4state = (time_66 ? mode4state+1'b1 : mode4state);
            end
            4'd2: begin
                mode = 3'd0;
                next_mode4state = (time_83 ? mode4state+1'b1 : mode4state);
            end
            4'd3: begin
                mode = 3'd2;
                next_mode4state = (time_122 ? mode4state+1'b1 : mode4state);
            end
            4'd4: begin
                mode = 3'd5;
                next_mode4state = (time_140 ? mode4state+1'b1 : mode4state);
            end
            4'd5: begin
                mode = 3'd7;
                next_mode4state = (time_159 ? mode4state+1'b1 : mode4state);
            end
            4'd6: begin
                mode = 3'd2;
                next_mode4state = (time_179 ? mode4state+1'b1 : mode4state);
            end
            4'd7: begin
                mode = 3'd1;
                next_mode4state = (time_196 ? mode4state+1'b1 : mode4state);
            end
            4'd8: begin
                mode = 3'd3;
                next_mode4state = (time_234 ? mode4state+1'b1 : mode4state);
            end
            4'd9: begin
                mode = 3'd7;
                next_mode4state = (mode7state==7'd127 ? mode4state+1'b1 : mode4state);
            end
            4'd10: begin
                mode = 3'd0;
                next_mode4state = mode4state;
            end
            default: begin
                mode = 3'd7;
                next_mode4state = 4'd0;
            end
        endcase
    end
    else mode = sel_mode;
end

//mode state
always @(posedge clk) begin
    if(mode==3'd0) begin //heart
        if(mode0state==1'b0) begin //All dark
            //y0 
            G[0][0][3] <= `dark; G[1][0][3] <= `dark; G[2][0][3] <= `dark; G[3][0][3] <= `dark; G[4][0][3] <= `dark; G[5][0][3] <= `dark; G[6][0][3] <= `dark; G[7][0][3] <= `dark;
            G[0][0][2] <= `dark; G[1][0][2] <= `dark; G[2][0][2] <= `dark; G[3][0][2] <= `dark; G[4][0][2] <= `dark; G[5][0][2] <= `dark; G[6][0][2] <= `dark; G[7][0][2] <= `dark;
            G[0][0][1] <= `dark; G[1][0][1] <= `dark; G[2][0][1] <= `dark; G[3][0][1] <= `dark; G[4][0][1] <= `dark; G[5][0][1] <= `dark; G[6][0][1] <= `dark; G[7][0][1] <= `dark;
            G[0][0][0] <= `dark; G[1][0][0] <= `dark; G[2][0][0] <= `dark; G[3][0][0] <= `dark; G[4][0][0] <= `dark; G[5][0][0] <= `dark; G[6][0][0] <= `dark; G[7][0][0] <= `dark;
            //y1
            G[0][1][3] <= `dark; G[1][1][3] <= `dark; G[2][1][3] <= `dark; G[3][1][3] <= `dark; G[4][1][3] <= `dark; G[5][1][3] <= `dark; G[6][1][3] <= `dark; G[7][1][3] <= `dark;
            G[0][1][2] <= `dark; G[1][1][2] <= `dark; G[2][1][2] <= `dark; G[3][1][2] <= `dark; G[4][1][2] <= `dark; G[5][1][2] <= `dark; G[6][1][2] <= `dark; G[7][1][2] <= `dark;
            G[0][1][1] <= `dark; G[1][1][1] <= `dark; G[2][1][1] <= `dark; G[3][1][1] <= `dark; G[4][1][1] <= `dark; G[5][1][1] <= `dark; G[6][1][1] <= `dark; G[7][1][1] <= `dark;
            G[0][1][0] <= `dark; G[1][1][0] <= `dark; G[2][1][0] <= `dark; G[3][1][0] <= `dark; G[4][1][0] <= `dark; G[5][1][0] <= `dark; G[6][1][0] <= `dark; G[7][1][0] <= `dark;
            //y2
            G[0][2][3] <= `dark; G[1][2][3] <= `dark; G[2][2][3] <= `dark; G[3][2][3] <= `dark; G[4][2][3] <= `dark; G[5][2][3] <= `dark; G[6][2][3] <= `dark; G[7][2][3] <= `dark;
            G[0][2][2] <= `dark; G[1][2][2] <= `dark; G[2][2][2] <= `dark; G[3][2][2] <= `dark; G[4][2][2] <= `dark; G[5][2][2] <= `dark; G[6][2][2] <= `dark; G[7][2][2] <= `dark;
            G[0][2][1] <= `dark; G[1][2][1] <= `dark; G[2][2][1] <= `dark; G[3][2][1] <= `dark; G[4][2][1] <= `dark; G[5][2][1] <= `dark; G[6][2][1] <= `dark; G[7][2][1] <= `dark;
            G[0][2][0] <= `dark; G[1][2][0] <= `dark; G[2][2][0] <= `dark; G[3][2][0] <= `dark; G[4][2][0] <= `dark; G[5][2][0] <= `dark; G[6][2][0] <= `dark; G[7][2][0] <= `dark;
            //y3
            G[0][3][3] <= `dark; G[1][3][3] <= `dark; G[2][3][3] <= `dark; G[3][3][3] <= `dark; G[4][3][3] <= `dark; G[5][3][3] <= `dark; G[6][3][3] <= `dark; G[7][3][3] <= `dark;
            G[0][3][2] <= `dark; G[1][3][2] <= `dark; G[2][3][2] <= `dark; G[3][3][2] <= `dark; G[4][3][2] <= `dark; G[5][3][2] <= `dark; G[6][3][2] <= `dark; G[7][3][2] <= `dark;
            G[0][3][1] <= `dark; G[1][3][1] <= `dark; G[2][3][1] <= `dark; G[3][3][1] <= `dark; G[4][3][1] <= `dark; G[5][3][1] <= `dark; G[6][3][1] <= `dark; G[7][3][1] <= `dark;
            G[0][3][0] <= `dark; G[1][3][0] <= `dark; G[2][3][0] <= `dark; G[3][3][0] <= `dark; G[4][3][0] <= `dark; G[5][3][0] <= `dark; G[6][3][0] <= `dark; G[7][3][0] <= `dark;
        end
        else begin
            //y0 
            G[0][0][3] <= `dark; G[1][0][3] <= `dark; G[2][0][3] <= `dark; G[3][0][3] <= `dark; G[4][0][3] <= `dark; G[5][0][3] <= `dark; G[6][0][3] <= `dark; G[7][0][3] <= `dark;
            G[0][0][2] <= `dark; G[1][0][2] <= `dark; G[2][0][2] <= `dark; G[3][0][2] <= mode1GRB; G[4][0][2] <= `dark; G[5][0][2] <= `dark; G[6][0][2] <= `dark; G[7][0][2] <= `dark;
            G[0][0][1] <= `dark; G[1][0][1] <= `dark; G[2][0][1] <= `dark; G[3][0][1] <= `dark; G[4][0][1] <= `dark; G[5][0][1] <= `dark; G[6][0][1] <= `dark; G[7][0][1] <= `dark;
            G[0][0][0] <= `dark; G[1][0][0] <= `dark; G[2][0][0] <= `dark; G[3][0][0] <= `dark; G[4][0][0] <= `dark; G[5][0][0] <= `dark; G[6][0][0] <= `dark; G[7][0][0] <= `dark;
            //y1
            G[0][1][3] <= `dark; G[1][1][3] <= `dark; G[2][1][3] <= `dark; G[3][1][3] <= `dark; G[4][1][3] <= `dark; G[5][1][3] <= `dark; G[6][1][3] <= `dark; G[7][1][3] <= `dark;
            G[0][1][2] <= `dark; G[1][1][2] <= `dark; G[2][1][2] <= mode1GRB; G[3][1][2] <= mode1GRB; G[4][1][2] <= mode1GRB; G[5][1][2] <= `dark; G[6][1][2] <= `dark; G[7][1][2] <= `dark;
            G[0][1][1] <= `dark; G[1][1][1] <= `dark; G[2][1][1] <= `dark; G[3][1][1] <= mode1GRB; G[4][1][1] <= `dark; G[5][1][1] <= `dark; G[6][1][1] <= `dark; G[7][1][1] <= `dark;
            G[0][1][0] <= `dark; G[1][1][0] <= `dark; G[2][1][0] <= `dark; G[3][1][0] <= `dark; G[4][1][0] <= `dark; G[5][1][0] <= `dark; G[6][1][0] <= `dark; G[7][1][0] <= `dark;
            //y2
            G[0][2][3] <= `dark; G[1][2][3] <= `dark; G[2][2][3] <= mode1GRB; G[3][2][3] <= `dark; G[4][2][3] <= mode1GRB; G[5][2][3] <= `dark; G[6][2][3] <= `dark; G[7][2][3] <= `dark;
            G[0][2][2] <= `dark; G[1][2][2] <= mode1GRB; G[2][2][2] <= mode1GRB; G[3][2][2] <= mode1GRB; G[4][2][2] <= mode1GRB; G[5][2][2] <= mode1GRB; G[6][2][2] <= `dark; G[7][2][2] <= `dark;
            G[0][2][1] <= `dark; G[1][2][1] <= `dark; G[2][2][1] <= mode1GRB; G[3][2][1] <= mode1GRB; G[4][2][1] <= mode1GRB; G[5][2][1] <= `dark; G[6][2][1] <= `dark; G[7][2][1] <= `dark;
            G[0][2][0] <= `dark; G[1][2][0] <= `dark; G[2][2][0] <= `dark; G[3][2][0] <= mode1GRB; G[4][2][0] <= `dark; G[5][2][0] <= `dark; G[6][2][0] <= `dark; G[7][2][0] <= `dark;
            //y3
            G[0][3][3] <= `dark; G[1][3][3] <= mode1GRB; G[2][3][3] <= mode1GRB; G[3][3][3] <= `dark; G[4][3][3] <= mode1GRB; G[5][3][3] <= mode1GRB; G[6][3][3] <= `dark; G[7][3][3] <= `dark;
            G[0][3][2] <= `dark; G[1][3][2] <= mode1GRB; G[2][3][2] <= mode1GRB; G[3][3][2] <= mode1GRB; G[4][3][2] <= mode1GRB; G[5][3][2] <= mode1GRB; G[6][3][2] <= `dark; G[7][3][2] <= `dark;
            G[0][3][1] <= `dark; G[1][3][1] <= `dark; G[2][3][1] <= mode1GRB; G[3][3][1] <= mode1GRB; G[4][3][1] <= mode1GRB; G[5][3][1] <= `dark; G[6][3][1] <= `dark; G[7][3][1] <= `dark;
            G[0][3][0] <= `dark; G[1][3][0] <= `dark; G[2][3][0] <= `dark; G[3][3][0] <= mode1GRB; G[4][3][0] <= `dark; G[5][3][0] <= `dark; G[6][3][0] <= `dark; G[7][3][0] <= `dark;
        end     
    end
    else if(mode==3'd1) begin //flying blanket
        //ALL dark
        //y0 
        G[0][0][3] <= `dark; G[1][0][3] <= `dark; G[2][0][3] <= `dark; G[3][0][3] <= `dark; G[4][0][3] <= `dark; G[5][0][3] <= `dark; G[6][0][3] <= `dark; G[7][0][3] <= `dark;
        G[0][0][2] <= `dark; G[1][0][2] <= `dark; G[2][0][2] <= `dark; G[3][0][2] <= `dark; G[4][0][2] <= `dark; G[5][0][2] <= `dark; G[6][0][2] <= `dark; G[7][0][2] <= `dark;
        G[0][0][1] <= `dark; G[1][0][1] <= `dark; G[2][0][1] <= `dark; G[3][0][1] <= `dark; G[4][0][1] <= `dark; G[5][0][1] <= `dark; G[6][0][1] <= `dark; G[7][0][1] <= `dark;
        G[0][0][0] <= `dark; G[1][0][0] <= `dark; G[2][0][0] <= `dark; G[3][0][0] <= `dark; G[4][0][0] <= `dark; G[5][0][0] <= `dark; G[6][0][0] <= `dark; G[7][0][0] <= `dark;
        //y1
        G[0][1][3] <= `dark; G[1][1][3] <= `dark; G[2][1][3] <= `dark; G[3][1][3] <= `dark; G[4][1][3] <= `dark; G[5][1][3] <= `dark; G[6][1][3] <= `dark; G[7][1][3] <= `dark;
        G[0][1][2] <= `dark; G[1][1][2] <= `dark; G[2][1][2] <= `dark; G[3][1][2] <= `dark; G[4][1][2] <= `dark; G[5][1][2] <= `dark; G[6][1][2] <= `dark; G[7][1][2] <= `dark;
        G[0][1][1] <= `dark; G[1][1][1] <= `dark; G[2][1][1] <= `dark; G[3][1][1] <= `dark; G[4][1][1] <= `dark; G[5][1][1] <= `dark; G[6][1][1] <= `dark; G[7][1][1] <= `dark;
        G[0][1][0] <= `dark; G[1][1][0] <= `dark; G[2][1][0] <= `dark; G[3][1][0] <= `dark; G[4][1][0] <= `dark; G[5][1][0] <= `dark; G[6][1][0] <= `dark; G[7][1][0] <= `dark;
        //y2
        G[0][2][3] <= `dark; G[1][2][3] <= `dark; G[2][2][3] <= `dark; G[3][2][3] <= `dark; G[4][2][3] <= `dark; G[5][2][3] <= `dark; G[6][2][3] <= `dark; G[7][2][3] <= `dark;
        G[0][2][2] <= `dark; G[1][2][2] <= `dark; G[2][2][2] <= `dark; G[3][2][2] <= `dark; G[4][2][2] <= `dark; G[5][2][2] <= `dark; G[6][2][2] <= `dark; G[7][2][2] <= `dark;
        G[0][2][1] <= `dark; G[1][2][1] <= `dark; G[2][2][1] <= `dark; G[3][2][1] <= `dark; G[4][2][1] <= `dark; G[5][2][1] <= `dark; G[6][2][1] <= `dark; G[7][2][1] <= `dark;
        G[0][2][0] <= `dark; G[1][2][0] <= `dark; G[2][2][0] <= `dark; G[3][2][0] <= `dark; G[4][2][0] <= `dark; G[5][2][0] <= `dark; G[6][2][0] <= `dark; G[7][2][0] <= `dark;
        //y3
        G[0][3][3] <= `dark; G[1][3][3] <= `dark; G[2][3][3] <= `dark; G[3][3][3] <= `dark; G[4][3][3] <= `dark; G[5][3][3] <= `dark; G[6][3][3] <= `dark; G[7][3][3] <= `dark;
        G[0][3][2] <= `dark; G[1][3][2] <= `dark; G[2][3][2] <= `dark; G[3][3][2] <= `dark; G[4][3][2] <= `dark; G[5][3][2] <= `dark; G[6][3][2] <= `dark; G[7][3][2] <= `dark;
        G[0][3][1] <= `dark; G[1][3][1] <= `dark; G[2][3][1] <= `dark; G[3][3][1] <= `dark; G[4][3][1] <= `dark; G[5][3][1] <= `dark; G[6][3][1] <= `dark; G[7][3][1] <= `dark;
        G[0][3][0] <= `dark; G[1][3][0] <= `dark; G[2][3][0] <= `dark; G[3][3][0] <= `dark; G[4][3][0] <= `dark; G[5][3][0] <= `dark; G[6][3][0] <= `dark; G[7][3][0] <= `dark;

        //y0
        G[mode1x[0][0][3]][mode1y[0][0][3]][mode1z[0][0][3]] <= mode1GRB;
        G[mode1x[0][0][2]][mode1y[0][0][2]][mode1z[0][0][2]] <= mode1GRB;
        G[mode1x[0][0][1]][mode1y[0][0][1]][mode1z[0][0][1]] <= mode1GRB;
        G[mode1x[0][0][0]][mode1y[0][0][0]][mode1z[0][0][0]] <= mode1GRB;
        //y1
        G[mode1x[0][1][3]][mode1y[0][1][3]][mode1z[0][1][3]] <= mode1GRB;
        G[mode1x[0][1][2]][mode1y[0][1][2]][mode1z[0][1][2]] <= mode1GRB;
        G[mode1x[0][1][1]][mode1y[0][1][1]][mode1z[0][1][1]] <= mode1GRB;
        G[mode1x[0][1][0]][mode1y[0][1][0]][mode1z[0][1][0]] <= mode1GRB;
        //y2
        G[mode1x[0][2][3]][mode1y[0][2][3]][mode1z[0][2][3]] <= mode1GRB;
        G[mode1x[0][2][2]][mode1y[0][2][2]][mode1z[0][2][2]] <= mode1GRB; 
        G[mode1x[0][2][1]][mode1y[0][2][1]][mode1z[0][2][1]] <= mode1GRB;
        G[mode1x[0][2][0]][mode1y[0][2][0]][mode1z[0][2][0]] <= mode1GRB;
        //y3
        G[mode1x[0][3][3]][mode1y[0][3][3]][mode1z[0][3][3]] <= mode1GRB;
        G[mode1x[0][3][2]][mode1y[0][3][2]][mode1z[0][3][2]] <= mode1GRB;
        G[mode1x[0][3][1]][mode1y[0][3][1]][mode1z[0][3][1]] <= mode1GRB;
        G[mode1x[0][3][0]][mode1y[0][3][0]][mode1z[0][3][0]] <= mode1GRB;
    end
    else if(mode==3'd2) begin //tree
        //z = 0
            G[3][1][0] <= mode1GRB; G[4][1][0] <= mode1GRB;
            G[3][2][0] <= mode1GRB; G[4][2][0] <= mode1GRB;       
        //z = 1
        if(mode2state<3'd1) begin
            G[3][1][1] <= `dark; G[4][1][1] <= `dark;
            G[3][2][1] <= `dark; G[4][2][1] <= `dark;
        end else begin    
            G[3][1][1] <= mode1GRB; G[4][1][1] <= mode1GRB;
            G[3][2][1] <= mode1GRB; G[4][2][1] <= mode1GRB;
        end 
        //z = 2
        if(mode2state<3'd2) begin
            G[3][1][2] <= `dark; G[4][1][2] <= `dark;
            G[3][2][2] <= `dark; G[4][2][2] <= `dark;
        end else begin    
            G[3][1][2] <= mode1GRB; G[4][1][2] <= mode1GRB;
            G[3][2][2] <= mode1GRB; G[4][2][2] <= mode1GRB;
        end 
        //z = 3
        if(mode2state<3'd3) begin
            G[3][1][3] <= `dark; G[4][1][3] <= `dark;
            G[3][2][3] <= `dark; G[4][2][3] <= `dark;
        end else begin    
            G[3][1][3] <= mode1GRB; G[4][1][3] <= mode1GRB;
            G[3][2][3] <= mode1GRB; G[4][2][3] <= mode1GRB;
        end 
        //z = 3 one
        if(mode2state2==2'd1) begin
            G[2][0][3] <= mode1GRB; G[3][0][3] <= mode1GRB; G[4][0][3] <= mode1GRB; G[5][0][3] <= mode1GRB;
            G[2][1][3] <= mode1GRB;                                                 G[5][1][3] <= mode1GRB;
            G[2][2][3] <= mode1GRB;                                                 G[5][2][3] <= mode1GRB;
            G[2][3][3] <= mode1GRB; G[3][3][3] <= mode1GRB; G[4][3][3] <= mode1GRB; G[5][3][3] <= mode1GRB;
        end else begin
            G[2][0][3] <= `dark; G[3][0][3] <= `dark; G[4][0][3] <= `dark; G[5][0][3] <= `dark;
            G[2][1][3] <= `dark;                                           G[5][1][3] <= `dark;
            G[2][2][3] <= `dark;                                           G[5][2][3] <= `dark;
            G[2][3][3] <= `dark; G[3][3][3] <= `dark; G[4][3][3] <= `dark; G[5][3][3] <= `dark;
        end
        //z = 3 two
        if(mode2state2==2'd2) begin
            G[1][0][3] <= mode1GRB;                                                 G[6][0][3] <= mode1GRB;
            G[1][1][3] <= mode1GRB;                                                 G[6][1][3] <= mode1GRB;
            G[1][2][3] <= mode1GRB;                                                 G[6][2][3] <= mode1GRB;
            G[1][3][3] <= mode1GRB;                                                 G[6][3][3] <= mode1GRB;
        end else begin
            G[1][0][3] <= `dark;                                                 G[6][0][3] <= `dark;
            G[1][1][3] <= `dark;                                                 G[6][1][3] <= `dark;
            G[1][2][3] <= `dark;                                                 G[6][2][3] <= `dark;
            G[1][3][3] <= `dark;                                                 G[6][3][3] <= `dark;
        end
        //z = 3 thr
        if(mode2state2==2'd3) begin
            G[0][0][3] <= mode1GRB;                                                 G[7][0][3] <= mode1GRB;
            G[0][1][3] <= mode1GRB;                                                 G[7][1][3] <= mode1GRB;
            G[0][2][3] <= mode1GRB;                                                 G[7][2][3] <= mode1GRB;
            G[0][3][3] <= mode1GRB;                                                 G[7][3][3] <= mode1GRB;
        end else begin
            G[0][0][3] <= `dark;                                                 G[7][0][3] <= `dark;
            G[0][1][3] <= `dark;                                                 G[7][1][3] <= `dark;
            G[0][2][3] <= `dark;                                                 G[7][2][3] <= `dark;
            G[0][3][3] <= `dark;                                                 G[7][3][3] <= `dark;
        end
        //z = 2 thr
        if(mode2state2==2'd0 && mode2state==3'd3) begin
            case(rand)
                5'd1: G[0][3][2] <= mode2GRB; 5'd5: G[1][3][2] <= mode2GRB; 5'd9: G[2][3][2] <= mode2GRB; 5'd11: G[5][3][2] <= mode2GRB; 5'd13: G[6][3][2] <= mode2GRB; 5'd17: G[7][3][2] <= mode2GRB;
                5'd2: G[0][2][2] <= mode2GRB; 5'd6: G[1][2][2] <= mode2GRB;                                                              5'd14: G[6][2][2] <= mode2GRB; 5'd18: G[7][2][2] <= mode2GRB;
                5'd3: G[0][1][2] <= mode2GRB; 5'd7: G[1][1][2] <= mode2GRB;                                                              5'd15: G[6][1][2] <= mode2GRB; 5'd19: G[7][1][2] <= mode2GRB;
                5'd4: G[0][0][2] <= mode2GRB; 5'd8: G[1][0][2] <= mode2GRB; 5'd10: G[2][0][2] <= mode2GRB; 5'd12: G[5][0][2] <= mode2GRB; 5'd16: G[6][0][2] <= mode2GRB; 5'd20: G[7][0][2] <= mode2GRB;
                default: G[0][0][2] <= mode2GRB;
            endcase
        end
        if(time_05) begin
            //z = 2
            G[0][3][2] <= `dark; G[1][3][2] <= `dark; G[2][3][2] <= `dark;  G[5][3][2] <= `dark; G[6][3][2] <= `dark; G[7][3][2] <= `dark;
            G[0][2][2] <= `dark; G[1][2][2] <= `dark;                                            G[6][2][2] <= `dark; G[7][2][2] <= `dark;
            G[0][1][2] <= `dark; G[1][1][2] <= `dark;                                            G[6][1][2] <= `dark; G[7][1][2] <= `dark;
            G[0][0][2] <= `dark; G[1][0][2] <= `dark; G[2][0][2] <= `dark;  G[5][0][2] <= `dark; G[6][0][2] <= `dark; G[7][0][2] <= `dark;
            //z = 1
            G[0][3][1] <= G[0][3][2]; G[1][3][1] <= G[1][3][2]; G[2][3][1] <= G[2][3][2]; G[5][3][1] <= G[5][3][2]; G[6][3][1] <= G[6][3][2]; G[7][3][1] <= G[7][3][2];
            G[0][2][1] <= G[0][2][2]; G[1][2][1] <= G[1][2][2];                                                     G[6][2][1] <= G[6][2][2]; G[7][2][1] <= G[7][2][2];
            G[0][1][1] <= G[0][1][2]; G[1][1][1] <= G[1][1][2];                                                     G[6][1][1] <= G[6][1][2]; G[7][1][1] <= G[7][1][2];
            G[0][0][1] <= G[0][0][2]; G[1][0][1] <= G[1][0][2]; G[2][0][1] <= G[2][0][2]; G[5][0][1] <= G[5][0][2]; G[6][0][1] <= G[6][0][2]; G[7][0][1] <= G[7][0][2];
            //z = 0
            G[0][3][0] <= G[0][3][1]; G[1][3][0] <= G[1][3][1]; G[2][3][0] <= G[2][3][1]; G[5][3][0] <= G[5][3][1]; G[6][3][0] <= G[6][3][1]; G[7][3][0] <= G[7][3][1];
            G[0][2][0] <= G[0][2][1]; G[1][2][0] <= G[1][2][1];                                                     G[6][2][0] <= G[6][2][1]; G[7][2][0] <= G[7][2][1];
            G[0][1][0] <= G[0][1][1]; G[1][1][0] <= G[1][1][1];                                                     G[6][1][0] <= G[6][1][1]; G[7][1][0] <= G[7][1][1];
            G[0][0][0] <= G[0][0][1]; G[1][0][0] <= G[1][0][1]; G[2][0][0] <= G[2][0][1]; G[5][0][0] <= G[5][0][1]; G[6][0][0] <= G[6][0][1]; G[7][0][0] <= G[7][0][1];
        end
        //z = 2
                             G[3][3][2] <= `dark; G[4][3][2] <= `dark;
        G[2][2][2] <= `dark;                                           G[5][2][2] <= `dark;
        G[2][1][2] <= `dark;                                           G[5][1][2] <= `dark;
                             G[3][0][2] <= `dark; G[4][0][2] <= `dark;
        //z = 1
                             G[3][3][1] <= `dark; G[4][3][1] <= `dark;
        G[2][2][1] <= `dark;                                           G[5][2][1] <= `dark; 
        G[2][1][1] <= `dark;                                           G[5][1][1] <= `dark; 
                             G[3][0][1] <= `dark; G[4][0][1] <= `dark;
        // z = 0
                             G[3][3][0] <= `dark; G[4][3][0] <= `dark;
        G[2][2][0] <= `dark;                                           G[5][2][0] <= `dark; 
        G[2][1][0] <= `dark;                                           G[5][1][0] <= `dark; 
                             G[3][0][0] <= `dark; G[4][0][0] <= `dark;
    end
    else if(mode==3'd3) begin //shift
        case(mode3state)
        5'd0: begin //ALL dark
            G[0][0][3] <= `dark; G[1][0][3] <= `dark; G[2][0][3] <= `dark; G[3][0][3] <= `dark; G[4][0][3] <= `dark; G[5][0][3] <= `dark; G[6][0][3] <= `dark; G[7][0][3] <= `dark;
            G[0][0][2] <= `dark; G[1][0][2] <= `dark; G[2][0][2] <= `dark; G[3][0][2] <= `dark; G[4][0][2] <= `dark; G[5][0][2] <= `dark; G[6][0][2] <= `dark; G[7][0][2] <= `dark;
            G[0][0][1] <= `dark; G[1][0][1] <= `dark; G[2][0][1] <= `dark; G[3][0][1] <= `dark; G[4][0][1] <= `dark; G[5][0][1] <= `dark; G[6][0][1] <= `dark; G[7][0][1] <= `dark;
            G[0][0][0] <= `dark; G[1][0][0] <= `dark; G[2][0][0] <= `dark; G[3][0][0] <= `dark; G[4][0][0] <= `dark; G[5][0][0] <= `dark; G[6][0][0] <= `dark; G[7][0][0] <= `dark;
            G[0][1][3] <= `dark; G[1][1][3] <= `dark; G[2][1][3] <= `dark; G[3][1][3] <= `dark; G[4][1][3] <= `dark; G[5][1][3] <= `dark; G[6][1][3] <= `dark; G[7][1][3] <= `dark;
            G[0][1][2] <= `dark; G[1][1][2] <= `dark; G[2][1][2] <= `dark; G[3][1][2] <= `dark; G[4][1][2] <= `dark; G[5][1][2] <= `dark; G[6][1][2] <= `dark; G[7][1][2] <= `dark;
            G[0][1][1] <= `dark; G[1][1][1] <= `dark; G[2][1][1] <= `dark; G[3][1][1] <= `dark; G[4][1][1] <= `dark; G[5][1][1] <= `dark; G[6][1][1] <= `dark; G[7][1][1] <= `dark;
            G[0][1][0] <= `dark; G[1][1][0] <= `dark; G[2][1][0] <= `dark; G[3][1][0] <= `dark; G[4][1][0] <= `dark; G[5][1][0] <= `dark; G[6][1][0] <= `dark; G[7][1][0] <= `dark;
            G[0][2][3] <= `dark; G[1][2][3] <= `dark; G[2][2][3] <= `dark; G[3][2][3] <= `dark; G[4][2][3] <= `dark; G[5][2][3] <= `dark; G[6][2][3] <= `dark; G[7][2][3] <= `dark;
            G[0][2][2] <= `dark; G[1][2][2] <= `dark; G[2][2][2] <= `dark; G[3][2][2] <= `dark; G[4][2][2] <= `dark; G[5][2][2] <= `dark; G[6][2][2] <= `dark; G[7][2][2] <= `dark;
            G[0][2][1] <= `dark; G[1][2][1] <= `dark; G[2][2][1] <= `dark; G[3][2][1] <= `dark; G[4][2][1] <= `dark; G[5][2][1] <= `dark; G[6][2][1] <= `dark; G[7][2][1] <= `dark;
            G[0][2][0] <= `dark; G[1][2][0] <= `dark; G[2][2][0] <= `dark; G[3][2][0] <= `dark; G[4][2][0] <= `dark; G[5][2][0] <= `dark; G[6][2][0] <= `dark; G[7][2][0] <= `dark;
            G[0][3][3] <= `dark; G[1][3][3] <= `dark; G[2][3][3] <= `dark; G[3][3][3] <= `dark; G[4][3][3] <= `dark; G[5][3][3] <= `dark; G[6][3][3] <= `dark; G[7][3][3] <= `dark;
            G[0][3][2] <= `dark; G[1][3][2] <= `dark; G[2][3][2] <= `dark; G[3][3][2] <= `dark; G[4][3][2] <= `dark; G[5][3][2] <= `dark; G[6][3][2] <= `dark; G[7][3][2] <= `dark;
            G[0][3][1] <= `dark; G[1][3][1] <= `dark; G[2][3][1] <= `dark; G[3][3][1] <= `dark; G[4][3][1] <= `dark; G[5][3][1] <= `dark; G[6][3][1] <= `dark; G[7][3][1] <= `dark;
            G[0][3][0] <= `dark; G[1][3][0] <= `dark; G[2][3][0] <= `dark; G[3][3][0] <= `dark; G[4][3][0] <= `dark; G[5][3][0] <= `dark; G[6][3][0] <= `dark; G[7][3][0] <= `dark;
        end
        5'd1: begin //x0
            G[0][0][3] <= mode1GRB; G[1][0][3] <= `dark; G[2][0][3] <= `dark; G[3][0][3] <= `dark; G[4][0][3] <= `dark; G[5][0][3] <= `dark; G[6][0][3] <= `dark; G[7][0][3] <= `dark;
            G[0][0][2] <= mode1GRB; G[1][0][2] <= `dark; G[2][0][2] <= `dark; G[3][0][2] <= `dark; G[4][0][2] <= `dark; G[5][0][2] <= `dark; G[6][0][2] <= `dark; G[7][0][2] <= `dark;
            G[0][0][1] <= mode1GRB; G[1][0][1] <= `dark; G[2][0][1] <= `dark; G[3][0][1] <= `dark; G[4][0][1] <= `dark; G[5][0][1] <= `dark; G[6][0][1] <= `dark; G[7][0][1] <= `dark;
            G[0][0][0] <= mode1GRB; G[1][0][0] <= `dark; G[2][0][0] <= `dark; G[3][0][0] <= `dark; G[4][0][0] <= `dark; G[5][0][0] <= `dark; G[6][0][0] <= `dark; G[7][0][0] <= `dark;
            G[0][1][3] <= mode1GRB; G[1][1][3] <= `dark; G[2][1][3] <= `dark; G[3][1][3] <= `dark; G[4][1][3] <= `dark; G[5][1][3] <= `dark; G[6][1][3] <= `dark; G[7][1][3] <= `dark;
            G[0][1][2] <= mode1GRB; G[1][1][2] <= `dark; G[2][1][2] <= `dark; G[3][1][2] <= `dark; G[4][1][2] <= `dark; G[5][1][2] <= `dark; G[6][1][2] <= `dark; G[7][1][2] <= `dark;
            G[0][1][1] <= mode1GRB; G[1][1][1] <= `dark; G[2][1][1] <= `dark; G[3][1][1] <= `dark; G[4][1][1] <= `dark; G[5][1][1] <= `dark; G[6][1][1] <= `dark; G[7][1][1] <= `dark;
            G[0][1][0] <= mode1GRB; G[1][1][0] <= `dark; G[2][1][0] <= `dark; G[3][1][0] <= `dark; G[4][1][0] <= `dark; G[5][1][0] <= `dark; G[6][1][0] <= `dark; G[7][1][0] <= `dark;
            G[0][2][3] <= mode1GRB; G[1][2][3] <= `dark; G[2][2][3] <= `dark; G[3][2][3] <= `dark; G[4][2][3] <= `dark; G[5][2][3] <= `dark; G[6][2][3] <= `dark; G[7][2][3] <= `dark;
            G[0][2][2] <= mode1GRB; G[1][2][2] <= `dark; G[2][2][2] <= `dark; G[3][2][2] <= `dark; G[4][2][2] <= `dark; G[5][2][2] <= `dark; G[6][2][2] <= `dark; G[7][2][2] <= `dark;
            G[0][2][1] <= mode1GRB; G[1][2][1] <= `dark; G[2][2][1] <= `dark; G[3][2][1] <= `dark; G[4][2][1] <= `dark; G[5][2][1] <= `dark; G[6][2][1] <= `dark; G[7][2][1] <= `dark;
            G[0][2][0] <= mode1GRB; G[1][2][0] <= `dark; G[2][2][0] <= `dark; G[3][2][0] <= `dark; G[4][2][0] <= `dark; G[5][2][0] <= `dark; G[6][2][0] <= `dark; G[7][2][0] <= `dark;
            G[0][3][3] <= mode1GRB; G[1][3][3] <= `dark; G[2][3][3] <= `dark; G[3][3][3] <= `dark; G[4][3][3] <= `dark; G[5][3][3] <= `dark; G[6][3][3] <= `dark; G[7][3][3] <= `dark;
            G[0][3][2] <= mode1GRB; G[1][3][2] <= `dark; G[2][3][2] <= `dark; G[3][3][2] <= `dark; G[4][3][2] <= `dark; G[5][3][2] <= `dark; G[6][3][2] <= `dark; G[7][3][2] <= `dark;
            G[0][3][1] <= mode1GRB; G[1][3][1] <= `dark; G[2][3][1] <= `dark; G[3][3][1] <= `dark; G[4][3][1] <= `dark; G[5][3][1] <= `dark; G[6][3][1] <= `dark; G[7][3][1] <= `dark;
            G[0][3][0] <= mode1GRB; G[1][3][0] <= `dark; G[2][3][0] <= `dark; G[3][3][0] <= `dark; G[4][3][0] <= `dark; G[5][3][0] <= `dark; G[6][3][0] <= `dark; G[7][3][0] <= `dark;
        end
        5'd2: begin //x1
            G[0][0][3] <= `dark; G[1][0][3] <= mode1GRB; G[2][0][3] <= `dark; G[3][0][3] <= `dark; G[4][0][3] <= `dark; G[5][0][3] <= `dark; G[6][0][3] <= `dark; G[7][0][3] <= `dark;
            G[0][0][2] <= `dark; G[1][0][2] <= mode1GRB; G[2][0][2] <= `dark; G[3][0][2] <= `dark; G[4][0][2] <= `dark; G[5][0][2] <= `dark; G[6][0][2] <= `dark; G[7][0][2] <= `dark;
            G[0][0][1] <= `dark; G[1][0][1] <= mode1GRB; G[2][0][1] <= `dark; G[3][0][1] <= `dark; G[4][0][1] <= `dark; G[5][0][1] <= `dark; G[6][0][1] <= `dark; G[7][0][1] <= `dark;
            G[0][0][0] <= `dark; G[1][0][0] <= mode1GRB; G[2][0][0] <= `dark; G[3][0][0] <= `dark; G[4][0][0] <= `dark; G[5][0][0] <= `dark; G[6][0][0] <= `dark; G[7][0][0] <= `dark;
            G[0][1][3] <= `dark; G[1][1][3] <= mode1GRB; G[2][1][3] <= `dark; G[3][1][3] <= `dark; G[4][1][3] <= `dark; G[5][1][3] <= `dark; G[6][1][3] <= `dark; G[7][1][3] <= `dark;
            G[0][1][2] <= `dark; G[1][1][2] <= mode1GRB; G[2][1][2] <= `dark; G[3][1][2] <= `dark; G[4][1][2] <= `dark; G[5][1][2] <= `dark; G[6][1][2] <= `dark; G[7][1][2] <= `dark;
            G[0][1][1] <= `dark; G[1][1][1] <= mode1GRB; G[2][1][1] <= `dark; G[3][1][1] <= `dark; G[4][1][1] <= `dark; G[5][1][1] <= `dark; G[6][1][1] <= `dark; G[7][1][1] <= `dark;
            G[0][1][0] <= `dark; G[1][1][0] <= mode1GRB; G[2][1][0] <= `dark; G[3][1][0] <= `dark; G[4][1][0] <= `dark; G[5][1][0] <= `dark; G[6][1][0] <= `dark; G[7][1][0] <= `dark;
            G[0][2][3] <= `dark; G[1][2][3] <= mode1GRB; G[2][2][3] <= `dark; G[3][2][3] <= `dark; G[4][2][3] <= `dark; G[5][2][3] <= `dark; G[6][2][3] <= `dark; G[7][2][3] <= `dark;
            G[0][2][2] <= `dark; G[1][2][2] <= mode1GRB; G[2][2][2] <= `dark; G[3][2][2] <= `dark; G[4][2][2] <= `dark; G[5][2][2] <= `dark; G[6][2][2] <= `dark; G[7][2][2] <= `dark;
            G[0][2][1] <= `dark; G[1][2][1] <= mode1GRB; G[2][2][1] <= `dark; G[3][2][1] <= `dark; G[4][2][1] <= `dark; G[5][2][1] <= `dark; G[6][2][1] <= `dark; G[7][2][1] <= `dark;
            G[0][2][0] <= `dark; G[1][2][0] <= mode1GRB; G[2][2][0] <= `dark; G[3][2][0] <= `dark; G[4][2][0] <= `dark; G[5][2][0] <= `dark; G[6][2][0] <= `dark; G[7][2][0] <= `dark;
            G[0][3][3] <= `dark; G[1][3][3] <= mode1GRB; G[2][3][3] <= `dark; G[3][3][3] <= `dark; G[4][3][3] <= `dark; G[5][3][3] <= `dark; G[6][3][3] <= `dark; G[7][3][3] <= `dark;
            G[0][3][2] <= `dark; G[1][3][2] <= mode1GRB; G[2][3][2] <= `dark; G[3][3][2] <= `dark; G[4][3][2] <= `dark; G[5][3][2] <= `dark; G[6][3][2] <= `dark; G[7][3][2] <= `dark;
            G[0][3][1] <= `dark; G[1][3][1] <= mode1GRB; G[2][3][1] <= `dark; G[3][3][1] <= `dark; G[4][3][1] <= `dark; G[5][3][1] <= `dark; G[6][3][1] <= `dark; G[7][3][1] <= `dark;
            G[0][3][0] <= `dark; G[1][3][0] <= mode1GRB; G[2][3][0] <= `dark; G[3][3][0] <= `dark; G[4][3][0] <= `dark; G[5][3][0] <= `dark; G[6][3][0] <= `dark; G[7][3][0] <= `dark;
        end
        5'd3: begin //x2
            G[0][0][3] <= `dark; G[1][0][3] <= `dark; G[2][0][3] <= mode1GRB; G[3][0][3] <= `dark; G[4][0][3] <= `dark; G[5][0][3] <= `dark; G[6][0][3] <= `dark; G[7][0][3] <= `dark;
            G[0][0][2] <= `dark; G[1][0][2] <= `dark; G[2][0][2] <= mode1GRB; G[3][0][2] <= `dark; G[4][0][2] <= `dark; G[5][0][2] <= `dark; G[6][0][2] <= `dark; G[7][0][2] <= `dark;
            G[0][0][1] <= `dark; G[1][0][1] <= `dark; G[2][0][1] <= mode1GRB; G[3][0][1] <= `dark; G[4][0][1] <= `dark; G[5][0][1] <= `dark; G[6][0][1] <= `dark; G[7][0][1] <= `dark;
            G[0][0][0] <= `dark; G[1][0][0] <= `dark; G[2][0][0] <= mode1GRB; G[3][0][0] <= `dark; G[4][0][0] <= `dark; G[5][0][0] <= `dark; G[6][0][0] <= `dark; G[7][0][0] <= `dark;
            G[0][1][3] <= `dark; G[1][1][3] <= `dark; G[2][1][3] <= mode1GRB; G[3][1][3] <= `dark; G[4][1][3] <= `dark; G[5][1][3] <= `dark; G[6][1][3] <= `dark; G[7][1][3] <= `dark;
            G[0][1][2] <= `dark; G[1][1][2] <= `dark; G[2][1][2] <= mode1GRB; G[3][1][2] <= `dark; G[4][1][2] <= `dark; G[5][1][2] <= `dark; G[6][1][2] <= `dark; G[7][1][2] <= `dark;
            G[0][1][1] <= `dark; G[1][1][1] <= `dark; G[2][1][1] <= mode1GRB; G[3][1][1] <= `dark; G[4][1][1] <= `dark; G[5][1][1] <= `dark; G[6][1][1] <= `dark; G[7][1][1] <= `dark;
            G[0][1][0] <= `dark; G[1][1][0] <= `dark; G[2][1][0] <= mode1GRB; G[3][1][0] <= `dark; G[4][1][0] <= `dark; G[5][1][0] <= `dark; G[6][1][0] <= `dark; G[7][1][0] <= `dark;
            G[0][2][3] <= `dark; G[1][2][3] <= `dark; G[2][2][3] <= mode1GRB; G[3][2][3] <= `dark; G[4][2][3] <= `dark; G[5][2][3] <= `dark; G[6][2][3] <= `dark; G[7][2][3] <= `dark;
            G[0][2][2] <= `dark; G[1][2][2] <= `dark; G[2][2][2] <= mode1GRB; G[3][2][2] <= `dark; G[4][2][2] <= `dark; G[5][2][2] <= `dark; G[6][2][2] <= `dark; G[7][2][2] <= `dark;
            G[0][2][1] <= `dark; G[1][2][1] <= `dark; G[2][2][1] <= mode1GRB; G[3][2][1] <= `dark; G[4][2][1] <= `dark; G[5][2][1] <= `dark; G[6][2][1] <= `dark; G[7][2][1] <= `dark;
            G[0][2][0] <= `dark; G[1][2][0] <= `dark; G[2][2][0] <= mode1GRB; G[3][2][0] <= `dark; G[4][2][0] <= `dark; G[5][2][0] <= `dark; G[6][2][0] <= `dark; G[7][2][0] <= `dark;
            G[0][3][3] <= `dark; G[1][3][3] <= `dark; G[2][3][3] <= mode1GRB; G[3][3][3] <= `dark; G[4][3][3] <= `dark; G[5][3][3] <= `dark; G[6][3][3] <= `dark; G[7][3][3] <= `dark;
            G[0][3][2] <= `dark; G[1][3][2] <= `dark; G[2][3][2] <= mode1GRB; G[3][3][2] <= `dark; G[4][3][2] <= `dark; G[5][3][2] <= `dark; G[6][3][2] <= `dark; G[7][3][2] <= `dark;
            G[0][3][1] <= `dark; G[1][3][1] <= `dark; G[2][3][1] <= mode1GRB; G[3][3][1] <= `dark; G[4][3][1] <= `dark; G[5][3][1] <= `dark; G[6][3][1] <= `dark; G[7][3][1] <= `dark;
            G[0][3][0] <= `dark; G[1][3][0] <= `dark; G[2][3][0] <= mode1GRB; G[3][3][0] <= `dark; G[4][3][0] <= `dark; G[5][3][0] <= `dark; G[6][3][0] <= `dark; G[7][3][0] <= `dark;
        end
        5'd4: begin //x3
            G[0][0][3] <= `dark; G[1][0][3] <= `dark; G[2][0][3] <= `dark; G[3][0][3] <= mode1GRB; G[4][0][3] <= `dark; G[5][0][3] <= `dark; G[6][0][3] <= `dark; G[7][0][3] <= `dark;
            G[0][0][2] <= `dark; G[1][0][2] <= `dark; G[2][0][2] <= `dark; G[3][0][2] <= mode1GRB; G[4][0][2] <= `dark; G[5][0][2] <= `dark; G[6][0][2] <= `dark; G[7][0][2] <= `dark;
            G[0][0][1] <= `dark; G[1][0][1] <= `dark; G[2][0][1] <= `dark; G[3][0][1] <= mode1GRB; G[4][0][1] <= `dark; G[5][0][1] <= `dark; G[6][0][1] <= `dark; G[7][0][1] <= `dark;
            G[0][0][0] <= `dark; G[1][0][0] <= `dark; G[2][0][0] <= `dark; G[3][0][0] <= mode1GRB; G[4][0][0] <= `dark; G[5][0][0] <= `dark; G[6][0][0] <= `dark; G[7][0][0] <= `dark;
            G[0][1][3] <= `dark; G[1][1][3] <= `dark; G[2][1][3] <= `dark; G[3][1][3] <= mode1GRB; G[4][1][3] <= `dark; G[5][1][3] <= `dark; G[6][1][3] <= `dark; G[7][1][3] <= `dark;
            G[0][1][2] <= `dark; G[1][1][2] <= `dark; G[2][1][2] <= `dark; G[3][1][2] <= mode1GRB; G[4][1][2] <= `dark; G[5][1][2] <= `dark; G[6][1][2] <= `dark; G[7][1][2] <= `dark;
            G[0][1][1] <= `dark; G[1][1][1] <= `dark; G[2][1][1] <= `dark; G[3][1][1] <= mode1GRB; G[4][1][1] <= `dark; G[5][1][1] <= `dark; G[6][1][1] <= `dark; G[7][1][1] <= `dark;
            G[0][1][0] <= `dark; G[1][1][0] <= `dark; G[2][1][0] <= `dark; G[3][1][0] <= mode1GRB; G[4][1][0] <= `dark; G[5][1][0] <= `dark; G[6][1][0] <= `dark; G[7][1][0] <= `dark;
            G[0][2][3] <= `dark; G[1][2][3] <= `dark; G[2][2][3] <= `dark; G[3][2][3] <= mode1GRB; G[4][2][3] <= `dark; G[5][2][3] <= `dark; G[6][2][3] <= `dark; G[7][2][3] <= `dark;
            G[0][2][2] <= `dark; G[1][2][2] <= `dark; G[2][2][2] <= `dark; G[3][2][2] <= mode1GRB; G[4][2][2] <= `dark; G[5][2][2] <= `dark; G[6][2][2] <= `dark; G[7][2][2] <= `dark;
            G[0][2][1] <= `dark; G[1][2][1] <= `dark; G[2][2][1] <= `dark; G[3][2][1] <= mode1GRB; G[4][2][1] <= `dark; G[5][2][1] <= `dark; G[6][2][1] <= `dark; G[7][2][1] <= `dark;
            G[0][2][0] <= `dark; G[1][2][0] <= `dark; G[2][2][0] <= `dark; G[3][2][0] <= mode1GRB; G[4][2][0] <= `dark; G[5][2][0] <= `dark; G[6][2][0] <= `dark; G[7][2][0] <= `dark;
            G[0][3][3] <= `dark; G[1][3][3] <= `dark; G[2][3][3] <= `dark; G[3][3][3] <= mode1GRB; G[4][3][3] <= `dark; G[5][3][3] <= `dark; G[6][3][3] <= `dark; G[7][3][3] <= `dark;
            G[0][3][2] <= `dark; G[1][3][2] <= `dark; G[2][3][2] <= `dark; G[3][3][2] <= mode1GRB; G[4][3][2] <= `dark; G[5][3][2] <= `dark; G[6][3][2] <= `dark; G[7][3][2] <= `dark;
            G[0][3][1] <= `dark; G[1][3][1] <= `dark; G[2][3][1] <= `dark; G[3][3][1] <= mode1GRB; G[4][3][1] <= `dark; G[5][3][1] <= `dark; G[6][3][1] <= `dark; G[7][3][1] <= `dark;
            G[0][3][0] <= `dark; G[1][3][0] <= `dark; G[2][3][0] <= `dark; G[3][3][0] <= mode1GRB; G[4][3][0] <= `dark; G[5][3][0] <= `dark; G[6][3][0] <= `dark; G[7][3][0] <= `dark;
        end
        5'd5: begin //x4
            G[0][0][3] <= `dark; G[1][0][3] <= `dark; G[2][0][3] <= `dark; G[3][0][3] <= `dark; G[4][0][3] <= mode1GRB; G[5][0][3] <= `dark; G[6][0][3] <= `dark; G[7][0][3] <= `dark;
            G[0][0][2] <= `dark; G[1][0][2] <= `dark; G[2][0][2] <= `dark; G[3][0][2] <= `dark; G[4][0][2] <= mode1GRB; G[5][0][2] <= `dark; G[6][0][2] <= `dark; G[7][0][2] <= `dark;
            G[0][0][1] <= `dark; G[1][0][1] <= `dark; G[2][0][1] <= `dark; G[3][0][1] <= `dark; G[4][0][1] <= mode1GRB; G[5][0][1] <= `dark; G[6][0][1] <= `dark; G[7][0][1] <= `dark;
            G[0][0][0] <= `dark; G[1][0][0] <= `dark; G[2][0][0] <= `dark; G[3][0][0] <= `dark; G[4][0][0] <= mode1GRB; G[5][0][0] <= `dark; G[6][0][0] <= `dark; G[7][0][0] <= `dark;
            G[0][1][3] <= `dark; G[1][1][3] <= `dark; G[2][1][3] <= `dark; G[3][1][3] <= `dark; G[4][1][3] <= mode1GRB; G[5][1][3] <= `dark; G[6][1][3] <= `dark; G[7][1][3] <= `dark;
            G[0][1][2] <= `dark; G[1][1][2] <= `dark; G[2][1][2] <= `dark; G[3][1][2] <= `dark; G[4][1][2] <= mode1GRB; G[5][1][2] <= `dark; G[6][1][2] <= `dark; G[7][1][2] <= `dark;
            G[0][1][1] <= `dark; G[1][1][1] <= `dark; G[2][1][1] <= `dark; G[3][1][1] <= `dark; G[4][1][1] <= mode1GRB; G[5][1][1] <= `dark; G[6][1][1] <= `dark; G[7][1][1] <= `dark;
            G[0][1][0] <= `dark; G[1][1][0] <= `dark; G[2][1][0] <= `dark; G[3][1][0] <= `dark; G[4][1][0] <= mode1GRB; G[5][1][0] <= `dark; G[6][1][0] <= `dark; G[7][1][0] <= `dark;
            G[0][2][3] <= `dark; G[1][2][3] <= `dark; G[2][2][3] <= `dark; G[3][2][3] <= `dark; G[4][2][3] <= mode1GRB; G[5][2][3] <= `dark; G[6][2][3] <= `dark; G[7][2][3] <= `dark;
            G[0][2][2] <= `dark; G[1][2][2] <= `dark; G[2][2][2] <= `dark; G[3][2][2] <= `dark; G[4][2][2] <= mode1GRB; G[5][2][2] <= `dark; G[6][2][2] <= `dark; G[7][2][2] <= `dark;
            G[0][2][1] <= `dark; G[1][2][1] <= `dark; G[2][2][1] <= `dark; G[3][2][1] <= `dark; G[4][2][1] <= mode1GRB; G[5][2][1] <= `dark; G[6][2][1] <= `dark; G[7][2][1] <= `dark;
            G[0][2][0] <= `dark; G[1][2][0] <= `dark; G[2][2][0] <= `dark; G[3][2][0] <= `dark; G[4][2][0] <= mode1GRB; G[5][2][0] <= `dark; G[6][2][0] <= `dark; G[7][2][0] <= `dark;
            G[0][3][3] <= `dark; G[1][3][3] <= `dark; G[2][3][3] <= `dark; G[3][3][3] <= `dark; G[4][3][3] <= mode1GRB; G[5][3][3] <= `dark; G[6][3][3] <= `dark; G[7][3][3] <= `dark;
            G[0][3][2] <= `dark; G[1][3][2] <= `dark; G[2][3][2] <= `dark; G[3][3][2] <= `dark; G[4][3][2] <= mode1GRB; G[5][3][2] <= `dark; G[6][3][2] <= `dark; G[7][3][2] <= `dark;
            G[0][3][1] <= `dark; G[1][3][1] <= `dark; G[2][3][1] <= `dark; G[3][3][1] <= `dark; G[4][3][1] <= mode1GRB; G[5][3][1] <= `dark; G[6][3][1] <= `dark; G[7][3][1] <= `dark;
            G[0][3][0] <= `dark; G[1][3][0] <= `dark; G[2][3][0] <= `dark; G[3][3][0] <= `dark; G[4][3][0] <= mode1GRB; G[5][3][0] <= `dark; G[6][3][0] <= `dark; G[7][3][0] <= `dark;
        end
        5'd6: begin //x5
            G[0][0][3] <= `dark; G[1][0][3] <= `dark; G[2][0][3] <= `dark; G[3][0][3] <= `dark; G[4][0][3] <= `dark; G[5][0][3] <= mode1GRB; G[6][0][3] <= `dark; G[7][0][3] <= `dark;
            G[0][0][2] <= `dark; G[1][0][2] <= `dark; G[2][0][2] <= `dark; G[3][0][2] <= `dark; G[4][0][2] <= `dark; G[5][0][2] <= mode1GRB; G[6][0][2] <= `dark; G[7][0][2] <= `dark;
            G[0][0][1] <= `dark; G[1][0][1] <= `dark; G[2][0][1] <= `dark; G[3][0][1] <= `dark; G[4][0][1] <= `dark; G[5][0][1] <= mode1GRB; G[6][0][1] <= `dark; G[7][0][1] <= `dark;
            G[0][0][0] <= `dark; G[1][0][0] <= `dark; G[2][0][0] <= `dark; G[3][0][0] <= `dark; G[4][0][0] <= `dark; G[5][0][0] <= mode1GRB; G[6][0][0] <= `dark; G[7][0][0] <= `dark;
            G[0][1][3] <= `dark; G[1][1][3] <= `dark; G[2][1][3] <= `dark; G[3][1][3] <= `dark; G[4][1][3] <= `dark; G[5][1][3] <= mode1GRB; G[6][1][3] <= `dark; G[7][1][3] <= `dark;
            G[0][1][2] <= `dark; G[1][1][2] <= `dark; G[2][1][2] <= `dark; G[3][1][2] <= `dark; G[4][1][2] <= `dark; G[5][1][2] <= mode1GRB; G[6][1][2] <= `dark; G[7][1][2] <= `dark;
            G[0][1][1] <= `dark; G[1][1][1] <= `dark; G[2][1][1] <= `dark; G[3][1][1] <= `dark; G[4][1][1] <= `dark; G[5][1][1] <= mode1GRB; G[6][1][1] <= `dark; G[7][1][1] <= `dark;
            G[0][1][0] <= `dark; G[1][1][0] <= `dark; G[2][1][0] <= `dark; G[3][1][0] <= `dark; G[4][1][0] <= `dark; G[5][1][0] <= mode1GRB; G[6][1][0] <= `dark; G[7][1][0] <= `dark;
            G[0][2][3] <= `dark; G[1][2][3] <= `dark; G[2][2][3] <= `dark; G[3][2][3] <= `dark; G[4][2][3] <= `dark; G[5][2][3] <= mode1GRB; G[6][2][3] <= `dark; G[7][2][3] <= `dark;
            G[0][2][2] <= `dark; G[1][2][2] <= `dark; G[2][2][2] <= `dark; G[3][2][2] <= `dark; G[4][2][2] <= `dark; G[5][2][2] <= mode1GRB; G[6][2][2] <= `dark; G[7][2][2] <= `dark;
            G[0][2][1] <= `dark; G[1][2][1] <= `dark; G[2][2][1] <= `dark; G[3][2][1] <= `dark; G[4][2][1] <= `dark; G[5][2][1] <= mode1GRB; G[6][2][1] <= `dark; G[7][2][1] <= `dark;
            G[0][2][0] <= `dark; G[1][2][0] <= `dark; G[2][2][0] <= `dark; G[3][2][0] <= `dark; G[4][2][0] <= `dark; G[5][2][0] <= mode1GRB; G[6][2][0] <= `dark; G[7][2][0] <= `dark;
            G[0][3][3] <= `dark; G[1][3][3] <= `dark; G[2][3][3] <= `dark; G[3][3][3] <= `dark; G[4][3][3] <= `dark; G[5][3][3] <= mode1GRB; G[6][3][3] <= `dark; G[7][3][3] <= `dark;
            G[0][3][2] <= `dark; G[1][3][2] <= `dark; G[2][3][2] <= `dark; G[3][3][2] <= `dark; G[4][3][2] <= `dark; G[5][3][2] <= mode1GRB; G[6][3][2] <= `dark; G[7][3][2] <= `dark;
            G[0][3][1] <= `dark; G[1][3][1] <= `dark; G[2][3][1] <= `dark; G[3][3][1] <= `dark; G[4][3][1] <= `dark; G[5][3][1] <= mode1GRB; G[6][3][1] <= `dark; G[7][3][1] <= `dark;
            G[0][3][0] <= `dark; G[1][3][0] <= `dark; G[2][3][0] <= `dark; G[3][3][0] <= `dark; G[4][3][0] <= `dark; G[5][3][0] <= mode1GRB; G[6][3][0] <= `dark; G[7][3][0] <= `dark;
        end
        5'd7: begin //x6
            G[0][0][3] <= `dark; G[1][0][3] <= `dark; G[2][0][3] <= `dark; G[3][0][3] <= `dark; G[4][0][3] <= `dark; G[5][0][3] <= `dark; G[6][0][3] <= mode1GRB; G[7][0][3] <= `dark;
            G[0][0][2] <= `dark; G[1][0][2] <= `dark; G[2][0][2] <= `dark; G[3][0][2] <= `dark; G[4][0][2] <= `dark; G[5][0][2] <= `dark; G[6][0][2] <= mode1GRB; G[7][0][2] <= `dark;
            G[0][0][1] <= `dark; G[1][0][1] <= `dark; G[2][0][1] <= `dark; G[3][0][1] <= `dark; G[4][0][1] <= `dark; G[5][0][1] <= `dark; G[6][0][1] <= mode1GRB; G[7][0][1] <= `dark;
            G[0][0][0] <= `dark; G[1][0][0] <= `dark; G[2][0][0] <= `dark; G[3][0][0] <= `dark; G[4][0][0] <= `dark; G[5][0][0] <= `dark; G[6][0][0] <= mode1GRB; G[7][0][0] <= `dark;
            G[0][1][3] <= `dark; G[1][1][3] <= `dark; G[2][1][3] <= `dark; G[3][1][3] <= `dark; G[4][1][3] <= `dark; G[5][1][3] <= `dark; G[6][1][3] <= mode1GRB; G[7][1][3] <= `dark;
            G[0][1][2] <= `dark; G[1][1][2] <= `dark; G[2][1][2] <= `dark; G[3][1][2] <= `dark; G[4][1][2] <= `dark; G[5][1][2] <= `dark; G[6][1][2] <= mode1GRB; G[7][1][2] <= `dark;
            G[0][1][1] <= `dark; G[1][1][1] <= `dark; G[2][1][1] <= `dark; G[3][1][1] <= `dark; G[4][1][1] <= `dark; G[5][1][1] <= `dark; G[6][1][1] <= mode1GRB; G[7][1][1] <= `dark;
            G[0][1][0] <= `dark; G[1][1][0] <= `dark; G[2][1][0] <= `dark; G[3][1][0] <= `dark; G[4][1][0] <= `dark; G[5][1][0] <= `dark; G[6][1][0] <= mode1GRB; G[7][1][0] <= `dark;
            G[0][2][3] <= `dark; G[1][2][3] <= `dark; G[2][2][3] <= `dark; G[3][2][3] <= `dark; G[4][2][3] <= `dark; G[5][2][3] <= `dark; G[6][2][3] <= mode1GRB; G[7][2][3] <= `dark;
            G[0][2][2] <= `dark; G[1][2][2] <= `dark; G[2][2][2] <= `dark; G[3][2][2] <= `dark; G[4][2][2] <= `dark; G[5][2][2] <= `dark; G[6][2][2] <= mode1GRB; G[7][2][2] <= `dark;
            G[0][2][1] <= `dark; G[1][2][1] <= `dark; G[2][2][1] <= `dark; G[3][2][1] <= `dark; G[4][2][1] <= `dark; G[5][2][1] <= `dark; G[6][2][1] <= mode1GRB; G[7][2][1] <= `dark;
            G[0][2][0] <= `dark; G[1][2][0] <= `dark; G[2][2][0] <= `dark; G[3][2][0] <= `dark; G[4][2][0] <= `dark; G[5][2][0] <= `dark; G[6][2][0] <= mode1GRB; G[7][2][0] <= `dark;
            G[0][3][3] <= `dark; G[1][3][3] <= `dark; G[2][3][3] <= `dark; G[3][3][3] <= `dark; G[4][3][3] <= `dark; G[5][3][3] <= `dark; G[6][3][3] <= mode1GRB; G[7][3][3] <= `dark;
            G[0][3][2] <= `dark; G[1][3][2] <= `dark; G[2][3][2] <= `dark; G[3][3][2] <= `dark; G[4][3][2] <= `dark; G[5][3][2] <= `dark; G[6][3][2] <= mode1GRB; G[7][3][2] <= `dark;
            G[0][3][1] <= `dark; G[1][3][1] <= `dark; G[2][3][1] <= `dark; G[3][3][1] <= `dark; G[4][3][1] <= `dark; G[5][3][1] <= `dark; G[6][3][1] <= mode1GRB; G[7][3][1] <= `dark;
            G[0][3][0] <= `dark; G[1][3][0] <= `dark; G[2][3][0] <= `dark; G[3][3][0] <= `dark; G[4][3][0] <= `dark; G[5][3][0] <= `dark; G[6][3][0] <= mode1GRB; G[7][3][0] <= `dark;
        end
        5'd8: begin //x7
            G[0][0][3] <= `dark; G[1][0][3] <= `dark; G[2][0][3] <= `dark; G[3][0][3] <= `dark; G[4][0][3] <= `dark; G[5][0][3] <= `dark; G[6][0][3] <= `dark; G[7][0][3] <= mode1GRB;
            G[0][0][2] <= `dark; G[1][0][2] <= `dark; G[2][0][2] <= `dark; G[3][0][2] <= `dark; G[4][0][2] <= `dark; G[5][0][2] <= `dark; G[6][0][2] <= `dark; G[7][0][2] <= mode1GRB;
            G[0][0][1] <= `dark; G[1][0][1] <= `dark; G[2][0][1] <= `dark; G[3][0][1] <= `dark; G[4][0][1] <= `dark; G[5][0][1] <= `dark; G[6][0][1] <= `dark; G[7][0][1] <= mode1GRB;
            G[0][0][0] <= `dark; G[1][0][0] <= `dark; G[2][0][0] <= `dark; G[3][0][0] <= `dark; G[4][0][0] <= `dark; G[5][0][0] <= `dark; G[6][0][0] <= `dark; G[7][0][0] <= mode1GRB;
            G[0][1][3] <= `dark; G[1][1][3] <= `dark; G[2][1][3] <= `dark; G[3][1][3] <= `dark; G[4][1][3] <= `dark; G[5][1][3] <= `dark; G[6][1][3] <= `dark; G[7][1][3] <= mode1GRB;
            G[0][1][2] <= `dark; G[1][1][2] <= `dark; G[2][1][2] <= `dark; G[3][1][2] <= `dark; G[4][1][2] <= `dark; G[5][1][2] <= `dark; G[6][1][2] <= `dark; G[7][1][2] <= mode1GRB;
            G[0][1][1] <= `dark; G[1][1][1] <= `dark; G[2][1][1] <= `dark; G[3][1][1] <= `dark; G[4][1][1] <= `dark; G[5][1][1] <= `dark; G[6][1][1] <= `dark; G[7][1][1] <= mode1GRB;
            G[0][1][0] <= `dark; G[1][1][0] <= `dark; G[2][1][0] <= `dark; G[3][1][0] <= `dark; G[4][1][0] <= `dark; G[5][1][0] <= `dark; G[6][1][0] <= `dark; G[7][1][0] <= mode1GRB;
            G[0][2][3] <= `dark; G[1][2][3] <= `dark; G[2][2][3] <= `dark; G[3][2][3] <= `dark; G[4][2][3] <= `dark; G[5][2][3] <= `dark; G[6][2][3] <= `dark; G[7][2][3] <= mode1GRB;
            G[0][2][2] <= `dark; G[1][2][2] <= `dark; G[2][2][2] <= `dark; G[3][2][2] <= `dark; G[4][2][2] <= `dark; G[5][2][2] <= `dark; G[6][2][2] <= `dark; G[7][2][2] <= mode1GRB;
            G[0][2][1] <= `dark; G[1][2][1] <= `dark; G[2][2][1] <= `dark; G[3][2][1] <= `dark; G[4][2][1] <= `dark; G[5][2][1] <= `dark; G[6][2][1] <= `dark; G[7][2][1] <= mode1GRB;
            G[0][2][0] <= `dark; G[1][2][0] <= `dark; G[2][2][0] <= `dark; G[3][2][0] <= `dark; G[4][2][0] <= `dark; G[5][2][0] <= `dark; G[6][2][0] <= `dark; G[7][2][0] <= mode1GRB;
            G[0][3][3] <= `dark; G[1][3][3] <= `dark; G[2][3][3] <= `dark; G[3][3][3] <= `dark; G[4][3][3] <= `dark; G[5][3][3] <= `dark; G[6][3][3] <= `dark; G[7][3][3] <= mode1GRB;
            G[0][3][2] <= `dark; G[1][3][2] <= `dark; G[2][3][2] <= `dark; G[3][3][2] <= `dark; G[4][3][2] <= `dark; G[5][3][2] <= `dark; G[6][3][2] <= `dark; G[7][3][2] <= mode1GRB;
            G[0][3][1] <= `dark; G[1][3][1] <= `dark; G[2][3][1] <= `dark; G[3][3][1] <= `dark; G[4][3][1] <= `dark; G[5][3][1] <= `dark; G[6][3][1] <= `dark; G[7][3][1] <= mode1GRB;
            G[0][3][0] <= `dark; G[1][3][0] <= `dark; G[2][3][0] <= `dark; G[3][3][0] <= `dark; G[4][3][0] <= `dark; G[5][3][0] <= `dark; G[6][3][0] <= `dark; G[7][3][0] <= mode1GRB;
        end
        5'd9: begin //y0
            G[0][0][3] <= mode1GRB; G[1][0][3] <= mode1GRB; G[2][0][3] <= mode1GRB; G[3][0][3] <= mode1GRB; G[4][0][3] <= mode1GRB; G[5][0][3] <= mode1GRB; G[6][0][3] <= mode1GRB; G[7][0][3] <= mode1GRB;
            G[0][0][2] <= mode1GRB; G[1][0][2] <= mode1GRB; G[2][0][2] <= mode1GRB; G[3][0][2] <= mode1GRB; G[4][0][2] <= mode1GRB; G[5][0][2] <= mode1GRB; G[6][0][2] <= mode1GRB; G[7][0][2] <= mode1GRB;
            G[0][0][1] <= mode1GRB; G[1][0][1] <= mode1GRB; G[2][0][1] <= mode1GRB; G[3][0][1] <= mode1GRB; G[4][0][1] <= mode1GRB; G[5][0][1] <= mode1GRB; G[6][0][1] <= mode1GRB; G[7][0][1] <= mode1GRB;
            G[0][0][0] <= mode1GRB; G[1][0][0] <= mode1GRB; G[2][0][0] <= mode1GRB; G[3][0][0] <= mode1GRB; G[4][0][0] <= mode1GRB; G[5][0][0] <= mode1GRB; G[6][0][0] <= mode1GRB; G[7][0][0] <= mode1GRB;
            G[0][1][3] <= `dark; G[1][1][3] <= `dark; G[2][1][3] <= `dark; G[3][1][3] <= `dark; G[4][1][3] <= `dark; G[5][1][3] <= `dark; G[6][1][3] <= `dark; G[7][1][3] <= `dark;
            G[0][1][2] <= `dark; G[1][1][2] <= `dark; G[2][1][2] <= `dark; G[3][1][2] <= `dark; G[4][1][2] <= `dark; G[5][1][2] <= `dark; G[6][1][2] <= `dark; G[7][1][2] <= `dark;
            G[0][1][1] <= `dark; G[1][1][1] <= `dark; G[2][1][1] <= `dark; G[3][1][1] <= `dark; G[4][1][1] <= `dark; G[5][1][1] <= `dark; G[6][1][1] <= `dark; G[7][1][1] <= `dark;
            G[0][1][0] <= `dark; G[1][1][0] <= `dark; G[2][1][0] <= `dark; G[3][1][0] <= `dark; G[4][1][0] <= `dark; G[5][1][0] <= `dark; G[6][1][0] <= `dark; G[7][1][0] <= `dark;
            G[0][2][3] <= `dark; G[1][2][3] <= `dark; G[2][2][3] <= `dark; G[3][2][3] <= `dark; G[4][2][3] <= `dark; G[5][2][3] <= `dark; G[6][2][3] <= `dark; G[7][2][3] <= `dark;
            G[0][2][2] <= `dark; G[1][2][2] <= `dark; G[2][2][2] <= `dark; G[3][2][2] <= `dark; G[4][2][2] <= `dark; G[5][2][2] <= `dark; G[6][2][2] <= `dark; G[7][2][2] <= `dark;
            G[0][2][1] <= `dark; G[1][2][1] <= `dark; G[2][2][1] <= `dark; G[3][2][1] <= `dark; G[4][2][1] <= `dark; G[5][2][1] <= `dark; G[6][2][1] <= `dark; G[7][2][1] <= `dark;
            G[0][2][0] <= `dark; G[1][2][0] <= `dark; G[2][2][0] <= `dark; G[3][2][0] <= `dark; G[4][2][0] <= `dark; G[5][2][0] <= `dark; G[6][2][0] <= `dark; G[7][2][0] <= `dark;
            G[0][3][3] <= `dark; G[1][3][3] <= `dark; G[2][3][3] <= `dark; G[3][3][3] <= `dark; G[4][3][3] <= `dark; G[5][3][3] <= `dark; G[6][3][3] <= `dark; G[7][3][3] <= `dark;
            G[0][3][2] <= `dark; G[1][3][2] <= `dark; G[2][3][2] <= `dark; G[3][3][2] <= `dark; G[4][3][2] <= `dark; G[5][3][2] <= `dark; G[6][3][2] <= `dark; G[7][3][2] <= `dark;
            G[0][3][1] <= `dark; G[1][3][1] <= `dark; G[2][3][1] <= `dark; G[3][3][1] <= `dark; G[4][3][1] <= `dark; G[5][3][1] <= `dark; G[6][3][1] <= `dark; G[7][3][1] <= `dark;
            G[0][3][0] <= `dark; G[1][3][0] <= `dark; G[2][3][0] <= `dark; G[3][3][0] <= `dark; G[4][3][0] <= `dark; G[5][3][0] <= `dark; G[6][3][0] <= `dark; G[7][3][0] <= `dark;
        end
        5'd10: begin //y1
            G[0][0][3] <= `dark; G[1][0][3] <= `dark; G[2][0][3] <= `dark; G[3][0][3] <= `dark; G[4][0][3] <= `dark; G[5][0][3] <= `dark; G[6][0][3] <= `dark; G[7][0][3] <= `dark;
            G[0][0][2] <= `dark; G[1][0][2] <= `dark; G[2][0][2] <= `dark; G[3][0][2] <= `dark; G[4][0][2] <= `dark; G[5][0][2] <= `dark; G[6][0][2] <= `dark; G[7][0][2] <= `dark;
            G[0][0][1] <= `dark; G[1][0][1] <= `dark; G[2][0][1] <= `dark; G[3][0][1] <= `dark; G[4][0][1] <= `dark; G[5][0][1] <= `dark; G[6][0][1] <= `dark; G[7][0][1] <= `dark;
            G[0][0][0] <= `dark; G[1][0][0] <= `dark; G[2][0][0] <= `dark; G[3][0][0] <= `dark; G[4][0][0] <= `dark; G[5][0][0] <= `dark; G[6][0][0] <= `dark; G[7][0][0] <= `dark;
            G[0][1][3] <= mode1GRB; G[1][1][3] <= mode1GRB; G[2][1][3] <= mode1GRB; G[3][1][3] <= mode1GRB; G[4][1][3] <= mode1GRB; G[5][1][3] <= mode1GRB; G[6][1][3] <= mode1GRB; G[7][1][3] <= mode1GRB;
            G[0][1][2] <= mode1GRB; G[1][1][2] <= mode1GRB; G[2][1][2] <= mode1GRB; G[3][1][2] <= mode1GRB; G[4][1][2] <= mode1GRB; G[5][1][2] <= mode1GRB; G[6][1][2] <= mode1GRB; G[7][1][2] <= mode1GRB;
            G[0][1][1] <= mode1GRB; G[1][1][1] <= mode1GRB; G[2][1][1] <= mode1GRB; G[3][1][1] <= mode1GRB; G[4][1][1] <= mode1GRB; G[5][1][1] <= mode1GRB; G[6][1][1] <= mode1GRB; G[7][1][1] <= mode1GRB;
            G[0][1][0] <= mode1GRB; G[1][1][0] <= mode1GRB; G[2][1][0] <= mode1GRB; G[3][1][0] <= mode1GRB; G[4][1][0] <= mode1GRB; G[5][1][0] <= mode1GRB; G[6][1][0] <= mode1GRB; G[7][1][0] <= mode1GRB;
            G[0][2][3] <= `dark; G[1][2][3] <= `dark; G[2][2][3] <= `dark; G[3][2][3] <= `dark; G[4][2][3] <= `dark; G[5][2][3] <= `dark; G[6][2][3] <= `dark; G[7][2][3] <= `dark;
            G[0][2][2] <= `dark; G[1][2][2] <= `dark; G[2][2][2] <= `dark; G[3][2][2] <= `dark; G[4][2][2] <= `dark; G[5][2][2] <= `dark; G[6][2][2] <= `dark; G[7][2][2] <= `dark;
            G[0][2][1] <= `dark; G[1][2][1] <= `dark; G[2][2][1] <= `dark; G[3][2][1] <= `dark; G[4][2][1] <= `dark; G[5][2][1] <= `dark; G[6][2][1] <= `dark; G[7][2][1] <= `dark;
            G[0][2][0] <= `dark; G[1][2][0] <= `dark; G[2][2][0] <= `dark; G[3][2][0] <= `dark; G[4][2][0] <= `dark; G[5][2][0] <= `dark; G[6][2][0] <= `dark; G[7][2][0] <= `dark;
            G[0][3][3] <= `dark; G[1][3][3] <= `dark; G[2][3][3] <= `dark; G[3][3][3] <= `dark; G[4][3][3] <= `dark; G[5][3][3] <= `dark; G[6][3][3] <= `dark; G[7][3][3] <= `dark;
            G[0][3][2] <= `dark; G[1][3][2] <= `dark; G[2][3][2] <= `dark; G[3][3][2] <= `dark; G[4][3][2] <= `dark; G[5][3][2] <= `dark; G[6][3][2] <= `dark; G[7][3][2] <= `dark;
            G[0][3][1] <= `dark; G[1][3][1] <= `dark; G[2][3][1] <= `dark; G[3][3][1] <= `dark; G[4][3][1] <= `dark; G[5][3][1] <= `dark; G[6][3][1] <= `dark; G[7][3][1] <= `dark;
            G[0][3][0] <= `dark; G[1][3][0] <= `dark; G[2][3][0] <= `dark; G[3][3][0] <= `dark; G[4][3][0] <= `dark; G[5][3][0] <= `dark; G[6][3][0] <= `dark; G[7][3][0] <= `dark;
        end
        5'd11: begin //y2
            G[0][0][3] <= `dark; G[1][0][3] <= `dark; G[2][0][3] <= `dark; G[3][0][3] <= `dark; G[4][0][3] <= `dark; G[5][0][3] <= `dark; G[6][0][3] <= `dark; G[7][0][3] <= `dark;
            G[0][0][2] <= `dark; G[1][0][2] <= `dark; G[2][0][2] <= `dark; G[3][0][2] <= `dark; G[4][0][2] <= `dark; G[5][0][2] <= `dark; G[6][0][2] <= `dark; G[7][0][2] <= `dark;
            G[0][0][1] <= `dark; G[1][0][1] <= `dark; G[2][0][1] <= `dark; G[3][0][1] <= `dark; G[4][0][1] <= `dark; G[5][0][1] <= `dark; G[6][0][1] <= `dark; G[7][0][1] <= `dark;
            G[0][0][0] <= `dark; G[1][0][0] <= `dark; G[2][0][0] <= `dark; G[3][0][0] <= `dark; G[4][0][0] <= `dark; G[5][0][0] <= `dark; G[6][0][0] <= `dark; G[7][0][0] <= `dark;
            G[0][1][3] <= `dark; G[1][1][3] <= `dark; G[2][1][3] <= `dark; G[3][1][3] <= `dark; G[4][1][3] <= `dark; G[5][1][3] <= `dark; G[6][1][3] <= `dark; G[7][1][3] <= `dark;
            G[0][1][2] <= `dark; G[1][1][2] <= `dark; G[2][1][2] <= `dark; G[3][1][2] <= `dark; G[4][1][2] <= `dark; G[5][1][2] <= `dark; G[6][1][2] <= `dark; G[7][1][2] <= `dark;
            G[0][1][1] <= `dark; G[1][1][1] <= `dark; G[2][1][1] <= `dark; G[3][1][1] <= `dark; G[4][1][1] <= `dark; G[5][1][1] <= `dark; G[6][1][1] <= `dark; G[7][1][1] <= `dark;
            G[0][1][0] <= `dark; G[1][1][0] <= `dark; G[2][1][0] <= `dark; G[3][1][0] <= `dark; G[4][1][0] <= `dark; G[5][1][0] <= `dark; G[6][1][0] <= `dark; G[7][1][0] <= `dark;
            G[0][2][3] <= mode1GRB; G[1][2][3] <= mode1GRB; G[2][2][3] <= mode1GRB; G[3][2][3] <= mode1GRB; G[4][2][3] <= mode1GRB; G[5][2][3] <= mode1GRB; G[6][2][3] <= mode1GRB; G[7][2][3] <= mode1GRB;
            G[0][2][2] <= mode1GRB; G[1][2][2] <= mode1GRB; G[2][2][2] <= mode1GRB; G[3][2][2] <= mode1GRB; G[4][2][2] <= mode1GRB; G[5][2][2] <= mode1GRB; G[6][2][2] <= mode1GRB; G[7][2][2] <= mode1GRB;
            G[0][2][1] <= mode1GRB; G[1][2][1] <= mode1GRB; G[2][2][1] <= mode1GRB; G[3][2][1] <= mode1GRB; G[4][2][1] <= mode1GRB; G[5][2][1] <= mode1GRB; G[6][2][1] <= mode1GRB; G[7][2][1] <= mode1GRB;
            G[0][2][0] <= mode1GRB; G[1][2][0] <= mode1GRB; G[2][2][0] <= mode1GRB; G[3][2][0] <= mode1GRB; G[4][2][0] <= mode1GRB; G[5][2][0] <= mode1GRB; G[6][2][0] <= mode1GRB; G[7][2][0] <= mode1GRB;
            G[0][3][3] <= `dark; G[1][3][3] <= `dark; G[2][3][3] <= `dark; G[3][3][3] <= `dark; G[4][3][3] <= `dark; G[5][3][3] <= `dark; G[6][3][3] <= `dark; G[7][3][3] <= `dark;
            G[0][3][2] <= `dark; G[1][3][2] <= `dark; G[2][3][2] <= `dark; G[3][3][2] <= `dark; G[4][3][2] <= `dark; G[5][3][2] <= `dark; G[6][3][2] <= `dark; G[7][3][2] <= `dark;
            G[0][3][1] <= `dark; G[1][3][1] <= `dark; G[2][3][1] <= `dark; G[3][3][1] <= `dark; G[4][3][1] <= `dark; G[5][3][1] <= `dark; G[6][3][1] <= `dark; G[7][3][1] <= `dark;
            G[0][3][0] <= `dark; G[1][3][0] <= `dark; G[2][3][0] <= `dark; G[3][3][0] <= `dark; G[4][3][0] <= `dark; G[5][3][0] <= `dark; G[6][3][0] <= `dark; G[7][3][0] <= `dark;
        end
        5'd12: begin //y3
            G[0][0][3] <= `dark; G[1][0][3] <= `dark; G[2][0][3] <= `dark; G[3][0][3] <= `dark; G[4][0][3] <= `dark; G[5][0][3] <= `dark; G[6][0][3] <= `dark; G[7][0][3] <= `dark;
            G[0][0][2] <= `dark; G[1][0][2] <= `dark; G[2][0][2] <= `dark; G[3][0][2] <= `dark; G[4][0][2] <= `dark; G[5][0][2] <= `dark; G[6][0][2] <= `dark; G[7][0][2] <= `dark;
            G[0][0][1] <= `dark; G[1][0][1] <= `dark; G[2][0][1] <= `dark; G[3][0][1] <= `dark; G[4][0][1] <= `dark; G[5][0][1] <= `dark; G[6][0][1] <= `dark; G[7][0][1] <= `dark;
            G[0][0][0] <= `dark; G[1][0][0] <= `dark; G[2][0][0] <= `dark; G[3][0][0] <= `dark; G[4][0][0] <= `dark; G[5][0][0] <= `dark; G[6][0][0] <= `dark; G[7][0][0] <= `dark;
            G[0][1][3] <= `dark; G[1][1][3] <= `dark; G[2][1][3] <= `dark; G[3][1][3] <= `dark; G[4][1][3] <= `dark; G[5][1][3] <= `dark; G[6][1][3] <= `dark; G[7][1][3] <= `dark;
            G[0][1][2] <= `dark; G[1][1][2] <= `dark; G[2][1][2] <= `dark; G[3][1][2] <= `dark; G[4][1][2] <= `dark; G[5][1][2] <= `dark; G[6][1][2] <= `dark; G[7][1][2] <= `dark;
            G[0][1][1] <= `dark; G[1][1][1] <= `dark; G[2][1][1] <= `dark; G[3][1][1] <= `dark; G[4][1][1] <= `dark; G[5][1][1] <= `dark; G[6][1][1] <= `dark; G[7][1][1] <= `dark;
            G[0][1][0] <= `dark; G[1][1][0] <= `dark; G[2][1][0] <= `dark; G[3][1][0] <= `dark; G[4][1][0] <= `dark; G[5][1][0] <= `dark; G[6][1][0] <= `dark; G[7][1][0] <= `dark;
            G[0][2][3] <= `dark; G[1][2][3] <= `dark; G[2][2][3] <= `dark; G[3][2][3] <= `dark; G[4][2][3] <= `dark; G[5][2][3] <= `dark; G[6][2][3] <= `dark; G[7][2][3] <= `dark;
            G[0][2][2] <= `dark; G[1][2][2] <= `dark; G[2][2][2] <= `dark; G[3][2][2] <= `dark; G[4][2][2] <= `dark; G[5][2][2] <= `dark; G[6][2][2] <= `dark; G[7][2][2] <= `dark;
            G[0][2][1] <= `dark; G[1][2][1] <= `dark; G[2][2][1] <= `dark; G[3][2][1] <= `dark; G[4][2][1] <= `dark; G[5][2][1] <= `dark; G[6][2][1] <= `dark; G[7][2][1] <= `dark;
            G[0][2][0] <= `dark; G[1][2][0] <= `dark; G[2][2][0] <= `dark; G[3][2][0] <= `dark; G[4][2][0] <= `dark; G[5][2][0] <= `dark; G[6][2][0] <= `dark; G[7][2][0] <= `dark;
            G[0][3][3] <= mode1GRB; G[1][3][3] <= mode1GRB; G[2][3][3] <= mode1GRB; G[3][3][3] <= mode1GRB; G[4][3][3] <= mode1GRB; G[5][3][3] <= mode1GRB; G[6][3][3] <= mode1GRB; G[7][3][3] <= mode1GRB;
            G[0][3][2] <= mode1GRB; G[1][3][2] <= mode1GRB; G[2][3][2] <= mode1GRB; G[3][3][2] <= mode1GRB; G[4][3][2] <= mode1GRB; G[5][3][2] <= mode1GRB; G[6][3][2] <= mode1GRB; G[7][3][2] <= mode1GRB;
            G[0][3][1] <= mode1GRB; G[1][3][1] <= mode1GRB; G[2][3][1] <= mode1GRB; G[3][3][1] <= mode1GRB; G[4][3][1] <= mode1GRB; G[5][3][1] <= mode1GRB; G[6][3][1] <= mode1GRB; G[7][3][1] <= mode1GRB;
            G[0][3][0] <= mode1GRB; G[1][3][0] <= mode1GRB; G[2][3][0] <= mode1GRB; G[3][3][0] <= mode1GRB; G[4][3][0] <= mode1GRB; G[5][3][0] <= mode1GRB; G[6][3][0] <= mode1GRB; G[7][3][0] <= mode1GRB;
        end
        5'd13: begin //z0
            //y0
            G[0][0][3] <= `dark; G[1][0][3] <= `dark; G[2][0][3] <= `dark; G[3][0][3] <= `dark; G[4][0][3] <= `dark; G[5][0][3] <= `dark; G[6][0][3] <= `dark; G[7][0][3] <= `dark;
            G[0][0][2] <= `dark; G[1][0][2] <= `dark; G[2][0][2] <= `dark; G[3][0][2] <= `dark; G[4][0][2] <= `dark; G[5][0][2] <= `dark; G[6][0][2] <= `dark; G[7][0][2] <= `dark;
            G[0][0][1] <= `dark; G[1][0][1] <= `dark; G[2][0][1] <= `dark; G[3][0][1] <= `dark; G[4][0][1] <= `dark; G[5][0][1] <= `dark; G[6][0][1] <= `dark; G[7][0][1] <= `dark;
            G[0][0][0] <= mode1GRB; G[1][0][0] <= mode1GRB; G[2][0][0] <= mode1GRB; G[3][0][0] <= mode1GRB; G[4][0][0] <= mode1GRB; G[5][0][0] <= mode1GRB; G[6][0][0] <= mode1GRB; G[7][0][0] <= mode1GRB;
            //y1
            G[0][1][3] <= `dark; G[1][1][3] <= `dark; G[2][1][3] <= `dark; G[3][1][3] <= `dark; G[4][1][3] <= `dark; G[5][1][3] <= `dark; G[6][1][3] <= `dark; G[7][1][3] <= `dark;
            G[0][1][2] <= `dark; G[1][1][2] <= `dark; G[2][1][2] <= `dark; G[3][1][2] <= `dark; G[4][1][2] <= `dark; G[5][1][2] <= `dark; G[6][1][2] <= `dark; G[7][1][2] <= `dark;
            G[0][1][1] <= `dark; G[1][1][1] <= `dark; G[2][1][1] <= `dark; G[3][1][1] <= `dark; G[4][1][1] <= `dark; G[5][1][1] <= `dark; G[6][1][1] <= `dark; G[7][1][1] <= `dark;
            G[0][1][0] <= mode1GRB; G[1][1][0] <= mode1GRB; G[2][1][0] <= mode1GRB; G[3][1][0] <= mode1GRB; G[4][1][0] <= mode1GRB; G[5][1][0] <= mode1GRB; G[6][1][0] <= mode1GRB; G[7][1][0] <= mode1GRB;
            //y2
            G[0][2][3] <= `dark; G[1][2][3] <= `dark; G[2][2][3] <= `dark; G[3][2][3] <= `dark; G[4][2][3] <= `dark; G[5][2][3] <= `dark; G[6][2][3] <= `dark; G[7][2][3] <= `dark;
            G[0][2][2] <= `dark; G[1][2][2] <= `dark; G[2][2][2] <= `dark; G[3][2][2] <= `dark; G[4][2][2] <= `dark; G[5][2][2] <= `dark; G[6][2][2] <= `dark; G[7][2][2] <= `dark;
            G[0][2][1] <= `dark; G[1][2][1] <= `dark; G[2][2][1] <= `dark; G[3][2][1] <= `dark; G[4][2][1] <= `dark; G[5][2][1] <= `dark; G[6][2][1] <= `dark; G[7][2][1] <= `dark;
            G[0][2][0] <= mode1GRB; G[1][2][0] <= mode1GRB; G[2][2][0] <= mode1GRB; G[3][2][0] <= mode1GRB; G[4][2][0] <= mode1GRB; G[5][2][0] <= mode1GRB; G[6][2][0] <= mode1GRB; G[7][2][0] <= mode1GRB;
            //y3
            G[0][3][3] <= `dark; G[1][3][3] <= `dark; G[2][3][3] <= `dark; G[3][3][3] <= `dark; G[4][3][3] <= `dark; G[5][3][3] <= `dark; G[6][3][3] <= `dark; G[7][3][3] <= `dark;
            G[0][3][2] <= `dark; G[1][3][2] <= `dark; G[2][3][2] <= `dark; G[3][3][2] <= `dark; G[4][3][2] <= `dark; G[5][3][2] <= `dark; G[6][3][2] <= `dark; G[7][3][2] <= `dark;
            G[0][3][1] <= `dark; G[1][3][1] <= `dark; G[2][3][1] <= `dark; G[3][3][1] <= `dark; G[4][3][1] <= `dark; G[5][3][1] <= `dark; G[6][3][1] <= `dark; G[7][3][1] <= `dark;
            G[0][3][0] <= mode1GRB; G[1][3][0] <= mode1GRB; G[2][3][0] <= mode1GRB; G[3][3][0] <= mode1GRB; G[4][3][0] <= mode1GRB; G[5][3][0] <= mode1GRB; G[6][3][0] <= mode1GRB; G[7][3][0] <= mode1GRB;
        end
        5'd14: begin //z1
            G[0][0][3] <= `dark; G[1][0][3] <= `dark; G[2][0][3] <= `dark; G[3][0][3] <= `dark; G[4][0][3] <= `dark; G[5][0][3] <= `dark; G[6][0][3] <= `dark; G[7][0][3] <= `dark;
            G[0][0][2] <= `dark; G[1][0][2] <= `dark; G[2][0][2] <= `dark; G[3][0][2] <= `dark; G[4][0][2] <= `dark; G[5][0][2] <= `dark; G[6][0][2] <= `dark; G[7][0][2] <= `dark;
            G[0][0][1] <= mode1GRB; G[1][0][1] <= mode1GRB; G[2][0][1] <= mode1GRB; G[3][0][1] <= mode1GRB; G[4][0][1] <= mode1GRB; G[5][0][1] <= mode1GRB; G[6][0][1] <= mode1GRB; G[7][0][1] <= mode1GRB;
            G[0][0][0] <= `dark; G[1][0][0] <= `dark; G[2][0][0] <= `dark; G[3][0][0] <= `dark; G[4][0][0] <= `dark; G[5][0][0] <= `dark; G[6][0][0] <= `dark; G[7][0][0] <= `dark;
            G[0][1][3] <= `dark; G[1][1][3] <= `dark; G[2][1][3] <= `dark; G[3][1][3] <= `dark; G[4][1][3] <= `dark; G[5][1][3] <= `dark; G[6][1][3] <= `dark; G[7][1][3] <= `dark;
            G[0][1][2] <= `dark; G[1][1][2] <= `dark; G[2][1][2] <= `dark; G[3][1][2] <= `dark; G[4][1][2] <= `dark; G[5][1][2] <= `dark; G[6][1][2] <= `dark; G[7][1][2] <= `dark;
            G[0][1][1] <= mode1GRB; G[1][1][1] <= mode1GRB; G[2][1][1] <= mode1GRB; G[3][1][1] <= mode1GRB; G[4][1][1] <= mode1GRB; G[5][1][1] <= mode1GRB; G[6][1][1] <= mode1GRB; G[7][1][1] <= mode1GRB;
            G[0][1][0] <= `dark; G[1][1][0] <= `dark; G[2][1][0] <= `dark; G[3][1][0] <= `dark; G[4][1][0] <= `dark; G[5][1][0] <= `dark; G[6][1][0] <= `dark; G[7][1][0] <= `dark;
            G[0][2][3] <= `dark; G[1][2][3] <= `dark; G[2][2][3] <= `dark; G[3][2][3] <= `dark; G[4][2][3] <= `dark; G[5][2][3] <= `dark; G[6][2][3] <= `dark; G[7][2][3] <= `dark;
            G[0][2][2] <= `dark; G[1][2][2] <= `dark; G[2][2][2] <= `dark; G[3][2][2] <= `dark; G[4][2][2] <= `dark; G[5][2][2] <= `dark; G[6][2][2] <= `dark; G[7][2][2] <= `dark;
            G[0][2][1] <= mode1GRB; G[1][2][1] <= mode1GRB; G[2][2][1] <= mode1GRB; G[3][2][1] <= mode1GRB; G[4][2][1] <= mode1GRB; G[5][2][1] <= mode1GRB; G[6][2][1] <= mode1GRB; G[7][2][1] <= mode1GRB;
            G[0][2][0] <= `dark; G[1][2][0] <= `dark; G[2][2][0] <= `dark; G[3][2][0] <= `dark; G[4][2][0] <= `dark; G[5][2][0] <= `dark; G[6][2][0] <= `dark; G[7][2][0] <= `dark;
            G[0][3][3] <= `dark; G[1][3][3] <= `dark; G[2][3][3] <= `dark; G[3][3][3] <= `dark; G[4][3][3] <= `dark; G[5][3][3] <= `dark; G[6][3][3] <= `dark; G[7][3][3] <= `dark;
            G[0][3][2] <= `dark; G[1][3][2] <= `dark; G[2][3][2] <= `dark; G[3][3][2] <= `dark; G[4][3][2] <= `dark; G[5][3][2] <= `dark; G[6][3][2] <= `dark; G[7][3][2] <= `dark;
            G[0][3][1] <= mode1GRB; G[1][3][1] <= mode1GRB; G[2][3][1] <= mode1GRB; G[3][3][1] <= mode1GRB; G[4][3][1] <= mode1GRB; G[5][3][1] <= mode1GRB; G[6][3][1] <= mode1GRB; G[7][3][1] <= mode1GRB;
            G[0][3][0] <= `dark; G[1][3][0] <= `dark; G[2][3][0] <= `dark; G[3][3][0] <= `dark; G[4][3][0] <= `dark; G[5][3][0] <= `dark; G[6][3][0] <= `dark; G[7][3][0] <= `dark;
        end
        5'd15: begin //z2
            G[0][0][3] <= `dark; G[1][0][3] <= `dark; G[2][0][3] <= `dark; G[3][0][3] <= `dark; G[4][0][3] <= `dark; G[5][0][3] <= `dark; G[6][0][3] <= `dark; G[7][0][3] <= `dark;
            G[0][0][2] <= mode1GRB; G[1][0][2] <= mode1GRB; G[2][0][2] <= mode1GRB; G[3][0][2] <= mode1GRB; G[4][0][2] <= mode1GRB; G[5][0][2] <= mode1GRB; G[6][0][2] <= mode1GRB; G[7][0][2] <= mode1GRB;
            G[0][0][1] <= `dark; G[1][0][1] <= `dark; G[2][0][1] <= `dark; G[3][0][1] <= `dark; G[4][0][1] <= `dark; G[5][0][1] <= `dark; G[6][0][1] <= `dark; G[7][0][1] <= `dark;
            G[0][0][0] <= `dark; G[1][0][0] <= `dark; G[2][0][0] <= `dark; G[3][0][0] <= `dark; G[4][0][0] <= `dark; G[5][0][0] <= `dark; G[6][0][0] <= `dark; G[7][0][0] <= `dark;
            G[0][1][3] <= `dark; G[1][1][3] <= `dark; G[2][1][3] <= `dark; G[3][1][3] <= `dark; G[4][1][3] <= `dark; G[5][1][3] <= `dark; G[6][1][3] <= `dark; G[7][1][3] <= `dark;
            G[0][1][2] <= mode1GRB; G[1][1][2] <= mode1GRB; G[2][1][2] <= mode1GRB; G[3][1][2] <= mode1GRB; G[4][1][2] <= mode1GRB; G[5][1][2] <= mode1GRB; G[6][1][2] <= mode1GRB; G[7][1][2] <= mode1GRB;
            G[0][1][1] <= `dark; G[1][1][1] <= `dark; G[2][1][1] <= `dark; G[3][1][1] <= `dark; G[4][1][1] <= `dark; G[5][1][1] <= `dark; G[6][1][1] <= `dark; G[7][1][1] <= `dark;
            G[0][1][0] <= `dark; G[1][1][0] <= `dark; G[2][1][0] <= `dark; G[3][1][0] <= `dark; G[4][1][0] <= `dark; G[5][1][0] <= `dark; G[6][1][0] <= `dark; G[7][1][0] <= `dark;
            G[0][2][3] <= `dark; G[1][2][3] <= `dark; G[2][2][3] <= `dark; G[3][2][3] <= `dark; G[4][2][3] <= `dark; G[5][2][3] <= `dark; G[6][2][3] <= `dark; G[7][2][3] <= `dark;
            G[0][2][2] <= mode1GRB; G[1][2][2] <= mode1GRB; G[2][2][2] <= mode1GRB; G[3][2][2] <= mode1GRB; G[4][2][2] <= mode1GRB; G[5][2][2] <= mode1GRB; G[6][2][2] <= mode1GRB; G[7][2][2] <= mode1GRB;
            G[0][2][1] <= `dark; G[1][2][1] <= `dark; G[2][2][1] <= `dark; G[3][2][1] <= `dark; G[4][2][1] <= `dark; G[5][2][1] <= `dark; G[6][2][1] <= `dark; G[7][2][1] <= `dark;
            G[0][2][0] <= `dark; G[1][2][0] <= `dark; G[2][2][0] <= `dark; G[3][2][0] <= `dark; G[4][2][0] <= `dark; G[5][2][0] <= `dark; G[6][2][0] <= `dark; G[7][2][0] <= `dark;
            G[0][3][3] <= `dark; G[1][3][3] <= `dark; G[2][3][3] <= `dark; G[3][3][3] <= `dark; G[4][3][3] <= `dark; G[5][3][3] <= `dark; G[6][3][3] <= `dark; G[7][3][3] <= `dark;
            G[0][3][2] <= mode1GRB; G[1][3][2] <= mode1GRB; G[2][3][2] <= mode1GRB; G[3][3][2] <= mode1GRB; G[4][3][2] <= mode1GRB; G[5][3][2] <= mode1GRB; G[6][3][2] <= mode1GRB; G[7][3][2] <= mode1GRB;
            G[0][3][1] <= `dark; G[1][3][1] <= `dark; G[2][3][1] <= `dark; G[3][3][1] <= `dark; G[4][3][1] <= `dark; G[5][3][1] <= `dark; G[6][3][1] <= `dark; G[7][3][1] <= `dark;
            G[0][3][0] <= `dark; G[1][3][0] <= `dark; G[2][3][0] <= `dark; G[3][3][0] <= `dark; G[4][3][0] <= `dark; G[5][3][0] <= `dark; G[6][3][0] <= `dark; G[7][3][0] <= `dark;
        end
        5'd16: begin //z3
            G[0][0][3] <= mode1GRB; G[1][0][3] <= mode1GRB; G[2][0][3] <= mode1GRB; G[3][0][3] <= mode1GRB; G[4][0][3] <= mode1GRB; G[5][0][3] <= mode1GRB; G[6][0][3] <= mode1GRB; G[7][0][3] <= mode1GRB;
            G[0][0][2] <= `dark; G[1][0][2] <= `dark; G[2][0][2] <= `dark; G[3][0][2] <= `dark; G[4][0][2] <= `dark; G[5][0][2] <= `dark; G[6][0][2] <= `dark; G[7][0][2] <= `dark;
            G[0][0][1] <= `dark; G[1][0][1] <= `dark; G[2][0][1] <= `dark; G[3][0][1] <= `dark; G[4][0][1] <= `dark; G[5][0][1] <= `dark; G[6][0][1] <= `dark; G[7][0][1] <= `dark;
            G[0][0][0] <= `dark; G[1][0][0] <= `dark; G[2][0][0] <= `dark; G[3][0][0] <= `dark; G[4][0][0] <= `dark; G[5][0][0] <= `dark; G[6][0][0] <= `dark; G[7][0][0] <= `dark;
            G[0][1][3] <= mode1GRB; G[1][1][3] <= mode1GRB; G[2][1][3] <= mode1GRB; G[3][1][3] <= mode1GRB; G[4][1][3] <= mode1GRB; G[5][1][3] <= mode1GRB; G[6][1][3] <= mode1GRB; G[7][1][3] <= mode1GRB;
            G[0][1][2] <= `dark; G[1][1][2] <= `dark; G[2][1][2] <= `dark; G[3][1][2] <= `dark; G[4][1][2] <= `dark; G[5][1][2] <= `dark; G[6][1][2] <= `dark; G[7][1][2] <= `dark;
            G[0][1][1] <= `dark; G[1][1][1] <= `dark; G[2][1][1] <= `dark; G[3][1][1] <= `dark; G[4][1][1] <= `dark; G[5][1][1] <= `dark; G[6][1][1] <= `dark; G[7][1][1] <= `dark;
            G[0][1][0] <= `dark; G[1][1][0] <= `dark; G[2][1][0] <= `dark; G[3][1][0] <= `dark; G[4][1][0] <= `dark; G[5][1][0] <= `dark; G[6][1][0] <= `dark; G[7][1][0] <= `dark;
            G[0][2][3] <= mode1GRB; G[1][2][3] <= mode1GRB; G[2][2][3] <= mode1GRB; G[3][2][3] <= mode1GRB; G[4][2][3] <= mode1GRB; G[5][2][3] <= mode1GRB; G[6][2][3] <= mode1GRB; G[7][2][3] <= mode1GRB;
            G[0][2][2] <= `dark; G[1][2][2] <= `dark; G[2][2][2] <= `dark; G[3][2][2] <= `dark; G[4][2][2] <= `dark; G[5][2][2] <= `dark; G[6][2][2] <= `dark; G[7][2][2] <= `dark;
            G[0][2][1] <= `dark; G[1][2][1] <= `dark; G[2][2][1] <= `dark; G[3][2][1] <= `dark; G[4][2][1] <= `dark; G[5][2][1] <= `dark; G[6][2][1] <= `dark; G[7][2][1] <= `dark;
            G[0][2][0] <= `dark; G[1][2][0] <= `dark; G[2][2][0] <= `dark; G[3][2][0] <= `dark; G[4][2][0] <= `dark; G[5][2][0] <= `dark; G[6][2][0] <= `dark; G[7][2][0] <= `dark;
            G[0][3][3] <= mode1GRB; G[1][3][3] <= mode1GRB; G[2][3][3] <= mode1GRB; G[3][3][3] <= mode1GRB; G[4][3][3] <= mode1GRB; G[5][3][3] <= mode1GRB; G[6][3][3] <= mode1GRB; G[7][3][3] <= mode1GRB;
            G[0][3][2] <= `dark; G[1][3][2] <= `dark; G[2][3][2] <= `dark; G[3][3][2] <= `dark; G[4][3][2] <= `dark; G[5][3][2] <= `dark; G[6][3][2] <= `dark; G[7][3][2] <= `dark;
            G[0][3][1] <= `dark; G[1][3][1] <= `dark; G[2][3][1] <= `dark; G[3][3][1] <= `dark; G[4][3][1] <= `dark; G[5][3][1] <= `dark; G[6][3][1] <= `dark; G[7][3][1] <= `dark;
            G[0][3][0] <= `dark; G[1][3][0] <= `dark; G[2][3][0] <= `dark; G[3][3][0] <= `dark; G[4][3][0] <= `dark; G[5][3][0] <= `dark; G[6][3][0] <= `dark; G[7][3][0] <= `dark;
        end
        default: begin //ALL dark
            G[0][0][3] <= `dark; G[1][0][3] <= `dark; G[2][0][3] <= `dark; G[3][0][3] <= `dark; G[4][0][3] <= `dark; G[5][0][3] <= `dark; G[6][0][3] <= `dark; G[7][0][3] <= `dark;
            G[0][0][2] <= `dark; G[1][0][2] <= `dark; G[2][0][2] <= `dark; G[3][0][2] <= `dark; G[4][0][2] <= `dark; G[5][0][2] <= `dark; G[6][0][2] <= `dark; G[7][0][2] <= `dark;
            G[0][0][1] <= `dark; G[1][0][1] <= `dark; G[2][0][1] <= `dark; G[3][0][1] <= `dark; G[4][0][1] <= `dark; G[5][0][1] <= `dark; G[6][0][1] <= `dark; G[7][0][1] <= `dark;
            G[0][0][0] <= `dark; G[1][0][0] <= `dark; G[2][0][0] <= `dark; G[3][0][0] <= `dark; G[4][0][0] <= `dark; G[5][0][0] <= `dark; G[6][0][0] <= `dark; G[7][0][0] <= `dark;
            G[0][1][3] <= `dark; G[1][1][3] <= `dark; G[2][1][3] <= `dark; G[3][1][3] <= `dark; G[4][1][3] <= `dark; G[5][1][3] <= `dark; G[6][1][3] <= `dark; G[7][1][3] <= `dark;
            G[0][1][2] <= `dark; G[1][1][2] <= `dark; G[2][1][2] <= `dark; G[3][1][2] <= `dark; G[4][1][2] <= `dark; G[5][1][2] <= `dark; G[6][1][2] <= `dark; G[7][1][2] <= `dark;
            G[0][1][1] <= `dark; G[1][1][1] <= `dark; G[2][1][1] <= `dark; G[3][1][1] <= `dark; G[4][1][1] <= `dark; G[5][1][1] <= `dark; G[6][1][1] <= `dark; G[7][1][1] <= `dark;
            G[0][1][0] <= `dark; G[1][1][0] <= `dark; G[2][1][0] <= `dark; G[3][1][0] <= `dark; G[4][1][0] <= `dark; G[5][1][0] <= `dark; G[6][1][0] <= `dark; G[7][1][0] <= `dark;
            G[0][2][3] <= `dark; G[1][2][3] <= `dark; G[2][2][3] <= `dark; G[3][2][3] <= `dark; G[4][2][3] <= `dark; G[5][2][3] <= `dark; G[6][2][3] <= `dark; G[7][2][3] <= `dark;
            G[0][2][2] <= `dark; G[1][2][2] <= `dark; G[2][2][2] <= `dark; G[3][2][2] <= `dark; G[4][2][2] <= `dark; G[5][2][2] <= `dark; G[6][2][2] <= `dark; G[7][2][2] <= `dark;
            G[0][2][1] <= `dark; G[1][2][1] <= `dark; G[2][2][1] <= `dark; G[3][2][1] <= `dark; G[4][2][1] <= `dark; G[5][2][1] <= `dark; G[6][2][1] <= `dark; G[7][2][1] <= `dark;
            G[0][2][0] <= `dark; G[1][2][0] <= `dark; G[2][2][0] <= `dark; G[3][2][0] <= `dark; G[4][2][0] <= `dark; G[5][2][0] <= `dark; G[6][2][0] <= `dark; G[7][2][0] <= `dark;
            G[0][3][3] <= `dark; G[1][3][3] <= `dark; G[2][3][3] <= `dark; G[3][3][3] <= `dark; G[4][3][3] <= `dark; G[5][3][3] <= `dark; G[6][3][3] <= `dark; G[7][3][3] <= `dark;
            G[0][3][2] <= `dark; G[1][3][2] <= `dark; G[2][3][2] <= `dark; G[3][3][2] <= `dark; G[4][3][2] <= `dark; G[5][3][2] <= `dark; G[6][3][2] <= `dark; G[7][3][2] <= `dark;
            G[0][3][1] <= `dark; G[1][3][1] <= `dark; G[2][3][1] <= `dark; G[3][3][1] <= `dark; G[4][3][1] <= `dark; G[5][3][1] <= `dark; G[6][3][1] <= `dark; G[7][3][1] <= `dark;
            G[0][3][0] <= `dark; G[1][3][0] <= `dark; G[2][3][0] <= `dark; G[3][3][0] <= `dark; G[4][3][0] <= `dark; G[5][3][0] <= `dark; G[6][3][0] <= `dark; G[7][3][0] <= `dark;
        end
        endcase
    end
    else if(mode==3'd5) begin //fountain
        //1
        if(voice > `voice_low) G[0][0][3] <= mode1GRB;
        else G[0][0][3] <= `dark;
        G[1][0][3] <= `dark; G[2][0][3] <= `dark; G[3][0][3] <= `dark; G[4][0][3] <= `dark; G[5][0][3] <= `dark; G[6][0][3] <= `dark; G[7][0][3] <= `dark;
        //2
        G[0][0][2] <= mode1GRB;
        G[0][1][3] <= mode1GRB;
        if(voice > `voice_low) begin
            G[1][0][2] <= mode1GRB;
            G[1][1][3] <= mode1GRB;
        end else begin
            G[1][0][2] <= `dark;
            G[1][1][3] <= `dark;
        end
        G[2][0][2] <= `dark; G[3][0][2] <= `dark; G[4][0][2] <= `dark; G[5][0][2] <= `dark; G[6][0][2] <= `dark; G[7][0][2] <= `dark;
        G[2][1][3] <= `dark; G[3][1][3] <= `dark; G[4][1][3] <= `dark; G[5][1][3] <= `dark; G[6][1][3] <= `dark; G[7][1][3] <= `dark;
        //3
        G[0][0][1] <= mode1GRB; G[1][0][1] <= mode1GRB;
        G[0][1][2] <= mode1GRB; G[1][1][2] <= mode1GRB;
        G[0][2][3] <= mode1GRB; G[1][2][3] <= mode1GRB;
        if(voice > `voice_lmid) begin
            G[2][0][1] <= mode1GRB;
            G[2][1][2] <= mode1GRB;
            G[2][2][3] <= mode1GRB;
        end else begin
            G[2][0][1] <= `dark;
            G[2][1][2] <= `dark;
            G[2][2][3] <= `dark;
        end
        G[3][0][1] <= `dark; G[4][0][1] <= `dark; G[5][0][1] <= `dark; G[6][0][1] <= `dark; G[7][0][1] <= `dark;
        G[3][1][2] <= `dark; G[4][1][2] <= `dark; G[5][1][2] <= `dark; G[6][1][2] <= `dark; G[7][1][2] <= `dark;
        G[3][2][3] <= `dark; G[4][2][3] <= `dark; G[5][2][3] <= `dark; G[6][2][3] <= `dark; G[7][2][3] <= `dark;
        //4
        G[0][0][0] <= mode1GRB; G[1][0][0] <= mode1GRB;
        G[0][1][1] <= mode1GRB; G[1][1][1] <= mode1GRB;
        G[0][2][2] <= mode1GRB; G[1][2][2] <= mode1GRB;
        G[0][3][3] <= mode1GRB; G[1][3][3] <= mode1GRB;
        if(voice > `voice_lmid) begin
            G[2][0][0] <= mode1GRB;
            G[2][1][1] <= mode1GRB;
            G[2][2][2] <= mode1GRB;
            G[2][3][3] <= mode1GRB;
        end else begin
            G[2][0][0] <= `dark;
            G[2][1][1] <= `dark;
            G[2][2][2] <= `dark;
            G[2][3][3] <= `dark;
        end
        if(voice > `voice_mid) begin
            G[3][0][0] <= mode1GRB;
            G[3][1][1] <= mode1GRB;
            G[3][2][2] <= mode1GRB;
            G[3][3][3] <= mode1GRB;
        end else begin
            G[3][0][0] <= `dark;
            G[3][1][1] <= `dark;
            G[3][2][2] <= `dark;
            G[3][3][3] <= `dark;
        end
        G[4][0][0] <= `dark; G[5][0][0] <= `dark; G[6][0][0] <= `dark; G[7][0][0] <= `dark;
        G[4][1][1] <= `dark; G[5][1][1] <= `dark; G[6][1][1] <= `dark; G[7][1][1] <= `dark;
        G[4][2][2] <= `dark; G[5][2][2] <= `dark; G[6][2][2] <= `dark; G[7][2][2] <= `dark;
        G[4][3][3] <= `dark; G[5][3][3] <= `dark; G[6][3][3] <= `dark; G[7][3][3] <= `dark;
        //5
        G[0][1][0] <= mode1GRB; G[1][1][0] <= mode1GRB;
        G[0][2][1] <= mode1GRB; G[1][2][1] <= mode1GRB;
        G[0][3][2] <= mode1GRB; G[1][3][2] <= mode1GRB;
        if(voice > `voice_lmid) begin
            G[2][1][0] <= mode1GRB;
            G[2][2][1] <= mode1GRB;
            G[2][3][2] <= mode1GRB;
        end else begin
            G[2][1][0] <= `dark;
            G[2][2][1] <= `dark;
            G[2][3][2] <= `dark;
        end
        if(voice > `voice_mid) begin
            G[3][1][0] <= mode1GRB;
            G[3][2][1] <= mode1GRB;
            G[3][3][2] <= mode1GRB;
        end else begin
            G[3][1][0] <= `dark;
            G[3][2][1] <= `dark;
            G[3][3][2] <= `dark;
        end
        if(voice > `voice_hmid) begin
            G[4][1][0] <= mode1GRB;
            G[4][2][1] <= mode1GRB;
            G[4][3][2] <= mode1GRB;
        end else begin
            G[4][1][0] <= `dark;
            G[4][2][1] <= `dark;
            G[4][3][2] <= `dark;
        end
        G[5][1][0] <= `dark; G[6][1][0] <= `dark; G[7][1][0] <= `dark;
        G[5][2][1] <= `dark; G[6][2][1] <= `dark; G[7][2][1] <= `dark;
        G[5][3][2] <= `dark; G[6][3][2] <= `dark; G[7][3][2] <= `dark;
        //6
        G[0][2][0] <= mode1GRB; G[1][2][0] <= mode1GRB; G[2][2][0] <= mode1GRB;
        G[0][3][1] <= mode1GRB; G[1][3][1] <= mode1GRB; G[2][3][1] <= mode1GRB;
        if(voice > `voice_lmid) begin
            G[3][2][0] <= mode1GRB;
            G[3][3][1] <= mode1GRB;
        end else begin
            G[3][2][0] <= `dark;
            G[3][3][1] <= `dark;
        end
        if(voice > `voice_mid) begin
            G[4][2][0] <= mode1GRB;
            G[4][3][1] <= mode1GRB;
        end else begin
            G[4][2][0] <= `dark;
            G[4][3][1] <= `dark;
        end
        if(voice > `voice_hmid) begin
            G[5][2][0] <= mode1GRB;
            G[5][3][1] <= mode1GRB;
        end else begin
            G[5][2][0] <= `dark;
            G[5][3][1] <= `dark;
        end
        G[6][2][0] <= `dark; G[7][2][0] <= `dark;
        G[6][3][1] <= `dark; G[7][3][1] <= `dark;
        //7
        G[0][3][0] <= mode1GRB; G[1][3][0] <= mode1GRB; G[2][3][0] <= mode1GRB; G[3][3][0] <= mode1GRB;
        if(voice > `voice_lmid) begin
            G[4][3][0] <= mode1GRB;
        end else begin
            G[4][3][0] <= `dark;
        end
        if(voice > `voice_mid) begin
            G[5][3][0] <= mode1GRB;
        end else begin
            G[5][3][0] <= `dark;
        end
        if(voice > `voice_hmid) begin
            G[6][3][0] <= mode1GRB;
        end else begin
            G[6][3][0] <= `dark;
        end
        if(voice > `voice_high) begin
            G[7][3][0] <= mode1GRB;
        end else begin
            G[7][3][0] <= `dark;
        end
    end
    else if(mode==3'd6) begin //sin
        //ALL dark
        //y0 
        G[0][0][3] <= `dark; G[1][0][3] <= `dark; G[2][0][3] <= `dark; G[3][0][3] <= `dark; G[4][0][3] <= `dark; G[5][0][3] <= `dark; G[6][0][3] <= `dark; G[7][0][3] <= `dark;
        G[0][0][2] <= `dark; G[1][0][2] <= `dark; G[2][0][2] <= `dark; G[3][0][2] <= `dark; G[4][0][2] <= `dark; G[5][0][2] <= `dark; G[6][0][2] <= `dark; G[7][0][2] <= `dark;
        G[0][0][1] <= `dark; G[1][0][1] <= `dark; G[2][0][1] <= `dark; G[3][0][1] <= `dark; G[4][0][1] <= `dark; G[5][0][1] <= `dark; G[6][0][1] <= `dark; G[7][0][1] <= `dark;
        G[0][0][0] <= `dark; G[1][0][0] <= `dark; G[2][0][0] <= `dark; G[3][0][0] <= `dark; G[4][0][0] <= `dark; G[5][0][0] <= `dark; G[6][0][0] <= `dark; G[7][0][0] <= `dark;
        //y1
        G[0][1][3] <= `dark; G[1][1][3] <= `dark; G[2][1][3] <= `dark; G[3][1][3] <= `dark; G[4][1][3] <= `dark; G[5][1][3] <= `dark; G[6][1][3] <= `dark; G[7][1][3] <= `dark;
        G[0][1][2] <= `dark; G[1][1][2] <= `dark; G[2][1][2] <= `dark; G[3][1][2] <= `dark; G[4][1][2] <= `dark; G[5][1][2] <= `dark; G[6][1][2] <= `dark; G[7][1][2] <= `dark;
        G[0][1][1] <= `dark; G[1][1][1] <= `dark; G[2][1][1] <= `dark; G[3][1][1] <= `dark; G[4][1][1] <= `dark; G[5][1][1] <= `dark; G[6][1][1] <= `dark; G[7][1][1] <= `dark;
        G[0][1][0] <= `dark; G[1][1][0] <= `dark; G[2][1][0] <= `dark; G[3][1][0] <= `dark; G[4][1][0] <= `dark; G[5][1][0] <= `dark; G[6][1][0] <= `dark; G[7][1][0] <= `dark;
        //y2
        G[0][2][3] <= `dark; G[1][2][3] <= `dark; G[2][2][3] <= `dark; G[3][2][3] <= `dark; G[4][2][3] <= `dark; G[5][2][3] <= `dark; G[6][2][3] <= `dark; G[7][2][3] <= `dark;
        G[0][2][2] <= `dark; G[1][2][2] <= `dark; G[2][2][2] <= `dark; G[3][2][2] <= `dark; G[4][2][2] <= `dark; G[5][2][2] <= `dark; G[6][2][2] <= `dark; G[7][2][2] <= `dark;
        G[0][2][1] <= `dark; G[1][2][1] <= `dark; G[2][2][1] <= `dark; G[3][2][1] <= `dark; G[4][2][1] <= `dark; G[5][2][1] <= `dark; G[6][2][1] <= `dark; G[7][2][1] <= `dark;
        G[0][2][0] <= `dark; G[1][2][0] <= `dark; G[2][2][0] <= `dark; G[3][2][0] <= `dark; G[4][2][0] <= `dark; G[5][2][0] <= `dark; G[6][2][0] <= `dark; G[7][2][0] <= `dark;
        //y3
        G[0][3][3] <= `dark; G[1][3][3] <= `dark; G[2][3][3] <= `dark; G[3][3][3] <= `dark; G[4][3][3] <= `dark; G[5][3][3] <= `dark; G[6][3][3] <= `dark; G[7][3][3] <= `dark;
        G[0][3][2] <= `dark; G[1][3][2] <= `dark; G[2][3][2] <= `dark; G[3][3][2] <= `dark; G[4][3][2] <= `dark; G[5][3][2] <= `dark; G[6][3][2] <= `dark; G[7][3][2] <= `dark;
        G[0][3][1] <= `dark; G[1][3][1] <= `dark; G[2][3][1] <= `dark; G[3][3][1] <= `dark; G[4][3][1] <= `dark; G[5][3][1] <= `dark; G[6][3][1] <= `dark; G[7][3][1] <= `dark;
        G[0][3][0] <= `dark; G[1][3][0] <= `dark; G[2][3][0] <= `dark; G[3][3][0] <= `dark; G[4][3][0] <= `dark; G[5][3][0] <= `dark; G[6][3][0] <= `dark; G[7][3][0] <= `dark;

        //y0
        G[0][0][mode6z[0]] <= mode1GRB;
        G[1][0][mode6z[1]] <= mode1GRB;
        G[2][0][mode6z[2]] <= mode1GRB;
        G[3][0][mode6z[3]] <= mode1GRB;
        G[4][0][mode6z[4]] <= mode1GRB;
        G[5][0][mode6z[5]] <= mode1GRB;
        G[6][0][mode6z[6]] <= mode1GRB;
        G[7][0][mode6z[7]] <= mode1GRB;
        //y1
        G[0][1][mode6z[8]] <= mode1GRB;
        G[1][1][mode6z[9]] <= mode1GRB; 
        G[2][1][mode6z[10]] <= mode1GRB;
        G[3][1][mode6z[11]] <= mode1GRB;
        G[4][1][mode6z[12]] <= mode1GRB;
        G[5][1][mode6z[13]] <= mode1GRB;
        G[6][1][mode6z[14]] <= mode1GRB;
        G[7][1][mode6z[15]] <= mode1GRB;
        //y2
        G[0][2][mode6z[16]] <= mode1GRB;
        G[1][2][mode6z[17]] <= mode1GRB;
        G[2][2][mode6z[18]] <= mode1GRB;
        G[3][2][mode6z[19]] <= mode1GRB;
        G[4][2][mode6z[20]] <= mode1GRB;
        G[5][2][mode6z[21]] <= mode1GRB;
        G[6][2][mode6z[22]] <= mode1GRB;
        G[7][2][mode6z[23]] <= mode1GRB;
        //y3
        G[0][3][mode6z[24]] <= mode1GRB;
        G[1][3][mode6z[25]] <= mode1GRB; 
        G[2][3][mode6z[26]] <= mode1GRB;
        G[3][3][mode6z[27]] <= mode1GRB;
        G[4][3][mode6z[28]] <= mode1GRB;
        G[5][3][mode6z[29]] <= mode1GRB;
        G[6][3][mode6z[30]] <= mode1GRB;
        G[7][3][mode6z[31]] <= mode1GRB;
    end
    else if(mode==3'd7) begin //test
        G[mode7x2][mode7y2][mode7z2] <= mode1GRB;
        G[mode7x1][mode7y1][mode7z1] <= `dark;
    end
end

//mode6z
always @(posedge clk) begin
    if(rst || mode!=3'd6) begin
        mode6z[0] <= 3;
        mode6z[1] <= 3;
        mode6z[2] <= 3;
        mode6z[3] <= 3;
        mode6z[4] <= 3;
        mode6z[5] <= 3;
        mode6z[6] <= 3;
        mode6z[7] <= 3;
        mode6z[8] <= 3;
        mode6z[9] <= 3;
        mode6z[10] <= 3;
        mode6z[11] <= 3;
        mode6z[12] <= 3;
        mode6z[13] <= 3;
        mode6z[14] <= 3;
        mode6z[15] <= 3;
        mode6z[16] <= 3;
        mode6z[17] <= 3;
        mode6z[18] <= 3;
        mode6z[19] <= 3;
        mode6z[20] <= 3;
        mode6z[21] <= 3;
        mode6z[22] <= 3;
        mode6z[23] <= 3;
        mode6z[24] <= 3;
        mode6z[25] <= 3;
        mode6z[26] <= 3;
        mode6z[27] <= 3;
        mode6z[28] <= 3;
        mode6z[29] <= 3;
        mode6z[30] <= 3;
        mode6z[31] <= 3;
    end
    else begin
        if(time_01) begin
            mode6z[0] <= mode6z[0] + (mode6dz[0] ? 1 : -1);
            mode6z[8] <= mode6z[8] + (mode6dz[8] ? 1 : -1);
            mode6z[16] <= mode6z[16] + (mode6dz[16] ? 1 : -1);
            mode6z[24] <= mode6z[24] + (mode6dz[24] ? 1 : -1);
        end
        if(time_0099) begin
            mode6z[1] <= mode6z[1] + (mode6dz[1] ? 1 : -1);
            mode6z[9] <= mode6z[9] + (mode6dz[9] ? 1 : -1);
            mode6z[17] <= mode6z[17] + (mode6dz[17] ? 1 : -1);
            mode6z[25] <= mode6z[25] + (mode6dz[25] ? 1 : -1);
        end
        if(time_0098) begin
            mode6z[2] <= mode6z[2] + (mode6dz[2] ? 1 : -1);
            mode6z[10] <= mode6z[10] + (mode6dz[10] ? 1 : -1);
            mode6z[18] <= mode6z[18] + (mode6dz[18] ? 1 : -1);
            mode6z[26] <= mode6z[26] + (mode6dz[26] ? 1 : -1);
        end
        if(time_0097) begin
            mode6z[3] <= mode6z[3] + (mode6dz[3] ? 1 : -1);
            mode6z[11] <= mode6z[11] + (mode6dz[11] ? 1 : -1);
            mode6z[19] <= mode6z[19] + (mode6dz[19] ? 1 : -1);
            mode6z[27] <= mode6z[27] + (mode6dz[27] ? 1 : -1);
        end
        if(time_0096) begin
            mode6z[4] <= mode6z[4] + (mode6dz[4] ? 1 : -1);
            mode6z[12] <= mode6z[12] + (mode6dz[12] ? 1 : -1);
            mode6z[20] <= mode6z[20] + (mode6dz[20] ? 1 : -1);
            mode6z[28] <= mode6z[28] + (mode6dz[28] ? 1 : -1);
        end
        if(time_0095) begin
            mode6z[5] <= mode6z[5] + (mode6dz[5] ? 1 : -1);
            mode6z[13] <= mode6z[13] + (mode6dz[13] ? 1 : -1);
            mode6z[21] <= mode6z[21] + (mode6dz[21] ? 1 : -1);
            mode6z[29] <= mode6z[29] + (mode6dz[29] ? 1 : -1);
        end
        if(time_0094) begin
            mode6z[6] <= mode6z[6] + (mode6dz[6] ? 1 : -1);
            mode6z[14] <= mode6z[14] + (mode6dz[14] ? 1 : -1);
            mode6z[22] <= mode6z[22] + (mode6dz[22] ? 1 : -1);
            mode6z[30] <= mode6z[30] + (mode6dz[30] ? 1 : -1);
        end
        if(time_0093) begin
            mode6z[7] <= mode6z[7] + (mode6dz[7] ? 1 : -1);
            mode6z[15] <= mode6z[15] + (mode6dz[15] ? 1 : -1);
            mode6z[23] <= mode6z[23] + (mode6dz[23] ? 1 : -1);
            mode6z[31] <= mode6z[31] + (mode6dz[31] ? 1 : -1);
        end
    end
end

//mod6dz
always @(posedge clk) begin
    mode6dz[0] <= (mode6dz[0] && mode6z[0] != 2'd3) || mode6z[0] == 2'd0;
    mode6dz[1] <= (mode6dz[1] && mode6z[1] != 2'd3) || mode6z[1] == 2'd0;
    mode6dz[2] <= (mode6dz[2] && mode6z[2] != 2'd3) || mode6z[2] == 2'd0;
    mode6dz[3] <= (mode6dz[3] && mode6z[3] != 2'd3) || mode6z[3] == 2'd0;
    mode6dz[4] <= (mode6dz[4] && mode6z[4] != 2'd3) || mode6z[4] == 2'd0;
    mode6dz[5] <= (mode6dz[5] && mode6z[5] != 2'd3) || mode6z[5] == 2'd0;
    mode6dz[6] <= (mode6dz[6] && mode6z[6] != 2'd3) || mode6z[6] == 2'd0;
    mode6dz[7] <= (mode6dz[7] && mode6z[7] != 2'd3) || mode6z[7] == 2'd0;
    mode6dz[8] <= (mode6dz[8] && mode6z[8] != 2'd3) || mode6z[8] == 2'd0;
    mode6dz[9] <= (mode6dz[9] && mode6z[9] != 2'd3) || mode6z[9] == 2'd0; 
    mode6dz[10] <= (mode6dz[10] && mode6z[10] != 2'd3) || mode6z[10] == 2'd0;
    mode6dz[11] <= (mode6dz[11] && mode6z[11] != 2'd3) || mode6z[11] == 2'd0;
    mode6dz[12] <= (mode6dz[12] && mode6z[12] != 2'd3) || mode6z[12] == 2'd0;
    mode6dz[13] <= (mode6dz[13] && mode6z[13] != 2'd3) || mode6z[13] == 2'd0;
    mode6dz[14] <= (mode6dz[14] && mode6z[14] != 2'd3) || mode6z[14] == 2'd0;
    mode6dz[15] <= (mode6dz[15] && mode6z[15] != 2'd3) || mode6z[15] == 2'd0;
    mode6dz[16] <= (mode6dz[16] && mode6z[16] != 2'd3) || mode6z[16] == 2'd0;
    mode6dz[17] <= (mode6dz[17] && mode6z[17] != 2'd3) || mode6z[17] == 2'd0;
    mode6dz[18] <= (mode6dz[18] && mode6z[18] != 2'd3) || mode6z[18] == 2'd0;
    mode6dz[19] <= (mode6dz[19] && mode6z[19] != 2'd3) || mode6z[19] == 2'd0;
    mode6dz[20] <= (mode6dz[20] && mode6z[20] != 2'd3) || mode6z[20] == 2'd0;
    mode6dz[21] <= (mode6dz[21] && mode6z[21] != 2'd3) || mode6z[21] == 2'd0;
    mode6dz[22] <= (mode6dz[22] && mode6z[22] != 2'd3) || mode6z[22] == 2'd0;
    mode6dz[23] <= (mode6dz[23] && mode6z[23] != 2'd3) || mode6z[23] == 2'd0;
    mode6dz[24] <= (mode6dz[24] && mode6z[24] != 2'd3) || mode6z[24] == 2'd0;
    mode6dz[25] <= (mode6dz[25] && mode6z[25] != 2'd3) || mode6z[25] == 2'd0;
    mode6dz[26] <= (mode6dz[26] && mode6z[26] != 2'd3) || mode6z[26] == 2'd0;
    mode6dz[27] <= (mode6dz[27] && mode6z[27] != 2'd3) || mode6z[27] == 2'd0;
    mode6dz[28] <= (mode6dz[28] && mode6z[28] != 2'd3) || mode6z[28] == 2'd0;
    mode6dz[29] <= (mode6dz[29] && mode6z[29] != 2'd3) || mode6z[29] == 2'd0;
    mode6dz[30] <= (mode6dz[30] && mode6z[30] != 2'd3) || mode6z[30] == 2'd0;
    mode6dz[31] <= (mode6dz[31] && mode6z[31] != 2'd3) || mode6z[31] == 2'd0;
end

//mode3state
always @(*) begin
    next_mode3dir = mode3dir;
    case(mode3state)
        5'd0: begin //initial state, all dark
            case(rand%6) 
                3'd0: begin
                    next_mode3state = 5'd1;
                    next_mode3dir = 2'd2;
                end
                3'd1: begin
                    next_mode3state = 5'd8;
                    next_mode3dir = 2'd0;
                end
                3'd2: begin
                    next_mode3state = 5'd9;
                    next_mode3dir = 2'd2;
                end
                3'd3: begin
                    next_mode3state = 5'd12;
                    next_mode3dir = 2'd0;
                end
                3'd4: begin
                    next_mode3state = 5'd13;
                    next_mode3dir = 2'd2;
                end
                3'd5: begin
                    next_mode3state = 5'd16;
                    next_mode3dir = 2'd0;
                end
                default: begin
                    next_mode3state = 5'd1;
                    next_mode3dir = 2'd2;
                end
            endcase
        end
        5'd1: begin //x0 time_01
            if(time_01) next_mode3state = (mode3dir==2'd0 ? 5'd0 : mode3state + 1'b1);
            else next_mode3state = mode3state;
        end
        5'd2: next_mode3state = (time_01 ? mode3state + mode3dir - 1'b1 : mode3state); //x1
        5'd3: next_mode3state = (time_01 ? mode3state + mode3dir - 1'b1 : mode3state); //x2
        5'd4: next_mode3state = (time_01 ? mode3state + mode3dir - 1'b1 : mode3state); //x3
        5'd5: next_mode3state = (time_01 ? mode3state + mode3dir - 1'b1 : mode3state); //x4
        5'd6: next_mode3state = (time_01 ? mode3state + mode3dir - 1'b1 : mode3state); //x5
        5'd7: next_mode3state = (time_01 ? mode3state + mode3dir - 1'b1 : mode3state); //x6
        5'd8: begin //x7
            if(time_01) next_mode3state = (mode3dir==2'd2 ? 5'd0 : mode3state - 1'b1);
            else next_mode3state = mode3state;
        end
        5'd9: begin //y0
            if(time_01) next_mode3state = (mode3dir==2'd0 ? 5'd0 : mode3state + 1'b1);
            else next_mode3state = mode3state;
        end
        5'd10: next_mode3state = (time_01 ? mode3state + mode3dir - 1'b1 : mode3state); //y1
        5'd11: next_mode3state = (time_01 ? mode3state + mode3dir - 1'b1 : mode3state); //y2
        5'd12: begin //y3
            if(time_01) next_mode3state = (mode3dir==2'd2 ? 5'd0 : mode3state - 1'b1);
            else next_mode3state = mode3state;
        end
        5'd13: begin //z0
            if(time_01) next_mode3state = (mode3dir==2'd0 ? 5'd0 : mode3state + 1'b1);
            else next_mode3state = mode3state;
        end
        5'd14: next_mode3state = (time_01 ? mode3state + mode3dir - 1'b1 : mode3state); //z1
        5'd15: next_mode3state = (time_01 ? mode3state + mode3dir - 1'b1 : mode3state); //z2
        5'd16: begin //z3
            if(time_01) next_mode3state = (mode3dir==2'd2 ? 5'd0 : mode3state - 1'b1);
            else next_mode3state = mode3state;
        end
        default: next_mode3state = 3'd0;
    endcase
end

//mode2state
always @(*) begin
    case(mode2state)
        3'd0: next_mode2state = (voice > `voice_low && time_005) + mode2state;
        3'd1: next_mode2state = mode2state - (voice <= `voice_low && time_01) + (voice > `voice_mid && time_005);
        3'd2: next_mode2state = mode2state - (voice <= `voice_mid && time_01) + (voice > `voice_hmid  && time_005);
        3'd3: next_mode2state = mode2state - (voice <= `voice_hmid && time_01);
        default: next_mode2state = 3'd0;
    endcase
end

//mode2state2
always @(*) begin
    case(mode2state2)
        2'd0: next_mode2state2 = (mode2state==3'd3) + mode2state2;
        2'd1: next_mode2state2 = time_05 + mode2state2;
        2'd2: next_mode2state2 = time_01 + mode2state2;
        2'd3: next_mode2state2 = time_01 + mode2state2;
        default: next_mode2state2 = 0;
    endcase
end

//mode2GRB
always @(*) begin
    case(randcolor)
        5'd0: mode2GRB = `red;
        5'd1: mode2GRB = `ored;
        5'd2: mode2GRB = `oran;
        5'd3: mode2GRB = `yora;
        5'd4: mode2GRB = `yell;
        5'd5: mode2GRB = `ygre;
        5'd6: mode2GRB = `gree;
        5'd7: mode2GRB = `bgre;
        5'd8: mode2GRB = `blue;
        5'd9: mode2GRB = `bvio;
        5'd10:mode2GRB = `viol;
        5'd11:mode2GRB = `rvio;
        default: mode2GRB = `rvio;
    endcase
end

//mode1color
always @(*) begin
    if(time_3) next_mode1color = (mode1color==4'd11 ? 4'd0 : mode1color + 4'd1);
    else next_mode1color = mode1color;
end

//mode1GRB
always @(*) begin
    case(mode1color)
        4'd0: mode1GRB = `red;
        4'd1: mode1GRB = `ored; 
        4'd2: mode1GRB = `oran; 
        4'd3: mode1GRB = `yora;  
        4'd4: mode1GRB = `yell; 
        4'd5: mode1GRB = `ygre; 
        4'd6: mode1GRB = `gree; 
        4'd7: mode1GRB = `bgre;
        4'd8: mode1GRB = `blue;
        4'd9: mode1GRB = `bvio; 
        4'd10:mode1GRB = `viol; 
        4'd11:mode1GRB = `rvio; 
        default: mode1GRB = `red;
    endcase
end

//mode1x
always @(posedge clk) begin
    if(rst || mode!=3'd1) begin
        //y0
        mode1x[0][0][3] <= 0;
        mode1x[0][0][2] <= 0;
        mode1x[0][0][1] <= 0;
        mode1x[0][0][0] <= 0;
        //y1
        mode1x[0][1][3] <= 0;
        mode1x[0][1][2] <= 0;
        mode1x[0][1][1] <= 0;
        mode1x[0][1][0] <= 0;
        //y2
        mode1x[0][2][3] <= 0;
        mode1x[0][2][2] <= 0;
        mode1x[0][2][1] <= 0;
        mode1x[0][2][0] <= 0;
        //y3
        mode1x[0][3][3] <= 0;
        mode1x[0][3][2] <= 0;
        mode1x[0][3][1] <= 0;
        mode1x[0][3][0] <= 0;
    end
    else begin
        if(time_01) begin
            mode1x[0][0][3] <= mode1x[0][0][3] + (mode1dx[0][0][3] ? 1 : -1);
        end
        if(time_0099) begin
            mode1x[0][0][2] <= mode1x[0][0][2] + (mode1dx[0][0][2] ? 1 : -1);
            mode1x[0][1][3] <= mode1x[0][1][3] + (mode1dx[0][1][3] ? 1 : -1);
        end
        if(time_0098) begin
            mode1x[0][0][1] <= mode1x[0][0][1] + (mode1dx[0][0][1] ? 1 : -1);
            mode1x[0][1][2] <= mode1x[0][1][2] + (mode1dx[0][1][2] ? 1 : -1);
            mode1x[0][2][3] <= mode1x[0][2][3] + (mode1dx[0][2][3] ? 1 : -1);
        end
        if(time_0097) begin
            mode1x[0][0][0] <= mode1x[0][0][0] + (mode1dx[0][0][0] ? 1 : -1);
            mode1x[0][1][1] <= mode1x[0][1][1] + (mode1dx[0][1][1] ? 1 : -1);
            mode1x[0][2][2] <= mode1x[0][2][2] + (mode1dx[0][2][2] ? 1 : -1);
            mode1x[0][3][3] <= mode1x[0][3][3] + (mode1dx[0][3][3] ? 1 : -1);
        end
        if(time_0096) begin
            mode1x[0][1][0] <= mode1x[0][1][0] + (mode1dx[0][1][0] ? 1 : -1);
            mode1x[0][2][1] <= mode1x[0][2][1] + (mode1dx[0][2][1] ? 1 : -1);
            mode1x[0][3][2] <= mode1x[0][3][2] + (mode1dx[0][3][2] ? 1 : -1);
        end
        if(time_0095) begin
            mode1x[0][2][0] <= mode1x[0][2][0] + (mode1dx[0][2][0] ? 1 : -1);
            mode1x[0][3][1] <= mode1x[0][3][1] + (mode1dx[0][3][1] ? 1 : -1);
        end
        if(time_0094) begin
            mode1x[0][3][0] <= mode1x[0][3][0] + (mode1dx[0][3][0] ? 1 : -1);
        end
    end
end

//mode1dx
always @(posedge clk) begin
    //y0
    mode1dx[0][0][3] <= (mode1dx[0][0][3] && mode1x[0][0][3] != 3'd7) || mode1x[0][0][3] == 3'd0;
    mode1dx[0][0][2] <= (mode1dx[0][0][2] && mode1x[0][0][2] != 3'd7) || mode1x[0][0][2] == 3'd0;
    mode1dx[0][0][1] <= (mode1dx[0][0][1] && mode1x[0][0][1] != 3'd7) || mode1x[0][0][1] == 3'd0;
    mode1dx[0][0][0] <= (mode1dx[0][0][0] && mode1x[0][0][0] != 3'd7) || mode1x[0][0][0] == 3'd0;
    //y1
    mode1dx[0][1][3] <= (mode1dx[0][1][3] && mode1x[0][1][3] != 3'd7) || mode1x[0][1][3] == 3'd0;
    mode1dx[0][1][2] <= (mode1dx[0][1][2] && mode1x[0][1][2] != 3'd7) || mode1x[0][1][2] == 3'd0;
    mode1dx[0][1][1] <= (mode1dx[0][1][1] && mode1x[0][1][1] != 3'd7) || mode1x[0][1][1] == 3'd0;
    mode1dx[0][1][0] <= (mode1dx[0][1][0] && mode1x[0][1][0] != 3'd7) || mode1x[0][1][0] == 3'd0;
    //y2
    mode1dx[0][2][3] <= (mode1dx[0][2][3] && mode1x[0][2][3] != 3'd7) || mode1x[0][2][3] == 3'd0;
    mode1dx[0][2][2] <= (mode1dx[0][2][2] && mode1x[0][2][2] != 3'd7) || mode1x[0][2][2] == 3'd0; 
    mode1dx[0][2][1] <= (mode1dx[0][2][1] && mode1x[0][2][1] != 3'd7) || mode1x[0][2][1] == 3'd0;
    mode1dx[0][2][0] <= (mode1dx[0][2][0] && mode1x[0][2][0] != 3'd7) || mode1x[0][2][0] == 3'd0;
    //y3
    mode1dx[0][3][3] <= (mode1dx[0][3][3] && mode1x[0][3][3] != 3'd7) || mode1x[0][3][3] == 3'd0;
    mode1dx[0][3][2] <= (mode1dx[0][3][2] && mode1x[0][3][2] != 3'd7) || mode1x[0][3][2] == 3'd0;
    mode1dx[0][3][1] <= (mode1dx[0][3][1] && mode1x[0][3][1] != 3'd7) || mode1x[0][3][1] == 3'd0;
    mode1dx[0][3][0] <= (mode1dx[0][3][0] && mode1x[0][3][0] != 3'd7) || mode1x[0][3][0] == 3'd0;
end

//mode1y
always @(posedge clk) begin
    //y0
    mode1y[0][0][3] <= 0;
    mode1y[0][0][2] <= 0;
    mode1y[0][0][1] <= 0;
    mode1y[0][0][0] <= 0;
    //y1
    mode1y[0][1][3] <= 1;
    mode1y[0][1][2] <= 1;
    mode1y[0][1][1] <= 1;
    mode1y[0][1][0] <= 1;
    //y2 
    mode1y[0][2][3] <= 2;
    mode1y[0][2][2] <= 2;
    mode1y[0][2][1] <= 2;
    mode1y[0][2][0] <= 2;
    //y3
    mode1y[0][3][3] <= 3;
    mode1y[0][3][2] <= 3;
    mode1y[0][3][1] <= 3;
    mode1y[0][3][0] <= 3;
end

//mode1z
always @(posedge clk) begin
    //y0
    mode1z[0][0][3] <= 3;
    mode1z[0][0][2] <= 2;
    mode1z[0][0][1] <= 1;
    mode1z[0][0][0] <= 0;
    //y1z    
    mode1z[0][1][3] <= 3;
    mode1z[0][1][2] <= 2;
    mode1z[0][1][1] <= 1;
    mode1z[0][1][0] <= 0;
    //y2z    
    mode1z[0][2][3] <= 3;
    mode1z[0][2][2] <= 2;
    mode1z[0][2][1] <= 1;
    mode1z[0][2][0] <= 0;
    //y3
    mode1z[0][3][3] <= 3;
    mode1z[0][3][2] <= 2;
    mode1z[0][3][1] <= 1;
    mode1z[0][3][0] <= 0;
end

//mode0state
always @(*) begin
    case(mode0state)
        1'b0: next_mode0state = (voice > `voice_low && time_01);
        1'b1: next_mode0state = (voice <= `voice_low && time_01 ? 1'b0: 1'b1);
        default: next_mode0state = 1'b0;
    endcase
end

//mode7state
always @(*) begin
    if(mode==3'd7) next_mode7state = mode7state + time_005;
    else next_mode7state = 3'b0;
end

//GRB
always @(*) GRB = G[nx][ny][nz];

//start
always @(*) begin
    if(number == 7'd127 && done) next_start = 1'b0; //to RST
    else if(time_RST) next_start = 1'b1; //restart
    else next_start = start;
end

//number
always @(*) next_number = number + done;

endmodule