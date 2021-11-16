----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/31/2015 06:09:44 PM
-- Design Name: 
-- Module Name: tb_px_axil_csr - Behavioral
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

entity tb_px_axil_csr is
generic (
   num_ctl_regs      : integer := 8; -- Number of Control Registers - 0 through 8
   num_stat_regs     : integer := 8; -- Number of Status Registers - 0 through 8
   has_interrupt_regs: boolean := true; -- Has Interrupt Registers 
   num_interrupt_src : integer := 16 -- Number of Interrupt Source bits - 0 to 32 
);
end tb_px_axil_csr;

architecture Behavioral of tb_px_axil_csr is

--------------------------------------------------------------------------------
-- Components
--------------------------------------------------------------------------------

component px_axil_csr
generic (
   num_ctl_regs      : integer := 8; -- Number of Control Registers - 0 through 8
   num_stat_regs     : integer := 8; -- Number of Status Registers - 0 through 8
   has_interrupt_regs: boolean := true; -- Has Interrupt Registers
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
   s_axi_csr_wstrb     : in  std_logic_vector(3 downto 0); 
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
   irq             : out std_logic
);
end component;

--------------------------------------------------------------------------------
-- Constants
--------------------------------------------------------------------------------
constant num_addr_bits: integer := 7; 
--------------------------------------------------------------------------------

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
-- Control Register Init Values
-------------------------------------------------------------------------------- 
signal  reg0_init_val   : std_logic_vector(31 downto 0) := x"00000000";
signal  reg1_init_val   : std_logic_vector(31 downto 0) := x"00000000";
signal  reg2_init_val   : std_logic_vector(31 downto 0) := x"00000000";
signal  reg3_init_val   : std_logic_vector(31 downto 0) := x"00000000";
signal  reg4_init_val   : std_logic_vector(31 downto 0) := x"00000000";
signal  reg5_init_val   : std_logic_vector(31 downto 0) := x"00000000";
signal  reg6_init_val   : std_logic_vector(31 downto 0) := x"00000000";
signal  reg7_init_val   : std_logic_vector(31 downto 0) := x"00000000";   
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
--------------------------------------------------------------------------------
-- Status Register Inputs
--------------------------------------------------------------------------------
signal  stat0_in        : std_logic_vector(31 downto 0) := x"00000000";
signal  stat1_in        : std_logic_vector(31 downto 0) := x"10000000";
signal  stat2_in        : std_logic_vector(31 downto 0) := x"20000000";
signal  stat3_in        : std_logic_vector(31 downto 0) := x"30000000";
signal  stat4_in        : std_logic_vector(31 downto 0) := x"40000000";
signal  stat5_in        : std_logic_vector(31 downto 0) := x"50000000";
signal  stat6_in        : std_logic_vector(31 downto 0) := x"60000000";
signal  stat7_in        : std_logic_vector(31 downto 0) := x"70000000";  
--------------------------------------------------------------------------------
-- Interrupt
--------------------------------------------------------------------------------
signal  intrpt_src_in   : std_logic_vector(num_interrupt_src-1 downto 0) := (others => '0');        
signal  irq             : std_logic;


--------------------------------------------------------------------------------

begin

