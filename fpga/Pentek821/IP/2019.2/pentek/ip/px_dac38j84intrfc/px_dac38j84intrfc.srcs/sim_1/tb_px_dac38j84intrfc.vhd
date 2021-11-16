----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/15/2018 10:21 AM
-- Design Name: 
-- Module Name: tb_px_dac38j84intrfc - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

use work.px_utility_pkg.ALL; -- Pentek Utility Package

library UNISIM;
use UNISIM.VComponents.all;

entity tb_px_dac38j84intrfc is
end tb_px_dac38j84intrfc;

architecture Behavioral of tb_px_dac38j84intrfc is

--------------------------------------------------------------------------------
-- Component
--------------------------------------------------------------------------------

component px_dac38j84intrfc
port (
   ----------------------------------------------------------------------------
   -- Control/Status Registers (AXI4-LITE)
   ----------------------------------------------------------------------------
   s_axi_csr_aclk           : in  std_logic;
   s_axi_csr_aresetn        : in  std_logic;
   s_axi_csr_awaddr         : in  std_logic_vector(6 downto 0);
   s_axi_csr_awprot         : in  std_logic_vector(2 downto 0);
   s_axi_csr_awvalid        : in  std_logic;
   s_axi_csr_awready        : out std_logic;
   s_axi_csr_wdata          : in  std_logic_vector(31 downto 0);
   s_axi_csr_wstrb          : in  std_logic_vector(3 downto 0);
   s_axi_csr_wvalid         : in  std_logic;
   s_axi_csr_wready         : out std_logic;
   s_axi_csr_bresp          : out std_logic_vector(1 downto 0);
   s_axi_csr_bvalid         : out std_logic;
   s_axi_csr_bready         : in  std_logic;
   s_axi_csr_araddr         : in  std_logic_vector(6 downto 0);
   s_axi_csr_arprot         : in  std_logic_vector(2 downto 0);
   s_axi_csr_arvalid        : in  std_logic;
   s_axi_csr_arready        : out std_logic;
   s_axi_csr_rdata          : out std_logic_vector(31 downto 0);
   s_axi_csr_rresp          : out std_logic_vector(1 downto 0);
   s_axi_csr_rvalid         : out std_logic;
   s_axi_csr_rready         : in  std_logic;
    
   irq                      : out std_logic; -- interrupt
   ----------------------------------------------------------------------------
   -- Control Outputs
   ----------------------------------------------------------------------------
   dac_txena               : out std_logic;
   dac_sleep               : out std_logic;
   dac_resetb              : out std_logic;
   ----------------------------------------------------------------------------
   -- Status Inputs
   ----------------------------------------------------------------------------
   dac_alarm               : in  std_logic;
   ----------------------------------------------------------------------------
   -- Input Data Clock
   ----------------------------------------------------------------------------
   s_axis_dac_sample_clk    : in  std_logic;
   ----------------------------------------------------------------------------
   -- Input Data Busses
   ----------------------------------------------------------------------------
   s_axis_ch0_tx_tdata      : in std_logic_vector(63 downto 0);
   s_axis_ch0_tx_tvalid     : in std_logic;
   s_axis_ch1_tx_tdata      : in std_logic_vector(63 downto 0); 
   s_axis_ch1_tx_tvalid     : in std_logic;

   ----------------------------------------------------------------------------
   -- Output Data Busses
   ----------------------------------------------------------------------------
   m_axis_dac_tx_tdata    : out std_logic_vector(127 downto 0); 
   m_axis_dac_tx_tvalid   : out std_logic;
   m_axis_dac_tx_tready   : in  std_logic
);
end component;


