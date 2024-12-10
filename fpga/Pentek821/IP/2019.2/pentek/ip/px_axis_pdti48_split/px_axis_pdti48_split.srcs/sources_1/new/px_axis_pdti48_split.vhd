----------------------------------------------------------------------------------
-- Pentek DES/Non-DES AXI Data Stream Channel Splitter 
----------------------------------------------------------------------------------
-- px_axis_pdti48_split.vhd
--
-- Target Device: Kintex UltraScale
--
-- Pentek Inc.
-- One Park Way, Upper Saddle River, NJ 07458
-- (201)818-5900
-- www.pentek.com
--
-- Copyright Pentek, Inc. 2016
--
-- Revision:
-- Revision 0.01 - File Created
-- Revision 1.0  - Fixed Non-Des Gate/SYNC/PPS


-- Additional Comments: 
-- This core receives a PDTI AXI-Stream that comes from an ADC that has a
-- Dual 4 samples per cycle or Single 8 samples per cycle format.   
-- It splits it in the Dual channel mode (Non-DES) into two Single Channel
-- 8 samples/cycle output streams at half the rate.
-- In Single channel mode (DES), it just makes two copies of the input
-- data stream. 

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

-- (c) Copyright 2016 Pentek, Inc. All rights reserved.
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

-------------------------------------------------------------------------------
-- Libraries
-------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity px_axis_pdti48_split is
port (
    -----------------------------------------------------------------------------
     aclk              : in  std_logic; -- AXI Stream Clock
     aresetn           : in  std_logic;
     -----------------------------------------------------------------------------
     -- Input Data Data/Time/Info Stream (AXI4-Stream Slave) no back pressure
     -----------------------------------------------------------------------------
     -- tuser[63:0]    = timestamp[63:0]
     -- tuser[71:64]   = Gate Positions  
     -- tuser[79:72]   = Sync Positions    
     -- tuser[87:80]   = PPS  Positions  
     -- tuser[91:88]   = Samples/Cycle
     -- tuser[92]      = IQ of first sample in data 0 = I, 1 = Q
     -- tuser[94:93]   = Data Format 0 = 8-bit 1= 16 bit 3 = 32-bit
     -- tuser[95]      = Data Type 0 = Real 1 = I/Q
     -- tuser[103:96]  = channel[7:0] 
     -- tuser[127:104] = Reserved
     
     -- DES Mode: 
     -- One Channel 8 samples/cycle
     -- Non-Des Mode:
     -- Ch1 4 samples/cycle,Ch0 4 samples/cycle  
     s_axis_pdti_tdata  : in  std_logic_vector(127 downto 0);  
     s_axis_pdti_tuser  : in  std_logic_vector(127 downto 0);
     s_axis_pdti_tvalid : in  std_logic;
     -----------------------------------------------------------------------------
     -- Output Data Data/Time/Info Stream (AXI4-Stream Slave) no back pressure
     -----------------------------------------------------------------------------  
     -- tuser[63:0]    = timestamp[63:0]
     -- tuser[71:64]   = Gate Positions  
     -- tuser[79:72]   = Sync Positions    
     -- tuser[87:80]   = PPS  Positions  
     -- tuser[91:88]   = Samples/Cycle
     -- tuser[92]      = IQ of first sample in data 0 = I, 1 = Q
     -- tuser[94:93]   = Data Format 0 = 8-bit 1= 16 bit 3 = 32-bit
     -- tuser[95]      = Data Type 0 = Real 1 = I/Q
     -- tuser[103:96]  = channel[7:0] 
     -- tuser[127:104] = Reserved 
     -----------
     --Channel 0 out 
     -- 8 samples/cycle 
     m_axis_pdti_ch0_tdata  : out  std_logic_vector(127 downto 0);  
     m_axis_pdti_ch0_tuser  : out  std_logic_vector(127 downto 0);
     m_axis_pdti_ch0_tvalid : out  std_logic;
     -----------
     -- Non-Des Mode - Channel 1 out
     -- Des Mode - Copy of Channel 0 
     -- 8 samples/cycle      
     m_axis_pdti_ch1_tdata  : out  std_logic_vector(127 downto 0);  
     m_axis_pdti_ch1_tuser  : out  std_logic_vector(127 downto 0);
     m_axis_pdti_ch1_tvalid : out  std_logic;           
      --    
     des_ctl                : in std_logic 
);
end px_axis_pdti48_split;