uut: px_axil_csr
generic map (
   num_ctl_regs      => num_ctl_regs,       -- Number of Control Registers - 0 through 8
   num_stat_regs     => num_stat_regs,      -- Number of Status Registers - 0 through 8
   has_interrupt_regs=> has_interrupt_regs, -- Has Interrupt Registers
   num_interrupt_src => num_interrupt_src  -- Number of Interrupt Source bits - 0 to 32 
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
-- Control Register Init Values
-------------------------------------------------------------------------------- 
   reg0_init_val     => reg0_init_val,
   reg1_init_val     => reg1_init_val,
   reg2_init_val     => reg2_init_val,
   reg3_init_val     => reg3_init_val,
   reg4_init_val     => reg4_init_val,
   reg5_init_val     => reg5_init_val,
   reg6_init_val     => reg6_init_val,
   reg7_init_val     => reg7_init_val,
--------------------------------------------------------------------------------
-- Control Register Outputs
--------------------------------------------------------------------------------
   ctl0_out          => ctl0_out,
   ctl1_out          => ctl1_out,
   ctl2_out          => ctl2_out,
   ctl3_out          => ctl3_out,
   ctl4_out          => ctl4_out,
   ctl5_out          => ctl5_out,
   ctl6_out          => ctl6_out,
   ctl7_out          => ctl7_out,
--------------------------------------------------------------------------------
-- Status Register Inputs
--------------------------------------------------------------------------------
   stat0_in          => stat0_in,
   stat1_in          => stat1_in,
   stat2_in          => stat2_in,
   stat3_in          => stat3_in,
   stat4_in          => stat4_in,
   stat5_in          => stat5_in,
   stat6_in          => stat6_in,
   stat7_in          => stat7_in,
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
   if (num_ctl_regs /= 0) then
      assert false
      report "Writing to Control Registers. Start Time = " & time'image(now) 
      severity NOTE;
      for i in 0 to (num_ctl_regs-1) loop
         px_axi_lite_writer(conv_std_logic_vector(i*4,num_addr_bits),conv_std_logic_vector(i,32), s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
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
      for i in 0 to (num_ctl_regs-1) loop
         px_axi_lite_reader(conv_std_logic_vector(i*4,num_addr_bits), conv_std_logic_vector(i,32),'1', '1', s_axi_csr_aclk, s_axi_csr_araddr, s_axi_csr_arprot, s_axi_csr_arvalid, s_axi_csr_arready, s_axi_csr_rdata, s_axi_csr_rresp, s_axi_csr_rvalid, s_axi_csr_rready);
      end loop;

      
      d_time := now - c_time; 
      assert false
      report "Finished Reading and verifying the Control Registers. End Time = " & time'image(now) 
      severity NOTE;
      assert false
      report "Total Time = " & time'image(d_time) 
      severity NOTE;  

    end if;
   -----------------------------------------------------------------------------
   -- Test Status Registers
   -----------------------------------------------------------------------------
   if (num_stat_regs /= 0) then
   
   
         c_time := now; 
         assert false
         report "Reading and Verifying Status Registers. Start Time = " & time'image(now) 
         severity NOTE;    
         for i in 0 to (num_stat_regs-1) loop
            px_axi_lite_reader(conv_std_logic_vector((num_ctl_regs*4)+(i*4),num_addr_bits), (conv_std_logic_vector(i,4) & x"0000000"),'1', '1', s_axi_csr_aclk, s_axi_csr_araddr, s_axi_csr_arprot, s_axi_csr_arvalid, s_axi_csr_arready, s_axi_csr_rdata, s_axi_csr_rresp, s_axi_csr_rvalid, s_axi_csr_rready);
         end loop;
   
         
         d_time := now - c_time; 
         assert false
         report "Finished Reading and Verifying the Status Registers. End Time = " & time'image(now) 
         severity NOTE;
         assert false
         report "Total Time = " & time'image(d_time) 
         severity NOTE;  
   
   end if;
   -----------------------------------------------------------------------------
   -- Test Interrupt Registers
   -----------------------------------------------------------------------------
   if (has_interrupt_regs /= false) then
      assert false
      report "Writing to Interrupt Enable Register. Setting all Interrupts Enabled. Start Time = " & time'image(now) 
      severity NOTE;
      px_axi_lite_writer(conv_std_logic_vector((num_ctl_regs*4)+(num_stat_regs*4),num_addr_bits),x"FFFFFFFF", s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);    
    
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
      px_axi_lite_reader(conv_std_logic_vector((num_ctl_regs*4)+(num_stat_regs*4),num_addr_bits),x"FFFFFFFF",'1', '1', s_axi_csr_aclk, s_axi_csr_araddr, s_axi_csr_arprot, s_axi_csr_arvalid, s_axi_csr_arready, s_axi_csr_rdata, s_axi_csr_rresp, s_axi_csr_rvalid, s_axi_csr_rready);

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
      px_axi_lite_writer(conv_std_logic_vector((num_ctl_regs*4)+(num_stat_regs*4)+8,num_addr_bits),x"FFFFFFFF", s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);    
      
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
      px_axi_lite_reader(conv_std_logic_vector((num_ctl_regs*4)+(num_stat_regs*4)+8,num_addr_bits),x"00000000",'1', '1', s_axi_csr_aclk, s_axi_csr_araddr, s_axi_csr_arprot, s_axi_csr_arvalid, s_axi_csr_arready, s_axi_csr_rdata, s_axi_csr_rresp, s_axi_csr_rvalid, s_axi_csr_rready);

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
      px_axi_lite_reader(conv_std_logic_vector((num_ctl_regs*4)+(num_stat_regs*4)+8,num_addr_bits),x"00000001",'1', '1', s_axi_csr_aclk, s_axi_csr_araddr, s_axi_csr_arprot, s_axi_csr_arvalid, s_axi_csr_arready, s_axi_csr_rdata, s_axi_csr_rresp, s_axi_csr_rvalid, s_axi_csr_rready);
      
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
      px_axi_lite_writer(conv_std_logic_vector((num_ctl_regs*4)+(num_stat_regs*4)+8,num_addr_bits),x"00000001", s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);    
      
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
      px_axi_lite_reader(conv_std_logic_vector((num_ctl_regs*4)+(num_stat_regs*4)+8,num_addr_bits),x"00000000",'1', '1', s_axi_csr_aclk, s_axi_csr_araddr, s_axi_csr_arprot, s_axi_csr_arvalid, s_axi_csr_arready, s_axi_csr_rdata, s_axi_csr_rresp, s_axi_csr_rvalid, s_axi_csr_rready);

      d_time := now - c_time; 
      assert false
      report "Finished Reading and Verifying the Interrupt Flag Register is Cleared. End Time = " & time'image(now) 
      severity NOTE;
      assert false
      report "Total Time = " & time'image(d_time) 
      severity NOTE;  

      
   end if;
   
   
   
   assert false
   report "Test Complete, Not A Failure." 
   severity FAILURE;  
   wait; 
end process;

end Behavioral;