signal   s_axi_csr_aclk          :  std_logic := '0';
signal   s_axi_csr_aresetn       :  std_logic := '0';
signal   s_axi_csr_awaddr        :  std_logic_vector(6 downto 0) := (others => '0');
signal   s_axi_csr_awprot        :  std_logic_vector(2 downto 0) := (others => '0');
signal   s_axi_csr_awvalid       :  std_logic := '0';
signal   s_axi_csr_awready       :  std_logic;
signal   s_axi_csr_wdata         :  std_logic_vector(31 downto 0) := (others => '0');
signal   s_axi_csr_wstrb         :  std_logic_vector(3 downto 0) := (others => '0');
signal   s_axi_csr_wvalid        :  std_logic := '0';
signal   s_axi_csr_wready        :  std_logic;
signal   s_axi_csr_bresp         :  std_logic_vector(1 downto 0);
signal   s_axi_csr_bvalid        :  std_logic;
signal   s_axi_csr_bready        :  std_logic := '0';
signal   s_axi_csr_araddr        :  std_logic_vector(6 downto 0) := (others => '0');
signal   s_axi_csr_arprot        :  std_logic_vector(2 downto 0) := (others => '0');
signal   s_axi_csr_arvalid       :  std_logic := '0';
signal   s_axi_csr_arready       :  std_logic;
signal   s_axi_csr_rdata         :  std_logic_vector(31 downto 0);
signal   s_axi_csr_rresp         :  std_logic_vector(1 downto 0);
signal   s_axi_csr_rvalid        :  std_logic;
signal   s_axi_csr_rready        :  std_logic := '0';        
signal   irq                     :  std_logic; 
signal   dac_txena               :  std_logic;
signal   dac_sleep               :  std_logic;
signal   dac_resetb              :  std_logic;
signal   dac_alarm               :  std_logic := '0';   
signal   s_axis_dac_sample_clk   :  std_logic := '0';
signal   s_axis_ch0_tx_tdata     :  std_logic_vector(63 downto 0) := (others => '0');
signal   s_axis_ch0_tx_tvalid    :  std_logic := '0';
signal   s_axis_ch1_tx_tdata     :  std_logic_vector(63 downto 0) := (others => '0');
signal   s_axis_ch1_tx_tvalid    :  std_logic := '0';
signal   m_axis_dac_tx_tdata     :  std_logic_vector(127 downto 0); 
signal   m_axis_dac_tx_tvalid    :  std_logic;
signal   m_axis_dac_tx_tready    :  std_logic := '0';

signal   m_axis_dac_data_test    :  std_logic_vector(127 downto 0) := (others => '0');


--------------------------------------------------------------------------------   
-- Constants
--------------------------------------------------------------------------------
-- Control/Status Register Address
constant DAC_CTRL_REG_ADDR         : std_logic_vector(6 downto 0) := "0000000";  -- 0x00
constant DAC_INTR_EN_REG_ADDR      : std_logic_vector(6 downto 0) := "0000100";  -- 0x04
constant DAC_INTR_STATUS_REG_ADDR  : std_logic_vector(6 downto 0) := "0001000";  -- 0x08
constant DAC_INTR_FLAG_REG_ADDR    : std_logic_vector(6 downto 0) := "0001100";  -- 0x0C

-- Define 1/2 Clock Period (250MHz Clock)
constant clk_in_half_p      : time := 2.0 ns;

--------------------------------------------------------------------------------

begin

--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--                                                                                                                --
--          ******************* Normal Testbench Runtime: 6460 ns *******************                            --
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

-- s_axis_dac_sample_clk - 250MHz
process
begin
    loop
        s_axis_dac_sample_clk <= not s_axis_dac_sample_clk;
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



