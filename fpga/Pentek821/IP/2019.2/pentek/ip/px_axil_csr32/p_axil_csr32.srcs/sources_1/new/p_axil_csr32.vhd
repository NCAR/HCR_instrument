----------------------------------------------------------------------------------
-- Pentek AXI-Lite Control/Status Register Block
----------------------------------------------------------------------------------
-- p_axil_csr32.vhd
--
-- Target Device: Kintex UltraScale
--
-- Pentek Inc.
-- One Park Way, Upper Saddle River, NJ 07458
-- (201)818-5900
-- www.pentek.com
--
-- Copyright Pentek, Inc. 2015-2019
--
-- Revision:
-- Revision 1.00 - File Created

-- Additional Comments: 
--  
-- This IP Core can create an AXI-Lite register group with up to 29 configurable registers and
-- optionally a group three other registers used for interrupts (Enable, STATUS, FLAG)

-- Registers can be set up a control or status registers based on reg_type parameter. Set the bit corresponding
-- to the Register number in reg_type to a '1' for control register and '0' for a status register
-- Set a bit to '0' in disable_reg to enable generation of the corresponding register number.   

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

-- (c) Copyright 2015-2019 Pentek, Inc. All rights reserved.
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
use ieee.math_real.ALL;

--library my_funct;
--use my_funct.p_csr_funct.all;

entity p_axil_csr32 is
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
end p_axil_csr32;

architecture Behavioral of p_axil_csr32 is

ATTRIBUTE X_INTERFACE_INFO : STRING;
ATTRIBUTE X_INTERFACE_PARAMETER : STRING;

ATTRIBUTE X_INTERFACE_INFO of irq: SIGNAL is "xilinx.com:signal:interrupt:1.0 irq INTR";
ATTRIBUTE X_INTERFACE_PARAMETER of irq: SIGNAL is "SENSITIVITY EDGE_RISING";

ATTRIBUTE X_INTERFACE_INFO of s_axi_csr_aclk: SIGNAL is "xilinx.com:signal:clock:1.0 s_axi_csr_aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of s_axi_csr_aclk: SIGNAL is "ASSOCIATED_BUSIF s_axi_csr, ASSOCIATED_RESET s_axi_csr_aresetn";

--------------------------------------------------------------------------------
-- Types
--------------------------------------------------------------------------------

type state_type is
(
    RESET_STATE,
    WR_ADDR_DATA_STATE,
    WR_DATA_STATE,
    WR_ADDR2_STATE,
    WR_ADDR_STATE,
    WR_DATA2_STATE,
    WR_ADDR_DEC_STATE,
    WR_B_RSP_STATE,
    RD_ADDR_STATE,
    WAIT_RD_BS_STATE,
    WAIT_RD_BS2_STATE,
    WAIT_RD_CMPLT_STATE,
    WAIT_RDDATA_RDY_STATE
);

type reg_array is array (0 to 28) of std_logic_vector(31 downto 0);

--------------------------------------------------------------------------------
-- Signals
--------------------------------------------------------------------------------

signal state            : state_type;
signal rd_data          : std_logic_vector(31 downto 0) := (others => '0');
signal rd_data0         : std_logic_vector(31 downto 0) := (others => '0');
signal rd_data1         : std_logic_vector(31 downto 0) := (others => '0');
signal rd_data2         : std_logic_vector(31 downto 0) := (others => '0');
signal rd_data3         : std_logic_vector(31 downto 0) := (others => '0');
signal w_data           : std_logic_vector(31 downto 0) := (others => '0');
signal w_addr           : std_logic_vector(6 downto 0) := (others => '0');
signal r_addr           : std_logic_vector(6 downto 0) := (others => '0');
signal w_we             : std_logic := '0'; 
signal w_addr_num       : integer := 0;
signal r_addr_num_a     : integer := 0;
signal r_addr_num_b     : integer := 0;
signal cntl_reg         : reg_array;
signal int_en_reg       : std_logic_vector(31 downto 0) := (others => '0');
signal t1_intrpt_src_in : std_logic_vector(31 downto 0) := (others => '0');
signal t2_intrpt_src_in : std_logic_vector(31 downto 0) := (others => '0'); 
signal re_int           : std_logic_vector(31 downto 0) := (others => '0');
signal int_and          : std_logic_vector(31 downto 0) := (others => '0'); 
signal int_flag_reg     : std_logic_vector(31 downto 0) := (others => '0'); 
signal reg_clr          : std_logic_vector(31 downto 0) := (others => '0'); 
signal usr_int          : std_logic := '0';
signal wr_strb          : std_logic_vector(3 downto 0) := "0000";
signal t1_s_axi_csr_aresetn: std_logic := '0';
--------------------------------------------------------------------------------


