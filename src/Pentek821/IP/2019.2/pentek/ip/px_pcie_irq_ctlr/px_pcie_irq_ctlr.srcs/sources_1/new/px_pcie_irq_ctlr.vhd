----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/07/2015 12:07:27 AM
-- Design Name: 
-- Module Name: px_pcie_irq_ctlr - Behavioral
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
-- This module converts up to 32 edge type interrupts to legacy and MSI signals needed by the
-- Gen3 PCIe core.
--
-- Register Map
-- Base + 0x00 = Interrupt Enable Register - set bits to '1' to enable corresponding interrupt Flag bits to create an output interrupt
-- Base + 0x04 = Interrupt Flag Register   - Bits can be cleared by writing '1's to bit positions. 

-- An incoming interrupt simultaneous to a clear will not clear.
 
 -- Only single vector MSI is supported at this time.
 
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

-------------------------------------------------------------------------------
-- Libraries
-------------------------------------------------------------------------------
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

entity px_pcie_irq_ctlr is
generic(
   num_interrupt_sources : integer := 32; -- number of input interrupts
   ku : integer := 1 -- 1 = Ultrascale Kintex 0 = V7
);
port (
   --------------------------------------------------------------------------------
   -- AXI LITE Slave Interface  
   -- DWORD Addressing
   --------------------------------------------------------------------------------
   aclk                              : in  std_logic;
   aresetn                           : in  std_logic;
   s_axi_csr_awaddr                  : in  std_logic_vector(3 downto 0);
   s_axi_csr_awprot                  : in  std_logic_vector(2 downto 0); -- not used
   s_axi_csr_awvalid                 : in  std_logic;
   s_axi_csr_awready                 : out std_logic;
   s_axi_csr_wdata                   : in  std_logic_vector(31 downto 0);
   s_axi_csr_wstrb                   : in  std_logic_vector(3 downto 0); -- not used
   s_axi_csr_wvalid                  : in  std_logic;
   s_axi_csr_wready                  : out std_logic;
   s_axi_csr_bresp                   : out std_logic_vector(1 downto 0);
   s_axi_csr_bvalid                  : out std_logic;
   s_axi_csr_bready                  : in  std_logic;
   s_axi_csr_araddr                  : in  std_logic_vector(3 downto 0);
   s_axi_csr_arprot                  : in  std_logic_vector(2 downto 0); -- not used
   s_axi_csr_arvalid                 : in  std_logic;
   s_axi_csr_arready                 : out std_logic;
   s_axi_csr_rdata                   : out std_logic_vector(31 downto 0);
   s_axi_csr_rresp                   : out std_logic_vector(1 downto 0);
   s_axi_csr_rvalid                  : out std_logic;
   s_axi_csr_rready                  : in  std_logic;
   -----------------------------------------------------------------------------
   -- Interrupt Sources (edge type)
   -----------------------------------------------------------------------------
   int_in                            : in  std_logic_vector(num_interrupt_sources-1 downto 0);
   -----------------------------------------------------------------------------
   -- MSI Mode Status Signal
   msi_enable_out                    : out std_logic_vector(3 downto 0);
   -----------------------------------------------------------------------------
   -- legacy interrupts
   cfg_interrupt_int                 : out std_logic_vector(3 downto 0);
   cfg_interrupt_pending             : out std_logic_vector((ku*2)+1 downto 0);
   cfg_interrupt_sent                : in  std_logic;
   -- msi interrupts
   cfg_interrupt_msi_attr            : out std_logic_vector(2 downto 0); --
   cfg_interrupt_msi_data            : in  std_logic_vector(31 downto 0); --
   cfg_interrupt_msi_enable          : in  std_logic_vector((ku*2)+1 downto 0); --
   cfg_interrupt_msi_fail            : in  std_logic; --
   cfg_interrupt_msi_function_number : out std_logic_vector(ku+2 downto 0); --
   cfg_interrupt_msi_int             : out std_logic_vector(63-(ku*32) downto 0); --
   cfg_interrupt_msi_mask_update     : in  std_logic; --
   cfg_interrupt_msi_mmenable        : in  std_logic_vector((ku*6)+5 downto 0); --
   cfg_interrupt_msi_pending_status  : out std_logic_vector(63-(ku*32) downto 0); --
   cfg_interrupt_msi_pending_status_data_enable  : out std_logic;
   cfg_interrupt_msi_pending_status_function_num  : out std_logic_vector(3 downto 0);
   cfg_interrupt_msi_select          : out std_logic_vector(3 downto 0); --
   cfg_interrupt_msi_sent            : in  std_logic; --
   cfg_interrupt_msi_tph_present     : out std_logic; --
   cfg_interrupt_msi_tph_st_tag      : out std_logic_vector(8 downto 0); --
   cfg_interrupt_msi_tph_type        : out std_logic_vector(1 downto 0); --
   cfg_interrupt_msi_vf_enable       : in  std_logic_vector((ku*2)+5 downto 0) --
    );
