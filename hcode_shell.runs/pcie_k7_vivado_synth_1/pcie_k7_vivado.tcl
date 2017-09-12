# 
# Synthesis run script generated by Vivado
# 

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
set_msg_config -msgmgr_mode ooc_run
create_project -in_memory -part xc7vx485tffg1761-2

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir /home/cho/hCODE_dev/hFPGA_z83/shell-vc707-xillybus-ap_fifo128-2ports/hcode_shell.cache/wt [current_project]
set_property parent.project_path /home/cho/hCODE_dev/hFPGA_z83/shell-vc707-xillybus-ap_fifo128-2ports/hcode_shell.xpr [current_project]
set_property XPM_LIBRARIES {XPM_CDC XPM_MEMORY} [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property ip_cache_permissions disable [current_project]
read_ip -quiet /home/cho/hCODE_dev/hFPGA_z83/shell-vc707-xillybus-ap_fifo128-2ports/core/pcie_k7_vivado/pcie_k7_vivado.xci
set_property is_locked true [get_files /home/cho/hCODE_dev/hFPGA_z83/shell-vc707-xillybus-ap_fifo128-2ports/core/pcie_k7_vivado/pcie_k7_vivado.xci]

foreach dcp [get_files -quiet -all *.dcp] {
  set_property used_in_implementation false $dcp
}
read_xdc dont_touch.xdc
set_property used_in_implementation false [get_files dont_touch.xdc]

synth_design -top pcie_k7_vivado -part xc7vx485tffg1761-2 -mode out_of_context

rename_ref -prefix_all pcie_k7_vivado_

write_checkpoint -force -noxdef pcie_k7_vivado.dcp

catch { report_utilization -file pcie_k7_vivado_utilization_synth.rpt -pb pcie_k7_vivado_utilization_synth.pb }

if { [catch {
  write_verilog -force -mode synth_stub /home/cho/hCODE_dev/hFPGA_z83/shell-vc707-xillybus-ap_fifo128-2ports/hcode_shell.runs/pcie_k7_vivado_synth_1/pcie_k7_vivado_stub.v
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create a Verilog synthesis stub for the sub-design. This may lead to errors in top level synthesis of the design. Error reported: $_RESULT"
}

if { [catch {
  write_vhdl -force -mode synth_stub /home/cho/hCODE_dev/hFPGA_z83/shell-vc707-xillybus-ap_fifo128-2ports/hcode_shell.runs/pcie_k7_vivado_synth_1/pcie_k7_vivado_stub.vhdl
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create a VHDL synthesis stub for the sub-design. This may lead to errors in top level synthesis of the design. Error reported: $_RESULT"
}

if { [catch {
  write_verilog -force -mode funcsim /home/cho/hCODE_dev/hFPGA_z83/shell-vc707-xillybus-ap_fifo128-2ports/hcode_shell.runs/pcie_k7_vivado_synth_1/pcie_k7_vivado_sim_netlist.v
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create the Verilog functional simulation sub-design file. Post-Synthesis Functional Simulation with this file may not be possible or may give incorrect results. Error reported: $_RESULT"
}

if { [catch {
  write_vhdl -force -mode funcsim /home/cho/hCODE_dev/hFPGA_z83/shell-vc707-xillybus-ap_fifo128-2ports/hcode_shell.runs/pcie_k7_vivado_synth_1/pcie_k7_vivado_sim_netlist.vhdl
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create the VHDL functional simulation sub-design file. Post-Synthesis Functional Simulation with this file may not be possible or may give incorrect results. Error reported: $_RESULT"
}

add_files /home/cho/hCODE_dev/hFPGA_z83/shell-vc707-xillybus-ap_fifo128-2ports/hcode_shell.runs/pcie_k7_vivado_synth_1/pcie_k7_vivado_stub.v -of_objects [get_files /home/cho/hCODE_dev/hFPGA_z83/shell-vc707-xillybus-ap_fifo128-2ports/core/pcie_k7_vivado/pcie_k7_vivado.xci]

add_files /home/cho/hCODE_dev/hFPGA_z83/shell-vc707-xillybus-ap_fifo128-2ports/hcode_shell.runs/pcie_k7_vivado_synth_1/pcie_k7_vivado_stub.vhdl -of_objects [get_files /home/cho/hCODE_dev/hFPGA_z83/shell-vc707-xillybus-ap_fifo128-2ports/core/pcie_k7_vivado/pcie_k7_vivado.xci]

add_files /home/cho/hCODE_dev/hFPGA_z83/shell-vc707-xillybus-ap_fifo128-2ports/hcode_shell.runs/pcie_k7_vivado_synth_1/pcie_k7_vivado_sim_netlist.v -of_objects [get_files /home/cho/hCODE_dev/hFPGA_z83/shell-vc707-xillybus-ap_fifo128-2ports/core/pcie_k7_vivado/pcie_k7_vivado.xci]

add_files /home/cho/hCODE_dev/hFPGA_z83/shell-vc707-xillybus-ap_fifo128-2ports/hcode_shell.runs/pcie_k7_vivado_synth_1/pcie_k7_vivado_sim_netlist.vhdl -of_objects [get_files /home/cho/hCODE_dev/hFPGA_z83/shell-vc707-xillybus-ap_fifo128-2ports/core/pcie_k7_vivado/pcie_k7_vivado.xci]

add_files /home/cho/hCODE_dev/hFPGA_z83/shell-vc707-xillybus-ap_fifo128-2ports/hcode_shell.runs/pcie_k7_vivado_synth_1/pcie_k7_vivado.dcp -of_objects [get_files /home/cho/hCODE_dev/hFPGA_z83/shell-vc707-xillybus-ap_fifo128-2ports/core/pcie_k7_vivado/pcie_k7_vivado.xci]

if {[file isdir /media/cho/f0449460-b73b-4e00-8126-7c61713f4090/home/cho/try_pcie/hls2/testMergeStream/ip-mergesorter-32bit/shell/hcode_shell.ip_user_files/ip/pcie_k7_vivado]} {
  catch { 
    file copy -force /home/cho/hCODE_dev/hFPGA_z83/shell-vc707-xillybus-ap_fifo128-2ports/hcode_shell.runs/pcie_k7_vivado_synth_1/pcie_k7_vivado_sim_netlist.v /media/cho/f0449460-b73b-4e00-8126-7c61713f4090/home/cho/try_pcie/hls2/testMergeStream/ip-mergesorter-32bit/shell/hcode_shell.ip_user_files/ip/pcie_k7_vivado
  }
}

if {[file isdir /media/cho/f0449460-b73b-4e00-8126-7c61713f4090/home/cho/try_pcie/hls2/testMergeStream/ip-mergesorter-32bit/shell/hcode_shell.ip_user_files/ip/pcie_k7_vivado]} {
  catch { 
    file copy -force /home/cho/hCODE_dev/hFPGA_z83/shell-vc707-xillybus-ap_fifo128-2ports/hcode_shell.runs/pcie_k7_vivado_synth_1/pcie_k7_vivado_sim_netlist.vhdl /media/cho/f0449460-b73b-4e00-8126-7c61713f4090/home/cho/try_pcie/hls2/testMergeStream/ip-mergesorter-32bit/shell/hcode_shell.ip_user_files/ip/pcie_k7_vivado
  }
}

if {[file isdir /media/cho/f0449460-b73b-4e00-8126-7c61713f4090/home/cho/try_pcie/hls2/testMergeStream/ip-mergesorter-32bit/shell/hcode_shell.ip_user_files/ip/pcie_k7_vivado]} {
  catch { 
    file copy -force /home/cho/hCODE_dev/hFPGA_z83/shell-vc707-xillybus-ap_fifo128-2ports/hcode_shell.runs/pcie_k7_vivado_synth_1/pcie_k7_vivado_stub.v /media/cho/f0449460-b73b-4e00-8126-7c61713f4090/home/cho/try_pcie/hls2/testMergeStream/ip-mergesorter-32bit/shell/hcode_shell.ip_user_files/ip/pcie_k7_vivado
  }
}

if {[file isdir /media/cho/f0449460-b73b-4e00-8126-7c61713f4090/home/cho/try_pcie/hls2/testMergeStream/ip-mergesorter-32bit/shell/hcode_shell.ip_user_files/ip/pcie_k7_vivado]} {
  catch { 
    file copy -force /home/cho/hCODE_dev/hFPGA_z83/shell-vc707-xillybus-ap_fifo128-2ports/hcode_shell.runs/pcie_k7_vivado_synth_1/pcie_k7_vivado_stub.vhdl /media/cho/f0449460-b73b-4e00-8126-7c61713f4090/home/cho/try_pcie/hls2/testMergeStream/ip-mergesorter-32bit/shell/hcode_shell.ip_user_files/ip/pcie_k7_vivado
  }
}
