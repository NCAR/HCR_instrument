----------------------------------------------------------------------------------
-- Pentek Data Stream to HMC DMA Input Width Converter
----------------------------------------------------------------------------------
-- ptk_dma_strm2hmc_width_conv.vhd
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

entity px_dma_ppkt2pcie_width_conv is
generic (
    WORD_WIDTH : integer := 16; -- must be 1,2,4,8,16,32 (number of 16-bit words)
    LITE       : boolean := false -- false = 512 output, true = 256 output 
    -- When output width = 256, the upper 256 bits of 512-bit output are zero.
    -- WORD_WIDTH of 32 not valid for LITE mode
);
port (
    ----------------------------------------------------------------------------
    -- Input - Variable Width
    ----------------------------------------------------------------------------
    s_aclk          : in  std_logic;
    s_aresetn       : in  std_logic;
    s_axis_tvalid   : in  std_logic;
    s_axis_tready   : out std_logic;
    s_axis_tdata    : in  std_logic_vector((WORD_WIDTH*16)-1 downto 0);
    -- tuser[63:0]    = timestamp[63:0]  
    -- tuser[64]      = SOP   
    -- tuser[66:65]   = Data Format 0 = 8-bit 1= 16 bit 2 = 32-bit
    -- tuser[67]      = Data Type 0 = Real 1 = I/Q
    -- tuser[75:68]   = channel[7:0] 
    -- tuser[79:76]   = user[3:0] 
    s_axis_tuser    : in  std_logic_vector(79 downto 0);
    s_axis_tkeep    : in  std_logic_vector(WORD_WIDTH-1 downto 0); -- One per 16-bit word
    s_axis_tlast    : in  std_logic;
    ----------------------------------------------------------------------------
    -- Output 512 wide
    ----------------------------------------------------------------------------
    m_axis_tvalid   : out std_logic;
    m_axis_tready   : in  std_logic;
    m_axis_tdata    : out std_logic_vector(511 downto 0);
    -- tuser[63:0]    = timestamp[63:0]  
    -- tuser[64]      = SOP   
    -- tuser[66:65]   = Data Format 0 = 8-bit 1= 16 bit 2 = 32-bit
    -- tuser[67]      = Data Type 0 = Real 1 = I/Q
    -- tuser[75:68]   = channel[7:0]  
    -- tuser[79:76]   = user
    -- tuser[87:80]   = valid bytes   
    m_axis_tuser    : out std_logic_vector(87 downto 0);
    m_axis_tlast    : out std_logic
  );
end px_dma_ppkt2pcie_width_conv;

architecture Behavioral of px_dma_ppkt2pcie_width_conv is

--------------------------------------------------------------------------------
-- Components
--------------------------------------------------------------------------------

-- Xilinx Core Code extracted to allow variable width
component px_axis_dwidth_converter
generic (
     C_FAMILY : string := "kintexu";
     C_S_AXIS_TDATA_WIDTH : integer := (WORD_WIDTH*16);
     C_S_AXIS_TUSER_WIDTH : integer := 1;
     C_M_AXIS_TDATA_WIDTH : integer := 512;
     C_M_AXIS_TUSER_WIDTH : integer := (512/(WORD_WIDTH*16));
     C_AXIS_SIGNAL_SET : std_logic_vector := "00000000000000000000000000010011"
  ); 
