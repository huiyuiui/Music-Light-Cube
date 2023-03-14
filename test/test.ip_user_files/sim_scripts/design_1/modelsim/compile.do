vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/xpm
vlib modelsim_lib/msim/xil_defaultlib
vlib modelsim_lib/msim/xlslice_v1_0_2
vlib modelsim_lib/msim/xlconstant_v1_1_7

vmap xpm modelsim_lib/msim/xpm
vmap xil_defaultlib modelsim_lib/msim/xil_defaultlib
vmap xlslice_v1_0_2 modelsim_lib/msim/xlslice_v1_0_2
vmap xlconstant_v1_1_7 modelsim_lib/msim/xlconstant_v1_1_7

vlog -work xpm  -incr -sv "+incdir+../../../../test.gen/sources_1/bd/design_1/ipshared/d0f7" "+incdir+../../../../test.gen/sources_1/bd/design_1/ipshared/1b7e/hdl/verilog" "+incdir+../../../../test.gen/sources_1/bd/design_1/ipshared/122e/hdl/verilog" "+incdir+../../../../test.gen/sources_1/bd/design_1/ipshared/b205/hdl/verilog" "+incdir+../../../../test.gen/sources_1/bd/design_1/ipshared/c968/hdl/verilog" \
"C:/Xilinx/Vivado/2020.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"C:/Xilinx/Vivado/2020.2/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm  -93 \
"C:/Xilinx/Vivado/2020.2/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib  -incr "+incdir+../../../../test.gen/sources_1/bd/design_1/ipshared/d0f7" "+incdir+../../../../test.gen/sources_1/bd/design_1/ipshared/1b7e/hdl/verilog" "+incdir+../../../../test.gen/sources_1/bd/design_1/ipshared/122e/hdl/verilog" "+incdir+../../../../test.gen/sources_1/bd/design_1/ipshared/b205/hdl/verilog" "+incdir+../../../../test.gen/sources_1/bd/design_1/ipshared/c968/hdl/verilog" \
"../../../bd/design_1/ip/design_1_xadc_wiz_0_0/design_1_xadc_wiz_0_0.v" \
"../../../bd/design_1/ip/design_1_ila_0_0/sim/design_1_ila_0_0.v" \
"../../../bd/design_1/ip/design_1_clk_wiz_0_0/design_1_clk_wiz_0_0_clk_wiz.v" \
"../../../bd/design_1/ip/design_1_clk_wiz_0_0/design_1_clk_wiz_0_0.v" \

vlog -work xlslice_v1_0_2  -incr "+incdir+../../../../test.gen/sources_1/bd/design_1/ipshared/d0f7" "+incdir+../../../../test.gen/sources_1/bd/design_1/ipshared/1b7e/hdl/verilog" "+incdir+../../../../test.gen/sources_1/bd/design_1/ipshared/122e/hdl/verilog" "+incdir+../../../../test.gen/sources_1/bd/design_1/ipshared/b205/hdl/verilog" "+incdir+../../../../test.gen/sources_1/bd/design_1/ipshared/c968/hdl/verilog" \
"../../../../test.gen/sources_1/bd/design_1/ipshared/11d0/hdl/xlslice_v1_0_vl_rfs.v" \

vlog -work xil_defaultlib  -incr "+incdir+../../../../test.gen/sources_1/bd/design_1/ipshared/d0f7" "+incdir+../../../../test.gen/sources_1/bd/design_1/ipshared/1b7e/hdl/verilog" "+incdir+../../../../test.gen/sources_1/bd/design_1/ipshared/122e/hdl/verilog" "+incdir+../../../../test.gen/sources_1/bd/design_1/ipshared/b205/hdl/verilog" "+incdir+../../../../test.gen/sources_1/bd/design_1/ipshared/c968/hdl/verilog" \
"../../../bd/design_1/ip/design_1_xlslice_0_0/sim/design_1_xlslice_0_0.v" \

vlog -work xlconstant_v1_1_7  -incr "+incdir+../../../../test.gen/sources_1/bd/design_1/ipshared/d0f7" "+incdir+../../../../test.gen/sources_1/bd/design_1/ipshared/1b7e/hdl/verilog" "+incdir+../../../../test.gen/sources_1/bd/design_1/ipshared/122e/hdl/verilog" "+incdir+../../../../test.gen/sources_1/bd/design_1/ipshared/b205/hdl/verilog" "+incdir+../../../../test.gen/sources_1/bd/design_1/ipshared/c968/hdl/verilog" \
"../../../../test.gen/sources_1/bd/design_1/ipshared/fcfc/hdl/xlconstant_v1_1_vl_rfs.v" \

vlog -work xil_defaultlib  -incr "+incdir+../../../../test.gen/sources_1/bd/design_1/ipshared/d0f7" "+incdir+../../../../test.gen/sources_1/bd/design_1/ipshared/1b7e/hdl/verilog" "+incdir+../../../../test.gen/sources_1/bd/design_1/ipshared/122e/hdl/verilog" "+incdir+../../../../test.gen/sources_1/bd/design_1/ipshared/b205/hdl/verilog" "+incdir+../../../../test.gen/sources_1/bd/design_1/ipshared/c968/hdl/verilog" \
"../../../bd/design_1/ip/design_1_xlconstant_0_0/sim/design_1_xlconstant_0_0.v" \
"../../../bd/design_1/sim/design_1.v" \
"../../../bd/design_1/ip/design_1_xlconstant_1_0/sim/design_1_xlconstant_1_0.v" \

vlog -work xil_defaultlib \
"glbl.v"

