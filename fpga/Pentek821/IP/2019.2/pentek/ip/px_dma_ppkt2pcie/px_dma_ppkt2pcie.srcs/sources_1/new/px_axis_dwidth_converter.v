//  (c) Copyright 2011-2013 Xilinx, Inc. All rights reserved.
//
//  This file contains confidential and proprietary information
//  of Xilinx, Inc. and is protected under U.S. and
//  international copyright and other intellectual property
//  laws.
//
//  DISCLAIMER
//  This disclaimer is not a license and does not grant any
//  rights to the materials distributed herewith. Except as
//  otherwise provided in a valid license issued to you by
//  Xilinx, and to the maximum extent permitted by applicable
//  law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
//  WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
//  AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
//  BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
//  INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
//  (2) Xilinx shall not be liable (whether in contract or tort,
//  including negligence, or under any other theory of
//  liability) for any loss or damage of any kind or nature
//  related to, arising under or in connection with these
//  materials, including for any direct, or any indirect,
//  special, incidental, or consequential loss or damage
//  (including loss of data, profits, goodwill, or any type of
//  loss or damage suffered as a result of any action brought
//  by a third party) even if such damage or loss was
//  reasonably foreseeable or Xilinx had been advised of the
//  possibility of the same.
//
//  CRITICAL APPLICATIONS
//  Xilinx products are not designed or intended to be fail-
//  safe, or for use in any application requiring fail-safe
//  performance, such as life-support or safety devices or
//  systems, Class III medical devices, nuclear facilities,
//  applications related to the deployment of airbags, or any
//  other applications that could lead to death, personal
//  injury, or severe property or environmental damage
//  (individually and collectively, "Critical
//  Applications"). Customer assumes the sole risk and
//  liability of any use of Xilinx products in Critical
//  Applications, subject only to applicable laws and
//  regulations governing limitations on product liability.
//
//  THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
//  PART OF THIS FILE AT ALL TIMES. 
//-----------------------------------------------------------------------------
//
// axis_dwidth_converter
//   Converts data when C_S_AXIS_TDATA_WIDTH != C_M_AXIS_TDATA_WIDTH.
//
// Verilog-standard:  Verilog 2001
//--------------------------------------------------------------------------
//
// Structure:
//   axis_dwidth_converter
//     register_slice (instantiated with upsizer)
//     axisc_upsizer
//     axisc_downsizer
//     register_slice (instantiated with downsizer)
//
//--------------------------------------------------------------------------

// Modified By Pentek!

`timescale 1ps/1ps
`default_nettype none

