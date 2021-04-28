----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/17/2015 07:00:43 PM
-- Design Name: 
-- Module Name: px_axil_i2c - Behavioral
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
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity px_axil_i2c_mstr is
generic (
   port_has_mga        : boolean := true; -- Has Geographical Address Input (IP Packager uses this generic)
   in_clk_rate_mhz     : integer := 250; -- Input Clock Rate in Megahertz
   port_init_rate_khz  : integer := 100  -- Initial output I2C clock rate setting at reset
   );
port (
--------------------------------------------------------------------------------
-- AXI LITE Slave Interface  
-- DWORD Addressing
--------------------------------------------------------------------------------
   s_axi_csr_aclk      : in  std_logic;
   s_axi_csr_aresetn   : in  std_logic;
   s_axi_csr_awaddr    : in  std_logic_vector(5 downto 0);
   s_axi_csr_awprot    : in  std_logic_vector(2 downto 0); -- not used
   s_axi_csr_awvalid   : in  std_logic;
   s_axi_csr_awready   : out std_logic;
   s_axi_csr_wdata     : in  std_logic_vector(31 downto 0);
   s_axi_csr_wstrb     : in  std_logic_vector(3 downto 0); 
   s_axi_csr_wvalid    : in  std_logic;
   s_axi_csr_wready    : out std_logic;
   s_axi_csr_bresp     : out std_logic_vector(1 downto 0);
   s_axi_csr_bvalid    : out std_logic;
   s_axi_csr_bready    : in  std_logic;
   s_axi_csr_araddr    : in  std_logic_vector(5 downto 0);
   s_axi_csr_arprot    : in  std_logic_vector(2 downto 0); -- not used
   s_axi_csr_arvalid   : in  std_logic;
   s_axi_csr_arready   : out std_logic;
   s_axi_csr_rdata     : out std_logic_vector(31 downto 0);
   s_axi_csr_rresp     : out std_logic_vector(1 downto 0);
   s_axi_csr_rvalid    : out std_logic;
   s_axi_csr_rready    : in  std_logic;
  
   irq                 : out std_logic;
   ----------------------------------------------------------------------------
   -- I2C Port
   ----------------------------------------------------------------------------
   -- Conforms to Interface frmat of IP Integrator IIC bus interface.
   -- Connect externally to Tri-State Buffers.
   port_scl_i         : in  std_logic;
   port_scl_o         : out std_logic;
   port_scl_t         : out std_logic;
   port_sda_i         : in  std_logic;
   port_sda_o         : out std_logic;
   port_sda_t         : out std_logic;
   port_mga           : in  std_logic_vector(2 downto 0) -- Geographical Address Input
   );
end px_axil_i2c_mstr;

architecture Behavioral of px_axil_i2c_mstr is

--------------------------------------------------------------------------------
-- Attributes
--------------------------------------------------------------------------------

ATTRIBUTE X_INTERFACE_INFO : STRING;
ATTRIBUTE X_INTERFACE_PARAMETER : STRING;

ATTRIBUTE X_INTERFACE_INFO of irq: SIGNAL is "xilinx.com:signal:interrupt:1.0 irq INTR";
ATTRIBUTE X_INTERFACE_PARAMETER of irq: SIGNAL is "SENSITIVITY EDGE_RISING";

ATTRIBUTE X_INTERFACE_INFO of s_axi_csr_aclk: SIGNAL is "xilinx.com:signal:clock:1.0 s_axi_csr_aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of s_axi_csr_aclk: SIGNAL is "ASSOCIATED_BUSIF s_axi_csr, ASSOCIATED_RESET s_axi_csr_aresetn";

--------------------------------------------------------------------------------
-- Component
--------------------------------------------------------------------------------

