----------------------------------------------------------------------------------
-- Company: Pentek, Inc.
-- Engineer: 
-- 
-- Create Date: 03/22/2016 12:14:59 PM
-- Design Name: 
-- Module Name: px_axisrq2ddrctlr - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: Interface between axis requests and responses and a native 80-bit DDR4 Controller 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

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

--------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
Library xpm;
use xpm.vcomponents.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity px_axisrq2ddrctlr is
generic (
   mem_size : integer := 1 -- 0 = 2GB 1 = 4 GB 2 = 8GB 3 = 16GB
   );
port (
 --------------------------------------------------------------------------------
 -- AXI LITE Slave Interface  
 --------------------------------------------------------------------------------
 s_axi_csr_aclk        : in  std_logic;
 s_axi_csr_aresetn     : in  std_logic;
 s_axi_csr_awaddr      : in  std_logic_vector(6 downto 0);
 s_axi_csr_awprot      : in  std_logic_vector(2 downto 0); -- not used
 s_axi_csr_awvalid     : in  std_logic;
 s_axi_csr_awready     : out std_logic;
 s_axi_csr_wdata       : in  std_logic_vector(31 downto 0);
 s_axi_csr_wstrb       : in  std_logic_vector(3 downto 0); -- not used
 s_axi_csr_wvalid      : in  std_logic;
 s_axi_csr_wready      : out std_logic;
 s_axi_csr_bresp       : out std_logic_vector(1 downto 0);
 s_axi_csr_bvalid      : out std_logic;
 s_axi_csr_bready      : in  std_logic;
 s_axi_csr_araddr      : in  std_logic_vector(6 downto 0);
 s_axi_csr_arprot      : in  std_logic_vector(2 downto 0); -- not used
 s_axi_csr_arvalid     : in  std_logic;
 s_axi_csr_arready     : out std_logic;
 s_axi_csr_rdata       : out std_logic_vector(31 downto 0);
 s_axi_csr_rresp       : out std_logic_vector(1 downto 0);
 s_axi_csr_rvalid      : out std_logic;
 s_axi_csr_rready      : in  std_logic;
 ----------------------------------------------------------------------------
 -- DDR4 Request Interface (AXI Stream)
 ----------------------------------------------------------------------------
 ddr4_app_axis_aclk    : in  std_logic;  
 -- tuser[127:0] = Request Header
 -- tuser[31:0]  = Address 
 -- tuser[34:32] = Future Address Expansion
 -- tuser[35]    = Read = 1, Write = 0
 -- tuser[39:36] = Reserved
 -- tuser[119:40]= Byte Masks
 -- tuser[255:128] = Upper 128-bits of RAM Data  
 s_axis_rqst_tvalid    : in  std_logic;
 s_axis_rqst_tready    : out std_logic;   
 s_axis_rqst_tlast     : in  std_logic;
 s_axis_rqst_tid       : in  std_logic_vector(7 downto 0);
 s_axis_rqst_tdata     : in  std_logic_vector(511 downto 0); 
 s_axis_rqst_tuser     : in  std_logic_vector(255 downto 0);
 ----------------------------------------------------------------------------
 -- DDR4 Response Interface (AXI Stream)
 ----------------------------------------------------------------------------
 -- tuser[127:0] = Response Header
 -- tuser[31:0]  = Address 
 -- tuser[34:32] = Future Address Expansion
 -- tuser[39:36] = Reserved
 -- tuser[119:40]= Byte Masks 
-- tuser[255:128] = Upper 128-bits of RAM Data 
 m_axis_rsp_tvalid     : out std_logic;
 m_axis_rsp_tlast      : out std_logic;
 m_axis_rsp_tid        : out std_logic_vector(7 downto 0);
 m_axis_rsp_tdata      : out std_logic_vector(511 downto 0); 
 m_axis_rsp_tuser      : out std_logic_vector(255 downto 0);
 -------------------------------------------------------------------------------
 -- 80-bit DDR4 Controller Interface (Native)
 -------------------------------------------------------------------------------
 ddr4_app_en           : out std_logic;      
 ddr4_app_hi_pri       : out std_logic;      
 ddr4_app_wdf_end      : out std_logic;      
 ddr4_app_wdf_wren     : out std_logic;      
 ddr4_app_rd_data_end  : in  std_logic;      
 ddr4_app_rd_data_valid: in  std_logic;      
 ddr4_app_rdy          : in  std_logic;      
 ddr4_app_wdf_rdy      : in  std_logic;      
 ddr4_app_addr         : out std_logic_vector(27+mem_size DOWNTO 0);
 ddr4_app_cmd          : out std_logic_vector(2 DOWNTO 0);
 ddr4_app_wdf_data     : out std_logic_vector(639 DOWNTO 0);
 ddr4_app_wdf_mask     : out std_logic_vector(79 DOWNTO 0);
 ddr4_app_rd_data      : in  std_logic_vector(639 DOWNTO 0);
 init_calib_complete   : in  std_logic;
 ddr4_sys_rst          : out std_logic
 );
