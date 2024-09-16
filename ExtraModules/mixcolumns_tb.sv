`timescale 1ns / 1ps

module tb_mixColumns();

    // Parámetros
    localparam N = 127; // Definimos el tamaño de la matriz de estado

    // Señales del DUT (Device Under Test)
    logic [N:0] state_matrix_in;    // Entrada de la matriz de estado
    logic [N:0] state_matrix_out;   // Salida de la matriz de estado

    // Instancia del módulo `mixColumns`
    mixColumns #(N) dut (
        .state_matrix_in(state_matrix_in),
        .state_matrix_out(state_matrix_out)
    );

    // Procedimiento inicial
    initial begin
        // Mostrar el inicio de la simulación
        $display("Iniciando simulación...");

        // Matriz de estado de prueba (4x4 bytes = 128 bits)
        // Cada byte corresponde a una fila de la matriz de estado
        // Ejemplo de datos de entrada (puedes modificar según tus pruebas)
        state_matrix_in = 128'hd4bf5d30e0b452aeb84111f1b8f27988;  // Valor conocido para verificar

        // Mostramos el valor inicial de la matriz de estado
        $display("Matriz de estado inicial: %h", state_matrix_in);

        // Esperamos unos ciclos de simulación para observar los resultados
        #10;

        // Mostramos el valor de salida después de aplicar `mixColumns`
        $display("Matriz de estado después de mixColumns: %h", state_matrix_out);

        // Comparamos el valor de salida con el esperado (valor de referencia)
        // Puedes calcular los valores de salida esperados para verificar
        // aquí si el resultado es correcto según la transformación de AES.
        // Ejemplo (el valor exacto dependerá del test y la implementación)
        // Comparación (esto debe ser calculado previamente)
        if (state_matrix_out == 128'h046681e5e0cb199a48f8d37a2806264c) begin
            $display("Test PASSED.");
        end else begin
            $display("Test FAILED. Resultado esperado: 046681e5e0cb199a48f8d37a2806264c");
        end

        // Terminamos la simulación
        $finish;
    end
endmodule
