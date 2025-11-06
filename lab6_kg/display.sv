module display(
	input logic [31:0] data_in,
	output logic [6:0] segments
);
	always_comb begin
<<<<<<< HEAD
		// compute segments into a temporary in current bit order,
		// then reverse MSB<->LSB when assigning to the output so the
		// bit ordering is flipped (MSB becomes LSB and vice-versa).
		logic [6:0] s;
		unique case (data_in[3:0])
			// constants flipped so MSB/LSB are reversed compared to original
			4'h0: s = 7'b1000000; // reversed of 0000001
			4'h1: s = 7'b1111001; // reversed of 1001111
			4'h2: s = 7'b0100100; // reversed of 0010010
			4'h3: s = 7'b0110000; // reversed of 0000110
			4'h4: s = 7'b0011001; // reversed of 1001100
			4'h5: s = 7'b0010010; // reversed of 0100100
			4'h6: s = 7'b0000010; // reversed of 0100000
			4'h7: s = 7'b1111000; // reversed of 0001111
			4'h8: s = 7'b0000000; // reversed of 0000000 (same)
			4'h9: s = 7'b0010000; // reversed of 0000100
			4'hA: s = 7'b0001000; // reversed of 0001000 (same)
			4'hB: s = 7'b0000011; // reversed of 1100000
			4'hC: s = 7'b1000110; // reversed of 0110001
			4'hD: s = 7'b0100001; // reversed of 1000010
			4'hE: s = 7'b0000110; // reversed of 0110000
			4'hF: s = 7'b0001110; // reversed of 0111000
			default: s = 7'b1111111; // all off (same when reversed)
		endcase
		// s already holds the flipped bit-order constants; drive directly
		segments = s;
=======
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
>>>>>>> c0e05add9224c5071719efd2505b72ed25c8cf7c
	end
endmodule
