module mixColumns #(N=127)(
    input logic [N:0] state_matrix_in,   // Matriz de estado de entrada (128 bits)
    output logic [N:0] state_matrix_out  // Matriz de estado de salida (128 bits)
);
    // Constante de mixColumns
    logic [7:0] const_matrix [3:0][3:0]; // Matriz constante de mixColumns

    // Inicialización de la matriz constante (valores en hexadecimal)
    initial begin
        const_matrix[0][0] = 8'h02; const_matrix[0][1] = 8'h03; const_matrix[0][2] = 8'h01; const_matrix[0][3] = 8'h01;
        const_matrix[1][0] = 8'h01; const_matrix[1][1] = 8'h02; const_matrix[1][2] = 8'h03; const_matrix[1][3] = 8'h01;
        const_matrix[2][0] = 8'h01; const_matrix[2][1] = 8'h01; const_matrix[2][2] = 8'h02; const_matrix[2][3] = 8'h03;
        const_matrix[3][0] = 8'h03; const_matrix[3][1] = 8'h01; const_matrix[3][2] = 8'h01; const_matrix[3][3] = 8'h02;
    end

    // División de la matriz de estado en columnas (cada columna de 32 bits)
    logic [31:0] col1_in, col2_in, col3_in, col4_in;
    assign col1_in = state_matrix_in[127:96];
    assign col2_in = state_matrix_in[95:64];
    assign col3_in = state_matrix_in[63:32];
    assign col4_in = state_matrix_in[31:0];

    // Columnas de salida tras mixColumns
    logic [31:0] col1_out, col2_out, col3_out, col4_out;

    // Función para realizar multiplicación en el campo de Galois (GF(2^8))
    function logic [7:0] galois_mult(input logic [7:0] a, input logic [7:0] b);
        logic [7:0] p;
        logic carry;
        integer i;
        begin
            p = 8'h00;
            for (i = 0; i < 8; i = i + 1) begin
                if (b[0] == 1)
                    p = p ^ a;
                carry = a[7];  // Verificamos si hay acarreo
                a = a << 1;
                if (carry)
                    a = a ^ 8'h1b;  // Reducimos módulo del polinomio irreducible AES (0x1b)
                b = b >> 1;
            end
            galois_mult = p;
        end
    endfunction

    // Proceso de mixColumns para cada columna
    always_comb begin
        // MixColumns para la primera columna
        col1_out[31:24] = galois_mult(const_matrix[0][0], col1_in[31:24]) ^ galois_mult(const_matrix[0][1], col1_in[23:16]) ^ galois_mult(const_matrix[0][2], col1_in[15:8]) ^ galois_mult(const_matrix[0][3], col1_in[7:0]);
        col1_out[23:16] = galois_mult(const_matrix[1][0], col1_in[31:24]) ^ galois_mult(const_matrix[1][1], col1_in[23:16]) ^ galois_mult(const_matrix[1][2], col1_in[15:8]) ^ galois_mult(const_matrix[1][3], col1_in[7:0]);
        col1_out[15:8]  = galois_mult(const_matrix[2][0], col1_in[31:24]) ^ galois_mult(const_matrix[2][1], col1_in[23:16]) ^ galois_mult(const_matrix[2][2], col1_in[15:8]) ^ galois_mult(const_matrix[2][3], col1_in[7:0]);
        col1_out[7:0]   = galois_mult(const_matrix[3][0], col1_in[31:24]) ^ galois_mult(const_matrix[3][1], col1_in[23:16]) ^ galois_mult(const_matrix[3][2], col1_in[15:8]) ^ galois_mult(const_matrix[3][3], col1_in[7:0]);

        // MixColumns para la segunda columna
        col2_out[31:24] = galois_mult(const_matrix[0][0], col2_in[31:24]) ^ galois_mult(const_matrix[0][1], col2_in[23:16]) ^ galois_mult(const_matrix[0][2], col2_in[15:8]) ^ galois_mult(const_matrix[0][3], col2_in[7:0]);
        col2_out[23:16] = galois_mult(const_matrix[1][0], col2_in[31:24]) ^ galois_mult(const_matrix[1][1], col2_in[23:16]) ^ galois_mult(const_matrix[1][2], col2_in[15:8]) ^ galois_mult(const_matrix[1][3], col2_in[7:0]);
        col2_out[15:8]  = galois_mult(const_matrix[2][0], col2_in[31:24]) ^ galois_mult(const_matrix[2][1], col2_in[23:16]) ^ galois_mult(const_matrix[2][2], col2_in[15:8]) ^ galois_mult(const_matrix[2][3], col2_in[7:0]);
        col2_out[7:0]   = galois_mult(const_matrix[3][0], col2_in[31:24]) ^ galois_mult(const_matrix[3][1], col2_in[23:16]) ^ galois_mult(const_matrix[3][2], col2_in[15:8]) ^ galois_mult(const_matrix[3][3], col2_in[7:0]);

        // MixColumns para la tercera columna
        col3_out[31:24] = galois_mult(const_matrix[0][0], col3_in[31:24]) ^ galois_mult(const_matrix[0][1], col3_in[23:16]) ^ galois_mult(const_matrix[0][2], col3_in[15:8]) ^ galois_mult(const_matrix[0][3], col3_in[7:0]);
        col3_out[23:16] = galois_mult(const_matrix[1][0], col3_in[31:24]) ^ galois_mult(const_matrix[1][1], col3_in[23:16]) ^ galois_mult(const_matrix[1][2], col3_in[15:8]) ^ galois_mult(const_matrix[1][3], col3_in[7:0]);
        col3_out[15:8]  = galois_mult(const_matrix[2][0], col3_in[31:24]) ^ galois_mult(const_matrix[2][1], col3_in[23:16]) ^ galois_mult(const_matrix[2][2], col3_in[15:8]) ^ galois_mult(const_matrix[2][3], col3_in[7:0]);
        col3_out[7:0]   = galois_mult(const_matrix[3][0], col3_in[31:24]) ^ galois_mult(const_matrix[3][1], col3_in[23:16]) ^ galois_mult(const_matrix[3][2], col3_in[15:8]) ^ galois_mult(const_matrix[3][3], col3_in[7:0]);

        // MixColumns para la cuarta columna
        col4_out[31:24] = galois_mult(const_matrix[0][0], col4_in[31:24]) ^ galois_mult(const_matrix[0][1], col4_in[23:16]) ^ galois_mult(const_matrix[0][2], col4_in[15:8]) ^ galois_mult(const_matrix[0][3], col4_in[7:0]);
        col4_out[23:16] = galois_mult(const_matrix[1][0], col4_in[31:24]) ^ galois_mult(const_matrix[1][1], col4_in[23:16]) ^ galois_mult(const_matrix[1][2], col4_in[15:8]) ^ galois_mult(const_matrix[1][3], col4_in[7:0]);
        col4_out[15:8]  = galois_mult(const_matrix[2][0], col4_in[31:24]) ^ galois_mult(const_matrix[2][1], col4_in[23:16]) ^ galois_mult(const_matrix[2][2], col4_in[15:8]) ^ galois_mult(const_matrix[2][3], col4_in[7:0]);
        col4_out[7:0]   = galois_mult(const_matrix[3][0], col4_in[31:24]) ^ galois_mult(const_matrix[3][1], col4_in[23:16]) ^ galois_mult(const_matrix[3][2], col4_in[15:8]) ^ galois_mult(const_matrix[3][3], col4_in[7:0]);
    end

    // Reemplazo de las columnas en la matriz de estado de salida
    assign state_matrix_out = {col1_out, col2_out, col3_out, col4_out};
endmodule