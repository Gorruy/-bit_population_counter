module bit_population_counter_top (
  input  logic                clk_i,
  input  logic                srst_i,

  input  logic [127:0]         data_i,
  input  logic                data_val_i,
  output logic [$clog2(128):0] data_o,
  output logic                data_val_o
);

  logic                srst;

  logic [127:0]         data;
  logic                data_val;

  logic [$clog2(128):0] data_output;
  logic                data_val_output;

  always_ff @( posedge clk_i )
    begin
      srst     <= srst_i;
      data     <= data_i;
      data_val <= data_val_i; 
    end 

  bit_population_counter #(
    .WIDTH      ( 128              )
  ) bit_population_counter (
    .clk_i      ( clk_i           ),
    .srst_i     ( srst            ),

    .data_i     ( data            ),
    .data_val_i ( data_val        ),

    .data_o     ( data_output     ),
    .data_val_o ( data_val_output )  
);

  always_ff @( posedge clk_i )
    begin
      data_o     <= data_output;
      data_val_o <= data_val_output;
    end


endmodule
