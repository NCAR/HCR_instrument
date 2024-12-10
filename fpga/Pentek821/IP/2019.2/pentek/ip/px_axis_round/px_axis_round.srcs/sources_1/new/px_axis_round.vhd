----------------------------------------------------------------------------------
-- Company: Pentek, Inc.
-- Engineer: 
-- 
-- Create Date: 05/20/2015 08:32:05 AM
-- Design Name: 
-- Module Name: px_axis_round - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: AXI-S Data Rounding Function 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- Round Type 
    --0 = Round to nearest (.5 rounds up)
   -- 1 = Round to nearest Even (.5 rounds to closest even number)
   -- 2 = Symetric Rounding (symetric around zero).
----------------------------------------------------------------------------------

-- (c) Copyright 2015 Pentek, Inc. All rights reserved.
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
--------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity px_axis_round is
generic (
   in_data_width  : integer := 24;
   out_data_width : integer := 16;
   rnd_type       : integer := 2;  -- 0 = Round to nearest (.5 rounds up)
                                   -- 1 = Round to nearest Even
                                   -- (.5 rounds to closest even number)
                                   -- 2 = Symetric Rounding (symetric
                                   --     around zero)
   has_tready     : boolean := false; -- When false, m_axis_tready has no effect (always ready)
   has_tuser      : boolean := false; -- Has tuser streams
   tuser_width    : integer := 1;     -- Number of bits in tuser  
   has_sat_out    : boolean := false
);
port ( 
   axis_aclk      : in  std_logic;                                   
   axis_aresetn   : in  std_logic; 
   -----------------------------------------------------------------------------
   -- Input AXI-S Slave
   -----------------------------------------------------------------------------                                  
   s_axis_tdata   : in  std_logic_vector (in_data_width-1 downto 0);
   s_axis_tuser   : in  std_logic_vector (tuser_width-1 downto 0); 
   s_axis_tvalid  : in  std_logic;
   s_axis_tready  : out std_logic;                                   
   -----------------------------------------------------------------------------
   -- Output AXI-S Master
   -----------------------------------------------------------------------------
   m_axis_tdata   : out std_logic_vector (out_data_width-1 downto 0);
   m_axis_tuser   : out std_logic_vector (tuser_width-1 downto 0); 
   m_axis_tvalid  : out std_logic;
   m_axis_tready  : in  std_logic;
   -----------------------------------------------------------------------------
   sat_out        : out std_logic                                    
);
end px_axis_round;

architecture Behavioral of px_axis_round is

--------------------------------------------------------------------------------
-- Attributes
--------------------------------------------------------------------------------

ATTRIBUTE X_INTERFACE_INFO : STRING;
ATTRIBUTE X_INTERFACE_PARAMETER : STRING;

ATTRIBUTE X_INTERFACE_INFO of axis_aclk: SIGNAL is "xilinx.com:signal:clock:1.0 axis_aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of axis_aclk: SIGNAL is "ASSOCIATED_BUSIF s_axis:m_axis, ASSOCIATED_RESET axis_aresetn";

--------------------------------------------------------------------------------
-- Signals
--------------------------------------------------------------------------------

signal dat : std_logic_vector(in_data_width-1 downto 0);
signal userdat: std_logic_vector (tuser_width-1 downto 0); 
signal t1_userdat: std_logic_vector (tuser_width-1 downto 0);
signal round_wrd : std_logic_vector(out_data_width downto 0);
signal round_wrd_sym : std_logic_vector(in_data_width downto 0);
signal sum : std_logic_vector(out_data_width downto 0);
signal sum_sym : std_logic_vector(in_data_width downto 0);
signal dec_half : std_logic;
signal carry : std_logic;
signal rdy : std_logic := '0'; 
signal pipeline : std_logic_vector(2 downto 0) := "000";
signal t1_axis_aresetn: std_logic := '0'; 

--------------------------------------------------------------------------------
-- Constants
--------------------------------------------------------------------------------

constant zeros : std_logic_vector(in_data_width -1 downto 0) := (others => '0');

--------------------------------------------------------------------------------

begin

gen_rdy: if (has_tready = true) generate
rdy <= m_axis_tready;
end generate;

gen_nordy: if (has_tready = false) generate
rdy <= '1';
end generate;

rnd_wrd_upper01_gen: if ((rnd_type = 0) or (rnd_type = 1)) generate  
round_wrd(out_data_width downto 1) <= (others => '0');
end generate;

rnd_wrd_upper2_gen: if (rnd_type = 2) generate  
round_wrd_sym(in_data_width downto (in_data_width- out_data_width - 1)) <= (others => '0');
round_wrd_sym((in_data_width - out_data_width -2) downto 0) <= (others => '1');
carry <= not dat(in_data_width - 1);
end generate;

rnd_wrd_n_gen: if ((rnd_type = 0) or ((rnd_type = 1) and ((in_data_width - out_data_width)= 1))) generate
   round_wrd(0) <= dat((in_data_width - out_data_width) -1);
   carry <= '0';
end generate;

