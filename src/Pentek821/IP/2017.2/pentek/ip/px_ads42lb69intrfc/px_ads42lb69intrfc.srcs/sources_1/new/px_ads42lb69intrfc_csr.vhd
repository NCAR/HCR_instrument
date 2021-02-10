----------------------------------------------------------------------------------
-- Control/Status Registers for Pentek ADS42LB69 ADC Interface
----------------------------------------------------------------------------------
-- px_ads42lb69intrfc_csr.vhd
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
-- 0x00 - Control 1
-- 0x04 - Control 2
-- 0x08 - Channel A Offset/Gain Trim 
-- 0x0C - Channel B Offset/Gain Trim 
-- 0x10 - ADC Serial Control
-- 0x14 - ADC Serial Status
-- 0x18 - Reserved
-- 0x1C - Reserved
-- 0x20 - Reserved
-- 0x24 - Interrupt Enable
-- 0x28 - Interrupt Status
-- 0x2C - Interrupt Flags

-- Control 1
--Bit [8:0]  - Tap Delay
--Bit [9]    - VTC Disable

-- Control 2
--Bit [1:0] - Integer Clock Delay 
--Bit [2]   - Reset
--Bit [3]   - Power Down Ch A
--Bit [4]   - Power Down Ch B
--Bit [6:5] - LED Source Select  00 = ADC OVLD 01 = G/O OVLD 10 = Ext Sig 11 = Disabled  
--Bit [7]   - Clock is Set up (Set to allow ADC clock input from ADC) 
--Bit [31:16]- Overload Threshold Count

-- Ch A Offset/Gain Trim or Ch B Offset/Gain Trim 
--Bit [15:0] - Gain
--Bit [31:16]- Offset

-- ADS42LB69 ADC Serial Control
--Bit [0] - Serial Access Request (toggle)
--Bit [1] - Serial Read/Write 0 = Write 1 = Read   
--Bit [13:8] - Serial Address
--Bit [23:16] - Serial Write Data

-- ADC12D1800 ADC Serial Status
--Bit [0] - Serial Access Done
--Bit [23:16] - Serial Read Data

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

entity px_ads42lb69intrfc_csr is
generic(
    initial_tap_delay   : integer := 0;
    initial_gain_a      : std_logic_vector(15 downto 0) := x"8000";  
    initial_offset_a    : std_logic_vector(15 downto 0) := x"0000";
    initial_gain_b      : std_logic_vector(15 downto 0) := x"8000";  
    initial_offset_b    : std_logic_vector(15 downto 0) := x"0000";  
    initial_pdwnf_a       : boolean := false; 
    initial_pdwnf_b       : boolean := false; 
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
    tap_delay             : out std_logic_vector(8 downto 0);
    int_delay             : out std_logic_vector(1 downto 0);
    gain_a                : out std_logic_vector(15 downto 0); 
    offset_a              : out std_logic_vector(15 downto 0);
    gain_b                : out std_logic_vector(15 downto 0); 
    offset_b              : out std_logic_vector(15 downto 0);
    ovld_thresh_cnt       : out std_logic_vector(15 downto 0);            
    led_sel               : out std_logic_vector(1 downto 0);
    pdwnf_a               : out std_logic;    
    pdwnf_b               : out std_logic;    
    adc_reset             : out std_logic;
    clk_configured        : out std_logic;
    dly_ld_ctl            : out std_logic;
    -- Serial Control Interface
    ser_wr_data           : out std_logic_vector(7 downto 0); 
    ser_addr              : out std_logic_vector(5 downto 0);  
    ser_wr_pls            : out std_logic;  
    ser_rd_pls            : out std_logic;  
    ser_rd_data           : in  std_logic_vector(7 downto 0);
    -- Status
    ser_sm_rdy            : in  std_logic;
-------------------------------------------------------------------------------
-- Interrupt Sources
--------------------------------------------------------------------------------
    adc_overload_a        : in  std_logic;
    adc_overload_b        : in  std_logic;
    go_overload_a         : in  std_logic;
    go_overload_b         : in  std_logic
);
end px_ads42lb69intrfc_csr;

architecture Behavioral of px_ads42lb69intrfc_csr is

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
    reg4_init_val : in std_logic_vector(31 downto 0);
    ctl0_out : out std_logic_vector(31 downto 0);
    ctl1_out : out std_logic_vector(31 downto 0);
    ctl2_out : out std_logic_vector(31 downto 0);
    ctl3_out : out std_logic_vector(31 downto 0);
    ctl4_out : out std_logic_vector(31 downto 0);
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
--Bit [1:0] - Integer Clock Delay 
--Bit [2]   - Reserved
--Bit [3]   - Reset
--Bit [4]   - Power Down
--Bit [6:5]- LED Source Select  00 = ADC OVLD 01 = G/O OVLD 10 = Ext Sig 11 = Disabled
--Bit [7]   - Clock is Set up (Set to allow ADC clock input from ADC)   
--Bit [31:16]- Overload Threshold Count

constant CNTL_REG0_INIT_VAL: std_logic_vector(31 downto 0) := x"00000" & "000" & conv_std_logic_vector(initial_tap_delay, 9);
constant CNTL_REG1_INIT_VAL: std_logic_vector(31 downto 0) := conv_std_logic_vector(initial_ovld_thresh, 16) & "000000000" & 
                                                              conv_std_logic_vector(initial_led_select,2) & To_Std_Logic(initial_pdwnf_b) & To_Std_Logic(initial_pdwnf_a) & "000";
