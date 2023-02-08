module FPGA(led1,led2,rst,clk);
input rst,clk;
output led1,led2;

integer count;
reg leda;

always @(posedge clk or negedge rst)
begin
	if(!rst)
	begin
		count<=0; //counter to keep track
		leda<=0; //actual blinking LED
	end
	else
	begin
		count<=count+1;
		if(count>=5000000)
		begin
			leda<=~leda;
			count<=0;
		end
	end
end
assign led1=leda;
assign led2=rst;

endmodule