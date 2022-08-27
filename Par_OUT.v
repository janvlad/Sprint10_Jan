module Par_OUT (input [7:0]RegData, Address, input clk, we, output reg [7:0]DataOut, output wren);

	wire fioA, fioB;
	
	assign fioA = (Address == 8'hFF) ? 1 : 0;
	assign fioB = we & fioA;
	assign wren = we & (~fioA);
	
	always @ (posedge clk) begin
		DataOut = fioB ? RegData : DataOut;
	end
endmodule 