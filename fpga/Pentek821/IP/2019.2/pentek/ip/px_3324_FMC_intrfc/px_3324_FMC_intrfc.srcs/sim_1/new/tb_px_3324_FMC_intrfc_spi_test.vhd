----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/03/2018 11:06:39 AM
-- Design Name: 
-- Module Name: tb_px_3324_FMC_intrfc_spi_test - Behavioral
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
--use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

use ieee.numeric_std.ALL;
use work.px_utility_pkg.ALL;

entity tb_px_3324_FMC_intrfc_spi_test is
--  Port ( );
end tb_px_3324_FMC_intrfc_spi_test;

architecture Behavioral of tb_px_3324_FMC_intrfc_spi_test is

component px_3324_FMC_intrfc_top
port (
   --------------------------------------------------------------------------------
   -- AXI LITE Slave Interface  
   --------------------------------------------------------------------------------
   s_axi_csr_aclk           : in  std_logic;                         
   s_axi_csr_araddr         : in  std_logic_vector ( 6 downto 0 );
   s_axi_csr_aresetn        : in  std_logic;
   s_axi_csr_arprot         : in  std_logic_vector ( 2 downto 0 );
   s_axi_csr_arready        : out std_logic;
   s_axi_csr_arvalid        : in  std_logic;
   s_axi_csr_awaddr         : in  std_logic_vector ( 6 downto 0 );
   s_axi_csr_awprot         : in  std_logic_vector ( 2 downto 0 );
   s_axi_csr_awready        : out std_logic;
   s_axi_csr_awvalid        : in  std_logic;
   s_axi_csr_bready         : in  std_logic;
   s_axi_csr_bresp          : out std_logic_vector ( 1 downto 0 );
   s_axi_csr_bvalid         : out std_logic;
   s_axi_csr_rdata          : out std_logic_vector ( 31 downto 0 );
   s_axi_csr_rready         : in  std_logic;
   s_axi_csr_rresp          : out std_logic_vector ( 1 downto 0 );
   s_axi_csr_rvalid         : out std_logic;
   s_axi_csr_wdata          : in  std_logic_vector ( 31 downto 0 );
   s_axi_csr_wready         : out std_logic;
   s_axi_csr_wstrb          : in  std_logic_vector ( 3 downto 0 );
   s_axi_csr_wvalid         : in  std_logic;
 
   --------------------------------------------------------------------------------
   -- System Level Clock and Reset  
   --------------------------------------------------------------------------------
   PCIE_CLK                 : in  std_logic;
   LRST_N                   : in  std_logic;

   ----------------------------------------------------------------------------
   -- TWSI Serial Bus
   ----------------------------------------------------------------------------
   TWSI_SDA                 : inout std_logic;
   TWSI_SCL                 : inout std_logic;
                            
   TRNS_DONE_INT            : out std_logic;  -- Transfer Done Interrupt
   NO_ACK_INT               : out std_logic;  -- No Acknowledge Interrupt

   
   -----------------------------------------------------------------------------
   -- SPI  Serial Bus
   -----------------------------------------------------------------------------
   SDIO                     : inout std_logic;
   SDENB                    : out std_logic_vector(4 downto 0);
   SCLK                     : out std_logic;
   SDO                      : in  std_logic_vector(4 downto 0);
   
   ----------------------------------------------------------------------------
   -- LMK04828B Control and Status
   ----------------------------------------------------------------------------
   INT_REF_SEL              : out std_logic;
   JESD_RESET_GPO           : out std_logic;
   PLL1_CLKIN_SEL0          : out std_logic;
   PLL1_CLKIN_SEL1          : out std_logic;
   PLL1_REF_ENAB            : out std_logic;
   PLL2_REF_ENAB            : out std_logic;
   GATE_B_SEL               : out std_logic;
   SYSREF_SYNC              : out std_logic;
   STATUS_LD1               : in std_logic;
   STATUS_LD2               : in std_logic
 );
end component;


