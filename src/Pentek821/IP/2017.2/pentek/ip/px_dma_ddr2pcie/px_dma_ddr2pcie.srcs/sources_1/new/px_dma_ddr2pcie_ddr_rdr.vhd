----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/05/2017 01:39:15 PM
-- Design Name: 
-- Module Name: px_dma_ddr2pcie_ddr_rdr - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------
-------------------------------------------------------------------------------

-- (c) Copyright 2016 Pentek, Inc. All rights reserved.
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

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity px_dma_ddr2pcie_ddr_rdr is
generic (
   ddr4_requestor_id : integer := 0
);
port (
    -----------------------------------------------------------------------------
    -- Command
    -----------------------------------------------------------------------------
    s_axis_ddr_cmd_tdata    : in  std_logic_vector(31 downto 0); -- DDR4 Address
    s_axis_ddr_cmd_tuser    : in  std_logic_vector(31 downto 0); -- Read Length (bytes)
    s_axis_ddr_cmd_tvalid   : in  std_logic;
    s_axis_ddr_cmd_tready   : out std_logic;
    s_axis_ddr_cmd_aclk     : in  std_logic;
    s_axis_ddr_cmd_aresetn  : in  std_logic;
    
    abort                   : in  std_logic;
    ddr_read_cmplt          : out std_logic;    
    -----------------------------------------------------------------------------
    -- DDR4 Request Interface (AXI Stream)
    ----------------------------------------------------------------------------  
    axis_ddr_aclk         : in  std_logic;
    -- tuser[127:0]   = Request Header
    -- tuser[31:0]    = Address (Address must be aligned to the request size boundaries)
    -- tuser[34:32]   = Future Address Expansion
    -- tuser[35]      = Read = 1, Write = 0
    -- tuser[39:36]   = Reserved
    -- tuser[119:40]  = Byte Masks
    -- tuser[255:128] = Upper 128-bits of RAM Data 
    m_axis_rqst_tvalid    : out std_logic;
    m_axis_rqst_tready    : in  std_logic;   
    m_axis_rqst_tlast     : out std_logic;
    m_axis_rqst_tid       : out std_logic_vector(7 downto 0);
    m_axis_rqst_tdata     : out std_logic_vector(511 downto 0); 
    m_axis_rqst_tuser     : out std_logic_vector(255 downto 0);
    -----------------------------------------------------------------------------
    -- DDR4 Response Interface (AXI Stream)
    ----------------------------------------------------------------------------  
    -- tuser[127:0]   = Request Header
    -- tuser[31:0]    = Address (Address must be aligned to the request size boundaries)
    -- tuser[34:32]   = Future Address Expansion
    -- tuser[35]      = Read = 1, Write = 0
    -- tuser[39:36]   = Reserved
    -- tuser[119:40]  = Byte Masks
    -- tuser[255:128] = Upper 128-bits of RAM Data 
    s_axis_rsp_tvalid    : in  std_logic;
    s_axis_rsp_tlast     : in  std_logic;
    s_axis_rsp_tid       : in  std_logic_vector(7 downto 0);
    s_axis_rsp_tdata     : in  std_logic_vector(511 downto 0); 
    s_axis_rsp_tuser     : in  std_logic_vector(255 downto 0);
    -----------------------------------------------------------------------------
    -- Output Data to PCIE Payload FIFO
    -----------------------------------------------------------------------------
    m_axis_tdata         : out std_logic_vector(511 downto 0);
    m_axis_tuser         : out std_logic_vector(7 downto 0); -- Valid Bytes
    m_axis_tlast         : out std_logic; 
    m_axis_tvalid        : out std_logic;
    pcie_afl             : in  std_logic;
    
    consec_access        : in  std_logic_vector(5 downto 0);
    
    ddr_rqst_fifo_afl    : out std_logic; 
    ddr_rqst_fifo_empty  : out std_logic
    );
end px_dma_ddr2pcie_ddr_rdr;

