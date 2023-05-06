`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.05.2023 18:18:14
// Design Name: 
// Module Name: UpDown
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


module UpDown(clk, rst, mode, Q);
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
            Q <= 4'b0;
        else
            if(mode)
                Q <= Q-1;
            else
                Q <= Q+1;
    end
endmodule
