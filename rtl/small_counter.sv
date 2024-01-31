module small_counter (
  input  logic [3:0] data_i,

  output logic [3:0] data_o
);

  assign data_o = data_i[0] + data_i[1] + data_i[2] + data_i[3];

endmodule
