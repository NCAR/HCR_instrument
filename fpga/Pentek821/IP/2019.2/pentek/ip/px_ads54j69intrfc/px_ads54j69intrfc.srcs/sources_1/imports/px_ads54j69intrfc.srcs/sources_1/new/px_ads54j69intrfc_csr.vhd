----------------------------------------------------------------------------------
-- Control/Status Registers for Pentek ADS42LB69 ADC Interface
----------------------------------------------------------------------------------
-- px_ads54j69intrfc_csr.vhd
--
-- Target Device: Kintex UltraScale
--
-- Pentek Inc.
-- One Park Way, Upper Saddle River, NJ 07458
-- (201)818-5900
-- www.pentek.com
--
-- Copyright Pentek, Inc. 2015
--
-- Revision:
-- Revision 0.01 - File Created


-- Additional Comments: 
--  

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
----------------------------------------------------------------------------------

-- Memory Map
-- 0x00 - Control
-- 0x04 - Channel A Offset/Gain Trim
-- 0x08 - Channel B Offset/Gain Trim 
-- 0x0C - ADC Serial Control 
-- 0x10 - ADC Serial Status
-- 0x14 - Reserved
-- 0x18 - Reserved
-- 0x1C - Reserved
-- 0x20 - Interrupt Enable
-- 0x24 - Interrupt Status
-- 0x28 - Interrupt Flags

-- Control
--Bit [1:0] - RESERVED
--Bit [2]   - Reset
--Bit [3]   - Power Down
--Bit [4]   - RESERVED
--Bit [6:5] - LED Source Select  00 = ADC OVLD 01 = G/O OVLD 10 = Ext Sig 11 = Disabled  
--Bit [7]   - RESERVED 
--Bit [31:16]- Overload Threshold Count

-- Ch A Offset/Gain Trim or Ch B Offset/Gain Trim 
--Bit [15:0] - Gain
--Bit [31:16]- Offset

-- Interrupts
-- Bit [0] ADC Ch A Overload
-- Bit [1] G/O Ch A Overload
-- Bit [2] ADC Ch B Overload
-- Bit [3] G/O Ch B Overload

----------------------------------------------------------------------------------


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

entity px_ads54j69intrfc_csr is
generic(
    initial_gain_a      : std_logic_vector(15 downto 0) := x"8000";  
    initial_offset_a    : std_logic_vector(15 downto 0) := x"0000";
    initial_gain_b      : std_logic_vector(15 downto 0) := x"8000";  
    initial_offset_b    : std_logic_vector(15 downto 0) := x"0000";  
    initial_pdwnf       : boolean := false; 
    initial_led_select  : integer range 0 to 3 := 0;
    initial_ovld_thresh : integer := 16
);
port (
--------------------------------------------------------------------------------
-- AXI LITE Slave Interface  
-- DWORD Addressing
--------------------------------------------------------------------------------
    s_axi_csr_aclk         : in  std_logic;
    s_axi_csr_aresetn      : in  std_logic;
    s_axi_csr_awaddr       : in  std_logic_vector(6 downto 0); 
    s_axi_csr_awprot       : in  std_logic_vector(2 downto 0);
    s_axi_csr_awvalid      : in  std_logic;
    s_axi_csr_awready      : out std_logic;
    s_axi_csr_wdata        : in  std_logic_vector(31 downto 0);
    s_axi_csr_wstrb        : in  std_logic_vector(3 downto 0);
    s_axi_csr_wvalid       : in  std_logic;
    s_axi_csr_wready       : out std_logic;
    s_axi_csr_bresp        : out std_logic_vector(1 downto 0);
    s_axi_csr_bvalid       : out std_logic;
    s_axi_csr_bready       : in  std_logic;
    s_axi_csr_araddr       : in  std_logic_vector(6 downto 0);  
    s_axi_csr_arprot       : in  std_logic_vector(2 downto 0);
    s_axi_csr_arvalid      : in  std_logic;
    s_axi_csr_arready      : out std_logic;
    s_axi_csr_rdata        : out std_logic_vector(31 downto 0);
    s_axi_csr_rresp        : out std_logic_vector(1 downto 0);
    s_axi_csr_rvalid       : out std_logic;
    s_axi_csr_rready       : in  std_logic;
    
    irq                   : out std_logic; -- interrupt
--------------------------------------------------------------------------------
-- Control Outputs
--------------------------------------------------------------------------------    
    gain_a                : out std_logic_vector(15 downto 0); 
    offset_a              : out std_logic_vector(15 downto 0);
    gain_b                : out std_logic_vector(15 downto 0); 
    offset_b              : out std_logic_vector(15 downto 0);
    ovld_thresh_cnt       : out std_logic_vector(15 downto 0);            
    led_sel               : out std_logic_vector(1 downto 0);
    pdwnf                 : out std_logic;    
    adc_reset             : out std_logic;

	-------------------------------------------------------------------------------
-- Interrupt Sources
--------------------------------------------------------------------------------
    adc_overload_a        : in  std_logic;
    adc_overload_b        : in  std_logic;
    go_overload_a         : in  std_logic;
    go_overload_b         : in  std_logic
);
end px_ads54j69intrfc_csr;