rnd_wrd_ne_gen: if ((rnd_type = 1) and ((in_data_width - out_data_width)> 1))  generate
   dec_half <= '1' when ( (dat(((in_data_width - out_data_width) -1)         )='1') and
                          (dat(((in_data_width - out_data_width) -2) downto 0)= zeros(((in_data_width - out_data_width) -2) downto 0))) else '0';
   round_wrd(0) <= '1' when (((dec_half = '1') and (dat((in_data_width - out_data_width))= '1' ))  or ((dec_half = '0') and (dat((in_data_width - out_data_width) -1)= '1' ))) else '0';
   carry <= '0';
end generate;

--------------------------------------------------------------------------------
-- Calculation Pipeline
--------------------------------------------------------------------------------

type_01_gen: if ((rnd_type = 0) or (rnd_type = 1)) generate
process(axis_aclk)
begin
   if rising_edge(axis_aclk) then
      if t1_axis_aresetn = '0' then
         dat          <= (others => '0');
         userdat      <= (others => '0');
         t1_userdat   <= (others => '0');
         m_axis_tdata <= (others => '0');
         sat_out      <=  '0';
         pipeline     <= "000";
         sum          <= (others => '0');
      else
         if (s_axis_tvalid = '1') and ((pipeline(1) = '0') or (pipeline(2) = '0') or (rdy = '1')) then
            pipeline(0) <= '1';
            dat         <= s_axis_tdata;
            userdat     <= s_axis_tuser;
         elsif ((pipeline(1) = '0') or (pipeline(2) = '0') or (rdy = '1')) then
            pipeline(0) <= '0';
         end if; 
         if ((pipeline(1) = '0') or (pipeline(2) = '0') or (rdy = '1')) then
            pipeline(1) <= pipeline(0);
            if pipeline(0) = '1' then
               sum <= dat(in_data_width-1) & dat(in_data_width-1 downto ((in_data_width - out_data_width)) ) + round_wrd + carry;
               t1_userdat     <= userdat;
            end if;   
         end if;    
         if (pipeline(2) = '0') or (rdy = '1') then
            pipeline(2) <= pipeline(1);
            if pipeline(1) = '1' then
               if sum(out_data_width) = sum(out_data_width-1) then
                  m_axis_tdata <= sum(out_data_width-1 downto 0);
                  sat_out <= '0';
               else   -- saturate
                  m_axis_tdata(out_data_width-1) <= sum(out_data_width);
                  if sum(out_data_width) = '0' then
                     m_axis_tdata(out_data_width-2 downto 0) <= (others => '1');
                  else
                     m_axis_tdata(out_data_width-2 downto 0) <= (others => '0');
                  end if;
                  sat_out <= '1';
               end if;
               m_axis_tuser <= t1_userdat;
            end if;
         end if;   
      end if;
   end if;
end process;

end generate;

type_2_gen: if (rnd_type = 2) generate
process(axis_aclk)
begin
   if rising_edge(axis_aclk) then
      if t1_axis_aresetn = '0' then
         dat          <= (others => '0');
         userdat      <= (others => '0');
         t1_userdat   <= (others => '0');
         m_axis_tdata <= (others => '0');
         sat_out      <=  '0';
         pipeline     <= "000";      
         sum_sym      <= (others => '0');
      else
         if (s_axis_tvalid = '1') and ((pipeline(1) = '0') or (pipeline(2) = '0') or (rdy = '1')) then
            pipeline(0) <= '1';
            dat         <= s_axis_tdata;
            userdat     <= s_axis_tuser;
         elsif ((pipeline(1) = '0') or (pipeline(2) = '0') or (rdy = '1')) then
            pipeline(0) <= '0';
         end if; 
         if ((pipeline(1) = '0') or (pipeline(2) = '0') or (rdy = '1')) then
            pipeline(1) <= pipeline(0);
            if pipeline(0) = '1' then
               sum_sym <= dat(in_data_width-1) & dat(in_data_width-1 downto 0) + round_wrd_sym + carry;
               t1_userdat     <= userdat;
            end if;   
         end if;    
         if (pipeline(2) = '0') or (rdy = '1') then
            pipeline(2) <= pipeline(1);
            if pipeline(1) = '1' then
               if sum_sym(in_data_width) = sum_sym(in_data_width-1) then
                  m_axis_tdata <= sum_sym(in_data_width-1 downto (in_data_width- out_data_width));
                  sat_out  <= '0';
               else   -- saturate
                  m_axis_tdata(out_data_width-1) <= sum_sym(in_data_width);
                  if sum_sym(in_data_width) = '0' then
                     m_axis_tdata(out_data_width-2 downto 0) <= (others => '1');
                  else
                     m_axis_tdata(out_data_width-2 downto 0) <= (others => '0');
                  end if;
                  sat_out <= '1';
               end if;
               m_axis_tuser <= t1_userdat;
            end if;
         end if;   
      end if;
   end if;
end process;

end generate;

m_axis_tvalid <= pipeline(2);
s_axis_tready <= '1' when ((pipeline /= "111") or (rdy = '1')) else '0';

process(axis_aclk)
begin
   if rising_edge(axis_aclk) then
      t1_axis_aresetn <= axis_aresetn;
   end if;
end process;      

end Behavioral;
