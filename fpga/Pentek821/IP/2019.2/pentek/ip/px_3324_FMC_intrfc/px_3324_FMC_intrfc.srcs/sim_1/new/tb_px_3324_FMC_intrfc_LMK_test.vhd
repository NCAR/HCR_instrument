----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/14/2018 10:21 AM
-- Design Name: 
-- Module Name: tb_px_3324_FMC_intrfc_LMK_test - Behavioral
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


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use work.px_utility_pkg.ALL; -- Pentek Utility Package

library UNISIM;
use UNISIM.VComponents.all;

entity tb_px_3324_FMC_intrfc_LMK_test is
end tb_px_3324_FMC_intrfc_LMK_test;

architecture Behavioral of tb_px_3324_FMC_intrfc_LMK_test is

--------------------------------------------------------------------------------
-- Component
--------------------------------------------------------------------------------

component px_3324_FMC_intrfc_top
port (
   --------------------------------------------------------------------------------
   -- AXI LITE Slave Interface  
   --------------------------------------------------------------------------------
   s_axi_csr_aclk          : in  std_logic;                         
   s_axi_csr_araddr        : in  std_logic_vector ( 6 downto 0 );
   s_axi_csr_aresetn       : in  std_logic;
   s_axi_csr_arprot        : in  std_logic_vector ( 2 downto 0 );
   s_axi_csr_arready       : out std_logic;
   s_axi_csr_arvalid       : in  std_logic;
   s_axi_csr_awaddr        : in  std_logic_vector ( 6 downto 0 );
   s_axi_csr_awprot        : in  std_logic_vector ( 2 downto 0 );
   s_axi_csr_awready       : out std_logic;
   s_axi_csr_awvalid       : in  std_logic;
   s_axi_csr_bready        : in  std_logic;
   s_axi_csr_bresp         : out std_logic_vector ( 1 downto 0 );
   s_axi_csr_bvalid        : out std_logic;
   s_axi_csr_rdata         : out std_logic_vector ( 31 downto 0 );
   s_axi_csr_rready        : in  std_logic;
   s_axi_csr_rresp         : out std_logic_vector ( 1 downto 0 );
   s_axi_csr_rvalid        : out std_logic;
   s_axi_csr_wdata         : in  std_logic_vector ( 31 downto 0 );
   s_axi_csr_wready        : out std_logic;
   s_axi_csr_wstrb         : in  std_logic_vector ( 3 downto 0 );
   s_axi_csr_wvalid        : in  std_logic;
 
   --------------------------------------------------------------------------------
   -- System Level Clock and Reset  
   --------------------------------------------------------------------------------
   PCIE_CLK                : in  std_logic;
   LRST_N                  : in  std_logic;

   ----------------------------------------------------------------------------
   -- TWSI Serial Bus
   ----------------------------------------------------------------------------
   TWSI_SDA                : inout std_logic;
   TWSI_SCL                : inout std_logic;
   
   TRNS_DONE_INT           : out std_logic;  -- Transfer Done Interrupt
   NO_ACK_INT              : out std_logic;  -- No Acknowledge Interrupt

   
   -----------------------------------------------------------------------------
   -- SPI  Serial Bus
   -----------------------------------------------------------------------------
   SDIO                    : inout std_logic;
   SDENB                   : out std_logic_vector(4 downto 0);
   SCLK                    : out std_logic;
   SDO                     : in  std_logic_vector(4 downto 0);
   
   ----------------------------------------------------------------------------
   -- LMK04828B Control and Status
   ----------------------------------------------------------------------------
   INT_REF_SEL             : out std_logic;
   JESD_RESET_GPO          : out std_logic;
   PLL1_CLKIN_SEL0         : out std_logic;
   PLL1_CLKIN_SEL1         : out std_logic;
   PLL1_REF_ENAB           : out std_logic;
   PLL2_REF_ENAB           : out std_logic;
   GATE_B_SEL              : out std_logic;
   SYSREF_SYNC             : out std_logic;
   STATUS_LD1              : in std_logic;
   STATUS_LD2              : in std_logic
 );
end component;


