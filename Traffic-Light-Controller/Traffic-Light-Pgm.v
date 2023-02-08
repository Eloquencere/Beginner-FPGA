//Delay Definition begin
`define R2Y 3
`define R2G 2
//Delay Definition end

// Colours definition begin
`define RED 2'd0
`define YELLOW 2'd1
`define GREEN 2'd2
// Colours definition end

module TrafficL(X,rst,clk,cntry,hghwy);
    input X,rst,clk;
    output reg [2:0] cntry, hghwy;

    parameter S0 =3'd0, S1= 3'd1, S2=3'd2, S3=3'd3, S4=3'd4;
    reg [2:0]Current_State, Next_State;

    always @(posedge clk)
    begin
        if(rst)
            Current_State = S0;
        else
            Current_State = Next_State;
    end
    
    always @(posedge clk)
    begin
        case(Current_State)
            S0:
            begin
                cntry =`RED;
                hghwy =`GREEN;
                if(X)
                    Next_State = S1;
                else
                    Next_State = S0;
            end
            S1:
            begin
                cntry =`RED;
                hghwy =`YELLOW;
                repeat (`R2Y) @(posedge clk); 
                Next_State = S2;
            end
            S2:
            begin
                cntry =`RED;
                hghwy = `RED;
                repeat (`R2G) @(posedge clk);
                Next_State = S3;
            end
            S3:
            begin
                cntry = `GREEN;
                hghwy = `RED;
                if(X)
                    Next_State = S3;
                else
                    Next_State = S4;
            end
            S4:
            begin
                cntry = `YELLOW;
                hghwy = `RED;
                repeat (`R2Y) @(posedge clk);
                Next_State = S0;
            end
        endcase
    end
endmodule