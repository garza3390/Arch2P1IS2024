module get_col
#( 
    parameter N = 4 
)
(
    input logic [N-1:0] i_num,    
    output logic [N-3:0] r_col
);

    always_comb begin
        r_col = (i_num % 4);
    end

endmodule
