module bit_population_counter #(
  parameter WIDTH = 24
)(
  input  logic                   clk_i,
  input  logic                   srst_i,

  input  logic [WIDTH - 1:0]     data_i,
  input  logic                   data_val_i,

  output logic [$clog2(WIDTH):0] data_o,
  output logic                   data_val_o
);

  localparam WIDTH_ALLIGNED = (WIDTH / 4) * 4;
  localparam OUT_DATA_SIZE  = $clog2(int'(WIDTH_ALLIGNED));

  logic [WIDTH_ALLIGNED - 1:0]                                                data_i_buf;
  
  logic [WIDTH_ALLIGNED / 8 - 1:0][WIDTH_ALLIGNED / 4 - 1:0][OUT_DATA_SIZE:0] buffers = '0 /* synthesis preserve */;

  assign data_i_buf = (WIDTH_ALLIGNED)'(data_i);

  genvar k;
  generate
    for ( k = 0; k < WIDTH_ALLIGNED / 4; k++ )
      begin: initial_count
        small_counter sc0 ( .data_i(data_i_buf[k*4 + 3:k*4]), .data_o(buffers[0][k][4:0]) );
      end
  endgenerate

  genvar i, j;
  generate
    for ( i = 1; i < OUT_DATA_SIZE; i++ )
      begin: adding
        always_ff @( posedge clk_i )
          begin
            for ( int j = 0; j < WIDTH_ALLIGNED / 8; j++ )
              begin
                buffers[i][j] = buffers[i - 1][j*2] + buffers[i - 1][j*2 + 1];
              end
          end
      end

  endgenerate

  always_ff @( posedge clk_i )
    begin
      data_o <= buffers[WIDTH_ALLIGNED / 8 - 1][WIDTH_ALLIGNED / 8];
    end

  always_ff @( posedge clk_i )
    begin
      if ( srst_i )
        data_val_o <= 1'b0;
      else
        begin
          if ( data_val_i )
            data_val_o <= 1'b1;
          else
            data_val_o <= 1'b0;
        end
    end


endmodule
