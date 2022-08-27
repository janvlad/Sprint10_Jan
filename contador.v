module divisor_frequencia #(parameter inversor = 25)(CLK50M, CLK1);

	input CLK50M;
	output reg CLK1;

	reg[25:0] contador = 26'b0;

	always @(posedge CLK50M)
		begin
			contador = contador + 26'b1;
			CLK1 = (contador < inversor) ? 1'b0 : 1'b1;
			
			contador = (contador > inversor*2) ? 26'b0 : contador;
			
		end 
endmodule 