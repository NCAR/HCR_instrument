-------------------------------------------------------------------------------
-- ********************** Simple AXI-Stream 1to2 De-Mux ********************* --
-------------------------------------------------------------------------------
--  Copyright (c) 2017 Pentek, Inc. All rights reserved.
-------------------------------------------------------------------------------
-- Title        : Simple AXI-Stream 1to2 De-Mux
-- Project      : 
-------------------------------------------------------------------------------
---------  Technical Support for Pentek's Navigator FPGA Design Kits   --------
-------------------------------------------------------------------------------
--        Technical support for Pentek's Navigator FPGA Design Kits is       --
--   available via e-mail (fpgasupport@pentek.com) or by phone (201-818-5900 --
--            ext. 238, 9 AM to 5 PM US Eastern time.) Names or              --
--  initials contained within the source code are part of our revision       --
--   control regime.  Please do not try to use these references to pursue    --
--                            technical support                              --
-------------------------------------------------------------------------------
-- Filename       : px_axis_1to2_demux.vhd
-- Author         : 
-- Created        : 10/04/2017
-- Last Modified  : 10/04/2017
-- Vivado Version :
-- Modified By    : 
--                  Pentek, Inc.
--                  One Park Way
--                  Upper Saddle River, NJ  07458
--                  (201) 818-5900
--                  www.pentek.com
-------------------------------------------------------------------------------
-- ******************************* Change Log ****************************** --
-- 10/04/2017 - Revision 0.01 - File Created
--
------------------------------------------------------------------------------
-- Description: Simple AXI-Stream 1-to-2 De-mux
-- 

-- Memory Map
-- address 0x000 bit 0 = Demux path select  '0' = Select m0_axis,  '1' =  Select m1_axis 

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

-- (c) Copyright 2017 Pentek, Inc. All rights reserved.
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

-------------------------------------------------------------------------------
-- Libraries
-------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.ALL;
Library xpm;
use xpm.vcomponents.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity px_axis_1to2_demux is
generic(
    data_byte_width         : integer := 2;  -- Width of input data stream in bytes
    tuser_width             : integer := 32; -- Width of tuser  1 to 1024
    has_tuser               : boolean := true;
    has_tready              : boolean := true;
    has_tlast               : boolean := true;
    has_tkeep               : boolean := true;
    bytes_per_tkeep         : integer := 1  -- 1 or 2
);
port (
    --------------------------------------------------------------------------------
    -- AXI LITE Slave Interface  
    -- DWORD Addressing
    --------------------------------------------------------------------------------
    s_axi_csr_aclk            : in  std_logic;
    s_axi_csr_aresetn         : in  std_logic;
    s_axi_csr_awaddr          : in  std_logic_vector(11 downto 0);
    s_axi_csr_awprot          : in  std_logic_vector(2 downto 0); -- not used
    s_axi_csr_awvalid         : in  std_logic;
    s_axi_csr_awready         : out std_logic;
    s_axi_csr_wdata           : in  std_logic_vector(31 downto 0);
    s_axi_csr_wstrb           : in  std_logic_vector(3 downto 0); -- not used
    s_axi_csr_wvalid          : in  std_logic;
    s_axi_csr_wready          : out std_logic;
    s_axi_csr_bresp           : out std_logic_vector(1 downto 0);
    s_axi_csr_bvalid          : out std_logic;
    s_axi_csr_bready          : in  std_logic;
    s_axi_csr_araddr          : in  std_logic_vector(11 downto 0);
    s_axi_csr_arprot          : in  std_logic_vector(2 downto 0); -- not used
    s_axi_csr_arvalid         : in  std_logic;
    s_axi_csr_arready         : out std_logic;
    s_axi_csr_rdata           : out std_logic_vector(31 downto 0);
    s_axi_csr_rresp           : out std_logic_vector(1 downto 0);
    s_axi_csr_rvalid          : out std_logic;
    s_axi_csr_rready          : in  std_logic;
    -----------------------------------------------------------------------------
    -- AXI4- Stream Clock
    -----------------------------------------------------------------------------
    s_axis_aclk               : in  std_logic;
    s_axis_aresetn            : in  std_logic;
    -----------------------------------------------------------------------------
    -- (AXI4-Stream Slave)
    -----------------------------------------------------------------------------
    s_axis_tdata        : in  std_logic_vector(((data_byte_width*8)-1) downto 0);
    s_axis_tuser        : in  std_logic_vector(tuser_width-1 downto 0);
    s_axis_tvalid       : in  std_logic;
    s_axis_tready       : out std_logic; 
    s_axis_tlast        : in  std_logic;
    s_axis_tkeep        : in  std_logic_vector(((data_byte_width/bytes_per_tkeep)-1) downto 0);
     ----------------------------------------------------------------------------
    -- Outputs (AXI4-Stream Masters)
    ----------------------------------------------------------------------------
    m0_axis_tdata        : out std_logic_vector(((data_byte_width*8)-1) downto 0);
    m0_axis_tuser        : out std_logic_vector(tuser_width-1 downto 0);
    m0_axis_tvalid       : out std_logic;
    m0_axis_tready       : in  std_logic;
    m0_axis_tlast        : out std_logic; 
    m0_axis_tkeep        : out std_logic_vector(((data_byte_width/bytes_per_tkeep)-1) downto 0);   
    
    m1_axis_tdata        : out std_logic_vector(((data_byte_width*8)-1) downto 0);
    m1_axis_tuser        : out std_logic_vector(tuser_width-1 downto 0);
    m1_axis_tvalid       : out std_logic;
    m1_axis_tready       : in  std_logic;
    m1_axis_tlast        : out std_logic;
    m1_axis_tkeep        : out std_logic_vector(((data_byte_width/bytes_per_tkeep)-1) downto 0)   
);
end px_axis_1to2_demux;