architecture Behavioral of px_axis_pdti48_split is

--------------------------------------------------------------------------------
-- Attributes
--------------------------------------------------------------------------------

ATTRIBUTE X_INTERFACE_INFO : STRING;
ATTRIBUTE X_INTERFACE_PARAMETER : STRING;

ATTRIBUTE X_INTERFACE_INFO of aclk: SIGNAL is "xilinx.com:signal:clock:1.0 aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of aclk: SIGNAL is "ASSOCIATED_BUSIF s_axis_pdti:m_axis_pdti_ch0:m_axis_pdti_ch1, ASSOCIATED_RESET aresetn";

--------------------------------------------------------------------------------
-- Signals
--------------------------------------------------------------------------------
signal hr                   : std_logic := '0';
signal a_tdata              : std_logic_vector(127 downto 0) := (others => '0'); 
signal b_tdata              : std_logic_vector(127 downto 0) := (others => '0');
signal a_tuser              : std_logic_vector(127 downto 0) := (others => '0'); 
signal b_tuser              : std_logic_vector(127 downto 0) := (others => '0');
signal t1_s_axis_pdti_tdata : std_logic_vector(127 downto 0) := (others => '0');   
signal t1_s_axis_pdti_tuser : std_logic_vector(127 downto 0) := (others => '0');   
signal t1_s_axis_pdti_tvalid: std_logic := '0';                        
signal a_tvalid             : std_logic := '0';
signal t1_des_ctl           : std_logic := '0';

--------------------------------------------------------------------------------

begin

process(aclk)
begin
    if rising_edge(aclk) then
        t1_s_axis_pdti_tdata   <= s_axis_pdti_tdata;
        t1_s_axis_pdti_tuser   <= s_axis_pdti_tuser;
        t1_s_axis_pdti_tvalid  <= s_axis_pdti_tvalid; 
        t1_des_ctl             <= des_ctl;
        
        m_axis_pdti_ch0_tdata  <= a_tdata;
        m_axis_pdti_ch0_tuser  <= a_tuser;
        m_axis_pdti_ch0_tvalid <= a_tvalid;
        
        m_axis_pdti_ch1_tdata  <= b_tdata;
        m_axis_pdti_ch1_tuser  <= b_tuser;
        m_axis_pdti_ch1_tvalid <= a_tvalid;
        
        if (aresetn = '0') then
            hr       <= '0';
            a_tvalid <= '0'; 
        else
            if t1_s_axis_pdti_tvalid = '1' then
            --------------------------------------------------------------------
            -- DES 1 Channel
            --------------------------------------------------------------------
                if t1_des_ctl = '1' then -- DES 1 Channel
                    a_tdata(127 downto 0)   <= t1_s_axis_pdti_tdata(127 downto 0);
                    b_tdata(127 downto 0)   <= t1_s_axis_pdti_tdata(127 downto 0);
                    a_tuser                 <= t1_s_axis_pdti_tuser;
                    b_tuser                 <= t1_s_axis_pdti_tuser; 
                    a_tvalid                <= '1';
                    hr                      <= '0';  
            --------------------------------------------------------------------
            -- Non-DES 2 Channel
            --------------------------------------------------------------------
            -- tuser[71:64]   = Gate Positions  
            -- tuser[79:72]   = Sync Positions    
            -- tuser[87:80]   = PPS  Positions  
                else  
                    if hr = '0' then
                        a_tdata(63 downto 0)    <= t1_s_axis_pdti_tdata(63 downto 0);
                        b_tdata(63 downto 0)    <= t1_s_axis_pdti_tdata(127 downto 64);