(* DowngradeIPIdentifiedWarnings="yes" *)
module px_axis_dwidth_converter #
(
///////////////////////////////////////////////////////////////////////////////
// Parameter Definitions
///////////////////////////////////////////////////////////////////////////////
   parameter         C_FAMILY           = "virtex7",
   parameter integer C_S_AXIS_TDATA_WIDTH = 32,
   parameter integer C_M_AXIS_TDATA_WIDTH = 32,
   parameter integer C_AXIS_TID_WIDTH   = 1,
   parameter integer C_AXIS_TDEST_WIDTH = 1,
   parameter integer C_S_AXIS_TUSER_WIDTH = 1,
   parameter integer C_M_AXIS_TUSER_WIDTH = 1,
   // Ratio of C_S_AXIS_TDATA_WIDTH : C_M_AXIS_TDATA_WIDTH must be the same as 
   // the ratio of C_S_AXIS_TUSER_WIDTH : C_M_AXIS_TUSER_WIDTH if USER signals are present.
   parameter [31:0]  C_AXIS_SIGNAL_SET  = 32'hFF
   // C_AXIS_SIGNAL_SET: each bit if enabled specifies which axis optional signals are present
   //   [0] => TREADY present (Required)
   //   [1] => TDATA present (Required, used to calculate ratios)
   //   [2] => TSTRB present, TDATA must be present
   //   [3] => TKEEP present, TDATA must be present (Required if TLAST, TID,
   //   TDEST present
   //   [4] => TLAST present
   //   [5] => TID present
   //   [6] => TDEST present
   //   [7] => TUSER present
   )
  (
///////////////////////////////////////////////////////////////////////////////
// Port Declarations
///////////////////////////////////////////////////////////////////////////////
   // System Signals
   input wire aclk,
   input wire aresetn,
   input wire aclken,

   // Slave side
   input  wire                              s_axis_tvalid,
   output wire                              s_axis_tready,
   input  wire [C_S_AXIS_TDATA_WIDTH-1:0]   s_axis_tdata,
   input  wire [C_S_AXIS_TDATA_WIDTH/8-1:0] s_axis_tstrb,
   input  wire [C_S_AXIS_TDATA_WIDTH/8-1:0] s_axis_tkeep,
   input  wire                              s_axis_tlast,
   input  wire [C_AXIS_TID_WIDTH-1:0]       s_axis_tid,
   input  wire [C_AXIS_TDEST_WIDTH-1:0]     s_axis_tdest,
   input  wire [C_S_AXIS_TUSER_WIDTH-1:0]   s_axis_tuser,

   // Master side
   output wire                              m_axis_tvalid,
   input  wire                              m_axis_tready,
   output wire [C_M_AXIS_TDATA_WIDTH-1:0]   m_axis_tdata,
   output wire [C_M_AXIS_TDATA_WIDTH/8-1:0] m_axis_tstrb,
   output wire [C_M_AXIS_TDATA_WIDTH/8-1:0] m_axis_tkeep,
   output wire                              m_axis_tlast,
   output wire [C_AXIS_TID_WIDTH-1:0]       m_axis_tid,
   output wire [C_AXIS_TDEST_WIDTH-1:0]     m_axis_tdest,
   output wire [C_M_AXIS_TUSER_WIDTH-1:0]   m_axis_tuser
   );