dac38j84intrfc_TEST : process
begin
   wait for 300 ns;
   wait until rising_edge(s_axi_csr_aclk);
   s_axi_csr_aresetn <= '1';
   
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--                                                                                                                --
--                                       Output Data Bus Mapping Test                                             --
--                                                                                                                --
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------


   wait for 100 ns;
   
   for i in 1 to 10 loop
   
   
      case i is
   
         when 1 => s_axis_ch0_tx_tdata <= x"1111111111111111";
   	              s_axis_ch1_tx_tdata <= x"8888888888888888";
                  m_axis_dac_data_test <= x"88888888888888881111111111111111";
   
         when 2 => s_axis_ch0_tx_tdata <= x"AAAAAAAAAAAAAAAA";
   	              s_axis_ch1_tx_tdata <= x"5555555555555555";
                  m_axis_dac_data_test <= x"5555555555555555aaaaaaaaaaaaaaaa";
   
         when 3 => s_axis_ch0_tx_tdata <= x"0F0F0F0F0F0F0F0F";
   	              s_axis_ch1_tx_tdata <= x"F0F0F0F0F0F0F0F0";
                  m_axis_dac_data_test <= x"f0f0f0f0f0f0f0f00f0f0f0f0f0f0f0f";
   
         when 4 => s_axis_ch0_tx_tdata <= x"0123456789ABCDEF";
   	              s_axis_ch1_tx_tdata <= x"FEDCBA9876543210";
                  m_axis_dac_data_test <= x"dcfe547698ba10322301ab896745efcd";
   
         when 5 => s_axis_ch0_tx_tdata <= x"8421842184218421";
   	              s_axis_ch1_tx_tdata <= x"7BDE7BDE7BDE7BDE";
                   m_axis_dac_data_test <= x"de7bde7bde7bde7b2184218421842184";
  
   ------------- Switch data on channels...
                   
         when 6 => s_axis_ch1_tx_tdata <= x"1111111111111111";
   	              s_axis_ch0_tx_tdata <= x"8888888888888888";
                  m_axis_dac_data_test <= x"11111111111111118888888888888888";
   
         when 7 => s_axis_ch1_tx_tdata <= x"AAAAAAAAAAAAAAAA";
   	              s_axis_ch0_tx_tdata <= x"5555555555555555";
                  m_axis_dac_data_test <= x"aaaaaaaaaaaaaaaa5555555555555555";
   
         when 8 => s_axis_ch1_tx_tdata <= x"0F0F0F0F0F0F0F0F";
   	              s_axis_ch0_tx_tdata <= x"F0F0F0F0F0F0F0F0";
                  m_axis_dac_data_test <= x"0f0f0f0f0f0f0f0ff0f0f0f0f0f0f0f0";
   
         when 9 => s_axis_ch1_tx_tdata <= x"0123456789ABCDEF";
   	              s_axis_ch0_tx_tdata <= x"FEDCBA9876543210";
                  m_axis_dac_data_test <= x"2301ab896745efcddcfe547698ba1032";
   
         when 10 => s_axis_ch1_tx_tdata <= x"8421842184218421";
   	              s_axis_ch0_tx_tdata <= x"7BDE7BDE7BDE7BDE";
                  m_axis_dac_data_test <= x"2184218421842184de7bde7bde7bde7b";
      end case;
       
      wait for 100 ns;
       
      wait until rising_edge(s_axis_dac_sample_clk);
      if ((i = 1) or (i = 5)) then
         s_axis_ch0_tx_tvalid <= '1';
         wait for 16 ns;
         if m_axis_dac_tx_tvalid = '0' then
            assert false   
            report "!!!!!!!!!!!!!!!> DATA VALID LOGIC FAILED: Data Set " & integer'image(i) & ", m_axis_dac_tx_tvalid should be SET."
            severity FAILURE;
         end if;
          
      elsif ((i = 2) or (i = 6)) then
         s_axis_ch0_tx_tvalid <= '0';
         wait for 16 ns;
         if m_axis_dac_tx_tvalid = '1' then
            assert false   
            report "!!!!!!!!!!!!!!!> DATA VALID LOGIC FAILED: Data Set " & integer'image(i) & ", m_axis_dac_tx_tvalid should be CLEARED."
            severity FAILURE;
         end if;
                 
      elsif ((i = 3) or (i = 7)) then
         s_axis_ch1_tx_tvalid <= '1';
         wait for 16 ns;
         if m_axis_dac_tx_tvalid = '0' then
            assert false   
            report "!!!!!!!!!!!!!!!> DATA VALID LOGIC FAILED: Data Set " & integer'image(i) & ", m_axis_dac_tx_tvalid should be SET."
            severity FAILURE;
         end if;
          
      elsif ((i = 4) or (i = 8)) then
         s_axis_ch1_tx_tvalid <= '0';
         wait for 16 ns;
         if m_axis_dac_tx_tvalid = '1' then
            assert false   
            report "!!!!!!!!!!!!!!!> DATA VALID LOGIC FAILED: Data Set " & integer'image(i) & ", m_axis_dac_tx_tvalid should be CLEARED."
            severity FAILURE;
         end if;
      end if;
   
      wait for 16 ns;
      
      if m_axis_dac_tx_tdata /= m_axis_dac_data_test then
         assert false   
         report "!!!!!!!!!!!!!!!> FAILED: Expected data: 0x" & px_std_logic_vector_to_hstring(m_axis_dac_data_test) & ", DAC Data: 0x" & px_std_logic_vector_to_hstring(m_axis_dac_tx_tdata) & "." 
         severity FAILURE;
      elsif m_axis_dac_tx_tdata /= m_axis_dac_data_test then
         assert false   
         report "!!!!!!!!!!!!!!!> DATA MAPPING FAILED: Expected data: 0x" & px_std_logic_vector_to_hstring(m_axis_dac_data_test) & ", DAC Data: 0x" & px_std_logic_vector_to_hstring(m_axis_dac_tx_tdata) & "." 
         severity FAILURE;
      else
         assert false   
         report ">>>>>>>>>>>>>>>> Data Set " & integer'image(i) & " passed."
         severity NOTE;
      end if;
      
   end loop;
  
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--                                                                                                                --
--                                          Control Register Test                                                 --
--                                                                                                                --
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------