end px_axisrq2ddrctlr;

architecture Behavioral of px_axisrq2ddrctlr is

--------------------------------------------------------------------------------
-- Attributes
--------------------------------------------------------------------------------

ATTRIBUTE X_INTERFACE_INFO : STRING;
ATTRIBUTE X_INTERFACE_PARAMETER : STRING;

ATTRIBUTE X_INTERFACE_INFO of s_axi_csr_aclk: SIGNAL is "xilinx.com:signal:clock:1.0 s_axi_csr_aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of s_axi_csr_aclk: SIGNAL is "ASSOCIATED_BUSIF s_axi_csr, ASSOCIATED_RESET s_axi_csr_aresetn";

ATTRIBUTE X_INTERFACE_INFO of ddr4_app_axis_aclk: SIGNAL is "xilinx.com:signal:clock:1.0 ddr4_app_axis_aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of ddr4_app_axis_aclk: SIGNAL is "ASSOCIATED_BUSIF s_axis_rqst:m_axis_rsp:ddr4";

--------------------------------------------------------------------------------
-- Components
--------------------------------------------------------------------------------

-- 64 deep
COMPONENT px_axisrq2ddr_fifo
  PORT (
    s_aclk : IN STD_LOGIC;
    s_aresetn : IN STD_LOGIC;
    s_axis_tvalid : IN STD_LOGIC;
    s_axis_tready : OUT STD_LOGIC;
    s_axis_tdata : IN STD_LOGIC_VECTOR(511 DOWNTO 0);
    s_axis_tid : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    s_axis_tuser : IN STD_LOGIC_VECTOR(255 DOWNTO 0);
    m_axis_tvalid : OUT STD_LOGIC;
    m_axis_tready : IN STD_LOGIC;
    m_axis_tdata : OUT STD_LOGIC_VECTOR(511 DOWNTO 0);
    m_axis_tid : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    m_axis_tuser : OUT STD_LOGIC_VECTOR(255 DOWNTO 0)
  );
END COMPONENT;

-- Common Clock
-- 512 Deep
COMPONENT px_axisrq2ddr_rrqfifo
  PORT (
    s_aclk : IN STD_LOGIC;
    s_aresetn : IN STD_LOGIC;
    s_axis_tvalid : IN STD_LOGIC;
    s_axis_tready : OUT STD_LOGIC;
    s_axis_tdata : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    s_axis_tuser : IN STD_LOGIC_VECTOR(119 DOWNTO 0);
    m_axis_tvalid : OUT STD_LOGIC;
    m_axis_tready : IN STD_LOGIC;
    m_axis_tdata : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    m_axis_tuser : OUT STD_LOGIC_VECTOR(119 DOWNTO 0)
  );
END COMPONENT;