signal   s_axi_csr_aclk     :  std_logic := '0';                         
signal   s_axi_csr_araddr   :  std_logic_vector ( 6 downto 0 ) := (others => '0');
signal   s_axi_csr_aresetn  :  std_logic := '0';
signal   s_axi_csr_arprot   :  std_logic_vector ( 2 downto 0 ) := (others => '0');
signal   s_axi_csr_arready  :  std_logic;
signal   s_axi_csr_arvalid  :  std_logic := '0';
signal   s_axi_csr_awaddr   :  std_logic_vector ( 6 downto 0 ) := (others => '0');
signal   s_axi_csr_awprot   :  std_logic_vector ( 2 downto 0 ) := (others => '0');
signal   s_axi_csr_awready  :  std_logic;
signal   s_axi_csr_awvalid  :  std_logic := '0';
signal   s_axi_csr_bready   :  std_logic := '0';
signal   s_axi_csr_bresp    :  std_logic_vector ( 1 downto 0 );
signal   s_axi_csr_bvalid   :  std_logic;
signal   s_axi_csr_rdata    :  std_logic_vector ( 31 downto 0 );
signal   s_axi_csr_rready   :  std_logic := '0';
signal   s_axi_csr_rresp    :  std_logic_vector ( 1 downto 0 );
signal   s_axi_csr_rvalid   :  std_logic;
signal   s_axi_csr_wdata    :  std_logic_vector ( 31 downto 0 ) := (others => '0');
signal   s_axi_csr_wready   :  std_logic;
signal   s_axi_csr_wstrb    :  std_logic_vector ( 3 downto 0 ) := (others => '0');
signal   s_axi_csr_wvalid   :  std_logic := '0';
signal   PCIE_CLK           :  std_logic := '0';
signal   LRST_N             :  std_logic := '0';
signal   TWSI_SDA           :  std_logic := 'Z';
signal   TWSI_SCL           :  std_logic := 'Z';   
signal   TRNS_DONE_INT      :  std_logic;  -- Transfer Done Interrupt
signal   NO_ACK_INT         :  std_logic;  -- No Acknowledge Interrupt
signal   SDIO               :  std_logic;
signal   SDENB              :  std_logic_vector(4 downto 0);
signal   SCLK               :  std_logic;
signal   SDO                :  std_logic_vector(4 downto 0) := (others => '0');
signal   INT_REF_SEL        :  std_logic;
signal   JESD_RESET_GPO     :  std_logic;
signal   PLL1_CLKIN_SEL0    :  std_logic;
signal   PLL1_CLKIN_SEL1    :  std_logic;
signal   PLL1_REF_ENAB      :  std_logic;
signal   PLL2_REF_ENAB      :  std_logic;
signal   GATE_B_SEL         :  std_logic;
signal   SYSREF_SYNC        :  std_logic;
signal   STATUS_LD1         :  std_logic := '0';
signal   STATUS_LD2         :  std_logic := '0';

--------------------------------------------------------------------------------   
-- Constants
--------------------------------------------------------------------------------
-- Control/Status Register Addresses
constant LMK_CTRL_REG_ADDR       : std_logic_vector(6 downto 0) := "0011000";  -- 0x18
constant LMK_STATUS_REG_ADDR     : std_logic_vector(6 downto 0) := "0101100";  -- 0x2C

-- Define 1/2 Clock Period
constant clk_in_half_p      : time := 2.0 ns;

--------------------------------------------------------------------------------

begin

--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--                                                                                                                --
--          ******************* Normal Testbench Runtime: 12620 ns *******************                            --
--                                                                                                                --
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--                                                                                                                --
--                                        Testbench Set-up                                                        --
--                                                                                                                --
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Generate Clocks
--------------------------------------------------------------------------------

-- PCIE_clk - 250MHz
process
begin
    loop
        PCIE_clk <= not PCIE_clk;
        wait for clk_in_half_p;
    end loop;
end process;

-- s_axi_csr_aclk 250MHz
process
begin
   loop
      s_axi_csr_aclk <= not s_axi_csr_aclk;
      wait for clk_in_half_p;
   end loop;
end process;



