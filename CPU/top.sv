module top (
    input logic clk,
    input logic reset
);
	// registro PC
	logic [15:0] pc_mux_output;
	logic [15:0] pc_address;
	// sumador del PC
	logic [15:0] pc_offset;
	logic [15:0] pc_incremented;
	// mux del PC
	logic [1:0] select_pc_mux;   // esta señal de control viene del comparador entre rs1 y rs2
	logic [15:0] branch_address;
	// registro Fetch-Decode
	logic [19:0] instruction_fetch, instruction_decode;
	logic [1:0] flush;
	// unidad de control
	logic [19:0] control_signals;
	// mux de la unidad de control
	logic [15:0] nop_mux_output;
	logic [1:0] select_nop_mux;
	// banco de registros
	logic [15:0] writeback_data;
	logic wre_writeback;
	logic [15:0] rd1,rd2,rd3;
	// extensor de signo
	logic [15:0] extended_label;
	// sumador branch
	logic [15:0] pc_decode;
	// registro Decode-Execute
	logic write_memory_enable_execute;
	logic [1:0] select_writeback_data_mux_execute;
	logic [3:0] aluOp_execute;
	logic [4:0] rs1_execute; // entrada a la unidad de adelantamiento y de deteccion de riesgos
	logic [4:0] rs2_execute; // entrada a la unidad de adelantamiento y de deteccion de riesgos
	logic [4:0] rd_execute; 
	logic load_instruction;
	// alu
	logic [7:0] alu_src_A;
	logic [7:0] alu_src_B;
	logic [7:0] alu_result_execute;
	logic [7:0] vector_alu_result_1_execute, vector_alu_result_2_execute, vector_alu_result_3_execute, 
					vector_alu_result_4_execute, vector_alu_result_5_execute, vector_alu_result_6_execute,
					vector_alu_result_7_execute, vector_alu_result_8_execute, vector_alu_result_9_execute,
					vector_alu_result_10_execute, vector_alu_result_11_execute, vector_alu_result_12_execute,
					vector_alu_result_13_execute, vector_alu_result_14_execute, vector_alu_result_15_execute,
					vector_alu_result_16_execute;
	// mux's de la alu
	logic [7:0] srcA_execute;
	logic [7:0] srcB_execute;
	// registro Execute-Memory
	logic wre_memory, wre_execute;
	logic vector_wre_memory, vector_wre_execute;
	logic [1:0] select_writeback_data_mux_memory;
	logic write_memory_enable_memory;
	logic [7:0] alu_result_memory;
	logic [7:0] srcA_memory;
	logic [7:0] srcB_memory;
	logic [4:0] rs1_memory; // entrada a la unidad de adelantamiento
	logic [4:0] rs2_memory; // entrada a la unidad de adelantamiento
	logic [4:0] rd_memory;
	// unidad de adelantamiento
	logic [2:0] select_forward_mux_A;
	logic [2:0] select_forward_mux_B;
	// memoria de datos
	logic [7:0] data_from_memory;
	// registro Memory-Writeback
	logic [7:0] data_from_memory_writeback;
	logic [7:0] alu_result_writeback;
	logic [4:0] rs1_writeback; // entrada a la unidad de adelantamiento
	logic [4:0] rs2_writeback; // entrada a la unidad de adelantamiento
	logic [4:0] rd_writeback;
	logic [1:0] select_writeback_data_mux_writeback;
	// vectorial
	logic vector_wre_writeback;
	logic [127:0] vector_rd1, vector_rd2, vector_rd3;
	logic [4:0] vector_rd_writeback;
	logic [127:0] vector_srcA_execute, vector_srcB_execute;
	logic [127:0] vector_data_execute, vector_data_memory, vector_writeback_data, vector_data_from_memory;
	logic [11:0] vector_address_execute, vector_address_memory;
	logic [127:0] alu_vector_result_execute;
	logic [3:0] aluVectorOp_execute;
//////////////////////////////////////////////////////////////////////////////
	assign pc_offset = 16'b0000000000000001;// Inicialización
