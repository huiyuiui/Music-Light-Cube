module Shift_Led(
    input [1535:0] led, //64*24 = 1536
    input [5:0] number, //2^6 = 64
    input [1:0] dx, //2^2 = 4
    input [1:0] dy,
    input [1:0] dz,
    output [1535:0] out
);

parameter GRB_black = 24'h000000; 
reg GRB_number;
wire [1:0] x, y, z;
wire [5:0] shift_number;

To_xyz to_xzy(number, x, y, z);
To_number to_number(x+dx, y+dy, z+dz, shift_number);

always @(*) begin
//    GRB_number = led[number*24+23:number*24];
//    out = led;
//    out[number*24+23:number*24] = GRB_black;
//    out[shift_number*24+23:shift_number*24] = GRB_number;
end

endmodule