LMK_CTRL_SIGNAL_TEST : process
begin
   wait for 100 ns;
   LRST_N <= '1';
   wait for 200 ns;
   wait until rising_edge(s_axi_csr_aclk);
   s_axi_csr_aresetn <= '1';
   wait for 200 ns;
   wait until rising_edge(s_axi_csr_aclk);
   wait until rising_edge(s_axi_csr_aclk);
   
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--                                                                                                                --
--                                           LMK Control Register Test                                                 --
--                                                                                                                --
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
-- 0x18 - LMK Control
--           Bit 0 - LMK CLKIN_SEL0
--           Bit 1 - LMK CLKIN_SEL1
--           Bits 3:2 - RESERVED
--           Bit 4 - LMK Reset (active HIGH)
--           Bit 5 - LMK Reference Slect: 0 = EXTERNAL, 1 = INTERNAL
--           Bit 6 - PLL1 Reference Enable <NOT USED on 33240 FMC>
--           Bit 7 - PLL2 Reference Enable
--           Bit 8 - GATE_B_SEL
--           Bit 9 - SYSREF_SYNC
--           Bits 31:10 - RESERVED

    assert false   
    report ">>>>>>>>>>>>>> Set and check CLKIN_SEL0 (PLL1_CLKIN_SEL0), LMK Reset (JESD_RESET_GPO), PLL1 Reference Enable (PLL1_REF_ENAB) and GATE_B_SEL."   
    severity NOTE;

    px_axi_lite_writer(
        LMK_CTRL_REG_ADDR,
        (x"00000" & "000101010001" ), 
        s_axi_csr_aclk,
        s_axi_csr_awaddr,  
        s_axi_csr_awprot,  
        s_axi_csr_awvalid, 
        s_axi_csr_awready, 
        s_axi_csr_wdata,   
        s_axi_csr_wstrb,   
        s_axi_csr_wvalid,  
        s_axi_csr_wready,  
        s_axi_csr_bresp,   
        s_axi_csr_bvalid,  
        s_axi_csr_bready  
        );
          
    wait for 1 us;

    assert false   
    report ">>>>>>>>>>>>>> Verifying the CLKIN_SEL0, LMK Reset, PLL1 Reference Enable and GATE_B_SEL outputs are set."   
    severity NOTE;

    if PLL1_CLKIN_SEL0 = '0' then
       assert false   
       report "!!!!!!!!!!!!!!!> FAILED: CLKIN_SEL0 (PLL1_CLKIN_SEL0) did not get set!."   
       severity FAILURE;
    elsif JESD_RESET_GPO = '0' then
       assert false   
       report "!!!!!!!!!!!!!!!> FAILED: LMK Reset (JESD_RESET_GPO) did not get set!."   
       severity FAILURE;
    elsif PLL1_REF_ENAB = '0' then
       assert false   
       report "!!!!!!!!!!!!!!!> FAILED: PLL1 Reference Enable (PLL1_REF_ENAB) did not get set!."   
       severity FAILURE;
    elsif GATE_B_SEL = '0' then
       assert false   
       report "!!!!!!!!!!!!!!!> FAILED: GATE_B_SEL did not get set!."   
       severity FAILURE;
    else
       assert false   
       report ">>>>>>>>>>>>>> CLKIN_SEL0, LMK Reset, PLL1 Reference Enable and GATE_B_SEL output tests PASS."   
       severity NOTE;
    end if;
          
    wait for 1 us;