begin

process(s_axi_csr_aclk)
begin
    if rising_edge(s_axi_csr_aclk) then
        t1_s_axi_csr_aresetn <= s_axi_csr_aresetn;
        if t1_s_axi_csr_aresetn = '0' then
           state <= RESET_STATE;
           s_axi_csr_awready <= '0'; 
           s_axi_csr_wready  <= '0';  
           s_axi_csr_arready <= '0'; 
           s_axi_csr_rvalid  <= '0';  
           s_axi_csr_bvalid  <= '0';
           w_we          <= '0';
           wr_strb       <= "0000"; 
        else 
           case state is 
            when RESET_STATE =>
                if (t1_s_axi_csr_aresetn = '0') then
                    state <= RESET_STATE;
                    s_axi_csr_awready <= '0';
                    s_axi_csr_wready  <= '0';
                    s_axi_csr_arready <= '0'; 
                    s_axi_csr_rvalid  <= '0';  
                    s_axi_csr_bvalid  <= '0';   
                    w_we          <= '0'; 
                    wr_strb       <= "0000";
                elsif (s_axi_csr_awvalid = '1') then  
                    if (s_axi_csr_wvalid = '1') then
                        state <=  WR_ADDR_DATA_STATE;
                    else
                        state <=  WR_ADDR_STATE;
                    end if; 
                elsif (s_axi_csr_wvalid = '1') then
                    state <=  WR_DATA_STATE;
                elsif (s_axi_csr_arvalid = '1') then
                    state <=  RD_ADDR_STATE;
                else
                    state <= RESET_STATE;
                end if;    
             when WR_ADDR_DATA_STATE =>
                s_axi_csr_wready <= '1';
                s_axi_csr_awready <= '1';  
                w_data <= s_axi_csr_wdata;
                wr_strb <= s_axi_csr_wstrb;
                w_addr <= s_axi_csr_awaddr; 
                state  <= WR_ADDR_DEC_STATE;
             when WR_DATA_STATE =>
                s_axi_csr_wready <= '1';
                w_data <= s_axi_csr_wdata;
                wr_strb <= s_axi_csr_wstrb;
                state  <= WR_ADDR2_STATE;
             when WR_ADDR2_STATE =>
                s_axi_csr_wready <= '0';
                if (s_axi_csr_awvalid = '1') then      
                   state  <= WR_ADDR_DEC_STATE;
                   w_addr <= s_axi_csr_awaddr;
                   s_axi_csr_awready <= '1';
                else
                   state  <= WR_ADDR2_STATE;
                end if;  
             when WR_ADDR_STATE =>
                   s_axi_csr_awready <= '1';
                   w_addr <= s_axi_csr_awaddr;
                   state  <= WR_DATA2_STATE;
             when WR_DATA2_STATE =>
                s_axi_csr_awready <= '0';
                if (s_axi_csr_wvalid = '1') then      
                   state  <= WR_ADDR_DEC_STATE;
                   w_data <= s_axi_csr_wdata;
                   wr_strb <= s_axi_csr_wstrb;
                   s_axi_csr_wready <= '1';
                else
                   state  <= WR_DATA2_STATE;
                end if;    
             when WR_ADDR_DEC_STATE =>
                w_we          <= '1';   
                s_axi_csr_wready  <= '0';
                s_axi_csr_awready <= '0';   
                state         <= WR_B_RSP_STATE;
                s_axi_csr_bresp   <= "00";
                s_axi_csr_bvalid  <= '1';     
            when  WR_B_RSP_STATE =>
                w_we             <= '0';  
                if s_axi_csr_bready = '1' then
                    s_axi_csr_bvalid <= '0';
                    state <= RESET_STATE;
                else
                    state <= WR_B_RSP_STATE;
                end if;    
            when  RD_ADDR_STATE =>
               s_axi_csr_arready <= '1';
               r_addr        <= s_axi_csr_araddr;
               state         <= WAIT_RD_BS_STATE;     
            when WAIT_RD_BS_STATE =>
                s_axi_csr_arready <= '0';    
                state         <= WAIT_RD_BS2_STATE;     
            when WAIT_RD_BS2_STATE =>
                state   <=  WAIT_RD_CMPLT_STATE;
            when WAIT_RD_CMPLT_STATE =>
                s_axi_csr_rdata  <= rd_data;
                s_axi_csr_rvalid <= '1'; 
                s_axi_csr_rresp  <= "00";
                state <= WAIT_RDDATA_RDY_STATE;                   
            when WAIT_RDDATA_RDY_STATE =>   
                if s_axi_csr_rready = '1' then
                    s_axi_csr_rvalid <= '0';
                    state <= RESET_STATE;
                else
                   state <= WAIT_RDDATA_RDY_STATE;     
                end if;  
            when others =>
               state <= RESET_STATE;
          end case;
       end if;
   end if;  
