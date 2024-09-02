module aes_preprocessor (
    input logic clk,
    input logic rst_n,
    output logic [127:0] aes_key,
    output logic [127:0] aes_value
);
    // Memory file to load
    parameter string MEM_FILE = "aes_data.mem";

    // Registers to store the key and value
    logic [127:0] key_reg;
    logic [127:0] value_reg;

    // Initialize the memory from the external file
    initial begin
        $readmemh(MEM_FILE, {key_reg, value_reg});
    end

    // Output the key and value
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            aes_key <= 128'b0;
            aes_value <= 128'b0;
        end else begin
            aes_key <= key_reg;
            aes_value <= value_reg;
        end
    end
endmodule