-- 0x18 - LMK Control
--           Bit 0 - LMK CLKIN_SEL0
--           Bit 1 - LMK CLKIN_SEL1
--           Bits 3:2 - RESERVED
--           Bit 4 - LMK Reset (active HIGH)
--           Bit 5 - LMK Reference Slect: 0 = EXTERNAL, 1 = INTERNAL
--           Bit 6 - PLL1 Reference Enable <NOT USED on 33240 FMC>
--           Bit 7 - PLL2 Reference Enable
--           Bit 8 - GATE_B_SEL
--           Bit 9 - SYSREF_SYNC
--           Bits 31:10 - RESERVED

    assert false   
    report ">>>>>>>>>>>>>> Set and check CLKIN_SEL1 (PLL1_CLKIN_SEL1), LMK Reference Slect (INT_REF_SEL), PLL2 Reference Enable (PLL2_REF_ENAB) and SYSREF_SYNC."   
    severity NOTE;

    px_axi_lite_writer(
        LMK_CTRL_REG_ADDR,
        (x"00000" &  "001010100010" ), 
        s_axi_csr_aclk,
        s_axi_csr_awaddr,  
        s_axi_csr_awprot,  
        s_axi_csr_awvalid, 
        s_axi_csr_awready, 
        s_axi_csr_wdata,   
        s_axi_csr_wstrb,   
        s_axi_csr_wvalid,  
        s_axi_csr_wready,  
        s_axi_csr_bresp,   
        s_axi_csr_bvalid,  
        s_axi_csr_bready  
        );
          
    wait for 1 us;

    assert false   
    report ">>>>>>>>>>>>>> Verifying the CLKIN_SEL1, LMK Reference Slect, PLL2 Reference Enable and SYSREF_SYNC outputs are set."   
    severity NOTE;

    if PLL1_CLKIN_SEL1 = '0' then
       assert false   
       report "!!!!!!!!!!!!!!!> FAILED: CLKIN_SEL1 (PLL1_CLKIN_SEL1) did not get set!."   
       severity FAILURE;
    elsif INT_REF_SEL = '0' then
       assert false   
       report "!!!!!!!!!!!!!!!> FAILED: LMK Reference Slect (INT_REF_SEL) did not get set!."   
       severity FAILURE;
    elsif PLL2_REF_ENAB = '0' then
       assert false   
       report "!!!!!!!!!!!!!!!> FAILED: PLL2 Reference Enable (PLL2_REF_ENAB) did not get set!."   
       severity FAILURE;
    elsif SYSREF_SYNC = '0' then
       assert false   
       report "!!!!!!!!!!!!!!!> FAILED: SYSREF_SYNC did not get set!."   
       severity FAILURE;
    else
       assert false   
       report ">>>>>>>>>>>>>> CLKIN_SEL1, LMK Reference Slect, PLL2 Reference Enable and SYSREF_SYNC output tests PASS."   
       severity NOTE;
    end if;


    wait for 1 us;

        
    assert false   
    report ">>>>>>>>>>>>>> Checking the LMK Status Register (First Check)..."   
    severity NOTE;     
        
    px_axi_lite_reader(
        LMK_STATUS_REG_ADDR,
        x"00000000", 
        '0',
        '0', 
        s_axi_csr_aclk,
        s_axi_csr_araddr,     
        s_axi_csr_arprot,     
        s_axi_csr_arvalid,    
        s_axi_csr_arready,    
        s_axi_csr_rdata,      
        s_axi_csr_rresp,      
        s_axi_csr_rvalid,     
        s_axi_csr_rready     
        );  
          
    wait for 1 us;
        
    if s_axi_csr_rdata /= x"00000000" then
       assert false   
       report "!!!!!!!!!!!!!!!> FIRST LMK STATUS REGISTER CHECK FAILED: expected 0x00000000, read 0x" & px_std_logic_vector_to_hstring(s_axi_csr_rdata) & "."   
       severity FAILURE;
    else
       assert false   
       report ">>>>>>>>>>>>>> First LMK STATUS REGISTER Check PASSED."   
       severity NOTE;
    end if;
 
    wait for 1 us;
    
    STATUS_LD1 <= '1';

    wait for 1 us;
            
    assert false   
    report ">>>>>>>>>>>>>> Checking the LMK Status Register (Second Check)..."   
    severity NOTE;     
        
    px_axi_lite_reader(
        LMK_STATUS_REG_ADDR,
        x"00000001", 
        '0',
        '0', 
        s_axi_csr_aclk,
        s_axi_csr_araddr,     
        s_axi_csr_arprot,     
        s_axi_csr_arvalid,    
        s_axi_csr_arready,    
        s_axi_csr_rdata,      
        s_axi_csr_rresp,      
        s_axi_csr_rvalid,     
        s_axi_csr_rready     
        );  
          
    wait for 1 us;
        
    if s_axi_csr_rdata /= x"00000001" then
       assert false   
       report "!!!!!!!!!!!!!!!> SECOND LMK STATUS REGISTER CHECK FAILED: expected 0x00000001, read 0x" & px_std_logic_vector_to_hstring(s_axi_csr_rdata) & "."   
       severity FAILURE;
    else
       assert false   
       report ">>>>>>>>>>>>>> Second LMK STATUS REGISTER Check PASSED."   
       severity NOTE;
    end if;
 
    wait for 1 us;
    
    STATUS_LD1 <= '0';
    STATUS_LD2 <= '1';
   
     wait for 1 us;
   
    assert false   
    report ">>>>>>>>>>>>>> Checking the LMK Status Register (Third Check)..."   
    severity NOTE;     
        
    px_axi_lite_reader(
        LMK_STATUS_REG_ADDR,
        x"00000002", 
        '0',
        '0', 
        s_axi_csr_aclk,
        s_axi_csr_araddr,     
        s_axi_csr_arprot,     
        s_axi_csr_arvalid,    
        s_axi_csr_arready,    
        s_axi_csr_rdata,      
        s_axi_csr_rresp,      
        s_axi_csr_rvalid,     
        s_axi_csr_rready     
        );  
          
    wait for 1 us;
        
    if s_axi_csr_rdata /= x"00000002" then
       assert false   
       report "!!!!!!!!!!!!!!!> THIRD LMK STATUS REGISTER CHECK FAILED: expected 0x00000002, read 0x" & px_std_logic_vector_to_hstring(s_axi_csr_rdata) & "."   
       severity FAILURE;
    else
       assert false   
       report ">>>>>>>>>>>>>> Third LMK STATUS REGISTER Check PASSED."   
       severity NOTE;
    end if;
   
           
    wait for 1 us;

  
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--                                                                                                                --
--                            End of LMK Control Register Tests - Report Status                                   --
--                                                                                                                --
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
    
    assert false
    report ">>>>>>>>>>>>>>******* NOT A FAILURE: All LMK Control Register Tests Completed with No Errors. Time = " & time'image(now)
    severity FAILURE;
