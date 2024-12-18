// ==============================================================
// RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and OpenCL
// Version: 2019.2
// Copyright (C) 1986-2019 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

module output_fifo70 (
        ap_clk,
        ap_rst,
        ap_start,
        ap_done,
        ap_continue,
        ap_idle,
        ap_ready,
        pulse_queue_ch0_V_dout,
        pulse_queue_ch0_V_empty_n,
        pulse_queue_ch0_V_read,
        pulse_metadata_ch0_V_TDATA,
        pulse_metadata_ch0_V_TVALID,
        pulse_metadata_ch0_V_TREADY
);

parameter    ap_ST_fsm_state1 = 3'd1;
parameter    ap_ST_fsm_state2 = 3'd2;
parameter    ap_ST_fsm_state3 = 3'd4;

input   ap_clk;
input   ap_rst;
input   ap_start;
output   ap_done;
input   ap_continue;
output   ap_idle;
output   ap_ready;
input  [949:0] pulse_queue_ch0_V_dout;
input   pulse_queue_ch0_V_empty_n;
output   pulse_queue_ch0_V_read;
output  [951:0] pulse_metadata_ch0_V_TDATA;
output   pulse_metadata_ch0_V_TVALID;
input   pulse_metadata_ch0_V_TREADY;

reg ap_done;
reg ap_idle;
reg ap_ready;
reg pulse_queue_ch0_V_read;

reg    ap_done_reg;
(* fsm_encoding = "none" *) reg   [2:0] ap_CS_fsm;
wire    ap_CS_fsm_state1;
reg    pulse_queue_ch0_V_blk_n;
wire    ap_CS_fsm_state2;
reg    pulse_metadata_ch0_V_TDATA_blk_n;
wire   [0:0] pulse_terminate_fu_65_p3;
wire    ap_CS_fsm_state3;
wire    regslice_both_pulse_metadata_ch0_V_U_apdone_blk;
reg    ap_block_state2;
reg    ap_block_state2_io;
wire   [948:0] trunc_ln176_fu_73_p1;
wire   [949:0] tmp_1_fu_77_p3;
reg   [2:0] ap_NS_fsm;
reg    ap_block_state1;
wire   [951:0] pulse_metadata_ch0_V_TDATA_int;
reg    pulse_metadata_ch0_V_TVALID_int;
wire    pulse_metadata_ch0_V_TREADY_int;
wire    regslice_both_pulse_metadata_ch0_V_U_vld_out;

// power-on initialization
initial begin
#0 ap_done_reg = 1'b0;
#0 ap_CS_fsm = 3'd1;
end

regslice_both #(
    .DataWidth( 952 ))
