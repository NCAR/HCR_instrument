----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/31/2015 06:09:44 PM
-- Design Name: 
-- Module Name: tb_p_axil_csr - Behavioral
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
-- Libraries
-------------------------------------------------------------------------------
use std.textio.all;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

use ieee.numeric_std.ALL;
use work.px_utility_pkg.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_p_axil_csr32 is

end tb_p_axil_csr32;

architecture Behavioral of tb_p_axil_csr32 is

--------------------------------------------------------------------------------
-- Components
--------------------------------------------------------------------------------

component p_axil_csr32 
generic (
   reg_type          : std_logic_vector(31 downto 0) := x"0000000F"; -- '1' = Control Reg, '0' = Status Reg
   disable_reg       : std_logic_vector(31 downto 0) := x"FFFFFF00"; -- '0' = Create Status or Control Reg, '1' = No Reg
   has_interrupt_regs: boolean := true; -- Create Interrupt Registers? 
   num_interrupt_src : integer := 16 -- Number of Interrupt Source bits - 0 to 32 
);
port (
--------------------------------------------------------------------------------
-- AXI LITE Slave Interface  
-- DWORD Addressing
--------------------------------------------------------------------------------
   s_axi_csr_aclk      : in  std_logic;
   s_axi_csr_aresetn   : in  std_logic;
   s_axi_csr_awaddr    : in  std_logic_vector(6 downto 0);
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
   s_axi_csr_araddr    : in  std_logic_vector(6 downto 0);
   s_axi_csr_arprot    : in  std_logic_vector(2 downto 0); -- not used
   s_axi_csr_arvalid   : in  std_logic;
   s_axi_csr_arready   : out std_logic;
   s_axi_csr_rdata     : out std_logic_vector(31 downto 0);
   s_axi_csr_rresp     : out std_logic_vector(1 downto 0);
   s_axi_csr_rvalid    : out std_logic;
   s_axi_csr_rready    : in  std_logic;  
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
   ctl8_out        : out std_logic_vector(31 downto 0);
   ctl9_out        : out std_logic_vector(31 downto 0);
   ctl10_out       : out std_logic_vector(31 downto 0);
   ctl11_out       : out std_logic_vector(31 downto 0);
   ctl12_out       : out std_logic_vector(31 downto 0);
   ctl13_out       : out std_logic_vector(31 downto 0);
   ctl14_out       : out std_logic_vector(31 downto 0);
   ctl15_out       : out std_logic_vector(31 downto 0);
   ctl16_out       : out std_logic_vector(31 downto 0);
   ctl17_out       : out std_logic_vector(31 downto 0);
   ctl18_out       : out std_logic_vector(31 downto 0);
   ctl19_out       : out std_logic_vector(31 downto 0);
   ctl20_out       : out std_logic_vector(31 downto 0);
   ctl21_out       : out std_logic_vector(31 downto 0);
   ctl22_out       : out std_logic_vector(31 downto 0);
   ctl23_out       : out std_logic_vector(31 downto 0);
   ctl24_out       : out std_logic_vector(31 downto 0);
   ctl25_out       : out std_logic_vector(31 downto 0);
   ctl26_out       : out std_logic_vector(31 downto 0);
   ctl27_out       : out std_logic_vector(31 downto 0);
   ctl28_out       : out std_logic_vector(31 downto 0);
--------------------------------------------------------------------------------
-- Status Register Inputs/ Control Register Init Values
--------------------------------------------------------------------------------
   stat0_in        : in  std_logic_vector(31 downto 0);
   stat1_in        : in  std_logic_vector(31 downto 0);
   stat2_in        : in  std_logic_vector(31 downto 0);
   stat3_in        : in  std_logic_vector(31 downto 0);
   stat4_in        : in  std_logic_vector(31 downto 0);
   stat5_in        : in  std_logic_vector(31 downto 0);
   stat6_in        : in  std_logic_vector(31 downto 0);
   stat7_in        : in  std_logic_vector(31 downto 0);  
   stat8_in        : in  std_logic_vector(31 downto 0);
   stat9_in        : in  std_logic_vector(31 downto 0);
   stat10_in       : in  std_logic_vector(31 downto 0);
   stat11_in       : in  std_logic_vector(31 downto 0);
   stat12_in       : in  std_logic_vector(31 downto 0);
   stat13_in       : in  std_logic_vector(31 downto 0);
   stat14_in       : in  std_logic_vector(31 downto 0);
   stat15_in       : in  std_logic_vector(31 downto 0);
   stat16_in       : in  std_logic_vector(31 downto 0);
   stat17_in       : in  std_logic_vector(31 downto 0);
   stat18_in       : in  std_logic_vector(31 downto 0);
   stat19_in       : in  std_logic_vector(31 downto 0);
   stat20_in       : in  std_logic_vector(31 downto 0);
   stat21_in       : in  std_logic_vector(31 downto 0);
   stat22_in       : in  std_logic_vector(31 downto 0);
   stat23_in       : in  std_logic_vector(31 downto 0);  
   stat24_in       : in  std_logic_vector(31 downto 0);
   stat25_in       : in  std_logic_vector(31 downto 0);
   stat26_in       : in  std_logic_vector(31 downto 0);
   stat27_in       : in  std_logic_vector(31 downto 0);
   stat28_in       : in  std_logic_vector(31 downto 0);  
--------------------------------------------------------------------------------
-- Interrupt
--------------------------------------------------------------------------------
   intrpt_src_in   : in  std_logic_vector(num_interrupt_src-1 downto 0);        
   irq             : out std_logic
);
end component;

