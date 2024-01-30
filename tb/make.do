vlib work

vlog -sv ../rtl/small_counter.sv
vlog -sv ../rtl/bit_population_counter.sv
vlog -sv top_tb.sv

vsim -novopt top_tb
add log -r /*
add wave -r *
run -all