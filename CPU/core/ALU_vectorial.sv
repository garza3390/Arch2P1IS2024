module ALU_vectorial (
    input logic [3:0] aluVectorOp, // Entrada de control para la operación ALU
    input logic [127:0] srcA_vector, // Primer operando
    input logic [127:0] srcB_vector, // Segundo operando
    output logic [127:0] result_vector // Resultado de la operación
);
	logic [127:0] result;
	logic [7:0] vector_alu_result_1;
	logic [7:0] vector_alu_result_2;
	logic [7:0] vector_alu_result_3;
	logic [7:0] vector_alu_result_4;
	logic [7:0] vector_alu_result_5;
	logic [7:0] vector_alu_result_6;
	logic [7:0] vector_alu_result_7;
	logic [7:0] vector_alu_result_8;
	logic [7:0] vector_alu_result_9;
	logic [7:0] vector_alu_result_10;
	logic [7:0] vector_alu_result_11;
	logic [7:0] vector_alu_result_12;
	logic [7:0] vector_alu_result_13;
	logic [7:0] vector_alu_result_14;
	logic [7:0] vector_alu_result_15;
	logic [7:0] vector_alu_result_16;
	
	logic [127:0] vector_data;
	
	logic [11:0] memory_base;
	logic [11:0] vector_address_out;
	
	// Instanciar los módulos de operaciones
	
	
	ALU ALU_vectorial_1 (
		.aluOp(aluVectorOp),       
      .srcA(vector_writeback_data[7:0]),
      .srcB(vector_srcB_execute[7:0]),
      .result(vector_alu_result)
	);
	// Instancia de la ALU
	ALU ALU_vectorial_2 (
		.aluOp(aluVectorOp),       
      .srcA(vector_writeback_data[15:8]),
      .srcB(vector_srcB_execute[15:8]),
      .result(vector_alu_result)
	);
	// Instancia de la ALU
	ALU ALU_vectorial_3 (
		.aluOp(aluVectorOp),       
      .srcA(vector_writeback_data[23:16]),
      .srcB(vector_srcB_execute[23:16]),
      .result(vector_alu_result)
	);
	// Instancia de la ALU
	ALU ALU_vectorial_4 (
		.aluOp(aluVectorOp),       
      .srcA(vector_writeback_data[31:24]),
      .srcB(vector_srcB_execute[31:24]),
      .result(vector_alu_result)
	);
	// Instancia de la ALU
	ALU ALU_vectorial_5 (
		.aluOp(aluVectorOp),       
      .srcA(vector_writeback_data[39:32]),
      .srcB(vector_srcB_execute[39:32]),
      .result(vector_alu_result)
	);
	// Instancia de la ALU
	ALU ALU_vectorial_6 (
		.aluOp(aluVectorOp),       
      .srcA(vector_writeback_data[47:40]),
      .srcB(vector_srcB_execute[47:40]),
      .result(vector_alu_result)
	);
	// Instancia de la ALU
	ALU ALU_vectorial_7 (
		.aluOp(aluVectorOp),       
      .srcA(vector_writeback_data[55:48]),
      .srcB(vector_srcB_execute[55:48]),
      .result(vector_alu_result)
	);
	// Instancia de la ALU
	ALU ALU_vectorial_8 (
		.aluOp(aluVectorOp),       
      .srcA(vector_writeback_data[63:56]),
      .srcB(vector_srcB_execute[63:56]),
      .result(vector_alu_result)
	);
	ALU ALU_vectorial_9 (
		.aluOp(aluVectorOp),       
      .srcA(vector_writeback_data[71:64]),
      .srcB(vector_srcB_execute[71:64]),
      .result(vector_alu_result)
	);
	// Instancia de la ALU
	ALU ALU_vectorial_10 (
		.aluOp(aluVectorOp),       
      .srcA(vector_writeback_data[79:72]),
      .srcB(vector_srcB_execute[79:72]),
      .result(vector_alu_result)
	);
	// Instancia de la ALU
	ALU ALU_vectorial_11 (
		.aluOp(aluVectorOp),       
      .srcA(vector_writeback_data[87:80]),
      .srcB(vector_srcB_execute[87:80]),
      .result(vector_alu_result)
	);
	// Instancia de la ALU
	ALU ALU_vectorial_12 (
		.aluOp(aluVectorOp),       
      .srcA(vector_writeback_data[95:88]),
      .srcB(vector_srcB_execute[95:88]),
      .result(vector_alu_result)
	);
	// Instancia de la ALU
	ALU ALU_vectorial_13 (
		.aluOp(aluVectorOp),       
      .srcA(vector_writeback_data[103:96]),
      .srcB(vector_srcB_execute[103:96]),
      .result(vector_alu_result)
	);
	// Instancia de la ALU
	ALU ALU_vectorial_14 (
		.aluOp(aluVectorOp),       
      .srcA(vector_writeback_data[111:104]),
      .srcB(vector_srcB_execute[111:104]),
      .result(vector_alu_result)
	);
	// Instancia de la ALU
	ALU ALU_vectorial_15 (
		.aluOp(aluVectorOp),       
      .srcA(vector_writeback_data[119:112]),
      .srcB(vector_srcB_execute[119:112]),
      .result(vector_alu_result)
	);
	// Instancia de la ALU
	ALU ALU_vectorial_16 (
		.aluOp(aluVectorOp),       
      .srcA(vector_writeback_data[127:120]),
      .srcB(vector_srcB_execute[127:120]),
      .result(vector_alu_result)
	);
	
	
	
	
	
	
	MemoryLoader MemoryLoader_instance(
		.clk(clk),
		.memory_base(memory_base), 
		.vector_alu_result_1_execute(vector_alu_result_1),
		.vector_alu_result_2_execute(vector_alu_result_2),
		.vector_alu_result_3_execute(vector_alu_result_3),
		.vector_alu_result_4_execute(vector_alu_result_4),
		.vector_alu_result_5_execute(vector_alu_result_5),
		.vector_alu_result_6_execute(vector_alu_result_6),
		.vector_alu_result_7_execute(vector_alu_result_7),
		.vector_alu_result_8_execute(vector_alu_result_8),
		.vector_alu_result_9_execute(vector_alu_result_9),
		.vector_alu_result_10_execute(vector_alu_result_10),
		.vector_alu_result_11_execute(vector_alu_result_11),
		.vector_alu_result_12_execute(vector_alu_result_12),
		.vector_alu_result_13_execute(vector_alu_result_13),
		.vector_alu_result_14_execute(vector_alu_result_14),
		.vector_alu_result_15_execute(vector_alu_result_15),
		.vector_alu_result_16_execute(vector_alu_result_16),
		.address_data_vector(vector_address_out),
		.data_vectorial_out(vector_data)
	);
	
	
	
	
	always_comb begin
		case (aluVectorOp)
			4'b0000: result = 128'b0; // Si hay un nop/stall el resultado es cero
			4'b0001: result = vector_data; // provisional, falta definir los resultados
			default: result = 128'b0; // Manejo de caso inválido, resultado es cero
      endcase
    end
endmodule
