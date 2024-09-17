module MemoryLoader (
	input logic clk,
	input logic [11:0] memory_base,
	input logic [7:0] vector_alu_result_1_execute,
	input logic [7:0] vector_alu_result_2_execute,
	input logic [7:0] vector_alu_result_3_execute,
	input logic [7:0] vector_alu_result_4_execute,
	input logic [7:0] vector_alu_result_5_execute,
	input logic [7:0] vector_alu_result_6_execute,
	input logic [7:0] vector_alu_result_7_execute,
	input logic [7:0] vector_alu_result_8_execute,
	input logic [7:0] vector_alu_result_9_execute,
	input logic [7:0] vector_alu_result_10_execute,
	input logic [7:0] vector_alu_result_11_execute,
	input logic [7:0] vector_alu_result_12_execute,
	input logic [7:0] vector_alu_result_13_execute,
	input logic [7:0] vector_alu_result_14_execute,
	input logic [7:0] vector_alu_result_15_execute,
	input logic [7:0] vector_alu_result_16_execute,
	output logic [11:0] address_data_vector,
   output logic [127:0] data_vectorial_out
);
	always_ff @(posedge clk) begin
		//Solicitar ldatos basados en la memoria base
		address_data_vector <= memory_base;
		//Concatenar los datos de 8 bits en un paquete de 128 bits en un solo ciclo
		data_vectorial_out <= {vector_alu_result_1_execute, vector_alu_result_2_execute, vector_alu_result_3_execute,
									vector_alu_result_4_execute, vector_alu_result_5_execute, vector_alu_result_6_execute,
									vector_alu_result_7_execute, vector_alu_result_8_execute, vector_alu_result_9_execute,
									vector_alu_result_10_execute, vector_alu_result_11_execute, vector_alu_result_12_execute,
									vector_alu_result_13_execute, vector_alu_result_14_execute, vector_alu_result_15_execute,
									vector_alu_result_16_execute};
	end
endmodule