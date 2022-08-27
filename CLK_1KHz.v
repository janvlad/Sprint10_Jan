module freq_divider(input clk, input [25:0] divider, output reg clk_out);

	reg[25:0] count = 26'd0;

	always @ (posedge clk) begin
		count <= count + 26'd1;
		clk_out = (count > (divider/2)) ? 1'b0 : 1'b1;

		if(count > (divider-1))
			count <= 26'd0;
	end

endmodule