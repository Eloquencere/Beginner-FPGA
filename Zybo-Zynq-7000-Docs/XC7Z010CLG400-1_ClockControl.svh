`timescale 1ns / 1ps // Smallest period possible / Considering other delays

// forever #8 masterClk = ~masterClk

module ClockDivider
#(
    parameter division = 1
)
(   
    input bit masterClock, 
    output bit dividedClock
);
    localparam targetCount = (division >> 1) - 1; // targetCount only for half of the period
    
    int count = 0;
    
    always_ff @(posedge masterClock)
    begin
        if(count == targetCount)
        begin
            count <= 1'b0;
            dividedClock <= ~dividedClock;
        end
        else count <= count + 1;
    end
endmodule
