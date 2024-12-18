// (c) Copyright 1995-2019 Xilinx, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
// 
// DO NOT MODIFY THIS FILE.

// IP VLNV: pentek.com:px_ip:px_test_sig_gen_48:1.0
// IP Revision: 42

// The following must be inserted into your Verilog file for this
// core to be instantiated. Change the instance name and port connections
// (in parentheses) to your own signal names.

//----------- Begin Cut here for INSTANTIATION Template ---// INST_TAG
stim_test_sig_48 your_instance_name (
  .s_axi_csr_aclk(s_axi_csr_aclk),                      // input wire s_axi_csr_aclk
  .s_axi_csr_aresetn(s_axi_csr_aresetn),                // input wire s_axi_csr_aresetn
  .s_axi_csr_awaddr(s_axi_csr_awaddr),                  // input wire [4 : 0] s_axi_csr_awaddr
  .s_axi_csr_awprot(s_axi_csr_awprot),                  // input wire [2 : 0] s_axi_csr_awprot
  .s_axi_csr_awvalid(s_axi_csr_awvalid),                // input wire s_axi_csr_awvalid
  .s_axi_csr_awready(s_axi_csr_awready),                // output wire s_axi_csr_awready
  .s_axi_csr_wdata(s_axi_csr_wdata),                    // input wire [31 : 0] s_axi_csr_wdata
  .s_axi_csr_wstrb(s_axi_csr_wstrb),                    // input wire [3 : 0] s_axi_csr_wstrb
  .s_axi_csr_wvalid(s_axi_csr_wvalid),                  // input wire s_axi_csr_wvalid
  .s_axi_csr_wready(s_axi_csr_wready),                  // output wire s_axi_csr_wready
  .s_axi_csr_bresp(s_axi_csr_bresp),                    // output wire [1 : 0] s_axi_csr_bresp
  .s_axi_csr_bvalid(s_axi_csr_bvalid),                  // output wire s_axi_csr_bvalid
  .s_axi_csr_bready(s_axi_csr_bready),                  // input wire s_axi_csr_bready
  .s_axi_csr_araddr(s_axi_csr_araddr),                  // input wire [4 : 0] s_axi_csr_araddr
  .s_axi_csr_arprot(s_axi_csr_arprot),                  // input wire [2 : 0] s_axi_csr_arprot
  .s_axi_csr_arvalid(s_axi_csr_arvalid),                // input wire s_axi_csr_arvalid
  .s_axi_csr_arready(s_axi_csr_arready),                // output wire s_axi_csr_arready
  .s_axi_csr_rdata(s_axi_csr_rdata),                    // output wire [31 : 0] s_axi_csr_rdata
  .s_axi_csr_rresp(s_axi_csr_rresp),                    // output wire [1 : 0] s_axi_csr_rresp
  .s_axi_csr_rvalid(s_axi_csr_rvalid),                  // output wire s_axi_csr_rvalid
  .s_axi_csr_rready(s_axi_csr_rready),                  // input wire s_axi_csr_rready
  .irq(irq),                                            // output wire irq
  .s_axis_aclk(s_axis_aclk),                            // input wire s_axis_aclk
  .s_axis_aresetn(s_axis_aresetn),                      // input wire s_axis_aresetn
  .s_axis_ptctl_tdata(s_axis_ptctl_tdata),              // input wire [31 : 0] s_axis_ptctl_tdata
  .s_axis_ptctl_tvalid(s_axis_ptctl_tvalid),            // input wire s_axis_ptctl_tvalid
  .m_axis_pd_testsig_tdata(m_axis_pd_testsig_tdata),    // output wire [127 : 0] m_axis_pd_testsig_tdata
  .m_axis_pd_testsig_tvalid(m_axis_pd_testsig_tvalid),  // output wire m_axis_pd_testsig_tvalid
  .des_ctl(des_ctl)                                    // input wire des_ctl
);
// INST_TAG_END ------ End INSTANTIATION Template ---------

