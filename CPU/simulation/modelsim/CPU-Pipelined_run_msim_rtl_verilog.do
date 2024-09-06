transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/Joseph/Documents/ProyectosQuartus/Arch2P1IS2024\ -\ Copy/CPU/memory {C:/Users/Joseph/Documents/ProyectosQuartus/Arch2P1IS2024 - Copy/CPU/memory/ROM.v}
vlog -vlog01compat -work work +incdir+C:/Users/Joseph/Documents/ProyectosQuartus/Arch2P1IS2024\ -\ Copy/CPU/memory {C:/Users/Joseph/Documents/ProyectosQuartus/Arch2P1IS2024 - Copy/CPU/memory/RAM.v}
vlog -sv -work work +incdir+C:/Users/Joseph/Documents/ProyectosQuartus/Arch2P1IS2024\ -\ Copy/CPU/core {C:/Users/Joseph/Documents/ProyectosQuartus/Arch2P1IS2024 - Copy/CPU/core/Regfile_vector.sv}
vlog -sv -work work +incdir+C:/Users/Joseph/Documents/ProyectosQuartus/Arch2P1IS2024\ -\ Copy/CPU/core {C:/Users/Joseph/Documents/ProyectosQuartus/Arch2P1IS2024 - Copy/CPU/core/MemoryLoader.sv}
vlog -sv -work work +incdir+C:/Users/Joseph/Documents/ProyectosQuartus/Arch2P1IS2024\ -\ Copy/CPU {C:/Users/Joseph/Documents/ProyectosQuartus/Arch2P1IS2024 - Copy/CPU/top.sv}
vlog -sv -work work +incdir+C:/Users/Joseph/Documents/ProyectosQuartus/Arch2P1IS2024\ -\ Copy/CPU/core {C:/Users/Joseph/Documents/ProyectosQuartus/Arch2P1IS2024 - Copy/CPU/core/PC_register.sv}
vlog -sv -work work +incdir+C:/Users/Joseph/Documents/ProyectosQuartus/Arch2P1IS2024\ -\ Copy/CPU/core {C:/Users/Joseph/Documents/ProyectosQuartus/Arch2P1IS2024 - Copy/CPU/core/mux_2inputs.sv}
vlog -sv -work work +incdir+C:/Users/Joseph/Documents/ProyectosQuartus/Arch2P1IS2024\ -\ Copy/CPU/core {C:/Users/Joseph/Documents/ProyectosQuartus/Arch2P1IS2024 - Copy/CPU/core/FetchDecode_register.sv}
vlog -sv -work work +incdir+C:/Users/Joseph/Documents/ProyectosQuartus/Arch2P1IS2024\ -\ Copy/CPU/core {C:/Users/Joseph/Documents/ProyectosQuartus/Arch2P1IS2024 - Copy/CPU/core/Regfile_scalar.sv}
vlog -sv -work work +incdir+C:/Users/Joseph/Documents/ProyectosQuartus/Arch2P1IS2024\ -\ Copy/CPU/core {C:/Users/Joseph/Documents/ProyectosQuartus/Arch2P1IS2024 - Copy/CPU/core/controlUnit.sv}
vlog -sv -work work +incdir+C:/Users/Joseph/Documents/ProyectosQuartus/Arch2P1IS2024\ -\ Copy/CPU/core {C:/Users/Joseph/Documents/ProyectosQuartus/Arch2P1IS2024 - Copy/CPU/core/DecodeExecute_register.sv}
vlog -sv -work work +incdir+C:/Users/Joseph/Documents/ProyectosQuartus/Arch2P1IS2024\ -\ Copy/CPU/core {C:/Users/Joseph/Documents/ProyectosQuartus/Arch2P1IS2024 - Copy/CPU/core/ALU.sv}
vlog -sv -work work +incdir+C:/Users/Joseph/Documents/ProyectosQuartus/Arch2P1IS2024\ -\ Copy/CPU/core {C:/Users/Joseph/Documents/ProyectosQuartus/Arch2P1IS2024 - Copy/CPU/core/adder.sv}
vlog -sv -work work +incdir+C:/Users/Joseph/Documents/ProyectosQuartus/Arch2P1IS2024\ -\ Copy/CPU/core {C:/Users/Joseph/Documents/ProyectosQuartus/Arch2P1IS2024 - Copy/CPU/core/ExecuteMemory_register.sv}
vlog -sv -work work +incdir+C:/Users/Joseph/Documents/ProyectosQuartus/Arch2P1IS2024\ -\ Copy/CPU/core {C:/Users/Joseph/Documents/ProyectosQuartus/Arch2P1IS2024 - Copy/CPU/core/MemoryWriteback_register.sv}
vlog -sv -work work +incdir+C:/Users/Joseph/Documents/ProyectosQuartus/Arch2P1IS2024\ -\ Copy/CPU/core {C:/Users/Joseph/Documents/ProyectosQuartus/Arch2P1IS2024 - Copy/CPU/core/comparator_branch.sv}
vlog -sv -work work +incdir+C:/Users/Joseph/Documents/ProyectosQuartus/Arch2P1IS2024\ -\ Copy/CPU/core {C:/Users/Joseph/Documents/ProyectosQuartus/Arch2P1IS2024 - Copy/CPU/core/mux_3inputs.sv}
vlog -sv -work work +incdir+C:/Users/Joseph/Documents/ProyectosQuartus/Arch2P1IS2024\ -\ Copy/CPU/core {C:/Users/Joseph/Documents/ProyectosQuartus/Arch2P1IS2024 - Copy/CPU/core/hazard_detection_unit.sv}
vlog -sv -work work +incdir+C:/Users/Joseph/Documents/ProyectosQuartus/Arch2P1IS2024\ -\ Copy/CPU/core {C:/Users/Joseph/Documents/ProyectosQuartus/Arch2P1IS2024 - Copy/CPU/core/forwarding_unit.sv}
vlog -sv -work work +incdir+C:/Users/Joseph/Documents/ProyectosQuartus/Arch2P1IS2024\ -\ Copy/CPU/core {C:/Users/Joseph/Documents/ProyectosQuartus/Arch2P1IS2024 - Copy/CPU/core/zeroExtend.sv}

vlog -sv -work work +incdir+C:/Users/Joseph/Documents/ProyectosQuartus/Arch2P1IS2024\ -\ Copy/CPU/testbenches {C:/Users/Joseph/Documents/ProyectosQuartus/Arch2P1IS2024 - Copy/CPU/testbenches/cpu_top_tb.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  cpu_top_tb

add wave *
view structure
view signals
run -all