end process;

--------------------------------------------------------------------------------
-- Control Registers
--------------------------------------------------------------------------------

w_addr_num <= conv_integer(w_addr(6 downto 2));

gen_regs: for i in 0 to 28 generate

gen_ctl_reg: if ((reg_type(i) = '1') and (disable_reg(i) = '0'))  generate
process(s_axi_csr_aclk)
begin
    if rising_edge(s_axi_csr_aclk) then
      if  s_axi_csr_aresetn = '0' then
         -- Initialize when reset
         case i is
            when 0 =>
               cntl_reg(i)(31 downto 0) <= stat0_in;
            when 1 =>
               cntl_reg(i)(31 downto 0) <= stat1_in; 
            when 2 =>
               cntl_reg(i)(31 downto 0) <= stat2_in;
            when 3 =>
               cntl_reg(i)(31 downto 0) <= stat3_in;
            when 4 =>
               cntl_reg(i)(31 downto 0) <= stat4_in;
            when 5 =>
               cntl_reg(i)(31 downto 0) <= stat5_in; 
            when 6 =>
               cntl_reg(i)(31 downto 0) <= stat6_in;
            when 7 =>
               cntl_reg(i)(31 downto 0) <= stat7_in;
            when 8 =>
               cntl_reg(i)(31 downto 0) <= stat8_in;
            when 9 =>
               cntl_reg(i)(31 downto 0) <= stat9_in; 
            when 10 =>
               cntl_reg(i)(31 downto 0) <= stat10_in;
            when 11 =>
               cntl_reg(i)(31 downto 0) <= stat11_in;
            when 12 =>
               cntl_reg(i)(31 downto 0) <= stat12_in;
            when 13 =>
               cntl_reg(i)(31 downto 0) <= stat13_in; 
            when 14 =>
               cntl_reg(i)(31 downto 0) <= stat14_in;
            when 15 =>
               cntl_reg(i)(31 downto 0) <= stat15_in;
            when 16 =>
               cntl_reg(i)(31 downto 0) <= stat16_in;
            when 17 =>
               cntl_reg(i)(31 downto 0) <= stat17_in; 
            when 18 =>
               cntl_reg(i)(31 downto 0) <= stat18_in;
            when 19 =>
               cntl_reg(i)(31 downto 0) <= stat19_in;
            when 20 =>
               cntl_reg(i)(31 downto 0) <= stat20_in;
            when 21 =>
               cntl_reg(i)(31 downto 0) <= stat21_in; 
            when 22 =>
               cntl_reg(i)(31 downto 0) <= stat22_in;
            when 23 =>
               cntl_reg(i)(31 downto 0) <= stat23_in;
            when 24 =>
               cntl_reg(i)(31 downto 0) <= stat24_in;
            when 25 =>
               cntl_reg(i)(31 downto 0) <= stat25_in; 
            when 26 =>
               cntl_reg(i)(31 downto 0) <= stat26_in;
            when 27 =>
               cntl_reg(i)(31 downto 0) <= stat27_in;
            when 28 =>
               cntl_reg(i)(31 downto 0) <= stat28_in;                      
            when others =>
               cntl_reg(i)(31 downto 0) <= stat0_in; 
          end case;                 
      else
          if  (w_we = '1') then  
            if (w_addr_num = i) then
               if wr_strb(0) = '1' then
                   cntl_reg(i)(7 downto 0) <= w_data(7 downto 0);
               end if;
               if wr_strb(1) = '1' then
                   cntl_reg(i)(15 downto 8) <= w_data(15 downto 8);
               end if;
               if wr_strb(2) = '1' then
                   cntl_reg(i)(23 downto 16) <= w_data(23 downto 16);
               end if;
               if wr_strb(3) = '1' then
                   cntl_reg(i)(31 downto 24) <= w_data(31 downto 24);
               end if;
            end if;
          end if;     
      end if;            
    end if;
