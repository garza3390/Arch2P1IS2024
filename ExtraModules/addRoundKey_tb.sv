<<<<<<< HEAD
module addRoundKey_tb;
    logic [7:0] in1;    
    logic [7:0] in2;    
    logic [7:0] out;    

    
    addRoundKey #(8) addRoundKey_inst (
        .in1(in1),
        .in2(in2),
        .out(out)
    );

    initial begin
        // Valores de prueba
        in1 = 8'hCB;
        in2 = 8'h9B;

        #10;  
        $display("in1: %h", in1);
        $display("in2: %h", in2);
        $display("out: %h", out);  // Muestra la salida del XOR deberia ser 50
=======
`timescale 1ns / 1ps

module tb_AddRoundKey();

    // Parámetros
    localparam N = 127;

    // Señales del DUT (Device Under Test)
    logic [N:0] state_matrix;
    logic [N:0] round_key;
    logic [N:0] result_matrix;

    // Instancia del módulo AddRoundKey
    AddRoundKey #(N) dut (
        .state_matrix(state_matrix),
        .round_key(round_key),
        .result_matrix(result_matrix)
    );

    // Procedimiento inicial
    initial begin
        // Mostrar inicio de simulación
        $display("Iniciando simulación...");

        // Asignamos valores conocidos para la matriz de estado y la clave
        state_matrix = 128'hCBE1CB980DE8EB75BAE9C6;
        round_key = 128'h9BFEDEBCFE86EFBCCCB8CC81F2;

        // Mostramos el valor inicial de la matriz de estado y la clave
        $display("Matriz de estado inicial: %h", state_matrix);
        $display("Clave de vuelta 1: %h", round_key);

        // Esperamos unos ciclos para observar los resultados
        #10;

        // Mostramos el resultado de AddRoundKey
        $display("Resultado de AddRoundKey: %h", result_matrix);

        // Verificamos si el resultado es correcto (calculado de antemano)
        if (result_matrix == 128'h501F1524F306079D16) begin
            $display("Test PASSED.");
        end else begin
            $display("Test FAILED.");
        end

        // Terminamos la simulación
        $finish;
>>>>>>> 9f69a0ad487faacf770c87881b87b355062eaab4
    end
endmodule
