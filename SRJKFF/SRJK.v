`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.05.2023 16:45:24
// Design Name: 
// Module Name: SRJK
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


module SRJK(clk , S, R, rst, switch, SRQ, SRQB, ClkDisp);
    input clk , S, R, rst, switch;
    output SRQB, ClkDisp;
    output reg SRQ;

    assign ClkDisp = DividedClk;
    assign SRQB = ~SRQ;

    integer count = 0;
    reg DividedClk = 0;
    always @(posedge clk) 
    begin: ClockDivider
        count <= count + 1;
        if(count == 70_000_000)
        begin
            DividedClk <= ~DividedClk;
            count <= 0;
        end
    end: ClockDivider

    always @ (posedge DividedClk)
    begin
        if(rst)
            SRQ <= 1'b0;
        else
        begin
            case ({S,R})
            2'b00: SRQ <=SRQ;
            2'b01: SRQ <= 1'b0;
            2'b10: SRQ <= 1'b1;
            2'b11: begin if(switch) SRQ <= 1'bx; else SRQ <= ~SRQ; end
            endcase
        end
    end
endmodule