architecture Behavioral of px_dma_ddr2pcie_ddr_rdr is

--------------------------------------------------------------------------------
-- Components
--------------------------------------------------------------------------------

COMPONENT px_dma_ddr2pcie_rdrcc
  PORT (
    s_axis_aresetn : IN STD_LOGIC;
    m_axis_aresetn : IN STD_LOGIC;
    s_axis_aclk : IN STD_LOGIC;
    s_axis_tvalid : IN STD_LOGIC;
    s_axis_tready : OUT STD_LOGIC;
    s_axis_tdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axis_tuser : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    m_axis_aclk : IN STD_LOGIC;
    m_axis_tvalid : OUT STD_LOGIC;
    m_axis_tready : IN STD_LOGIC;
    m_axis_tdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    m_axis_tuser : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
  );
END COMPONENT;

-- 16 Deep 
-- afl at 14
COMPONENT px_ddr2pcie_rqst_fifo
  PORT (
    s_aclk : IN STD_LOGIC;
    s_aresetn : IN STD_LOGIC;
    s_axis_tvalid : IN STD_LOGIC;
    s_axis_tready : OUT STD_LOGIC;
    s_axis_tlast  : IN STD_LOGIC;
    s_axis_tdata : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
    m_axis_tvalid : OUT STD_LOGIC;
    m_axis_tready : IN STD_LOGIC;
    m_axis_tdata : OUT STD_LOGIC_VECTOR(127 DOWNTO 0);
    m_axis_tlast  : OUT STD_LOGIC;
    axis_prog_full : OUT STD_LOGIC
  );
END COMPONENT;

--------------------------------------------------------------------------------
-- Types
--------------------------------------------------------------------------------

type state_type is
(
RESET_STATE,
START_STATE,
RQST_STATE,
WAIT_STATE,
END_STATE
);

--------------------------------------------------------------------------------
-- Signals
--------------------------------------------------------------------------------

signal state : state_type := RESET_STATE;
signal tvalid : std_logic := '0';
signal tready : std_logic := '0';
signal tdata : std_logic_vector(31 downto 0) := (others => '0');
signal tuser : std_logic_vector(31 downto 0) := (others => '0');
signal m_aresetn : std_logic := '0';
signal rqst_tvalid : std_logic := '0';
signal rqst_tdata : std_logic_vector(127 downto 0) := (others => '0');
signal addr : std_logic_vector(31 downto 0) := (others => '0');
signal len_cntr : std_logic_vector(31 downto 0) := (others => '0');
signal afl : std_logic := '0';
signal rqstout_tdata : std_logic_vector(127 downto 0) := (others => '0');
signal t1_s_axis_rsp_tvalid : std_logic := '0';
signal t1_s_axis_rsp_tlast : std_logic := '0'; 
signal t1_s_axis_rsp_tid : std_logic_vector(7 downto 0) := (others => '0');   
signal t1_s_axis_rsp_tdata : std_logic_vector(511 downto 0) := (others => '0'); 
signal t1_s_axis_rsp_tuser : std_logic_vector(127 downto 0) := (others => '0'); 
signal tk : std_logic_vector(15 downto 0) := (others => '0'); 
signal read_cmplt : std_logic := '0';  
signal axis_ddr_areset: std_logic := '0';  
signal axis_ddr_aresetn: std_logic := '0';  
signal t1_pcie_afl: std_logic := '0';
signal t1_consec_access: std_logic_vector(5 downto 0) := (others => '0');
signal rqst_tlast: std_logic := '0';
signal access_cntr: std_logic_vector(5 downto 0) := (others => '0');
signal abortx : std_logic := '0';
signal s_axis_ddr_cmd_areset : std_logic := '0';
signal sm_rstn    : std_logic := '0';  
signal fifo_rstn  : std_logic := '0'; 
signal int_m_axis_rqst_tvalid: std_logic := '0'; 
--------------------------------------------------------------------------------

