module top(
    input  logic clk,
    input  logic rst,
    output logic [7:0] led
);

    // Simple 8-bit counter — synthesizable
    always_ff @(posedge clk or posedge rst) begin
        if (rst)
            led <= 8'h00;
        else
            led <= led + 1'b1;
    end

endmodule
