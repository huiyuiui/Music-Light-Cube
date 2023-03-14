module PWM(
    input clk,
	input rst,
    input [23:0] GRB,
    input start,
    output done,
	output reg pwm
);
//clk 100MHz
parameter T0H = 8'd30; //300ns*100MHz
parameter T0L = 8'd100; //1000ns*100MHz
parameter T1H = 8'd100; //1000ns*100MHz

reg [7:0] cnt, next_cnt; //one cycle: T0H + T0L
reg [4:0] bit, next_bit; //GRB 24bit
reg next_pwm;

always @(posedge clk) begin
    if(rst) begin
        cnt <= 8'd1;
        bit <= 5'd0;
        pwm <= 1'b0;
    end
    else begin
        cnt <= next_cnt;
        bit <= next_bit;
        pwm <= next_pwm;
    end
end

//cnt
always @(*) begin 
    if(start==1'b0) next_cnt = 8'd1;
    else next_cnt = (cnt == T0H + T0L ? 8'd1 : cnt+1'b1);
end

//bit
always @(*) begin
    if(cnt == T0H + T0L) next_bit = (bit==5'd23 ? 5'd0 : bit+1'b1);
    else next_bit = bit;
end

//done
assign done = start & (bit == 5'd23) & (cnt == T0H + T0L);

//pwm 
always @(*) begin
    if(!start) next_pwm = 1'b0;
    else 
        if(GRB[23-bit] == 1'b0) next_pwm = (cnt <= T0H); //0 Hight Power
        else next_pwm = (cnt <= T1H); //1 Hight Power
end

endmodule