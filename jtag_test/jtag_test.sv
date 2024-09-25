module jtag_test (
	 input logic clk,
    input logic [1:0] A,
    input logic [1:0] B,
    output logic [2:0] SUMA
);
    assign SUMA = A + B;
endmodule
