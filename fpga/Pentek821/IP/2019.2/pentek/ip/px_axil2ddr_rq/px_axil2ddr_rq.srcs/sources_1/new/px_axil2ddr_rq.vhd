----------------------------------------------------------------------------------
-- Company: Pentek, Inc.
-- Engineer: 
-- 
-- Create Date: 03/21/2016 08:27:32 AM
-- Design Name: AXI-Lite to AXIS DDR4 Requester
-- Module Name: px_axil2ddr_rq - Behavioral
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
----------------------------------------------------------------------------------

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

entity px_axil2ddr_rq is
generic ( 
    id      : integer := 0; -- range = 0 to 255 
    has_irq : boolean := true -- Has Interrupt Output when true. 
);
port (
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
    irq             : out std_logic;
   ----------------------------------------------------------------------------
    -- DDR4 Request Interface (AXI Stream)
    ----------------------------------------------------------------------------  
    -- tuser[127:0]  = Request Header
    -- tuser[31:0]  = Address (Address must be aligned to the request size boundaries)
    -- tuser[34:32] = Future Address Expansion
    -- tuser[35]    = Read = 1, Write = 0
    -- tuser[39:36] = Reserved
    -- tuser[119:40]= Byte Masks
    -- tuser[255:128] = Upper 128-bits of RAM Data 
    m_axis_rqst_tvalid    : out std_logic;
    m_axis_rqst_tready    : in  std_logic;   
    m_axis_rqst_tlast     : out std_logic;
    m_axis_rqst_tid       : out std_logic_vector(7 downto 0);
    m_axis_rqst_tdata     : out std_logic_vector(511 downto 0); 
    m_axis_rqst_tuser     : out std_logic_vector(255 downto 0);
    ----------------------------------------------------------------------------
    -- DDR4 Response Interface (AXI Stream)
    ----------------------------------------------------------------------------
    -- tuser[127:0] = Response Header
    -- tuser[31:0]  = Address (Address must be aligned to the request size boundaries)
    -- tuser[34:32] = Future Address Expansion
    -- tuser[39:36] = Reserved
    -- tuser[119:40]= Byte Masks 
    -- tuser[255:128] = Upper 128-bits of RAM Data 
    s_axis_rsp_tvalid     : in  std_logic;
    s_axis_rsp_tlast      : in  std_logic;
    s_axis_rsp_tid        : in  std_logic_vector(7 downto 0);
    s_axis_rsp_tdata      : in  std_logic_vector(511 downto 0); 
    s_axis_rsp_tuser      : in  std_logic_vector(255 downto 0)
    );
end px_axil2ddr_rq;

architecture Behavioral of px_axil2ddr_rq is

--------------------------------------------------------------------------------
-- Attributes
--------------------------------------------------------------------------------

ATTRIBUTE X_INTERFACE_INFO : STRING;
ATTRIBUTE X_INTERFACE_PARAMETER : STRING;

ATTRIBUTE X_INTERFACE_INFO of s_axi_aclk: SIGNAL is "xilinx.com:signal:clock:1.0 s_axi_aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of s_axi_aclk: SIGNAL is "ASSOCIATED_BUSIF s_axi:m_axis_rqst:s_axis_rsp, ASSOCIATED_RESET s_axi_aresetn";

--------------------------------------------------------------------------------
-- Components
--------------------------------------------------------------------------------

-- AXIS Register Slice
COMPONENT px_axil2ddr_rsp_rslice
  PORT (
    aclk : IN STD_LOGIC;
    aresetn : IN STD_LOGIC;
    s_axis_tvalid : IN STD_LOGIC;
    s_axis_tdata : IN STD_LOGIC_VECTOR(639 DOWNTO 0);
    s_axis_tid : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    m_axis_tvalid : OUT STD_LOGIC;
    m_axis_tdata : OUT STD_LOGIC_VECTOR(639 DOWNTO 0);
    m_axis_tid : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
  );
END COMPONENT;

