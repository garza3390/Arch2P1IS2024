module ALU (
    input logic [4:0] aluOp, // Entrada de control para la operación ALU
    input logic [7:0] srcA, // Primer operando
    input logic [7:0] srcB, // Segundo operando
    output logic [7:0] result // Resultado de la operación
);
	// Variables para almacenar los resultados de las operaciones
	logic [7:0] increment_result, test_result;
	
	assign increment_result = srcA+1'b1;
	assign test_result = srcB;
	
	// Selección de la operación basada en ALUop
	always_comb begin
		case (aluOp)
			5'b00000: result = 8'b0; // nop/stall
			5'b00001: result = test_result; //para evitar warnings
			5'b00100: result = increment_result; // Incrementa en 1 y hace el numero de 16 bits
			default: result = 8'b0; // Manejo de caso inválido
      endcase
    end
endmodule