--                        a_tuser(87 downto 0)    <= t1_s_axis_pdti_tuser(87 downto 0);
--                        b_tuser(87 downto 0)    <= t1_s_axis_pdti_tuser(87 downto 0);
                        a_tuser(63 downto 0)    <= t1_s_axis_pdti_tuser(63 downto 0);
                        b_tuser(63 downto 0)    <= t1_s_axis_pdti_tuser(63 downto 0);
                        
                        a_tuser(64)             <= t1_s_axis_pdti_tuser(64);
                        b_tuser(64)             <= t1_s_axis_pdti_tuser(64); 
                        a_tuser(65)             <= t1_s_axis_pdti_tuser(66);
                        b_tuser(65)             <= t1_s_axis_pdti_tuser(66);
                        a_tuser(66)             <= t1_s_axis_pdti_tuser(68);
                        b_tuser(66)             <= t1_s_axis_pdti_tuser(68);      
                        a_tuser(67)             <= t1_s_axis_pdti_tuser(70);
                        b_tuser(67)             <= t1_s_axis_pdti_tuser(70); 
                        
                        a_tuser(72)             <= t1_s_axis_pdti_tuser(72);
                        b_tuser(72)             <= t1_s_axis_pdti_tuser(72); 
                        a_tuser(73)             <= t1_s_axis_pdti_tuser(74);
                        b_tuser(73)             <= t1_s_axis_pdti_tuser(74);
                        a_tuser(74)             <= t1_s_axis_pdti_tuser(76);
                        b_tuser(74)             <= t1_s_axis_pdti_tuser(76);      
                        a_tuser(75)             <= t1_s_axis_pdti_tuser(78);
                        b_tuser(75)             <= t1_s_axis_pdti_tuser(78);   
                        
                        a_tuser(80)             <= t1_s_axis_pdti_tuser(80);
                        b_tuser(80)             <= t1_s_axis_pdti_tuser(80); 
                        a_tuser(81)             <= t1_s_axis_pdti_tuser(82);
                        b_tuser(81)             <= t1_s_axis_pdti_tuser(82);
                        a_tuser(82)             <= t1_s_axis_pdti_tuser(84);
                        b_tuser(82)             <= t1_s_axis_pdti_tuser(84);      
                        a_tuser(83)             <= t1_s_axis_pdti_tuser(86);
                        b_tuser(83)             <= t1_s_axis_pdti_tuser(86);    
                                                                
                        a_tuser(91 downto 88)   <= "1000"; 
                        b_tuser(91 downto 88)   <= "1000"; 
                        a_tuser(127 downto 92)  <= t1_s_axis_pdti_tuser(127 downto 92);
                        b_tuser(127 downto 92)  <= t1_s_axis_pdti_tuser(127 downto 92);
                        hr                      <= '1';
                        a_tvalid                <= '0';
                    else
                        a_tdata(127 downto 64)  <= t1_s_axis_pdti_tdata(63 downto 0);
                        b_tdata(127 downto 64)  <= t1_s_axis_pdti_tdata(127 downto 64);
                        
                        a_tuser(68)             <= t1_s_axis_pdti_tuser(64);
                        b_tuser(68)             <= t1_s_axis_pdti_tuser(64); 
                        a_tuser(69)             <= t1_s_axis_pdti_tuser(66);
                        b_tuser(69)             <= t1_s_axis_pdti_tuser(66);
                        a_tuser(70)             <= t1_s_axis_pdti_tuser(68);
                        b_tuser(70)             <= t1_s_axis_pdti_tuser(68);      
                        a_tuser(71)             <= t1_s_axis_pdti_tuser(70);
                        b_tuser(71)             <= t1_s_axis_pdti_tuser(70);
                        
                        a_tuser(76)             <= t1_s_axis_pdti_tuser(72);
                        b_tuser(76)             <= t1_s_axis_pdti_tuser(72); 
                        a_tuser(77)             <= t1_s_axis_pdti_tuser(74);
                        b_tuser(77)             <= t1_s_axis_pdti_tuser(74);
                        a_tuser(78)             <= t1_s_axis_pdti_tuser(76);
                        b_tuser(78)             <= t1_s_axis_pdti_tuser(76);      
                        a_tuser(79)             <= t1_s_axis_pdti_tuser(78);
                        b_tuser(79)             <= t1_s_axis_pdti_tuser(78);  
                        
                        a_tuser(84)             <= t1_s_axis_pdti_tuser(80);
                        b_tuser(84)             <= t1_s_axis_pdti_tuser(80); 
                        a_tuser(85)             <= t1_s_axis_pdti_tuser(82);
                        b_tuser(85)             <= t1_s_axis_pdti_tuser(82);
                        a_tuser(86)             <= t1_s_axis_pdti_tuser(84);
                        b_tuser(86)             <= t1_s_axis_pdti_tuser(84);      
                        a_tuser(87)             <= t1_s_axis_pdti_tuser(86);
                        b_tuser(87)             <= t1_s_axis_pdti_tuser(86);  
                        
                        a_tvalid                <= '1';
                        hr <= '0';                
                    end if;   
                end if;      
            else
                a_tvalid <= '0';
            end if;  
        end if;
    end if;
end process;    


end Behavioral;
