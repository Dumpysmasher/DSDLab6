module mux_alusrc(
    input  logic        ALUSrc,     // 0: RD2, 1: SignImm
    input  logic [31:0] RD2,
    input  logic [31:0] SignImm,
    output logic [31:0] ALUSrc_out
);
    always_comb begin
        ALUSrc_out = ALUSrc ? SignImm : RD2;
    end
endmodule
