module controlUnit (
    input logic [4:0] opCode,
	 output logic [19:0] control_signals // salida concatenada
);
	logic load; // indica si la operacion carga datos desde memoria
	logic wre;	// write register enable
	logic [3:0] aluOp;	// operacion que debe realizar la ALU
	logic [1:0] select_writeback_data_mux; // mux que elige entre el dato calculado en la alu o el dato que sale de memoria
	
	logic [3:0] aluVectorOp;
	logic [1:0] select_writeback_vector_data_mux;
	logic vector_wre = 1'b0; // write register enableV
	logic write_memory_enable_a ; // indica si la operacion escribe o no en la memoria (escalares)
	logic write_memory_enable_b ; // indica si la operacion escribe o no en la memoria (vectores)
	
	
	// Definición de las salidas en función del opCode
	always_comb begin
		case (opCode)		  
			// nop/stall
			4'b0000: begin
			   load = 1'b0;
				wre = 1'b0;
				vector_wre = 1'b0;
				write_memory_enable_a = 1'b0;
				write_memory_enable_b = 1'b0;
				select_writeback_data_mux = 2'b00;
				select_writeback_vector_data_mux = 2'b00;
				aluOp = 4'b0000;
				aluVectorOp = 4'b0000;
			end
			// 
			4'b0010: begin
				load = 1'b0;
				wre = 1'b0;
				vector_wre = 1'b0;
				write_memory_enable_a = 1'b0;
				write_memory_enable_b = 1'b0;
				select_writeback_data_mux = 2'b00;
				select_writeback_vector_data_mux = 2'b00;
				aluOp = 4'b0000;
				aluVectorOp = 4'b0000;
			end	
			4'b0001: begin
				load = 1'b0;
				wre = 1'b0;
				vector_wre = 1'b0;
				write_memory_enable_a = 1'b0;
				write_memory_enable_b = 1'b0;
				select_writeback_data_mux = 2'b00;
				select_writeback_vector_data_mux = 2'b00;
				aluOp = 4'b0000;
				aluVectorOp = 4'b0000;
			end	
			// 
			4'b1010: begin
				load = 1'b0;
				wre = 1'b0;
				vector_wre = 1'b0;
				write_memory_enable_a = 1'b0;
				write_memory_enable_b = 1'b0;
				select_writeback_data_mux = 2'b00;
				select_writeback_vector_data_mux = 2'b00;
				aluOp = 4'b0000;
				aluVectorOp = 4'b0000;
			end
			//
			4'b1001: begin
				load = 1'b0;
				wre = 1'b0;
				vector_wre = 1'b0;
				write_memory_enable_a = 1'b0;
				write_memory_enable_b = 1'b0;
				select_writeback_data_mux = 2'b00;
				select_writeback_vector_data_mux = 2'b00;
				aluOp = 4'b0000;
				aluVectorOp = 4'b0000;
			end
			//
			4'b0100: begin
				load = 1'b0;
				wre = 1'b0;
				vector_wre = 1'b0;
				write_memory_enable_a = 1'b0;
				write_memory_enable_b = 1'b0;
				select_writeback_data_mux = 2'b00;
				select_writeback_vector_data_mux = 2'b00;
				aluOp = 4'b0000;
				aluVectorOp = 4'b0000;
			end
			default: begin
				load = 1'b0;
				wre = 1'b0;
				vector_wre = 1'b0;
				write_memory_enable_a = 1'b0;
				write_memory_enable_b = 1'b0;
				select_writeback_data_mux = 2'b00;
				select_writeback_vector_data_mux = 2'b00;
				aluOp = 4'b0000;
				aluVectorOp = 4'b0000;
			end
		endcase
		control_signals = {3'b0,  load, wre, vector_wre, write_memory_enable_a, write_memory_enable_b, select_writeback_data_mux, select_writeback_vector_data_mux, aluOp, aluVectorOp};
	end
endmodule