component px_axil_i2c_mstr_sm
port (
   -----------------------------------------------------------------------------
   -- Control/Status
   -----------------------------------------------------------------------------
   clk_division   : in  std_logic_vector(9 downto 0); -- clk/(output rate*4)
   enable         : in  std_logic;  -- Enable I2C Port  
   strt_pls       : in  std_logic;  -- Start Pulse
   addr           : in  std_logic_vector(6 downto 0); --I2C Address
   restart_mode   : in  std_logic;  -- Restart Mode
   r_w_n          : in  std_logic; -- Data direction (0 = write, 1 = read)
   num_bytes      : in  std_logic_vector(3 downto 0);    -- (# of bytes-1) to transfer
   fifo_flush     : in  std_logic; -- FIFO Flush
   trns_done_int  : out std_logic; -- Transaction Done (One clock Pulse)
   no_ack_int     : out std_logic; -- No Acknoledgement
   busy_out       : out std_logic; -- Transaction in progress
   -- Number of data bytes available to read in the FIFO
   rd_fifo_cnt    : out std_logic_vector(4 downto 0);
   rd_fifo_full   : out std_logic; -- RX Full
   rd_fifo_empty  : out std_logic; -- RX Empty
   -- Number of data bytes ready to be transmitted
   wr_fifo_cnt    : out std_logic_vector(4 downto 0);
   wr_fifo_full   : out std_logic; -- TX Full
   wr_fifo_empty  : out std_logic; -- TX Empty
   --------------------------------------------------------------------------------
   -- AXI LITE Slave Interface  
   -- DWORD Addressing
   -- FIFO Read/Write Interface
   --------------------------------------------------------------------------------
   s_axi_csr_aclk      : in  std_logic;  -- Clock for whole module (250 MHz)
   s_axi_csr_aresetn   : in  std_logic;
   s_axi_csr_awaddr    : in  std_logic_vector(2 downto 0);
   s_axi_csr_awprot    : in  std_logic_vector(2 downto 0); -- not used
   s_axi_csr_awvalid   : in  std_logic;
   s_axi_csr_awready   : out std_logic;
   s_axi_csr_wdata     : in  std_logic_vector(31 downto 0);
   s_axi_csr_wstrb     : in  std_logic_vector(3 downto 0); -- not used
   s_axi_csr_wvalid    : in  std_logic;
   s_axi_csr_wready    : out std_logic;
   s_axi_csr_bresp     : out std_logic_vector(1 downto 0);
   s_axi_csr_bvalid    : out std_logic;
   s_axi_csr_bready    : in  std_logic;
   s_axi_csr_araddr    : in  std_logic_vector(2 downto 0);
   s_axi_csr_arprot    : in  std_logic_vector(2 downto 0); -- not used
   s_axi_csr_arvalid   : in  std_logic;
   s_axi_csr_arready   : out std_logic;
   s_axi_csr_rdata     : out std_logic_vector(31 downto 0);
   s_axi_csr_rresp     : out std_logic_vector(1 downto 0);
   s_axi_csr_rvalid    : out std_logic;
   s_axi_csr_rready    : in  std_logic;
   -----------------------------------------------------------------------------
   -- I2C Signals
   -----------------------------------------------------------------------------
   oe_n           : out std_logic;
   scl_in         : in  std_logic;
   scl_out        : out std_logic;
   sda_in         : in  std_logic;
   sda_out        : out std_logic
   
);
end component;

-- AXI-Lie Crossbar
-- Master 0 offset = 0x00
-- Master 1 offset = 0x20
COMPONENT px_i2c_axi_crossbar
  PORT (
    aclk : IN STD_LOGIC;
    aresetn : IN STD_LOGIC;
    s_axi_awaddr : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
    s_axi_awprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    s_axi_awvalid : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    s_axi_awready : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
    s_axi_wdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axi_wstrb : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    s_axi_wvalid : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    s_axi_wready : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
    s_axi_bresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    s_axi_bvalid : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
    s_axi_bready : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    s_axi_araddr : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
    s_axi_arprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    s_axi_arvalid : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    s_axi_arready : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
    s_axi_rdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axi_rresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    s_axi_rvalid : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
    s_axi_rready : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    m_axi_awaddr : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
    m_axi_awprot : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
    m_axi_awvalid : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    m_axi_awready : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
    m_axi_wdata : OUT STD_LOGIC_VECTOR(63 DOWNTO 0);
    m_axi_wstrb : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    m_axi_wvalid : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    m_axi_wready : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
    m_axi_bresp : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    m_axi_bvalid : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
    m_axi_bready : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    m_axi_araddr : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
    m_axi_arprot : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
    m_axi_arvalid : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    m_axi_arready : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
    m_axi_rdata : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
    m_axi_rresp : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    m_axi_rvalid : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
    m_axi_rready : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
  );
END COMPONENT;

-- AXI-Lite Control/Status Register Set
-- 4 Control Regs
-- 1 Stat Reg
-- Interrupt Regs
-- 7 interrupt sources
COMPONENT px_i2c_axil_csr
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
    reg1_init_val : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    reg2_init_val : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    reg3_init_val : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    ctl0_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    ctl1_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    ctl2_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    ctl3_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    stat0_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    intrpt_src_in : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
    irq : OUT STD_LOGIC
  );
