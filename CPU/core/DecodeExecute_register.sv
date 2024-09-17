module DecodeExecute_register (
   input logic clk,
   input logic reset,
   input logic [15:0] nop_mux_output_in,	 
   input logic [7:0] srcA_in,
   input logic [7:0] srcB_in,
	input logic [7:0] srcA_vector_in,
   input logic [7:0] srcB_vector_in,
	input logic [4:0] rs1_decode,
	input logic [4:0] rs2_decode,
	input logic [4:0] rd_decode,
   output logic wre_execute,
   output logic vector_wre_execute,
   output logic write_memory_enable_execute,
   output logic [1:0] select_writeback_data_mux_execute,
   output logic [3:0] aluOp_execute,
   output logic [7:0] srcA_out,
   output logic [7:0] srcB_out,
	output logic [7:0] srcA_vector_out,
   output logic [7:0] srcB_vector_out,
	output logic [4:0] rs1_execute,
	output logic [4:0] rs2_execute,
	output logic [4:0] rd_execute,
	output logic load_instruction
);
   logic [7:0] srcA;
   logic [7:0] srcB;
	logic [7:0] srcA_vector;
   logic [7:0] srcB_vector;
	logic [4:0] rs1;
	logic [4:0] rs2;
	logic [4:0] rd;
	logic load;
   always_ff @(posedge clk) begin
		if (reset) begin
			wre_execute <= 1'b0;
         write_memory_enable_execute <= 1'b0;
         select_writeback_data_mux_execute <= 2'b00;
         aluOp_execute <= 4'b0;
         srcA <= 8'b0;
         srcB <= 8'b0;
			srcA_vector <= 8'b0;
         srcB_vector <= 8'b0;
			rs1 <= 5'b0;
			rs2 <= 5'b0;
			rd <= 5'b0;
			load <= 5'b0;
      end else begin
         vector_wre_execute <= nop_mux_output_in[9];
         wre_execute <= nop_mux_output_in[7];
			write_memory_enable_execute <= nop_mux_output_in[6];
			select_writeback_data_mux_execute <= nop_mux_output_in[5:4];
			aluOp_execute <= nop_mux_output_in[3:0];
         srcA <= srcA_in;
         srcB <= srcB_in;
			srcA_vector <= srcA_vector_in;
         srcB_vector <= srcB_vector_in;
			rs1 <= rs1_decode;
			rs2 <= rs2_decode;
			rd <= rd_decode;
			wre_execute <= nop_mux_output_in[8];
      end
   end
   assign srcA_out = srcA;
   assign srcB_out = srcB;
	assign srcA_out_vector = srcA_vector;
   assign srcB_out_vector = srcB_vector;
	assign rs1_execute = rs1;
	assign rs2_execute = rs2;
	assign rd_execute = rd;
	assign load_instruction = load;
endmodule