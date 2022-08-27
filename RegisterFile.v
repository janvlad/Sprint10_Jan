module RegisterFile (
  input [7:0]wd3,
  input [3:0]wa3, ra1, ra2,
  input we3,
  input clk,
  
  output [7:0]rd1, rd2, S0, S1, S2, S3, S4, S5, S6, S7
);
  
  wire [15:0]decOut;
  wire [127:0]regOut;
  
  decoder decod (.Nbit(wa3), .Ndecimal(decOut));
  
  registrador reg1 (.dataIn(wd3), .clk(clk), .load(decOut[0] & we3), .dataOut(regOut[7:0]));
  registrador reg2 (.dataIn(wd3), .clk(clk), .load(decOut[1] & we3), .dataOut(regOut[15:8]));
  registrador reg3 (.dataIn(wd3), .clk(clk), .load(decOut[2] & we3), .dataOut(regOut[23:16]));
  registrador reg4 (.dataIn(wd3), .clk(clk), .load(decOut[3] & we3), .dataOut(regOut[31:24]));
  registrador reg5 (.dataIn(wd3), .clk(clk), .load(decOut[4] & we3), .dataOut(regOut[39:32]));
  registrador reg6 (.dataIn(wd3), .clk(clk), .load(decOut[5] & we3), .dataOut(regOut[47:40]));
  registrador reg7 (.dataIn(wd3), .clk(clk), .load(decOut[6] & we3), .dataOut(regOut[55:48]));
  registrador reg8 (.dataIn(wd3), .clk(clk), .load(decOut[7] & we3), .dataOut(regOut[63:56]));
  registrador reg9 (.dataIn(wd3), .clk(clk), .load(decOut[8] & we3), .dataOut(regOut[71:64]));
  registrador reg10 (.dataIn(wd3), .clk(clk), .load(decOut[9] & we3), .dataOut(regOut[79:72]));
  registrador reg11 (.dataIn(wd3), .clk(clk), .load(decOut[10] & we3), .dataOut(regOut[87:80]));
  registrador reg12 (.dataIn(wd3), .clk(clk), .load(decOut[11] & we3), .dataOut(regOut[95:88]));
  registrador reg13 (.dataIn(wd3), .clk(clk), .load(decOut[12] & we3), .dataOut(regOut[103:96]));
  registrador reg14 (.dataIn(wd3), .clk(clk), .load(decOut[13] & we3), .dataOut(regOut[111:104]));
  registrador reg15 (.dataIn(wd3), .clk(clk), .load(decOut[14] & we3), .dataOut(regOut[119:112]));
  registrador reg16 (.dataIn(wd3), .clk(clk), .load(decOut[15] & we3), .dataOut(regOut[127:120]));
  
  demux dmx1 (.regOut(regOut), .ra(ra1), .muxOut(rd1));
  demux dmx2 (.regOut(regOut), .ra(ra2), .muxOut(rd2));
  
  assign S0 = regOut[7:0];
  assign S1 = regOut[15:8];
  assign S2 = regOut[23:16];
  assign S3 = regOut[31:24];
  assign S4 = regOut[39:32];
  assign S5 = regOut[47:40];
  assign S6 = regOut[55:48];
  assign S7 = regOut[63:56];
  
endmodule 