----------------------------------------------------------------------------------
-- Control/Status Registers for Pentek PCIe to AXI-S DMA
----------------------------------------------------------------------------------
-- px_dma_pcie2pd_csr.vhd
--
-- Target Device: Kintex UltraScale
--
-- Pentek Inc.
-- One Park Way, Upper Saddle River, NJ 07458
-- (201)818-5900
-- www.pentek.com
--
-- Copyright Pentek, Inc. 2016
--
-- Revision:
-- Revision 0.01 - File Created


-- Additional Comments: 

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

-- Register Map
-- 0x00 DMA RESTART		           R/W
-- 0x04 DMA ADVANCE 	           R/W
-- 0x08 DMA ABORT                  R/W
-- 0x0C DMA START LINK ADDRESS     R/W
-- 0x10 FIFO FLUSH                 R/W
-- 0x14 Reserved                   R/W
-- 0x18 Reserved                   R/W
-- 0x1C Reserved                   R/W
-- 0x20 DMA STATUS	               RO
-- 0x24 CURRENT LINK ADDRESS       RO
-- 0x28 LAST LINK ADDRESS          RO
-- 0x2C BYTES LAST TRANSFERRED     RO
-- 0x30 FIFO COUNT                 RO
-- 0x34 INTERRUPT ENABLE           R/W	
-- 0x38 INTERRUPT STATUS           RO
-- 0x3C INTERRUPT FLAG	           R/Clr

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

entity px_dma_pcie2pd_csr is
port (
--------------------------------------------------------------------------------
-- AXI LITE Slave Interface  
-- DWORD Addressing
--------------------------------------------------------------------------------
    s_axi_csr_aclk        : in  std_logic;
    s_axi_csr_aresetn     : in  std_logic;
    s_axi_csr_awaddr      : in  std_logic_vector(5 downto 0); -- only [5:0] used
    s_axi_csr_awprot      : in  std_logic_vector(2 downto 0);
    s_axi_csr_awvalid     : in  std_logic;
    s_axi_csr_awready     : out std_logic;
    s_axi_csr_wdata       : in  std_logic_vector(31 downto 0);
    s_axi_csr_wstrb       : in  std_logic_vector(3 downto 0);
    s_axi_csr_wvalid      : in  std_logic;
    s_axi_csr_wready      : out std_logic;
    s_axi_csr_bresp       : out std_logic_vector(1 downto 0);
    s_axi_csr_bvalid      : out std_logic;
    s_axi_csr_bready      : in  std_logic;
    s_axi_csr_araddr      : in  std_logic_vector(5 downto 0);  -- only [5:0] used
    s_axi_csr_arprot      : in  std_logic_vector(2 downto 0);
    s_axi_csr_arvalid     : in  std_logic;
    s_axi_csr_arready     : out std_logic;
    s_axi_csr_rdata       : out std_logic_vector(31 downto 0);
    s_axi_csr_rresp       : out std_logic_vector(1 downto 0);
    s_axi_csr_rvalid      : out std_logic;
    s_axi_csr_rready      : in  std_logic;
    
    irq                   : out std_logic; -- interrupt

--------------------------------------------------------------------------------
-- Control Outputs
--------------------------------------------------------------------------------    
    start_link_descr_addr : out std_logic_vector(15 downto 0);
    dma_restart           : out std_logic;
    dma_advance           : out std_logic;
    dma_abort             : out std_logic;
    fifo_flush            : out std_logic;
--------------------------------------------------------------------------------
-- Status Inputs
--------------------------------------------------------------------------------       	           
    current_link_address  : in  std_logic_vector(15 downto 0);
    last_link_address     : in  std_logic_vector(15 downto 0);
    bytes_last_transferred: in  std_logic_vector(31 downto 0); 
    dma_aborting          : in  std_logic;
    dma_waiting_for_adv   : in  std_logic;
    dma_paused            : in  std_logic;
    dma_active            : in  std_logic;
    data_buf_fifo_full    : in  std_logic;
    data_buf_fifo_empty   : in  std_logic;
    data_buf_fifo_count   : in  std_logic_vector(11 downto 0); 
    pcie_rqst_fifo_afl    : in  std_logic;
    pcie_rqst_fifo_empty  : in  std_logic;
 --------------------------------------------------------------------------------
-- Interrupt Sources
--------------------------------------------------------------------------------    
    all_rd_cmplt          : in  std_logic;
    all_rqsts_cmplt       : in  std_logic;
    pcie_data_error       : in  std_logic;
    pcie_error_code       : in  std_logic_vector(3 downto 0);
    abort_cmplt           : in  std_logic;
    waiting_adv           : in  std_logic;
    chain_end_int         : in  std_logic;
    link_end_int          : in  std_logic;
    chain_end             : in  std_logic;
    link_end              : in  std_logic;
    link_start            : in  std_logic
);
end px_dma_pcie2pd_csr;

