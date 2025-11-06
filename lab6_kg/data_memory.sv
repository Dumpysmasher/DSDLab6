module data_memory(
    input logic clk, rst,
    input logic [31:0] A,
    input logic [31:0] WD,
    input logic WE,
    input logic [7:0] prodeInd,
    output logic [31:0] RD,
    output logic [31:0] prode
);
    logic [31:0] mem [0:255];

    integer i;
    initial begin
        for (i = 0; i < 256; i = i + 1) begin
            mem[i] = i[31:0];
        end
    end

    assign RD = mem[A[7:0]];

    assign prode = mem[prodeInd];

        always @(posedge clk) begin
        if (WE) begin
            mem[A[7:0]] <= WD;
        end
    end
endmodule