module mux_regdst(
    input  logic       RegDst,   // 0: rt, 1: rd
    input  logic [4:0] rt,
    input  logic [4:0] rd,
    output logic [4:0] RegDst_out
);
    always_comb begin
        RegDst_out = RegDst ? rd : rt;
    end
endmodule