//////////////////////////////////////////////////////////////////////////////
		// Instancia del sumador del PC
	adder_16 pc_add (
		.a(pc_mux_output),
		.b(pc_offset),
		.y(pc_incremented)
	);
	// Instancia del MUX del PC
	mux_2inputs_16bits mux_2inputs_PC (
		.data0(pc_address),
		.data1(branch_address),
		.select(select_pc_mux),
		.out(pc_mux_output)
	);
	// Instancia del registro del PC
	PC_register pc_reg (
		.clk(clk),
      .reset(reset),
      .nop(select_nop_mux),
      .address_in(pc_incremented),
      .address_out(pc_address)
	);
	// Instancia de la memoria ROM
	ROM rom_memory (
		.address(pc_mux_output),
      .clock(clk),
      .q(instruction_fetch)
	);
	// Instancia del registro FetchDecode
	FetchDecode_register FetchDecode_register_instance (
		.clk(clk),
      .reset(reset),
      .flush(flush),
		.nop(select_nop_mux),
      .pc(pc_mux_output),
      .instruction_in(instruction_fetch),
      .pc_decode(pc_decode),
      .instruction_out(instruction_decode)
	);
	// Instancia de la unidad de detección de riesgos
	hazard_detection_unit u_hazard_detection (
		.opcode(instruction_decode[19:15]),
		.rd_load_execute(rd_execute),
      .load_instruction(load_instruction),
		.regfile_data_1(rd1),
		.regfile_data_2(rd2),
      .rs1_decode(instruction_decode[4:0]),
      .rs2_decode(instruction_decode[9:5]),
      .rs1_execute(rs1_execute),
      .rs2_execute(rs2_execute),
      .nop(select_nop_mux),
		.flush(flush)
	); 
	// Instancia de la unidad de control
	controlUnit control_unit_instance (
		.opCode(instruction_decode[19:15]),
      .control_signals(control_signals)
	);
	// Instancia del MUX de NOP
	mux_2inputs_20bits mux_2inputs_nop (
		.data0(control_signals),
      .data1(16'b0),
      .select(select_nop_mux),
      .out(nop_mux_output)
	);
	// Instancia del extensor de ceros
	zeroExtend zero_extend_instance (
		.label(instruction_decode[14:10]),
		.ZeroExtLabel(extended_label) 
	); 
	// Instancia del sumador de etiquetas de branch
	adder_16 branch_label_pc_add (
		.a(pc_decode),
      .b(extended_label),
      .y(branch_address)
	);
	// Instancia del banco de registros
	Regfile_scalar regfile_instance (
		.clk(clk),
		.wre(wre_writeback),
		.a1(instruction_decode[4:0]),
      .a2(instruction_decode[9:5]),
      .a3(rd_writeback),
      .wd3(writeback_data),
      .rd1(rd1),
      .rd2(rd2),
      .rd3(rd3)
	);
	// Instancia del banco de registros vectorial
	Regfile_vector vector_instance (
		.clk(clk),
		.wre(vector_wre_writeback),
		.a1(instruction_decode[4:0]),
      .a2(instruction_decode[9:5]),
      .a3(vector_rd_writeback),
		.wd3(vector_writeback_data),
		.rd1(vector_rd1),   // Read data 1
		.rd2(vector_rd2),   // Read data 2
		.rd3(vector_rd3)   // Read data 3
	);
	// Instancia del comparador de branch
	comparator_branch comparator_instance (
		.opCode(instruction_decode[19:15]),
      .rs1_value(rd1),
      .rs2_value(rd2),
      .select_pc_mux(select_pc_mux)
	);
	// Instancia del registro DecodeExecute
	DecodeExecute_register DecodeExecute_register_instance (
		.clk(clk),
      .reset(reset),
      .nop_mux_output_in(nop_mux_output),
      .srcA_in(rd1),
      .srcB_in(rd2),
		.srcA_vector_in(vector_rd1),
		.srcB_vector_in(vector_rd2),
      .rs1_decode(instruction_decode[4:0]),
      .rs2_decode(instruction_decode[9:5]),
      .rd_decode(instruction_decode[14:10]),
      .wre_execute(wre_execute),
		.vector_wre_execute(vector_wre_execute),
      .write_memory_enable_execute(write_memory_enable_execute),
      .select_writeback_data_mux_execute(select_writeback_data_mux_execute),
      .aluOp_execute(aluOp_execute),
      .srcA_out(srcA_execute),
      .srcB_out(srcB_execute),
		.srcA_vector_out(vector_srcA_execute),
      .srcB_vector_out(vector_srcB_execute),
      .rs1_execute(rs1_execute),  // entrada a la unidad de adelantamiento
      .rs2_execute(rs2_execute), // entrada a la unidad de adelantamiento
      .rd_execute(rd_execute),
		.load_instruction(load_instruction)
	);
	// Instancia del MUX de forwarding A
	mux_3inputs mux_alu_forward_A (
		.data0(srcA_execute),
      .data1(writeback_data),
      .data2(alu_result_memory),
      .select(select_forward_mux_A),
      .out(alu_src_A)
	);
	// Instancia del MUX de forwarding B
	mux_3inputs mux_alu_forward_B (
		.data0(srcB_execute),
      .data1(writeback_data),
      .data2(alu_result_memory),
      .select(select_forward_mux_B),
     	.out(alu_src_B)
	);
	// Instancia de la ALU
	ALU ALU_escalar(
		.aluOp(aluOp_execute),       
      .srcA(alu_src_A),
      .srcB(alu_src_B),
      .result(alu_result_execute)
	);
	// Instancia de la ALU vectorial
	ALU ALU_vectorial(
		.aluVectorOp(aluVectorOp_execute),       
      .srcA_vector(vector_srcA_execute),
      .srcB_vector(vector_srcB_execute),
      .result_vector(alu_vector_result_execute)
	);
	// Instancia del módulo forwarding_unit
   forwarding_unit forwarding_unit_instance (
      .rs1_execute(rs1_execute),
      .rs2_execute(rs2_execute),
      .rs1_memory(rs1_memory),
      .rs2_memory(rs2_memory),
      .rs1_writeback(rs1_writeback),
      .rs2_writeback(rs2_writeback),
      .rd_memory(rd_memory),
      .rd_writeback(rd_writeback),
      .write_memory_enable_execute(write_memory_enable_execute),
      .wre_memory(wre_memory),
      .wre_writeback(wre_writeback),
      .select_forward_mux_A(select_forward_mux_A),
      .select_forward_mux_B(select_forward_mux_B)
    );
	// Instancia del registro ExecuteMemory
	ExecuteMemory_register ExecuteMemory_register_instance (
		.clk(clk),
     	.reset(reset),
     	.wre_execute(wre_execute),
		.vector_address_execute(vector_address_execute),
		.vector_data_execute(alu_vector_result_execute),
		.vector_wre_execute(vector_wre_execute),
     	.select_writeback_data_mux_execute(select_writeback_data_mux_execute),
     	.write_memory_enable_execute(write_memory_enable_execute),
		.rs1_execute(rs1_execute),
     	.rs2_execute(rs1_execute),
     	.ALUresult_in(alu_result_execute),
     	.srcA_execute(srcA_execute),
     	.srcB_execute(alu_src_B),
     	.rd_execute(rd_execute),
     	.wre_memory(wre_memory),
		.vector_wre_memory(vector_wre_memory),
		.vector_data_memory(vector_data_memory),
		.vector_address_memory(vector_address_memory),
     	.select_writeback_data_mux_memory(select_writeback_data_mux_memory),
     	.write_memory_enable_memory(write_memory_enable_memory),
		.rs1_memory(rs1_memory),
     	.rs2_memory(rs2_memory),
     	.ALUresult_out(alu_result_memory),
     	.srcA_memory(srcA_memory),
     	.srcB_memory(srcB_memory),
     	.rd_memory(rd_memory)
	);
	// Instancia de la RAM
	RAM RAM_instance(
		.address_a(srcA_memory),
		.address_b(srcA_memory), //vector_address_memory
      .clock(clk),
      .data_a(srcB_memory),
		.data_b(vector_data_memory),
      .wren_a(write_memory_enable_memory),
		.wren_b(vector_wre_memory),
      .q_a(data_from_memory),
		.q_b(vector_data_from_memory)
	);
	// Instancia del registro MemoryWriteback
	MemoryWriteback_register MemoryWriteback_register_instance (
		.clk(clk),
      .reset(reset),
      .wre_memory(wre_memory),
		.vector_wre_memory(vector_wre_memory),
      .select_writeback_data_mux_memory(select_writeback_data_mux_memory),
		.rs1_memory(rs1_memory),
      .rs2_memory(rs2_memory),
      .rd_memory(rd_memory), 
      .data_from_memory_in(data_from_memory),
		.vector_data_from_memory_in(vector_data_from_memory),
      .calc_data_in(alu_result_memory),
      .data_from_memory_out(data_from_memory_writeback),
		.vector_data_from_memory_out(vector_writeback_data),
      .calc_data_out(alu_result_writeback),
      .wre_writeback(wre_writeback),
		.vector_wre_writeback(vector_wre_writeback),
      .select_writeback_data_mux_writeback(select_writeback_data_mux_writeback),
		.rs1_writeback(rs1_writeback),
     	.rs2_writeback(rs2_writeback),
      .rd_writeback(rd_writeback)
	);
	// Instancia del MUX de writeback
	mux_2inputs_8bits mux_2inputs_writeback (
		.data0(data_from_memory_writeback),
      .data1(alu_result_writeback),
      .select(select_writeback_data_mux_writeback),
      .out(writeback_data)
	);
	// Instancia del MUX de writeback
	mux_2inputs_128bits mux_vector_2inputs_writeback (
		.data0(vector_writeback_data),
      .data1(-----),
      .select(select_writeback_data_mux_writeback),
      .out(writeback_data)
	);
endmodule