COMPONENT px_axisrq2ddr_csr
  PORT (
    s_axi_csr_aclk : IN STD_LOGIC;
    s_axi_csr_aresetn : IN STD_LOGIC;
    s_axi_csr_awaddr : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
    s_axi_csr_awprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    s_axi_csr_awvalid : IN STD_LOGIC;
    s_axi_csr_awready : OUT STD_LOGIC;
    s_axi_csr_wdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axi_csr_wstrb : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    s_axi_csr_wvalid : IN STD_LOGIC;
    s_axi_csr_wready : OUT STD_LOGIC;
    s_axi_csr_bresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    s_axi_csr_bvalid : OUT STD_LOGIC;
    s_axi_csr_bready : IN STD_LOGIC;
    s_axi_csr_araddr : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
    s_axi_csr_arprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    s_axi_csr_arvalid : IN STD_LOGIC;
    s_axi_csr_arready : OUT STD_LOGIC;
    s_axi_csr_rdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axi_csr_rresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    s_axi_csr_rvalid : OUT STD_LOGIC;
    s_axi_csr_rready : IN STD_LOGIC;
    reg0_init_val : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    ctl0_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    stat0_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0)
  );
END COMPONENT;

--------------------------------------------------------------------------------
-- Signals
--------------------------------------------------------------------------------

signal fifo_rstnx         : std_logic := '0';
signal in_fifo_tvalid     : std_logic := '0'; 
signal in_fifo_tready     : std_logic := '0'; 
signal in_fifo_tdata      : std_logic_vector(511 downto 0) := (others => '0');  
signal in_fifo_tid        : std_logic_vector(7 downto 0) := (others => '0');  
signal in_fifo_tuser      : std_logic_vector(255 downto 0) := (others => '0');  
signal rrqst_fifo_tvalid  : std_logic := '0';
signal rrqst_fifo_tready  : std_logic := '0';
signal rrqst_fifo_tdata   : std_logic_vector(7 downto 0) := (others => '0');  
signal rrqst_fifo_tuser   : std_logic_vector(119 downto 0) := (others => '0');  
signal rrq_fifo_tvalid    : std_logic := '0';
signal rrq_fifo_tready    : std_logic := '0';
signal rsp_tvalid         : std_logic := '0';
signal rsp_tdata          : std_logic_vector(511 downto 0) := (others => '0');  
signal rsp_tuser          : std_logic_vector(255 downto 0) := (others => '0');  
signal rsp_tid            : std_logic_vector(7 downto 0) := (others => '0');  
signal ctl0_out           : std_logic_vector(31 downto 0) := (others => '0');  
signal ctl0_outx          : std_logic_vector(1 downto 0) := (others => '0'); 
signal stat0_in           : std_logic_vector(31 downto 0) := (others => '0');  
signal src_sends          : std_logic := '0';
signal src_rcvs           : std_logic := '0';
signal dest_reqs          : std_logic := '0';
signal src_senda          : std_logic := '0';
signal src_rcva           : std_logic := '0';
signal dest_reqa          : std_logic := '0';
signal s_axi_csr_aresetnx : std_logic := '0'; 
signal t1_s_axi_csr_aresetn: std_logic := '0'; 
--------------------------------------------------------------------------------

begin

--------------------------------------------------------------------------------
-- AXI-S Input FIFO
--------------------------------------------------------------------------------
-- 64 deep
in_fifo_inst : px_axisrq2ddr_fifo
port map (
    s_aclk         => ddr4_app_axis_aclk,
    s_aresetn      => fifo_rstnx,
    s_axis_tvalid  => s_axis_rqst_tvalid,
    s_axis_tready  => s_axis_rqst_tready,
    s_axis_tdata   => s_axis_rqst_tdata,
    s_axis_tid     => s_axis_rqst_tid,
    s_axis_tuser   => s_axis_rqst_tuser,
    m_axis_tvalid  => in_fifo_tvalid,
    m_axis_tready  => in_fifo_tready,
    m_axis_tdata   => in_fifo_tdata,
    m_axis_tid     => in_fifo_tid,
    m_axis_tuser   => in_fifo_tuser
  );

--------------------------------------------------------------------------------
-- Store Read Access Request tuser info to use to form tuser of Response
--------------------------------------------------------------------------------

rrq_fifo_tvalid <= in_fifo_tvalid and in_fifo_tready and in_fifo_tuser(35);

