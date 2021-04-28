----------------------------------------------------------------------------------
-- Pentek AXI-Lite Control/Status Register Block for DMAs
-- (Has SYNC RAM AXI-S output)
----------------------------------------------------------------------------------
-- px_axil_dma_csr.vhd
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
-- Revision 1.00 - File Created

-- Additional Comments: 
--  
-- Register Order is:
-- Control Registers (up to 8)
-- Status Registers (up to 8)
-- Interrupt Registers
--    Interrupt Enable Register
--    Interrupt Status Register
--    Interrupt Flag Register

-- If any register group is set to 0, then other groups move down in address space.
-- AXI-Lite Address width is a function of the number of registers configured.
-- If the width is the (ceiling of the LOG2(number of total registers))+2.
-- For instance, 9 total registers will result in an address width of 6 [5:0]
-- The lower two bits are due to AXI-Lite addresses being byte addresses.

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

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

-------------------------------------------------------------------------------
-- Libraries
-------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.ALL;

entity px_axil_dma_csr is
generic (
   num_addr_bits     : integer := 7;    -- Number of address bits 3-7 (Must agree with number of registers
   num_ctl_regs      : integer := 8;    -- Number of Control Registers - 0 through 8
   num_stat_regs     : integer := 8;    -- Number of Status Registers - 0 through 8
   num_interrupt_regs: integer := 1;    -- Number of Interrupt Registers - 0 or 1
   num_interrupt_src : integer := 16;   -- Number of Interrupt Source bits - 0 to 32
   sync_ram_clr_reg_num : integer := 5; -- Register Number used for SYNC RAM Clear
   sync_ram_set_reg_num : integer := 6  -- Register Number used for SYNC RAM Set
);
port (
--------------------------------------------------------------------------------
-- AXI LITE Slave Interface  
-- DWORD Addressing
--------------------------------------------------------------------------------
   s_axi_csr_aclk      : in  std_logic;
   s_axi_csr_aresetn   : in  std_logic;
   s_axi_csr_awaddr    : in  std_logic_vector(num_addr_bits-1 downto 0);
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
   s_axi_csr_araddr    : in  std_logic_vector(num_addr_bits-1 downto 0);
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
   irq             : out std_logic;
--------------------------------------------------------------------------------
-- SYNC RAM Set/Clear Interface
--------------------------------------------------------------------------------
   sync_ram_tvalid : out std_logic;
   sync_ram_tready : in  std_logic;
   sync_ram_tdata  : out std_logic_vector(7 downto 0);
   sync_ram_tuser  : out std_logic_vector(10 downto 0)
);
end px_axil_dma_csr;

architecture Behavioral of px_axil_dma_csr is

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
    WAIT_RD_CMPLT_STATE,
    WAIT_RDDATA_RDY_STATE,
    WAIT_SYNC_STATE
);

type reg_array is array (0 to 7) of std_logic_vector(31 downto 0);

--------------------------------------------------------------------------------
-- Signals
--------------------------------------------------------------------------------

signal state            : state_type;
signal rd_data          : std_logic_vector(31 downto 0) := (others => '0');
signal w_data           : std_logic_vector(31 downto 0) := (others => '0');
signal w_addr           : std_logic_vector(num_addr_bits-1 downto 0) := (others => '0');
signal r_addr           : std_logic_vector(num_addr_bits-1 downto 0) := (others => '0');
signal w_we             : std_logic := '0'; 
signal w_addr_num       : integer := 0;
signal r_addr_num       : integer := 0;
signal cntl_reg         : reg_array;
signal stat_reg         : reg_array;
signal int_en_reg       : std_logic_vector(31 downto 0) := (others => '0');
signal t1_intrpt_src_in : std_logic_vector(31 downto 0) := (others => '0');
signal t2_intrpt_src_in : std_logic_vector(31 downto 0) := (others => '0'); 
signal re_int           : std_logic_vector(31 downto 0) := (others => '0');
signal int_and          : std_logic_vector(31 downto 0) := (others => '0'); 
signal int_flag_reg     : std_logic_vector(31 downto 0) := (others => '0'); 
signal reg_clr          : std_logic_vector(31 downto 0) := (others => '0'); 
signal usr_int          : std_logic := '0';
signal wr_strb          : std_logic_vector(3 downto 0) := "0000";