signal   s_axi_csr_aclk     :  std_logic := '0';                         
signal   s_axi_csr_araddr   :  std_logic_vector ( 6 downto 0 );
signal   s_axi_csr_aresetn  :  std_logic := '0';
signal   s_axi_csr_arprot   :  std_logic_vector ( 2 downto 0 );
signal   s_axi_csr_arready  :  std_logic;
signal   s_axi_csr_arvalid  :  std_logic := '0';
signal   s_axi_csr_awaddr   :  std_logic_vector ( 6 downto 0 );
signal   s_axi_csr_awprot   :  std_logic_vector ( 2 downto 0 );
signal   s_axi_csr_awready  :  std_logic;
signal   s_axi_csr_awvalid  :  std_logic := '0';
signal   s_axi_csr_bready   :  std_logic := '0';
signal   s_axi_csr_bresp    :  std_logic_vector ( 1 downto 0 );
signal   s_axi_csr_bvalid   :  std_logic;
signal   s_axi_csr_rdata    :  std_logic_vector ( 31 downto 0 );
signal   s_axi_csr_rready   :  std_logic := '0';
signal   s_axi_csr_rresp    :  std_logic_vector ( 1 downto 0 );
signal   s_axi_csr_rvalid   :  std_logic;
signal   s_axi_csr_wdata    :  std_logic_vector ( 31 downto 0 );
signal   s_axi_csr_wready   :  std_logic;
signal   s_axi_csr_wstrb    :  std_logic_vector ( 3 downto 0 );
signal   s_axi_csr_wvalid   :  std_logic := '0';
signal   PCIE_CLK           :  std_logic := '0';
signal   LRST_N             :  std_logic := '0';
signal   TWSI_SDA           :  std_logic := '0';
signal   TWSI_SCL           :  std_logic := '0';   
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

signal   start_test         : std_logic := '0';
signal   spi_cntrl_reg      : std_logic_vector(31 downto 0) := (others => '0');
signal   spi_reset          : std_logic := '0'; 
signal   spi_read           : std_logic := '0'; 
signal   spi_write          : std_logic := '0'; 
signal   spi_dev_sel        : std_logic_vector(2 downto 0) := "000";
signal   spi_mode           : std_logic := '0'; 
signal   spi_data_length    : std_logic := '0'; 
signal   spi_address        : std_logic_vector(15 downto 0) := (others => '0');
signal   spi_rd_data        : std_logic_vector(31 downto 0) := (others => '0');
signal   spi_wr_data        : std_logic_vector(31 downto 0) := (others => '0');
signal   data_reg_width     : integer range 0 to 16;
signal   addr_reg_width     : integer range 0 to 16;
signal   write_addr_error   : std_logic := '0';
signal   write_data_error   : std_logic := '0';
signal   read_data_error    : std_logic := '0';
signal   error              : std_logic := '0';
signal   verify_write_cntr  : integer range 0 to 20 := 0;
signal   verify_write_data  : std_logic_vector(34 downto 0);
signal   write_length       : integer range 0 to 40 := 0;
signal   verify_write_hold  : std_logic := '0';
signal   sclk_LED_pulse     : std_logic := '0';
signal   sclk_LED_reg1      : std_logic := '0';
signal   sclk_LED_reg2      : std_logic := '0';
signal   sclk_TED_pulse     : std_logic := '0';
signal   sclk_TED_reg1      : std_logic := '0';
signal   sclk_TED_reg2      : std_logic := '0';
signal   write_data_test    : std_logic := '0';
signal   read_data_test     : std_logic := '0';
signal   spi_read_data      : std_logic_vector(31 downto 0) := (others => '0');
signal   spi_out_bit        : std_logic := '0';
signal   spi_read_counter   : integer range 0 to 20 := 10;
signal   spi_read_trist_en  : std_logic := '0';
signal   spi_read_data_csr  : std_logic_vector(31 downto 0) := (others => '0');

constant clk_in_half_p      : time := 2.0 ns;


begin

