onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /top_tb/clk
add wave -noupdate /top_tb/srst
add wave -noupdate /top_tb/srst_done
add wave -noupdate /top_tb/data_input
add wave -noupdate /top_tb/data_val_input
add wave -noupdate /top_tb/data_output
add wave -noupdate /top_tb/data_val_output
add wave -noupdate /top_tb/test_succeed
add wave -noupdate /top_tb/cb/cb_event
add wave -noupdate /top_tb/display_error/in
add wave -noupdate /top_tb/display_error/out
add wave -noupdate /top_tb/raise_transaction_strobe/data_to_send
add wave -noupdate /top_tb/raise_transaction_strobe/delay
add wave -noupdate /top_tb/compare_data/i_data
add wave -noupdate /top_tb/compare_data/o_data
add wave -noupdate /top_tb/generate_transactions/data_to_send
add wave -noupdate /top_tb/send_data/data_to_send
add wave -noupdate /top_tb/send_data/no_delay
add wave -noupdate /top_tb/read_data/recieved_data
add wave -noupdate /top_tb/read_data/time_without_data
add wave -noupdate /top_tb/DUT/clk_i
add wave -noupdate /top_tb/DUT/srst_i
add wave -noupdate /top_tb/DUT/data_i
add wave -noupdate /top_tb/DUT/data_val_i
add wave -noupdate /top_tb/DUT/data_o
add wave -noupdate /top_tb/DUT/data_val_o
add wave -noupdate /top_tb/DUT/data_i_buf
add wave -noupdate -radix unsigned /top_tb/DUT/buffers
add wave -noupdate {/top_tb/DUT/initial_count[7]/sc0/data_i}
add wave -noupdate {/top_tb/DUT/initial_count[7]/sc0/data_o}
add wave -noupdate {/top_tb/DUT/initial_count[6]/sc0/data_i}
add wave -noupdate {/top_tb/DUT/initial_count[6]/sc0/data_o}
add wave -noupdate {/top_tb/DUT/initial_count[5]/sc0/data_i}
add wave -noupdate {/top_tb/DUT/initial_count[5]/sc0/data_o}
add wave -noupdate {/top_tb/DUT/initial_count[4]/sc0/data_i}
add wave -noupdate {/top_tb/DUT/initial_count[4]/sc0/data_o}
add wave -noupdate {/top_tb/DUT/initial_count[3]/sc0/data_i}
add wave -noupdate {/top_tb/DUT/initial_count[3]/sc0/data_o}
add wave -noupdate {/top_tb/DUT/initial_count[2]/sc0/data_i}
add wave -noupdate {/top_tb/DUT/initial_count[2]/sc0/data_o}
add wave -noupdate {/top_tb/DUT/initial_count[1]/sc0/data_i}
add wave -noupdate {/top_tb/DUT/initial_count[1]/sc0/data_o}
add wave -noupdate {/top_tb/DUT/initial_count[0]/sc0/data_i}
add wave -noupdate {/top_tb/DUT/initial_count[0]/sc0/data_o}
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {159 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {1 ns}
