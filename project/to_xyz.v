module To_xyz(
    input [6:0] number,
    output [2:0] x,
    output [2:0] y,
    output [2:0] z
);

assign x = (number>>3'd4); //number/16
assign y = ((number>>3'd2)&2'b11); //（number/4)%4
assign z = (number&2'b11); //number%4
endmodule