architecture Behavioral of px_dma_pcie2pd_csr is

--------------------------------------------------------------------------------
-- Components
--------------------------------------------------------------------------------

-- Generic Control/Status Register Set
component px_axil_dma_csr 
generic (
   num_addr_bits        : integer := 7; -- Number of address bits 3-7 (Must agree with number of registers
   num_ctl_regs         : integer := 8; -- Number of Control Registers - 0 through 8
   num_stat_regs        : integer := 8; -- Number of Status Registers - 0 through 8
   num_interrupt_regs   : integer := 1; -- Number of Interrupt Registers - 0 or 1
   num_interrupt_src    : integer := 16;-- Number of Interrupt Source bits - 0 to 32
   sync_ram_clr_reg_num : integer := 5; -- Register Number used for SYNC RAM Clear
   sync_ram_set_reg_num : integer := 6  -- Register Number used for SYNC RAM Set
);
port (
--------------------------------------------------------------------------------
-- AXI LITE Slave Interface  
-- DWORD Addressing
--------------------------------------------------------------------------------
   s_axi_csr_aclk      : in  std_logic;
   s_axi_csr_aresetn   : in  std_logic;
   s_axi_csr_awaddr    : in  std_logic_vector(num_addr_bits-1 downto 0);
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
   s_axi_csr_araddr    : in  std_logic_vector(num_addr_bits-1 downto 0);
   s_axi_csr_arprot    : in  std_logic_vector(2 downto 0); -- not used
   s_axi_csr_arvalid   : in  std_logic;
   s_axi_csr_arready   : out std_logic;
   s_axi_csr_rdata     : out std_logic_vector(31 downto 0);
   s_axi_csr_rresp     : out std_logic_vector(1 downto 0);
   s_axi_csr_rvalid    : out std_logic;
   s_axi_csr_rready    : in  std_logic;
--------------------------------------------------------------------------------
-- Control Register Init Values
-------------------------------------------------------------------------------- 
   reg0_init_val   : in  std_logic_vector(31 downto 0);
   reg1_init_val   : in  std_logic_vector(31 downto 0);
   reg2_init_val   : in  std_logic_vector(31 downto 0);
   reg3_init_val   : in  std_logic_vector(31 downto 0);
   reg4_init_val   : in  std_logic_vector(31 downto 0);
   reg5_init_val   : in  std_logic_vector(31 downto 0);
   reg6_init_val   : in  std_logic_vector(31 downto 0);
   reg7_init_val   : in  std_logic_vector(31 downto 0);   
--------------------------------------------------------------------------------
-- Control Register Outputs
--------------------------------------------------------------------------------
   ctl0_out        : out std_logic_vector(31 downto 0);
   ctl1_out        : out std_logic_vector(31 downto 0);
   ctl2_out        : out std_logic_vector(31 downto 0);
   ctl3_out        : out std_logic_vector(31 downto 0);
   ctl4_out        : out std_logic_vector(31 downto 0);
   ctl5_out        : out std_logic_vector(31 downto 0);
   ctl6_out        : out std_logic_vector(31 downto 0);
   ctl7_out        : out std_logic_vector(31 downto 0);
--------------------------------------------------------------------------------
-- Status Register Inputs
--------------------------------------------------------------------------------
   stat0_in        : in  std_logic_vector(31 downto 0);
   stat1_in        : in  std_logic_vector(31 downto 0);
   stat2_in        : in  std_logic_vector(31 downto 0);
   stat3_in        : in  std_logic_vector(31 downto 0);
   stat4_in        : in  std_logic_vector(31 downto 0);
   stat5_in        : in  std_logic_vector(31 downto 0);
   stat6_in        : in  std_logic_vector(31 downto 0);
   stat7_in        : in  std_logic_vector(31 downto 0);  
--------------------------------------------------------------------------------
-- Interrupt
--------------------------------------------------------------------------------
   intrpt_src_in   : in  std_logic_vector(num_interrupt_src-1 downto 0);        
   irq             : out std_logic;  
--------------------------------------------------------------------------------
-- SYNC RAM Set/Clear Interface
--------------------------------------------------------------------------------
   sync_ram_tvalid : out std_logic;
   sync_ram_tready : in  std_logic;
   sync_ram_tdata  : out std_logic_vector(7 downto 0);
   sync_ram_tuser  : out std_logic_vector(10 downto 0)
);
end component;

---------------------------------------------------------------------------------
-- Constants
---------------------------------------------------------------------------------

constant DMA_RESTART_REG_INIT_VAL         : std_logic_vector(31 downto 0) := x"00000000";
constant DMA_ADVANCE_REG_INIT_VAL         : std_logic_vector(31 downto 0) := x"00000000";
constant DMA_ABORT_REG_INIT_VAL           : std_logic_vector(31 downto 0) := x"00000000";
constant DMA_START_LINK_ADDR_REG_INIT_VAL : std_logic_vector(31 downto 0) := x"00000000";

---------------------------------------------------------------------------------
-- Signals
---------------------------------------------------------------------------------
 
signal cntl_reg0            : std_logic_vector(31 downto 0) := DMA_RESTART_REG_INIT_VAL;
signal cntl_reg1            : std_logic_vector(31 downto 0) := DMA_ADVANCE_REG_INIT_VAL;
signal cntl_reg2            : std_logic_vector(31 downto 0) := DMA_ABORT_REG_INIT_VAL;
signal cntl_reg3            : std_logic_vector(31 downto 0) := DMA_START_LINK_ADDR_REG_INIT_VAL;
signal cntl_reg4            : std_logic_vector(31 downto 0) := (others => '0');
signal cntl_reg5            : std_logic_vector(31 downto 0) := (others => '0');
signal cntl_reg6            : std_logic_vector(31 downto 0) := (others => '0');
signal stat_reg0            : std_logic_vector(31 downto 0) := (others => '0');
signal stat_reg1            : std_logic_vector(31 downto 0) := (others => '0');
signal stat_reg2            : std_logic_vector(31 downto 0) := (others => '0');
signal stat_reg3            : std_logic_vector(31 downto 0) := (others => '0');
signal stat_reg4            : std_logic_vector(31 downto 0) := (others => '0');
signal int_src_stat         : std_logic_vector(15 downto 0):= (others => '0');
signal t1_cntl_reg0_0       : std_logic:= '0';
signal t1_cntl_reg1_0       : std_logic:= '0';  
signal t1_cntl_reg2_0       : std_logic:= '0'; 

---------------------------------------------------------------------------------

begin

csr_inst: px_axil_dma_csr 
  generic map (
    num_addr_bits        => 6, -- Number of address bits 3-7 (Must agree with number of registers
    num_ctl_regs         => 8, -- Number of Control Registers - 0 through 8
    num_stat_regs        => 5, -- Number of Status Registers - 0 through 8
    num_interrupt_regs   => 1, -- Number of Interrupt Registers - 0 or 1
    num_interrupt_src    => 16,-- Number of Interrupt Source bits - 0 to 32
    sync_ram_clr_reg_num => 5, -- Register Number used for SYNC RAM Clear
    sync_ram_set_reg_num => 6  -- Register Number used for SYNC RAM Set
)
  port map (
    s_axi_csr_aclk      => s_axi_csr_aclk,
    s_axi_csr_aresetn   => s_axi_csr_aresetn,
    s_axi_csr_awaddr    => s_axi_csr_awaddr,
    s_axi_csr_awprot    => s_axi_csr_awprot,
    s_axi_csr_awvalid   => s_axi_csr_awvalid,
    s_axi_csr_awready   => s_axi_csr_awready,
    s_axi_csr_wdata     => s_axi_csr_wdata,
    s_axi_csr_wstrb     => s_axi_csr_wstrb,
    s_axi_csr_wvalid    => s_axi_csr_wvalid,
    s_axi_csr_wready    => s_axi_csr_wready,
    s_axi_csr_bresp     => s_axi_csr_bresp,
    s_axi_csr_bvalid    => s_axi_csr_bvalid,
    s_axi_csr_bready    => s_axi_csr_bready,
    s_axi_csr_araddr    => s_axi_csr_araddr,
    s_axi_csr_arprot    => s_axi_csr_arprot,
    s_axi_csr_arvalid   => s_axi_csr_arvalid,
    s_axi_csr_arready   => s_axi_csr_arready,
    s_axi_csr_rdata     => s_axi_csr_rdata,
    s_axi_csr_rresp     => s_axi_csr_rresp,
    s_axi_csr_rvalid    => s_axi_csr_rvalid,
    s_axi_csr_rready    => s_axi_csr_rready,
    reg0_init_val       => DMA_RESTART_REG_INIT_VAL,        
    reg1_init_val       => DMA_ADVANCE_REG_INIT_VAL,        
    reg2_init_val       => DMA_ABORT_REG_INIT_VAL,          
    reg3_init_val       => DMA_START_LINK_ADDR_REG_INIT_VAL,
    reg4_init_val       => x"00000000", 
    reg5_init_val       => x"00000000", 
    reg6_init_val       => x"00000000", 
    reg7_init_val       => x"00000000",    
    ctl0_out            => cntl_reg0,
    ctl1_out            => cntl_reg1,
    ctl2_out            => cntl_reg2,
    ctl3_out            => cntl_reg3,
    ctl4_out            => cntl_reg4,
    ctl5_out            => cntl_reg5,
    ctl6_out            => cntl_reg6,
    ctl7_out            => open,    
    stat0_in            => stat_reg0,
    stat1_in            => stat_reg1,
    stat2_in            => stat_reg2,
    stat3_in            => stat_reg3,
    stat4_in            => stat_reg4,
    stat5_in            => x"00000000",
    stat6_in            => x"00000000",
    stat7_in            => x"00000000",
    intrpt_src_in       => int_src_stat,
    irq                 => irq,
    sync_ram_tvalid     => open,
    sync_ram_tready     => '1',
    sync_ram_tdata      => open, 
    sync_ram_tuser      => open 
  );

--------------------------------------------------------------------------------
-- Control Outputs
--------------------------------------------------------------------------------

process(s_axi_csr_aclk)
begin
    if rising_edge(s_axi_csr_aclk) then
        t1_cntl_reg0_0 <= cntl_reg0(0);
        dma_restart    <= (not t1_cntl_reg0_0) and cntl_reg0(0);
        t1_cntl_reg1_0 <= cntl_reg1(0);
        dma_advance    <= (not t1_cntl_reg1_0) and cntl_reg1(0);
        t1_cntl_reg2_0 <= cntl_reg2(0);
        dma_abort      <= (not t1_cntl_reg2_0) and cntl_reg2(0);     
        fifo_flush     <= cntl_reg4(0);  
    end if;
end process;

start_link_descr_addr <= cntl_reg3(15 downto 0);

--------------------------------------------------------------------------------
-- Status Inputs
--------------------------------------------------------------------------------

stat_reg0(27 downto 0) <= x"0000" & "000" & dma_aborting & '0' & dma_waiting_for_adv & dma_paused &
             dma_active & pcie_rqst_fifo_afl & pcie_rqst_fifo_empty & data_buf_fifo_full & data_buf_fifo_empty; 
stat_reg1 <= x"0000" & current_link_address;  
stat_reg2 <= x"0000" & last_link_address;     
stat_reg3 <= bytes_last_transferred;
stat_reg4(4 downto 0)    <= (others => '0'); 
stat_reg4(16 downto 5)   <= data_buf_fifo_count;
stat_reg4(31 downto 17)  <= (others => '0'); 

process(s_axi_csr_aclk)
begin
    if rising_edge(s_axi_csr_aclk) then
        if s_axi_csr_aresetn = '0' then
            stat_reg0(31 downto 28) <= "0000";
        elsif pcie_data_error <= '1' then
            stat_reg0(31 downto 28) <= pcie_error_code;
        end if;
    end if;        
end process;

int_src_stat <= x"0" & "0"  & all_rd_cmplt & all_rqsts_cmplt & pcie_data_error & '0'&
                abort_cmplt & waiting_adv & link_start & chain_end_int & link_end_int & chain_end & link_end;        


end Behavioral;

