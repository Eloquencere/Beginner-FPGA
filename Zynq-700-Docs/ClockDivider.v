reg count = 0;
reg DividedClk = 0;
always @(posedge clk) 
begin: ClockDivider
    count <= count + 1;
    if(count[24:0])
    begin
        DividedClk <= ~DividedClk;
        count <= 0;
    end
end: ClockDivider