-- Control 1
-- Bit [0]     - DAC Reset
-- Bit [1]     - DAC Sleep Mode
-- Bit [2]     - DAC TX Enable

   assert false   
   report ">>>>>>>>>>>>>> Set and check DAC Reset (Active LOW)."   
   severity NOTE;

   px_axi_lite_writer(
       DAC_CTRL_REG_ADDR,
       (x"00000001" ), 
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
         
   wait for 200 ns;

   assert false   
   report ">>>>>>>>>>>>>> Verifying the DAC Reset output is set (Active LOW)."   
   severity NOTE;

   if dac_resetb = '1' then
      assert false   
      report "!!!!!!!!!!!!!!!> FAILED: dac_resetb did not get set (Active LOW)!."   
      severity FAILURE;
   else
      assert false   
      report ">>>>>>>>>>>>>> Output dac_resetb is set (Active LOW)."   
      severity NOTE;
   end if;
         
   wait for 200 ns;

   assert false   
   report ">>>>>>>>>>>>>> Set and check DAC Sleep Mode."   
   severity NOTE;

   px_axi_lite_writer(
       DAC_CTRL_REG_ADDR,
       (x"00000002" ), 
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
         
   wait for 200 ns;

   assert false   
   report ">>>>>>>>>>>>>> Verifying the DAC Sleep Mode output is set."   
   severity NOTE;

   if dac_sleep = '0' then
      assert false   
      report "!!!!!!!!!!!!!!!> FAILED: dac_sleep did not get set!."   
      severity FAILURE;
   elsif dac_resetb = '0' then
      assert false   
      report "!!!!!!!!!!!!!!!> FAILED: dac_resetb did not get cleared (Active LOW)!."   
      severity FAILURE;
   else
      assert false   
      report ">>>>>>>>>>>>>> Outputs dac_sleep is set and dac_resetb is cleared."   
      severity NOTE;
   end if;
         
   wait for 200 ns;
   

   assert false   
   report ">>>>>>>>>>>>>> Set and check DAC TX Enable."   
   severity NOTE;

   px_axi_lite_writer(
       DAC_CTRL_REG_ADDR,
       (x"00000004" ), 
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
         
   wait for 200 ns;

   assert false   
   report ">>>>>>>>>>>>>> Verifying the DAC Sleep Mode output is set."   
   severity NOTE;

   if dac_txena = '0' then
      assert false   
      report "!!!!!!!!!!!!!!!> FAILED: dac_txena did not get set!."   
      severity FAILURE;
   elsif dac_sleep = '1' then
      assert false   
      report "!!!!!!!!!!!!!!!> FAILED: dac_sleep did not get cleared!."   
      severity FAILURE;
   else
      assert false   
      report ">>>>>>>>>>>>>> Outputs dac_txena is set and dac_sleep is cleared."   
      severity NOTE;
   end if;
         
   wait for 200 ns;
   
   

   assert false   
   report ">>>>>>>>>>>>>> Clear and check the control register outputs."   
   severity NOTE;

   px_axi_lite_writer(
       DAC_CTRL_REG_ADDR,
       (x"00000000" ), 
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
         
   wait for 200 ns;

   assert false   
   report ">>>>>>>>>>>>>> Verifying all control register outputs are cleared."   
   severity NOTE;

   if dac_txena = '1' then
      assert false   
      report "!!!!!!!!!!!!!!!> FAILED: dac_txena did not get cleared!."   
      severity FAILURE;
   elsif dac_sleep = '1' then
      assert false   
      report "!!!!!!!!!!!!!!!> FAILED: dac_sleep did not get cleared!."   
      severity FAILURE;
   elsif dac_resetb = '0' then
      assert false   
      report "!!!!!!!!!!!!!!!> FAILED: dac_resetb did not get cleared (Active LOW)!."   
      severity FAILURE;
   else
      assert false   
      report ">>>>>>>>>>>>>> All control register output bits are cleared."   
      severity NOTE;
   end if;

         
   wait for 200 ns;
  
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--                                                                                                                --
--                                             Interrupt Test                                                     --
--                                                                                                                --
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------

-- Interrupts
-- Bit [0]     - DAC0 Alarm

         
   wait for 200 ns;
        
   assert false   
   report ">>>>>>>>>>>>>> Checking the interrupt status..."   
   severity NOTE;     
       
   px_axi_lite_reader(
       DAC_INTR_STATUS_REG_ADDR,
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
         
   wait for 200 ns;
        
   if (s_axi_csr_rdata /= x"00000000") then
      assert false   
      report ">>>>>>>>>>>>>> Current Interrupt Status Register Contents: 0x" & px_std_logic_vector_to_hstring(s_axi_csr_rdata) & "."   
      severity NOTE;
   else
      assert false   
      report ">>>>>>>>>>>>>> Interrupt Status Register is CLEARED."   
      severity NOTE;
   end if;
        
   assert false   
   report ">>>>>>>>>>>>>> Checking the interrupt flag register..."   
   severity NOTE;     

   
   px_axi_lite_reader(
       DAC_INTR_FLAG_REG_ADDR,
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
         
   wait for 200 ns;

   assert false   
   report ">>>>>>>>>>>>>> Current Interrupt Flag Register Contents: 0x" & px_std_logic_vector_to_hstring(s_axi_csr_rdata) & "."   
   severity NOTE;
   
   if (s_axi_csr_rdata /= x"00000000") then
      assert false   
      report ">>>>>>>>>>>>>> Clearing the Interrupt Flag Register..."   
      severity NOTE;
      px_axi_lite_writer(
          DAC_INTR_FLAG_REG_ADDR,
          (x"FFFFFFFF" ), 
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
         
      wait for 200 ns;
      px_axi_lite_writer(
          DAC_INTR_FLAG_REG_ADDR,
          (x"00000000" ), 
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
         
      wait for 200 ns;

      assert false   
      report ">>>>>>>>>>>>>> Interrupt Register is CLEARED."   
      severity NOTE;
   end if;

   assert false   
   report ">>>>>>>>>>>>>> Enable the interrupt."   
   severity NOTE;

   px_axi_lite_writer(
       DAC_INTR_EN_REG_ADDR,
       (x"00000001" ), 
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
         
   wait for 200 ns;

   assert false   
   report ">>>>>>>>>>>>>> Re-Check the Interrupt Status and Flag registers."   
   severity NOTE;

   px_axi_lite_reader(
       DAC_INTR_STATUS_REG_ADDR,
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
         
   wait for 200 ns;
  
   if (s_axi_csr_rdata /= x"00000000") then
      assert false   
      report "!!!!!!!!!!!!!!!> FAILED: Interrupt Status Register did not get CLEARED."   
      severity FAILURE;
   end if;

   
   px_axi_lite_reader(
       DAC_INTR_FLAG_REG_ADDR,
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
         
   wait for 200 ns;
  
   if (s_axi_csr_rdata /= x"00000000") then
      assert false   
      report "!!!!!!!!!!!!!!!> FAILED: Interrupt Flag Register did not get CLEARED."   
      severity FAILURE;
   end if;

   assert false   
   report ">>>>>>>>>>>>>> Interrupt Status and Flag registers are cleared."   
   severity NOTE;
         
   wait for 200 ns;

   assert false   
   report ">>>>>>>>>>>>>> Assert the dac_alarm interrupt. "   
   severity NOTE;

   wait until rising_edge(s_axis_dac_sample_clk);
   dac_alarm <= '1';

   wait until rising_edge(s_axis_dac_sample_clk);       
   px_axi_lite_reader(
       DAC_INTR_STATUS_REG_ADDR,
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
         
   wait for 200 ns;
         
   if (s_axi_csr_rdata /= x"00000001") then
      assert false   
      report ">>>>>>>>>>>>>> Current Interrupt Status Register Contents: 0x" & px_std_logic_vector_to_hstring(s_axi_csr_rdata) & "."   
      severity NOTE;
      assert false   
      report "!!!!!!!!!!!!!!!> FAILED: Interrupt Status Register Bit did not get SET."   
      severity FAILURE;
   else
      assert false   
      report ">>>>>>>>>>>>>> Interrupt Status Register Bit is SET."   
      severity NOTE;
   end if;

      px_axi_lite_reader(
       DAC_INTR_FLAG_REG_ADDR,
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
         
   wait for 200 ns;

   if (s_axi_csr_rdata /= x"00000001") then
      assert false   
      report ">>>>>>>>>>>>>> Current Interrupt Flag Register Contents: 0x" & px_std_logic_vector_to_hstring(s_axi_csr_rdata) & "."   
      severity NOTE;
      assert false   
      report "!!!!!!!!!!!!!!!> FAILED: Interrupt Flag Register Bit did not get SET."   
      severity FAILURE;
   else
      assert false   
      report ">>>>>>>>>>>>>> Interrupt Flag Register Bit is SET."   
      severity NOTE;
   end if;

   assert false   
   report ">>>>>>>>>>>>>> De-assert the dac_alarm interrupt. "   
   severity NOTE;

   wait until rising_edge(s_axis_dac_sample_clk);
   dac_alarm <= '0';


   wait until rising_edge(s_axis_dac_sample_clk);       
   px_axi_lite_reader(
       DAC_INTR_STATUS_REG_ADDR,
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
         
   wait for 200 ns;
         
   if (s_axi_csr_rdata /= x"00000000") then
      assert false   
      report ">>>>>>>>>>>>>> Current Interrupt Status Register Contents: 0x" & px_std_logic_vector_to_hstring(s_axi_csr_rdata) & "."   
      severity NOTE;
      assert false   
      report "!!!!!!!!!!!!!!!> FAILED: Interrupt Status Register Bit did not get CLEARED."   
      severity FAILURE;
   else
      assert false   
      report ">>>>>>>>>>>>>> Interrupt Status Register Bit is CLEARED."   
      severity NOTE;
   end if;

      px_axi_lite_reader(
       DAC_INTR_FLAG_REG_ADDR,
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
         
   wait for 200 ns;

   if (s_axi_csr_rdata /= x"00000001") then
      assert false   
      report ">>>>>>>>>>>>>> Current Interrupt Flag Register Contents: 0x" & px_std_logic_vector_to_hstring(s_axi_csr_rdata) & "."   
      severity NOTE;
      assert false   
      report "!!!!!!!!!!!!!!!> FAILED: Interrupt Flag Register Bit did not stay SET."   
      severity FAILURE;
   else
      assert false   
      report ">>>>>>>>>>>>>> Interrupt Flag Register Bit is still SET."   
      severity NOTE;
   end if;

   assert false   
   report ">>>>>>>>>>>>>> Clearing the Interrupt Flag Register..."   
   severity NOTE;
   px_axi_lite_writer(
       DAC_INTR_FLAG_REG_ADDR,
       (x"FFFFFFFF" ), 
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
      
   wait for 200 ns;
   px_axi_lite_writer(
       DAC_INTR_FLAG_REG_ADDR,
       (x"00000000" ), 
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
               
   wait for 200 ns;

   assert false   
   report ">>>>>>>>>>>>>> Re-Check the Interrupt Flag register."   
   severity NOTE;

   px_axi_lite_reader(
       DAC_INTR_FLAG_REG_ADDR,
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
         
   wait for 200 ns;
  
   if (s_axi_csr_rdata /= x"00000000") then
      assert false   
      report "!!!!!!!!!!!!!!!> FAILED: Interrupt Flag Register did not get CLEARED."   
      severity FAILURE;
   end if;

    
assert false
report ">>>>>>>>>>>>>>******* NOT A FAILURE: All px_dac38j84intrfc Tests Completed with No Errors. Time = " & time'image(now)
severity FAILURE;

   
end process;

--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--                                                                                                                --
--                                        Verify the IRQ Output                                                   --
--                                                                                                                --
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------

-- IRQ output should be asserted from 4.904us to 4.908us, so test in the middle.

check_irq_output_proc : process
begin
wait for 4.906 us;
  
   if (irq /= '1') then
      assert false   
      report "!!!!!!!!!!!!!!!> FAILED: IRQ OUTPUT NOT DETECTED. Time = " & time'image(now)   
      severity FAILURE;
   else
      assert false   
      report ">>>>>>>>>>>>>>******* IRQ OUTPUT DETECTED. Time = " & time'image(now)   
      severity NOTE;
   end if;
end process;

--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--                                                                                                                --
--                                 --  Core Under Test Instantiation --                                           --
--                                                                                                                --
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------


uut : px_dac38j84intrfc
   port map(
   s_axi_csr_aclk           =>   s_axi_csr_aclk,   
   s_axi_csr_aresetn        =>   s_axi_csr_aresetn,
   s_axi_csr_awaddr         =>   s_axi_csr_awaddr, 
   s_axi_csr_awprot         =>   s_axi_csr_awprot, 
   s_axi_csr_awvalid        =>   s_axi_csr_awvalid,
   s_axi_csr_awready        =>   s_axi_csr_awready,
   s_axi_csr_wdata          =>   s_axi_csr_wdata,  
   s_axi_csr_wstrb          =>   s_axi_csr_wstrb,  
   s_axi_csr_wvalid         =>   s_axi_csr_wvalid, 
   s_axi_csr_wready         =>   s_axi_csr_wready, 
   s_axi_csr_bresp          =>   s_axi_csr_bresp,  
   s_axi_csr_bvalid         =>   s_axi_csr_bvalid, 
   s_axi_csr_bready         =>   s_axi_csr_bready, 
   s_axi_csr_araddr         =>   s_axi_csr_araddr, 
   s_axi_csr_arprot         =>   s_axi_csr_arprot, 
   s_axi_csr_arvalid        =>   s_axi_csr_arvalid,
   s_axi_csr_arready        =>   s_axi_csr_arready,
   s_axi_csr_rdata          =>   s_axi_csr_rdata,  
   s_axi_csr_rresp          =>   s_axi_csr_rresp,  
   s_axi_csr_rvalid         =>   s_axi_csr_rvalid, 
   s_axi_csr_rready         =>   s_axi_csr_rready, 
   irq                      =>   irq,              
   dac_txena                =>   dac_txena,            
   dac_sleep                =>   dac_sleep,            
   dac_resetb               =>   dac_resetb,           
   dac_alarm                =>   dac_alarm,            
   s_axis_dac_sample_clk    =>   s_axis_dac_sample_clk,
   s_axis_ch0_tx_tdata      =>   s_axis_ch0_tx_tdata,  
   s_axis_ch0_tx_tvalid     =>   s_axis_ch0_tx_tvalid, 
   s_axis_ch1_tx_tdata      =>   s_axis_ch1_tx_tdata,  
   s_axis_ch1_tx_tvalid     =>   s_axis_ch1_tx_tvalid, 
   m_axis_dac_tx_tdata      =>   m_axis_dac_tx_tdata,  
   m_axis_dac_tx_tvalid     =>   m_axis_dac_tx_tvalid, 
   m_axis_dac_tx_tready     =>   m_axis_dac_tx_tready 
   );


end Behavioral;