transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/Joseph/Documents/ProyectosQuartus/Arch2P1IS2024/CPU/memory {C:/Users/Joseph/Documents/ProyectosQuartus/Arch2P1IS2024/CPU/memory/ROM.v}
vlog -vlog01compat -work work +incdir+C:/Users/Joseph/Documents/ProyectosQuartus/Arch2P1IS2024/CPU/memory {C:/Users/Joseph/Documents/ProyectosQuartus/Arch2P1IS2024/CPU/memory/RAM.v}
vlog -sv -work work +incdir+C:/Users/Joseph/Documents/ProyectosQuartus/Arch2P1IS2024/CPU/core {C:/Users/Joseph/Documents/ProyectosQuartus/Arch2P1IS2024/CPU/core/subBytes.sv}
vlog -sv -work work +incdir+C:/Users/Joseph/Documents/ProyectosQuartus/Arch2P1IS2024/CPU/core {C:/Users/Joseph/Documents/ProyectosQuartus/Arch2P1IS2024/CPU/core/shiftRows.sv}
vlog -sv -work work +incdir+C:/Users/Joseph/Documents/ProyectosQuartus/Arch2P1IS2024/CPU/core {C:/Users/Joseph/Documents/ProyectosQuartus/Arch2P1IS2024/CPU/core/rotWord.sv}
vlog -sv -work work +incdir+C:/Users/Joseph/Documents/ProyectosQuartus/Arch2P1IS2024/CPU/core {C:/Users/Joseph/Documents/ProyectosQuartus/Arch2P1IS2024/CPU/core/Rcon.sv}
vlog -sv -work work +incdir+C:/Users/Joseph/Documents/ProyectosQuartus/Arch2P1IS2024/CPU/core {C:/Users/Joseph/Documents/ProyectosQuartus/Arch2P1IS2024/CPU/core/mixColumns.sv}
vlog -sv -work work +incdir+C:/Users/Joseph/Documents/ProyectosQuartus/Arch2P1IS2024/CPU/core {C:/Users/Joseph/Documents/ProyectosQuartus/Arch2P1IS2024/CPU/core/AddRoundKey.sv}
vlog -sv -work work +incdir+C:/Users/Joseph/Documents/ProyectosQuartus/Arch2P1IS2024/CPU {C:/Users/Joseph/Documents/ProyectosQuartus/Arch2P1IS2024/CPU/top.sv}
vlog -sv -work work +incdir+C:/Users/Joseph/Documents/ProyectosQuartus/Arch2P1IS2024/CPU/core {C:/Users/Joseph/Documents/ProyectosQuartus/Arch2P1IS2024/CPU/core/zeroExtend.sv}
vlog -sv -work work +incdir+C:/Users/Joseph/Documents/ProyectosQuartus/Arch2P1IS2024/CPU/core {C:/Users/Joseph/Documents/ProyectosQuartus/Arch2P1IS2024/CPU/core/Regfile_vector.sv}
vlog -sv -work work +incdir+C:/Users/Joseph/Documents/ProyectosQuartus/Arch2P1IS2024/CPU/core {C:/Users/Joseph/Documents/ProyectosQuartus/Arch2P1IS2024/CPU/core/Regfile_scalar.sv}
vlog -sv -work work +incdir+C:/Users/Joseph/Documents/ProyectosQuartus/Arch2P1IS2024/CPU/core {C:/Users/Joseph/Documents/ProyectosQuartus/Arch2P1IS2024/CPU/core/PC_register.sv}
vlog -sv -work work +incdir+C:/Users/Joseph/Documents/ProyectosQuartus/Arch2P1IS2024/CPU/core {C:/Users/Joseph/Documents/ProyectosQuartus/Arch2P1IS2024/CPU/core/MemoryWriteback_register.sv}
vlog -sv -work work +incdir+C:/Users/Joseph/Documents/ProyectosQuartus/Arch2P1IS2024/CPU/core {C:/Users/Joseph/Documents/ProyectosQuartus/Arch2P1IS2024/CPU/core/hazard_detection_unit.sv}
vlog -sv -work work +incdir+C:/Users/Joseph/Documents/ProyectosQuartus/Arch2P1IS2024/CPU/core {C:/Users/Joseph/Documents/ProyectosQuartus/Arch2P1IS2024/CPU/core/forwarding_unit.sv}
vlog -sv -work work +incdir+C:/Users/Joseph/Documents/ProyectosQuartus/Arch2P1IS2024/CPU/core {C:/Users/Joseph/Documents/ProyectosQuartus/Arch2P1IS2024/CPU/core/FetchDecode_register.sv}
vlog -sv -work work +incdir+C:/Users/Joseph/Documents/ProyectosQuartus/Arch2P1IS2024/CPU/core {C:/Users/Joseph/Documents/ProyectosQuartus/Arch2P1IS2024/CPU/core/ExecuteMemory_register.sv}
vlog -sv -work work +incdir+C:/Users/Joseph/Documents/ProyectosQuartus/Arch2P1IS2024/CPU/core {C:/Users/Joseph/Documents/ProyectosQuartus/Arch2P1IS2024/CPU/core/DecodeExecute_register.sv}
vlog -sv -work work +incdir+C:/Users/Joseph/Documents/ProyectosQuartus/Arch2P1IS2024/CPU/core {C:/Users/Joseph/Documents/ProyectosQuartus/Arch2P1IS2024/CPU/core/controlUnit.sv}
vlog -sv -work work +incdir+C:/Users/Joseph/Documents/ProyectosQuartus/Arch2P1IS2024/CPU/core {C:/Users/Joseph/Documents/ProyectosQuartus/Arch2P1IS2024/CPU/core/comparator_branch.sv}
vlog -sv -work work +incdir+C:/Users/Joseph/Documents/ProyectosQuartus/Arch2P1IS2024/CPU/core {C:/Users/Joseph/Documents/ProyectosQuartus/Arch2P1IS2024/CPU/core/ALU.sv}
vlog -sv -work work +incdir+C:/Users/Joseph/Documents/ProyectosQuartus/Arch2P1IS2024/CPU/core {C:/Users/Joseph/Documents/ProyectosQuartus/Arch2P1IS2024/CPU/core/adder_16.sv}
vlog -sv -work work +incdir+C:/Users/Joseph/Documents/ProyectosQuartus/Arch2P1IS2024/CPU/core {C:/Users/Joseph/Documents/ProyectosQuartus/Arch2P1IS2024/CPU/core/mux_2inputs_16bits.sv}
vlog -sv -work work +incdir+C:/Users/Joseph/Documents/ProyectosQuartus/Arch2P1IS2024/CPU/core {C:/Users/Joseph/Documents/ProyectosQuartus/Arch2P1IS2024/CPU/core/ALU_vectorial.sv}
vlog -sv -work work +incdir+C:/Users/Joseph/Documents/ProyectosQuartus/Arch2P1IS2024/CPU/core {C:/Users/Joseph/Documents/ProyectosQuartus/Arch2P1IS2024/CPU/core/mux_2inputs_20bits.sv}
vlog -sv -work work +incdir+C:/Users/Joseph/Documents/ProyectosQuartus/Arch2P1IS2024/CPU/core {C:/Users/Joseph/Documents/ProyectosQuartus/Arch2P1IS2024/CPU/core/mux_2inputs_128bits.sv}
vlog -sv -work work +incdir+C:/Users/Joseph/Documents/ProyectosQuartus/Arch2P1IS2024/CPU/core {C:/Users/Joseph/Documents/ProyectosQuartus/Arch2P1IS2024/CPU/core/substractor_branch.sv}
vlog -sv -work work +incdir+C:/Users/Joseph/Documents/ProyectosQuartus/Arch2P1IS2024/CPU/core {C:/Users/Joseph/Documents/ProyectosQuartus/Arch2P1IS2024/CPU/core/mux_3inputs_16bits.sv}
vlog -sv -work work +incdir+C:/Users/Joseph/Documents/ProyectosQuartus/Arch2P1IS2024/CPU/core {C:/Users/Joseph/Documents/ProyectosQuartus/Arch2P1IS2024/CPU/core/mux_3inputs_128bits.sv}
vlog -sv -work work +incdir+C:/Users/Joseph/Documents/ProyectosQuartus/Arch2P1IS2024/CPU/core {C:/Users/Joseph/Documents/ProyectosQuartus/Arch2P1IS2024/CPU/core/xorColumns.sv}

vlog -sv -work work +incdir+C:/Users/Joseph/Documents/ProyectosQuartus/Arch2P1IS2024/CPU/testbenches {C:/Users/Joseph/Documents/ProyectosQuartus/Arch2P1IS2024/CPU/testbenches/Memory_Stage_tb.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  Memory_Stage_tb

add wave *
view structure
view signals
run -all
