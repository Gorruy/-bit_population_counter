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

  logic [$clog2(WIDTH):0] out_data_buffer;

  always_ff @( posedge clk_i )
    begin
      if ( srst_i )
        data_val_o <= 1'b0;
      else 
        begin
          if ( data_val_i )
            begin
              data_val_o <= 1'b1;
              data_o     <= out_data_buffer;
            end
          else
            data_val_o <= 1'b0;
        end
    end

  always_comb 
    begin
      out_data_buffer = '0;
      if ( data_val_i )
        begin
          for ( int i = 0; i < WIDTH; i++) begin
            out_data_buffer += data_i[i];
          end
        end
    end
endmodule
