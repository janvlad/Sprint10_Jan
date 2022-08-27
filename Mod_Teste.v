`default_nettype none //Comando para desabilitar declaração automática de wires
module Mod_Teste (
//Clocks
input CLOCK_27, CLOCK_50,
//Chaves e Botoes
input [3:0] KEY,
input [17:0] SW,
//Displays de 7 seg e LEDs
output [0:6] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7,
output [8:0] LEDG,
output [17:0] LEDR,
//Serial
output UART_TXD,
input UART_RXD,
inout [7:0] LCD_DATA,
output LCD_ON, LCD_BLON, LCD_RW, LCD_EN, LCD_RS,
//GPIO
inout [35:0] GPIO_0, GPIO_1
);
assign GPIO_1 = 36'hzzzzzzzzz;
assign GPIO_0 = 36'hzzzzzzzzz;
assign LCD_ON = 1'b1;
assign LCD_BLON = 1'b1;
wire [7:0] w_d0x0, w_d0x1, w_d0x2, w_d0x3, w_d0x4, w_d0x5,
w_d1x0, w_d1x1, w_d1x2, w_d1x3, w_d1x4, w_d1x5;
LCD_TEST MyLCD (
.iCLK ( CLOCK_50 ),
.iRST_N ( KEY[0] ),
.d0x0(w_d0x0),.d0x1(w_d0x1),.d0x2(w_d0x2),.d0x3(w_d0x3),.d0x4(w_d0x4),.d0x5(w_d0x5),
.d1x0(w_d1x0),.d1x1(w_d1x1),.d1x2(w_d1x2),.d1x3(w_d1x3),.d1x4(w_d1x4),.d1x5(w_d1x5),
.LCD_DATA( LCD_DATA ),
.LCD_RW ( LCD_RW ),
.LCD_EN ( LCD_EN ),
.LCD_RS ( LCD_RS )
);
//---------- modifique a partir daqui --------

wire w_ULASrc, w_RegWrite, w_RegDst, w_MemtoReg, w_MemWrite, w_PCSrc, w_Jump, w_Branch, w_Z, w_We, clk_1K, w_Jal, w_RegtoPC;
wire [2:0]w_ULAControl;
wire [4:0]w_wa3, w_wa3A;
wire [7:0]w_PCp1, w_PC, w_rd1SrcA, w_ULAResultWd3, w_wd3, w_RData, w_m1, w_nPC, w_PCBranch, w_RegData, w_DataOut, w_DataIn, w_wd3D, w_ImPC;
wire [15:0]w_rd2, w_SrcB;
wire [31:0]w_Inst, w_q;
wire w_Interrup, w_clk;

parameter divider = 26'd500;

freq_divider (.clk(CLOCK_50), .divider(divider), .clk_out(clk_1K));

RomInstMem RomMemv02 (.address(w_PC), .clock(CLOCK_50), .q(w_q));

RamDataMem RamMemv02 (.address(w_ULAResultWd3), .clock(CLOCK_50), .data(w_rd2), .wren(w_We), .q(w_RData));

ControlUnit CUv03 (.OP(w_Inst[31:26]), .Funct(w_Inst[5:0]), .Jump(w_Jump), .Jal(w_Jal), .MemtoReg(w_MemtoReg), .MemWrite(w_MemWrite), .Branch(w_Branch), .ULASrc(w_ULASrc), .RegDst(w_RegDst), .RegWrite(w_RegWrite), .RegtoPC(w_RegtoPC), .ULAControl(w_ULAControl));

RegisterFile RFv02 (.wd3(w_wd3), .wa3(w_wa3), .ra1(w_Inst[25:21]), .ra2(w_Inst[20:16]), .we3(w_RegWrite), .clk(w_clk), .rd1(w_rd1SrcA), .rd2(w_rd2), .S0(w_d0x0), .S1(w_d0x1), .S2(w_d0x2), .S3(w_d0x3), .S4(w_d1x0), .S5(w_d1x1), .S6(w_d1x2), .S7(w_d1x3));

ULA ULAv03 (.SrcA(w_rd1SrcA), .SrcB(w_SrcB), .control(w_ULAControl), .result(w_ULAResultWd3), .Z(w_Z));

RegPC RPCv03 (.PCin(w_nPC), .clk(w_clk), .PC(w_PC));

Par_IN P_INv1 (.MemData(w_RData), .Address(w_ULAResultWd3), .DataIn(w_DataIn), .RegData(w_RegData));

Par_OUT P_OUTv1 (.RegData(w_rd2), .Address(w_ULAResultWd3), .clk(w_clk), .we(w_MemWrite), .DataOut(w_DataOut));

assign w_SrcB = w_ULASrc ? w_Inst[15:0] : {8'd0, w_rd2};
assign w_wa3A = w_RegDst ? w_Inst[15:11] : w_Inst[20:16];
assign w_wd3D = w_MemtoReg ? w_RegData : w_ULAResultWd3;
assign w_nPC = w_Jump ? w_ImPC : w_m1;
assign w_m1 = w_PCSrc ? w_PCBranch : w_PCp1;
assign w_wd3 = w_Jal ? w_PCp1 : w_wd3D;
assign w_wa3 = w_Jal ? 3'd15 : w_wa3A;
assign w_Inst = w_Interrup ? 32'b_000011_00000_00000_00011_111010 : w_q;
assign w_ImPC = w_RegtoPC ? w_rd1SrcA : w_Inst[7:0];

assign w_PCSrc = w_Branch & w_Z;
assign w_PCp1 = w_PC + 1;
assign w_PCBranch = w_PCp1 + w_Inst[7:0];
assign w_d0x4 = w_PC;

assign LEDR[6:4] = w_ULAControl;
assign LEDR[7] = w_ULASrc;
assign LEDR[8] = w_RegDst;
assign LEDR[9] = w_RegWrite;
assign LEDR[0] = w_DataOut[0];
assign w_DataIn = SW[7:0];
assign w_Interrup = SW[15];
assign w_clk = clk_1K;

endmodule



