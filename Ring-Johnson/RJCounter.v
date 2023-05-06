`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.05.2023 17:38:15
// Design Name: 
// Module Name: RJCounter
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


module RJCounter(clk, rst, mode, Q);
    input clk, rst, mode;
    output reg [3:0]Q;

    integer count = 0;
    reg DividedClk = 0;
    always @(posedge clk) 
    begin: ClockDivider
        count <= count + 1;
        if(count == 50_000_000)
        begin
            DividedClk <= ~DividedClk;
            count <= 0;
        end
    end: ClockDivider

    always @(posedge DividedClk)
    begin
        if(rst)
            Q <= 4'd8;
        else
            if(mode) // Johnson
                Q <= {~Q[0], Q} >> 1;
            else // ring
                Q <= {Q[0], Q} >> 1;
    end
endmodule