architecture Behavioral of px_ads54j69intrfc_csr is

--------------------------------------------------------------------------------
-- Components
--------------------------------------------------------------------------------

-- Generic AXI-Lite Control/Status Register Set
component px_axil_csr_ads
  port (
    s_axi_csr_aclk : in std_logic;
    s_axi_csr_aresetn : in std_logic;
    s_axi_csr_awaddr : in std_logic_vector(6 downto 0);
    s_axi_csr_awprot : in std_logic_vector(2 downto 0);
    s_axi_csr_awvalid : in std_logic;
    s_axi_csr_awready : out std_logic;
    s_axi_csr_wdata : in std_logic_vector(31 downto 0);
    s_axi_csr_wstrb : in std_logic_vector(3 downto 0);
    s_axi_csr_wvalid : in std_logic;
    s_axi_csr_wready : out std_logic;
    s_axi_csr_bresp : out std_logic_vector(1 downto 0);
    s_axi_csr_bvalid : out std_logic;
    s_axi_csr_bready : in std_logic;
    s_axi_csr_araddr : in std_logic_vector(6 downto 0);
    s_axi_csr_arprot : in std_logic_vector(2 downto 0);
    s_axi_csr_arvalid : in std_logic;
    s_axi_csr_arready : out std_logic;
    s_axi_csr_rdata : out std_logic_vector(31 downto 0);
    s_axi_csr_rresp : out std_logic_vector(1 downto 0);
    s_axi_csr_rvalid : out std_logic;
    s_axi_csr_rready : in std_logic;
    reg0_init_val : in std_logic_vector(31 downto 0);
    reg1_init_val : in std_logic_vector(31 downto 0);
    reg2_init_val : in std_logic_vector(31 downto 0);
    reg3_init_val : in std_logic_vector(31 downto 0);
    ctl0_out : out std_logic_vector(31 downto 0);
    ctl1_out : out std_logic_vector(31 downto 0);
    ctl2_out : out std_logic_vector(31 downto 0);
    ctl3_out : out std_logic_vector(31 downto 0);
    stat0_in : in std_logic_vector(31 downto 0);
    stat1_in : in std_logic_vector(31 downto 0);
    stat2_in : in std_logic_vector(31 downto 0);
    stat3_in : in std_logic_vector(31 downto 0);
    intrpt_src_in : in std_logic_vector(3 downto 0);
    irq : out std_logic
  );
end component;
			
--------------------------------------------------------------------------------
-- Functions
--------------------------------------------------------------------------------

function To_Std_Logic(L: BOOLEAN) return std_logic is
begin
    if L then
       return('1');
    else
       return('0');
    end if;