--------------------------------------------------------------------------------


begin

process(s_axi_csr_aclk)
begin
    if rising_edge(s_axi_csr_aclk) then
        if s_axi_csr_aresetn = '0' then
           state <= RESET_STATE;
           s_axi_csr_awready <= '0'; 
           s_axi_csr_wready  <= '0';  
           s_axi_csr_arready <= '0'; 
           s_axi_csr_rvalid  <= '0';  
           s_axi_csr_bvalid  <= '0';
           w_we              <= '0'; 
           sync_ram_tvalid   <= '0';
        else 
           case state is 
            when RESET_STATE =>
                if (s_axi_csr_aresetn = '0') then
                    state <= RESET_STATE;
                    s_axi_csr_awready <= '0';
                    s_axi_csr_wready <= '0';
                    s_axi_csr_arready <= '0'; 
                    s_axi_csr_rvalid  <= '0';  
                    s_axi_csr_bvalid  <= '0';   
                    w_we             <= '0'; 
                    sync_ram_tvalid  <= '0';
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
                wr_strb<= s_axi_csr_wstrb;
                w_addr <= s_axi_csr_awaddr; 
                state  <= WR_ADDR_DEC_STATE;
             when WR_DATA_STATE =>
                s_axi_csr_wready <= '1';
                w_data <= s_axi_csr_wdata;
                wr_strb<= s_axi_csr_wstrb;
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
                   wr_strb<= s_axi_csr_wstrb;
                   s_axi_csr_wready <= '1';
                else
                   state  <= WR_DATA2_STATE;
                end if;    
             when WR_ADDR_DEC_STATE =>
                w_we              <= '1';   
                s_axi_csr_wready  <= '0';
                s_axi_csr_awready <= '0'; 
                s_axi_csr_bresp   <= "00";  
                
                if (w_addr_num = sync_ram_clr_reg_num) then
                  state             <= WAIT_SYNC_STATE;
                  sync_ram_tvalid   <= '1';
                  sync_ram_tdata    <= x"00";
                  sync_ram_tuser    <= w_data(10 downto 0);
                elsif (w_addr_num = sync_ram_set_reg_num) then
                  state             <= WAIT_SYNC_STATE;
                  sync_ram_tvalid   <= '1';
                  sync_ram_tdata    <= x"01";
                  sync_ram_tuser    <= w_data(10 downto 0);
                else
                  s_axi_csr_bvalid  <= '1';
                  state             <= WR_B_RSP_STATE;
                end if;   
            when WAIT_SYNC_STATE => 
                w_we                <= '0'; 
                if (sync_ram_tready = '1') then    
                   sync_ram_tvalid  <= '0';
                   s_axi_csr_bvalid <= '1';
                   state            <= WR_B_RSP_STATE;
                else
                   state            <= WAIT_SYNC_STATE;
                end if;   
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

