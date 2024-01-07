`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.01.2024 13:00:53
// Design Name: 
// Module Name: lfsr
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


module LFSR
(
    input clk,
    input rst,
    output logic [7:0] lfsr_out
);
    always @(posedge clk)
    begin
        if(rst)
            lfsr_out <= '1;
        else
            lfsr_out <= {lfsr_out, lfsr_out[1]^lfsr_out[0]} << 1;
    end
endmodule
