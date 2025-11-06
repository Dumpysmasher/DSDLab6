module mux_memtoreg(
    input  logic        MemtoReg,     // 0: ALUResult, 1: RD
    input  logic [31:0] ALUResult,
    input  logic [31:0] RD,           // from data memory
    output logic [31:0] MemtoReg_out
);
    always_comb begin
        MemtoReg_out = MemtoReg ? RD : ALUResult;
    end
endmodule