begin

--------------------------------------------------------------------------------
-- AXI-S Clock Converter
--------------------------------------------------------------------------------

cmd_cc_inst : px_dma_ddr2pcie_rdrcc
port map (
    s_axis_aresetn   => s_axis_ddr_cmd_aresetn,
    m_axis_aresetn   => m_aresetn,
    s_axis_aclk      => s_axis_ddr_cmd_aclk,
    s_axis_tvalid    => s_axis_ddr_cmd_tvalid,
    s_axis_tready    => s_axis_ddr_cmd_tready,
    s_axis_tdata     => s_axis_ddr_cmd_tdata,
    s_axis_tuser     => s_axis_ddr_cmd_tuser,
    m_axis_aclk      => axis_ddr_aclk,
    m_axis_tvalid    => tvalid,
    m_axis_tready    => tready,
    m_axis_tdata     => tdata,
    m_axis_tuser     => tuser
  );

s_axis_ddr_cmd_areset <= not s_axis_ddr_cmd_aresetn;

abort_cdc_inst: xpm_cdc_pulse
  generic map (
    -- Common module generics
    DEST_SYNC_FF   => 3, -- integer; range: 2-10
    REG_OUTPUT     => 1, -- integer; 0=disable registered output,   1=enable registered output
    RST_USED       => 1, -- integer; 0=no reset, 1=implement reset
    SIM_ASSERT_CHK => 0  -- integer; 0=disable simulation messages, 1=enable simulation messages
  )
  port map (
    src_clk    => s_axis_ddr_cmd_aclk,
    src_rst    => s_axis_ddr_cmd_areset,   -- optional; required when RST_USED = 1
    src_pulse  => abort,
    dest_clk   => axis_ddr_aclk,
    dest_rst   => '0',  -- optional; required when RST_USED = 1
    dest_pulse => abortx
  );
	
con_cdc_inst: xpm_cdc_array_single
    generic map (
      -- Common module generics
      DEST_SYNC_FF   => 3, -- integer; range: 2-10
      SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
      SRC_INPUT_REG  => 1, -- integer; 0=do not register input, 1=register input
      WIDTH          => 6  -- integer; range: 1-1024
    )
    port map (
      src_clk  => s_axis_ddr_cmd_aclk,  -- optional; required when SRC_INPUT_REG = 1
      src_in   => consec_access,
      dest_clk => axis_ddr_aclk,
      dest_out => t1_consec_access
    );	
	
--------------------------------------------------------------------------------
-- DDR4 Request Generation
--------------------------------------------------------------------------------
m_aresetn <= axis_ddr_aresetn;