architecture Behavioral of px_axis_1to2_demux is

--------------------------------------------------------------------------------
-- Attributes
--------------------------------------------------------------------------------

ATTRIBUTE X_INTERFACE_INFO : STRING;
ATTRIBUTE X_INTERFACE_PARAMETER : STRING;

ATTRIBUTE X_INTERFACE_INFO of s_axi_csr_aclk: SIGNAL is "xilinx.com:signal:clock:1.0 s_axi_csr_aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of s_axi_csr_aclk: SIGNAL is "ASSOCIATED_BUSIF s_axi_csr, ASSOCIATED_RESET s_axi_csr_aresetn";

ATTRIBUTE X_INTERFACE_INFO of s_axis_aclk: SIGNAL is "xilinx.com:signal:clock:1.0 s_axis_aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of s_axis_aclk: SIGNAL is "ASSOCIATED_BUSIF s_axis:m0_axis:m1_axis, ASSOCIATED_RESET s_axis_aresetn";

-------------------------------------------------------------------------------
-- Types
-------------------------------------------------------------------------------

type axi_state_type is
(
    RESET_STATE,
    WR_ADDR_DATA_STATE,
    WR_DATA_STATE,
    WR_ADDR2_STATE,
    WR_ADDR_STATE,
    WR_DATA2_STATE,
    WR_ADDR_DEC_STATE,
    WR_B_RSP_STATE,
    RD_ADDR_STATE,
    WAIT_RD_BS_STATE,
    WAIT_RDDATA_RDY_STATE
);

-------------------------------------------------------------------------------
-- Signals
-------------------------------------------------------------------------------

signal axi_state        : axi_state_type := RESET_STATE;
signal sel_reg          : std_logic_vector(0 downto 0)  := (others => '0');
signal t1_sel_reg       : std_logic_vector(0 downto 0)  := (others => '0');
signal t2_sel_reg       : std_logic_vector(0 downto 0)  := (others => '0');
signal rd_data          : std_logic_vector(0 downto 0)  := (others => '0');
signal w_data           : std_logic_vector(0 downto 0)  := (others => '0');
signal w_strb           : std_logic := '0';
signal sel              : std_logic := '0';
signal selx             : std_logic := '0';
signal t1_s_axi_csr_aresetn: std_logic:= '0';
-------------------------------------------------------------------------------

begin

m0_axis_tdata      <= s_axis_tdata; 
m0_axis_tuser      <= s_axis_tuser; 
m0_axis_tlast      <= s_axis_tlast; 
m0_axis_tvalid     <= s_axis_tvalid  when (selx = '0') else '0';
m0_axis_tkeep      <= s_axis_tkeep;
s_axis_tready      <= m0_axis_tready when (selx = '0') else m1_axis_tready;

m1_axis_tdata      <= s_axis_tdata; 
m1_axis_tuser      <= s_axis_tuser; 
m1_axis_tlast      <= s_axis_tlast; 
m1_axis_tkeep      <= s_axis_tkeep;
m1_axis_tvalid     <= s_axis_tvalid  when (selx = '1') else '0';