w_addr_num <= conv_integer(w_addr(w_addr'length - 1 downto 2));

gen_cntl: if (num_ctl_regs > 0) generate

gen_ctl_regs: for i in 0 to (num_ctl_regs-1) generate

process(s_axi_csr_aclk)
begin
    if rising_edge(s_axi_csr_aclk) then
      if  s_axi_csr_aresetn = '0' then
         -- Initialize when reset
         case i is
            when 0 =>
               cntl_reg(i)(31 downto 0) <= reg0_init_val;
            when 1 =>
               cntl_reg(i)(31 downto 0) <= reg1_init_val; 
            when 2 =>
               cntl_reg(i)(31 downto 0) <= reg2_init_val;
            when 3 =>
               cntl_reg(i)(31 downto 0) <= reg3_init_val;
            when 4 =>
               cntl_reg(i)(31 downto 0) <= reg4_init_val;
            when 5 =>
               cntl_reg(i)(31 downto 0) <= reg5_init_val; 
            when 6 =>
               cntl_reg(i)(31 downto 0) <= reg6_init_val;
            when 7 =>
               cntl_reg(i)(31 downto 0) <= reg7_init_val;
            when others =>
               cntl_reg(i)(31 downto 0) <= reg7_init_val; 
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

end generate;

gen_stat: if (num_stat_regs > 0) generate

gen_stat_regs: for i in 0 to (num_stat_regs-1) generate

process(s_axi_csr_aclk)
begin
   if rising_edge(s_axi_csr_aclk) then
      case i is
         when 0 =>
            stat_reg(i)(31 downto 0) <= stat0_in;
         when 1 =>
            stat_reg(i)(31 downto 0) <= stat1_in; 
         when 2 =>
            stat_reg(i)(31 downto 0) <= stat2_in;
         when 3 =>
            stat_reg(i)(31 downto 0) <= stat3_in;
         when 4 =>
            stat_reg(i)(31 downto 0) <= stat4_in;
         when 5 =>
            stat_reg(i)(31 downto 0) <= stat5_in; 
         when 6 =>
            stat_reg(i)(31 downto 0) <= stat6_in;
         when 7 =>
            stat_reg(i)(31 downto 0) <= stat7_in;
         when others =>
            stat_reg(i)(31 downto 0) <= stat7_in; 
       end case;                 
   end if;
end process;

end generate;

end generate;

-- Unused Status
gen_spare_stat: if (num_stat_regs < 8) generate

gen_spare_stat_regs: for i in num_stat_regs to 7 generate

stat_reg(i) <= x"00000000";

end generate;

end generate;

-------------------------------------------------------------------------------
-- Generate the Latched Interrupt Flag Register
-------------------------------------------------------------------------------
gen_int: if (num_interrupt_regs /= 0) generate

-- Interrupt Enable
process(s_axi_csr_aclk)
begin
    if rising_edge(s_axi_csr_aclk) then
      if  s_axi_csr_aresetn = '0' then
         int_en_reg(31 downto 0) <= x"00000000";
      else
         if  (w_we = '1') then  
            if (w_addr_num = (num_ctl_regs + num_stat_regs)) then -- address of interrupt enable reg
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
reg_clr(i) <= w_data(i) when  ((wr_strb(i/8) = '1') and (w_we = '1') and (w_addr_num = (num_ctl_regs + num_stat_regs + 2))) else '0';

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
gen_no_int: if (num_interrupt_regs = 0) generate
int_flag_reg <= x"00000000";
int_en_reg   <= x"00000000";
irq          <= '0';
end generate gen_no_int;

--------------------------------------------------------------------------------
-- Read Registers
--------------------------------------------------------------------------------

r_addr_num <= conv_integer(r_addr(r_addr'length - 1 downto 2));

process(s_axi_csr_aclk)
begin
   if rising_edge(s_axi_csr_aclk) then
      if (r_addr_num < num_ctl_regs) then -- Control regs
         rd_data <= cntl_reg(r_addr_num);
      elsif (r_addr_num < (num_stat_regs + num_ctl_regs)) then -- Status regs
         rd_data <= stat_reg(r_addr_num - num_ctl_regs);
      elsif (r_addr_num = (num_stat_regs + num_ctl_regs)) then -- Interrupt Enable reg
         rd_data <= int_en_reg;
      elsif (r_addr_num = (num_stat_regs + num_ctl_regs + 1)) then
         rd_data <= t2_intrpt_src_in; -- Interrupt Status reg
      else -- Interrupt Flag reg
         rd_data <= int_flag_reg;
      end if;
   end if;
end process;   

--------------------------------------------------------------------------------
-- Control Register Ouputs
--------------------------------------------------------------------------------
process(s_axi_csr_aclk)
begin
   if rising_edge(s_axi_csr_aclk) then
      ctl0_out <= cntl_reg(0);
      ctl1_out <= cntl_reg(1);
      ctl2_out <= cntl_reg(2);
      ctl3_out <= cntl_reg(3);
      ctl4_out <= cntl_reg(4);
      ctl5_out <= cntl_reg(5);
      ctl6_out <= cntl_reg(6);
      ctl7_out <= cntl_reg(7);
   end if;
end process; 

end Behavioral;