port (
    aclk          : in std_logic;
    aresetn       : in std_logic;
    aclken        : in std_logic;
    s_axis_tvalid : in std_logic;
    s_axis_tid    : in std_logic_vector(0 downto 0);
    s_axis_tdest  : in std_logic_vector(0 downto 0);
    s_axis_tkeep  : in std_logic_vector(C_S_AXIS_TDATA_WIDTH/8-1 downto 0);
    s_axis_tstrb  : in std_logic_vector(C_S_AXIS_TDATA_WIDTH/8-1 downto 0); 
    s_axis_tready : out std_logic;
    s_axis_tdata  : in std_logic_vector(C_S_AXIS_TDATA_WIDTH-1 downto 0);
    s_axis_tlast  : in std_logic;
    s_axis_tuser  : in std_logic_vector(C_S_AXIS_TUSER_WIDTH-1 downto 0); 
    m_axis_tid    : out std_logic_vector(0 downto 0);
    m_axis_tvalid : out std_logic;
    m_axis_tready : in std_logic;
    m_axis_tdata  : out std_logic_vector(C_M_AXIS_TDATA_WIDTH-1 downto 0);
    m_axis_tlast  : out std_logic;
    m_axis_tkeep  : out std_logic_vector((C_M_AXIS_TDATA_WIDTH/8)-1 downto 0);
    m_axis_tstrb  : out std_logic_vector((C_M_AXIS_TDATA_WIDTH/8)-1 downto 0);
    m_axis_tdest  : out std_logic_vector(0 downto 0);
    m_axis_tuser  : out std_logic_vector(C_M_AXIS_TUSER_WIDTH-1 downto 0)
  );
end component;

COMPONENT px_dma_ppkt2pcie_userdata_fifo
  PORT (
    s_aclk : IN STD_LOGIC;
    s_aresetn : IN STD_LOGIC;
    s_axis_tvalid : IN STD_LOGIC;
    s_axis_tready : OUT STD_LOGIC;
    s_axis_tdata : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    s_axis_tuser : IN STD_LOGIC_VECTOR(79 DOWNTO 0);
    m_axis_tvalid : OUT STD_LOGIC;
    m_axis_tready : IN STD_LOGIC;
    m_axis_tdata : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    m_axis_tuser : OUT STD_LOGIC_VECTOR(79 DOWNTO 0)
  );
END COMPONENT;

--------------------------------------------------------------------------------
-- Signals
--------------------------------------------------------------------------------

signal tkeepx: std_logic_vector(16 downto 0);
signal valid_bytes: integer;
signal cntr: std_logic_vector(5 downto 0);
signal vb : std_logic_vector(7 downto 0); 
signal cntr_usr_valid: std_logic; 
signal cntr_end: std_logic;
signal user_tvalid : std_logic;  
signal last_tvalid: std_logic;
signal last_tdata: std_logic_vector(7 downto 0); 
signal out_tready: std_logic;
signal s_axis_tready_int: std_logic;
signal m_axis_tvalid_int: std_logic;
signal tkeep: std_logic_vector(WORD_WIDTH*2-1 downto 0);
signal user_reg : std_logic_vector(79 downto 0);
signal user_data : std_logic_vector(79 downto 0);

--------------------------------------------------------------------------------
-- Constants
-------------------------------------------------------------------------------- 
 
constant incr_val : integer := WORD_WIDTH * 2;

---------------------------------------------------------------------------------

begin

--------------------------------------------------------------------------------
-- 512 Output Width
--------------------------------------------------------------------------------

nlt: if (LITE= false) generate

-- Up Size if word width is less than 512 bits (32 Words)
n512: if (WORD_WIDTH /= 32) generate

tkeepx(WORD_WIDTH-1 downto 0) <= s_axis_tkeep;
tkeepx(16 downto WORD_WIDTH) <= (others => '0'); 

process(tkeepx)
begin
        if tkeepx(15 downto 12) /= 0 then
            if tkeepx(15) = '1' then
                valid_bytes <= 32;
            elsif tkeepx(14) = '1' then
                valid_bytes <= 30;
            elsif tkeepx(13) = '1' then
                valid_bytes <= 28;
            else
                valid_bytes <= 26;
            end if;
        elsif tkeepx(11 downto 8) /= 0 then
            if tkeepx(11) = '1' then
                valid_bytes <= 24;
            elsif tkeepx(10) = '1' then
                valid_bytes <= 22;
            elsif tkeepx(9) = '1' then
                valid_bytes <= 20;
            else
                valid_bytes <= 18;
            end if;    
        elsif tkeepx(7 downto 4) /= 0 then
            if tkeepx(7) = '1' then
                valid_bytes <= 16;
            elsif tkeepx(6) = '1' then
                valid_bytes <= 14;
            elsif tkeepx(5) = '1' then
                valid_bytes <= 12;
            else
                valid_bytes <= 10;
            end if;  
         else
            if tkeepx(3) = '1' then
                valid_bytes <= 8;
            elsif tkeepx(2) = '1' then
                valid_bytes <= 6;
            elsif tkeepx(1) = '1' then
                valid_bytes <= 4;
            else
                valid_bytes <= 2;
            end if;
         end if;
