module rc_to_num_tb;
    logic [1:0] row;   
    logic [1:0] col;
	 logic [1:0] r_row;   
    logic [1:0] r_col;
    logic [3:0] result;  // El resultado ahora tiene 4 bits de ancho

    rc_to_num #(2) fc_inst (
        .row(row),
        .col(col),
        .result(result)
    );
	 
	 get_row #(4) grow(.i_num(result),.r_row(r_row));
	 get_col #(4) gcol(.i_num(result),.r_col(r_col));

    initial begin
        
        row = 2'd3;
        col = 2'd1;
        #10;
        $display("Resultado: %d", result);  // Debería ser 13 1101
		  row = 2'd2;
        col = 2'd0;
		  #10;
		  $display("Resultado: %d", result);  // Debería ser 8 1000
		  row = 2'd1;
        col = 2'd3;
		  #10;
		  $display("Resultado: %d", result);  // Debería ser 7 0111
		  
    end
endmodule