////////////////////////////////////////////////////////////////////////////////
// Functions
////////////////////////////////////////////////////////////////////////////////
`include "axis_infrastructure_v1_1_0_axis_infrastructure.vh"

////////////////////////////////////////////////////////////////////////////////
// Local parameters
////////////////////////////////////////////////////////////////////////////////
// TKEEP required if TID/TLAST/TDEST signals enabled
localparam [31:0]  P_SS_TKEEP_REQUIRED = (C_AXIS_SIGNAL_SET & (G_MASK_SS_TID | G_MASK_SS_TDEST | G_MASK_SS_TLAST)) 
                                          ? G_MASK_SS_TKEEP : 32'h0;
// TREADY/TDATA must always be present
localparam [31:0]  P_AXIS_SIGNAL_SET  = C_AXIS_SIGNAL_SET | G_MASK_SS_TREADY | G_MASK_SS_TDATA | P_SS_TKEEP_REQUIRED;
localparam P_S_RATIO = f_lcm(C_S_AXIS_TDATA_WIDTH, C_M_AXIS_TDATA_WIDTH) / C_S_AXIS_TDATA_WIDTH;
localparam P_M_RATIO = f_lcm(C_S_AXIS_TDATA_WIDTH, C_M_AXIS_TDATA_WIDTH) / C_M_AXIS_TDATA_WIDTH;
localparam P_D2_TDATA_WIDTH = C_S_AXIS_TDATA_WIDTH * P_S_RATIO;
// To protect against bad TUSER M/S ratios when not using TUSER, base all
// TUSER widths off of the calculated ratios and the slave tuser input width.
localparam P_D1_TUSER_WIDTH = C_AXIS_SIGNAL_SET[G_INDX_SS_TUSER] ? C_S_AXIS_TUSER_WIDTH : C_S_AXIS_TDATA_WIDTH/8;
localparam P_D2_TUSER_WIDTH = P_D1_TUSER_WIDTH * P_S_RATIO;
localparam P_D3_TUSER_WIDTH = P_D2_TUSER_WIDTH / P_M_RATIO;

localparam P_D1_REG_CONFIG = 1; // Full buffered
localparam P_D3_REG_CONFIG = 0; // Full buffered

////////////////////////////////////////////////////////////////////////////////
// DRCs
////////////////////////////////////////////////////////////////////////////////
// synthesis translate_off
integer retval;
integer retval_all;
initial
begin : DRC
  retval_all = 0;
  t_check_tdata_width(C_S_AXIS_TDATA_WIDTH, "C_S_AXIS_TDATA_WIDTH", "axis_dwidth_converter", G_TASK_SEVERITY_ERR, retval);
  retval_all = retval_all | retval;

  t_check_tdata_width(C_M_AXIS_TDATA_WIDTH, "C_M_AXIS_TDATA_WIDTH", "axis_dwidth_converter", G_TASK_SEVERITY_ERR, retval);
  retval_all = retval_all | retval;
  if (C_AXIS_SIGNAL_SET[G_INDX_SS_TUSER]) begin
    t_check_tuser_width (
      C_S_AXIS_TUSER_WIDTH, "C_S_AXIS_TUSER_WIDTH"   , 
      C_S_AXIS_TDATA_WIDTH, "C_S_AXIS_TDATA_WIDTH"   , 
      "axis_dwidth_converter", G_TASK_SEVERITY_ERR , 
      retval
    );
    retval_all = retval_all | retval;
    t_check_tuser_width(
      C_M_AXIS_TUSER_WIDTH, "C_M_AXIS_TUSER_WIDTH",
      C_M_AXIS_TDATA_WIDTH, "C_M_AXIS_TDATA_WIDTH",
      "axis_dwidth_converter", G_TASK_SEVERITY_ERR,
      retval
    );
    retval_all = retval_all | retval;
  end
  else begin 
    // No check
  end
  if (retval_all > 0) begin
    $stop;
  end else begin
    // Do nothing
  end


end
// synthesis translate_on
////////////////////////////////////////////////////////////////////////////////
// Wires/Reg declarations
////////////////////////////////////////////////////////////////////////////////

reg                               areset_r;

// Tie-offs for required signals if not present on inputs
wire                              tready_in;
wire [C_S_AXIS_TDATA_WIDTH-1:0]   tdata_in;
wire [C_S_AXIS_TDATA_WIDTH/8-1:0] tkeep_in;
wire [P_D1_TUSER_WIDTH-1:0]       tuser_in;

// Output of first register stage
wire                              d1_valid;
wire                              d1_ready;
wire [C_S_AXIS_TDATA_WIDTH-1:0]   d1_data;
wire [C_S_AXIS_TDATA_WIDTH/8-1:0] d1_strb;
wire [C_S_AXIS_TDATA_WIDTH/8-1:0] d1_keep;
wire                              d1_last;
wire [C_AXIS_TID_WIDTH-1:0]       d1_id;
wire [C_AXIS_TDEST_WIDTH-1:0]     d1_dest;
wire [P_D1_TUSER_WIDTH-1:0]       d1_user;

// Output of upsizer stage
wire                              d2_valid;
wire                              d2_ready;
wire [P_D2_TDATA_WIDTH-1:0]       d2_data;
wire [P_D2_TDATA_WIDTH/8-1:0]     d2_strb;
wire [P_D2_TDATA_WIDTH/8-1:0]     d2_keep;
wire                              d2_last;
wire [C_AXIS_TID_WIDTH-1:0]       d2_id;
wire [C_AXIS_TDEST_WIDTH-1:0]     d2_dest;
wire [P_D2_TUSER_WIDTH-1:0]       d2_user;

// Output of downsizer stage
wire                              d3_valid;
wire                              d3_ready;
wire [C_M_AXIS_TDATA_WIDTH-1:0]   d3_data;
wire [C_M_AXIS_TDATA_WIDTH/8-1:0] d3_strb;
wire [C_M_AXIS_TDATA_WIDTH/8-1:0] d3_keep;
wire                              d3_last;
wire [C_AXIS_TID_WIDTH-1:0]       d3_id;
wire [C_AXIS_TDEST_WIDTH-1:0]     d3_dest;
wire [P_D3_TUSER_WIDTH-1:0]       d3_user;
wire [P_D3_TUSER_WIDTH-1:0]       m_axis_tuser_out;



////////////////////////////////////////////////////////////////////////////////
// BEGIN RTL
////////////////////////////////////////////////////////////////////////////////

always @(posedge aclk) begin
  areset_r <= ~aresetn;
end

// Tie-offs for required signals if not present on inputs
assign tready_in = C_AXIS_SIGNAL_SET[G_INDX_SS_TREADY] ? m_axis_tready : 1'b1;
assign tdata_in = C_AXIS_SIGNAL_SET[G_INDX_SS_TDATA] ? s_axis_tdata : {C_S_AXIS_TDATA_WIDTH{1'b0}};
assign tkeep_in = C_AXIS_SIGNAL_SET[G_INDX_SS_TKEEP] ? s_axis_tkeep : {(C_S_AXIS_TDATA_WIDTH/8){1'b1}};
assign tuser_in = C_AXIS_SIGNAL_SET[G_INDX_SS_TUSER] ? s_axis_tuser : {P_D1_TUSER_WIDTH{1'b1}};

axis_register_slice_v1_1_9_axis_register_slice #(
  .C_FAMILY           ( C_FAMILY               ) ,
  .C_AXIS_TDATA_WIDTH ( C_S_AXIS_TDATA_WIDTH   ) ,
  .C_AXIS_TID_WIDTH   ( C_AXIS_TID_WIDTH       ) ,
  .C_AXIS_TDEST_WIDTH ( C_AXIS_TDEST_WIDTH     ) ,
  .C_AXIS_TUSER_WIDTH ( P_D1_TUSER_WIDTH       ) ,
  .C_AXIS_SIGNAL_SET  ( P_AXIS_SIGNAL_SET      ) ,
  .C_REG_CONFIG       ( P_D1_REG_CONFIG        )
)
axis_reg_slice_0
(
  .aclk          ( aclk          ) ,
  .aclken        ( aclken        ) ,
  .aresetn       ( aresetn       ) ,
  .s_axis_tvalid ( s_axis_tvalid ) ,
  .s_axis_tready ( s_axis_tready ) ,
  .s_axis_tdata  ( tdata_in      ) ,
  .s_axis_tstrb  ( s_axis_tstrb  ) ,
  .s_axis_tkeep  ( tkeep_in      ) ,
  .s_axis_tlast  ( s_axis_tlast  ) ,
  .s_axis_tid    ( s_axis_tid    ) ,
  .s_axis_tdest  ( s_axis_tdest  ) ,
  .s_axis_tuser  ( tuser_in      ) ,
  .m_axis_tvalid ( d1_valid      ) ,
  .m_axis_tready ( d1_ready      ) ,
  .m_axis_tdata  ( d1_data       ) ,
  .m_axis_tstrb  ( d1_strb       ) ,
  .m_axis_tkeep  ( d1_keep       ) ,
  .m_axis_tlast  ( d1_last       ) ,
  .m_axis_tid    ( d1_id         ) ,
  .m_axis_tdest  ( d1_dest       ) ,
  .m_axis_tuser  ( d1_user       ) 
);


generate
  if (P_S_RATIO > 1) begin : gen_upsizer_conversion
    axis_dwidth_converter_v1_1_8_axisc_upsizer #(
      .C_FAMILY             ( C_FAMILY             ) ,
      .C_S_AXIS_TDATA_WIDTH ( C_S_AXIS_TDATA_WIDTH ) ,
      .C_M_AXIS_TDATA_WIDTH ( P_D2_TDATA_WIDTH     ) ,
      .C_AXIS_TID_WIDTH     ( C_AXIS_TID_WIDTH     ) ,
      .C_AXIS_TDEST_WIDTH   ( C_AXIS_TDEST_WIDTH   ) ,
      .C_S_AXIS_TUSER_WIDTH  ( P_D1_TUSER_WIDTH    ) ,
      .C_M_AXIS_TUSER_WIDTH  ( P_D2_TUSER_WIDTH    ) ,
      .C_AXIS_SIGNAL_SET    ( P_AXIS_SIGNAL_SET    ) ,
      .C_RATIO              ( P_S_RATIO            ) 
    )
    axisc_upsizer_0 (
      .ACLK          ( aclk     ) ,
      .ARESET        ( areset_r ) ,
      .ACLKEN        ( aclken   ) ,
      .S_AXIS_TVALID ( d1_valid ) ,
      .S_AXIS_TREADY ( d1_ready ) ,
      .S_AXIS_TDATA  ( d1_data  ) ,
      .S_AXIS_TSTRB  ( d1_strb  ) ,
      .S_AXIS_TKEEP  ( d1_keep  ) ,
      .S_AXIS_TLAST  ( d1_last  ) ,
      .S_AXIS_TID    ( d1_id    ) ,
      .S_AXIS_TDEST  ( d1_dest  ) ,
      .S_AXIS_TUSER  ( d1_user  ) ,
      .M_AXIS_TVALID ( d2_valid ) ,
      .M_AXIS_TREADY ( d2_ready ) ,
      .M_AXIS_TDATA  ( d2_data  ) ,
      .M_AXIS_TSTRB  ( d2_strb  ) ,
      .M_AXIS_TKEEP  ( d2_keep  ) ,
      .M_AXIS_TLAST  ( d2_last  ) ,
      .M_AXIS_TID    ( d2_id    ) ,
      .M_AXIS_TDEST  ( d2_dest  ) ,
      .M_AXIS_TUSER  ( d2_user  ) 
    );
  end
  else begin : gen_no_upsizer_passthru
    assign d2_valid = d1_valid;
    assign d1_ready = d2_ready;
    assign d2_data  = d1_data;
    assign d2_strb  = d1_strb;
    assign d2_keep  = d1_keep;
    assign d2_last  = d1_last;
    assign d2_id    = d1_id;
    assign d2_dest  = d1_dest;
    assign d2_user  = d1_user;
  end
  if (P_M_RATIO > 1) begin : gen_downsizer_conversion
    axis_dwidth_converter_v1_1_8_axisc_downsizer #(
      .C_FAMILY             ( C_FAMILY             ) ,
      .C_S_AXIS_TDATA_WIDTH ( P_D2_TDATA_WIDTH     ) ,
      .C_M_AXIS_TDATA_WIDTH ( C_M_AXIS_TDATA_WIDTH ) ,
      .C_AXIS_TID_WIDTH     ( C_AXIS_TID_WIDTH     ) ,
      .C_AXIS_TDEST_WIDTH   ( C_AXIS_TDEST_WIDTH   ) ,
      .C_S_AXIS_TUSER_WIDTH  ( P_D2_TUSER_WIDTH    ) ,
      .C_M_AXIS_TUSER_WIDTH  ( P_D3_TUSER_WIDTH    ) ,
      .C_AXIS_SIGNAL_SET    ( P_AXIS_SIGNAL_SET    ) ,
      .C_RATIO              ( P_M_RATIO            ) 
    )
    axisc_downsizer_0 (
      .ACLK          ( aclk     ) ,
      .ARESET        ( areset_r ) ,
      .ACLKEN        ( aclken   ) ,
      .S_AXIS_TVALID ( d2_valid ) ,
      .S_AXIS_TREADY ( d2_ready ) ,
      .S_AXIS_TDATA  ( d2_data  ) ,
      .S_AXIS_TSTRB  ( d2_strb  ) ,
      .S_AXIS_TKEEP  ( d2_keep  ) ,
      .S_AXIS_TLAST  ( d2_last  ) ,
      .S_AXIS_TID    ( d2_id    ) ,
      .S_AXIS_TDEST  ( d2_dest  ) ,
      .S_AXIS_TUSER  ( d2_user  ) ,
      .M_AXIS_TVALID ( d3_valid ) ,
      .M_AXIS_TREADY ( d3_ready ) ,
      .M_AXIS_TDATA  ( d3_data  ) ,
      .M_AXIS_TSTRB  ( d3_strb  ) ,
      .M_AXIS_TKEEP  ( d3_keep  ) ,
      .M_AXIS_TLAST  ( d3_last  ) ,
      .M_AXIS_TID    ( d3_id    ) ,
      .M_AXIS_TDEST  ( d3_dest  ) ,
      .M_AXIS_TUSER  ( d3_user  ) 
    );
  end
  else begin : gen_no_downsizer_passthru
    assign d3_valid = d2_valid;
    assign d2_ready = d3_ready;
    assign d3_data  = d2_data;
    assign d3_strb  = d2_strb;
    assign d3_keep  = d2_keep;
    assign d3_last  = d2_last;
    assign d3_id    = d2_id;
    assign d3_dest  = d2_dest;
    assign d3_user  = d2_user;
  end
endgenerate

axis_register_slice_v1_1_9_axis_register_slice #(
  .C_FAMILY           ( C_FAMILY             ) ,
  .C_AXIS_TDATA_WIDTH ( C_M_AXIS_TDATA_WIDTH ) ,
  .C_AXIS_TID_WIDTH   ( C_AXIS_TID_WIDTH     ) ,
  .C_AXIS_TDEST_WIDTH ( C_AXIS_TDEST_WIDTH   ) ,
  .C_AXIS_TUSER_WIDTH ( P_D3_TUSER_WIDTH     ) ,
  .C_AXIS_SIGNAL_SET  ( P_AXIS_SIGNAL_SET    ) ,
  .C_REG_CONFIG       ( P_D3_REG_CONFIG      )
)
axis_reg_slice_1
(
  .aclk          ( aclk          ) ,
  .aclken        ( aclken        ) ,
  .aresetn       ( aresetn       ) ,
  .s_axis_tvalid ( d3_valid      ) ,
  .s_axis_tready ( d3_ready      ) ,
  .s_axis_tdata  ( d3_data       ) ,
  .s_axis_tstrb  ( d3_strb       ) ,
  .s_axis_tkeep  ( d3_keep       ) ,
  .s_axis_tlast  ( d3_last       ) ,
  .s_axis_tid    ( d3_id         ) ,
  .s_axis_tdest  ( d3_dest       ) ,
  .s_axis_tuser  ( d3_user       ) ,
  .m_axis_tvalid ( m_axis_tvalid ) ,
  .m_axis_tready ( tready_in     ) ,
  .m_axis_tdata  ( m_axis_tdata  ) ,
  .m_axis_tstrb  ( m_axis_tstrb  ) ,
  .m_axis_tkeep  ( m_axis_tkeep  ) ,
  .m_axis_tlast  ( m_axis_tlast  ) ,
  .m_axis_tid    ( m_axis_tid    ) ,
  .m_axis_tdest  ( m_axis_tdest  ) ,
  .m_axis_tuser  ( m_axis_tuser_out )
);

assign m_axis_tuser = C_AXIS_SIGNAL_SET[G_INDX_SS_TUSER] ? m_axis_tuser_out[P_D3_TUSER_WIDTH-1:0] 
                                                    : {C_M_AXIS_TUSER_WIDTH{1'bx}};

endmodule // axis_dwidth_converter

`default_nettype wire
