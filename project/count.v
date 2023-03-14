module COUNT #(parameter t = 2)(
    input clk,
    input rst,
    output out
);

reg [34:0] count, next_count;

always@(posedge clk) count <= (rst ? 35'd1 : next_count);

always @(*) next_count = (count==t ? 35'd1 : count+1'b1);

assign out = (count==t);

endmodule