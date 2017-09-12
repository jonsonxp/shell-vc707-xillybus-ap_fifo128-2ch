proc start_step { step } {
  set stopFile ".stop.rst"
  if {[file isfile .stop.rst]} {
    puts ""
    puts "*** Halting run - EA reset detected ***"
    puts ""
    puts ""
    return -code error
  }
  set beginFile ".$step.begin.rst"
  set platform "$::tcl_platform(platform)"
  set user "$::tcl_platform(user)"
  set pid [pid]
  set host ""
  if { [string equal $platform unix] } {
    if { [info exist ::env(HOSTNAME)] } {
      set host $::env(HOSTNAME)
    }
  } else {
    if { [info exist ::env(COMPUTERNAME)] } {
      set host $::env(COMPUTERNAME)
    }
  }
  set ch [open $beginFile w]
  puts $ch "<?xml version=\"1.0\"?>"
  puts $ch "<ProcessHandle Version=\"1\" Minor=\"0\">"
  puts $ch "    <Process Command=\".planAhead.\" Owner=\"$user\" Host=\"$host\" Pid=\"$pid\">"
  puts $ch "    </Process>"
  puts $ch "</ProcessHandle>"
  close $ch
}

proc end_step { step } {
  set endFile ".$step.end.rst"
  set ch [open $endFile w]
  close $ch
}

proc step_failed { step } {
  set endFile ".$step.error.rst"
  set ch [open $endFile w]
  close $ch
}

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000

