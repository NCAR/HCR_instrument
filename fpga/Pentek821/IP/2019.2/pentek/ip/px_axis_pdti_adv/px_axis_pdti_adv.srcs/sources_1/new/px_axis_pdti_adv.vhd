----------------------------------------------------------------------------------
-- Company: Pentek, Inc.
-- Engineer: 
-- 
-- Create Date: 05/13/2015 08:59:53 AM
-- Design Name: 
-- Module Name: px_axis_pdti_adv - Behavioral
-- Project Name: 
-- Target Devices: Ultrascale Kintex
-- Tool Versions: 
-- Description: Advances Data and timestamp in an AXI-S bus in relation to Gate/Sync/PPS  
-- Can be use for "pre-triggering."
--
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

-- (c) Copyright 2015 Pentek, Inc. All rights reserved.
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity px_axis_pdti_adv is
generic (
    has_csr : boolean := true; -- Has register control
    data_byte_width   : integer := 2;  -- Width of input data stream in bytes 
    delay_ctl_width   : integer := 8   -- Width of Delay Control Input when CSR is not present  (1 to 16)
);
port (
    --------------------------------------------------------------------------------
    -- AXI LITE Slave Interface  (optional)
    -- DWORD Addressing
    --------------------------------------------------------------------------------
    s_axi_csr_aclk            : in  std_logic;
    s_axi_csr_aresetn         : in  std_logic;
    s_axi_csr_awaddr          : in  std_logic_vector(2 downto 0);
    s_axi_csr_awprot          : in  std_logic_vector(2 downto 0); -- not used
    s_axi_csr_awvalid         : in  std_logic;
    s_axi_csr_awready         : out std_logic;
    s_axi_csr_wdata           : in  std_logic_vector(31 downto 0);
    s_axi_csr_wstrb           : in  std_logic_vector(3 downto 0); 
    s_axi_csr_wvalid          : in  std_logic;
    s_axi_csr_wready          : out std_logic;
    s_axi_csr_bresp           : out std_logic_vector(1 downto 0);
    s_axi_csr_bvalid          : out std_logic;
    s_axi_csr_bready          : in  std_logic;
    s_axi_csr_araddr          : in  std_logic_vector(2 downto 0);
    s_axi_csr_arprot          : in  std_logic_vector(2 downto 0); -- not used
    s_axi_csr_arvalid         : in  std_logic;
    s_axi_csr_arready         : out std_logic;
    s_axi_csr_rdata           : out std_logic_vector(31 downto 0);
    s_axi_csr_rresp           : out std_logic_vector(1 downto 0);
    s_axi_csr_rvalid          : out std_logic;
    s_axi_csr_rready          : in  std_logic;
    -----------------------------------------------------------------------------
    -- Optional Control
    -----------------------------------------------------------------------------
    delay_ctl                 : in std_logic_vector(delay_ctl_width-1 downto 0);
    --------------------------------------------------------------------------------
    -- BRAM Interfaces
    --------------------------------------------------------------------------------
    -- Out to BRAM 
    bram_wrport_rst            : out std_logic;
    bram_wrport_clk            : out std_logic;
    bram_wrport_en             : out std_logic;
    bram_wrport_we             : out std_logic_vector(data_byte_width+15 downto 0);
    bram_wrport_addr           : out std_logic_vector(delay_ctl_width-1 downto 0);
    bram_wrport_wrdata         : out std_logic_vector(((data_byte_width*8)-1)+128 downto 0);
    -- From BRAM (expects a 2 cycle latency in BRAM) 
    bram_rdport_rst            : out std_logic;
    bram_rdport_clk            : out std_logic;
    bram_rdport_en             : out std_logic;
    bram_rdport_addr           : out std_logic_vector(delay_ctl_width-1 downto 0);  
    bram_rdport_rddata         : in  std_logic_vector(((data_byte_width*8)-1)+128 downto 0);
    -----------------------------------------------------------------------------
    -- AXI4- Stream Clock
    -----------------------------------------------------------------------------
    s_axis_aclk                : in  std_logic;
    s_axis_aresetn             : in  std_logic;
    -----------------------------------------------------------------------------
    -- Input Data Data/Time/Info Streams (AXI4-Stream Slave) no back pressure
    -----------------------------------------------------------------------------
    -- tuser[63:0]    = timestamp[63:0]
    -- tuser[71:64]   = Gate Positions  
    -- tuser[79:72]   = Sync Positions      
    -- tuser[87:80]   = PPS Positions
    -- tuser[92:88]   = Samples/Cycle
    -- tuser[94:93]   = Data Format 0 = 8-bit 1= 16 bit 2 = 32-bit
    -- tuser[95]      = Data Type 0 = Real 1 = I/Q
    -- tuser[103:96]  = channel[7:0] 
    -- tuser[127:104] = Reserved 
    -----------------------------------------------------------------------------
    s_axis_pdti_tdata     : in  std_logic_vector(((data_byte_width*8)-1) downto 0);
    s_axis_pdti_tuser     : in  std_logic_vector(127 downto 0);
    s_axis_pdti_tvalid    : in  std_logic;
    ----------------------------------------------------------------------------
    -- Output
    ----------------------------------------------------------------------------
    m_axis_pdti_tdata     : out std_logic_vector(((data_byte_width*8)-1) downto 0);
    m_axis_pdti_tuser     : out std_logic_vector(127 downto 0);
    m_axis_pdti_tvalid    : out std_logic    
);
end px_axis_pdti_adv;