end process;
end generate;

gen_no_ctl_reg: if ((reg_type(i) = '0') and (disable_reg(i) = '0')) generate
process(s_axi_csr_aclk)
begin
   if rising_edge(s_axi_csr_aclk) then
    case i is
      when 0 =>
         cntl_reg(i)(31 downto 0) <= stat0_in;
      when 1 =>
         cntl_reg(i)(31 downto 0) <= stat1_in; 
      when 2 =>
         cntl_reg(i)(31 downto 0) <= stat2_in;
      when 3 =>
         cntl_reg(i)(31 downto 0) <= stat3_in;
      when 4 =>
         cntl_reg(i)(31 downto 0) <= stat4_in;
      when 5 =>
         cntl_reg(i)(31 downto 0) <= stat5_in; 
      when 6 =>
         cntl_reg(i)(31 downto 0) <= stat6_in;
      when 7 =>
         cntl_reg(i)(31 downto 0) <= stat7_in;
      when 8 =>
         cntl_reg(i)(31 downto 0) <= stat8_in;
      when 9 =>
         cntl_reg(i)(31 downto 0) <= stat9_in; 
      when 10 =>
         cntl_reg(i)(31 downto 0) <= stat10_in;
      when 11 =>
         cntl_reg(i)(31 downto 0) <= stat11_in;
      when 12 =>
         cntl_reg(i)(31 downto 0) <= stat12_in;
      when 13 =>
         cntl_reg(i)(31 downto 0) <= stat13_in; 
      when 14 =>
         cntl_reg(i)(31 downto 0) <= stat14_in;
      when 15 =>
         cntl_reg(i)(31 downto 0) <= stat15_in;
      when 16 =>
         cntl_reg(i)(31 downto 0) <= stat16_in;
      when 17 =>
         cntl_reg(i)(31 downto 0) <= stat17_in; 
      when 18 =>
         cntl_reg(i)(31 downto 0) <= stat18_in;
      when 19 =>
         cntl_reg(i)(31 downto 0) <= stat19_in;
      when 20 =>
         cntl_reg(i)(31 downto 0) <= stat20_in;
      when 21 =>
         cntl_reg(i)(31 downto 0) <= stat21_in; 
      when 22 =>
         cntl_reg(i)(31 downto 0) <= stat22_in;
      when 23 =>
         cntl_reg(i)(31 downto 0) <= stat23_in;
      when 24 =>
         cntl_reg(i)(31 downto 0) <= stat24_in;
      when 25 =>
         cntl_reg(i)(31 downto 0) <= stat25_in; 
      when 26 =>
         cntl_reg(i)(31 downto 0) <= stat26_in;
      when 27 =>
         cntl_reg(i)(31 downto 0) <= stat27_in;
      when 28 =>
         cntl_reg(i)(31 downto 0) <= stat28_in;                      
      when others =>
         cntl_reg(i)(31 downto 0) <= stat0_in; 
    end case; 
   end if;