--------------------------------------------------------------------------------
-- Signals
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- AXI LITE Slave Interface  
-- DWORD Addressing
--------------------------------------------------------------------------------
signal  s_axi_csr_aclk      : std_logic := '0';
signal  s_axi_csr_aresetn   : std_logic := '0';
signal  s_axi_csr_awaddr    : std_logic_vector(6  downto 0):= (others => '0');
signal  s_axi_csr_awprot    : std_logic_vector(2 downto 0):= (others => '0'); -- not used
signal  s_axi_csr_awvalid   : std_logic := '0';
signal  s_axi_csr_awready   : std_logic := '0';
signal  s_axi_csr_wdata     : std_logic_vector(31 downto 0):= (others => '0');
signal  s_axi_csr_wstrb     : std_logic_vector(3 downto 0):= (others => '0'); -- not used
signal  s_axi_csr_wvalid    : std_logic := '0';
signal  s_axi_csr_wready    : std_logic := '0';
signal  s_axi_csr_bresp     : std_logic_vector(1 downto 0):= (others => '0');
signal  s_axi_csr_bvalid    : std_logic := '0';
signal  s_axi_csr_bready    : std_logic := '0';
signal  s_axi_csr_araddr    : std_logic_vector(6  downto 0);
signal  s_axi_csr_arprot    : std_logic_vector(2 downto 0); -- not used
signal  s_axi_csr_arvalid   : std_logic := '0';
signal  s_axi_csr_arready   : std_logic := '0';
signal  s_axi_csr_rdata     : std_logic_vector(31 downto 0):= (others => '0');
signal  s_axi_csr_rresp     : std_logic_vector(1 downto 0):= (others => '0');
signal  s_axi_csr_rvalid    : std_logic := '0';
signal  s_axi_csr_rready    : std_logic := '0';
--------------------------------------------------------------------------------
-- Control Register Outputs
--------------------------------------------------------------------------------
signal  ctl0_out        : std_logic_vector(31 downto 0);
signal  ctl1_out        : std_logic_vector(31 downto 0);
signal  ctl2_out        : std_logic_vector(31 downto 0);
signal  ctl3_out        : std_logic_vector(31 downto 0);
signal  ctl4_out        : std_logic_vector(31 downto 0);
signal  ctl5_out        : std_logic_vector(31 downto 0);
signal  ctl6_out        : std_logic_vector(31 downto 0);
signal  ctl7_out        : std_logic_vector(31 downto 0);
signal  ctl8_out        : std_logic_vector(31 downto 0);
signal  ctl9_out        : std_logic_vector(31 downto 0);
signal  ctl10_out       : std_logic_vector(31 downto 0);
signal  ctl11_out       : std_logic_vector(31 downto 0);
signal  ctl12_out       : std_logic_vector(31 downto 0);
signal  ctl13_out       : std_logic_vector(31 downto 0);
signal  ctl14_out       : std_logic_vector(31 downto 0);
signal  ctl15_out       : std_logic_vector(31 downto 0);
signal  ctl16_out       : std_logic_vector(31 downto 0);
signal  ctl17_out       : std_logic_vector(31 downto 0);
signal  ctl18_out       : std_logic_vector(31 downto 0);
signal  ctl19_out       : std_logic_vector(31 downto 0);
signal  ctl20_out       : std_logic_vector(31 downto 0);
signal  ctl21_out       : std_logic_vector(31 downto 0);
signal  ctl22_out       : std_logic_vector(31 downto 0);
signal  ctl23_out       : std_logic_vector(31 downto 0);
signal  ctl24_out       : std_logic_vector(31 downto 0);
signal  ctl25_out       : std_logic_vector(31 downto 0);
signal  ctl26_out       : std_logic_vector(31 downto 0);
signal  ctl27_out       : std_logic_vector(31 downto 0);
signal  ctl28_out       : std_logic_vector(31 downto 0);
--------------------------------------------------------------------------------
-- Status Register Inputs
--------------------------------------------------------------------------------
signal  stat0_in        : std_logic_vector(31 downto 0) := x"00000000";
signal  stat1_in        : std_logic_vector(31 downto 0) := x"00000000";
signal  stat2_in        : std_logic_vector(31 downto 0) := x"00000000";
signal  stat3_in        : std_logic_vector(31 downto 0) := x"00000000";
signal  stat4_in        : std_logic_vector(31 downto 0) := x"00000000";
signal  stat5_in        : std_logic_vector(31 downto 0) := x"00000000";
signal  stat6_in        : std_logic_vector(31 downto 0) := x"00000000";
signal  stat7_in        : std_logic_vector(31 downto 0) := x"00000000";  
signal  stat8_in        : std_logic_vector(31 downto 0) := x"00000000";
signal  stat9_in        : std_logic_vector(31 downto 0) := x"00000000";
signal  stat10_in       : std_logic_vector(31 downto 0) := x"00000000";
signal  stat11_in       : std_logic_vector(31 downto 0) := x"00000000";
signal  stat12_in       : std_logic_vector(31 downto 0) := x"00000000";
signal  stat13_in       : std_logic_vector(31 downto 0) := x"00000000";
signal  stat14_in       : std_logic_vector(31 downto 0) := x"00000000";
signal  stat15_in       : std_logic_vector(31 downto 0) := x"00000000";
signal  stat16_in       : std_logic_vector(31 downto 0) := x"00000000";
signal  stat17_in       : std_logic_vector(31 downto 0) := x"00000001";
signal  stat18_in       : std_logic_vector(31 downto 0) := x"00000002";
signal  stat19_in       : std_logic_vector(31 downto 0) := x"00000003";
signal  stat20_in       : std_logic_vector(31 downto 0) := x"00000004";
signal  stat21_in       : std_logic_vector(31 downto 0) := x"00000005";
signal  stat22_in       : std_logic_vector(31 downto 0) := x"00000006";
signal  stat23_in       : std_logic_vector(31 downto 0) := x"00000007";  
signal  stat24_in       : std_logic_vector(31 downto 0) := x"00000008";
signal  stat25_in       : std_logic_vector(31 downto 0) := x"00000009";
signal  stat26_in       : std_logic_vector(31 downto 0) := x"0000000A";
signal  stat27_in       : std_logic_vector(31 downto 0) := x"0000000B";
signal  stat28_in       : std_logic_vector(31 downto 0) := x"0000000C";  
--------------------------------------------------------------------------------
-- Interrupt                                           
--------------------------------------------------------------------------------
signal intrpt_src_in    : std_logic_vector(31 downto 0) := (others => '0');        
signal irq              : std_logic;

