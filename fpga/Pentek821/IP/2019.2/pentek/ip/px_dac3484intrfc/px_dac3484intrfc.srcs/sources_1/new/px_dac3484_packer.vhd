----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/09/2019 02:11:44 PM
-- Design Name: 
-- Module Name: px_dac3484_packer - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity px_dac3484_packer is
Port (

-- Dac Packer Interface
    s_dac_axis_aclk  : in std_logic;
    s_dac0_axis_tvalid : in std_logic;
    s_dac0_axis_tdata  : in std_logic_vector(31 downto 0);
    s_dac0_axis_tuser  : in std_logic_vector(127 downto 0);
    
    s_dac1_axis_tvalid : in std_logic;
    s_dac1_axis_tdata  : in std_logic_vector(31 downto 0);
    s_dac1_axis_tuser  : in std_logic_vector(127 downto 0);
    
    dac_mode         : in std_logic_vector(2 downto 0);
    
    dac_data_out     : out std_logic_vector(63 downto 0);
    dac_sync_out     : out std_logic
    
);
end px_dac3484_packer;

architecture Behavioral of px_dac3484_packer is

signal dac_data_packed_out_ab    :std_logic_vector(63 downto 0);
signal dac_data_packed_out_a     :std_logic_vector(31 downto 0);
signal dac_data_packed_out_b     :std_logic_vector(31 downto 0);
signal dac_mode_sel              :std_logic_vector(3 downto 0);

signal s_dac0_axis_tvalid_reg1   :std_logic;
signal s_dac0_axis_tvalid_reg2   :std_logic;
signal s_dac0_axis_tdata_reg     :std_logic_vector(31 downto 0);
signal s_dac0_gate               :std_logic;
signal s_dac0_gate_dly           :std_logic;
signal s_dac1_axis_tvalid_reg1   :std_logic;
signal s_dac1_axis_tvalid_reg2   :std_logic;
signal s_dac1_axis_tdata_reg     :std_logic_vector(31 downto 0);
signal s_dac1_gate               :std_logic;
signal s_dac1_gate_dly           :std_logic;

begin
 
process(s_dac_axis_aclk) 
begin

    if(rising_edge(s_dac_axis_aclk)) then
        
        s_dac0_axis_tvalid_reg1    <= s_dac0_axis_tvalid;
        s_dac0_axis_tvalid_reg2    <= s_dac0_axis_tvalid_reg1;
        s_dac0_axis_tdata_reg      <= s_dac0_axis_tdata;
        s_dac0_gate                <= s_dac0_axis_tuser(64);
        s_dac0_gate_dly            <= s_dac0_gate;
        
        s_dac1_axis_tvalid_reg1    <= s_dac1_axis_tvalid;
        s_dac1_axis_tvalid_reg2    <= s_dac1_axis_tvalid_reg1;
        s_dac1_axis_tdata_reg      <= s_dac1_axis_tdata;
        s_dac1_gate                <= s_dac1_axis_tuser(64);
        s_dac1_gate_dly            <= s_dac1_gate;

        case dac_mode is
            -- Real Mode
            when "000" =>
                if(s_dac0_gate = '1' and s_dac0_axis_tvalid_reg1 = '1') then 
                    dac_data_out(15 downto 0)  <= s_dac0_axis_tdata_reg(15 downto 0);
                    dac_data_out(31 downto 16) <= (others => '0'); --s_dac0_axis_tdata_reg(15 downto 0); 
                
                elsif(s_dac0_gate_dly = '1' and s_dac0_axis_tvalid_reg2 = '1') then
                    dac_data_out(15 downto 0)  <= s_dac0_axis_tdata_reg(31 downto 16);
                    dac_data_out(31 downto 16) <= (others => '0'); --s_dac0_axis_tdata_reg(31 downto 16);
                else
                    dac_data_out(31 downto 0) <= (others => '0');    
                end if;
                
                if(s_dac1_gate = '1' and s_dac1_axis_tvalid_reg1 = '1') then 
                    dac_data_out(47 downto 32) <= s_dac1_axis_tdata_reg(15 downto 0);
                    dac_data_out(63 downto 48) <= (others => '0'); --s_dac1_axis_tdata_reg(15 downto 0); 
                elsif(s_dac1_gate_dly = '1' and s_dac1_axis_tvalid_reg2 = '1') then    
                    dac_data_out(47 downto 32) <= s_dac1_axis_tdata_reg(31 downto 16);
                    dac_data_out(63 downto 48) <= (others => '0'); --s_dac1_axis_tdata_reg(31 downto 16);
                else
                    dac_data_out(63 downto 32) <= (others => '0');    
                end if;
                
                -- When either channel is driving data, the DAC3484 SYNC needs to be aserted
                dac_sync_out               <= s_dac1_gate or s_dac1_gate_dly or s_dac0_gate or s_dac0_gate_dly;
             
            -- I/Q Mode
            when "001" =>
                if(s_dac0_gate = '1' and s_dac0_axis_tvalid_reg1 = '1') then
                    dac_data_out(15 downto 0)  <= s_dac0_axis_tdata_reg(15 downto 0);
                    dac_data_out(31 downto 16) <= s_dac0_axis_tdata_reg(31 downto 16); 
                
                else
                    dac_data_out(31 downto 0) <= (others => '0');
                end if;
                
                if(s_dac1_gate = '1' and s_dac1_axis_tvalid_reg1 = '1') then
                    dac_data_out(47 downto 32) <= s_dac1_axis_tdata_reg(15 downto 0);
                    dac_data_out(63 downto 48) <= s_dac1_axis_tdata_reg(31 downto 16); 
                
                else
                    dac_data_out(63 downto 32) <= (others => '0');
                end if;
                
                dac_sync_out               <= s_dac1_gate or s_dac0_gate;
            
            when others =>
                dac_data_out <= (others => '0');
                dac_sync_out <= '0';
                
            
        end case;
    end if;
end process;


end Behavioral;
