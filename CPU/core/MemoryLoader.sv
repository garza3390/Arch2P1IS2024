module MemoryLoader (
	input logic clk,
   input logic [15:0] memory_base, 
	input logic [15:0] alu_result_vectorial_1_execute,
	input logic [15:0] alu_result_vectorial_2_execute,
	input logic [15:0] alu_result_vectorial_3_execute,
	input logic [15:0] alu_result_vectorial_4_execute,
	input logic [15:0] alu_result_vectorial_5_execute,
	input logic [15:0] alu_result_vectorial_6_execute,
	input logic [15:0] alu_result_vectorial_7_execute,
	input logic [15:0] alu_result_vectorial_8_execute,
	output logic [15:0] address_data_1,
	output logic [15:0] address_data_2,
	output logic [15:0] address_data_3,
	output logic [15:0] address_data_4,
	output logic [15:0] address_data_5,
	output logic [15:0] address_data_6,
	output logic [15:0] address_data_7,
	output logic [15:0] address_data_8,
   output logic [127:0] data_vectorial_out
);
	always_ff @(posedge clk) begin
		//Solicitar los 8 datos basados en la memoria base
		address_data_1 <= memory_base;
		address_data_2 <= memory_base+16;
		address_data_3 <= memory_base+32;
		address_data_4 <= memory_base+48;
		address_data_5 <= memory_base+64;
		address_data_6 <= memory_base+80;
		address_data_7 <= memory_base+96;
		address_data_8 <= memory_base+112;
		//Concatenar los 8 datos de 16 bits en un paquete de 128 bits en un solo ciclo
		data_vectorial_out <= {alu_result_vectorial_1_execute, alu_result_vectorial_2_execute, alu_result_vectorial_3_execute,
						alu_result_vectorial_4_execute, alu_result_vectorial_5_execute, alu_result_vectorial_6_execute, 
						alu_result_vectorial_7_execute, alu_result_vectorial_8_execute};
	end
endmodule