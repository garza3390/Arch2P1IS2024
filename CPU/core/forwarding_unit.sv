module forwarding_unit (
    input logic [4:0] rs1_execute,
    input logic [4:0] rs2_execute,
	 input logic [4:0] rs1_memory,
    input logic [4:0] rs2_memory,
	 input logic [4:0] rs1_writeback,
    input logic [4:0] rs2_writeback,   
    input logic [4:0] rd_memory,
    input logic [4:0] rd_writeback,
	 input logic write_memory_enable_execute,
    input logic wre_memory,
    input logic wre_writeback,
    
    output logic [2:0] select_forward_mux_A,
    output logic [2:0] select_forward_mux_B
);

    always_comb begin
        // Lógica para seleccionar la señal del primer operando (rs1_execute) para instrucciones que escriben en el regfile
        if (wre_memory && (rd_memory == rs1_execute)) begin
            select_forward_mux_A = 3'b010;
        end else if (wre_writeback && (rd_writeback == rs1_execute)) begin
            select_forward_mux_A = 3'b001;
        end else begin
            select_forward_mux_A = 3'b000;
        end
        
        // Lógica para seleccionar la señal del segundo operando (rs2_execute)  para instrucciones que escriben en el regfile
        if (wre_memory && (rd_memory == rs2_execute)) begin
            select_forward_mux_B = 3'b010;
        end else if (wre_writeback && (rd_writeback == rs2_execute) &&
                     !(wre_memory && (rd_memory == rs2_execute))) begin
            select_forward_mux_B = 3'b001;
        end else begin
            select_forward_mux_B = 3'b000;
        end
		  
		   // Lógica para seleccionar la señal del segundo operando (en este caso no pasa por la alu solo se toma la salida del mux)  para la instruccion str, para evitar riesgos con la instruccion add y sub
        if (write_memory_enable_execute && (rs2_execute == rd_memory) && wre_memory) begin
            select_forward_mux_B = 3'b010;
        end else if (write_memory_enable_execute && (rs2_execute == rd_writeback) && wre_writeback) begin
            select_forward_mux_B = 3'b001;
        end else begin
            select_forward_mux_B = 3'b000;
        end
    end

endmodule