start_step init_design
set ACTIVE_STEP init_design
set rc [catch {
  create_msg_db init_design.pb
  set_property design_mode GateLvl [current_fileset]
  set_param project.singleFileAddWarning.threshold 0
  set_property webtalk.parent_dir /home/cho/hCODE_dev/hFPGA_z83/shell-vc707-xillybus-ap_fifo128-2ports/hcode_shell.cache/wt [current_project]
  set_property parent.project_path /home/cho/hCODE_dev/hFPGA_z83/shell-vc707-xillybus-ap_fifo128-2ports/hcode_shell.xpr [current_project]
  set_property ip_cache_permissions disable [current_project]
  set_property XPM_LIBRARIES {XPM_CDC XPM_MEMORY} [current_project]
  add_files -quiet /home/cho/hCODE_dev/hFPGA_z83/shell-vc707-xillybus-ap_fifo128-2ports/hcode_shell.runs/synth_1/hcode_shell_top.dcp
  set_property edif_extra_search_paths {$PPRDIR/core} [current_fileset]
  read_edif /home/cho/hCODE_dev/hFPGA_z83/shell-vc707-xillybus-ap_fifo128-2ports/hcode_shell.srcs/sources_1/imports/2ports/xillybus_core.ngc
  add_files -quiet /home/cho/hCODE_dev/hFPGA_z83/shell-vc707-xillybus-ap_fifo128-2ports/core/clk_wiz_0/clk_wiz_0.dcp
  set_property netlist_only true [get_files /home/cho/hCODE_dev/hFPGA_z83/shell-vc707-xillybus-ap_fifo128-2ports/core/clk_wiz_0/clk_wiz_0.dcp]
  add_files -quiet /home/cho/hCODE_dev/hFPGA_z83/shell-vc707-xillybus-ap_fifo128-2ports/core/pcie_k7_vivado/pcie_k7_vivado.dcp
  set_property netlist_only true [get_files /home/cho/hCODE_dev/hFPGA_z83/shell-vc707-xillybus-ap_fifo128-2ports/core/pcie_k7_vivado/pcie_k7_vivado.dcp]
  add_files -quiet /home/cho/hCODE_dev/hFPGA_z83/shell-vc707-xillybus-ap_fifo128-2ports/core/fifo_128x512_1/fifo_128x512.dcp
  set_property netlist_only true [get_files /home/cho/hCODE_dev/hFPGA_z83/shell-vc707-xillybus-ap_fifo128-2ports/core/fifo_128x512_1/fifo_128x512.dcp]
  read_xdc -mode out_of_context -ref clk_wiz_0 -cells inst /home/cho/hCODE_dev/hFPGA_z83/shell-vc707-xillybus-ap_fifo128-2ports/core/clk_wiz_0/clk_wiz_0_ooc.xdc
  set_property processing_order EARLY [get_files /home/cho/hCODE_dev/hFPGA_z83/shell-vc707-xillybus-ap_fifo128-2ports/core/clk_wiz_0/clk_wiz_0_ooc.xdc]
  read_xdc -prop_thru_buffers -ref clk_wiz_0 -cells inst /home/cho/hCODE_dev/hFPGA_z83/shell-vc707-xillybus-ap_fifo128-2ports/core/clk_wiz_0/clk_wiz_0_board.xdc
  set_property processing_order EARLY [get_files /home/cho/hCODE_dev/hFPGA_z83/shell-vc707-xillybus-ap_fifo128-2ports/core/clk_wiz_0/clk_wiz_0_board.xdc]
  read_xdc -ref clk_wiz_0 -cells inst /home/cho/hCODE_dev/hFPGA_z83/shell-vc707-xillybus-ap_fifo128-2ports/core/clk_wiz_0/clk_wiz_0.xdc
  set_property processing_order EARLY [get_files /home/cho/hCODE_dev/hFPGA_z83/shell-vc707-xillybus-ap_fifo128-2ports/core/clk_wiz_0/clk_wiz_0.xdc]
  read_xdc -mode out_of_context -ref pcie_k7_vivado -cells inst /home/cho/hCODE_dev/hFPGA_z83/shell-vc707-xillybus-ap_fifo128-2ports/core/pcie_k7_vivado/synth/pcie_k7_vivado_ooc.xdc
  set_property processing_order EARLY [get_files /home/cho/hCODE_dev/hFPGA_z83/shell-vc707-xillybus-ap_fifo128-2ports/core/pcie_k7_vivado/synth/pcie_k7_vivado_ooc.xdc]
  read_xdc -ref pcie_k7_vivado -cells inst /home/cho/hCODE_dev/hFPGA_z83/shell-vc707-xillybus-ap_fifo128-2ports/core/pcie_k7_vivado/source/pcie_k7_vivado-PCIE_X1Y0.xdc
  set_property processing_order EARLY [get_files /home/cho/hCODE_dev/hFPGA_z83/shell-vc707-xillybus-ap_fifo128-2ports/core/pcie_k7_vivado/source/pcie_k7_vivado-PCIE_X1Y0.xdc]
  read_xdc -mode out_of_context -ref fifo_128x512 -cells U0 /home/cho/hCODE_dev/hFPGA_z83/shell-vc707-xillybus-ap_fifo128-2ports/core/fifo_128x512_1/fifo_128x512_ooc.xdc
  set_property processing_order EARLY [get_files /home/cho/hCODE_dev/hFPGA_z83/shell-vc707-xillybus-ap_fifo128-2ports/core/fifo_128x512_1/fifo_128x512_ooc.xdc]
  read_xdc -ref fifo_128x512 -cells U0 /home/cho/hCODE_dev/hFPGA_z83/shell-vc707-xillybus-ap_fifo128-2ports/core/fifo_128x512_1/fifo_128x512/fifo_128x512.xdc
  set_property processing_order EARLY [get_files /home/cho/hCODE_dev/hFPGA_z83/shell-vc707-xillybus-ap_fifo128-2ports/core/fifo_128x512_1/fifo_128x512/fifo_128x512.xdc]
  read_xdc /home/cho/hCODE_dev/hFPGA_z83/shell-vc707-xillybus-ap_fifo128-2ports/constrain/hcode_shell.xdc
  read_xdc -ref fifo_128x512 -cells U0 /home/cho/hCODE_dev/hFPGA_z83/shell-vc707-xillybus-ap_fifo128-2ports/core/fifo_128x512_1/fifo_128x512/fifo_128x512_clocks.xdc
  set_property processing_order LATE [get_files /home/cho/hCODE_dev/hFPGA_z83/shell-vc707-xillybus-ap_fifo128-2ports/core/fifo_128x512_1/fifo_128x512/fifo_128x512_clocks.xdc]
  link_design -top hcode_shell_top -part xc7vx485tffg1761-2
  write_hwdef -file hcode_shell_top.hwdef
  close_msg_db -file init_design.pb
} RESULT]
if {$rc} {
  step_failed init_design
  return -code error $RESULT
} else {
  end_step init_design
  unset ACTIVE_STEP 
}

