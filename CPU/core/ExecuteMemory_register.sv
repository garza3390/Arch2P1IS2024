module ExecuteMemory_register (
   input logic clk,
   input logic reset,
   input logic wre_execute,
	input logic [11:0] vector_address_data_execute,
	input logic [127:0] vector_data_execute,
   input logic vector_wre_execute,
   input logic select_writeback_data_mux_execute,
   input logic write_memory_enable_execute,
	input logic [3:0] rs1_execute,
   input logic [3:0] rs2_execute,
   input logic [7:0] ALUresult_in,
   input logic [7:0] srcA_execute,
   input logic [7:0] srcB_execute,
   input logic [4:0] rd_execute,
   output logic wre_memory,
	output logic [127:0] vector_data_memory,
	output logic [11:0] vector_address_data_memory,
   output logic vector_wre_memory,
   output logic select_writeback_data_mux_memory,
   output logic write_memory_enable_memory,
	output logic [3:0] rs1_memory,
   output logic [3:0] rs2_memory,
   output logic [7:0] ALUresult_out,
   output logic [7:0] srcA_memory,
   output logic [7:0] srcB_memory,
   output logic [4:0] rd_memory
);
    // Registros internos
	logic [4:0] rs1;
	logic [4:0] rs2;
   logic [7:0] ALUresult;
   logic wre;
	logic [11:0] vector_address_data;
	logic [127:0] vector_data;
   logic vector_wre;
   logic select_writeback_data_mux;
   logic write_memory_enable;
   logic [7:0] srcA;
   logic [7:0] srcB;
   logic [4:0] rd;
   // Proceso de escritura en el registro
   always_ff @(posedge clk) begin
		if (reset) begin
			rs1 <= 5'b0;
			rs2 <= 5'b0;
         ALUresult <= 8'b0;
         wre <= 1'b0;
			vector_address_data <= 12'b0;
			vector_data <= 128'b0;
         vector_wre <= 1'b0;
         select_writeback_data_mux <= 1'b0;
         write_memory_enable <= 1'b0;
         srcA <= 8'b0;
         srcB <= 8'b0;
         rd <= 5'b0;
		end else begin
			rs1 <= rs1_execute;
			rs2 <= rs2_execute;
         ALUresult <= ALUresult_in;
         wre <= wre_execute;
			vector_data <= vector_data_execute;
			vector_address_data <= vector_address_data_execute;
         vector_wre <= vector_wre_execute;
         select_writeback_data_mux <= select_writeback_data_mux_execute;
         write_memory_enable <= write_memory_enable_execute;
         srcA <= srcA_execute;
         srcB <= srcB_execute;
         rd <= rd_execute;
      end
	end
    // Salidas del registro
	assign rs1_memory = rs1;
	assign rs2_memory = rs2;
   assign ALUresult_out = ALUresult;
   assign wre_memory = wre;
	assign vector_data_memory = vector_data;
	assign vector_address_data_memory = vector_address_data;
   assign vector_wre_memory = vector_wre;
   assign select_writeback_data_mux_memory = select_writeback_data_mux;
   assign write_memory_enable_memory = write_memory_enable;
   assign srcA_memory = srcA;
   assign srcB_memory = srcB;
   assign rd_memory = rd;
endmodule