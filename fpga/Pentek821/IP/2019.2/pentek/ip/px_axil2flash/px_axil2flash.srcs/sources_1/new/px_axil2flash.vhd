----------------------------------------------------------------------------------
-- Pentek AXI4-LITE to 16-bit Parallel NOR Flash Bridge
----------------------------------------------------------------------------------
-- px_axil2flash.vhd
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

entity px_axil2flash is
generic (
   flash_addr_bits : integer := 24 -- number of FLASH Address bits
);
port( 
--------------------------------------------------------------------------------
-- AXI LITE Slave Interface  
--------------------------------------------------------------------------------
    s_axi_aclk      : in  std_logic;
    s_axi_aresetn   : in  std_logic;
    s_axi_awaddr    : in  std_logic_vector(3 downto 0);
    s_axi_awprot    : in  std_logic_vector(2 downto 0); -- not used
    s_axi_awvalid   : in  std_logic;
    s_axi_awready   : out std_logic;
    s_axi_wdata     : in  std_logic_vector(31 downto 0);
    s_axi_wstrb     : in  std_logic_vector(3 downto 0); -- not used
    s_axi_wvalid    : in  std_logic;
    s_axi_wready    : out std_logic;
    s_axi_bresp     : out std_logic_vector(1 downto 0);
    s_axi_bvalid    : out std_logic;
    s_axi_bready    : in  std_logic;
    s_axi_araddr    : in  std_logic_vector(3 downto 0);
    s_axi_arprot    : in  std_logic_vector(2 downto 0); -- not used
    s_axi_arvalid   : in  std_logic;
    s_axi_arready   : out std_logic;
    s_axi_rdata     : out std_logic_vector(31 downto 0);
    s_axi_rresp     : out std_logic_vector(1 downto 0);
    s_axi_rvalid    : out std_logic;
    s_axi_rready    : in  std_logic;
--------------------------------------------------------------------------------
-- Flash Interface
--------------------------------------------------------------------------------
    flash_d_i       : in    std_logic_vector(15 downto 0);
    flash_d_o       : out   std_logic_vector(15 downto 0);
    flash_d_t       : out   std_logic_vector(15 downto 0);
    flash_a         : out   std_logic_vector(flash_addr_bits-1 downto 0);
    flash_adv_b     : out   std_logic;
    flash_fwe_b     : out   std_logic;
    flash_fcs_b     : out   std_logic;
    flash_foe_b     : out   std_logic
);
end px_axil2flash;

architecture Behavioral of px_axil2flash is

--------------------------------------------------------------------------------
-- Attributes
--------------------------------------------------------------------------------

ATTRIBUTE X_INTERFACE_INFO : STRING;
ATTRIBUTE X_INTERFACE_PARAMETER : STRING;

ATTRIBUTE X_INTERFACE_INFO of s_axi_aclk: SIGNAL is "xilinx.com:signal:clock:1.0 s_axi_aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of s_axi_aclk: SIGNAL is "ASSOCIATED_BUSIF s_axi, ASSOCIATED_RESET s_axi_aresetn";

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
    WR_RQST_STATE,
    WAIT_WR_RDY_STATE,
    WR_RQST_WAIT_STATE,
    WAIT_WR_RSP_STATE,
    WR_B_RSP_STATE,
    RD_ADDR_STATE,
    RD_RQST_STATE,
    WAIT_RD_BS_STATE,
    RD_RQST_WAIT_STATE,
    WAIT_RD_RDY_STATE,
    WAIT_RD_CMPLT_STATE,
    WAIT_RDDATA_RDY_STATE
);
-------------------------------------------------------------------------------
-- Signals
-------------------------------------------------------------------------------

