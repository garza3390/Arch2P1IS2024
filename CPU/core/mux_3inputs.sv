module mux_3inputs (
    input logic [7:0] data0,  // Primera entrada
    input logic [7:0] data1,  // Segunda entrada
    input logic [7:0] data2,  // Tercera entrada
    input logic [2:0] select,  // Señal de selección de 3 bits
    output logic [7:0] out    // Salida de 16 bits
);

    always_comb begin
        case (select)
            3'b000: out = data0;  // Selección de la primera entrada
            3'b001: out = data1;  // Selección de la segunda entrada
            3'b010: out = data2;  // Selección de la tercera entrada
            default: out = 8'h0000; // Valor por defecto
        endcase
    end

endmodule