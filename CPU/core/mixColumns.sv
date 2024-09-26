module mixColumns(
    input  logic [7:0] col_in0,    // Celda 0 de la columna
    input  logic [7:0] col_in1,    // Celda 1 de la columna
    input  logic [7:0] col_in2,    // Celda 2 de la columna
    input  logic [7:0] col_in3,    // Celda 3 de la columna
    input  logic [1:0] row_idx,    // Índice de la fila (0, 1, 2, 3)
    input  logic [1:0] col_idx,    // Índice de la columna (0, 1, 2, 3)
    output logic [7:0] result      // Resultado de la multiplicación
);

    // Definimos la tabla MixColumns (Matriz de coeficientes fija)
    logic [7:0] MixMatrix [3:0][3:0];

    initial begin
        // Inicializamos la tabla MixColumns
        MixMatrix[0][0] = 8'h02; MixMatrix[0][1] = 8'h03; MixMatrix[0][2] = 8'h01; MixMatrix[0][3] = 8'h01;
        MixMatrix[1][0] = 8'h01; MixMatrix[1][1] = 8'h02; MixMatrix[1][2] = 8'h03; MixMatrix[1][3] = 8'h01;
        MixMatrix[2][0] = 8'h01; MixMatrix[2][1] = 8'h01; MixMatrix[2][2] = 8'h02; MixMatrix[2][3] = 8'h03;
        MixMatrix[3][0] = 8'h03; MixMatrix[3][1] = 8'h01; MixMatrix[3][2] = 8'h01; MixMatrix[3][3] = 8'h02;
    end

    // Función para la multiplicación en el campo de Galois
    function logic [7:0] galois_mult;
        input logic [7:0] a;  // Multiplicador
        input logic [7:0] b;  // Multiplicando

        logic [7:0] p;    // Producto parcial
        logic [7:0] hi_bit_set;
        integer i;

        begin
            p = 8'h00;
            for (i = 0; i < 8; i = i + 1) begin
                if (b[0] == 1)
                    p = p ^ a;
                hi_bit_set = a[7];
                a = a << 1;
                if (hi_bit_set == 1)
                    a = a ^ 8'h1b;  // XOR con el polinomio irreducible 0x1b
                b = b >> 1;
            end
            galois_mult = p;
        end
    endfunction

    // Proceso para calcular la multiplicación fila x columna
    always @(*) begin
        case (col_idx)
            2'b00: result = galois_mult(MixMatrix[row_idx][0], col_in0);
            2'b01: result = galois_mult(MixMatrix[row_idx][1], col_in1);
            2'b10: result = galois_mult(MixMatrix[row_idx][2], col_in2);
            2'b11: result = galois_mult(MixMatrix[row_idx][3], col_in3);
            default: result = 8'h00;
        endcase
    end
endmodule




/*
module mixColumns(
    input  logic [1:0] row,        
    input  logic [7:0] col_in0,    
    input  logic [7:0] col_in1,    
    input  logic [7:0] col_in2,    
    input  logic [7:0] col_in3,    
    output logic [7:0] col_out     
);

    logic [7:0] coeff0, coeff1, coeff2, coeff3; 
    logic [7:0] res0, res1, res2, res3;         

    
    always_comb begin
        case (row)
            2'b00: begin 
                coeff0 = 8'h02;
                coeff1 = 8'h03;
                coeff2 = 8'h01; 
                coeff3 = 8'h01;
            end
            2'b01: begin 
                coeff0 = 8'h01;
                coeff1 = 8'h02;
                coeff2 = 8'h03;
                coeff3 = 8'h01;
            end
            2'b10: begin 
                coeff0 = 8'h01;
                coeff1 = 8'h01;
                coeff2 = 8'h02;
                coeff3 = 8'h03;
            end
            2'b11: begin 
                coeff0 = 8'h03;
                coeff1 = 8'h01;
                coeff2 = 8'h01;
                coeff3 = 8'h02;
            end
            default: begin
                coeff0 = 8'h00; 
                coeff1 = 8'h00;
                coeff2 = 8'h00;
                coeff3 = 8'h00;
            end
        endcase
    end

    
    always_comb begin
        
        res0 = galois_mult(coeff0, col_in0);  
        res1 = galois_mult(coeff1, col_in1);
        res2 = galois_mult(coeff2, col_in2);
        res3 = galois_mult(coeff3, col_in3);

       
        col_out = res0 ^ res1 ^ res2 ^ res3;
    end

    // Función para realizar la multiplicación en el campo de Galois GF(2^8)
    function automatic logic [7:0] galois_mult(input logic [7:0] a, input logic [7:0] b);
        logic [7:0] p;
        logic [7:0] hi_bit_set;
        integer i;
        begin
            p = 8'h00;
            hi_bit_set = 8'h1B;  
            for (i = 0; i < 8; i = i + 1) begin
                if (b[0] == 1'b1) begin
                    p = p ^ a; 
                end
                hi_bit_set = (a & 8'h80) ? hi_bit_set : 8'h00;
                a = (a << 1) ^ hi_bit_set;
                b = b >> 1;
            end
            galois_mult = p;
        end
    endfunction

endmodule
*/
