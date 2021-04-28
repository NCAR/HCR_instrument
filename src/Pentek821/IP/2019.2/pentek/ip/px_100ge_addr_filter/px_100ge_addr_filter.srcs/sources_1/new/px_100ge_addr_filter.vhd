----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/24/2019 11:31:16 AM
-- Design Name: 
-- Module Name: px_100ge_addr_filter - Behavioral
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


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity px_100ge_addr_filter is
port (
    ----------------------------------------------------------------------------------
    -- IP and MAC address Inputs
    ----------------------------------------------------------------------------------
    ip_address   : in std_logic_vector(31 downto 0);
    mac_address  : in std_logic_vector(47 downto 0);
    ---------------------------------------------------------------------------------
    -- 100GE Core AXI-S RX bus
    ---------------------------------------------------------------------------------
    s_axis_aresetn        : in  std_logic;
    s_axis_aclk           : in  std_logic;
    s_axis_tvalid         : in  std_logic;
    s_axis_tdata          : in  std_logic_vector(511 downto 0); 
    s_axis_tuser          : in  std_logic_vector(0 downto 0);
    s_axis_tkeep          : in  std_logic_vector(63 downto 0);
    s_axis_tlast          : in  std_logic; -- end of packet
    ----------------------------------------------------------------------------------
    -- AXI-Stream Master  (pass-through from s_axis)
    ----------------------------------------------------------------------------------
    m_axis_tvalid         : out std_logic;
    m_axis_tdata          : out std_logic_vector(511 downto 0); 
    m_axis_tuser          : out std_logic_vector(0 downto 0);
    m_axis_tkeep          : out std_logic_vector(63 downto 0);
    m_axis_tlast          : out std_logic -- end of packet
);
end px_100ge_addr_filter;

architecture Behavioral of px_100ge_addr_filter is

ATTRIBUTE X_INTERFACE_INFO : STRING;
ATTRIBUTE X_INTERFACE_PARAMETER : STRING;


ATTRIBUTE X_INTERFACE_INFO of s_axis_aresetn: SIGNAL is "xilinx.com:signal:reset:1.0 s_axis_aresetn RST";
ATTRIBUTE X_INTERFACE_PARAMETER of s_axis_aresetn: SIGNAL is "POLARITY ACTIVE_LOW";

ATTRIBUTE X_INTERFACE_INFO of s_axis_aclk: SIGNAL is "xilinx.com:signal:clock:1.0 s_axis_aclk CLK";
ATTRIBUTE X_INTERFACE_PARAMETER of s_axis_aclk: SIGNAL is "ASSOCIATED_BUSIF s_axis:m_axis, ASSOCIATED_RESET s_axis_aresetn";

-------------------------------------------------------------------------------------
-- Types
-------------------------------------------------------------------------------------

type sm_state_type is
(
HEADER_STATE,
WAIT_TLAST_STATE
);

-------------------------------------------------------------------------------------
-- Signals
-------------------------------------------------------------------------------------

signal sm_state : sm_state_type := HEADER_STATE;
signal t1_s_axis_aresetn: std_logic := '0';
signal t2_s_axis_aresetn: std_logic := '0';
signal t3_s_axis_aresetn: std_logic := '0';
signal t4_s_axis_aresetn: std_logic := '0';
signal t5_s_axis_aresetn: std_logic := '0';
signal t6_s_axis_aresetn: std_logic := '0';
signal t7_s_axis_aresetn: std_logic := '0';
signal t8_s_axis_aresetn: std_logic := '0';
signal our_ip_addr_rvrs: std_logic_vector(31 downto 0) := (others => '0');
signal our_mac_addr_rvrs : std_logic_vector(47 downto 0) := (others => '0');

--------------------------------------------------------------------------------
-- Constants
--------------------------------------------------------------------------------
constant broadcast_ip_addr : std_logic_vector(31 downto 0) := x"FFFFFFFF";
constant broadcast_mac_addr: std_logic_vector(47 downto 0) := x"FFFFFFFFFFFF";

begin


process(s_axis_aclk)
begin
 if rising_edge(s_axis_aclk) then
    t1_s_axis_aresetn <= s_axis_aresetn;
    t2_s_axis_aresetn <= t1_s_axis_aresetn;
    t3_s_axis_aresetn <= t2_s_axis_aresetn;
    t4_s_axis_aresetn <= t3_s_axis_aresetn;
    t5_s_axis_aresetn <= t4_s_axis_aresetn;
    t6_s_axis_aresetn <= t5_s_axis_aresetn;
    t7_s_axis_aresetn <= t6_s_axis_aresetn;
    t8_s_axis_aresetn <= t7_s_axis_aresetn;
    m_axis_tdata         <= s_axis_tdata;
    m_axis_tuser         <= s_axis_tuser;
    m_axis_tkeep         <= s_axis_tkeep; 
    m_axis_tlast         <= s_axis_tlast; 
    if (t1_s_axis_aresetn = '0') or  (t2_s_axis_aresetn = '0') or  (t3_s_axis_aresetn = '0') or  (t4_s_axis_aresetn = '0') or  (t5_s_axis_aresetn = '0') or  (t6_s_axis_aresetn = '0') or  (t7_s_axis_aresetn = '0') or (t8_s_axis_aresetn = '0') then
        sm_state      <= HEADER_STATE;
        m_axis_tvalid    <= '0';
    else
        case sm_state is
            when HEADER_STATE =>
                if  (s_axis_tvalid = '1')  then  
                    -- Test if our IP Address and MAC address is in header as destination or broadcast address
                    if  ((s_axis_tdata(47 downto 0) = our_mac_addr_rvrs) and (s_axis_tdata(271 downto 240) = our_ip_addr_rvrs)) or (s_axis_tdata(47 downto 0) = broadcast_mac_addr) or (s_axis_tdata(271 downto 240) = broadcast_ip_addr) then 
                       m_axis_tvalid   <= '1'; 
                       if  (s_axis_tlast = '0') then
                            sm_state <= WAIT_TLAST_STATE; 
                       end if;
                    else
                       m_axis_tvalid   <= '0'; 
                       if  (s_axis_tlast = '0') then
                            sm_state <= WAIT_TLAST_STATE; 
                       end if;
                    end if;
                else
                    m_axis_tvalid <= '0';
                end if;    
            when WAIT_TLAST_STATE => -- Wait for end of packet
                m_axis_tvalid   <= s_axis_tvalid;
                if  (s_axis_tvalid = '1') and (s_axis_tlast = '1') then
                    sm_state    <= HEADER_STATE;
                end if;
            when others =>
                sm_state <= HEADER_STATE;
        end case;
    end if;
 end if;
end process;

process(s_axis_aclk)
begin
 if rising_edge(s_axis_aclk) then
    our_ip_addr_rvrs <= ip_address(7 downto 0) & ip_address(15 downto 8) & ip_address(23 downto 16) & ip_address(31 downto 24);
    our_mac_addr_rvrs <= mac_address(7 downto 0) & mac_address(15 downto 8) & mac_address(23 downto 16) & mac_address(31 downto 24) & mac_address(39 downto 32) & mac_address(47 downto 40);
 end if;
 end process;


end Behavioral;
