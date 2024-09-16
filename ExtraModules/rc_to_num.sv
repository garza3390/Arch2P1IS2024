module rc_to_num
#( 
    parameter N = 2  // Parámetro que define el tamaño de los datos de entrada
)
(
    input logic [N-1:0] row,      // Entrada de N bits para la fila
    input logic [N-1:0] col,      // Entrada de N bits para la columna
    output logic [N+2:0] result   // Salida que devuelve el resultado (4*fila + columna)
);

    always_comb begin
        result = (row * 4) + col; // Asegurar que el ancho de la operación es correcto
    end

endmodule