-------------------------------------------------------------------------------
-- AXI4-Lite Interface State Machine
-------------------------------------------------------------------------------
process(s_axi_csr_aclk)
begin
    if rising_edge(s_axi_csr_aclk) then
        t1_s_axi_csr_aresetn <= s_axi_csr_aresetn;
        if t1_s_axi_csr_aresetn = '0' then
           axi_state           <= RESET_STATE;
           s_axi_csr_awready   <= '0'; 
           s_axi_csr_wready    <= '0';  
           s_axi_csr_arready   <= '0'; 
           s_axi_csr_rvalid    <= '0';  
           s_axi_csr_bvalid    <= '0';
           sel_reg             <= (others => '0');
        else 
           case axi_state is 
            when RESET_STATE =>
                if (t1_s_axi_csr_aresetn = '0') then
                    axi_state           <= RESET_STATE;
                    s_axi_csr_awready   <= '0';
                    s_axi_csr_wready    <= '0';
                    s_axi_csr_arready   <= '0'; 
                    s_axi_csr_rvalid    <= '0';  
                    s_axi_csr_bvalid    <= '0';
                    sel_reg             <= (others => '0');
                elsif (s_axi_csr_awvalid = '1') then  
                    if (s_axi_csr_wvalid = '1') then
                        axi_state <=  WR_ADDR_DATA_STATE;
                    else
                        axi_state <=  WR_ADDR_STATE;
                    end if; 
                elsif (s_axi_csr_wvalid = '1') then
                    axi_state <=  WR_DATA_STATE;
                elsif (s_axi_csr_arvalid = '1') then
                    axi_state <=  RD_ADDR_STATE;
                else
                    axi_state <= RESET_STATE;
                end if;    
             when WR_ADDR_DATA_STATE =>
                s_axi_csr_wready  <= '1';
                s_axi_csr_awready <= '1';       
                w_strb            <= s_axi_csr_wstrb(0);
                w_data            <= s_axi_csr_wdata(0 downto 0);
                axi_state         <= WR_ADDR_DEC_STATE;
             when WR_DATA_STATE =>
                s_axi_csr_wready  <= '1';
                w_strb            <= s_axi_csr_wstrb(0);
                w_data            <= s_axi_csr_wdata(0 downto 0);
                axi_state         <= WR_ADDR2_STATE;
             when WR_ADDR2_STATE =>
                s_axi_csr_wready     <= '0';
                if (s_axi_csr_awvalid = '1') then      
                   axi_state  <= WR_ADDR_DEC_STATE;
                   s_axi_csr_awready <= '1';
                else
                   axi_state         <= WR_ADDR2_STATE;
                end if;  
             when WR_ADDR_STATE =>
                   s_axi_csr_awready <= '1';
                   axi_state     <= WR_DATA2_STATE;
             when WR_DATA2_STATE =>
                s_axi_csr_awready <= '0';
                if (s_axi_csr_wvalid = '1') then      
                   axi_state        <= WR_ADDR_DEC_STATE;
                   s_axi_csr_wready <= '1';
                   w_strb           <= s_axi_csr_wstrb(0);
                   w_data           <= s_axi_csr_wdata(0 downto 0);
                else
                   axi_state  <= WR_DATA2_STATE;
                end if;    
             when WR_ADDR_DEC_STATE =>
                s_axi_csr_wready  <= '0';
                s_axi_csr_awready <= '0';   
                if w_strb = '1' then
                  sel_reg           <= w_data;
                end if;                   
                axi_state         <= WR_B_RSP_STATE;
                s_axi_csr_bresp   <= "00";
                s_axi_csr_bvalid  <= '1';     
            when  WR_B_RSP_STATE =>
                if s_axi_csr_bready = '1' then
                    s_axi_csr_bvalid <= '0';
                    axi_state <= RESET_STATE;
                else
                    axi_state <= WR_B_RSP_STATE;
                end if;    
            when  RD_ADDR_STATE =>
               s_axi_csr_arready <= '1';
               rd_data     <= sel_reg; 
               axi_state   <= WAIT_RD_BS_STATE;
            when WAIT_RD_BS_STATE =>
                s_axi_csr_arready <= '0';
                s_axi_csr_rdata(0 downto 0) <= rd_data;
                s_axi_csr_rvalid  <= '1'; 
                s_axi_csr_rresp   <= "00";
                axi_state         <= WAIT_RDDATA_RDY_STATE;              
            when WAIT_RDDATA_RDY_STATE =>   
                if s_axi_csr_rready = '1' then
                   s_axi_csr_rvalid <= '0';
                   axi_state        <= RESET_STATE;
                else
                   axi_state        <= WAIT_RDDATA_RDY_STATE;     
                end if;  
            when others =>
               axi_state <= RESET_STATE;
          end case;
       end if;
   end if;  
end process;

sel <= sel_reg(0);

s_axi_csr_rdata(31 downto 1) <= x"0000000" & "000";

xpm_cdc_single_inst: xpm_cdc_single
  generic map (
     DEST_SYNC_FF   => 3, -- integer; range: 2-10
     SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
     SRC_INPUT_REG  => 1  -- integer; 0=do not register input, 1=register input
  )
  port map (
     src_clk  => s_axi_csr_aclk,  -- optional; required when SRC_INPUT_REG = 1
     src_in   => sel,
     dest_clk => s_axis_aclk,
     dest_out => selx
  );


end Behavioral;
