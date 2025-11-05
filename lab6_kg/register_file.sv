module register_file (
	input  logic        clk, rst, WE3,
	input  logic [4:0]  A1, A2, A3, 
	input  logic [31:0] WD3,
	output logic [31:0] RD1, RD2,
	output logic [31:0] prode
);
	logic [31:0] rf [31:0];

	initial begin
		for (int i = 0; i < 32; i++) rf[i] = i;
	end

	assign RD1   = rf[A1];
	assign RD2   = rf[A2];


	assign prode = rf[1];

	always_ff @(posedge clk) begin
		if (WE3) rf[A3] <= WD3;
	end
endmodule
