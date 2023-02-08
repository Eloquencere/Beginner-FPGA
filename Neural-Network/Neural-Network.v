module Neural(sepal_len,petal_len,sepal_size,petal_size,setosa,versicolor,virginica);
input signed [15:0]sepal_len, petal_len, sepal_size, petal_size;
output reg setosa=0,versicolor=0,virginica=0;
wire signed [15:0]flwr_parametr[3:0];

wire signed [15:0]layer1_weights[3:0][7:0];
wire signed [7:0]layer1_bias[7:0];
reg signed [32:0]final_layer1_out[7:0];

// flwr_parameter defn//
assign flwr_parametr[0]=sepal_len;
assign flwr_parametr[1]=petal_len;
assign flwr_parametr[2]=sepal_size;
assign flwr_parametr[3]=petal_size;

/// layer1_weights defn begin ///
//layer1_weights row 1 defn
assign layer1_weights[0][0]=16'd3;
assign layer1_weights[0][1]=16'd2;
assign layer1_weights[0][2]=16'd123;
assign layer1_weights[0][3]=16'd115;
assign layer1_weights[0][4]=16'd103;
assign layer1_weights[0][5]=-16'd92;
assign layer1_weights[0][6]=16'd146;
assign layer1_weights[0][7]=16'd109;
//layer1_weights row 2 defn
assign layer1_weights[1][0]=16'd92;
assign layer1_weights[1][1]=16'd56;
assign layer1_weights[1][2]=16'd6;
assign layer1_weights[1][3]=16'd182;
assign layer1_weights[1][4]=-16'd1;
assign layer1_weights[1][5]=16'd65;
assign layer1_weights[1][6]=16'd77;
assign layer1_weights[1][7]=16'd337;
//layer1_weights row 3 defn
assign layer1_weights[2][0]=16'd161;
assign layer1_weights[2][1]=-16'd173;
assign layer1_weights[2][2]=16'd130;
assign layer1_weights[2][3]=16'd163;
assign layer1_weights[2][4]=16'd22;
assign layer1_weights[2][5]=-16'd146;
assign layer1_weights[2][6]=-16'd166;
assign layer1_weights[2][7]=-16'd208;
//layer1_weights row 4 defn
assign layer1_weights[3][0]=-16'd21;
assign layer1_weights[3][1]=-16'd6;
assign layer1_weights[3][2]=16'd81;
assign layer1_weights[3][3]=16'd254;
assign layer1_weights[3][4]=16'd86;
assign layer1_weights[3][5]=16'd148;
assign layer1_weights[3][6]=-16'd146;
assign layer1_weights[3][7]=-16'd345;
/// layer1_weights defn end ///

/// layer1_bias defn begin ///
assign layer1_bias[0]=-8'd39;
assign layer1_bias[1]=-8'd38;
assign layer1_bias[2]=8'd15;
assign layer1_bias[3]=-8'd29;
assign layer1_bias[4]=8'd12;
assign layer1_bias[5]=8'd0;
assign layer1_bias[6]=8'd80;
assign layer1_bias[7]=8'd225;
/// layer1_bias defn end ///

// layer1 Multiplication and adding bias and relu1
integer i,j;
always @*
begin
    for(i=0;i<8;i=i+1) // make 2 for loops & assign the flower parameter just before one of the for loops
    begin
        final_layer1_out[i]=layer1_bias[i]; //adding bias
        for(j=0;j<4;j=j+1)
        begin
            final_layer1_out[i] = final_layer1_out[i] + flwr_parametr[j]*layer1_weights[j][i];
        end
        if(final_layer1_out[i][32])
            final_layer1_out[i]=0;
    end
end

wire signed [15:0]layer2_weights[7:0][2:0];
wire signed [7:0]layer2_bias[2:0];
reg signed [32:0]final_layer2_out[2:0];

/// layer2_weights defn begin ///
//layer2_weights row 1 defn
assign layer2_weights[0][0]=-16'd69;
assign layer2_weights[0][1]=-16'd104;
assign layer2_weights[0][2]=16'd195;
//layer2_weights row 2 defn
assign layer2_weights[1][0]=-16'd144;
assign layer2_weights[1][1]=16'd148;
assign layer2_weights[1][2]=16'd50;
//layer2_weights row 3 defn
assign layer2_weights[2][0]=-16'd219;
assign layer2_weights[2][1]=16'd143;
assign layer2_weights[2][2]=-16'd71;
//layer2_weights row 4 defn
assign layer2_weights[3][0]=16'd76;
assign layer2_weights[3][1]=-16'd12;
assign layer2_weights[3][2]=16'd181;
//layer2_weights row 5 defn
assign layer2_weights[4][0]=-16'd208;
assign layer2_weights[4][1]=16'd87;
assign layer2_weights[4][2]=-16'd84;
//layer2_weights row 6 defn
assign layer2_weights[5][0]=16'd104;
assign layer2_weights[5][1]=-16'd109;
assign layer2_weights[5][2]=-16'd122;
//layer2_weights row 7 defn
assign layer2_weights[6][0]=16'd339;
assign layer2_weights[6][1]=16'd195;
assign layer2_weights[6][2]=-16'd199;
//layer2_weights row 8 defn
assign layer2_weights[7][0]=16'd433;
assign layer2_weights[7][1]=16'd86;
assign layer2_weights[7][2]=-16'd535;
/// layer2_weights defn end ///

/// layer2_bias defn begin ///
assign layer2_bias[0]=8'd52;
assign layer2_bias[1]=8'd21;
assign layer2_bias[2]=-8'd49;
/// layer2_bias defn end ///

// layer2 Multiplication and adding bias and relu2
always @*
begin
    for(i=0;i<3;i=i+1)
    begin
        final_layer2_out[i]=layer2_bias[i];//adding bias
        for(j=0;j<8;j=j+1)
        begin
            final_layer2_out[i]=final_layer2_out[i]+(final_layer1_out[j]*layer2_weights[j][i]);
        end 
        if(final_layer2_out[i][32])
            final_layer2_out[i]=0;
    end
end

//display
always @*
begin
    if(final_layer2_out[0]>final_layer2_out[1] & final_layer2_out[0]>final_layer2_out[2])
        setosa=1;
    else if (final_layer2_out[1]>final_layer2_out[0] & final_layer2_out[0]>final_layer2_out[2])
        versicolor=1;
    else if (final_layer2_out[2]>final_layer2_out[1] & final_layer2_out[2]>final_layer2_out[0])
        virginica=1;
end
endmodule