end px_pcie_irq_ctlr;

architecture Behavioral of px_pcie_irq_ctlr is

-------------------------------------------------------------------------------
-- Attributes
-------------------------------------------------------------------------------

ATTRIBUTE X_INTERFACE_INFO : STRING;
ATTRIBUTE X_INTERFACE_PARAMETER : STRING;

ATTRIBUTE X_INTERFACE_INFO of aclk: SIGNAL is "xilinx.com:signal:clock:1.0 aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of aclk: SIGNAL is "ASSOCIATED_BUSIF s_axi_csr, ASSOCIATED_RESET aresetn";

-------------------------------------------------------------------------------
-- Types
-------------------------------------------------------------------------------
type state_mach_states is (reset_state,
                           wait_for_int_state,
                           int_assert_state,
                           wait_for_sent_state,
                           wait_int_in_low_state
                           );


type axi_state_type is
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
    WAIT_RDDATA_RDY_STATE
);
-------------------------------------------------------------------------------
-- Signals
-------------------------------------------------------------------------------
      
signal next_state       : state_mach_states := reset_state;
signal state            : state_mach_states := reset_state;
signal axi_state        : axi_state_type := RESET_STATE;
signal intrpt_en_reg    : std_logic_vector(31 downto 0) := (others => '0');
signal intrpt_clr_vctr  : std_logic_vector(31 downto 0) := (others => '0');
signal intrpt_flag_reg  : std_logic_vector(31 downto 0) := (others => '0');
signal int              : std_logic := '0';
signal int_or           : std_logic_vector(31 downto 0) := (others => '0');
signal rd_data          : std_logic_vector(31 downto 0) := (others => '0');
signal w_data           : std_logic_vector(31 downto 0) := (others => '0');
signal w_addr           : std_logic_vector(3 downto 0)  := (others => '0');
signal t1_aresetn       : std_logic := '0';
signal t2_aresetn       : std_logic := '0';
signal t3_aresetn       : std_logic := '0';
signal t4_aresetn       : std_logic := '0';
signal t1_int_status    : std_logic_vector(31 downto 0) := (others => '0'); 
signal t2_int_status    : std_logic_vector(31 downto 0) := (others => '0'); 
signal rerror           : std_logic := '0';
signal int_in_vctr      : std_logic_vector(31 downto 0) := (others => '0');
signal w_strb           : std_logic_vector(3 downto 0) := (others => '0');

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

begin

