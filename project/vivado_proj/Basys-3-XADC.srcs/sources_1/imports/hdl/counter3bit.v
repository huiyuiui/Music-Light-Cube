module counter3bit (
    input clk,
    input rst,
    output reg [2:0] Q
    );
 
 //在此的clk為每20000個原始clk才為一週期
 //Q會隨著clk一直從0加到7, 溢位後重新計算
always @ (posedge(clk))   // When will Always Block Be Triggered
begin
    if (rst == 3'b111)
        // How Output reacts when Reset Is Asserted
        Q <= 3'b0;
    else
        // How Output reacts when Rising Edge of Clock Arrives?
        Q <= Q + 1'b1;
end
 
endmodule
