vlib work
vlog DSP48A1.v DSP48A1_tb.v reg_mux.v 
vsim -voptargs=+acc work.DSP48A1_tb
add wave *
run -all
#quit -sim