/*-- (c) Copyright 2016 Pentek, Inc. All rights reserved.
-- 
-- This file contains confidential and proprietary information
-- of Pentek, Inc. and is protected under U.S. and
-- international copyright and other intellectual property
-- laws.
-- 
-- DISCLAIMER
-- This disclaimer is not a license and does not grant any
-- rights to the materials distributed herewith. Except as
-- otherwise provided in a valid license issued to you by
-- Pentek, and to the maximum extent permitted by applicable
-- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
-- WITH ALL FAULTS, AND PENTEK HEREBY DISCLAIMS ALL WARRANTIES
-- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
-- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
-- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
-- (2) Pentek shall not be liable (whether in contract or tort,
-- including negligence, or under any other theory of
-- liability) for any loss or damage of any kind or nature
-- related to, arising under or in connection with these
-- materials, including for any direct, or any indirect,
-- special, incidental, or consequential loss or damage
-- (including loss of data, profits, goodwill, or any type of
-- loss or damage suffered as a result of any action brought
-- by a third party) even if such damage or loss was
-- reasonably foreseeable or Pentek had been advised of the
-- possibility of the same.
-- 
-- CRITICAL APPLICATIONS
-- Pentek products are not designed or intended to be fail-
-- safe, or for use in any application requiring fail-safe
-- performance, such as life-support or safety devices or
-- systems, Class III medical devices, nuclear facilities,
-- applications related to the deployment of airbags, or any
-- other applications that could lead to death, personal
-- injury, or severe property or environmental damage
-- (individually and collectively, "Critical
-- Applications"). Customer assumes the sole risk and
-- liability of any use of Pentek products in Critical
-- Applications, subject only to applicable laws and
-- regulations governing limitations on product liability.
-- 
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
-- PART OF THIS FILE AT ALL TIMES.
-- 
*/

