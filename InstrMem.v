module InstrMem (input [7:0]A, output reg [31:0]RD);
  
  always @ (*) begin
    
    case(A) 
      
      8'd0: RD = 32'b_001000_00000_00001_00000_00000_000011;
      8'd1: RD = 32'b_001000_00000_00010_00000_00000_001001;
      8'd2: RD = 32'b_000000_00001_00010_00010_00000_100000;
      8'd3: RD = 32'b_000000_00001_00010_00011_00000_100100;
      8'd4: RD = 32'b_000000_00001_00010_00100_00000_100101;
    endcase
  end
  
endmodule