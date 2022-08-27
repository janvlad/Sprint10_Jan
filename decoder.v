module decoder (input [2:0]Nbit, output [7:0]Ndecimal);
  
  assign Ndecimal[0] = (Nbit == 3'b000) ? 1 : 0;
  assign Ndecimal[1] = (Nbit == 3'b001) ? 1 : 0;
  assign Ndecimal[2] = (Nbit == 3'b010) ? 1 : 0;
  assign Ndecimal[3] = (Nbit == 3'b011) ? 1 : 0;
  assign Ndecimal[4] = (Nbit == 3'b100) ? 1 : 0;
  assign Ndecimal[5] = (Nbit == 3'b101) ? 1 : 0;
  assign Ndecimal[6] = (Nbit == 3'b110) ? 1 : 0;
  assign Ndecimal[7] = (Nbit == 3'b111) ? 1 : 0;
  
endmodule