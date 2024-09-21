module AddRoundKey #(N=127)(
    input logic [N:0] state_matrix,   // Matriz de estado (128 bits)
    input logic [N:0] round_key,      // Clave de vuelta (128 bits)
    output logic [N:0] result_matrix  // Matriz resultado después de XOR
);
	// Realizamos XOR entre la matriz de estado y la clave de vuelta
	assign result_matrix = state_matrix ^ round_key;
endmodule
