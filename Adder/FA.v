`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.05.2023 15:58:32
// Design Name: 
// Module Name: Adder
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


module FA1bit(sum,cout,a,b,cin);
    output sum,cout;
    input a,b,cin;
    wire w1,w2,w3;
HA1bit M1(w1,w2,a,b);
HA1bit M2(sum,w3,w1,cin);
or M3(cout,w2,w3);
endmodule

module HA1bit(sum,cout,a,b);
    output sum,cout;
    input a,b;
xor(sum,a,b);
and (cout,a,b);
endmodule
