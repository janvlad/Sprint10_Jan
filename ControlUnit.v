module ControlUnit (input [5:0]OP, Funct, output reg Jump, Jal, MemtoReg, MemWrite, Branch, ULASrc, RegDst, RegWrite, RegtoPC, output reg [2:0]ULAControl);

	always @ (*) begin
		
		case(OP)
			
			6'b100011: begin
				RegWrite = 1;
				RegDst = 0;
				ULASrc = 1;
				ULAControl = 3'b010;
				Branch = 0;
				MemWrite = 0;
				MemtoReg = 1;
				Jump = 0;
				Jal = 0;
				RegtoPC = 0;
			end
			6'b101011: begin
				RegWrite = 0;
				RegDst = 0;
				ULASrc = 1;
				ULAControl = 3'b010;
				Branch = 0;
				MemWrite = 1;
				MemtoReg = 0;
				Jump = 0;
				Jal = 0;
				RegtoPC = 0;
			end
			6'b000100: begin
				RegWrite = 0;
				RegDst = 0;
				ULASrc = 0;
				ULAControl = 3'b110;
				Branch = 1;
				MemWrite = 0;
				MemtoReg = 0;
				Jump = 0;
				Jal = 0;
				RegtoPC = 0;
			end
			6'b001000: begin
				RegWrite = 1;
				RegDst = 0;
				ULASrc = 1;
				ULAControl = 3'b010;
				Branch = 0;
				MemWrite = 0;
				MemtoReg = 0;
				Jump = 0;
				Jal = 0;
				RegtoPC = 0;
         end
			6'b000010: begin
				RegWrite = 0;
				RegDst = 0;
				ULASrc = 0;
				ULAControl = 3'b000;
				Branch = 0;
				MemWrite = 0;
				MemtoReg = 0;
				Jump = 1;
				Jal = 0;
				RegtoPC = 0;
			end
			6'b000011: begin
				RegWrite = 1;
				RegDst = 0;
				ULASrc = 0;
				ULAControl = 3'b000;
				Branch = 0;
				MemWrite = 0;
				MemtoReg = 0;
				Jump = 1;
				Jal = 1;
				RegtoPC = 0;
			end
			6'b000000: begin
				
				case(Funct)
					
					6'b100000: begin
						RegWrite = 1;
						RegDst = 1;
						ULASrc = 0;
						ULAControl = 3'b010;
						Branch = 0;
						MemWrite = 0;
						MemtoReg = 0;
						Jump = 0;
						Jal = 0;
						RegtoPC = 0;
					end
               6'b100010: begin
						RegWrite = 1;
						RegDst = 1;
						ULASrc = 0;
						ULAControl = 3'b110;
						Branch = 0;
						MemWrite = 0;
						MemtoReg = 0;
						Jump = 0;
						Jal = 0;
						RegtoPC = 0;
					end
               6'b100100: begin
						RegWrite = 1;
						RegDst = 1;
						ULASrc = 0;
						ULAControl = 3'b000;
						Branch = 0;
						MemWrite = 0;
						MemtoReg = 0;
						Jump = 0;	
						Jal = 0;
						RegtoPC = 0;
					end
               6'b100101: begin
						RegWrite = 1;
						RegDst = 1;
						ULASrc = 0;
						ULAControl = 3'b001;
						Branch = 0;
						MemWrite = 0;
						MemtoReg = 0;
						Jump = 0;	
						Jal = 0;
						RegtoPC = 0;
					end
               6'b101010: begin
						RegWrite = 1;
						RegDst = 1;
						ULASrc = 0;
						ULAControl = 3'b111;
						Branch = 0;
						MemWrite = 0;
						MemtoReg = 0;
						Jump = 0;	
						Jal = 0;
						RegtoPC = 0;
					end
					6'b000010: begin
						RegWrite = 1;
						RegDst = 1;
						ULASrc = 1;
						ULAControl = 3'b011;
						Branch = 0;
						MemWrite = 0;
						MemtoReg = 0;
						Jump = 0;
						Jal = 0;
						RegtoPC = 0;
					end
					6'b001000: begin
						RegWrite = 0;
						RegDst = 0;
						ULASrc = 0;
						ULAControl = 3'b000;
						Branch = 0;
						MemWrite = 0;
						MemtoReg = 0;
						Jump = 1;
						Jal = 0;
						RegtoPC = 1;
					end
				endcase
			end
		endcase
	end
              
endmodule