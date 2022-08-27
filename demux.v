module demux (input [127:0]regOut, input [3:0]ra, output [7:0]muxOut);

  assign muxOut = (ra == 3'd0) ? 8'b0 : 
  (ra == 3'd1) ? regOut[15:8] : 
  (ra == 3'd2) ? regOut[23:16] : 
  (ra == 3'd3) ? regOut[31:24] : 
  (ra == 3'd4) ? regOut[39:32] : 
  (ra == 3'd5) ? regOut[47:40] : 
  (ra == 3'd6) ? regOut[55:48] : 
  (ra == 3'd7) ? regOut[63:56] :
  (ra == 3'd8) ? regOut[71:64] : 
  (ra == 3'd9) ? regOut[79:72] : 
  (ra == 3'd10) ? regOut[87:80] : 
  (ra == 3'd11) ? regOut[95:88] : 
  (ra == 3'd12) ? regOut[103:96] : 
  (ra == 3'd13) ? regOut[111:104] : 
  (ra == 3'd14) ? regOut[119:112] : 
  (ra == 3'd15) ? regOut[127:120] :  0;
  
endmodule