-- AXIS Register Slice
COMPONENT px_axil2ddr_rqst_rslice
  PORT (
    aclk : IN STD_LOGIC;
    aresetn : IN STD_LOGIC;
    s_axis_tvalid : IN STD_LOGIC;
    s_axis_tready : OUT STD_LOGIC;
    s_axis_tdata : IN STD_LOGIC_VECTOR(511 DOWNTO 0);
    s_axis_tuser : IN STD_LOGIC_VECTOR(255 DOWNTO 0);
    m_axis_tvalid : OUT STD_LOGIC;
    m_axis_tready : IN STD_LOGIC;
    m_axis_tdata : OUT STD_LOGIC_VECTOR(511 DOWNTO 0);
    m_axis_tuser : OUT STD_LOGIC_VECTOR(255 DOWNTO 0)
  );
END COMPONENT;

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
    WR_B_RSP_STATE,
    RD_ADDR_STATE,
    RD_RQST_STATE,
    WAIT_RD_RDY_STATE,
    WAIT_RD_RSP_STATE,
    WAIT_RD_BS_STATE,
    WAIT_RD_CMPLT_STATE,
    WAIT_RDDATA_RDY_STATE
);

--------------------------------------------------------------------------------
-- Signals
--------------------------------------------------------------------------------

signal state : state_type := RESET_STATE;
signal w_data : std_logic_vector(31 downto 0) := (others => '0');
signal w_addr : std_logic_vector(3 downto 0) := (others => '0');
signal ddr4_addr : std_logic_vector(34 downto 0) := (others => '0');
signal mem_area : std_logic := '0';
signal byte_mask: std_logic_vector(3 downto 0) := (others => '0');
signal rd_data: std_logic_vector(639 downto 0) := (others => '0');
signal rerror: std_logic := '0';
signal rqst_tvalid: std_logic := '0';  
signal rqst_tready: std_logic := '0';  
signal rqst_tdata: std_logic_vector(511 downto 0) := (others => '0');
signal rqst_tuser: std_logic_vector(255 downto 0) := (others => '0');   
signal reg_tvalid: std_logic := '0';   
signal rsp_tvalid: std_logic := '0';   
signal rsp_tready : std_logic := '0';  
signal rsp_tid : std_logic_vector(7 downto 0) := (others => '0');   
signal rsp_tdata: std_logic_vector(639 downto 0) := (others => '0');
signal rsptdata: std_logic_vector(639 downto 0) := (others => '0');     
signal bs_data: std_logic_vector(31 downto 0):= (others => '0');
signal timeout_cntr: std_logic_vector(19 downto 0):= (others => '0');
signal int_enable: std_logic := '0';
signal mux_addr: std_logic_vector(4 downto 0) := (others => '0');
signal t1_s_axi_aresetn: std_logic := '0';
--------------------------------------------------------------------------------

begin

m_axis_rqst_tlast <= '1';
m_axis_rqst_tid   <= conv_std_logic_vector(id, 8);