start_step opt_design
set ACTIVE_STEP opt_design
set rc [catch {
  create_msg_db opt_design.pb
  opt_design 
  write_checkpoint -force hcode_shell_top_opt.dcp
  report_drc -file hcode_shell_top_drc_opted.rpt
  close_msg_db -file opt_design.pb
} RESULT]
if {$rc} {
  step_failed opt_design
  return -code error $RESULT
} else {
  end_step opt_design
  unset ACTIVE_STEP 
}

start_step place_design
set ACTIVE_STEP place_design
set rc [catch {
  create_msg_db place_design.pb
  implement_debug_core 
  place_design 
  write_checkpoint -force hcode_shell_top_placed.dcp
  report_io -file hcode_shell_top_io_placed.rpt
  report_utilization -file hcode_shell_top_utilization_placed.rpt -pb hcode_shell_top_utilization_placed.pb
  report_control_sets -verbose -file hcode_shell_top_control_sets_placed.rpt
  close_msg_db -file place_design.pb
} RESULT]
if {$rc} {
  step_failed place_design
  return -code error $RESULT
} else {
  end_step place_design
  unset ACTIVE_STEP 
}

start_step phys_opt_design
set ACTIVE_STEP phys_opt_design
set rc [catch {
  create_msg_db phys_opt_design.pb
  phys_opt_design 
  write_checkpoint -force hcode_shell_top_physopt.dcp
  close_msg_db -file phys_opt_design.pb
} RESULT]
if {$rc} {
  step_failed phys_opt_design
  return -code error $RESULT
} else {
  end_step phys_opt_design
  unset ACTIVE_STEP 
}

  set_msg_config -source 4 -id {Route 35-39} -severity "critical warning" -new_severity warning
start_step route_design
set ACTIVE_STEP route_design
set rc [catch {
  create_msg_db route_design.pb
  route_design 
  write_checkpoint -force hcode_shell_top_routed.dcp
  report_drc -file hcode_shell_top_drc_routed.rpt -pb hcode_shell_top_drc_routed.pb -rpx hcode_shell_top_drc_routed.rpx
  report_methodology -file hcode_shell_top_methodology_drc_routed.rpt -rpx hcode_shell_top_methodology_drc_routed.rpx
  report_timing_summary -max_paths 10 -file hcode_shell_top_timing_summary_routed.rpt -rpx hcode_shell_top_timing_summary_routed.rpx
  report_power -file hcode_shell_top_power_routed.rpt -pb hcode_shell_top_power_summary_routed.pb -rpx hcode_shell_top_power_routed.rpx
  report_route_status -file hcode_shell_top_route_status.rpt -pb hcode_shell_top_route_status.pb
  report_clock_utilization -file hcode_shell_top_clock_utilization_routed.rpt
  close_msg_db -file route_design.pb
} RESULT]
if {$rc} {
  write_checkpoint -force hcode_shell_top_routed_error.dcp
  step_failed route_design
  return -code error $RESULT
} else {
  end_step route_design
  unset ACTIVE_STEP 
}

start_step post_route_phys_opt_design
set ACTIVE_STEP post_route_phys_opt_design
set rc [catch {
  create_msg_db post_route_phys_opt_design.pb
  phys_opt_design 
  write_checkpoint -force hcode_shell_top_postroute_physopt.dcp
  report_timing_summary -warn_on_violation -max_paths 10 -file hcode_shell_top_timing_summary_postroute_physopted.rpt -rpx hcode_shell_top_timing_summary_postroute_physopted.rpx
  close_msg_db -file post_route_phys_opt_design.pb
} RESULT]
if {$rc} {
  step_failed post_route_phys_opt_design
  return -code error $RESULT
} else {
  end_step post_route_phys_opt_design
  unset ACTIVE_STEP 
}

