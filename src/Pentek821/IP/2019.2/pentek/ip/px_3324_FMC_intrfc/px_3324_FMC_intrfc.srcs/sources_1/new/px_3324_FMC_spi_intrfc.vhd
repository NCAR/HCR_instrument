----------------------------------------------------------------------------------
-- Company: Pentek 
-- Engineer: 
-- 
-- Create Date: 06/25/2018 
-- Design Name: px_3324_spi_intrfc 
-- Module Name: px_3324_spi_intrfc - Behavioral
-- Project Name: Navigator FPGA Kit
-- Target Devices: 
-- Tool Versions: Vivado 2018.1
-- Description: 
-- This module was created in combination with generics based on previous
-- pentek designs that used SPI interfaces with various configurations. The
-- generics allow for any configuration between data and addr width to be
-- used
--
-- Dependencies: 
-- px_3324_spi_intrfc Local interface should be used with pentek control and status 
-- register module (px_axil_csr) in order to provide software capability control

-- Revision:
-- Revision 1.0 - Module Created
--
-- Additional Comments: 
--  


-- (NO Memory Map associated with this module)
--  

-- (Additional Info)
-- Requires connection to external pins to access external devices

----------------------------------------------------------------------------------

-- (Technical Support for Pentek's GateFlow FPGA Design Kits)  
-- Technical support for Pentek's GateFlow FPGA Design Kits is available via e-mail 
-- (fpgasupport@pentek.com) or by phone (201-818-5900 ext. 238, 9 AM to 5 PM US 
-- Eastern time.) Names or initials contained within the source code are part of 
-- our revision control regime.  Please do not try to use these references to 
-- pursue technical support                              

-- (c) Copyright 2017 Pentek, Inc. All rights reserved.
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


LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity px_3324_spi_intrfc is
port 
(
   -- internal interface signals
   clk_in    : in  std_logic; 
   rst_n     : in  std_logic;
   
   -- Device Select: 000 = ADC0: 4-wire, 16-bit address, 8-bit data
   --                001 = ADC1: 4-wire, 16-bit address, 8-bit data
   --                010 = DAC0: 3/4-wire, 7-bit address, 16-bit data
   --                011 = DAC1: 3/4-wire, 7-bit address, 16-bit data
   --                100 = LMK: 3-wire, 16-bit address, 8-bit data
   dev_sel   : in  std_logic_vector(2 downto 0);
   
   spi_mode  : in  std_logic;  -- '0' = 4 wire , '1' = 3 wire
   data_len  : in  std_logic;  -- '0' = 8, '1' = 16
   data_in   : in  std_logic_vector(15 downto 0);
   addr      : in  std_logic_vector(15 downto 0);
   wr        : in  std_logic;
   rd        : in  std_logic;
   data_out  : out std_logic_vector(15 downto 0);
   sm_rdy    : out std_logic;
   -- serial interface signals
   sdi       : inout std_logic;
   sdenb     : out std_logic_vector(4 downto 0);
   sclk      : out std_logic;
   sdo       : in  std_logic_vector(4 downto 0)
);
end px_3324_spi_intrfc;

architecture Behavioral of px_3324_spi_intrfc is

-------------------------------------------------------------------------------
-- Signals
-------------------------------------------------------------------------------

signal data_out_sr_width : integer;

signal data_reg_width : integer;
signal addr_reg_width : integer;

signal rst_n_reg     : std_logic;

signal wr_reg1       : std_logic;
signal wr_reg2       : std_logic;
signal wr_pls        : std_logic;

signal rd_reg1       : std_logic;
signal rd_reg2       : std_logic;
signal rd_pls        : std_logic;

signal ser_clk_cntr  : std_logic_vector(4 downto 0);
signal ser_sr_cntr   : integer;
signal sr_cntr_tc    : std_logic;
signal data_out_sr   : std_logic_vector(32 downto 0):= (others => '0');
signal data_in_sr    : std_logic_vector(15 downto 0);
signal rd_strch      : std_logic;
signal wr_strch      : std_logic;
signal w_sdi         : std_logic;
signal r_sdi         : std_logic;
signal r_sdenb       : std_logic_vector(4 downto 0);
signal r_sclk        : std_logic;

signal oe            : std_logic;
signal oe_tri        : std_logic; 

signal data_in_zero  : std_logic_vector(15 downto 0) := (others => '0');


-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

begin

data_reg_width <= 16 when (data_len = '1') else 8;
addr_reg_width <= 7 when (dev_sel(1) = '1') else 16;

data_out_sr_width <= data_reg_width + addr_reg_width + 1;

process(clk_in)
begin
    if(rising_edge(clk_in)) then
        rst_n_reg <= rst_n;
    end if;
end process;

-- Create a 7.8125MHz Serial data rate from the 250MHz PCIE clock
process(clk_in)
begin
   if rising_edge(clk_in) then
      if (rst_n_reg = '0' or sr_cntr_tc = '1') then
         ser_clk_cntr <= "00000";
      elsif(sr_cntr_tc = '0') then   
         ser_clk_cntr <= ser_clk_cntr + 1;
      end if;   
   end if;
end process;

process(clk_in)
begin
   if rising_edge(clk_in) then
      if (rst_n_reg = '0' ) then
          wr_reg1 <= '0';
          wr_reg2 <= '0';
          wr_pls  <= '0';
          
          rd_reg1 <= '0';
          rd_reg2 <= '0';
          rd_pls  <= '0';
      else
          
          wr_reg1 <= wr;
          wr_reg2 <= wr_reg1;
          wr_pls  <= wr_reg1 and not wr_reg2;
          
          rd_reg1 <= rd;
          rd_reg2 <= rd_reg1;
          rd_pls  <= rd_reg1 and not rd_reg2;
      end if;   
   end if;
end process;

-------------------------------------------------------------------------------
-- Shift Register Cycle Counter
-------------------------------------------------------------------------------
process(clk_in)
begin
   if rising_edge(clk_in) then
      if (rst_n_reg = '0') then
         ser_sr_cntr <= 0;  
      elsif (wr_pls = '1') then
         ser_sr_cntr <= data_out_sr_width;
      elsif(rd_pls = '1') then 
         ser_sr_cntr <= data_out_sr_width; 
      elsif  (ser_sr_cntr /= 0) and (ser_clk_cntr = "11111") then
         ser_sr_cntr <= ser_sr_cntr - 1;
      end if; 
      if (rst_n_reg = '0') then
         sr_cntr_tc  <= '1';
      --elsif (ser_clk_cntr = "11111") then
      else
         if (ser_sr_cntr = 0) then
            sr_cntr_tc  <= '1';
         else
            sr_cntr_tc  <= '0';
         end if;
      end if;
   end if;
end process;

-------------------------------------------------------------------------------
-- Data Output Shift Register
-------------------------------------------------------------------------------
process(clk_in)
begin
   if rising_edge(clk_in) then  
      if (rst_n_reg = '0') then
         data_out_sr(data_out_sr_width - 1 downto 0) <= (others => '0');  
      elsif (rd_pls = '1') then
         data_out_sr(data_out_sr_width - 1 downto 0) <= rd_pls & addr(addr_reg_width -1 downto 0) & data_in_zero(data_reg_width - 1 downto 0);
      elsif (wr_pls = '1') then
         data_out_sr(data_out_sr_width - 1 downto 0) <= '0' & addr(addr_reg_width -1 downto 0) & data_in(data_reg_width - 1 downto 0);
      elsif (sr_cntr_tc = '0') and (ser_clk_cntr = "11111") then
         data_out_sr(data_out_sr_width - 1 downto 0) <= data_out_sr(data_out_sr_width - 2 downto 0) & '0';
      end if;
   end if;
end process;

-- Generate Write Ready signal
process(clk_in)
begin   
   if rising_edge(clk_in) then
      if (rst_n_reg = '0') then 
         wr_strch <= '0';
      elsif WR_PLS = '1' then
         wr_strch <= '1';
      elsif (ser_sr_cntr = 0)  and (ser_clk_cntr = "00000") then
         wr_strch <= '0';
      end if;
      if (rst_n_reg = '0') then 
         sm_rdy     <= '1'; 
      else   
         sm_rdy     <= not( wr_strch or rd_strch);
      end if;   
   end if;
end process;

-------------------------------------------------------------------------------
-- Data Input Shift Register
-------------------------------------------------------------------------------
process(clk_in)
begin
   if rising_edge(clk_in) then
      if (rst_n_reg = '0') then
         data_in_sr(data_reg_width - 1 downto 0) <= (others => '0'); 
      elsif (sr_cntr_tc = '0') and (ser_clk_cntr = "10001") then
          if(spi_mode = '1') then
              data_in_sr(data_reg_width - 1 downto 0) <= data_in_sr(data_reg_width - 2 downto 0) & r_sdi;
          else
              case dev_sel is
			    when "000" => data_in_sr(data_reg_width - 1 downto 0) <= data_in_sr(data_reg_width - 2 downto 0) & sdo(0);
			    when "001" => data_in_sr(data_reg_width - 1 downto 0) <= data_in_sr(data_reg_width - 2 downto 0) & sdo(1);
			    when "010" => data_in_sr(data_reg_width - 1 downto 0) <= data_in_sr(data_reg_width - 2 downto 0) & sdo(2);
			    when "011" => data_in_sr(data_reg_width - 1 downto 0) <= data_in_sr(data_reg_width - 2 downto 0) & sdo(3);
			    when "100" => data_in_sr(data_reg_width - 1 downto 0) <= data_in_sr(data_reg_width - 2 downto 0) & sdo(4);
				when others => data_in_sr(data_reg_width - 1 downto 0) <= (others => '0'); 
			  end case;
          end if;
      end if;   
   end if; 
end process;

process(clk_in)
begin
   if rising_edge(clk_in) then
      if (rst_n_reg = '0') then
         data_out <= (others => '0');
      elsif (ser_sr_cntr = 0)  and (ser_clk_cntr = "00000") and
         (rd_strch = '1') then
		    if (data_len = '0') then
               data_out <= x"00" & data_in_sr(7 downto 0);
			else
               data_out <= data_in_sr;
			end if;
      end if;
      if (rst_n_reg = '0') then
         rd_strch <= '0';
      elsif rd_pls = '1' then
         rd_strch <= '1';
      elsif (ser_sr_cntr = 0)  and (ser_clk_cntr = "00000") then
         rd_strch <= '0';
      end if;
   end if;
end process;
 
process(clk_in) begin
    if(rising_edge(clk_in)) then
        if(rst_n_reg = '0') then
            oe <= '0';
        elsif(spi_mode = '0') then
            oe <= '1'; 
        else
            if (wr_pls = '1' or rd_pls = '1') then
                oe <= '1';
            elsif (rd_strch = '1' and (ser_sr_cntr = (data_out_sr_width - addr_reg_width))  and (ser_clk_cntr = "11000")) then
                oe <= '0';
            elsif (wr_strch = '1' and (ser_sr_cntr = 0) and (ser_clk_cntr = "00000")) then
                oe <= '0';
            end if;            
        end if;
    end if;

end process;

-------------------------------------------------------------------------------
-- Output Signals to serial interface
-------------------------------------------------------------------------------
process(clk_in)
begin
   if rising_edge(clk_in) then  
      if (rst_n_reg = '0') then
         w_sdi       <= '1';
         r_sdenb     <= (others => '1');
      else   
         w_sdi       <= data_out_sr(data_out_sr_width - 1);
	     case dev_sel is
	       when "000" => 
              r_sdenb(0)  <=  sr_cntr_tc;
	   	      r_sdenb(1)  <=  '1';
		      r_sdenb(2)  <=  '1';
		      r_sdenb(3)  <=  '1';
		      r_sdenb(4)  <=  '1';
	       when "001" => 
              r_sdenb(0)  <=  '1';
		      r_sdenb(1)  <=  sr_cntr_tc;
		      r_sdenb(2)  <=  '1';
		      r_sdenb(3)  <=  '1';
		      r_sdenb(4)  <=  '1';
	       when "010" => 
              r_sdenb(0)  <=  '1';
		      r_sdenb(1)  <=  '1';
		      r_sdenb(2)  <=  sr_cntr_tc;
		      r_sdenb(3)  <=  '1';
		      r_sdenb(4)  <=  '1';
	       when "011" => 
              r_sdenb(0)  <=  '1';
		      r_sdenb(1)  <=  '1';
		      r_sdenb(2)  <=  '1';
		      r_sdenb(3)  <=  sr_cntr_tc;
		      r_sdenb(4)  <=  '1';
	       when "100" => 
              r_sdenb(0)  <=  '1';
		      r_sdenb(1)  <=  '1';
		      r_sdenb(2)  <=  '1';
		      r_sdenb(3)  <=  '1';
		      r_sdenb(4)  <=  sr_cntr_tc;
          when others => 
		      r_sdenb(0)  <=  '1';
		      r_sdenb(1)  <=  '1';
		      r_sdenb(2)  <=  '1';
		      r_sdenb(3)  <=  '1';
		      r_sdenb(4)  <=  '1';
         end case;
      end if;
      if (rst_n_reg = '0') then
         r_sclk  <= '0';
      elsif (ser_clk_cntr(4) = '1') and (sr_cntr_tc = '0') and
         (ser_sr_cntr /= 0) then
         r_sclk <= '1';
      else
         r_sclk <= '0';
      end if;
   end if;
end process;

oe_tri <= not oe;

IOBUF_inst : IOBUF
   port map (
      O => r_sdi,   -- 1-bit output: Buffer output
      I => w_sdi,   -- 1-bit input: Buffer input
      IO => sdi,    -- 1-bit inout: Buffer inout (connect directly to top-level port)
      T => oe_tri   -- 1-bit input: 3-state enable input
   );

--<= w_sdi when oe = '1' else 'Z';  
sdenb     <= r_sdenb;
sclk      <= r_sclk; 


end Behavioral;