end process;  

process(s_aclk)
begin
    if rising_edge(s_aclk) then
        if (s_aresetn = '0') or ((s_axis_tlast= '1') and (s_axis_tvalid = '1')  and (s_axis_tready_int = '1')) or ((cntr_end = '1') and (s_axis_tvalid = '1')  and (s_axis_tready_int = '1')) then
            cntr <= "000000";
            vb   <= "00000000";
        elsif ((s_axis_tvalid = '1')  and (s_axis_tready_int = '1')) then
            cntr <= cntr + 1;
            vb   <= vb + incr_val;
        end if;
    end if;
end process;

gen_1_cntr: if (WORD_WIDTH = 1) generate
cntr_usr_valid <= '1' when (cntr(4 downto 0) = "00000") else '0'; 
cntr_end <= '1' when (cntr(4 downto 0) = "11111") else '0';
end generate; 
gen_2_cntr: if (WORD_WIDTH = 2) generate
cntr_usr_valid <= '1' when (cntr(3 downto 0) = "0000") else '0'; 
cntr_end <= '1' when (cntr(3 downto 0) = "1111") else '0';
end generate;    
gen_4_cntr: if (WORD_WIDTH = 4) generate
cntr_usr_valid <= '1' when (cntr(2 downto 0) = "000") else '0'; 
cntr_end <= '1' when (cntr(2 downto 0) = "111") else '0';
end generate; 
gen_8_cntr: if (WORD_WIDTH = 8) generate
cntr_usr_valid <= '1' when (cntr(1 downto 0) = "00") else '0'; 
cntr_end <= '1' when (cntr(1 downto 0) = "11") else '0';
end generate; 
gen_16_cntr: if (WORD_WIDTH = 16) generate
cntr_usr_valid <= '1' when (cntr(0) = '0') else '0'; 
cntr_end <= '1' when (cntr(0) = '1') else '0';
end generate; 

user_tvalid <= cntr_usr_valid and s_axis_tvalid and s_axis_tready_int;

last_tvalid <= (s_axis_tlast or cntr_end) and s_axis_tvalid and s_axis_tready_int;
last_tdata  <= (vb + valid_bytes) when (s_axis_tlast = '1') else x"40";

out_tready <= m_axis_tvalid_int and m_axis_tready;

s_axis_tready <= s_axis_tready_int;

tkeep <= (others => '1');

process(s_aclk)
begin
    if rising_edge(s_aclk) then
        if user_tvalid = '1' then
            user_reg <= s_axis_tuser;
        end if;
    end if;
end process;

user_data <= user_reg when (user_tvalid = '0') else s_axis_tuser;

widthconv_inst: px_axis_dwidth_converter
generic map (
     C_FAMILY => "kintexu",
     C_S_AXIS_TDATA_WIDTH => (WORD_WIDTH*16),
     C_M_AXIS_TDATA_WIDTH => 512,
     C_S_AXIS_TUSER_WIDTH => 1,
     C_M_AXIS_TUSER_WIDTH => (512/(WORD_WIDTH*16)),
     C_AXIS_SIGNAL_SET => "00000000000000000000000000011011"
  ) 
port map (
    aclk          => s_aclk,
    aresetn       => s_aresetn,
    aclken        => '1',
    s_axis_tvalid => s_axis_tvalid,
    s_axis_tready => s_axis_tready_int,
    s_axis_tdata  => s_axis_tdata,
    s_axis_tlast  => s_axis_tlast,
    s_axis_tid    => "0", 
    s_axis_tkeep  => tkeep, 
    s_axis_tstrb  => tkeep,   
    s_axis_tdest  => "0", 
    s_axis_tuser  => "0",    
    m_axis_tvalid => m_axis_tvalid_int,
    m_axis_tready => m_axis_tready,
    m_axis_tdata  => m_axis_tdata,
    m_axis_tlast  => m_axis_tlast,
    m_axis_tid    => open,
    m_axis_tkeep  => open,
    m_axis_tstrb  => open, 
    m_axis_tdest  => open,
    m_axis_tuser  => open  
  );