rrq_fifo : px_axisrq2ddr_rrqfifo
  PORT MAP (
    s_aclk        => ddr4_app_axis_aclk,
    s_aresetn     => fifo_rstnx,
    s_axis_tvalid => rrq_fifo_tvalid,
    s_axis_tready => rrq_fifo_tready,
    s_axis_tdata  => in_fifo_tid,
    s_axis_tuser  => in_fifo_tuser(119 downto 0),
    m_axis_tvalid => rrqst_fifo_tvalid,
    m_axis_tready => rrqst_fifo_tready,
    m_axis_tdata  => rrqst_fifo_tdata,
    m_axis_tuser  => rrqst_fifo_tuser
  );

--------------------------------------------------------------------------------
-- For DDR4 Controller APP Commands
--------------------------------------------------------------------------------

ddr4_app_cmd      <= "00" & in_fifo_tuser(35); -- Read/Write Command
ddr4_app_en       <= (ddr4_app_rdy and rrq_fifo_tready and in_fifo_tvalid) when (in_fifo_tuser(35) = '1') else (ddr4_app_rdy and ddr4_app_wdf_rdy and rrq_fifo_tready and in_fifo_tvalid);
ddr4_app_wdf_wren <= (ddr4_app_rdy and ddr4_app_wdf_rdy and rrq_fifo_tready and in_fifo_tvalid and (not in_fifo_tuser(35)));
in_fifo_tready    <= (ddr4_app_rdy and rrq_fifo_tready) when (in_fifo_tuser(35) = '1') else (ddr4_app_rdy and rrq_fifo_tready and ddr4_app_wdf_rdy);
ddr4_app_wdf_end  <= '1';
ddr4_app_hi_pri   <= '0';
ddr4_app_wdf_data <= in_fifo_tuser(255 downto 128) & in_fifo_tdata;
ddr4_app_wdf_mask <= in_fifo_tuser(119 downto 40);
ddr4_app_addr     <= in_fifo_tuser(30+mem_size downto 6) & "000";

rrqst_fifo_tready <= ddr4_app_rd_data_valid;

--------------------------------------------------------------------------------
-- Form Response
--------------------------------------------------------------------------------
-- Response has no Back-pressure. It is assumed that if data was requested then 
-- the requester has the ability to receive it.

process(ddr4_app_axis_aclk)
begin
   if rising_edge(ddr4_app_axis_aclk) then
     rsp_tvalid         <= ddr4_app_rd_data_valid;
     rsp_tdata          <= ddr4_app_rd_data(511 downto 0); 
     rsp_tuser          <= ddr4_app_rd_data(639 downto 512) & x"00" & rrqst_fifo_tuser;
     rsp_tid            <= rrqst_fifo_tdata;
     m_axis_rsp_tvalid  <= rsp_tvalid;
     m_axis_rsp_tdata   <= rsp_tdata; 
     m_axis_rsp_tid     <= rsp_tid;  
     m_axis_rsp_tuser   <= rsp_tuser;   
   end if;
end process;  

m_axis_rsp_tlast <= '1';  

--------------------------------------------------------------------------------
-- Control/Stsus Registers
--------------------------------------------------------------------------------

csr_inst : px_axisrq2ddr_csr
  PORT MAP (
    s_axi_csr_aclk     => s_axi_csr_aclk,
    s_axi_csr_aresetn  => t1_s_axi_csr_aresetn,
    s_axi_csr_awaddr   => s_axi_csr_awaddr,
    s_axi_csr_awprot   => s_axi_csr_awprot,
    s_axi_csr_awvalid  => s_axi_csr_awvalid,
    s_axi_csr_awready  => s_axi_csr_awready,
    s_axi_csr_wdata    => s_axi_csr_wdata,
    s_axi_csr_wstrb    => s_axi_csr_wstrb,
    s_axi_csr_wvalid   => s_axi_csr_wvalid,
    s_axi_csr_wready   => s_axi_csr_wready,
    s_axi_csr_bresp    => s_axi_csr_bresp,
    s_axi_csr_bvalid   => s_axi_csr_bvalid,
    s_axi_csr_bready   => s_axi_csr_bready,
    s_axi_csr_araddr   => s_axi_csr_araddr,
    s_axi_csr_arprot   => s_axi_csr_arprot,
    s_axi_csr_arvalid  => s_axi_csr_arvalid,
    s_axi_csr_arready  => s_axi_csr_arready,
    s_axi_csr_rdata    => s_axi_csr_rdata,
    s_axi_csr_rresp    => s_axi_csr_rresp,
    s_axi_csr_rvalid   => s_axi_csr_rvalid,
    s_axi_csr_rready   => s_axi_csr_rready,
    reg0_init_val      => x"00000000",
    ctl0_out           => ctl0_out,
    stat0_in           => stat0_in
  );

