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

  localparam WIDTH_ALLIGNED     = ((WIDTH + 3) / 4) * 4;
  localparam OUT_DATA_SIZE      = $clog2(WIDTH);
  localparam LNUMBER_OF_WINDOWS = $clog2(WIDTH_ALLIGNED / 4);

  logic [WIDTH_ALLIGNED - 1:0]                               data_i_buf;
  logic [$clog2(WIDTH_ALLIGNED) - 2:0][WIDTH_ALLIGNED - 1:0] buffers;
  logic [LNUMBER_OF_WINDOWS - 1:0]                           data_val_buf;

  assign data_i_buf = (WIDTH_ALLIGNED)'(data_i);

  genvar k;
  generate
    for ( k = 0; k < WIDTH_ALLIGNED / 4; k++ )
      begin: initial_count
        small_counter sc0 ( .data_i(data_i_buf[k*4 + 3 -: 4]), .data_o(buffers[0][k*4 + 3: k*4]) );
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
                buffers[i][(j+1)*(2**(2+i)) - 1 -: (2**(2+i))] <= ( buffers[i - 1][j*(2**(2+i)) + 2**(1+i) - 1 -:(2**(1+i))] 
                  + buffers[i - 1][j*(2**(2+i)) + 2**(2+i) - 1 -:(2**(1+i))] );
              end
          end
      end

  endgenerate

  assign data_o = (OUT_DATA_SIZE)'(buffers[LNUMBER_OF_WINDOWS]);

  always_ff @( posedge clk_i )
    begin
      if ( srst_i )
        data_val_buf <= '0;
      else
        begin
          data_val_buf[0] <= data_val_i;
          for ( int i = 1; i < LNUMBER_OF_WINDOWS; i++ )
            data_val_buf[i] <= data_val_buf[i - 1];
        end   
    end

  assign data_val_o = data_val_buf[LNUMBER_OF_WINDOWS - 1];


endmodule