end process; 

end generate;

disable_reg_gen: if (disable_reg(i) = '1') generate

cntl_reg(i) <= x"00000000";

end generate;

end generate;


process(s_axi_csr_aclk)
begin
   if rising_edge(s_axi_csr_aclk) then
      if disable_reg(0) = '0' then
         ctl0_out <= cntl_reg(0);  
      else
         ctl0_out <= x"00000000"; 
      end if;
   end if;
end process;
process(s_axi_csr_aclk)
begin
   if rising_edge(s_axi_csr_aclk) then
      if disable_reg(1) = '0' then
         ctl1_out <= cntl_reg(1);  
      else
         ctl1_out <= x"00000000"; 
      end if;
   end if;
end process;
process(s_axi_csr_aclk)
begin
   if rising_edge(s_axi_csr_aclk) then
      if disable_reg(2) = '0' then
         ctl2_out <= cntl_reg(2);  
      else
         ctl2_out <= x"00000000"; 
      end if;
   end if;
end process;
process(s_axi_csr_aclk)
begin
   if rising_edge(s_axi_csr_aclk) then
      if disable_reg(3) = '0' then
         ctl3_out <= cntl_reg(3);  
      else
         ctl3_out <= x"00000000"; 
      end if;
   end if;
end process;
process(s_axi_csr_aclk)
begin
   if rising_edge(s_axi_csr_aclk) then
      if disable_reg(4) = '0' then
         ctl4_out <= cntl_reg(4);  
      else
         ctl4_out <= x"00000000"; 
      end if;
   end if;
end process;
process(s_axi_csr_aclk)
begin
   if rising_edge(s_axi_csr_aclk) then
      if disable_reg(5) = '0' then
         ctl5_out <= cntl_reg(5);  
      else
         ctl5_out <= x"00000000"; 
      end if;
   end if;
end process;
process(s_axi_csr_aclk)
begin
   if rising_edge(s_axi_csr_aclk) then
      if disable_reg(6) = '0' then
         ctl6_out <= cntl_reg(6);  
      else
         ctl6_out <= x"00000000"; 
      end if;
   end if;
end process;
process(s_axi_csr_aclk)
begin
   if rising_edge(s_axi_csr_aclk) then
      if disable_reg(7) = '0' then
         ctl7_out <= cntl_reg(7);  
      else
         ctl7_out <= x"00000000"; 
      end if;
   end if;
end process;
process(s_axi_csr_aclk)
begin
   if rising_edge(s_axi_csr_aclk) then
      if disable_reg(8) = '0' then
         ctl8_out <= cntl_reg(8);  
      else
         ctl8_out <= x"00000000"; 
      end if;
   end if;
end process;
process(s_axi_csr_aclk)
begin
   if rising_edge(s_axi_csr_aclk) then
      if disable_reg(9) = '0' then
         ctl9_out <= cntl_reg(9);  
      else
         ctl9_out <= x"00000000"; 
      end if;
   end if;
end process;
process(s_axi_csr_aclk)
begin
   if rising_edge(s_axi_csr_aclk) then
      if disable_reg(10) = '0' then
         ctl10_out <= cntl_reg(10);  
      else
         ctl10_out <= x"00000000"; 
      end if;
   end if;
