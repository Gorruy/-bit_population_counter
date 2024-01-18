module deserializer #(
  parameter WIDTH = 16
)(
  input  logic               clk_i,
  input  logic               srst_i,

  input  logic               data_i,
  input  logic               data_val_i,
  output logic [WIDTH - 1:0] deser_data_o,
  output logic               deser_data_val_o
);

  localparam NUMBER_OF_ITERATIONS = $clog2(WIDTH);

  always_comb 
    begin
      window_size = 2;
      for ( int i = 0; i < NUMBER_OF_ITERATIONS; i++) begin
        for ( int k = 0; k < WIDTH >> i; k ++ )
          begin
            data_i <= 1;
          end
      end
    end
endmodule