process(axis_ddr_aclk)
begin
    if rising_edge(axis_ddr_aclk) then
      t1_pcie_afl <= pcie_afl;
      if (axis_ddr_aresetn = '0') or (abortx = '1') then
         state        <= RESET_STATE; 
         tready       <= '0';
         read_cmplt   <= '0';
         rqst_tvalid  <= '0';
         rqst_tlast   <= '0';
         sm_rstn      <= '0';
      else
         case state is
            when RESET_STATE =>
               if (axis_ddr_aresetn = '0') or (abortx = '1')  then
                  state     <= RESET_STATE; 
               else   
                  state     <= START_STATE;
                  tready    <= '1';
                  sm_rstn   <= '1'; 
               end if;
               read_cmplt   <= '0';
               rqst_tvalid  <= '0';
               rqst_tlast   <= '0';                 
            when START_STATE =>
               --sm_rstn      <= '1';  
               if tvalid = '1' then
                  state     <= RQST_STATE;
                  tready    <= '0';
                  addr      <= tdata(31 downto 6) & "000000"; 
                  len_cntr  <= tuser(31 downto 2) & "00";
                  access_cntr <= "000000";
               end if;
            when RQST_STATE  =>
               if (len_cntr > 64) then -- more than 64 bytes left to request
                  len_cntr                  <= len_cntr - 64;
                  addr                      <= addr + 64;
                  if (access_cntr = t1_consec_access) then -- limit consecutive DDR4 requests for fair arbitration
                     access_cntr               <= "000000";
                     rqst_tlast                <= '1';
                  else
                     access_cntr               <= access_cntr + 1;
                     rqst_tlast                <= '0';
                  end if;   
                  rqst_tvalid               <= '1';
                  rqst_tdata(31 downto 0)   <= addr; 
                  rqst_tdata(95 downto 32)  <= x"0000000000000000"; -- mask bits
                  if (afl = '0') and (t1_pcie_afl = '0') then
                     state                  <= RQST_STATE;
                  else
                     state                  <= WAIT_STATE;
                  end if;
               else -- Last Request
                  state                     <= END_STATE;
                  rqst_tdata(31 downto 0)   <= addr; 
                  -- mask bits
                  case len_cntr(5 downto 2) is
                     when "0001" => 
                         rqst_tdata(95 downto 32) <= x"FFFFFFFFFFFFFFF0";
                     when "0010" => 
                         rqst_tdata(95 downto 32) <= x"FFFFFFFFFFFFFF00";
                     when "0011" => 
                         rqst_tdata(95 downto 32) <= x"FFFFFFFFFFFFF000";
                     when "0100" => 
                         rqst_tdata(95 downto 32) <= x"FFFFFFFFFFFF0000";
                     when "0101" => 
                         rqst_tdata(95 downto 32) <= x"FFFFFFFFFFF00000";
                     when "0110" => 
                         rqst_tdata(95 downto 32) <= x"FFFFFFFFFF000000";
                     when "0111" => 
                         rqst_tdata(95 downto 32) <= x"FFFFFFFFF0000000";
                     when "1000" => 
                         rqst_tdata(95 downto 32) <= x"FFFFFFFF00000000";
                     when "1001" => 
                         rqst_tdata(95 downto 32) <= x"FFFFFFF000000000";
                     when "1010" => 
                         rqst_tdata(95 downto 32) <= x"FFFFFF0000000000";
                     when "1011" => 
                         rqst_tdata(95 downto 32) <= x"FFFFF00000000000";
                     when "1100" => 
                         rqst_tdata(95 downto 32) <= x"FFFF000000000000";
                     when "1101" => 
                         rqst_tdata(95 downto 32) <= x"FFF0000000000000";
                     when "1110" => 
                         rqst_tdata(95 downto 32) <= x"FF00000000000000";
                     when "1111" => 
                         rqst_tdata(95 downto 32) <= x"F000000000000000";
                     when "0000" => 
                         rqst_tdata(95 downto 32) <= x"0000000000000000";     
                     when others =>
                         rqst_tdata(95 downto 32) <= x"0000000000000000";                                                   
                  end case;
                  if len_cntr /= x"00000000" then
                     rqst_tvalid  <= '1';
                  else
                     rqst_tvalid  <= '0';
                  end if;    
                  rqst_tlast      <= '1';
               end if; 
            when END_STATE   =>
               read_cmplt   <= '1';
               state        <= RESET_STATE;
               rqst_tvalid  <= '0';
               rqst_tlast   <= '0';
            when WAIT_STATE =>
               rqst_tvalid  <= '0';
               if (afl = '0') and (t1_pcie_afl = '0') then
                  state     <= RQST_STATE;
               else
                  state     <= WAIT_STATE;
               end if;  
            when others =>
               state        <= RESET_STATE;
         end case;   
      end if;
    end if;
end process;

axis_ddr_areset <= not axis_ddr_aresetn;

cmplr_cdc_inst: xpm_cdc_pulse
generic map (
   -- Common module generics
   DEST_SYNC_FF   => 3, -- integer; range: 2-10
   REG_OUTPUT     => 1, -- integer; 0=disable registered output,   1=enable registered output
   RST_USED       => 1, -- integer; 0=no reset, 1=implement reset
   SIM_ASSERT_CHK => 0  -- integer; 0=disable simulation messages, 1=enable simulation messages
  )
