module LFSR(
    input clk,
    input rst,
    output reg [4:0] out
);

wire [4:0] next_out;
assign next_out = {out[0], out[4],  out[0] ^ out[3], out[2], out[1]};

always @(posedge clk) begin
    out <= (rst ? 5'd1 : next_out);
end

endmodule