end function To_Std_Logic;

---------------------------------------------------------------------------------
-- Constants
---------------------------------------------------------------------------------
-- Control Register
--Bits [0,1]  - Reserved
--Bit [2]     - Reset
--Bit [3]     - Power Down ADC A
--Bit [4]     - Power Down ADC B
--Bit [6:5]   - LED Source Select  00 = ADC OVLD 01 = G/O OVLD 10 = Ext Sig 11 = Disabled
--Bit [7]     - Reserved   
--Bit [31:16] - Overload Threshold Count

constant CNTL_REG0_INIT_VAL: std_logic_vector(31 downto 0) := conv_std_logic_vector(initial_ovld_thresh, 16) & "000000000" & 
                                                              conv_std_logic_vector(initial_led_select,2) & '0' & To_Std_Logic(initial_pdwnf) & "000";
constant CNTL_REG1_INIT_VAL: std_logic_vector(31 downto 0) := initial_offset_a & initial_gain_a; 
constant CNTL_REG2_INIT_VAL: std_logic_vector(31 downto 0) := initial_offset_b & initial_gain_b; 
constant CNTL_REG3_INIT_VAL: std_logic_vector(31 downto 0) := (others => '0'); 


---------------------------------------------------------------------------------
-- Signals
---------------------------------------------------------------------------------
 
signal cntl_reg0            : std_logic_vector(31 downto 0) := CNTL_REG0_INIT_VAL;
signal cntl_reg1            : std_logic_vector(31 downto 0) := CNTL_REG1_INIT_VAL;
signal cntl_reg2            : std_logic_vector(31 downto 0) := CNTL_REG2_INIT_VAL;
signal int_src_stat         : std_logic_vector(3 downto 0)  := (others => '0');
signal stat0_in             : std_logic_vector(31 downto 0) := (others => '0');
---------------------------------------------------------------------------------

begin

csr_inst: px_axil_csr_ads
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
    reg0_init_val       => CNTL_REG0_INIT_VAL,
    reg1_init_val       => CNTL_REG1_INIT_VAL,
    reg2_init_val       => CNTL_REG2_INIT_VAL,
    reg3_init_val       => CNTL_REG3_INIT_VAL,
    ctl0_out            => cntl_reg0,
    ctl1_out            => cntl_reg1,
    ctl2_out            => cntl_reg2,
    ctl3_out            => open,
    stat0_in            => x"00000000",
    stat1_in            => x"00000000",
    stat2_in            => x"00000000",
    stat3_in            => x"00000000",
    intrpt_src_in       => int_src_stat,
    irq                 => irq
  );

--------------------------------------------------------------------------------
-- Control Outputs
--------------------------------------------------------------------------------

--Control
--Bit [1:0]   - Reserved 
--Bit [2]     - ADC Reset
--Bit [3]     - Power Down
--Bit [4]     - Reserved
--Bit [6:5]   - LED Source Select  00 = ADC OVLD 01 = G/O OVLD 10 = Ext Sig 11 = Disabled  
--Bit [7]     - Reserved 
--Bit [31:16] - Overload Threshold Count

process(s_axi_csr_aclk)
begin
    if rising_edge(s_axi_csr_aclk) then
       adc_reset           <= cntl_reg1(2);
       pdwnf               <= cntl_reg1(3);
       led_sel             <= cntl_reg1(6 downto 5);
       ovld_thresh_cnt     <= cntl_reg1(31 downto 16);
       gain_a              <= cntl_reg1(15 downto 0);
       offset_a            <= cntl_reg1(31 downto 16);
       gain_b              <= cntl_reg2(15 downto 0);
       offset_b            <= cntl_reg2(31 downto 16);
    end if;
end process;

--------------------------------------------------------------------------------
-- Interrupt Sources
--------------------------------------------------------------------------------

-- Interrupts

int_src_stat <= go_overload_b & adc_overload_b & go_overload_a & adc_overload_a;


end Behavioral;