--------------------------------------------------------------------------------

begin

uut: p_axil_csr32
generic map (
   reg_type          => x"0000FFFF", -- '1' = Control Reg, '0' = Status Reg
   disable_reg       => x"00000000", -- '0' = Create Status or Control Reg, '1' = No Reg
   has_interrupt_regs=> true,  
   num_interrupt_src => 32
)
port map (
--------------------------------------------------------------------------------
-- AXI LITE Slave Interface  
-- DWORD Addressing
--------------------------------------------------------------------------------
   s_axi_csr_aclk        => s_axi_csr_aclk,   
   s_axi_csr_aresetn     => s_axi_csr_aresetn,
   s_axi_csr_awaddr      => s_axi_csr_awaddr, 
   s_axi_csr_awprot      => s_axi_csr_awprot, 
   s_axi_csr_awvalid     => s_axi_csr_awvalid,
   s_axi_csr_awready     => s_axi_csr_awready,
   s_axi_csr_wdata       => s_axi_csr_wdata,  
   s_axi_csr_wstrb       => s_axi_csr_wstrb,  
   s_axi_csr_wvalid      => s_axi_csr_wvalid, 
   s_axi_csr_wready      => s_axi_csr_wready, 
   s_axi_csr_bresp       => s_axi_csr_bresp,  
   s_axi_csr_bvalid      => s_axi_csr_bvalid, 
   s_axi_csr_bready      => s_axi_csr_bready, 
   s_axi_csr_araddr      => s_axi_csr_araddr, 
   s_axi_csr_arprot      => s_axi_csr_arprot, 
   s_axi_csr_arvalid     => s_axi_csr_arvalid,
   s_axi_csr_arready     => s_axi_csr_arready,
   s_axi_csr_rdata       => s_axi_csr_rdata,  
   s_axi_csr_rresp       => s_axi_csr_rresp,  
   s_axi_csr_rvalid      => s_axi_csr_rvalid, 
   s_axi_csr_rready      => s_axi_csr_rready, 
--------------------------------------------------------------------------------
-- Control Register Outputs
--------------------------------------------------------------------------------
   ctl0_out           => ctl0_out ,
   ctl1_out           => ctl1_out ,
   ctl2_out           => ctl2_out ,
   ctl3_out           => ctl3_out ,
   ctl4_out           => ctl4_out ,
   ctl5_out           => ctl5_out ,
   ctl6_out           => ctl6_out ,
   ctl7_out           => ctl7_out ,
   ctl8_out           => ctl8_out ,
   ctl9_out           => ctl9_out ,
   ctl10_out          => ctl10_out,
   ctl11_out          => ctl11_out,
   ctl12_out          => ctl12_out,
   ctl13_out          => ctl13_out,
   ctl14_out          => ctl14_out,
   ctl15_out          => ctl15_out,
   ctl16_out          => ctl16_out, -- Not used in this configuration
   ctl17_out          => ctl17_out, -- Not used in this configuration
   ctl18_out          => ctl18_out, -- Not used in this configuration
   ctl19_out          => ctl19_out, -- Not used in this configuration
   ctl20_out          => ctl20_out, -- Not used in this configuration
   ctl21_out          => ctl21_out, -- Not used in this configuration
   ctl22_out          => ctl22_out, -- Not used in this configuration
   ctl23_out          => ctl23_out, -- Not used in this configuration
   ctl24_out          => ctl24_out, -- Not used in this configuration
   ctl25_out          => ctl25_out, -- Not used in this configuration
   ctl26_out          => ctl26_out, -- Not used in this configuration
   ctl27_out          => ctl27_out, -- Not used in this configuration
   ctl28_out          => ctl28_out, -- Not used in this configuration
--------------------------------------------------------------------------------
-- Status Register Inputs
--------------------------------------------------------------------------------
   stat0_in           => stat0_in,  -- Used to Initialize Control Register in the configuration 
   stat1_in           => stat1_in,  -- Used to Initialize Control Register in the configuration 
   stat2_in           => stat2_in,  -- Used to Initialize Control Register in the configuration 
   stat3_in           => stat3_in,  -- Used to Initialize Control Register in the configuration 
   stat4_in           => stat4_in,  -- Used to Initialize Control Register in the configuration 
   stat5_in           => stat5_in,  -- Used to Initialize Control Register in the configuration 
   stat6_in           => stat6_in,  -- Used to Initialize Control Register in the configuration 
   stat7_in           => stat7_in,  -- Used to Initialize Control Register in the configuration 
   stat8_in           => stat8_in,  -- Used to Initialize Control Register in the configuration 
   stat9_in           => stat9_in,  -- Used to Initialize Control Register in the configuration 
   stat10_in          => stat10_in, -- Used to Initialize Control Register in the configuration 
   stat11_in          => stat11_in, -- Used to Initialize Control Register in the configuration 
   stat12_in          => stat12_in, -- Used to Initialize Control Register in the configuration 
   stat13_in          => stat13_in, -- Used to Initialize Control Register in the configuration 
   stat14_in          => stat14_in, -- Used to Initialize Control Register in the configuration 
   stat15_in          => stat15_in, -- Used to Initialize Control Register in the configuration 
   stat16_in          => stat16_in,
   stat17_in          => stat17_in,
   stat18_in          => stat18_in,
   stat19_in          => stat19_in,
   stat20_in          => stat20_in,
   stat21_in          => stat21_in,
   stat22_in          => stat22_in,
   stat23_in          => stat23_in,
   stat24_in          => stat24_in,
   stat25_in          => stat25_in,
   stat26_in          => stat26_in,
   stat27_in          => stat27_in,
   stat28_in          => stat28_in,   
--------------------------------------------------------------------------------
-- Interrupt
--------------------------------------------------------------------------------
   intrpt_src_in     => intrpt_src_in,    
   irq               => irq             
);

