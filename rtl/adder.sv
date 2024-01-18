module adder #(
  WINDOW_SIZE = 2
)(
  input  logic [WINDOW_SIZE - 1:0]   a;
  input  logic [WINDOW_SIZE - 1:0]   b;

  output logic [WINDOW_SIZE*2 - 1:0] c;
);

  assign c = (WINDOW_SIZE*2)'a + (WINDOW_SIZE*2)'b;

endmodule