port map (
   src_clk    => axis_ddr_aclk,
   src_rst    => axis_ddr_areset,   -- optional; required when RST_USED = 1
   src_pulse  => read_cmplt,
   dest_clk   => s_axis_ddr_cmd_aclk,
   dest_rst   => '0',  -- optional; required when RST_USED = 1
   dest_pulse => ddr_read_cmplt
  );

-- Request Construction

    -- tuser[127:0] = Request Header
    -- tuser[31:0]  = Address (Address must be aligned to 64-byte boundaries 5:0 = 000000)
    -- tuser[34:32] = Future Address Expansion
    -- tuser[35]    = Read = 1, Write = 0
    -- tuser[39:36] = Reserved
    -- tuser[119:40]= Byte Masks
    -- tuser[255:128] = Upper 128-bits of RAM Data 
--    m_axis_ddr_aclk          : in  std_logic; 
--    m_axis_ddr_rqst_tvalid   : out std_logic;
--    m_axis_ddr_rqst_tready   : in  std_logic;   
--    m_axis_ddr_rqst_tlast    : out std_logic;
--    m_axis_ddr_rqst_tid      : out std_logic_vector(7 downto 0);
--    m_axis_ddr_rqst_tdata    : out std_logic_vector(511 downto 0); 
--    m_axis_ddr_rqst_tuser    : out std_logic_vector(255 downto 0);

-- Output Request FIFO

rqst_tdata(127 downto 96) <= (others => '0');
 
rqst_fifo_inst : px_ddr2pcie_rqst_fifo
port map (
    s_aclk          => axis_ddr_aclk,
    s_aresetn       => fifo_rstn,
    s_axis_tvalid   => rqst_tvalid,
    s_axis_tready   => open,
    s_axis_tdata    => rqst_tdata,
    s_axis_tlast    => rqst_tlast,
    m_axis_tvalid   => int_m_axis_rqst_tvalid,
    m_axis_tready   => m_axis_rqst_tready,
    m_axis_tdata    => rqstout_tdata,
    m_axis_tlast    => m_axis_rqst_tlast,
    axis_prog_full  => afl
  );

m_axis_rqst_tvalid <= int_m_axis_rqst_tvalid;
fifo_rstn <= axis_ddr_aresetn and sm_rstn;

m_axis_rqst_tuser  <= x"00000000000000000000000000000000" & x"00FFFF" & rqstout_tdata(95 downto 32) & x"08" & rqstout_tdata(31 downto 0);
m_axis_rqst_tdata  <= x"00000000000000000000000000000000" & x"00000000000000000000000000000000" &
                      x"00000000000000000000000000000000" & x"00000000000000000000000000000000";                
m_axis_rqst_tid    <= conv_std_logic_vector(ddr4_requestor_id, 8);

process(axis_ddr_aclk)
begin
    if rising_edge(axis_ddr_aclk) then
      ddr_rqst_fifo_afl   <= afl;
      ddr_rqst_fifo_empty <= not int_m_axis_rqst_tvalid;
   end if;
end process;   

--------------------------------------------------------------------------------
-- DDR4 Responses
--------------------------------------------------------------------------------

    -- tuser[127:0] = Response Header
    -- tuser[31:0]  = Address (Address must be aligned to 64-byte boundaries 5:0 = 000000)
    -- tuser[34:32] = Future Address Expansion
    -- tuser[39:36] = Reserved
    -- tuser[119:40]= Byte Masks 
    -- tuser[255:128] = Upper 128-bits of RAM Data 
    --s_axis_ddr_rsp_tvalid    : in  std_logic;
    --s_axis_ddr_rsp_tlast     : in  std_logic;
    --s_axis_ddr_rsp_tid       : in  std_logic_vector(7 downto 0);
    --s_axis_ddr_rsp_tdata     : in  std_logic_vector(511 downto 0); 
    --s_axis_ddr_rsp_tuser     : in  std_logic_vector(255 downto 0);
    
