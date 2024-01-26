module top_tb;

  parameter NUMBER_OF_TEST_RUNS = 100;
  parameter WIDTH               = 17;

  bit                     clk;
  logic                   srst;
  bit                     srst_done;

  logic [WIDTH - 1:0]     data_input;
  logic                   data_val_input;

  logic [$clog2(WIDTH):0] data_output;
  logic                   data_val_output;

  // flag to indicate if there is an error
  bit test_succeed;

  initial forever #5 clk = !clk;

  default clocking cb @( posedge clk );
  endclocking

  initial 
    begin
      srst <= 1'b0;
      ##1;
      srst <= 1'b1;
      ##1;
      srst      <= 1'b0;
      srst_done <= 1'b1;
    end

  bit_population_counter #(
    .WIDTH      ( WIDTH           )
  ) DUT ( 
    .clk_i      ( clk             ),
    .srst_i     ( srst            ),
    .data_o     ( data_output     ),
    .data_val_o ( data_val_output ),
    .data_i     ( data_input      ),
    .data_val_i ( data_val_input  )
  );

  mailbox #( logic [$clog2(WIDTH):0] ) output_data    = new();
  mailbox #( logic [WIDTH - 1:0]     ) input_data     = new();
  mailbox #( logic [WIDTH - 1:0]     ) generated_data = new();

  function void display_error ( input logic [WIDTH - 1:0] in,  
                                input logic [$clog2(WIDTH):0] out
                              );
    $error( "expected values:%p, result value:%p", in, out );

  endfunction

  task raise_transaction_strobe( logic [WIDTH - 1:0] data_to_send ); 
    
    // data comes at random moment
    int delay;

    delay = $urandom_range(10, 0);
    ##(delay);

    data_input     = data_to_send;
    data_val_input = 1'b1;
    ## 1;
    data_input     = '0;
    data_val_input = 1'b0; 

  endtask

  task compare_data ( mailbox #( logic [WIDTH - 1:0] ) input_data,
                      mailbox #( logic [$clog2(WIDTH):0] ) output_data
                    );
    
    logic [WIDTH - 1:0]     i_data;
    logic [$clog2(WIDTH):0] o_data;

    while ( input_data.num() )
      begin
        input_data.get( i_data );
        output_data.get( o_data );

        if ( $countones(i_data) != o_data )
          begin
            display_error( i_data, o_data );
            test_succeed = 1'b0;
            return;
          end
      end
    
  endtask

  task generate_transactions ( mailbox #( logic [WIDTH - 1:0] ) generated_data );
    
    logic [WIDTH - 1:0] data_to_send;

    repeat (NUMBER_OF_TEST_RUNS) 
      begin
        data_to_send = $urandom_range(WIDTH**2, 0);
        generated_data.put( data_to_send );
      end

  endtask

  task send_data ( mailbox #( logic [WIDTH - 1:0] ) input_data,
                   mailbox #( logic [WIDTH - 1:0] ) generated_data
                 );

    logic [WIDTH - 1:0] data_to_send;
    int                 no_delay;

    while ( generated_data.num() )
      begin
        generated_data.get( data_to_send );
        
        raise_transaction_strobe( data_to_send );

        input_data.put( data_to_send );
      end

  endtask

  task read_data ( mailbox #( logic [$clog2(WIDTH):0] ) output_data );
    
    logic [$clog2(WIDTH):0] recieved_data;
    int                     time_without_data;
    
    forever
      begin
        @( posedge clk );
        if ( data_val_output === 1'b1 )
          begin
            recieved_data     = data_output;
            time_without_data = 0;
            output_data.put(recieved_data);
          end
        else
          begin
            if ( time_without_data == 11*WIDTH )
              return;
            else 
              time_without_data += 1;
          end
      end

  endtask

  initial begin
    data_input     <= '0;
    data_val_input <= 1'b0;
    test_succeed   <= 1'b1;

    generate_transactions( generated_data );

    $display("Simulation started!");
    wait( srst_done );
    fork
      read_data( output_data );
      send_data( input_data, generated_data );
    join

    compare_data( input_data, output_data );
    $display("Simulation is over!");
    if ( test_succeed )
      $display("All tests passed!");
    $stop();
  end
  



endmodule