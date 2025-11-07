`timescale 1ns/1ps

module top_tb();

    logic clk;
    logic rst;
    logic [1:0] sw;

    logic [31:0] ALUResult;
    logic [31:0] RD1, RD2;
    logic [31:0] prode_register_file;
    logic [31:0] prode_data_memory;
    logic [6:0]  display_led;

    // Instantiate DUT
    top uut(
        .clk(clk), .rst(rst), .sw(sw),
        .ALUResult(ALUResult), .RD1(RD1), .RD2(RD2),
        .prode_register_file(prode_register_file),
        .prode_data_memory(prode_data_memory),
        .display_led(display_led)
    );

    // Clock generator: 100 MHz -> 10 ns period
    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        $display("Starting I-type LW/SW simulation...");
        sw  = 2'd0;
        rst = 1;
        repeat (3) @(posedge clk);
        rst = 0;

        // Test LW: load DM[5] -> RF[1]
        sw = 2'd1; // select LW instruction
        @(posedge clk); // writeback occurs here
        #1; // small delay for visibility
        $display("After LW: RF[1] = %0d (expect 5)", prode_register_file);
        if (prode_register_file !== 32'd5) begin
            $error("LW failed: RF[1]=%0d, expected 5", prode_register_file);
            $fatal;
        end

        // Test SW: store RF[2] (init=2) -> DM[2]
        sw = 2'd2; // select SW instruction
        @(posedge clk); // memory write occurs here
        #1;
        $display("After SW: DM[2] = %0d (expect 2)", prode_data_memory);
        if (prode_data_memory !== 32'd2) begin
            $error("SW failed: DM[2]=%0d, expected 2", prode_data_memory);
            $fatal;
        end

        $display("Simulation PASSED.");
        $finish;
    end

endmodule
