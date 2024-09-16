module get_row
#( 
    parameter N = 4  
)
(
    input logic [N-1:0] i_num,    
    output logic [N-2:0] r_row     
);

    always_comb begin
        r_row = (i_num >> 2);
    end
	 
	 // 1101 13 13 division entera entre 4 da 3
	 // 0011 3

endmodule