`default_nettype none

module px_lvl_trans_xclk_async_fifo #(
        parameter DWIDTH                        = 8,
        parameter ENTRIES                       = 2
    ) (
        // interface for shift_in side
        input wire              si_clk,
        input wire              si_res_n,
        input wire              shift_in,
        input wire [DWIDTH-1:0] d_in,

        output reg              full,
        output reg              almost_full,

        // interface for shift_out side
        input wire              so_clk,
        input wire              so_res_n,
        input wire              shift_out,

        output reg [DWIDTH-1:0] d_out,
        output reg              empty,
        output reg              almost_empty
    );


// the FIFO currently can only have up to 2048 entries
    localparam LG_ENTRIES = (ENTRIES <= 2)    ?  1 :
                            (ENTRIES <= 4)    ?  2 :
                            (ENTRIES <= 8)    ?  3 :
                            (ENTRIES <= 16)   ?  4 :
                            (ENTRIES <= 32)   ?  5 :
                            (ENTRIES <= 64)   ?  6 :
                            (ENTRIES <= 128)  ?  7 :
                            (ENTRIES <= 256)  ?  8 :
                            (ENTRIES <= 512)  ?  9 :
                            (ENTRIES <= 1024) ? 10 : 11;

    reg [DWIDTH-1:0]            entry [0:ENTRIES-1];

    reg [LG_ENTRIES-1:0]    wp;
    reg [LG_ENTRIES-1:0]    rp;

    // asynchronous thermo wp
    reg [ENTRIES-1:0]       thermo_wp_w;
    reg [ENTRIES-1:0]       thermo_rp_w;

    reg [ENTRIES-1:0]       thermo_wp;
    reg [ENTRIES-1:0]       thermo_rp;

    reg [ENTRIES-1:0]       thermo_wp_synced_0;

    reg [ENTRIES-1:0]       thermo_wp_synced_1;

    reg [ENTRIES-1:0]       thermo_rp_synced_0;

    reg [ENTRIES-1:0]       thermo_rp_synced_1;

    wire [LG_ENTRIES-1:0]   next_rp;
    wire [LG_ENTRIES-1:0]   next_rp_p1;

    wire                    set_empty_w;
    wire                    set_a_empty_0_w;
    wire                    set_a_empty_1_w;
    wire                    set_a_empty_2_w;

    wire                    set_full_w;
    wire                    set_a_full_0_w;
    wire                    set_a_full_1_w;
    wire                    set_a_full_2_w;

    wire [LG_ENTRIES-1:0]   upper_bound;

    assign next_rp          = (rp == upper_bound) ? {LG_ENTRIES {1'b0}} : rp + 1'b1;
    assign next_rp_p1       = (next_rp == upper_bound) ? {LG_ENTRIES {1'b0}} : next_rp + 1'b1;

    assign set_empty_w      = (thermo_rp == thermo_wp_synced_1);
    assign set_a_empty_0_w  = (thermo_rp == {~thermo_wp_synced_1[0],   thermo_wp_synced_1[ENTRIES-1:1]});
    assign set_a_empty_1_w  = (thermo_rp == {~thermo_wp_synced_1[1:0], thermo_wp_synced_1[ENTRIES-1:2]});
    assign set_a_empty_2_w  = (thermo_rp == {~thermo_wp_synced_1[2:0], thermo_wp_synced_1[ENTRIES-1:3]});

    assign set_full_w       = &(thermo_wp ^ thermo_rp_synced_1);
    assign set_a_full_0_w   = &(thermo_wp ^ {~thermo_rp_synced_1[0],   thermo_rp_synced_1[ENTRIES-1:1]});
    assign set_a_full_1_w   = &(thermo_wp ^ {~thermo_rp_synced_1[1:0], thermo_rp_synced_1[ENTRIES-1:2]});
    assign set_a_full_2_w   = &(thermo_wp ^ {~thermo_rp_synced_1[2:0], thermo_rp_synced_1[ENTRIES-1:3]});

    assign upper_bound      = ENTRIES[LG_ENTRIES-1:0] - {{LG_ENTRIES-1 {1'b0}}, 1'b1};

    always @ (*)
    begin
        if (shift_in && !full)
            thermo_wp_w     = {thermo_wp[ENTRIES-2:0], !thermo_wp[ENTRIES-1]};
        else
            thermo_wp_w     = thermo_wp;
    end

    always @ (*)
    begin
        if (shift_out && !empty)
            thermo_rp_w     = {thermo_rp[ENTRIES-2:0], !thermo_rp[ENTRIES-1]};
        else
            thermo_rp_w     = thermo_rp;
    end


    // shift_in side:
    `ifdef ASYNC_RES
    always @(posedge si_clk or negedge si_res_n) `else
    always @(posedge si_clk) `endif
    begin
        if (!si_res_n)
        begin
            wp                  <= {LG_ENTRIES {1'b0}};
            thermo_wp           <= {ENTRIES {1'b0}};
            full                <= 1'b0;
            almost_full         <= 1'b0;
        end
        else
        begin
            full                <= set_full_w || (set_a_full_0_w && shift_in) ;
            almost_full         <= set_full_w || (set_a_full_0_w) || (set_a_full_1_w && shift_in) ;

            thermo_wp           <= thermo_wp_w;

            if (shift_in && !full)
            begin
                entry[wp]       <= d_in;

                if (wp == upper_bound)
                    wp          <= {LG_ENTRIES {1'b0}};
                else
                    wp          <= wp + 1'b1;
            end
        end
    end

    // shift_out side
    `ifdef ASYNC_RES
    always @(posedge so_clk or negedge so_res_n) `else
    always @(posedge so_clk) `endif
    begin
        if (!so_res_n)
        begin
            rp                  <= {LG_ENTRIES {1'b0}};
            thermo_rp           <= {ENTRIES {1'b0}};
            empty               <= 1'b1;
            almost_empty        <= 1'b1;

        end
        else
        begin
            empty               <= (set_empty_w || (set_a_empty_0_w && shift_out && !empty));
            almost_empty        <= empty || set_empty_w || set_a_empty_0_w || (set_a_empty_1_w && shift_out && !empty);

            thermo_rp           <= thermo_rp_w;
            // shift out and not empty or empty but a new word just finished synchronizing (like almost empty)
            if (shift_out && !empty)
            begin
                rp              <= next_rp;
                d_out       <= entry[next_rp];
            end
            else
            begin
                d_out       <= entry[rp];
            end
        end
    end

    // syncing thermp_rp to shift_in domain
    `ifdef ASYNC_RES
    always @(posedge si_clk or negedge si_res_n) `else
    always @(posedge si_clk) `endif
    begin
        if (!si_res_n)
        begin
            thermo_rp_synced_0  <= {ENTRIES {1'b0}};
            thermo_rp_synced_1  <= {ENTRIES {1'b0}};
        end
        else
        begin
            thermo_rp_synced_0  <= thermo_rp;
            thermo_rp_synced_1  <= thermo_rp_synced_0;
        end
    end

    // syncing write pointer to shift_out domain
    `ifdef ASYNC_RES
    always @(posedge so_clk or negedge so_res_n) `else
    always @(posedge so_clk) `endif
    begin
        if (!so_res_n)
        begin
            thermo_wp_synced_0  <= {ENTRIES {1'b0}};
            thermo_wp_synced_1  <= {ENTRIES {1'b0}};
        end
        else
        begin
            thermo_wp_synced_0  <= thermo_wp;
            thermo_wp_synced_1  <= thermo_wp_synced_0;
        end
    end

endmodule

`default_nettype wire