end process;
process(s_axi_csr_aclk)
begin
   if rising_edge(s_axi_csr_aclk) then
      if disable_reg(11) = '0' then
         ctl11_out <= cntl_reg(11);  
      else
         ctl11_out <= x"00000000"; 
      end if;
   end if;
end process;
process(s_axi_csr_aclk)
begin
   if rising_edge(s_axi_csr_aclk) then
      if disable_reg(12) = '0' then
         ctl12_out <= cntl_reg(12);  
      else
         ctl12_out <= x"00000000"; 
      end if;
   end if;
end process;
process(s_axi_csr_aclk)
begin
   if rising_edge(s_axi_csr_aclk) then
      if disable_reg(13) = '0' then
         ctl13_out <= cntl_reg(13);  
      else
         ctl13_out <= x"00000000"; 
      end if;
   end if;
end process;
process(s_axi_csr_aclk)
begin
   if rising_edge(s_axi_csr_aclk) then
      if disable_reg(14) = '0' then
         ctl14_out <= cntl_reg(14);  
      else
         ctl14_out <= x"00000000"; 
      end if;
   end if;
end process;
process(s_axi_csr_aclk)
begin
   if rising_edge(s_axi_csr_aclk) then
      if disable_reg(15) = '0' then
         ctl15_out <= cntl_reg(15);  
      else
         ctl15_out <= x"00000000"; 
      end if;
   end if;
end process;
process(s_axi_csr_aclk)
begin
   if rising_edge(s_axi_csr_aclk) then
      if disable_reg(16) = '0' then
         ctl16_out <= cntl_reg(16);  
      else
         ctl16_out <= x"00000000"; 
      end if;
   end if;
end process;
process(s_axi_csr_aclk)
begin
   if rising_edge(s_axi_csr_aclk) then
      if disable_reg(17) = '0' then
         ctl17_out <= cntl_reg(17);  
      else
         ctl17_out <= x"00000000"; 
      end if;
   end if;
end process;
process(s_axi_csr_aclk)
begin
   if rising_edge(s_axi_csr_aclk) then
      if disable_reg(18) = '0' then
         ctl18_out <= cntl_reg(18);  
      else
         ctl18_out <= x"00000000"; 
      end if;
   end if;
end process;
process(s_axi_csr_aclk)
begin
   if rising_edge(s_axi_csr_aclk) then
      if disable_reg(19) = '0' then
         ctl19_out <= cntl_reg(19);  
      else
         ctl19_out <= x"00000000"; 
      end if;
   end if;
end process;
process(s_axi_csr_aclk)
begin
   if rising_edge(s_axi_csr_aclk) then
      if disable_reg(20) = '0' then
         ctl20_out <= cntl_reg(20);  
      else
         ctl20_out <= x"00000000"; 
      end if;
   end if;
end process;
process(s_axi_csr_aclk)
begin
   if rising_edge(s_axi_csr_aclk) then
      if disable_reg(21) = '0' then
         ctl21_out <= cntl_reg(21);  
      else
         ctl21_out <= x"00000000"; 
      end if;
   end if;
end process;
process(s_axi_csr_aclk)
begin
   if rising_edge(s_axi_csr_aclk) then
      if disable_reg(22) = '0' then
         ctl22_out <= cntl_reg(22);  
      else
         ctl22_out <= x"00000000"; 
      end if;
   end if;
end process;
process(s_axi_csr_aclk)
begin
   if rising_edge(s_axi_csr_aclk) then
      if disable_reg(23) = '0' then
         ctl23_out <= cntl_reg(23);  
      else
         ctl23_out <= x"00000000"; 
      end if;
   end if;
end process;
process(s_axi_csr_aclk)
begin
   if rising_edge(s_axi_csr_aclk) then
      if disable_reg(24) = '0' then
         ctl24_out <= cntl_reg(24);  
      else
         ctl24_out <= x"00000000"; 
      end if;
   end if;
