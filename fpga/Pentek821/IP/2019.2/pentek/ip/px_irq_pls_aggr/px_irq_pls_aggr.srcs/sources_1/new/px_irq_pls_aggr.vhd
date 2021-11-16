----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/24/2015 12:51:24 PM
-- Design Name: 
-- Module Name: px_irq_pls_aggr - Behavioral
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
-- Interrupt inputs are expected to be pulses and synchronous with the clock.
-- There is no enable register, so interrupts are assumed to come from 
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
use ieee.numeric_std.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity px_irq_pls_aggr is
generic(
   num_interrupt_sources : integer := 32 -- number of input interrupts
);
port (
    --------------------------------------------------------------------------------
    -- AXI LITE Slave Interface  
    -- DWORD Addressing
    --------------------------------------------------------------------------------
    s_axi_csr_aclk            : in  std_logic;
    s_axi_csr_aresetn         : in  std_logic;
    s_axi_csr_awaddr          : in  std_logic_vector(2 downto 0);
    s_axi_csr_awprot          : in  std_logic_vector(2 downto 0); -- not used
    s_axi_csr_awvalid         : in  std_logic;
    s_axi_csr_awready         : out std_logic;
    s_axi_csr_wdata           : in  std_logic_vector(31 downto 0);
    s_axi_csr_wstrb           : in  std_logic_vector(3 downto 0); 
    s_axi_csr_wvalid          : in  std_logic;
    s_axi_csr_wready          : out std_logic;
    s_axi_csr_bresp           : out std_logic_vector(1 downto 0);
    s_axi_csr_bvalid          : out std_logic;
    s_axi_csr_bready          : in  std_logic;
    s_axi_csr_araddr          : in  std_logic_vector(2 downto 0);
    s_axi_csr_arprot          : in  std_logic_vector(2 downto 0); -- not used
    s_axi_csr_arvalid         : in  std_logic;
    s_axi_csr_arready         : out std_logic;
    s_axi_csr_rdata           : out std_logic_vector(31 downto 0);
    s_axi_csr_rresp           : out std_logic_vector(1 downto 0);
    s_axi_csr_rvalid          : out std_logic;
    s_axi_csr_rready          : in  std_logic; 
   -----------------------------------------------------------------------------
    -- Interrupt Sources (pulsed edge type)
    -----------------------------------------------------------------------------
    intrpt_in                 : in  std_logic_vector(num_interrupt_sources-1 downto 0);    
    -----------------------------------------------------------------------------
    -- Interrupt Output (pulsed edge type)
    -----------------------------------------------------------------------------
    irq_out                   : out std_logic         
);
end px_irq_pls_aggr;

architecture Behavioral of px_irq_pls_aggr is

-------------------------------------------------------------------------------
-- Attributes
-------------------------------------------------------------------------------

ATTRIBUTE X_INTERFACE_INFO : STRING;
ATTRIBUTE X_INTERFACE_PARAMETER : STRING;

ATTRIBUTE X_INTERFACE_INFO of irq_out: SIGNAL is "xilinx.com:signal:interrupt:1.0 irq_out INTR";
ATTRIBUTE X_INTERFACE_PARAMETER of irq_out: SIGNAL is "SENSITIVITY EDGE_RISING";

ATTRIBUTE X_INTERFACE_INFO of s_axi_csr_aclk: SIGNAL is "xilinx.com:signal:clock:1.0 s_axi_csr_aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of s_axi_csr_aclk: SIGNAL is "ASSOCIATED_BUSIF s_axi_csr, ASSOCIATED_RESET s_axi_csr_aresetn";


-------------------------------------------------------------------------------
-- Types
-------------------------------------------------------------------------------

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

signal axi_state        : axi_state_type := RESET_STATE;
signal t1_aresetn       : std_logic := '0';
signal t2_aresetn       : std_logic := '0';
signal t3_aresetn       : std_logic := '0';
signal intrpt_en_reg    : std_logic_vector(31 downto 0) := (others => '0');
signal t1_int_status    : std_logic_vector(31 downto 0) := (others => '0'); 
signal t2_int_status    : std_logic_vector(31 downto 0) := (others => '0'); 
signal intrpt_clr_vctr  : std_logic_vector(31 downto 0) := (others => '0');
signal intrpt_in_vctr   : std_logic_vector(31 downto 0) := (others => '0');
signal intrpt_flag_reg  : std_logic_vector(31 downto 0) := (others => '0');
signal rd_data          : std_logic_vector(31 downto 0) := (others => '0');
signal w_data           : std_logic_vector(31 downto 0) := (others => '0');
signal w_addr           : std_logic_vector(2 downto 0)  := (others => '0');
signal int_or           : std_logic_vector(31 downto 0) := (others => '0');
signal irq              : std_logic := '0';
signal t1_s_axi_csr_aresetn: std_logic := '0';
-------------------------------------------------------------------------------

begin


