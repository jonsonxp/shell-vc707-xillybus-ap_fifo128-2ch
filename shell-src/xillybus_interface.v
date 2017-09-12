`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 11/09/2015 10:19:35 AM
// Design Name:
// Module Name: xillybus_interface
// Project Name:
// Target Devices:
// Tool Versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////

module xillybus_interface
  (
   /*AUTOARG*/
   // Outputs
   GPIO_LED, PCIE_TX_N, PCIE_TX_P,
   in_r_dout_1, in_r_empty_n_1, bus_clk, ip_rst_n_1,
   in_r_dout_2, in_r_empty_n_2, ip_rst_n_2,
   memarray_out,
   // Inputs
   PCIE_PERST_B_LS, PCIE_REFCLK_N, PCIE_REFCLK_P, PCIE_RX_N,
   PCIE_RX_P, 
   ip_clk_1, in_r_read_1, out_r_din_1, out_r_full_1, out_r_write_1,
   ip_clk_2, in_r_read_2, out_r_din_2, out_r_full_2, out_r_write_2
   );

   input  PCIE_PERST_B_LS;
   input  PCIE_REFCLK_N;
   input  PCIE_REFCLK_P;
   input [7:0] PCIE_RX_N;
   input [7:0] PCIE_RX_P;
   input       ip_clk_1;
   input       in_r_read_1;
   input [127:0] out_r_din_1;
   input        out_r_full_1;
   input        out_r_write_1;
   
   input       ip_clk_2;
   input       in_r_read_2;
   input [127:0] out_r_din_2;
   input        out_r_full_2;
   input        out_r_write_2;
   
   output [3:0] GPIO_LED;
   output [7:0] PCIE_TX_N;
   output [7:0] PCIE_TX_P;

   output [127:0] in_r_dout_1;
   output 	 in_r_empty_n_1;
   output        bus_clk;
   output 	 ip_rst_n_1;
   
   output [127:0] in_r_dout_2;
   output      in_r_empty_n_2;
   output      ip_rst_n_2;
   
   output [8*128-1:0] memarray_out;

   wire 	 hls_fifo_rd_en_1;
   reg 		 in_r_empty_n_1;
   wire 	 hls_fifo_rd_en_2;
   reg       in_r_empty_n_2;

   wire 	 bus_clk;
   wire 	 quiesce;
   reg [7:0] 	 memarray[0:127];
   wire [8*128-1:0] memarray_out;
   wire 	 user_r_mem_8_rden;
   wire 	 user_r_mem_8_empty;
   reg [7:0] 	 user_r_mem_8_data;
   wire 	 user_r_mem_8_eof;
   wire 	 user_r_mem_8_open;
   wire 	 user_w_mem_8_wren;
   wire 	 user_w_mem_8_full;
   wire [7:0] 	 user_w_mem_8_data;
   wire 	 user_w_mem_8_open;
   wire [4:0] 	 user_mem_8_addr;
   wire 	 user_mem_8_addr_update;

   wire 	 user_r_read_128_1_rden;
   wire 	 user_r_read_128_1_empty;
   wire [127:0] 	 user_r_read_128_1_data;
   wire 	 user_r_read_128_1_eof;
   wire 	 user_r_read_128_1_open;
   wire 	 user_w_write_128_1_wren;
   wire 	 user_w_write_128_1_full;
   wire [127:0] 	 user_w_write_128_1_data;
   wire 	 user_w_write_128_1_open;
   
   wire 	 user_r_read_128_2_rden;
   wire      user_r_read_128_2_empty;
   wire [127:0]      user_r_read_128_2_data;
   wire      user_r_read_128_2_eof;
   wire      user_r_read_128_2_open;
   wire      user_w_write_128_2_wren;
   wire      user_w_write_128_2_full;
   wire [127:0]      user_w_write_128_2_data;
   wire      user_w_write_128_2_open;
   
   wire hls_fifo_empty_1;
   wire hls_fifo_empty_2;
   
   genvar i;
   for (i=0; i<8; i=i+1) assign memarray_out[128*i+127:128*i] = memarray[i];

   assign ip_rst_n_1 = ~(!user_w_write_128_1_open && !user_r_read_128_1_open);
   assign  hls_fifo_rd_en_1 = !hls_fifo_empty_1 && (in_r_read_1 || !in_r_empty_n_1);
   assign ip_rst_n_2 = ~(!user_w_write_128_2_open && !user_r_read_128_2_open);
   assign  hls_fifo_rd_en_2 = !hls_fifo_empty_2 && (in_r_read_2 || !in_r_empty_n_2);
   
   assign  user_r_read_128_1_eof = 0;
   assign  user_r_read_128_2_eof = 0;
   
   always @(posedge ip_clk_1)
     if (!user_w_write_128_1_open)
       in_r_empty_n_1 <= 0;
     else if (hls_fifo_rd_en_1)
       in_r_empty_n_1 <= 1;
     else if (in_r_read_1)
       in_r_empty_n_1 <= 0;
       
  always @(posedge ip_clk_2)
     if (!user_w_write_128_2_open)
       in_r_empty_n_2 <= 0;
     else if (hls_fifo_rd_en_2)
       in_r_empty_n_2 <= 1;
     else if (in_r_read_2)
       in_r_empty_n_2 <= 0;

   fifo_128x512 fifo_to_function_1
     (
      .rst(!user_w_write_128_1_open && !user_r_read_128_1_open),
      .rd_clk(ip_clk_1),
      .wr_clk(bus_clk),
      .din(user_w_write_128_1_data),
      .wr_en(user_w_write_128_1_wren),
      .rd_en(hls_fifo_rd_en_1),
      .dout(in_r_dout_1),
      .full(user_w_write_128_1_full),
      .empty(hls_fifo_empty_1)
      );

   fifo_128x512 fifo_from_function_1
     (
      .rst(!user_w_write_128_1_open && !user_r_read_128_1_open),
      .wr_clk(ip_clk_1),
      .rd_clk(bus_clk),
      .din(out_r_din_1),
      .wr_en(out_r_write_1),
      .rd_en(user_r_read_128_1_rden),
      .dout(user_r_read_128_1_data),
      .full(out_r_full_1),
      .empty(user_r_read_128_1_empty)
      );
      
   fifo_128x512 fifo_to_function_2
      (
      .rst(!user_w_write_128_2_open && !user_r_read_128_2_open),
      .rd_clk(ip_clk_2),
      .wr_clk(bus_clk),
      .din(user_w_write_128_2_data),
      .wr_en(user_w_write_128_2_wren),
      .rd_en(hls_fifo_rd_en_2),
      .dout(in_r_dout_2),
      .full(user_w_write_128_2_full),
      .empty(hls_fifo_empty_2)
      );
   
    fifo_128x512 fifo_from_function_2
      (
      .rst(!user_w_write_128_2_open && !user_r_read_128_2_open),
      .wr_clk(ip_clk_2),
      .rd_clk(bus_clk),
      .din(out_r_din_2),
      .wr_en(out_r_write_2),
      .rd_en(user_r_read_128_2_rden),
      .dout(user_r_read_128_2_data),
      .full(out_r_full_2),
      .empty(user_r_read_128_2_empty)
      );

   // A simple inferred RAM
   always @(posedge bus_clk)
   begin
       if (user_w_mem_8_wren)
            memarray[user_mem_8_addr] <= user_w_mem_8_data;
    
       if (user_r_mem_8_rden)
            user_r_mem_8_data <= memarray[user_mem_8_addr];
   end
   assign  user_r_mem_8_empty = 0;
   assign  user_r_mem_8_eof = 0;
   assign  user_w_mem_8_full = 0;

 xillybus  xillybus_ins (
   
       // Ports related to /dev/xillybus_mem_8
       // FPGA to CPU signals:
       .user_r_mem_8_rden(user_r_mem_8_rden),
       .user_r_mem_8_empty(user_r_mem_8_empty),
       .user_r_mem_8_data(user_r_mem_8_data),
       .user_r_mem_8_eof(user_r_mem_8_eof),
       .user_r_mem_8_open(user_r_mem_8_open),
   
       // CPU to FPGA signals:
       .user_w_mem_8_wren(user_w_mem_8_wren),
       .user_w_mem_8_full(user_w_mem_8_full),
       .user_w_mem_8_data(user_w_mem_8_data),
       .user_w_mem_8_open(user_w_mem_8_open),
   
       // Address signals:
       .user_mem_8_addr(user_mem_8_addr),
       .user_mem_8_addr_update(user_mem_8_addr_update),
   
   
       // Ports related to /dev/xillybus_read_128_1
       // FPGA to CPU signals: channel1
       .user_r_read_128_1_rden(user_r_read_128_1_rden),
       .user_r_read_128_1_empty(user_r_read_128_1_empty),
       .user_r_read_128_1_data(user_r_read_128_1_data),
       .user_r_read_128_1_eof(user_r_read_128_1_eof),
       .user_r_read_128_1_open(user_r_read_128_1_open),
   
   
       // Ports related to /dev/xillybus_write_128_1
       // CPU to FPGA signals: channel1
       .user_w_write_128_1_wren(user_w_write_128_1_wren),
       .user_w_write_128_1_full(user_w_write_128_1_full),
       .user_w_write_128_1_data(user_w_write_128_1_data),
       .user_w_write_128_1_open(user_w_write_128_1_open),

        // Ports related to /dev/xillybus_read_128_2
        // FPGA to CPU signals: channel2
        .user_r_read_128_2_rden(user_r_read_128_2_rden),
        .user_r_read_128_2_data(user_r_read_128_2_data),
        .user_r_read_128_2_empty(user_r_read_128_2_empty),
        .user_r_read_128_2_eof(user_r_read_128_2_eof), 
        .user_r_read_128_2_open(user_r_read_128_2_open),
        
        // Ports related to /dev/xillybus_write_128_2
        // CPU to FPGA signals: channel2
        .user_w_write_128_2_wren(user_w_write_128_2_wren),
        .user_w_write_128_2_data(user_w_write_128_2_data),
        .user_w_write_128_2_full(user_w_write_128_2_full),
        .user_w_write_128_2_open(user_w_write_128_2_open),
   
   
       // General signals
       .PCIE_PERST_B_LS(PCIE_PERST_B_LS),
       .PCIE_REFCLK_N(PCIE_REFCLK_N),
       .PCIE_REFCLK_P(PCIE_REFCLK_P),
       .PCIE_RX_N(PCIE_RX_N),
       .PCIE_RX_P(PCIE_RX_P),
       .GPIO_LED(GPIO_LED),
       .PCIE_TX_N(PCIE_TX_N),
       .PCIE_TX_P(PCIE_TX_P),
       .bus_clk(bus_clk),
       .quiesce(quiesce)
     );

endmodule