architecture Behavioral of px_axis_pdti_adv is

--------------------------------------------------------------------------------
-- Attributes
--------------------------------------------------------------------------------

ATTRIBUTE X_INTERFACE_INFO : STRING;
ATTRIBUTE X_INTERFACE_PARAMETER : STRING;

ATTRIBUTE X_INTERFACE_INFO of s_axi_csr_aclk: SIGNAL is "xilinx.com:signal:clock:1.0 s_axi_csr_aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of s_axi_csr_aclk: SIGNAL is "ASSOCIATED_BUSIF s_axi_csr, ASSOCIATED_RESET s_axi_csr_aresetn";

ATTRIBUTE X_INTERFACE_INFO of s_axis_aclk: SIGNAL is "xilinx.com:signal:clock:1.0 s_axis_aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of s_axis_aclk: SIGNAL is "ASSOCIATED_BUSIF s_axis_pdti:m_axis_pdti, ASSOCIATED_RESET s_axis_aresetn";

ATTRIBUTE X_INTERFACE_INFO of bram_wrport_clk: SIGNAL is "xilinx.com:signal:clock:1.0 bram_wrport_clk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of bram_wrport_clk: SIGNAL is "ASSOCIATED_BUSIF bram_wrport, ASSOCIATED_RESET bram_wrport_rst";

ATTRIBUTE X_INTERFACE_INFO of bram_rdport_clk: SIGNAL is "xilinx.com:signal:clock:1.0 bram_rdport_clk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of bram_rdport_clk: SIGNAL is "ASSOCIATED_BUSIF bram_rdport, ASSOCIATED_RESET bram_rdport_rst";

ATTRIBUTE X_INTERFACE_INFO of bram_wrport_rst: SIGNAL is "xilinx.com:signal:reset:1.0 bram_wrport_rst RST";
ATTRIBUTE X_INTERFACE_PARAMETER of bram_wrport_rst: SIGNAL is "POLARITY ACTIVE_HIGH";

ATTRIBUTE X_INTERFACE_INFO of bram_rdport_rst: SIGNAL is "xilinx.com:signal:reset:1.0 bram_rdport_rst RST";
ATTRIBUTE X_INTERFACE_PARAMETER of bram_rdport_rst: SIGNAL is "POLARITY ACTIVE_HIGH";

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

--------------------------------------------------------------------------------
-- Signals
--------------------------------------------------------------------------------

signal rd_data          : std_logic_vector(15 downto 0)  := (others => '0');
signal w_data           : std_logic_vector(15 downto 0)  := (others => '0');
signal w_strb           : std_logic_vector(3 downto 0)   := (others => '0');
signal axi_state        : axi_state_type := RESET_STATE;
signal delay_ctl_reg    : std_logic_vector(15 downto 0)  := (others => '0');
signal delay_ctl_in     : std_logic_vector(delay_ctl_width-1 downto 0)  := (others => '0');
signal dly_wr_cntr      : std_logic_vector(delay_ctl_width-1 downto 0)  := (others => '0');
signal dly_rd_cntr      : std_logic_vector(delay_ctl_width-1 downto 0)  := (others => '0');
signal rs_delay_ctl     : std_logic_vector(delay_ctl_width-1 downto 0)  := (others => '0');
signal t1_rs_delay_ctl  : std_logic_vector(delay_ctl_width-1 downto 0)  := (others => '0');
signal t1_s_axis_aresetn: std_logic := '0';
signal bram_rst         : std_logic := '0';  
signal dly_tvalid       : std_logic_vector(4 downto 0)   := (others => '0');  
signal t1_dly_tuser     : std_logic_vector(127 downto 0) := (others => '0');  
signal t2_dly_tuser     : std_logic_vector(23 downto 0)  := (others => '0');  
signal t3_dly_tuser     : std_logic_vector(23 downto 0)  := (others => '0');  
signal t4_dly_tuser     : std_logic_vector(23 downto 0)  := (others => '0');  
signal t5_dly_tuser     : std_logic_vector(23 downto 0)  := (others => '0');  
signal t1_dly_tdata     : std_logic_vector(((data_byte_width*8)-1) downto 0):= (others => '0');
signal t1_s_axi_csr_aresetn: std_logic := '0'; 
--------------------------------------------------------------------------------

begin