regslice_both_pulse_metadata_ch0_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .data_in(pulse_metadata_ch0_V_TDATA_int),
    .vld_in(pulse_metadata_ch0_V_TVALID_int),
    .ack_in(pulse_metadata_ch0_V_TREADY_int),
    .data_out(pulse_metadata_ch0_V_TDATA),
    .vld_out(regslice_both_pulse_metadata_ch0_V_U_vld_out),
    .ack_out(pulse_metadata_ch0_V_TREADY),
    .apdone_blk(regslice_both_pulse_metadata_ch0_V_U_apdone_blk)
);

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_CS_fsm <= ap_ST_fsm_state1;
    end else begin
        ap_CS_fsm <= ap_NS_fsm;
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_done_reg <= 1'b0;
    end else begin
        if ((ap_continue == 1'b1)) begin
            ap_done_reg <= 1'b0;
        end else if ((~((pulse_queue_ch0_V_empty_n == 1'b0) | (1'b1 == ap_block_state2_io) | (regslice_both_pulse_metadata_ch0_V_U_apdone_blk == 1'b1)) & (pulse_terminate_fu_65_p3 == 1'd1) & (1'b1 == ap_CS_fsm_state2))) begin
            ap_done_reg <= 1'b1;
        end
    end
end

always @ (*) begin
    if ((~((pulse_queue_ch0_V_empty_n == 1'b0) | (1'b1 == ap_block_state2_io) | (regslice_both_pulse_metadata_ch0_V_U_apdone_blk == 1'b1)) & (pulse_terminate_fu_65_p3 == 1'd1) & (1'b1 == ap_CS_fsm_state2))) begin
        ap_done = 1'b1;
    end else begin
        ap_done = ap_done_reg;
    end
end

always @ (*) begin
    if (((ap_start == 1'b0) & (1'b1 == ap_CS_fsm_state1))) begin
        ap_idle = 1'b1;
    end else begin
        ap_idle = 1'b0;
    end
end

always @ (*) begin
    if ((~((pulse_queue_ch0_V_empty_n == 1'b0) | (1'b1 == ap_block_state2_io) | (regslice_both_pulse_metadata_ch0_V_U_apdone_blk == 1'b1)) & (pulse_terminate_fu_65_p3 == 1'd1) & (1'b1 == ap_CS_fsm_state2))) begin
        ap_ready = 1'b1;
    end else begin
        ap_ready = 1'b0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state3) | ((pulse_terminate_fu_65_p3 == 1'd0) & (1'b1 == ap_CS_fsm_state2)))) begin
        pulse_metadata_ch0_V_TDATA_blk_n = pulse_metadata_ch0_V_TREADY_int;
    end else begin
        pulse_metadata_ch0_V_TDATA_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((~((pulse_queue_ch0_V_empty_n == 1'b0) | (1'b1 == ap_block_state2_io) | (regslice_both_pulse_metadata_ch0_V_U_apdone_blk == 1'b1)) & (pulse_terminate_fu_65_p3 == 1'd0) & (1'b1 == ap_CS_fsm_state2))) begin
        pulse_metadata_ch0_V_TVALID_int = 1'b1;
    end else begin
        pulse_metadata_ch0_V_TVALID_int = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state2)) begin
        pulse_queue_ch0_V_blk_n = pulse_queue_ch0_V_empty_n;
    end else begin
        pulse_queue_ch0_V_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((~((pulse_queue_ch0_V_empty_n == 1'b0) | (1'b1 == ap_block_state2_io) | (regslice_both_pulse_metadata_ch0_V_U_apdone_blk == 1'b1)) & (1'b1 == ap_CS_fsm_state2))) begin
        pulse_queue_ch0_V_read = 1'b1;
    end else begin
        pulse_queue_ch0_V_read = 1'b0;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_state1 : begin
            if ((~((ap_start == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
                ap_NS_fsm = ap_ST_fsm_state2;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state1;
            end
        end
        ap_ST_fsm_state2 : begin
            if ((~((pulse_queue_ch0_V_empty_n == 1'b0) | (1'b1 == ap_block_state2_io) | (regslice_both_pulse_metadata_ch0_V_U_apdone_blk == 1'b1)) & (pulse_terminate_fu_65_p3 == 1'd1) & (1'b1 == ap_CS_fsm_state2))) begin
                ap_NS_fsm = ap_ST_fsm_state1;
            end else if ((~((pulse_queue_ch0_V_empty_n == 1'b0) | (1'b1 == ap_block_state2_io) | (regslice_both_pulse_metadata_ch0_V_U_apdone_blk == 1'b1)) & (pulse_terminate_fu_65_p3 == 1'd0) & (1'b1 == ap_CS_fsm_state2))) begin
                ap_NS_fsm = ap_ST_fsm_state3;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state2;
            end
        end
        ap_ST_fsm_state3 : begin
            if (((1'b1 == ap_CS_fsm_state3) & (pulse_metadata_ch0_V_TREADY_int == 1'b1))) begin
                ap_NS_fsm = ap_ST_fsm_state2;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state3;
            end
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign ap_CS_fsm_state1 = ap_CS_fsm[32'd0];

assign ap_CS_fsm_state2 = ap_CS_fsm[32'd1];

assign ap_CS_fsm_state3 = ap_CS_fsm[32'd2];

always @ (*) begin
    ap_block_state1 = ((ap_start == 1'b0) | (ap_done_reg == 1'b1));
end

always @ (*) begin
    ap_block_state2 = ((pulse_queue_ch0_V_empty_n == 1'b0) | (regslice_both_pulse_metadata_ch0_V_U_apdone_blk == 1'b1));
end

always @ (*) begin
    ap_block_state2_io = ((pulse_terminate_fu_65_p3 == 1'd0) & (pulse_metadata_ch0_V_TREADY_int == 1'b0));
end

assign pulse_metadata_ch0_V_TDATA_int = $signed(tmp_1_fu_77_p3);

assign pulse_metadata_ch0_V_TVALID = regslice_both_pulse_metadata_ch0_V_U_vld_out;

assign pulse_terminate_fu_65_p3 = pulse_queue_ch0_V_dout[32'd949];

assign tmp_1_fu_77_p3 = {{1'd0}, {trunc_ln176_fu_73_p1}};

assign trunc_ln176_fu_73_p1 = pulse_queue_ch0_V_dout[948:0];

endmodule //output_fifo70