-- Cross Clock Boundaries
cntl02_xclk:  xpm_cdc_handshake
generic map (

  -- Common module generics
  DEST_EXT_HSK   => 1, -- integer; 0=user handshake, 1=internal handshake
  DEST_SYNC_FF   => 4, -- integer; range: 2-10
  SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
  SRC_SYNC_FF    => 4, -- integer; range: 2-10
  WIDTH          => 2  -- integer; range: 1-1024
)
port map (

  src_clk  => s_axi_csr_aclk,
  src_in   => ctl0_out(1 downto 0),
  src_send => src_senda,
  src_rcv  => src_rcva,
  dest_clk => ddr4_app_axis_aclk,
  dest_req => dest_reqa,
  dest_ack => dest_reqa, 
  dest_out => ctl0_outx
);
   
process(s_axi_csr_aclk)
begin
   if rising_edge(s_axi_csr_aclk) then
     t1_s_axi_csr_aresetn <= s_axi_csr_aresetn;
     if (src_rcva = '1') then
       src_senda <= '0';
     elsif (src_rcva = '0') and (src_senda = '0') then
       src_senda <= '1';
     end if;  
     ddr4_sys_rst <= ctl0_out(0); -- dont sync to DDR clock because it resets the DDR controller and output clock
   end if;
end process;   

process(ddr4_app_axis_aclk)
begin
   if rising_edge(ddr4_app_axis_aclk) then
     --ddr4_sys_rst <= ctl0_outx(0); 
     fifo_rstnx   <=  not(ctl0_outx(1) or not s_axi_csr_aresetnx);
   end if;
end process;  

statl02_xclk:  xpm_cdc_handshake
generic map (

  -- Common module generics
  DEST_EXT_HSK   => 1, -- integer; 0=user handshake, 1=internal handshake
  DEST_SYNC_FF   => 4, -- integer; range: 2-10
  SIM_ASSERT_CHK => 0, -- integer; 0=disable simulation messages, 1=enable simulation messages
  SRC_SYNC_FF    => 4, -- integer; range: 2-10
  WIDTH          => 1  -- integer; range: 1-1024
)
port map (

  src_clk  => ddr4_app_axis_aclk, 
  src_in(0)=> init_calib_complete,
  src_send => src_sends,
  src_rcv  => src_rcvs,
  dest_clk => s_axi_csr_aclk,
  dest_req => dest_reqs,
  dest_ack => dest_reqs, 
  dest_out(0) => stat0_in(0)
);
   
process(ddr4_app_axis_aclk)
begin
   if rising_edge(ddr4_app_axis_aclk) then
     if (src_rcvs = '1') then
       src_sends <= '0';
     elsif (src_rcvs = '0') and (src_sends = '0') then
       src_sends <= '1';
     end if;  
   end if;
end process;   

stat0_in(31 downto 1) <= x"0000000" & "000"; 

xpm_cdc_rst_inst: xpm_cdc_async_rst
  generic map (

    -- Common module parameters
     DEST_SYNC_FF    => 4, -- integer; range: 2-10
     RST_ACTIVE_HIGH => 0  -- integer; 0=active low reset, 1=active high reset
  )
  port map (

     src_arst  => t1_s_axi_csr_aresetn,
     dest_clk  => ddr4_app_axis_aclk,
     dest_arst => s_axi_csr_aresetnx
  );


end Behavioral;