-------------------------------------------------------------------------------
-- AXI4-Lite Interface State Machine
-------------------------------------------------------------------------------
process(aclk)
begin
    if rising_edge(aclk) then
        if t1_aresetn = '0' then
           axi_state       <= RESET_STATE;
           s_axi_csr_awready   <= '0'; 
           s_axi_csr_wready    <= '0';  
           s_axi_csr_arready   <= '0'; 
           s_axi_csr_rvalid    <= '0';  
           s_axi_csr_bvalid    <= '0';
           intrpt_en_reg   <= (others => '0');
           intrpt_clr_vctr <= (others => '0');
        else 
           case axi_state is 
            when RESET_STATE =>
                if (t1_aresetn = '0') then
                    axi_state       <= RESET_STATE;
                    s_axi_csr_awready   <= '0';
                    s_axi_csr_wready    <= '0';
                    s_axi_csr_arready   <= '0'; 
                    s_axi_csr_rvalid    <= '0';  
                    s_axi_csr_bvalid    <= '0';
                    intrpt_en_reg   <= (others => '0');
                    intrpt_clr_vctr <= (others => '0');
                elsif (s_axi_csr_awvalid = '1') then  
                    if (s_axi_csr_wvalid = '1') then
                        axi_state <=  WR_ADDR_DATA_STATE;
                    else
                        axi_state <=  WR_ADDR_STATE;
                    end if; 
                elsif (s_axi_csr_wvalid = '1') then
                    axi_state <=  WR_DATA_STATE;
                elsif (s_axi_csr_arvalid = '1') then
                    axi_state <=  RD_ADDR_STATE;
                else
                    axi_state <= RESET_STATE;
                end if;   
             when WR_ADDR_DATA_STATE =>
                s_axi_csr_wready  <= '1';
                s_axi_csr_awready <= '1';       
                w_strb        <= s_axi_csr_wstrb(3 downto 0);
                w_data        <= s_axi_csr_wdata;
                w_addr        <= s_axi_csr_awaddr;
                axi_state         <= WR_ADDR_DEC_STATE;
             when WR_DATA_STATE =>
                s_axi_csr_wready <= '1';
                w_strb        <= s_axi_csr_wstrb(3 downto 0);
                w_data        <= s_axi_csr_wdata;
                axi_state     <= WR_ADDR2_STATE;
             when WR_ADDR2_STATE =>
                s_axi_csr_wready <= '0';
                if (s_axi_csr_awvalid = '1') then      
                   axi_state  <= WR_ADDR_DEC_STATE;
                   s_axi_csr_awready <= '1';
                   w_addr <= s_axi_csr_awaddr;
                else
                   axi_state  <= WR_ADDR2_STATE;
                end if;  
             when WR_ADDR_STATE =>
                   s_axi_csr_awready <= '1';
                   w_addr        <= s_axi_csr_awaddr;
                   axi_state         <= WR_DATA2_STATE;
             when WR_DATA2_STATE =>
                s_axi_csr_awready <= '0';
                if (s_axi_csr_wvalid = '1') then      
                   axi_state    <= WR_ADDR_DEC_STATE;
                   s_axi_csr_wready <= '1';
                   w_strb       <= s_axi_csr_wstrb(3 downto 0);
                   w_data       <= s_axi_csr_wdata;
                else
                   axi_state    <= WR_DATA2_STATE;
                end if;    
             when WR_ADDR_DEC_STATE =>
                s_axi_csr_wready <= '0';
                s_axi_csr_awready <= '0';  
                -- Interrupt Enable Register[31:0] 
                if w_addr(2) = '0' then
                   if  w_strb(0) = '1' then
                       intrpt_en_reg(7 downto 0)   <= w_data(7 downto 0);
                   end if;
                   if  w_strb(1) = '1' then
                       intrpt_en_reg(15 downto 8)  <= w_data(15 downto 8);
                   end if;
                   if  w_strb(2) = '1' then
                       intrpt_en_reg(23 downto 16) <= w_data(23 downto 16);
                   end if;
                   if  w_strb(3) = '1' then
                       intrpt_en_reg(31 downto 24) <= w_data(31 downto 24);
                   end if;                                  
                else -- Interrupt Flag Register
                   if  w_strb(0) = '1' then
                      intrpt_clr_vctr(7 downto 0)  <= w_data(7 downto 0);
                   end if;
                   if  w_strb(1) = '1' then
                      intrpt_clr_vctr(15 downto 8) <= w_data(15 downto 8);
                   end if;
                   if  w_strb(2) = '1' then
                      intrpt_clr_vctr(23 downto 16)<= w_data(23 downto 16);
                   end if;
                   if  w_strb(3) = '1' then
                      intrpt_clr_vctr(31 downto 24)<= w_data(31 downto 24);
                   end if;       
                end if;       
                axi_state         <= WR_B_RSP_STATE;
                s_axi_csr_bresp   <= "00";
                s_axi_csr_bvalid  <= '1';     
            when  WR_B_RSP_STATE =>
                intrpt_clr_vctr <= x"00000000";
                if s_axi_csr_bready = '1' then
                    s_axi_csr_bvalid <= '0';
                    axi_state <= RESET_STATE;
                else
                    axi_state <= WR_B_RSP_STATE;
                end if;    
            when  RD_ADDR_STATE =>
               s_axi_csr_arready <= '1';
               if s_axi_csr_araddr(2) = '0' then
                   -- Interrupt Enable Register[31:0]
                  rd_data(31 downto 0) <= intrpt_en_reg; 
               else
                  rd_data(31 downto 0) <= intrpt_flag_reg;
               end if; 
               axi_state   <= WAIT_RD_BS_STATE;
               rerror  <= '0';
            when WAIT_RD_BS_STATE =>
                s_axi_csr_arready <= '0';
                s_axi_csr_rdata   <= rd_data;
                s_axi_csr_rvalid  <= '1'; 
                s_axi_csr_rresp   <= rerror & '0';
                axi_state <= WAIT_RDDATA_RDY_STATE;              
            when WAIT_RDDATA_RDY_STATE =>   
                if s_axi_csr_rready = '1' then
                   s_axi_csr_rvalid <= '0';
                   axi_state <= RESET_STATE;
                else
                   axi_state <= WAIT_RDDATA_RDY_STATE;     
                end if;  
            when others =>
               axi_state <= RESET_STATE;
          end case;
       end if;
   end if;  