--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--                                                                                                                --
--           ******************* Normal Testbench Runtime: 45276 ns *******************                           --
--                                                                                                                --
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--                                                                                                                --
--                                      Testbench Set-up                                                          --
--                                                                                                                --
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------

-- 0x00 - SPI Interface Control
--           Bit 0 - SPI Reset
--           Bit 1 - SPI Read
--           Bit 2 - SPI Write
--           Bits 5:3 - Device Select: 100 = LMK, 011 = DAC1, 010 = DAC0, 001 = ADC1, 000 = ADC0
--           Bit 6 - Mode: 0 = 4-Wire, 1 = 3-Wire
--           Bit 7 - Data Length: 0 = 8-Bit, 1 = 16-bit
--           Bits 23:8 - SPI Address (14:8 for DACs)
--           Bits 31:24 - RESERVED

-- Set-up SPI Control Register Bits:
spi_reset          <= spi_cntrl_reg(0);    
spi_read           <= spi_cntrl_reg(1);
spi_write          <= spi_cntrl_reg(2);
spi_dev_sel        <= spi_cntrl_reg(5 downto 3);
spi_mode           <= spi_cntrl_reg(6);
spi_data_length    <= spi_cntrl_reg(7);
spi_address        <= spi_cntrl_reg(23 downto 8);

data_reg_width <= 8 when (spi_data_length = '0') else 16;
addr_reg_width <= 7 when (spi_dev_sel(1) = '1') else 16;

write_length <= data_reg_width + addr_reg_width + 1; -- Add 1 for the read/write bit at the start of the stream

-- Generate Clocks

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

-- Release Power-On-Reset
LRST_N <= '1' after 100ns;  -- Power-on Reset

-- Release CSR AXI4-Lite Reset
s_axi_csr_aresetn <= '1' after 300ns;