process(s_axi_aclk)
begin
    if rising_edge(s_axi_aclk) then
        t1_s_axi_aresetn <= s_axi_aresetn;
        if t1_s_axi_aresetn = '0' then
           state <= RESET_STATE;
           s_axi_awready <= '0'; 
           s_axi_wready  <= '0';  
           s_axi_arready <= '0'; 
           s_axi_rvalid  <= '0';  
           s_axi_bvalid  <= '0';
           ddr4_addr     <= (others => '0');
           mem_area      <=  '0';
           int_enable    <= '0';
           irq           <= '0';
        else 
           case state is 
            when RESET_STATE =>
                irq <= '0';
                if (t1_s_axi_aresetn = '0') then
                    state <= RESET_STATE;
                    s_axi_awready <= '0';
                    s_axi_wready  <= '0';
                    s_axi_arready <= '0'; 
                    s_axi_rvalid  <= '0';  
                    s_axi_bvalid  <= '0';
                    ddr4_addr     <= (others => '0');
                    mem_area      <=  '0';
                    int_enable    <= '0';
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
                case w_addr(3 downto 2) is
                    when "00" => -- DDR4 Address[31:0]
                        ddr4_addr(31 downto 0) <= w_data;
                        state                  <= WR_B_RSP_STATE;
                        s_axi_bresp            <= "00";
                        s_axi_bvalid           <= '1';
                    when "01" => -- DDR4 Address[34:32] and Memory Area and Byte Enables
                        ddr4_addr(34 downto 32)<= w_data(2 downto 0); -- Future Address Expansion 
                        mem_area               <= w_data(3);
                        byte_mask              <= w_data(7 downto 4);
                        int_enable             <= w_data(8);
                        s_axi_bresp            <= "00";
                        s_axi_bvalid           <= '1';
                        state                  <= WR_B_RSP_STATE;
                    when "10" | "11" => -- DDR4 Data Access
                       state <= WR_RQST_STATE;
                    when others =>  
                       state <= WR_RQST_STATE;
                end case;          
             when WR_RQST_STATE =>
                rqst_tvalid <= '1';
                -- tuser[143:0] = Request Header
                -- tuser[31:0]  = Address (Address must be aligned to the request size boundaries)
                -- tuser[34:32] = Future Address Expansion
                -- tuser[35]    = Read = 1, Write = 0
                -- tuser[119:40]= Byte Enables    
                if mem_area = '0' then
                case ddr4_addr(5 downto 2) is
                  when x"0" => 
                     rqst_tuser(119 downto 40)  <= x"FFFFFFFFFFFFFFFFFFF" & byte_mask;
                  when x"1" => 
                     rqst_tuser(119 downto 40)  <= x"FFFFFFFFFFFFFFFFFF" & byte_mask & x"F";
                  when x"2" => 
                     rqst_tuser(119 downto 40)  <= x"FFFFFFFFFFFFFFFFF" & byte_mask & x"FF";
                  when x"3" => 
                     rqst_tuser(119 downto 40)  <= x"FFFFFFFFFFFFFFFF" & byte_mask & x"FFF";
                  when x"4" => 
                     rqst_tuser(119 downto 40)  <= x"FFFFFFFFFFFFFFF" & byte_mask & x"FFFF";
                  when x"5" => 
                     rqst_tuser(119 downto 40)  <= x"FFFFFFFFFFFFFF" & byte_mask & x"FFFFF";
                  when x"6" => 
                     rqst_tuser(119 downto 40)  <= x"FFFFFFFFFFFFF" & byte_mask & x"FFFFFF";
                  when x"7" => 
                     rqst_tuser(119 downto 40)  <= x"FFFFFFFFFFFF" & byte_mask & x"FFFFFFF";
                  when x"8" => 
                     rqst_tuser(119 downto 40)  <= x"FFFFFFFFFFF" & byte_mask & x"FFFFFFFF";
                  when x"9" => 
                     rqst_tuser(119 downto 40)  <= x"FFFFFFFFFF" & byte_mask & x"FFFFFFFFF";
                  when x"A" => 
                     rqst_tuser(119 downto 40)  <= x"FFFFFFFFF" & byte_mask & x"FFFFFFFFFF";
                  when x"B" => 
                     rqst_tuser(119 downto 40)  <= x"FFFFFFFF" & byte_mask & x"FFFFFFFFFFF";
                  when x"C" => 
                     rqst_tuser(119 downto 40)  <= x"FFFFFFF" & byte_mask & x"FFFFFFFFFFFF";
                  when x"D" => 
                     rqst_tuser(119 downto 40)  <= x"FFFFFF" & byte_mask & x"FFFFFFFFFFFFF";
                  when x"E" => 
                     rqst_tuser(119 downto 40)  <= x"FFFFF" & byte_mask & x"FFFFFFFFFFFFFF";
                  when x"F" => 
                     rqst_tuser(119 downto 40)  <= x"FFFF" & byte_mask & x"FFFFFFFFFFFFFFF";
                  when others => 
                     rqst_tuser(119 downto 40)  <= x"FFFF" & byte_mask & x"FFFFFFFFFFFFFFF";
                end case;
                else
                  case ddr4_addr(3 downto 2) is
                     when "00" =>
                        rqst_tuser(119 downto 40)  <= x"FFF" & byte_mask & x"FFFFFFFFFFFFFFFF";
                     when "01" => 
                        rqst_tuser(119 downto 40)  <= x"FF" & byte_mask & x"FFFFFFFFFFFFFFFFF";
                     when "10" =>   
                        rqst_tuser(119 downto 40)  <= x"F" & byte_mask & x"FFFFFFFFFFFFFFFFFF";
                     when "11" =>    
                        rqst_tuser(119 downto 40)  <=        byte_mask & x"FFFFFFFFFFFFFFFFFFF";
                     when others => 
                        rqst_tuser(119 downto 40)  <=        byte_mask & x"FFFFFFFFFFFFFFFFFFF";
                   end case;           
                end if;                                                                                                                                                                                                                                                                  
                rqst_tuser(39 downto 0)    <= "0000" & '0' & ddr4_addr(34 downto 6) & "000000";
                rqst_tuser(255 downto 128) <= w_data & w_data & w_data & w_data; 
                rqst_tdata                 <= w_data & w_data & w_data & w_data & w_data & w_data & w_data & w_data & w_data & w_data & w_data & w_data & w_data & w_data & w_data & w_data;
                state                      <= WAIT_WR_RDY_STATE;           
                ddr4_addr(31 downto 0)     <= ddr4_addr(31 downto 0) + 4;    
                timeout_cntr               <= x"FFFFF";
            when WAIT_WR_RDY_STATE =>
                if (rqst_tready = '1') then
                   rqst_tvalid  <= '0';
                   state        <= WR_B_RSP_STATE;
    
                   s_axi_bresp  <= "00"; 
                   s_axi_bvalid <= '1';
                elsif (timeout_cntr = x"00000") then   
                   state        <= WR_B_RSP_STATE;
                   s_axi_bresp  <= "10";
                   s_axi_bvalid <= '1';
                   irq          <= int_enable;
                else
                   state        <=  WAIT_WR_RDY_STATE;
                   timeout_cntr <= timeout_cntr -1;
                end if;
            when  WR_B_RSP_STATE =>
                if s_axi_bready = '1' then
                    s_axi_bvalid <= '0';
                    state       <= RESET_STATE;
                else
                    state       <= WR_B_RSP_STATE;
                end if;    
                irq       <= '0';
            when  RD_ADDR_STATE =>
               s_axi_arready    <= '1';
               case s_axi_araddr(3 downto 2) is
                   when "00" => -- DDR4 Address[31:0]
                        rd_data(31 downto 0) <= ddr4_addr(31 downto 0);
                        state                <= WAIT_RD_BS_STATE;
                        rerror               <= '0';                      
                   when "01" => -- DDR4 Address[34:32] and Memory Area and Byte Enables
                       rd_data(2 downto 0)   <= ddr4_addr(34 downto 32);
                       rd_data(3)            <= mem_area;
                       rd_data(7 downto 4)   <= byte_mask;
                       rd_data(8)            <= int_enable;
                       rd_data(31 downto 9)  <= (others => '0');
                       state                 <= WAIT_RD_BS_STATE;
                       rerror                <= '0'; 
                   when "10" | "11" => -- DDR4 Data Access
                      state <= RD_RQST_STATE;
                   when others =>  
                      state <= RD_RQST_STATE;
               end case;      
               mux_addr             <= "00000"; 
            when RD_RQST_STATE =>
                s_axi_arready <= '0';
                mux_addr      <= mem_area & ddr4_addr(5 downto 2);
                rqst_tvalid   <= '1';            
                -- tuser[143:0] = Request Header
                -- tuser[31:0]  = Address (Address must be aligned to the request size boundaries)
                -- tuser[34:32] = Future Address Expansion
                -- tuser[35]    = Read = 1, Write = 0
                -- tuser[119:40]= Byte Enables  
                if mem_area = '0' then
                   case ddr4_addr(5 downto 2) is
                     when x"0" => 
                        rqst_tuser(119 downto 40)  <= x"FFFFFFFFFFFFFFFFFFF" & byte_mask;
                     when x"1" => 
                        rqst_tuser(119 downto 40)  <= x"FFFFFFFFFFFFFFFFFF" & byte_mask & x"F";
                     when x"2" => 
                        rqst_tuser(119 downto 40)  <= x"FFFFFFFFFFFFFFFFF" & byte_mask & x"FF";
                     when x"3" => 
                        rqst_tuser(119 downto 40)  <= x"FFFFFFFFFFFFFFFF" & byte_mask & x"FFF";
                     when x"4" => 
                        rqst_tuser(119 downto 40)  <= x"FFFFFFFFFFFFFFF" & byte_mask & x"FFFF";
                     when x"5" => 
                        rqst_tuser(119 downto 40)  <= x"FFFFFFFFFFFFFF" & byte_mask & x"FFFFF";
                     when x"6" => 
                        rqst_tuser(119 downto 40)  <= x"FFFFFFFFFFFFF" & byte_mask & x"FFFFFF";
                     when x"7" => 
                        rqst_tuser(119 downto 40)  <= x"FFFFFFFFFFFF" & byte_mask & x"FFFFFFF";
                     when x"8" => 
                        rqst_tuser(119 downto 40)  <= x"FFFFFFFFFFF" & byte_mask & x"FFFFFFFF";
                     when x"9" => 
                        rqst_tuser(119 downto 40)  <= x"FFFFFFFFFF" & byte_mask & x"FFFFFFFFF";
                     when x"A" => 
                        rqst_tuser(119 downto 40)  <= x"FFFFFFFFF" & byte_mask & x"FFFFFFFFFF";
                     when x"B" => 
                        rqst_tuser(119 downto 40)  <= x"FFFFFFFF" & byte_mask & x"FFFFFFFFFFF";
                     when x"C" => 
                        rqst_tuser(119 downto 40)  <= x"FFFFFFF" & byte_mask & x"FFFFFFFFFFFF";
                     when x"D" => 
                        rqst_tuser(119 downto 40)  <= x"FFFFFF" & byte_mask & x"FFFFFFFFFFFFF";
                     when x"E" => 
                        rqst_tuser(119 downto 40)  <= x"FFFFF" & byte_mask & x"FFFFFFFFFFFFFF";
                     when x"F" => 
                        rqst_tuser(119 downto 40)  <= x"FFFF" & byte_mask & x"FFFFFFFFFFFFFFF";
                     when others => 
                        rqst_tuser(119 downto 40)  <= x"FFFF" & byte_mask & x"FFFFFFFFFFFFFFF";
                   end case;
                else -- upper 128 bits
                   case ddr4_addr(3 downto 2) is
                      when "00" =>
                         rqst_tuser(119 downto 40)  <= x"FFF" & byte_mask & x"FFFFFFFFFFFFFFFF";
                      when "01" => 
                         rqst_tuser(119 downto 40)  <= x"FF" & byte_mask & x"FFFFFFFFFFFFFFFFF";
                      when "10" =>   
                         rqst_tuser(119 downto 40)  <= x"F" & byte_mask & x"FFFFFFFFFFFFFFFFFF";
                      when "11" =>    
                         rqst_tuser(119 downto 40)  <=        byte_mask & x"FFFFFFFFFFFFFFFFFFF";
                      when others => 
                         rqst_tuser(119 downto 40)  <=        byte_mask & x"FFFFFFFFFFFFFFFFFFF";
                    end case;           
                end if;                                                                                                                                                                                                                                                                  
                rqst_tuser(39 downto 0)    <= "0000" & '1' & ddr4_addr(34 downto 6) & "000000";
                rqst_tuser(255 downto 128) <= (others => '0'); 
                rqst_tdata                 <= (others => '0');
                ddr4_addr(31 downto 0)     <= ddr4_addr(31 downto 0) + 4;
                state                      <=  WAIT_RD_RDY_STATE;        
            when WAIT_RD_RDY_STATE =>
                if (rqst_tready = '1') then
                  rqst_tvalid  <= '0';
                  state        <=  WAIT_RD_RSP_STATE;   
                  timeout_cntr <= x"FFFFF";          
                else
                  state        <=  WAIT_RD_RDY_STATE;
                end if;
            when WAIT_RD_RSP_STATE =>  
               if (rsp_tvalid = '1') and (rsp_tid = id) then
                  rd_data      <= rsp_tdata;
                  state        <= WAIT_RD_BS_STATE;   
                  rerror       <= '0';
               elsif (timeout_cntr = x"00000") then -- Timeout
                  rd_data      <= x"DEADBEEFDEADBEEFDEADBEEFDEADBEEFDEADBEEFDEADBEEFDEADBEEFDEADBEEFDEADBEEFDEADBEEFDEADBEEFDEADBEEFDEADBEEFDEADBEEFDEADBEEFDEADBEEFDEADBEEFDEADBEEFDEADBEEFDEADBEEF"; 
                  state        <=  WAIT_RD_BS_STATE;
                  rerror       <= '1'; 
               else
                  state        <=  WAIT_RD_RSP_STATE;
                  timeout_cntr <=  timeout_cntr -1;
               end if;
            when WAIT_RD_BS_STATE =>
                s_axi_arready <= '0';
                if mux_addr(4) = '0' then
                   case mux_addr(3 downto 0) is
                      when x"0" => 
                        bs_data       <= rd_data(31 downto 0);
                      when x"1" => 
                        bs_data       <= rd_data(63 downto 32);                        
                      when x"2" => 
                        bs_data       <= rd_data(95 downto 64); 
                      when x"3" => 
                        bs_data       <= rd_data(127 downto 96); 
                      when x"4" => 
                        bs_data       <= rd_data(159 downto 128);
                      when x"5" => 
                        bs_data       <= rd_data(191 downto 160);
                      when x"6" => 
                        bs_data       <= rd_data(223 downto 192); 
                      when x"7" => 
                        bs_data       <= rd_data(255 downto 224); 
                      when x"8" => 
                        bs_data       <= rd_data(287 downto 256);
                      when x"9" => 
                        bs_data       <= rd_data(319 downto 288);
                      when x"A" => 
                        bs_data       <= rd_data(351 downto 320);
                      when x"B" => 
                        bs_data       <= rd_data(383 downto 352);
                      when x"C" => 
                        bs_data       <= rd_data(415 downto 384);
                      when x"D" => 
                        bs_data       <= rd_data(447 downto 416);
                      when x"E" => 
                        bs_data       <= rd_data(479 downto 448);
                      when x"F" => 
                        bs_data       <= rd_data(511 downto 480);
                      when others =>
                        bs_data       <= rd_data(511 downto 480);      
                   end case;
                else
                   case mux_addr(1 downto 0) is
                      when "00" => 
                         bs_data      <= rd_data(543 downto 512);
                      when "01" => 
                         bs_data      <= rd_data(575 downto 544);                      
                      when "10" => 
                         bs_data      <= rd_data(607 downto 576); 
                      when "11" => 
                         bs_data      <= rd_data(639 downto 608);
                      when others => 
                         bs_data      <= rd_data(639 downto 608);
                    end case;                               
                end if;                                                                                                                                                                                                                                                                                                         
                state         <=  WAIT_RD_CMPLT_STATE;
            when WAIT_RD_CMPLT_STATE =>
                s_axi_rdata   <= bs_data;
                s_axi_rvalid  <= '1'; 
                s_axi_rresp   <= rerror & '0';
                state         <= WAIT_RDDATA_RDY_STATE;  
                irq           <= rerror and int_enable;                 
            when WAIT_RDDATA_RDY_STATE =>   
                if s_axi_rready = '1' then
                   s_axi_rvalid <= '0';
                   state        <= RESET_STATE;
                else
                   state        <= WAIT_RDDATA_RDY_STATE;     
                end if;  
                irq             <= '0';
            when others =>
               state          <= RESET_STATE;
          end case;
       end if;
   end if;  
