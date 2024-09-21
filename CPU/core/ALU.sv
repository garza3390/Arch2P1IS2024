module ALU (
    input logic [4:0] aluOp, // Entrada de control para la operación ALU
    input logic [7:0] srcA, // Primer operando
    input logic [7:0] srcB, // Segundo operando
    output logic [7:0] result // Resultado de la operación
);
	// Variables para almacenar los resultados de las operaciones
	logic [7:0] add_result, sub_result;
	// Instanciar los módulos adder y subtractor
	adder_8bits u_adder (
		.a(srcA),
		.b(srcB),
		.y(add_result)
	);
	// Selección de la operación basada en ALUop
	always_comb begin
		case (aluOp)
			5'b00000: result = 8'b0; // nop/stall
			5'b00001: result = add_result; // Suma
			default: result = 8'b0; // Manejo de caso inválido
      endcase
    end
endmodule