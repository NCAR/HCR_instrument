----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/17/2016 01:43:26 PM
-- Design Name: 
-- Module Name: px_axis_pdti2ppkt_bs - Behavioral
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

entity px_axis_pdti2ppkt_bs is
port (
  aclk               : in  std_logic;
  aresetn            : in  std_logic;
  
  s_axis_pdti_tdata  : in  std_logic_vector(255 downto 0);  
  s_axis_pdti_tuser  : in  std_logic_vector(127 downto 0);
  s_axis_pdti_tvalid : in  std_logic;
  
  m_axis_pdti_tdata  : out std_logic_vector(255 downto 0);  
  m_axis_pdti_tuser  : out std_logic_vector(127 downto 0);
  m_axis_pdti_tvalid : out std_logic
);
end px_axis_pdti2ppkt_bs;

architecture Behavioral of px_axis_pdti2ppkt_bs is

signal t1_tvalid  :  std_logic := '0'; 
signal t1_in_tdata:  std_logic_vector(255 downto 0) := (others => '0'); 
signal t1_in_tuser:  std_logic_vector(127 downto 0) := (others => '0'); 
signal t2_tvalid  :  std_logic := '0'; 
signal t2_in_tdata:  std_logic_vector(255 downto 0) := (others => '0'); 
signal t2_in_tuser:  std_logic_vector(127 downto 0) := (others => '0'); 
signal t3_in_tdata:  std_logic_vector(255 downto 0) := (others => '0'); 
signal t3_in_tuser:  std_logic_vector(127 downto 0) := (others => '0'); 
signal t4_in_tuser:  std_logic_vector(127 downto 0) := (others => '0'); 
signal t3_bshift  :  std_logic_vector(1 downto 0) := (others => '0'); 
signal  gate_on   :  std_logic := '0';
signal t2_gate    :  std_logic_vector(3 downto 0) := (others => '0');
signal t1_aresetn :  std_logic := '0';
signal t4_mux_tdata:  std_logic_vector(255 downto 0) := (others => '0'); 
signal t4_mux_tuser:  std_logic_vector(127 downto 0) := (others => '0');
 
begin

t2_gate <= t2_in_tuser(70) & t2_in_tuser(68) & t2_in_tuser(66) & t2_in_tuser(64);

process(aclk)
begin
    if rising_edge(aclk) then
        t1_aresetn  <= aresetn;
        t1_tvalid   <= s_axis_pdti_tvalid;
        t2_tvalid   <= t1_tvalid; 
        t1_in_tdata <= s_axis_pdti_tdata;
        t1_in_tuser <= s_axis_pdti_tuser;
        if t1_tvalid = '1' then
            t2_in_tdata <= t1_in_tdata;  
            t2_in_tuser <= t1_in_tuser;
            t3_in_tdata <= t2_in_tdata;  
            t3_in_tuser <= t2_in_tuser;
            t4_in_tuser <= t3_in_tuser;
        end if;     
        if t1_aresetn = '0' then
          gate_on <= '0';
          t3_bshift <= "00";
        elsif t1_tvalid = '1' then
            if gate_on = '0' then
                case t2_gate is
                    when "0000" => 
                        t3_bshift <= "00";
                    when "0001" | "0011" | "0111" | "1111" | "1011" | "1001" | "1101" | "0101" =>
                        t3_bshift <= "00";
                        gate_on <= '1';
                    when "0010" | "0110" | "1110" | "1010" =>
                        t3_bshift <= "01";
                        gate_on <= '1';
                    when "0100" | "1100" =>
                        t3_bshift <= "10";
                        gate_on <= '1';
                    when "1000" =>    
                        t3_bshift <= "11";
                        gate_on <= '1';   
                    when others =>
                        t3_bshift <= "00";
                end case; 
            elsif (t2_gate /= "1111") then  
                gate_on <= '0';            
            end if;
        end if;                
    end if;                          
end process;

process(aclk)
begin
    if rising_edge(aclk) then
        if t1_tvalid = '1' then
            case t3_bshift is
                when "00" =>
                    t4_mux_tdata <= t3_in_tdata;
                    t4_mux_tuser(71 downto 64) <= t3_in_tuser(71 downto 64);
                    t4_mux_tuser(79 downto 72) <= t3_in_tuser(79 downto 72);
                    t4_mux_tuser(87 downto 80) <= t3_in_tuser(87 downto 80);
                when "01" => 
                    t4_mux_tdata <= t2_in_tdata(63 downto 0) & t3_in_tdata(255 downto 64);
                    t4_mux_tuser(71 downto 64) <= t2_in_tuser(65 downto 64) & t3_in_tuser(71 downto 66);
                    t4_mux_tuser(79 downto 72) <= t2_in_tuser(73 downto 72) & t3_in_tuser(79 downto 74);
                    t4_mux_tuser(87 downto 80) <= t2_in_tuser(81 downto 80) & t3_in_tuser(87 downto 82);
                when "10" => 
                    t4_mux_tdata <= t2_in_tdata(127 downto 0) & t3_in_tdata(255 downto 128);
                    t4_mux_tuser(71 downto 64) <= t2_in_tuser(67 downto 64) & t3_in_tuser(71 downto 68);
                    t4_mux_tuser(79 downto 72) <= t2_in_tuser(75 downto 72) & t3_in_tuser(79 downto 76);
                    t4_mux_tuser(87 downto 80) <= t2_in_tuser(83 downto 80) & t3_in_tuser(87 downto 84);
                when "11" => 
                    t4_mux_tdata <= t2_in_tdata(191 downto 0) & t3_in_tdata(255 downto 192);
                    t4_mux_tuser(71 downto 64) <= t2_in_tuser(69 downto 64) & t3_in_tuser(71 downto 70);
                    t4_mux_tuser(79 downto 72) <= t2_in_tuser(77 downto 72) & t3_in_tuser(79 downto 78);
                    t4_mux_tuser(87 downto 80) <= t2_in_tuser(85 downto 80) & t3_in_tuser(87 downto 86);
                when others =>
                    t4_mux_tdata <= t2_in_tdata(191 downto 0) & t3_in_tdata(255 downto 192);
                    t4_mux_tuser(71 downto 64) <= t2_in_tuser(69 downto 64) & t3_in_tuser(71 downto 70);
                    t4_mux_tuser(79 downto 72) <= t2_in_tuser(77 downto 72) & t3_in_tuser(79 downto 78);
                    t4_mux_tuser(87 downto 80) <= t2_in_tuser(85 downto 80) & t3_in_tuser(87 downto 86);
            end case;
        end if;
   end if;         
end process;

t4_mux_tuser(63 downto 0)   <= t4_in_tuser(63 downto 0);
t4_mux_tuser(127 downto 88) <= t4_in_tuser(127 downto 88);

process(aclk)
begin
    if rising_edge(aclk) then
        m_axis_pdti_tdata  <= t4_mux_tdata;
        m_axis_pdti_tuser  <= t4_mux_tuser;
        m_axis_pdti_tvalid <= t2_tvalid;
    end if;
end process;    

end Behavioral;