end process;

--------------------------------------------------------------------------------
-- Interrupt Flag Register
--------------------------------------------------------------------------------

-- Interrupt Source Monitoring
process(aclk)
begin
   if rising_edge(aclk) then
      t1_aresetn <= aresetn;
      t2_aresetn <= t1_aresetn;
      t3_aresetn <= t2_aresetn;
      t4_aresetn <= t3_aresetn;
      if (t1_aresetn = '0') or (t2_aresetn = '0') or (t3_aresetn = '0') then
         int            <= '0';
         t1_int_status  <= (others => '0');
         t2_int_status  <= (others => '0');
      else
         t1_int_status  <= int_in_vctr;
         t2_int_status  <= t1_int_status;
         if (int_or = x"00000000") then -- interrupt is off
            int            <= '0';
         else
            int            <= '1';     -- interrupt is on
         end if; 
      end if;  
   end if;
end process;

-- Latch the interrupt sources
gen_int_reg: for i in 0 to 31 generate

int_in_vctr(i) <= int_in(i) when (i < num_interrupt_sources) else '0';

process(aclk)
begin
   if rising_edge(aclk) then
      if (t1_aresetn = '0') or (t2_aresetn = '0') or (t3_aresetn = '0') or (t4_aresetn = '0') then
         intrpt_flag_reg(i) <= '0';
      elsif t2_int_status(i)   = '1' then
         intrpt_flag_reg(i) <= '1';
      elsif intrpt_clr_vctr(i) = '1' then
         intrpt_flag_reg(i) <= '0';
      end if;   
   end if;
end process;

int_or(i) <= intrpt_flag_reg(i) and intrpt_en_reg(i);

end generate;

--------------------------------------------------------------------------------


msi_enable_out <= cfg_interrupt_msi_enable when (ku = 1) else ("00" & cfg_interrupt_msi_enable);

--cfg_interrupt_pending(0) <= int;
--cfg_interrupt_pending((ku*2)+1 downto 1) <= (others => '0');
cfg_interrupt_pending <= (others => '0');

cfg_interrupt_msi_int(63-(ku*32) downto 1)  <= (others => '0');

cfg_interrupt_msi_attr              <= (others => '0');
cfg_interrupt_msi_tph_present       <= '0';
cfg_interrupt_msi_tph_type          <= (others => '0');
cfg_interrupt_msi_tph_st_tag        <= (others => '0');
cfg_interrupt_msi_function_number   <= (others => '0');

