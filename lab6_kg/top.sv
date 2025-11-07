module top(
	input  logic        clk,
	input  logic        rst,
	input  logic [1:0]  sw,  // selects instruction: 1=LW example, 2=SW example
	output logic [31:0] ALUResult,             // observable for pre-lab
	output logic [31:0] RD1, RD2,              // RF read ports (visible)
	output logic [31:0] prode_register_file,   // RF[1] probe
	output logic [31:0] prode_data_memory,     // DM[2] probe
	output logic [6:0]  display_led            // in-lab (seven-seg segments)
);

	// I-type instruction examples from the lab handout
	// --- Board 512 (previous) ---
	// localparam logic [31:0] INST_LW = 32'b010101_00000_00001_0000_0000_0000_0101; // LW DM[5] -> RF[1]
	// localparam logic [31:0] INST_SW = 32'b010100_00000_00010_0000_0000_0000_0010; // SW RF[2] -> DM[2]

	// --- Board 860 (current) ---
	// LW: op=010101, rs=00000, rt=00001, imm=...1000 (8)  -- load DM[8] -> RF[1]
	localparam logic [31:0] INST_LW = 32'b010101_00000_00001_0000_0000_0000_1000;
	// SW: op=010100, rs=00000, rt=00000, imm=...0010 (2)  -- store RF[0] -> DM[2]
	localparam logic [31:0] INST_SW = 32'b010100_00000_00000_0000_0000_0000_0010;


	logic [31:0] instr;
	logic [7:0]  memProdeInd; // DM probe index (0..255)
	logic [4:0]  regProdeInd; // RF probe index (0..31)
	always_comb begin
		// defaults to avoid latches
		instr = 32'b0;
		memProdeInd = 8'd0;
		regProdeInd = 5'd0;
		unique case (sw)
			2'b01: begin 
				instr = INST_LW;
				// Board 860: observe DM[8] and RF[1]
				memProdeInd = 8'd8; // observe DM[8]
				regProdeInd = 5'd1; // observe RF[1]
			end
			2'b10: begin
				instr = INST_SW;
				// Board 860: observe DM[2] and RF[0]
				memProdeInd = 8'd2; // observe DM[2]
				regProdeInd = 5'd0; // observe RF[0]
			end
			default: /* NOP */ ;
		endcase
	end

	// Instruction fields
	logic [5:0]  op;
	logic [4:0]  rs, rt, rd;
	logic [15:0] imm;
	assign op  = instr[31:26];
	assign rs  = instr[25:21];
	assign rt  = instr[20:16];
	assign rd  = instr[15:11];
	assign imm = instr[15:0];

	// Control signals mapped from op: {RegDst, ALUSrc, ALUControl[2:0], MemtoReg}
	logic RegDst, ALUSrc;
	logic [2:0] ALUControl;
	logic MemtoReg;
	assign RegDst    = op[5];
	assign ALUSrc    = op[4];
	assign ALUControl= op[3:1];
	assign MemtoReg  = op[0];

	// For this lab's two ops: LW (MemtoReg=1) writes reg; SW (MemtoReg=0) writes memory
	logic RegWrite, MemWrite;
	assign RegWrite = MemtoReg;     // LW:1, SW:0
	assign MemWrite = ~MemtoReg;    // LW:0, SW:1

	// Datapath wires
	logic [31:0] SignImm;
	logic [4:0]  writeReg;
	logic [31:0] srcB;
	logic [31:0] memRD;
	logic [31:0] WD3;

	// Modules
	sign_extend u_se(
		.imm16(imm),
		.signimm(SignImm)
	);

	mux_regdst u_mux_regdst(
		.RegDst(RegDst), .rt(rt), .rd(rd), .RegDst_out(writeReg)
	);

	register_file u_rf(
		.clk(clk), .rst(rst), .WE3(RegWrite), .prodeInd(regProdeInd),
		.A1(rs), .A2(rt), .A3(writeReg),
		.WD3(WD3),
		.RD1(RD1), .RD2(RD2),
		.prode(prode_register_file)
	);

	mux_alusrc u_mux_alusrc(
		.ALUSrc(ALUSrc), .RD2(RD2), .SignImm(SignImm), .ALUSrc_out(srcB)
	);

	ALU u_alu(
		.SrcA(RD1), .SrcB(srcB), .ALUControl(ALUControl), .ALUResult(ALUResult)
	);

	data_memory u_dm(
		.clk(clk), .rst(rst),
		.A(ALUResult), .WD(RD2), .WE(MemWrite), .prodeInd(memProdeInd),
		.RD(memRD), .prode(prode_data_memory)
	);

	mux_memtoreg u_mux_m2r(
		.MemtoReg(MemtoReg), .ALUResult(ALUResult), .RD(memRD), .MemtoReg_out(WD3)
	);

	// Display: show RF[1] low hex digit
	display u_disp(
		.data_in(prode_register_file), .segments(display_led)
	);

endmodule



