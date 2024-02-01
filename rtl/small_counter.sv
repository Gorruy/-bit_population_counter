module small_counter #(
  parameter OUT_DATA_SIZE = 4
)(
  input  logic [3:0]                 data_i,

  output logic [OUT_DATA_SIZE - 1:0] data_o
);

  assign data_o = data_i[0] + data_i[1] + data_i[2] + data_i[3];

endmodule
