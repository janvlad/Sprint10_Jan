module contadorMOD10 (CLK, reset, saida);

	input CLK;
	input reset;
	
	output reg [3:0]saida;
	
	reg [3:0]contador = 4'b0;
	
	always @(posedge CLK)
		begin
			contador = contador + 4'b1;
			contador = (contador > 9) || (reset == 0) ? 4'b0 : contador;
			
			saida = contador;
		end
endmodule 