end process;
process(s_axi_csr_aclk)
begin
   if rising_edge(s_axi_csr_aclk) then
      if disable_reg(25) = '0' then
         ctl25_out <= cntl_reg(25);  
      else
         ctl25_out <= x"00000000"; 
      end if;
   end if;
end process;
process(s_axi_csr_aclk)
begin
   if rising_edge(s_axi_csr_aclk) then
      if disable_reg(26) = '0' then
         ctl26_out <= cntl_reg(26);  
      else
         ctl26_out <= x"00000000"; 
      end if;
   end if;
end process;
process(s_axi_csr_aclk)
begin
   if rising_edge(s_axi_csr_aclk) then
      if disable_reg(27) = '0' then
         ctl27_out <= cntl_reg(27);  
      else
         ctl27_out <= x"00000000"; 
      end if;
   end if;
end process;
process(s_axi_csr_aclk)
begin
   if rising_edge(s_axi_csr_aclk) then
      if disable_reg(28) = '0' then
         ctl28_out <= cntl_reg(28);  
      else
         ctl28_out <= x"00000000"; 
      end if;
   end if;
end process;
-------------------------------------------------------------------------------
-- Generate the Latched Interrupt Flag Register
-------------------------------------------------------------------------------
gen_int: if (has_interrupt_regs = true) generate

-- Interrupt Enable
process(s_axi_csr_aclk)
begin
    if rising_edge(s_axi_csr_aclk) then
      if  s_axi_csr_aresetn = '0' then
         int_en_reg(31 downto 0) <= x"00000000";
      else
         if  (w_we = '1') then  
            if (w_addr_num = 29) then -- address of interrupt enable reg
               if wr_strb(0) = '1' then
                  int_en_reg(7 downto 0)   <= w_data(7 downto 0);
               end if;
               if wr_strb(1) = '1' then
                  int_en_reg(15 downto 8)  <= w_data(15 downto 8);
               end if;
               if wr_strb(2) = '1' then
                  int_en_reg(23 downto 16) <= w_data(23 downto 16);
               end if;
               if wr_strb(3) = '1' then
                  int_en_reg(31 downto 24) <= w_data(31 downto 24);
               end if;   
            end if;
          end if;     
      end if;
    end if;
end process;

gen_int_src: if (num_interrupt_src /= 0) generate
gen_int_src_reg: for i in 0 to num_interrupt_src-1 generate
process(s_axi_csr_aclk)
begin
   if rising_edge(s_axi_csr_aclk) then
      if  s_axi_csr_aresetn = '0' then
         t1_intrpt_src_in(i) <= '0'; 
         t2_intrpt_src_in(i) <= '0';
         re_int(i)           <= '0'; 
         int_and(i)          <= '0'; 
      else
         t1_intrpt_src_in(i) <= intrpt_src_in(i);
         t2_intrpt_src_in(i) <= t1_intrpt_src_in(i);
         re_int(i)           <= t1_intrpt_src_in(i) and not t2_intrpt_src_in(i);
         int_and(i)          <= re_int(i) and int_en_reg(i);
      end if;
   end if;
end process;   

end generate;
end generate;

gen_spare_int_src: if (num_interrupt_src < 32) generate
gen_spare_int_src_reg: for i in num_interrupt_src to 31 generate
t1_intrpt_src_in(i) <= '0';
t2_intrpt_src_in(i) <= '0';
re_int(i)           <= '0'; 
int_and(i)          <= '0';    
end generate;
end generate;

gen_int_flag: if (num_interrupt_src /= 0) generate
gen_int_flag_reg: for i in 0 to num_interrupt_src-1 generate
-- Create Flag Clears
reg_clr(i) <= w_data(i) when  ((wr_strb(i/8) = '1') and (w_we = '1') and (w_addr_num = 31)) else '0';