m_axis_tvalid <= m_axis_tvalid_int;  

userdata_fifo_inst : px_dma_ppkt2pcie_userdata_fifo
  port map (
    s_aclk          => s_aclk,
    s_aresetn       => s_aresetn,
    s_axis_tvalid   => last_tvalid,
    s_axis_tready   => open,
    s_axis_tdata    => last_tdata,
    s_axis_tuser    => user_data,
    m_axis_tvalid   => open,
    m_axis_tready   => out_tready,
    m_axis_tdata    => m_axis_tuser(87 downto 80),
    m_axis_tuser    => m_axis_tuser(79 downto 0)
  );

end generate n512;

-- Up Size if word width is less than 512 bits (32 Words)
i512: if (WORD_WIDTH = 32) generate

m_axis_tdata               <= s_axis_tdata; 
m_axis_tuser(79 downto 0)  <= s_axis_tuser(79 downto 0);
m_axis_tvalid              <= s_axis_tvalid; 
s_axis_tready              <= m_axis_tready;
m_axis_tlast               <= s_axis_tlast;
m_axis_tuser(87 downto 80) <= (conv_std_logic_vector(valid_bytes, 8)) when (s_axis_tlast = '1') else x"40";

process(s_axis_tkeep)
begin
        if s_axis_tkeep(31 downto 28) /= 0 then
            if s_axis_tkeep(31) = '1' then
                valid_bytes <= 64;
            elsif s_axis_tkeep(30) = '1' then
                valid_bytes <= 62;
            elsif s_axis_tkeep(29) = '1' then
                valid_bytes <= 60;
            else
                valid_bytes <= 58;
            end if;
        elsif s_axis_tkeep(27 downto 24) /= 0 then
            if s_axis_tkeep(27) = '1' then
                valid_bytes <= 56;
            elsif s_axis_tkeep(26) = '1' then
                valid_bytes <= 54;
            elsif s_axis_tkeep(25) = '1' then
                valid_bytes <= 52;
            else
                valid_bytes <= 50;
            end if;
        elsif s_axis_tkeep(23 downto 20) /= 0 then
            if s_axis_tkeep(23) = '1' then
                valid_bytes <= 48;
            elsif s_axis_tkeep(22) = '1' then
                valid_bytes <= 46;
            elsif s_axis_tkeep(21) = '1' then
                valid_bytes <= 44;
            else
                valid_bytes <= 42;
            end if;
        elsif s_axis_tkeep(19 downto 16) /= 0 then
            if s_axis_tkeep(19) = '1' then
                valid_bytes <= 40;
            elsif s_axis_tkeep(18) = '1' then
                valid_bytes <= 38;
            elsif s_axis_tkeep(17) = '1' then
                valid_bytes <= 36;
            else
                valid_bytes <= 34;
            end if;
        elsif s_axis_tkeep(15 downto 12) /= 0 then
            if s_axis_tkeep(15) = '1' then
                valid_bytes <= 32;
            elsif s_axis_tkeep(14) = '1' then
                valid_bytes <= 30;
            elsif s_axis_tkeep(13) = '1' then
                valid_bytes <= 28;
            else
                valid_bytes <= 26;
            end if;
        elsif s_axis_tkeep(11 downto 8) /= 0 then
            if s_axis_tkeep(11) = '1' then
                valid_bytes <= 24;
            elsif s_axis_tkeep(10) = '1' then
                valid_bytes <= 22;
            elsif s_axis_tkeep(9) = '1' then
                valid_bytes <= 20;
            else
                valid_bytes <= 18;
            end if;    
        elsif s_axis_tkeep(7 downto 4) /= 0 then
            if s_axis_tkeep(7) = '1' then
                valid_bytes <= 16;
            elsif s_axis_tkeep(6) = '1' then
                valid_bytes <= 14;
            elsif s_axis_tkeep(5) = '1' then
                valid_bytes <= 12;
            else
                valid_bytes <= 10;
            end if;  
         else
            if s_axis_tkeep(3) = '1' then
                valid_bytes <= 8;
            elsif s_axis_tkeep(2) = '1' then
                valid_bytes <= 6;
            elsif s_axis_tkeep(1) = '1' then
                valid_bytes <= 4;
            else
                valid_bytes <= 2;
            end if;
         end if;
