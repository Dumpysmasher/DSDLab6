`timescale 1ns/1ps

module top_tb();

    logic clk;
    logic rst;
    logic [7:0] led;

    // Instantiate DUT
    top uut(
        .clk(clk),
        .rst(rst),
        .led(led)
    );

    // Clock generator: 100 MHz -> 10 ns period
    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        $display("Starting simulation...");
        rst = 1;
        #20;
        rst = 0;
        #200;
        $display("led = %0h", led);
        // run a bit longer to see changes
        #1000;
        $display("Finished, led = %0h", led);
        $finish;
    end

endmodule
