module sign_extend(
    input  logic [15:0] imm16,
    output logic [31:0] signimm
);
    always_comb begin
        signimm = {{16{imm16[15]}}, imm16};
    end
endmodule