end process;  
 
end generate i512;

end generate nlt;



--------------------------------------------------------------------------------
-- 256 Output Width
--------------------------------------------------------------------------------

lt: if (LITE= true) generate

-- Up Size if word width is less than 512 bits (32 Words)
n256: if (WORD_WIDTH /= 16) generate

tkeepx(WORD_WIDTH-1 downto 0) <= s_axis_tkeep;
tkeepx(16 downto WORD_WIDTH)   <= (others => '0'); 

process(tkeepx)
begin
        if tkeepx(7 downto 4) /= 0 then
            if tkeepx(7) = '1' then
                valid_bytes <= 16;
            elsif tkeepx(6) = '1' then
                valid_bytes <= 14;
            elsif tkeepx(5) = '1' then
                valid_bytes <= 12;
            else
                valid_bytes <= 10;
            end if;  
         else
            if tkeepx(3) = '1' then
                valid_bytes <= 8;
            elsif tkeepx(2) = '1' then
                valid_bytes <= 6;
            elsif tkeepx(1) = '1' then
                valid_bytes <= 4;
            else
                valid_bytes <= 2;
            end if;
         end if;
end process;  

process(s_aclk)
begin
    if rising_edge(s_aclk) then
        if (s_aresetn = '0') or ((s_axis_tlast= '1') and (s_axis_tvalid = '1')  and (s_axis_tready_int = '1')) or ((cntr_end = '1') and (s_axis_tvalid = '1')  and (s_axis_tready_int = '1')) then
            cntr <= "000000";
            vb   <= "00000000";
        elsif ((s_axis_tvalid = '1')  and (s_axis_tready_int = '1')) then
            cntr <= cntr + 1;
            vb   <= vb + incr_val;
        end if;
    end if;
end process;

gen_1_cntr: if (WORD_WIDTH = 1) generate
cntr_usr_valid <= '1' when (cntr(3 downto 0) = "0000") else '0'; 
cntr_end <= '1' when (cntr(3 downto 0) = "1111") else '0';
end generate;    
gen_2_cntr: if (WORD_WIDTH = 2) generate
cntr_usr_valid <= '1' when (cntr(2 downto 0) = "000") else '0'; 
cntr_end <= '1' when (cntr(2 downto 0) = "111") else '0';
end generate; 
gen_4_cntr: if (WORD_WIDTH = 4) generate
cntr_usr_valid <= '1' when (cntr(1 downto 0) = "00") else '0'; 
cntr_end <= '1' when (cntr(1 downto 0) = "11") else '0';
end generate; 
gen_8_cntr: if (WORD_WIDTH = 8) generate
cntr_usr_valid <= '1' when (cntr(0) = '0') else '0'; 
cntr_end <= '1' when (cntr(0) = '1') else '0';
end generate; 

user_tvalid <= cntr_usr_valid and s_axis_tvalid and s_axis_tready_int;

last_tvalid <= (s_axis_tlast or cntr_end) and s_axis_tvalid and s_axis_tready_int;
last_tdata  <= (vb + valid_bytes) when (s_axis_tlast = '1') else x"20";

out_tready <= m_axis_tvalid_int and m_axis_tready;

s_axis_tready <= s_axis_tready_int;

tkeep <= (others => '1');

process(s_aclk)
begin
    if rising_edge(s_aclk) then
        if user_tvalid = '1' then
            user_reg <= s_axis_tuser;
        end if;
    end if;
end process;

user_data <= user_reg when (user_tvalid = '0') else s_axis_tuser;

widthconv_inst: px_axis_dwidth_converter
generic map (
     C_FAMILY => "kintexu",
     C_S_AXIS_TDATA_WIDTH => (WORD_WIDTH*16),
     C_M_AXIS_TDATA_WIDTH => 256,
     C_S_AXIS_TUSER_WIDTH => 1,
     C_M_AXIS_TUSER_WIDTH => (256/(WORD_WIDTH*16)),
     C_AXIS_SIGNAL_SET => "00000000000000000000000000011011"
  ) 