--------------------------------------------------------------------------------
-- Generate Clocks
--------------------------------------------------------------------------------

-- CSR Clock = 250MHz
process
begin
    loop
        s_axi_csr_aclk <= not s_axi_csr_aclk;
        wait for 2 ns;
    end loop;
end process;


test_process: process
variable c_time : time    := 0 ns;
variable d_time : time    := 0 ns;
variable x      : integer := 5;

begin
   wait for 400 ns;
   wait until rising_edge(s_axi_csr_aclk);
   s_axi_csr_aresetn <= '1';
   wait for 40 ns;
   c_time := now;
   -----------------------------------------------------------------------------
   -- Test Control Registers
   -----------------------------------------------------------------------------

      assert false
      report "Writing to Control Registers. Start Time = " & time'image(now) 
      severity NOTE;
      for i in 0 to 15 loop
         px_axi_lite_writer(conv_std_logic_vector(i*4,7),conv_std_logic_vector(i,32), s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
      end loop;
      
    
      d_time := now - c_time; 
      assert false
      report "Finished Writing the Control Registers. End Time = " & time'image(now) 
      severity NOTE;
      assert false
      report "Total Time = " & time'image(d_time) 
      severity NOTE;  
   
      c_time := now; 
      assert false
      report "Reading Back and Verifying Control Registers. Start Time = " & time'image(now) 
      severity NOTE;    
      for i in 0 to 15 loop
         px_axi_lite_reader(conv_std_logic_vector(i*4,7), conv_std_logic_vector(i,32),'1', '1', s_axi_csr_aclk, s_axi_csr_araddr, s_axi_csr_arprot, s_axi_csr_arvalid, s_axi_csr_arready, s_axi_csr_rdata, s_axi_csr_rresp, s_axi_csr_rvalid, s_axi_csr_rready);
      end loop;

      
      d_time := now - c_time; 
      assert false
      report "Finished Reading and verifying the Control Registers. End Time = " & time'image(now) 
      severity NOTE;
      assert false
      report "Total Time = " & time'image(d_time) 
      severity NOTE;  


   -----------------------------------------------------------------------------
   -- Test Status Registers
   -----------------------------------------------------------------------------

         c_time := now; 
         assert false
         report "Reading and Verifying Status Registers. Start Time = " & time'image(now) 
         severity NOTE;    
         for i in 0 to 12 loop
            px_axi_lite_reader(conv_std_logic_vector((16*4)+(i*4),7), (conv_std_logic_vector(i,32)),'1', '1', s_axi_csr_aclk, s_axi_csr_araddr, s_axi_csr_arprot, s_axi_csr_arvalid, s_axi_csr_arready, s_axi_csr_rdata, s_axi_csr_rresp, s_axi_csr_rvalid, s_axi_csr_rready);
         end loop;
   
         
         d_time := now - c_time; 
         assert false
         report "Finished Reading and Verifying the Status Registers. End Time = " & time'image(now) 
         severity NOTE;
         assert false
         report "Total Time = " & time'image(d_time) 
         severity NOTE;  

   -----------------------------------------------------------------------------
   -- Test Interrupt Registers
   -----------------------------------------------------------------------------

      assert false
      report "Writing to Interrupt Enable Register. Setting all Interrupts Enabled. Start Time = " & time'image(now) 
      severity NOTE;
      px_axi_lite_writer(conv_std_logic_vector((29*4),7),x"FFFFFFFF", s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);    
    
      d_time := now - c_time; 
      assert false
      report "Finished Writing to Interrupt Enable Register. End Time = " & time'image(now) 
      severity NOTE;
      assert false
      report "Total Time = " & time'image(d_time) 
      severity NOTE;  
   
      c_time := now; 
      assert false
      report "Reading Back and Verifying Interrupt Enable Register. Start Time = " & time'image(now) 
      severity NOTE;    
      px_axi_lite_reader(conv_std_logic_vector((29*4),7),x"FFFFFFFF",'1', '1', s_axi_csr_aclk, s_axi_csr_araddr, s_axi_csr_arprot, s_axi_csr_arvalid, s_axi_csr_arready, s_axi_csr_rdata, s_axi_csr_rresp, s_axi_csr_rvalid, s_axi_csr_rready);

      d_time := now - c_time; 
      assert false
      report "Finished Reading and Verifying the Interrupt Enable Register. End Time = " & time'image(now) 
      severity NOTE;
      assert false
      report "Total Time = " & time'image(d_time) 
      severity NOTE;  
      
      assert false
      report "Clearing the Interrupt Flag Register. Start Time = " & time'image(now) 
      severity NOTE;
      px_axi_lite_writer(conv_std_logic_vector((31*4),7),x"FFFFFFFF", s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);    
      
      d_time := now - c_time; 
      assert false
      report "Finished Clearing the Interrupt Flag Register. End Time = " & time'image(now) 
      severity NOTE;
      assert false
      report "Total Time = " & time'image(d_time) 
      severity NOTE;  
      
      c_time := now; 
      assert false
      report "Reading Back and Verifying Interrupt Flag Register is Cleared. Start Time = " & time'image(now) 
      severity NOTE;    
      px_axi_lite_reader(conv_std_logic_vector((31*4),7),x"00000000",'1', '1', s_axi_csr_aclk, s_axi_csr_araddr, s_axi_csr_arprot, s_axi_csr_arvalid, s_axi_csr_arready, s_axi_csr_rdata, s_axi_csr_rresp, s_axi_csr_rvalid, s_axi_csr_rready);

      d_time := now - c_time; 
      assert false
      report "Finished Reading and Verifying the Interrupt Flag Register is Cleared. End Time = " & time'image(now) 
      severity NOTE;
      assert false
      report "Total Time = " & time'image(d_time) 
      severity NOTE;  
      
      -- Set an Interrupt
      wait until rising_edge(s_axi_csr_aclk);
      wait for 0.5 ns;
      intrpt_src_in(0) <= '1';
      x := 10;
      while ((x /= 0) and (irq = '0')) loop
         wait until rising_edge(s_axi_csr_aclk);
         x := x -1;
         if (x = 0) then
            assert false
            report "Failure. Interrupt Output Did Not Occur!" 
            severity FAILURE;
         end if;
      end loop;
      
      wait until rising_edge(s_axi_csr_aclk);
      wait for 0.5 ns;
      intrpt_src_in(0) <= '0';
      
      c_time := now; 
      assert false
      report "Reading Back and Verifying Interrupt Flag Register is Set. Start Time = " & time'image(now) 
      severity NOTE;    
      px_axi_lite_reader(conv_std_logic_vector((31*4),7),x"00000001", '1', '1', s_axi_csr_aclk, s_axi_csr_araddr, s_axi_csr_arprot, s_axi_csr_arvalid, s_axi_csr_arready, s_axi_csr_rdata, s_axi_csr_rresp, s_axi_csr_rvalid, s_axi_csr_rready);
      
      d_time := now - c_time; 
      assert false
      report "Finished Reading and Verifying the Interrupt Flag Register is Set. End Time = " & time'image(now) 
      severity NOTE;
      assert false
      report "Total Time = " & time'image(d_time) 
      severity NOTE;  
      
      assert false
      report "Clearing the Interrupt Flag Register. Start Time = " & time'image(now) 
      severity NOTE;
      px_axi_lite_writer(conv_std_logic_vector((31*4),7),x"00000001",  s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);    
      
      d_time := now - c_time; 
      assert false
      report "Finished Clearing the Interrupt Flag Register. End Time = " & time'image(now) 
      severity NOTE;
      assert false
      report "Total Time = " & time'image(d_time) 
      severity NOTE;  
      
      c_time := now; 
      assert false
      report "Reading Back and Verifying Interrupt Flag Register is Cleared. Start Time = " & time'image(now) 
      severity NOTE;    
      px_axi_lite_reader(conv_std_logic_vector((31*4),7),x"00000000", '1', '1', s_axi_csr_aclk, s_axi_csr_araddr, s_axi_csr_arprot, s_axi_csr_arvalid, s_axi_csr_arready, s_axi_csr_rdata, s_axi_csr_rresp, s_axi_csr_rvalid, s_axi_csr_rready);

      d_time := now - c_time; 
      assert false
      report "Finished Reading and Verifying the Interrupt Flag Register is Cleared. End Time = " & time'image(now) 
      severity NOTE;
      assert false
      report "Total Time = " & time'image(d_time) 
      severity NOTE;  


   
   
   
   assert false
   report "Test Complete, Not A Failure." 
   severity FAILURE;  
   wait; 
end process;

end Behavioral;