cfg_interrupt_msi_select            <= (others => '0');
cfg_interrupt_msi_pending_status(63-(ku*32) downto 0) <= (others => '0');
cfg_interrupt_msi_pending_status_function_num <= (others => '0');
--cfg_interrupt_msi_pending_status_data_enable  <= cfg_interrupt_msi_enable(0);
cfg_interrupt_msi_pending_status_data_enable  <= '0';

-------------------------------------------------------------------------------
-- Legacy Interrupts
-------------------------------------------------------------------------------
process(aclk)
begin
   if rising_edge(aclk) then
      if cfg_interrupt_msi_enable(0) = '0' then
         if int = '1' then
            cfg_interrupt_int <= "0001";
         else
            cfg_interrupt_int <= "0000";
         end if;
      else
      cfg_interrupt_int <= "0000";
      end if;
   end if;
end process;   

-------------------------------------------------------------------------------
-- MSI Interrupt State Machine
-------------------------------------------------------------------------------

process(aclk)
begin
   if rising_edge(aclk) then
     if (t1_aresetn = '0') then
         state <= reset_state;
     elsif (cfg_interrupt_msi_enable(0) = '0') then
         state <= reset_state;
     else
         state <= next_state;
     end if;
   end if;
end process;

process(state, int, cfg_interrupt_msi_sent, cfg_interrupt_msi_fail , t1_aresetn, cfg_interrupt_msi_enable)
begin   
   case state is
      when reset_state =>
         if (t1_aresetn = '0') or (cfg_interrupt_msi_enable(0) = '0') then
            next_state <= reset_state;
         else
            next_state <= wait_for_int_state;
         end if;
      -- wait for interrupt input
      when wait_for_int_state =>
         -- if interrupt input, then output msi interrupt
         if (int = '1') then
            next_state <= int_assert_state;
         else -- continue waiting
            next_state <= wait_for_int_state;
         end if;
      -- generate an interrupt assert request
      when int_assert_state =>
         -- go and wait for interrupt sent signal
            next_state <= wait_for_sent_state;
      -- the interrupt level is "off"
      when wait_for_sent_state =>
         -- the interrupt was sent, so go wait until interrupt input goes low.
         if (cfg_interrupt_msi_sent = '1') then
            next_state  <= wait_int_in_low_state;
         -- the interrupt failed, so resend.   
         elsif (cfg_interrupt_msi_fail = '1') then
            next_state  <= int_assert_state;
         -- continue waiting
         else
            next_state <= wait_for_sent_state;
         end if;
      -- wait until the interrupt input source goes low again
      when wait_int_in_low_state =>
         -- the interrupt went "off"
         if int = '0' then
            next_state <= wait_for_int_state;
         -- continue waiting.
         else
            next_state <= wait_int_in_low_state;
         end if;
      when others =>
         next_state <= reset_state;
   end case;
end process;


process(aclk)
begin
   if rising_edge(aclk) then
      case next_state is
         when reset_state =>
            cfg_interrupt_msi_int(0) <= '0';
            --cfg_interrupt_msi_pending_status(0) <= '0'; 
         when wait_for_int_state =>
            cfg_interrupt_msi_int(0) <= '0';
            --cfg_interrupt_msi_pending_status(0) <= '0'; 
         -- generate an interrupt assert
         when int_assert_state =>
            cfg_interrupt_msi_int(0) <= '1';
            --cfg_interrupt_msi_pending_status(0) <= '1'; 
         when wait_for_sent_state =>
            cfg_interrupt_msi_int(0) <= '0';
            --cfg_interrupt_msi_pending_status(0) <= '1'; 
         when wait_int_in_low_state =>
            cfg_interrupt_msi_int(0) <= '0';
            --cfg_interrupt_msi_pending_status(0) <= '0'; 
         when others =>
            cfg_interrupt_msi_int(0) <= '0';
            --cfg_interrupt_msi_pending_status(0) <= '0'; 
      end case;
   end if;
end process;


end Behavioral;