-- Generate a single PCIE_CLK-wide pulse on the leading-edge of SCLK
sclk_LED_pulse_gen : process (PCIE_CLK, SCLK)
begin

   if LRST_N = '0' then
      sclk_LED_reg1 <= '0';
      sclk_LED_reg2 <= '0';
   elsif (PCIE_CLK'event and PCIE_CLK = '1') then
      sclk_LED_reg1 <= SCLK;
	  sclk_LED_reg2 <= sclk_LED_reg1;
   end if;
end process;

sclk_LED_pulse <= sclk_LED_reg1 and not sclk_LED_reg2;

-- Generate a single PCIE_CLK-wide pulse on the trailing-edge of SCLK
sclk_TED_pulse <= not sclk_LED_reg1 and sclk_LED_reg2;


SPI_TEST : process

begin

--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--                                                                                                                --
--                                            SPI Write Data Test                                                 --
--                                                                                                                --
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------

      wait for 100ns;

      for i in 1 to 5 loop

-- 0x00 - SPI Interface Control
--           Bit 0 - SPI Reset
--           Bit 1 - SPI Read
--           Bit 2 - SPI Write
--           Bits 5:3 - Device Select: 100 = LMK, 011 = DAC1, 010 = DAC0, 001 = ADC1, 000 = ADC0
--           Bit 6 - Mode: 0 = 4-Wire, 1 = 3-Wire
--           Bit 7 - Data Length: 0 = 8-Bit, 1 = 16-bit
--           Bits 23:8 - SPI Address (14:8 for DACs)
--           Bits 31:24 - RESERVED

         case i is
      
            when 1 => spi_wr_data <= x"000000a5";
      	               spi_cntrl_reg <= x"00800104"; -- Write, ADC0, 4-wire, 8-bit data, 16-bit address
      
            when 2 => spi_wr_data <= x"0000005a";
		               spi_cntrl_reg <= x"0003400C"; -- Write, ADC1, 4-wire, 8-bit data, 16-bit address
      
            when 3 => spi_wr_data <= x"00001234";
		               spi_cntrl_reg <= x"00005694"; -- Write, DAC0, 4-wire, 16-bit data, 7-bit address
      
            when 4 => spi_wr_data <= x"0000FEDC";
		               spi_cntrl_reg <= x"0000569C"; -- Write, DAC1, 4-wire, 16-bit data, 7-bit address
      
            when 5 => spi_wr_data <= x"000000fa";
		               spi_cntrl_reg <= x"00078064"; -- Write, LMK, 3-wire, 8-bit data, 16-bit address
         end case;


		  wait for 100ns;

		  write_data_test <= '1';  -- Boundary for each iteration of the test, used in verification.

		  
          -- First, write the SPI Control Register settings:
          px_axi_lite_writer("0000000",spi_cntrl_reg, s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
      
         wait for 100ns;

         --Next, write the SPI Data to be transmitted:
         px_axi_lite_writer("0000100",spi_wr_data, s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
      
         wait for 100ns;
      
         -- Do a looped-read of the SPI status until it is ready:      
         while start_test = '0' loop  
            px_axi_lite_reader("0011100", x"00000001", '0', '0', s_axi_csr_aclk, s_axi_csr_araddr, s_axi_csr_arprot, s_axi_csr_arvalid, s_axi_csr_arready, s_axi_csr_rdata, s_axi_csr_rresp, s_axi_csr_rvalid, s_axi_csr_rready);
            start_test <= s_axi_csr_rdata(0);
         end loop;
      
         wait for 100ns;
      
         -- Toggle the start bit:
         px_axi_lite_writer("0001000",x"00000001", s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
         px_axi_lite_writer("0001000",x"00000000", s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
		  
         -- The start bit pulse should be finished by the time it is read here:
         px_axi_lite_reader("0011000", x"00000001", '0', '0', s_axi_csr_aclk, s_axi_csr_araddr, s_axi_csr_arprot, s_axi_csr_arvalid, s_axi_csr_arready, s_axi_csr_rdata, s_axi_csr_rresp, s_axi_csr_rvalid, s_axi_csr_rready);
         start_test <= s_axi_csr_rdata(0);

         wait for 4 us;
	  
	     write_data_test <= '0';  -- Boundary for each iteration of the test, used in verification.
           
      end loop;
 
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--                                                                                                                --
--                                        End of SPI Write Data Test                                              --
--                                                                                                                --
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------

   
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--                                                                                                                --
--                                            SPI Read Data Test                                                  --
--                                                                                                                --
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------


      for i in 1 to 5 loop

-- 0x00 - SPI Interface Control
--           Bit 0 - SPI Reset
--           Bit 1 - SPI Read
--           Bit 2 - SPI Write
--           Bits 5:3 - Device Select: 100 = LMK, 011 = DAC1, 010 = DAC0, 001 = ADC1, 000 = ADC0
--           Bit 6 - Mode: 0 = 4-Wire, 1 = 3-Wire
--           Bit 7 - Data Length: 0 = 8-Bit, 1 = 16-bit
--           Bits 23:8 - SPI Address (14:8 for DACs)
--           Bits 31:24 - RESERVED

		 read_data_test <= '1';  -- Boundary for each iteration of the test, used in verification.
      
         wait for 100ns;

         case i is
      
            when 1 => spi_cntrl_reg <= x"00800102"; -- Read, ADC0, 4-wire, 8-bit data, 16-bit address
                      spi_rd_data <= x"00000081";
      
            when 2 => spi_cntrl_reg <= x"0003400A"; -- Read, ADC1, 4-wire, 8-bit data, 16-bit address
                       spi_rd_data <= x"0000005a";
     
            when 3 => spi_cntrl_reg <= x"0000569A"; -- Read, DAC0, 4-wire, 16-bit data, 7-bit address
                      spi_rd_data <= x"00001234";
     
            when 4 => spi_cntrl_reg <= x"00005692"; -- Read, DAC1, 4-wire, 16-bit data, 7-bit address
                      spi_rd_data <= x"0000FEDC";
      
            when 5 => spi_cntrl_reg <= x"00078062"; -- Read, LMK, 3-wire, 8-bit data, 16-bit address
                      spi_rd_data <= x"000000fa";
         end case;


		  wait for 100ns;

		  
          -- First, write the SPI Control Register settings:
          px_axi_lite_writer("0000000",spi_cntrl_reg, s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
      
         wait for 100ns;
      
         -- Do a looped-read of the SPI status until it is ready:      
         while start_test = '0' loop  
            px_axi_lite_reader("0011100", x"00000001", '0', '0', s_axi_csr_aclk, s_axi_csr_araddr, s_axi_csr_arprot, s_axi_csr_arvalid, s_axi_csr_arready, s_axi_csr_rdata, s_axi_csr_rresp, s_axi_csr_rvalid, s_axi_csr_rready);
            start_test <= s_axi_csr_rdata(0);
         end loop;
      
         wait for 100ns;
      
         -- Toggle the start bit:
         px_axi_lite_writer("0001000",x"00000001", s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
         px_axi_lite_writer("0001000",x"00000000", s_axi_csr_aclk, s_axi_csr_awaddr, s_axi_csr_awprot, s_axi_csr_awvalid, s_axi_csr_awready, s_axi_csr_wdata, s_axi_csr_wstrb, s_axi_csr_wvalid, s_axi_csr_wready, s_axi_csr_bresp, s_axi_csr_bvalid, s_axi_csr_bready);
		  
         -- The start bit pulse should be finished by the time it is read here:
         px_axi_lite_reader("0011000", x"00000001", '0', '0', s_axi_csr_aclk, s_axi_csr_araddr, s_axi_csr_arprot, s_axi_csr_arvalid, s_axi_csr_arready, s_axi_csr_rdata, s_axi_csr_rresp, s_axi_csr_rvalid, s_axi_csr_rready);
         start_test <= s_axi_csr_rdata(0);

         wait for 3.6us;
         
         -- Read the SPI Data received:
         px_axi_lite_reader("0100000", x"00000001", '0', '0', s_axi_csr_aclk, s_axi_csr_araddr, s_axi_csr_arprot, s_axi_csr_arvalid, s_axi_csr_arready, s_axi_csr_rdata, s_axi_csr_rresp, s_axi_csr_rvalid, s_axi_csr_rready);
         spi_read_data_csr <= s_axi_csr_rdata;
         
         wait for 100ns;

	     read_data_test <= '0';  -- Boundary for each iteration of the test, used in verification.
         
         wait for 200ns;
           
      end loop;
      
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--                                                                                                                --
--                                        End of SPI Read Data Test                                               --
--                                                                                                                --
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
      
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--                                                                                                                --
--                                       End of Tests - Report Status                                             --
--                                                                                                                --
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
      
      if error = '1' then
         assert false
         report "TEST FAILED - See error signals..." 
         severity FAILURE;
      else
         assert false
         report ">>>>>>>>>>>>>>******* NOT A FAILURE: All SPI Tests Completed with No Errors. Time = " & time'image(now)
         severity FAILURE;
      end if;
       
      wait;
		 
end process;

      
error <= (write_addr_error or write_data_error or read_data_error);

--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--                                                                                                                --
--                                            Parallel Processes                                                  --
--                                                                                                                --
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--                                                                                                                --
--                                     Verify SPI Write Data Test Data                                            --
--                                                                                                                --
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------

sclk_LED_pulse <= sclk_LED_reg1 and not sclk_LED_reg2;


SPI_write_verification : process(PCIE_CLK, start_test, sclk_LED_pulse)
begin
   if write_data_test = '1' then
		 
      if (start_test = '1') then
	     verify_write_cntr <= write_length - 1;
		 verify_write_data <= (others => '0');
		 verify_write_hold <= '0';
         -- These are commented-out so that if either trips 
         -- during any of the verifies it will not reset
         --		 write_data_error <= '0';
         --      write_addr_error <= '0';
		 
	  elsif (PCIE_CLK'event and PCIE_CLK = '1')  then
	     if sclk_LED_pulse = '1' then
		    verify_write_data(verify_write_cntr) <= SDIO;
	        if (verify_write_cntr > 0) then
			   verify_write_cntr <= verify_write_cntr - 1;
			else
			   verify_write_hold <= '1';  -- wait for the last data to latch
            end if;
         end if;

         if (verify_write_hold = '1') and (write_data_test = '1') and (SDENB /= "11111") then
            if verify_write_data(((write_length - 2) - addr_reg_width) downto 0) /= spi_wr_data((data_reg_width - 1) downto 0) then
               write_data_error <= '1';
            end if;
            if verify_write_data((write_length - 1) downto (write_length - addr_reg_width - 1)) /= spi_cntrl_reg((addr_reg_width + 8) downto 8) then
	  	       write_addr_error <= '1';
            end if;
         end if;

      end if;
   end if;
end process;	  

   
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--                                                                                                                --
--                                   Generate the SPI Read Test Data Stream                                       --
--                                                                                                                --
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------

         
read_data_generator : process (PCIE_CLK, SCLK)
begin

   if read_data_test = '1' then
      for j in 1 to 5 loop
      
         if (start_test = '1') then
            spi_read_counter <= write_length -1;
            spi_read_trist_en <= '0';
         elsif read_data_test = '1' then
            if (PCIE_CLK'event and PCIE_CLK = '1') then
               if sclk_TED_pulse = '1' then
                  if spi_read_counter < (data_reg_width + 2) then
                     if spi_mode = '1' then
                        spi_read_trist_en <= '1';
                     else
                        spi_read_trist_en <= '0';
                     end if;
                 end if;
                  if spi_read_counter /= 0 then
                     spi_read_counter <= spi_read_counter - 1;
                  end if;
               end if;
            end if;
         end if;
      end loop;
   end if;
      
      
      spi_out_bit <= spi_rd_data(spi_read_counter);
      
      if (spi_read_trist_en = '1') and (read_data_test = '1') then
         SDIO <= spi_out_bit;
      else
         SDIO <= 'Z';
      end if;
      
      -- Device Select: 100 = LMK, 011 = DAC1, 010 = DAC0, 001 = ADC1, 000 = ADC0
      
         case spi_dev_sel is
             when "000" => SDO(0) <= spi_out_bit;
                           SDO(1) <= '0';
                           SDO(2) <= '0';
                           SDO(3) <= '0';
                           SDO(4) <= '0';
             when "001" => SDO(0) <= '0';
                           SDO(1) <= spi_out_bit;
                           SDO(2) <= '0';
                           SDO(3) <= '0';
                           SDO(4) <= '0';
             when "010" => SDO(0) <= '0';
                           SDO(1) <= '0';
                           SDO(2) <= spi_out_bit;
                           SDO(3) <= '0';
                           SDO(4) <= '0';
             when "011" => SDO(0) <= '0';
                           SDO(1) <= '0';
                           SDO(2) <= '0';
                           SDO(3) <= spi_out_bit;
                           SDO(4) <= '0';
             when "100" => SDO(0) <= '0';
                           SDO(1) <= '0';
                           SDO(2) <= '0';
                           SDO(3) <= '0';
                           SDO(4) <= spi_out_bit;
            when others => SDO(0) <= '0';
                           SDO(1) <= '0';
                           SDO(2) <= '0';
                           SDO(3) <= '0';
                           SDO(4) <= '0';
         end case;

end process;  

SPI_read_verification : process(PCIE_CLK, read_data_test, spi_read_counter)

begin

   if (PCIE_CLK'event and PCIE_CLK = '1') then
      if ((read_data_test = '0') and (spi_read_counter = 0)) then
         if spi_read_data_csr(((write_length - 2) - addr_reg_width) downto 0) /= spi_rd_data((data_reg_width - 1) downto 0) then
            read_data_error <= '1';
         end if;
      end if;
   end if;
end process;
   
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--                                                                                                                --
--                                         --  End of tests --                                                    --
--                                                                                                                --
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------

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