-------------------------------------------------------------------------------
-- AXI4-Lite Interface State Machine
-------------------------------------------------------------------------------
process(s_axi_csr_aclk)
begin
    if rising_edge(s_axi_csr_aclk) then
        t1_s_axi_csr_aresetn <= s_axi_csr_aresetn;
        if t1_s_axi_csr_aresetn = '0' then
           axi_state           <= RESET_STATE;
           s_axi_csr_awready   <= '0'; 
           s_axi_csr_wready    <= '0';  
           s_axi_csr_arready   <= '0'; 
           s_axi_csr_rvalid    <= '0';  
           s_axi_csr_bvalid    <= '0';
           intrpt_en_reg       <= (others => '0');
           intrpt_clr_vctr     <= (others => '0');
        else 
           case axi_state is 
            when RESET_STATE =>
                if (t1_s_axi_csr_aresetn = '0') then
                    axi_state           <= RESET_STATE;
                    s_axi_csr_awready   <= '0';
                    s_axi_csr_wready    <= '0';
                    s_axi_csr_arready   <= '0'; 
                    s_axi_csr_rvalid    <= '0';  
                    s_axi_csr_bvalid    <= '0';
                    intrpt_en_reg       <= (others => '0');
                    intrpt_clr_vctr     <= (others => '0');
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
                w_addr            <= s_axi_csr_awaddr;
                w_data            <= s_axi_csr_wdata;
                axi_state         <= WR_ADDR_DEC_STATE;
             when WR_DATA_STATE =>
                s_axi_csr_wready  <= '1';
                w_data            <= s_axi_csr_wdata;
                axi_state         <= WR_ADDR2_STATE;
             when WR_ADDR2_STATE =>
                s_axi_csr_wready     <= '0';
                if (s_axi_csr_awvalid = '1') then   
                   w_addr <= s_axi_csr_awaddr;   
                   axi_state  <= WR_ADDR_DEC_STATE;
                   s_axi_csr_awready <= '1';
                else
                   axi_state         <= WR_ADDR2_STATE;
                end if;  
             when WR_ADDR_STATE =>
                   w_addr <= s_axi_csr_awaddr;
                   s_axi_csr_awready <= '1';
                   axi_state     <= WR_DATA2_STATE;
             when WR_DATA2_STATE =>
                s_axi_csr_awready <= '0';
                if (s_axi_csr_wvalid = '1') then      
                   axi_state        <= WR_ADDR_DEC_STATE;
                   s_axi_csr_wready <= '1';
                   w_data           <= s_axi_csr_wdata;
                else
                   axi_state  <= WR_DATA2_STATE;
                end if;    
             when WR_ADDR_DEC_STATE =>
                s_axi_csr_wready  <= '0';
                s_axi_csr_awready <= '0';   
                if w_addr(2) = '0' then
                -- Interrupt Enable Register[31:0]
                   intrpt_en_reg   <= w_data;                
                else -- Interrupt Flag Register
                   intrpt_clr_vctr <= w_data;
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
               s_axi_csr_arready    <= '1';
               if s_axi_csr_araddr(2) = '0' then
                   -- Interrupt Enable Register[31:0]
                  rd_data(31 downto 0) <= intrpt_en_reg; 
               else
                  rd_data(31 downto 0) <= intrpt_flag_reg;
               end if; 
               axi_state            <= WAIT_RD_BS_STATE;
            when WAIT_RD_BS_STATE =>
                s_axi_csr_arready <= '0';
                s_axi_csr_rdata   <= rd_data;
                s_axi_csr_rvalid  <= '1'; 
                s_axi_csr_rresp   <= "00";
                axi_state         <= WAIT_RDDATA_RDY_STATE;              
            when WAIT_RDDATA_RDY_STATE =>   
                if s_axi_csr_rready = '1' then
                   s_axi_csr_rvalid <= '0';
                   axi_state        <= RESET_STATE;
                else
                   axi_state        <= WAIT_RDDATA_RDY_STATE;     
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
process(s_axi_csr_aclk)
begin
   if rising_edge(s_axi_csr_aclk) then
      t1_aresetn <= t1_s_axi_csr_aresetn;
      t2_aresetn <= t1_aresetn;
      t3_aresetn <= t2_aresetn;
      if (t1_s_axi_csr_aresetn = '0') or (t1_aresetn = '0') or (t2_aresetn = '0') then
         irq            <= '0';
         irq_out        <= '0'; 
         t1_int_status  <= (others => '0');
         t2_int_status  <= (others => '0');
      else
         t1_int_status  <= intrpt_in_vctr;
         t2_int_status  <= t1_int_status;
         if ( int_or = x"00000000") then -- interrupt is off
            irq            <= '0';
         else
            irq            <= '1';     -- interrupt is on
         end if; 
         irq_out <= irq;
      end if;  
   end if;
end process;

-- Latch the interrupt sources
gen_int_reg: for i in 0 to 31 generate

intrpt_in_vctr(i) <= intrpt_in(i) when (i < num_interrupt_sources) else '0';

process(s_axi_csr_aclk)
begin
   if rising_edge(s_axi_csr_aclk) then
      if (t1_s_axi_csr_aresetn = '0') or (t1_aresetn = '0') or (t2_aresetn = '0') or (t3_aresetn = '0') then
         intrpt_flag_reg(i) <= '0';
      elsif int_or(i)   = '1' then
         intrpt_flag_reg(i) <= '1';
      elsif intrpt_clr_vctr(i) = '1' then
         intrpt_flag_reg(i) <= '0';
      end if;   
   end if;
end process;

int_or(i) <= t2_int_status(i) and intrpt_en_reg(i);

end generate;

end Behavioral;