constant CNTL_REG2_INIT_VAL: std_logic_vector(31 downto 0) := initial_offset_a & initial_gain_a; 
constant CNTL_REG3_INIT_VAL: std_logic_vector(31 downto 0) := initial_offset_b & initial_gain_b; 
constant CNTL_REG4_INIT_VAL: std_logic_vector(31 downto 0) := (others => '0'); 


---------------------------------------------------------------------------------
-- Signals
---------------------------------------------------------------------------------
 
signal cntl_reg0            : std_logic_vector(31 downto 0) := CNTL_REG0_INIT_VAL;
signal cntl_reg1            : std_logic_vector(31 downto 0) := CNTL_REG1_INIT_VAL;
signal cntl_reg2            : std_logic_vector(31 downto 0) := CNTL_REG2_INIT_VAL;
signal cntl_reg3            : std_logic_vector(31 downto 0) := CNTL_REG3_INIT_VAL;
signal cntl_reg4            : std_logic_vector(31 downto 0) := CNTL_REG4_INIT_VAL;
signal int_src_stat         : std_logic_vector(3 downto 0)  := (others => '0');
signal stat0_in             : std_logic_vector(31 downto 0) := (others => '0');
signal t1_ser_access        : std_logic := '0';
signal t1_ser_sm_rdy        : std_logic := '0';
signal ser_sm_rdy_int       : std_logic := '0';
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
    reg4_init_val       => CNTL_REG4_INIT_VAL,
    ctl0_out            => cntl_reg0,
    ctl1_out            => cntl_reg1,
    ctl2_out            => cntl_reg2,
    ctl3_out            => cntl_reg3,
    ctl4_out            => cntl_reg4,
    stat0_in            => stat0_in,
    stat1_in            => x"00000000",
    stat2_in            => x"00000000",
    stat3_in            => x"00000000",
    intrpt_src_in       => int_src_stat,
    irq                 => irq
  );

--------------------------------------------------------------------------------
-- Control Outputs
--------------------------------------------------------------------------------
--Control Reg 1
--Bit [8:0]   - Tap Delay
--Bit [9]     - Disable VTC

--Control Reg 2
--Bit [1:0] - Integer Clock Delay 
--Bit [2]   -  ADC Reset
--Bit [3]   - Power Down Ch A
--Bit [4]   - Power Down Ch B
--Bit [6:5] - LED Source Select  00 = ADC OVLD 01 = G/O OVLD 10 = Ext Sig 11 = Disabled  
--Bit [7]   - Clock is Set up (Set to allow ADC clock input from ADC) 
--Bit [31:16]- Overload Threshold Count

process(s_axi_csr_aclk)
begin
    if rising_edge(s_axi_csr_aclk) then
       tap_delay           <= cntl_reg0(8 downto 0); 
       int_delay           <= cntl_reg1(1 downto 0);
       adc_reset           <= cntl_reg1(2);
       pdwnf_a             <= cntl_reg1(3);
       pdwnf_b             <= cntl_reg1(4);
       led_sel             <= cntl_reg1(6 downto 5);
       clk_configured      <= cntl_reg1(7);
       ovld_thresh_cnt     <= cntl_reg1(31 downto 16);
       gain_a              <= cntl_reg2(15 downto 0);
       offset_a            <= cntl_reg2(31 downto 16);
       gain_b              <= cntl_reg3(15 downto 0);
       offset_b            <= cntl_reg3(31 downto 16);
       dly_ld_ctl          <= cntl_reg0(9);
    end if;
end process;

--en_vtc <= not cntl_reg0(9);

-- ADS42LB69 ADC Serial Control
--Bit [0]     - Serial Access Request (toggle)
--Bit [1]     - Serial Read/Write 0 = Write 1 = Read   
--Bit [13:8]  - Serial Address
--Bit [23:16] - Serial Write Data
process(s_axi_csr_aclk)
begin
    if rising_edge(s_axi_csr_aclk) then
        ser_wr_data   <= cntl_reg4(23 downto 16);
        ser_addr      <= cntl_reg4(13 downto 8);
        t1_ser_access <= cntl_reg4(0);
        ser_wr_pls    <= cntl_reg4(0) and (not t1_ser_access) and (not cntl_reg4(1));
        ser_rd_pls    <= cntl_reg4(0) and (not t1_ser_access) and (cntl_reg4(1));
    end if;
end process;

--------------------------------------------------------------------------------
-- Status
--------------------------------------------------------------------------------
--Bit[0]     - Serial Interface Ready
--Bit[23:16] - Serial Read Data
process(s_axi_csr_aclk)
begin
    if rising_edge(s_axi_csr_aclk) then
       stat0_in(0)            <= ser_sm_rdy;
       stat0_in(23 downto 16) <= ser_rd_data; 
    end if;
end process;

stat0_in(15 downto 2) <= (others => '0');
stat0_in(31 downto 24) <= (others => '0');
--------------------------------------------------------------------------------
-- Interrupt Sources
--------------------------------------------------------------------------------

-- Interrupts

int_src_stat <= go_overload_b & adc_overload_b & go_overload_a & adc_overload_a;


end Behavioral;
