module bit_population_counter #(
  parameter WIDTH = 16
)(
  input  logic                   clk_i,
  input  logic                   srst_i,

  input  logic [WIDTH - 1:0]     data_i,
  input  logic                   data_val_i,

  output logic [$clog2(WIDTH):0] data_o,
  output logic                   data_val_o
);

  always_ff @( posedge clk_i )
    begin
      if ( data_val_i )
        data_val_o <= 1'b1;
      else
        data_val_o <= 1'b0;
    end

  always_comb 
    begin
      if ( data_val_i )
        begin
          data_o = '0;
          for ( int i = 0; i < WIDTH; i++) begin
            data_o += data_i[i];
          end
        end
    end
endmodule