process(s_axi_csr_aclk)
begin
   if rising_edge(s_axi_csr_aclk) then
      if s_axi_csr_aresetn = '0' then
         int_flag_reg(i) <= '0';
      elsif re_int(i) = '1' then
         int_flag_reg(i) <= '1';
      elsif (reg_clr(i) = '1') then 
         int_flag_reg(i) <= '0';
      end if;
   end if;
end process;

end generate;
end generate;


gen_spare_int_flag: if (num_interrupt_src  < 32) generate
gen_spare_int_flag_reg: for i in num_interrupt_src to 31 generate

int_flag_reg(i) <= '0';

end generate;
end generate;

process(s_axi_csr_aclk)
begin
   if rising_edge(s_axi_csr_aclk) then
      if (int_and = x"00000000") then
         usr_int <= '0';
      else
         usr_int <= '1';
      end if;
      if  s_axi_csr_aresetn = '0' then
        irq  <= '0';
      else
        irq  <= usr_int;
      end if;   
   end if;
end process;

end generate gen_int;

-- Generate No Interrupt
gen_no_int: if (has_interrupt_regs = false) generate
int_flag_reg <= x"00000000";
t2_intrpt_src_in <= x"00000000";
int_en_reg   <= x"00000000";
irq          <= '0';
end generate gen_no_int;

--------------------------------------------------------------------------------
-- Read Registers
--------------------------------------------------------------------------------

r_addr_num_a <= conv_integer(r_addr(6 downto 5));
r_addr_num_b <= conv_integer(r_addr(4 downto 2));

process(s_axi_csr_aclk)
begin
   if rising_edge(s_axi_csr_aclk) then
      case r_addr_num_a is 
         when 0 =>
            rd_data  <= rd_data0;
         when 1 =>
            rd_data  <= rd_data1;       
         when 2 =>
            rd_data  <= rd_data2;                
         when 3 =>
            rd_data  <= rd_data3;
         when others =>
            rd_data  <= rd_data0;
      end case;     
      case r_addr_num_b is 
         when 0 =>
            rd_data0 <= cntl_reg(0);
            rd_data1 <= cntl_reg(8);
            rd_data2 <= cntl_reg(16);
            rd_data3 <= cntl_reg(24);
         when 1 =>
            rd_data0 <= cntl_reg(1); 
            rd_data1 <= cntl_reg(9);
            rd_data2 <= cntl_reg(17);
            rd_data3 <= cntl_reg(25);        
         when 2 =>
            rd_data0 <= cntl_reg(2); 
            rd_data1 <= cntl_reg(10);
            rd_data2 <= cntl_reg(18);
            rd_data3 <= cntl_reg(26);                    
         when 3 =>
            rd_data0 <= cntl_reg(3); 
            rd_data1 <= cntl_reg(11);
            rd_data2 <= cntl_reg(19);
            rd_data3 <= cntl_reg(27);        
         when 4 =>
            rd_data0 <= cntl_reg(4);  
            rd_data1 <= cntl_reg(12);
            rd_data2 <= cntl_reg(20);
            rd_data3 <= cntl_reg(28);       
         when 5 =>
            rd_data0 <= cntl_reg(5);
            rd_data1 <= cntl_reg(13);
            rd_data2 <= cntl_reg(21);
            rd_data3 <= int_en_reg;        
         when 6 =>
            rd_data0 <= cntl_reg(6);
            rd_data1 <= cntl_reg(14);
            rd_data2 <= cntl_reg(22);
            rd_data3 <=  t2_intrpt_src_in;        
         when 7 =>
            rd_data0 <= cntl_reg(7);
            rd_data1 <= cntl_reg(15);
            rd_data2 <= cntl_reg(23);
            rd_data3 <= int_flag_reg;         
         when others =>
            rd_data0 <= cntl_reg(0);
            rd_data1 <= cntl_reg(8);
            rd_data2 <= cntl_reg(16);
            rd_data3 <= cntl_reg(20);         
      end case;
      
   end if;
end process;   


end Behavioral;
