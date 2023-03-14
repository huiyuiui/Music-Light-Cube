module To_number(
    input [2:0] x,
    input [2:0] y,
    input [2:0] z,
    output [6:0] number
);

assign number = x*16+y*4+z;
endmodule