module display(
	input logic [31:0] data_in,
	output logic [6:0] segments
);
	always_comb begin
		unique case (data_in[3:0])
			4'h0: segments = 7'b0000001; // a b c d e f on, g off
			4'h1: segments = 7'b1001111; // b c
			4'h2: segments = 7'b0010010; // a b d e g
			4'h3: segments = 7'b0000110; // a b c d g
			4'h4: segments = 7'b1001100; // f g b c
			4'h5: segments = 7'b0100100; // a f g c d
			4'h6: segments = 7'b0100000; // a f g e c d
			4'h7: segments = 7'b0001111; // a b c
			4'h8: segments = 7'b0000000; // all on
			4'h9: segments = 7'b0000100; // a b c d f g
			4'hA: segments = 7'b0001000; // a b c e f g
			4'hB: segments = 7'b1100000; // f e d c g  (uppercase B looks like b)
			4'hC: segments = 7'b0110001; // a f e d
			4'hD: segments = 7'b1000010; // b c d e g  (uppercase D looks like d)
			4'hE: segments = 7'b0110000; // a f g e d
			4'hF: segments = 7'b0111000; // a f g e
			default: segments = 7'b1111111; // all off
		endcase
	end
endmodule
