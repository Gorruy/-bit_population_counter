module bit_population_counter #(
  parameter WIDTH = 24
)(
  input  logic                       clk_i,
  input  logic                       srst_i,

  input  logic [WIDTH - 1:0]         data_i,
  input  logic                       data_val_i,

  output logic [$clog2(WIDTH) - 1:0] data_o,
  output logic                       data_val_o
);

  localparam WIDTH_ALLIGNED     = 2**$clog2(WIDTH);
  localparam OUT_DATA_SIZE      = $clog2(WIDTH);
  localparam LNUMBER_OF_WINDOWS = $clog2(WIDTH_ALLIGNED / 4);

  logic [WIDTH_ALLIGNED - 1:0]                                             data_i_buf;
  logic [LNUMBER_OF_WINDOWS - 1:0]                                         data_val_buf;
  logic [OUT_DATA_SIZE - 2:0][WIDTH_ALLIGNED/4 - 1:0][OUT_DATA_SIZE - 1:0] buffers;

  assign data_i_buf = (WIDTH_ALLIGNED)'(data_i);

  genvar k;
  generate
    for ( k = 0; k < WIDTH_ALLIGNED / 4; k++ )
      begin: initial_count
        assign buffers[0][k] = data_i_buf[k*4] + data_i_buf[k*4 + 1] + data_i_buf[k*4 + 2] + data_i_buf[k*4 + 3];
      end
  endgenerate

  genvar i;
  generate
    for ( i = 1; i < LNUMBER_OF_WINDOWS + 1; i++ )
      begin: adding
        always_ff @( posedge clk_i )
          begin
            for ( int j = 0; j < WIDTH_ALLIGNED / (2**(2+i)); j++ )
              begin
                buffers[i][j] <= buffers[i - 1][j*2] + buffers[i - 1][j*2 + 1];
              end
          end
      end

  endgenerate

  assign data_o = buffers[LNUMBER_OF_WINDOWS][0][OUT_DATA_SIZE - 1:0];

  always_ff @( posedge clk_i )
    begin
      if ( srst_i )
        data_val_buf <= '0;
      else
        data_val_buf <= { data_val_buf[LNUMBER_OF_WINDOWS - 2:0], data_val_i };  
    end

  assign data_val_o = data_val_buf[LNUMBER_OF_WINDOWS - 1];


endmodule
