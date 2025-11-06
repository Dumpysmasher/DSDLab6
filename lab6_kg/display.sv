module display(
	input logic [31:0] data_in,
	output logic [6:0] segments
);
	always_comb begin
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
	end
endmodule