end process;

rqst_tuser(127 downto 120) <= x"00";

--------------------------------------------------------------------------------
-- Output Request 
--------------------------------------------------------------------------------
 
rqst_rslice_inst : px_axil2ddr_rqst_rslice
 port map (
    aclk             => s_axi_aclk,
    aresetn          => t1_s_axi_aresetn,
    s_axis_tvalid    => rqst_tvalid,
    s_axis_tready    => rqst_tready,
    s_axis_tdata     => rqst_tdata,
    s_axis_tuser     => rqst_tuser,
    m_axis_tvalid    => m_axis_rqst_tvalid,
    m_axis_tready    => m_axis_rqst_tready,
    m_axis_tdata     => m_axis_rqst_tdata,
    m_axis_tuser     => m_axis_rqst_tuser
   ); 

--------------------------------------------------------------------------------
-- Input Response 
--------------------------------------------------------------------------------
rsptdata <= s_axis_rsp_tuser(255 downto 128) &  s_axis_rsp_tdata;

rsp_rslice_inst : px_axil2ddr_rsp_rslice
port map (
   aclk             => s_axi_aclk,
   aresetn          => t1_s_axi_aresetn,
   s_axis_tvalid    => s_axis_rsp_tvalid,
   s_axis_tdata     => rsptdata,
   s_axis_tid       => s_axis_rsp_tid,
   m_axis_tvalid    => rsp_tvalid,
   m_axis_tdata     => rsp_tdata,
   m_axis_tid       => rsp_tid
  );



end Behavioral;