signal state : state_type := RESET_STATE;
signal cycle_counter    : std_logic_vector(4 downto 0);
signal t1_s_axi_aresetn : std_logic := '0';
signal w_data           : std_logic_vector(31 downto 0) := (others => '0');
signal rd_data          : std_logic_vector(31 downto 0) := (others => '0');
signal w_addr           : std_logic_vector(3 downto 0) := (others => '0');
signal fdata_oe_n       : std_logic := '1';
signal flash_addr       : std_logic_vector(31 downto 0) := (others => '0');
signal wdata            : std_logic_vector(15 downto 0) := (others => '0');
signal rdata            : std_logic_vector(15 downto 0) := (others => '0');
signal waddr            : std_logic_vector(31 downto 0) := (others => '0');
signal cntr_ld          : std_logic := '0';  

--------------------------------------------------------------------------------

begin

process(s_axi_aclk)
begin
    if rising_edge(s_axi_aclk) then
        if (t1_s_axi_aresetn = '0') then
           state <= RESET_STATE;
           s_axi_awready <= '0'; 
           s_axi_wready  <= '0';  
           s_axi_arready <= '0'; 
           s_axi_rvalid  <= '0';  
           s_axi_bvalid  <= '0';
           flash_addr    <= (others => '0');
           flash_adv_b   <= '1';
           flash_fwe_b   <= '1';
           flash_fcs_b   <= '1';
           flash_foe_b   <= '1';
           fdata_oe_n    <= '1';
           cntr_ld       <= '0';

        else 
           case state is 
            when RESET_STATE =>
                if (t1_s_axi_aresetn = '0') then
                    state <= RESET_STATE;
                    s_axi_awready <= '0';
                    s_axi_wready  <= '0';
                    s_axi_arready <= '0'; 
                    s_axi_rvalid  <= '0';  
                    s_axi_bvalid  <= '0';
                    flash_addr    <= (others => '0');
                    flash_adv_b   <= '1';
                    flash_fwe_b   <= '1';
                    flash_fcs_b   <= '1';
                    flash_foe_b   <= '1';
                    fdata_oe_n    <= '1';
                    cntr_ld       <= '0'; 
                elsif (s_axi_awvalid = '1') then  
                    if (s_axi_wvalid = '1') then
                        state <=  WR_ADDR_DATA_STATE;
                    else
                        state <=  WR_ADDR_STATE;
                    end if; 
                elsif (s_axi_wvalid = '1') then
                    state <=  WR_DATA_STATE;
                elsif (s_axi_arvalid = '1') then
                    state <=  RD_ADDR_STATE;
                else
                    state <= RESET_STATE;
                end if;    
             when WR_ADDR_DATA_STATE =>
                s_axi_wready <= '1';
                s_axi_awready <= '1';       
                w_data <= s_axi_wdata;
                w_addr <= s_axi_awaddr;
                state  <= WR_ADDR_DEC_STATE;
             when WR_DATA_STATE =>
                s_axi_wready <= '1';
                w_data <= s_axi_wdata;
                state  <= WR_ADDR2_STATE;
             when WR_ADDR2_STATE =>
                s_axi_wready <= '0';
                if (s_axi_awvalid = '1') then      
                   state  <= WR_ADDR_DEC_STATE;
                   s_axi_awready <= '1';
                   w_addr <= s_axi_awaddr;
                else
                   state  <= WR_ADDR2_STATE;
                end if;  
             when WR_ADDR_STATE =>
                   s_axi_awready <= '1';
                   w_addr <= s_axi_awaddr;
                   state  <= WR_DATA2_STATE;
             when WR_DATA2_STATE =>
                s_axi_awready <= '0';
                if (s_axi_wvalid = '1') then      
                   state  <= WR_ADDR_DEC_STATE;
                   s_axi_wready <= '1';
                   w_data <= s_axi_wdata;
                else
                   state  <= WR_DATA2_STATE;
                end if;    
             when WR_ADDR_DEC_STATE =>
                s_axi_wready <= '0';
                s_axi_awready <= '0';   
                if (w_addr(2) = '0') then
                    -- Flash Address[31:0]
                    flash_addr(31 downto 0) <=  w_data;
                    state <= WR_B_RSP_STATE;
                    s_axi_bresp  <= "00";
                    s_axi_bvalid <= '1';
                else
                    state <= WR_RQST_STATE;
                end if;            
             when WR_RQST_STATE =>
                cntr_ld     <= '1';
                waddr       <= flash_addr;
                wdata       <= w_data(15 downto 0);
                state       <=  WR_RQST_WAIT_STATE;           
                flash_addr  <= flash_addr + 1; --4;  
            when WR_RQST_WAIT_STATE =>   
                state       <=  WAIT_WR_RDY_STATE; 
                cntr_ld     <= '0'; 
            when WAIT_WR_RDY_STATE =>
               if (cycle_counter = "00000") then
                  state     <=  WAIT_WR_RSP_STATE;
               else
                  state     <=  WAIT_WR_RDY_STATE; 
               end if;
               case conv_integer('0' & cycle_counter) is
                   when 28 to 31 =>
                      flash_adv_b <= '1';
                      flash_fwe_b <= '1';
                      flash_fcs_b <= '1';
                      flash_foe_b <= '1';
                      fdata_oe_n  <= '1';
                   when 24 to 27 =>
                      flash_adv_b <= '0';
                      flash_fwe_b <= '1';
                      flash_fcs_b <= '0';
                      flash_foe_b <= '1';
                      fdata_oe_n  <= '1';
                   when 10 to 23 =>
                      flash_adv_b <= '1';
                      flash_fwe_b <= '0';
                      flash_fcs_b <= '0';
                      flash_foe_b <= '1';
                      fdata_oe_n  <= '0';
                   when 6 to 9 =>
                      flash_adv_b <= '1';
                      flash_fwe_b <= '1';
                      flash_fcs_b <= '0';
                      flash_foe_b <= '1';
                      fdata_oe_n  <= '0';
                   when 3 to 5 =>
                      flash_adv_b <= '1';
                      flash_fwe_b <= '1';
                      flash_fcs_b <= '1';
                      flash_foe_b <= '1';
                      fdata_oe_n  <= '1';
                   when 2 =>
                      flash_adv_b <= '1';
                      flash_fwe_b <= '1';
                      flash_fcs_b <= '1';
                      flash_foe_b <= '1';
                      fdata_oe_n  <= '1';
                   when 1 =>
                      flash_adv_b <= '1';
                      flash_fwe_b <= '1';
                      flash_fcs_b <= '1';
                      flash_foe_b <= '1';
                      fdata_oe_n  <= '1';
                   when 0 =>
                      flash_adv_b <= '1';
                      flash_fwe_b <= '1';
                      flash_fcs_b <= '1';
                      flash_foe_b <= '1';
                      fdata_oe_n  <= '1';
                   when others =>
                      flash_adv_b <= '1';
                      flash_fwe_b <= '1';
                      flash_fcs_b <= '1';
                      flash_foe_b <= '1';
                      fdata_oe_n  <= '1';
                end case;
            when WAIT_WR_RSP_STATE =>  
               state <= WR_B_RSP_STATE;
               s_axi_bresp  <= "00";
               s_axi_bvalid <= '1';
            when  WR_B_RSP_STATE =>
                if s_axi_bready = '1' then
                    s_axi_bvalid <= '0';
                    state <= RESET_STATE;
                else
                    state <= WR_B_RSP_STATE;
                end if;    
            when  RD_ADDR_STATE =>
               s_axi_arready <= '1';
               if (s_axi_araddr(2) = '0') then
                   -- FLASH Address[31:0]
                   rd_data(31 downto 0) <= flash_addr(31 downto 0);
                   state <= WAIT_RD_BS_STATE;
               else    
                   -- Flash Data Access
                   state <= RD_RQST_STATE;
               end if;    
            when RD_RQST_STATE =>
                s_axi_arready <= '0';
                cntr_ld       <= '1';
                waddr         <= flash_addr;       
                flash_addr    <= flash_addr + 1; --4;  
                state         <=  RD_RQST_WAIT_STATE;  
            when RD_RQST_WAIT_STATE =>   
                state         <=  WAIT_RD_RDY_STATE; 
                cntr_ld       <= '0';       
            when WAIT_RD_RDY_STATE =>
               if (cycle_counter = "00000") then
                  state       <=  WAIT_RD_CMPLT_STATE;
               else
                  state       <=  WAIT_RD_RDY_STATE; 
               end if;
               case conv_integer('0' & cycle_counter) is
                   when 28 to 31 =>
                      flash_adv_b <= '1';
                      flash_fwe_b <= '1';
                      flash_fcs_b <= '1';
                      flash_foe_b <= '1';
                      fdata_oe_n  <= '1';
                   when 24 to 27 =>
                      flash_adv_b <= '0';
                      flash_fwe_b <= '1';
                      flash_fcs_b <= '0';
                      flash_foe_b <= '1';
                      fdata_oe_n  <= '1';
                   when 10 to 23 =>
                      flash_adv_b <= '1';
                      flash_fwe_b <= '1';
                      flash_fcs_b <= '0';
                      flash_foe_b <= '0';
                      fdata_oe_n  <= '1';
                   when 6 to 9 =>
                      flash_adv_b <= '1';
                      flash_fwe_b <= '1';
                      flash_fcs_b <= '0';
                      flash_foe_b <= '0';
                      fdata_oe_n  <= '1';
                   when 3 to 5 =>
                      flash_adv_b <= '1';
                      flash_fwe_b <= '1';
                      flash_fcs_b <= '0';
                      flash_foe_b <= '0';
                      fdata_oe_n  <= '1';
                   when 2 =>
                      flash_adv_b <= '1';
                      flash_fwe_b <= '1';
                      flash_fcs_b <= '0';
                      flash_foe_b <= '0';
                      fdata_oe_n  <= '1';
                   when 1 =>
                      flash_adv_b <= '1';
                      flash_fwe_b <= '1';
                      flash_fcs_b <= '1';
                      flash_foe_b <= '1';
                      rd_data  <= x"0000" & rdata;
                      fdata_oe_n  <= '1';
                   when 0 =>
                      flash_adv_b <= '1';
                      flash_fwe_b <= '1';
                      flash_fcs_b <= '1';
                      flash_foe_b <= '1';                
                      fdata_oe_n  <= '1';
                   when others =>
                      flash_adv_b <= '1';
                      flash_fwe_b <= '1';
                      flash_fcs_b <= '1';
                      flash_foe_b <= '1';
                      fdata_oe_n  <= '1';
                  end case;
            when WAIT_RD_BS_STATE =>
                s_axi_arready <= '0';

            when WAIT_RD_CMPLT_STATE =>
                s_axi_rdata  <= rd_data;
                s_axi_rvalid <= '1'; 
                s_axi_rresp  <= "00";
                state        <= WAIT_RDDATA_RDY_STATE;  
                
            when WAIT_RDDATA_RDY_STATE =>   
                if s_axi_rready = '1' then
                    s_axi_rvalid <= '0';
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

flash_d_o <= wdata;
flash_d_t <= x"FFFF" when (fdata_oe_n = '1') else x"0000";
rdata     <= flash_d_i;
flash_a   <= waddr(flash_addr_bits-1 downto 0);

process(s_axi_aclk)
begin
   if rising_edge(s_axi_aclk) then
      t1_s_axi_aresetn <= s_axi_aresetn;
   end if;
end process;

-- Clock Cycle Counter
process(s_axi_aclk)
begin
   if rising_edge(s_axi_aclk) then
      if (t1_s_axi_aresetn = '0') then
         cycle_counter <= (others => '0');
      elsif (cntr_ld = '1') then
         cycle_counter <= "11111";
      elsif  cycle_counter /= "00000" then
         cycle_counter <= cycle_counter - 1;
      end if;
   end if;
end process;



end Behavioral;
