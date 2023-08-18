`timescale 1ns / 1ps // Smallest period possible / Considering other delays

module ClockDivider #(parameter int MasterPeriod = 8/*ns*/, int Division = 1)(input bit MasterClock, output bit DividedClock);
    parameter int TargetCount = Division*MasterPeriod;
    
    int count;
    always @(posedge MasterClock)
    begin
        count++;
        if(count == TargetCount)
        begin
            DividedClock <= ~DividedClock;
            count <= 0;
        end
    end
endmodule