-- Generate CSR Port
gen_csr: if (has_csr = true) generate
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
           delay_ctl_reg       <= (others => '0');
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
                    delay_ctl_reg       <= (others => '0');
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
                w_strb            <= s_axi_csr_wstrb;
                w_data            <= s_axi_csr_wdata(15 downto 0);
                axi_state         <= WR_ADDR_DEC_STATE;
             when WR_DATA_STATE =>
                s_axi_csr_wready  <= '1';
                w_strb            <= s_axi_csr_wstrb;
                w_data            <= s_axi_csr_wdata(15 downto 0);
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
                   w_strb           <= s_axi_csr_wstrb;
                   w_data           <= s_axi_csr_wdata(15 downto 0);
                else
                   axi_state  <= WR_DATA2_STATE;
                end if;    
             when WR_ADDR_DEC_STATE =>
                s_axi_csr_wready  <= '0';
                s_axi_csr_awready <= '0';   
                if w_strb(0) = '1' then   
                  delay_ctl_reg(7 downto 0)  <= w_data(7 downto 0);
                end if;  
                if w_strb(1) = '1' then   
                  delay_ctl_reg(15 downto 8) <= w_data(15 downto 8);
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
               rd_data     <= delay_ctl_reg; 
               axi_state   <= WAIT_RD_BS_STATE;
            when WAIT_RD_BS_STATE =>
                s_axi_csr_arready <= '0';
                s_axi_csr_rdata(15 downto 0) <= rd_data;
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

s_axi_csr_rdata(31 downto 16) <= x"0000";

delay_ctl_in <= delay_ctl_reg(delay_ctl_width-1 downto 0);

end generate;

-- No CSR Port
gen_no_csr: if (has_csr = false) generate

    s_axi_csr_awready   <= '1';    
    s_axi_csr_wready    <= '1';    
    s_axi_csr_bresp     <= "00";   
    s_axi_csr_bvalid    <= '1';    
    s_axi_csr_arready   <= '1';    
    s_axi_csr_rdata     <= x"00000000"; 
    s_axi_csr_rresp     <= "00";   
    s_axi_csr_rvalid    <= '1';  
    
    delay_ctl_in        <= delay_ctl;  

end generate;

gen_dly_ctl_hs: for i in 0 to (delay_ctl_width-1) generate    

-- Synchronize Delay Control to AXI-S clock domain
HARD_SYNC_inst: HARD_SYNC
   generic map (
      INIT => '0',            -- Initial values, '0', '1'
      IS_CLK_INVERTED => '0', -- Programmable inversion on CLK input
      LATENCY => 3            -- 2-3
   )
   port map (
      DOUT => rs_delay_ctl(i), -- 1-bit output: Data
      CLK  => s_axis_aclk,   -- 1-bit input: Clock
      DIN  => delay_ctl_in(i)    -- 1-bit input: Data
   );
    
end generate;


-- BRAM Address Counters
process(s_axis_aclk)
begin
   if rising_edge(s_axis_aclk) then
      t1_rs_delay_ctl      <= rs_delay_ctl;
      t1_s_axis_aresetn    <= s_axis_aresetn;
      bram_rst             <= not t1_s_axis_aresetn; 
      if (t1_s_axis_aresetn = '0') then
         dly_wr_cntr       <= (others => '0');
         dly_rd_cntr       <= 0 - t1_rs_delay_ctl;
      elsif (dly_tvalid(0) = '1') then
         dly_wr_cntr       <= dly_wr_cntr + 1;
         dly_rd_cntr       <= dly_wr_cntr - t1_rs_delay_ctl;
      end if;
   end if;
end process;

    -- Out to BRAM 
    bram_wrport_en             <= '1';
    bram_wrport_we             <= (others => '1') when (dly_tvalid(0) = '1') else (others => '0');
    bram_wrport_addr           <= dly_wr_cntr;
    bram_wrport_wrdata         <= t1_dly_tuser & t1_dly_tdata; 
    -- From BRAM (expects a 2 cycle latency in BRAM) 

    bram_rdport_en             <= '1';
    bram_rdport_addr           <= dly_rd_cntr;
    
    bram_wrport_rst            <= bram_rst;
    bram_wrport_clk            <= s_axis_aclk;
    
    bram_rdport_rst            <= bram_rst;
    bram_rdport_clk            <= s_axis_aclk;

process(s_axis_aclk)
begin
   if rising_edge(s_axis_aclk) then
      t1_dly_tdata                     <= s_axis_pdti_tdata;
      dly_tvalid(4 downto 0)           <= dly_tvalid(3 downto 0) & s_axis_pdti_tvalid;
      t1_dly_tuser                     <= s_axis_pdti_tuser;
      t2_dly_tuser                     <= t1_dly_tuser(87 downto 64);
      t3_dly_tuser                     <= t2_dly_tuser;
      t4_dly_tuser                     <= t3_dly_tuser;
      t5_dly_tuser                     <= t4_dly_tuser;
      m_axis_pdti_tdata                <= bram_rdport_rddata(((data_byte_width*8)-1) downto 0);
      m_axis_pdti_tuser(63 downto 0)   <= bram_rdport_rddata(((data_byte_width*8)+63) downto (data_byte_width*8));
      m_axis_pdti_tuser(127 downto 88) <= bram_rdport_rddata(((data_byte_width*8)+127) downto (data_byte_width*8)+88);
      m_axis_pdti_tuser(87 downto 64)  <= t4_dly_tuser(23 downto 0);  
      m_axis_pdti_tvalid               <= dly_tvalid(3);
   end if;
end process;       



end Behavioral;