END COMPONENT;

--------------------------------------------------------------------------------
-- Constants
--------------------------------------------------------------------------------

constant init_clk_division : std_logic_vector(31 downto 0) := conv_std_logic_vector(((in_clk_rate_mhz*1000)/(port_init_rate_khz*4)),32);

--------------------------------------------------------------------------------
-- Signals
--------------------------------------------------------------------------------

signal m_axi_awaddr     : std_logic_vector(11 downto 0):= (others => '0');
signal m_axi_awprot     : std_logic_vector(5 downto 0) := (others => '0');
signal m_axi_awvalid    : std_logic_vector(1 downto 0) := (others => '0');
signal m_axi_awready    : std_logic_vector(1 downto 0) := (others => '0');
signal m_axi_wdata      : std_logic_vector(63 downto 0):= (others => '0');
signal m_axi_wstrb      : std_logic_vector(7 downto 0) := (others => '0');
signal m_axi_wvalid     : std_logic_vector(1 downto 0) := (others => '0');
signal m_axi_wready     : std_logic_vector(1 downto 0) := (others => '0');
signal m_axi_bresp      : std_logic_vector(3 downto 0) := (others => '0');
signal m_axi_bvalid     : std_logic_vector(1 downto 0) := (others => '0');
signal m_axi_bready     : std_logic_vector(1 downto 0) := (others => '0');
signal m_axi_araddr     : std_logic_vector(11 downto 0):= (others => '0');
signal m_axi_arprot     : std_logic_vector(5 downto 0) := (others => '0');
signal m_axi_arvalid    : std_logic_vector(1 downto 0) := (others => '0');
signal m_axi_arready    : std_logic_vector(1 downto 0) := (others => '0');
signal m_axi_rdata      : std_logic_vector(63 downto 0):= (others => '0');
signal m_axi_rresp      : std_logic_vector(3 downto 0) := (others => '0');
signal m_axi_rvalid     : std_logic_vector(1 downto 0) := (others => '0');
signal m_axi_rready     : std_logic_vector(1 downto 0) := (others => '0');
signal ctl0_out         : std_logic_vector(31 downto 0):= (others => '0');
signal ctl1_out         : std_logic_vector(31 downto 0):= (others => '0');
signal ctl2_out         : std_logic_vector(31 downto 0):= (others => '0');
signal ctl3_out         : std_logic_vector(31 downto 0):= (others => '0');
signal stat0_in         : std_logic_vector(31 downto 0):= (others => '0');
signal intrpt_src_in    : std_logic_vector(6 downto 0) := (others => '0');
signal clk_division     : std_logic_vector(9 downto 0) := (others => '0'); -- clk/(output rate*4)
signal enable           : std_logic := '0';  -- Enable I2C Port  
signal strt_pls         : std_logic := '0';  -- Start Pulse
signal addr             : std_logic_vector(6 downto 0) := (others => '0'); --I2C Address
signal r_w_n            : std_logic := '0'; -- Data direction (0 = write, 1 = read)
signal num_bytes        : std_logic_vector(3 downto 0) := (others => '0');    -- (# of bytes-1) to transfer
signal trns_done_int    : std_logic := '0'; -- Transaction Dome (One clock Pulse)
signal no_ack_int       : std_logic := '0'; -- No Acknoledgement
signal busy_out         : std_logic := '0'; -- Transaction in progress
signal rd_fifo_cnt      : std_logic_vector(4 downto 0) := (others => '0');
signal rd_fifo_full     : std_logic := '0'; -- RX Full
signal rd_fifo_empty    : std_logic := '0'; -- RX Empty
signal wr_fifo_cnt      : std_logic_vector(4 downto 0) := (others => '0');
signal wr_fifo_full     : std_logic := '0'; -- TX Full
signal wr_fifo_empty    : std_logic := '0'; -- TX Empty
signal oe_n             : std_logic := '0';
signal scl_in           : std_logic := '0';
signal scl_out          : std_logic := '0';
signal sda_in           : std_logic := '0';
signal sda_out          : std_logic := '0';
signal awaddr           : std_logic_vector(6 downto 0) := (others => '0');
signal araddr           : std_logic_vector(6 downto 0) := (others => '0');
signal restart_mode     : std_logic := '0';
signal fifo_flush       : std_logic := '0';
signal t1_s_axi_csr_aresetn: std_logic := '0';
--------------------------------------------------------------------------------   

begin

process(s_axi_csr_aclk)
begin
    if rising_edge(s_axi_csr_aclk) then
        t1_s_axi_csr_aresetn <= s_axi_csr_aresetn;
    end if;
end process;

--------------------------------------------------------------------------------
-- AXI-Lite Crossbar
--------------------------------------------------------------------------------
axi_xbar_inst : px_i2c_axi_crossbar
port map (
    aclk          => s_axi_csr_aclk,
    aresetn       => t1_s_axi_csr_aresetn,
    s_axi_awaddr  => s_axi_csr_awaddr,
    s_axi_awprot  => s_axi_csr_awprot,
    s_axi_awvalid(0) => s_axi_csr_awvalid,
    s_axi_awready(0) => s_axi_csr_awready,
    s_axi_wdata   => s_axi_csr_wdata,
    s_axi_wstrb   => s_axi_csr_wstrb,
    s_axi_wvalid(0)  => s_axi_csr_wvalid,
    s_axi_wready(0)  => s_axi_csr_wready,
    s_axi_bresp   => s_axi_csr_bresp,
    s_axi_bvalid(0)  => s_axi_csr_bvalid,
    s_axi_bready(0)  => s_axi_csr_bready,
    s_axi_araddr  => s_axi_csr_araddr,
    s_axi_arprot  => s_axi_csr_arprot,
    s_axi_arvalid(0) => s_axi_csr_arvalid,
    s_axi_arready(0) => s_axi_csr_arready,
    s_axi_rdata   => s_axi_csr_rdata,
    s_axi_rresp   => s_axi_csr_rresp,
    s_axi_rvalid(0)  => s_axi_csr_rvalid,
    s_axi_rready(0)  => s_axi_csr_rready,
    m_axi_awaddr  => m_axi_awaddr,
    m_axi_awprot  => m_axi_awprot,
    m_axi_awvalid => m_axi_awvalid,
    m_axi_awready => m_axi_awready,
    m_axi_wdata   => m_axi_wdata,
    m_axi_wstrb   => m_axi_wstrb,
    m_axi_wvalid  => m_axi_wvalid,
    m_axi_wready  => m_axi_wready,
    m_axi_bresp   => m_axi_bresp,
    m_axi_bvalid  => m_axi_bvalid,
    m_axi_bready  => m_axi_bready,
    m_axi_araddr  => m_axi_araddr,
    m_axi_arprot  => m_axi_arprot,
    m_axi_arvalid => m_axi_arvalid,
    m_axi_arready => m_axi_arready,
    m_axi_rdata   => m_axi_rdata,
    m_axi_rresp   => m_axi_rresp,
    m_axi_rvalid  => m_axi_rvalid,
    m_axi_rready  => m_axi_rready
  );

awaddr <= "00" & m_axi_awaddr(4 downto 0);
araddr <= "00" & m_axi_araddr(4 downto 0);
--------------------------------------------------------------------------------
-- Control Status Registers
--------------------------------------------------------------------------------
csr_inst: px_i2c_axil_csr
port map (
    s_axi_csr_aclk      => s_axi_csr_aclk,                  
    s_axi_csr_aresetn   => t1_s_axi_csr_aresetn,               
    s_axi_csr_awaddr    => awaddr,       
    s_axi_csr_awprot    => m_axi_awprot(2 downto 0),   
    s_axi_csr_awvalid   => m_axi_awvalid(0),           
    s_axi_csr_awready   => m_axi_awready(0),           
    s_axi_csr_wdata     => m_axi_wdata(31 downto 0),  
    s_axi_csr_wstrb     => m_axi_wstrb(3 downto 0),    
    s_axi_csr_wvalid    => m_axi_wvalid(0),            
    s_axi_csr_wready    => m_axi_wready(0),            
    s_axi_csr_bresp     => m_axi_bresp(1 downto 0),    
    s_axi_csr_bvalid    => m_axi_bvalid(0),            
    s_axi_csr_bready    => m_axi_bready(0),            
    s_axi_csr_araddr    => araddr,  
    s_axi_csr_arprot    => m_axi_arprot(2 downto 0),   
    s_axi_csr_arvalid   => m_axi_arvalid(0),           
    s_axi_csr_arready   => m_axi_arready(0),           
    s_axi_csr_rdata     => m_axi_rdata(31 downto 0),   
    s_axi_csr_rresp     => m_axi_rresp(1 downto 0),    
    s_axi_csr_rvalid    => m_axi_rvalid(0),            
    s_axi_csr_rready    => m_axi_rready(0), 
               
    reg0_init_val       => x"00000000",
    reg1_init_val       => init_clk_division, -- Output Rate Initialization value
    reg2_init_val       => x"00000000",
    reg3_init_val       => x"00000000",
    
    ctl0_out            => ctl0_out,
    ctl1_out            => ctl1_out,
    ctl2_out            => ctl2_out,
    ctl3_out            => ctl3_out,
    stat0_in            => stat0_in,
    
    intrpt_src_in       => intrpt_src_in,
    irq                 => irq
  );
  
strt_pls     <= ctl0_out(0); -- Start Transfer Pulse (Toggled in software)  
clk_division <= ctl1_out(9 downto 0);
addr         <= ctl2_out(6 downto 0);
enable       <= ctl3_out(0); 
r_w_n        <= ctl3_out(1);
restart_mode <= ctl3_out(2);
fifo_flush   <= ctl3_out(3);
num_bytes    <= ctl3_out(7 downto 4);

stat0_in(0)            <= busy_out;
stat0_in(2 downto 1)   <= "00";
stat0_in(7 downto 3)   <= rd_fifo_cnt;
stat0_in(8)            <= '0';
stat0_in(10)           <= rd_fifo_full;
stat0_in(9)            <= rd_fifo_empty;
stat0_in(11)           <= '0';  
stat0_in(16 downto 12) <= wr_fifo_cnt;
stat0_in(18)           <= wr_fifo_full; 
stat0_in(17)           <= wr_fifo_empty; 
stat0_in(19)           <= '0';
stat0_in(22 downto 20) <= port_mga;
stat0_in(23)           <= '0';
stat0_in(31 downto 24) <= x"00";

intrpt_src_in <= wr_fifo_full & wr_fifo_empty & rd_fifo_full & rd_fifo_empty & no_ack_int & (not busy_out) & trns_done_int;

--------------------------------------------------------------------------------
-- I2C State Machine
--------------------------------------------------------------------------------

port_inst: px_axil_i2c_mstr_sm
port map (
   -----------------------------------------------------------------------------
   -- Control/Status
   -----------------------------------------------------------------------------
   clk_division   => clk_division,  
   enable         => enable,        
   strt_pls       => strt_pls,
   restart_mode   => restart_mode,      
   addr           => addr,          
   r_w_n          => r_w_n,         
   num_bytes      => num_bytes,  
   fifo_flush     => fifo_flush,    
   trns_done_int  => trns_done_int, 
   no_ack_int     => no_ack_int,    
   busy_out       => busy_out,      
   rd_fifo_cnt    => rd_fifo_cnt,   
   rd_fifo_full   => rd_fifo_full,  
   rd_fifo_empty  => rd_fifo_empty, 
   wr_fifo_cnt    => wr_fifo_cnt,   
   wr_fifo_full   => wr_fifo_full,  
   wr_fifo_empty  => wr_fifo_empty, 
   ----------------------------------------------------------------------------
   -- Data Read/Write Bus
   ----------------------------------------------------------------------------
   --------------------------------------------------------------------------------
   -- AXI LITE Slave Interface  
   -- DWORD Addressing
   -- FIFO Read/Write Interface
   --------------------------------------------------------------------------------
   s_axi_csr_aclk      => s_axi_csr_aclk,   
   s_axi_csr_aresetn   => t1_s_axi_csr_aresetn,
   s_axi_csr_awaddr    => m_axi_awaddr(8 downto 6), 
   s_axi_csr_awprot    => m_axi_awprot(5 downto 3), 
   s_axi_csr_awvalid   => m_axi_awvalid(1),
   s_axi_csr_awready   => m_axi_awready(1),
   s_axi_csr_wdata     => m_axi_wdata(63 downto 32),  
   s_axi_csr_wstrb     => m_axi_wstrb(7 downto 4),  
   s_axi_csr_wvalid    => m_axi_wvalid(1), 
   s_axi_csr_wready    => m_axi_wready(1), 
   s_axi_csr_bresp     => m_axi_bresp(3 downto 2),  
   s_axi_csr_bvalid    => m_axi_bvalid(1), 
   s_axi_csr_bready    => m_axi_bready(1), 
   s_axi_csr_araddr    => m_axi_araddr(8 downto 6), 
   s_axi_csr_arprot    => m_axi_arprot(5 downto 3), 
   s_axi_csr_arvalid   => m_axi_arvalid(1),
   s_axi_csr_arready   => m_axi_arready(1),
   s_axi_csr_rdata     => m_axi_rdata(63 downto 32),  
   s_axi_csr_rresp     => m_axi_rresp(3 downto 2),  
   s_axi_csr_rvalid    => m_axi_rvalid(1), 
   s_axi_csr_rready    => m_axi_rready(1), 
   -----------------------------------------------------------------------------
   -- I2C Signals
   -----------------------------------------------------------------------------
   oe_n                => oe_n,
   scl_in              => scl_in,
   scl_out             => scl_out,
   sda_in              => sda_in,
   sda_out             => sda_out
);

--------------------------------------------------------------------------------
-- Port Outputs
-------------------------------------------------------------------------------- 
-- Uses IIC Bus Interface Format for core
   scl_in             <= port_scl_i;
   port_scl_o         <= '0';
   port_scl_t         <= scl_out or oe_n;
   sda_in             <= port_sda_i;
   port_sda_o         <= '0';
   port_sda_t         <= sda_out or oe_n;


end Behavioral;
