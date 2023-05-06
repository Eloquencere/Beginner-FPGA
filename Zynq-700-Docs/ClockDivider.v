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
