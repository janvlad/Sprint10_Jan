module ULA (input [7:0]SrcA, input [15:0]SrcB, input [2:0]control, output reg [7:0]result, output Z);

  assign Z = result ? 0 : 1;
  
  always @ (*) 
    
    begin
    
      case(control)

        1'd0: result = SrcA & SrcB[7:0];
        1'd1: result = SrcA | SrcB[7:0];
        3'd2: result = SrcA + SrcB[7:0];
		  3'd3: result = SrcA >> SrcB[10:6];
        3'd6: result = SrcA + ~(SrcB[7:0]) + 1;
        3'd7: result = (SrcA < SrcB[7:0]) ? 1 : 0;
		endcase
		
    end
    
endmodule 