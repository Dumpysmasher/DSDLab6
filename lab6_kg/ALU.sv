module ALU (
    input  logic [31:0] SrcA, SrcB,
    input  logic [2:0]  ALUControl,
    output logic [31:0] ALUResult
);
    always_comb begin
        unique case (ALUControl)
            3'b010: ALUResult = SrcA + SrcB;   // ADD
            3'b110: ALUResult = SrcA - SrcB;   // SUB
            default: ALUResult = '0;
        endcase
    end
endmodule
