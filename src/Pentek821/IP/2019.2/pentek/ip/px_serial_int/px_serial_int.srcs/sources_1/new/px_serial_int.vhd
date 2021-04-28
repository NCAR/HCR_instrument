----------------------------------------------------------------------------------
-- Company: Pentek 
-- Engineer: 
-- 
-- Create Date: 05/05/2017 
-- Design Name: px_serial_int 
-- Module Name: px_serial_int - Behavioral
-- Project Name: Navigator FPGA Kit
-- Target Devices: 
-- Tool Versions: Vivado 2016.4
-- Description: 
-- This module was created in combination with generics based on previous
-- pentek designs that used SPI interfaces with various configurations. The
-- generics allow for any configuration between data and addr width to be
-- used
--
-- Dependencies: 
-- Px_serial_int Local interface should be used with pentek control and status 
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

entity px_serial_int is
generic 
(
   -- Set Data and Addr width based on external device SPI interface
   data_reg_width : integer := 16;
   addr_reg_width : integer := 16;
   
   -- 0 - to use module as a three wire interface
   -- 1 - to use module as a four wire interface
   bustype_3wire_4wire    : std_logic := '0';
   
   -- 0 - for RD = '1' and Write = '0' the write/read polarity on SDI bus line
   -- 1 - for RD = '0' and Write = '1' the write/read polarity on SDI bus line
   RD_WR_POL      : std_logic := '0' 
);
port 
(
   -- internal interface signals
   clk_in    : in  std_logic; 
   rst_n     : in  std_logic;
   data_in   : in  std_logic_vector(data_reg_width - 1 downto 0);
   addr      : in  std_logic_vector(addr_reg_width - 1 downto 0);
   wr        : in  std_logic;
   rd        : in  std_logic;
   data_out  : out std_logic_vector(data_reg_width - 1 downto 0);
   sm_rdy    : out std_logic;
   -- serial interface signals
   sdi       : inout std_logic;
   sdenb     : out std_logic;
   sclk      : out std_logic;
   sdo       : in  std_logic
);
end px_serial_int;

architecture Behavioral of px_serial_int is

-------------------------------------------------------------------------------
-- Signals
-------------------------------------------------------------------------------

constant data_out_sr_width : integer := data_reg_width + addr_reg_width + 1;

signal rst_n_reg     : std_logic;

signal wr_reg1       : std_logic;
signal wr_reg2       : std_logic;
signal wr_pls        : std_logic;

signal rd_reg1       : std_logic;
signal rd_reg2       : std_logic;
signal rd_pls        : std_logic;

signal ser_clk_cntr  : std_logic_vector(4 downto 0);
signal ser_sr_cntr   : integer := data_out_sr_width;
signal sr_cntr_tc    : std_logic;
signal data_out_sr   : std_logic_vector(data_out_sr_width - 1 downto 0);
signal data_in_sr    : std_logic_vector(data_reg_width - 1 downto 0);
signal rd_strch      : std_logic;
signal wr_strch      : std_logic;
signal w_sdi         : std_logic;
signal r_sdi         : std_logic;
signal r_sdenb       : std_logic;
signal r_sclk        : std_logic;

signal oe            : std_logic;
signal oe_tri        : std_logic; 

signal data_in_zero  : std_logic_vector(data_reg_width - 1 downto 0) := (others => '0');

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

begin

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
         data_out_sr(data_out_sr_width - 1 downto 0) <= (not RD_WR_POL and rd_pls) & addr & data_in_zero;
      elsif (wr_pls = '1') then
         data_out_sr(data_out_sr_width - 1 downto 0) <= (RD_WR_POL and wr_pls) & addr & data_in;
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
          if(bustype_3wire_4wire = '0') then
              data_in_sr(data_reg_width - 1 downto 0) <= data_in_sr(data_reg_width - 2 downto 0) & r_sdi;
          else
              data_in_sr(data_reg_width - 1 downto 0) <= data_in_sr(data_reg_width - 2 downto 0) & sdo;
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
         data_out <= data_in_sr;
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
        elsif(bustype_3wire_4wire = '1') then
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
         r_sdenb     <= '1';
      else   
      w_sdi       <= data_out_sr(data_out_sr_width - 1);
      r_sdenb     <= sr_cntr_tc;
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
      IO => sdi, -- 1-bit inout: Buffer inout (connect directly to top-level port)
      T => oe_tri    -- 1-bit input: 3-state enable input
   );

--<= w_sdi when oe = '1' else 'Z';  
sdenb     <= r_sdenb;
sclk      <= r_sclk; 


end Behavioral;