port map (
    aclk          => s_aclk,
    aresetn       => s_aresetn,
    aclken        => '1',
    s_axis_tvalid => s_axis_tvalid,
    s_axis_tready => s_axis_tready_int,
    s_axis_tdata  => s_axis_tdata,
    s_axis_tlast  => s_axis_tlast,
    s_axis_tid    => "0", 
    s_axis_tkeep  => tkeep, 
    s_axis_tstrb  => tkeep,   
    s_axis_tdest  => "0", 
    s_axis_tuser  => "0",    
    m_axis_tvalid => m_axis_tvalid_int,
    m_axis_tready => m_axis_tready,
    m_axis_tdata  => m_axis_tdata(255 downto 0),
    m_axis_tlast  => m_axis_tlast,
    m_axis_tid    => open,
    m_axis_tkeep  => open,
    m_axis_tstrb  => open, 
    m_axis_tdest  => open,
    m_axis_tuser  => open  
  );
  
m_axis_tdata(511 downto 256) <= (others => '0'); 

m_axis_tvalid <= m_axis_tvalid_int;  

userdata_fifo_inst : px_dma_ppkt2pcie_userdata_fifo
  port map (
    s_aclk          => s_aclk,
    s_aresetn       => s_aresetn,
    s_axis_tvalid   => last_tvalid,
    s_axis_tready   => open,
    s_axis_tdata    => last_tdata,
    s_axis_tuser    => user_data,
    m_axis_tvalid   => open,
    m_axis_tready   => out_tready,
    m_axis_tdata    => m_axis_tuser(87 downto 80),
    m_axis_tuser    => m_axis_tuser(79 downto 0)
  );

end generate n256;

-- Don't Up Size if word width is 256 bits (16 Words)
i256: if (WORD_WIDTH = 16) generate

m_axis_tdata(511 downto 256) <= (others => '0'); 
m_axis_tdata(255 downto 0) <= s_axis_tdata(255 downto 0); 
m_axis_tuser(79 downto 0)  <= s_axis_tuser(79 downto 0);
m_axis_tvalid              <= s_axis_tvalid; 
s_axis_tready              <= m_axis_tready;
m_axis_tlast               <= s_axis_tlast;
m_axis_tuser(87 downto 80) <= (conv_std_logic_vector(valid_bytes, 8)) when (s_axis_tlast = '1') else x"20";

process(s_axis_tkeep)
begin
        if s_axis_tkeep(15 downto 12) /= 0 then
            if s_axis_tkeep(15) = '1' then
                valid_bytes <= 32;
            elsif s_axis_tkeep(14) = '1' then
                valid_bytes <= 30;
            elsif s_axis_tkeep(13) = '1' then
                valid_bytes <= 28;
            else
                valid_bytes <= 26;
            end if;
        elsif s_axis_tkeep(11 downto 8) /= 0 then
            if s_axis_tkeep(11) = '1' then
                valid_bytes <= 24;
            elsif s_axis_tkeep(10) = '1' then
                valid_bytes <= 22;
            elsif s_axis_tkeep(9) = '1' then
                valid_bytes <= 20;
            else
                valid_bytes <= 18;
            end if;    
        elsif s_axis_tkeep(7 downto 4) /= 0 then
            if s_axis_tkeep(7) = '1' then
                valid_bytes <= 16;
            elsif s_axis_tkeep(6) = '1' then
                valid_bytes <= 14;
            elsif s_axis_tkeep(5) = '1' then
                valid_bytes <= 12;
            else
                valid_bytes <= 10;
            end if;  
         else
            if s_axis_tkeep(3) = '1' then
                valid_bytes <= 8;
            elsif s_axis_tkeep(2) = '1' then
                valid_bytes <= 6;
            elsif s_axis_tkeep(1) = '1' then
                valid_bytes <= 4;
            else
                valid_bytes <= 2;
            end if;
         end if;
end process;  
 
end generate i256;

end generate lt;

end Behavioral;