--    severity NOTE;
   
end process;

--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--                                                                                                                --
--                                 --  Core Under Test Instantiation --                                           --
--                                                                                                                --
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------


uut : px_3324_FMC_intrfc_top
   port map(
   s_axi_csr_aclk     =>   s_axi_csr_aclk,
   s_axi_csr_araddr   =>   s_axi_csr_araddr ,
   s_axi_csr_aresetn  =>   s_axi_csr_aresetn,
   s_axi_csr_arprot   =>   s_axi_csr_arprot,
   s_axi_csr_arready  =>   s_axi_csr_arready,
   s_axi_csr_arvalid  =>   s_axi_csr_arvalid,
   s_axi_csr_awaddr   =>   s_axi_csr_awaddr,
   s_axi_csr_awprot   =>   s_axi_csr_awprot,
   s_axi_csr_awready  =>   s_axi_csr_awready,
   s_axi_csr_awvalid  =>   s_axi_csr_awvalid,
   s_axi_csr_bready   =>   s_axi_csr_bready,
   s_axi_csr_bresp    =>   s_axi_csr_bresp,
   s_axi_csr_bvalid   =>   s_axi_csr_bvalid ,
   s_axi_csr_rdata    =>   s_axi_csr_rdata,
   s_axi_csr_rready   =>   s_axi_csr_rready,
   s_axi_csr_rresp    =>   s_axi_csr_rresp,
   s_axi_csr_rvalid   =>   s_axi_csr_rvalid,
   s_axi_csr_wdata    =>   s_axi_csr_wdata,
   s_axi_csr_wready   =>   s_axi_csr_wready,
   s_axi_csr_wstrb    =>   s_axi_csr_wstrb,
   s_axi_csr_wvalid   =>   s_axi_csr_wvalid,
   PCIE_CLK           =>   PCIE_CLK,
   LRST_N             =>   LRST_N,
   TWSI_SDA           =>   TWSI_SDA,
   TWSI_SCL           =>   TWSI_SCL,
   TRNS_DONE_INT      =>   TRNS_DONE_INT,
   NO_ACK_INT         =>   NO_ACK_INT,
   SDIO               =>   SDIO,
   SDENB              =>   SDENB,
   SCLK               =>   SCLK,
   SDO                =>   SDO,
   INT_REF_SEL        =>   INT_REF_SEL,
   JESD_RESET_GPO     =>   JESD_RESET_GPO,
   PLL1_CLKIN_SEL0    =>   PLL1_CLKIN_SEL0,
   PLL1_CLKIN_SEL1    =>   PLL1_CLKIN_SEL1,
   PLL1_REF_ENAB      =>   PLL1_REF_ENAB,
   PLL2_REF_ENAB      =>   PLL2_REF_ENAB,
   GATE_B_SEL         =>   GATE_B_SEL,
   SYSREF_SYNC        =>   SYSREF_SYNC,
   STATUS_LD1         =>   STATUS_LD1,
   STATUS_LD2         =>   STATUS_LD2
   );


end Behavioral;