<<<<<<< HEAD
module addRoundKey
#(
    parameter N = 8
)
(
    input logic [N-1:0] in1, 
    input logic [N-1:0] in2,
    output logic [N-1:0] out
);

    always_comb begin
        out = in1 ^ in2;
    end
=======
module AddRoundKey #(N=127)(
    input logic [N:0] state_matrix,   // Matriz de estado (128 bits)
    input logic [N:0] round_key,      // Clave de vuelta (128 bits)
    output logic [N:0] result_matrix  // Matriz resultado después de XOR
);

    // Realizamos XOR entre la matriz de estado y la clave de vuelta
    assign result_matrix = state_matrix ^ round_key;
>>>>>>> 9f69a0ad487faacf770c87881b87b355062eaab4

endmodule
