module registrador (input [7:0]dataIn, input clk, load, output reg [7:0]dataOut);

  always @ (posedge clk) begin
    
    if(load == 1)
      dataOut = dataIn;
  end

endmodule 