-- AXI-S Register Slice     
process(axis_ddr_aclk)
begin
   if rising_edge(axis_ddr_aclk) then
      t1_s_axis_rsp_tvalid <= s_axis_rsp_tvalid;
      t1_s_axis_rsp_tlast  <= s_axis_rsp_tlast;
      t1_s_axis_rsp_tid    <= s_axis_rsp_tid;  
      t1_s_axis_rsp_tdata  <= s_axis_rsp_tdata;
      t1_s_axis_rsp_tuser(127 downto 0) <= s_axis_rsp_tuser(127 downto 0);
      case tk is
         when x"0000" => 
            m_axis_tuser <= x"40";
         when x"8000" => 
            m_axis_tuser <= x"3C";
         when x"C000" => 
            m_axis_tuser <= x"38";
         when x"E000" => 
            m_axis_tuser <= x"34";
         when x"F000" => 
            m_axis_tuser <= x"30";
         when x"F800" => 
            m_axis_tuser <= x"2C";
         when x"FC00" => 
            m_axis_tuser <= x"28";
         when x"FE00" => 
            m_axis_tuser <= x"24";
         when x"FF00" => 
            m_axis_tuser <= x"20";
         when x"FF80" => 
            m_axis_tuser <= x"1C";
         when x"FFC0" => 
            m_axis_tuser <= x"18";
         when x"FFE0" => 
            m_axis_tuser <= x"14";
         when x"FFF0" => 
            m_axis_tuser <= x"10";
         when x"FFF8" => 
            m_axis_tuser <= x"0C";
         when x"FFFC" => 
            m_axis_tuser <= x"08";
         when x"FFFE" => 
            m_axis_tuser <= x"04";
         when x"FFFF" => 
            m_axis_tuser <= x"00";
         when others =>
            m_axis_tuser <= x"00";       
      end case;                                                        
      m_axis_tlast   <= t1_s_axis_rsp_tuser(103);
      if (t1_s_axis_rsp_tid = conv_std_logic_vector(ddr4_requestor_id,8)) then
         m_axis_tvalid  <= t1_s_axis_rsp_tvalid; 
      else
         m_axis_tvalid  <= '0';
      end if;
      m_axis_tdata   <= t1_s_axis_rsp_tdata;
   end if;
end process;   

tk <= t1_s_axis_rsp_tuser(103) & t1_s_axis_rsp_tuser(99) & t1_s_axis_rsp_tuser(95) & t1_s_axis_rsp_tuser(91) & 
      t1_s_axis_rsp_tuser(87)  & t1_s_axis_rsp_tuser(83) & t1_s_axis_rsp_tuser(79) & t1_s_axis_rsp_tuser(75) & 
      t1_s_axis_rsp_tuser(71)  & t1_s_axis_rsp_tuser(67) & t1_s_axis_rsp_tuser(63) & t1_s_axis_rsp_tuser(59) & 
      t1_s_axis_rsp_tuser(55)  & t1_s_axis_rsp_tuser(51) & t1_s_axis_rsp_tuser(47) & t1_s_axis_rsp_tuser(43);    
      

rst_cdc_inst: xpm_cdc_sync_rst
  generic map (

     -- Common module parameters
     DEST_SYNC_FF    => 3, -- integer; range: 2-10
     INIT            => 1, -- integer; 0=initialize synchronization registers to 0,
                           --          1=initialize synchronization registers to 1
     SIM_ASSERT_CHK  => 0  -- integer; 0=disable simulation messages, 1=enable simulation messages
  )
  port map (
     src_rst  => s_axis_ddr_cmd_aresetn,
     dest_clk => axis_ddr_aclk,
     dest_rst => axis_ddr_aresetn
  );      
  

end Behavioral;
