--
-- pdti_dac_pulse.vhd
--    Author: Adam Karboski <karboski@ucar.edu>
--
-- Copyright (c) 2021 University Corporation for Atmospheric Research
-- All rights reserved.

library ieee;
use ieee.std_logic_1164.all;

entity pdti_dac_pulse is
  generic (
    tdata_width         : integer := 32
  );
  port (
    ACLK                : in  std_logic;
    ARESETN             : in  std_logic;
    GATE                : in  std_logic;
    MOD_VAL             : std_logic_vector(tdata_width-1 downto 0) := (others=>'0');
    FORMAT              : std_logic_vector(2 downto 0) := (others=>'0');
    M_AXIS_PDTI_TDATA   : out std_logic_vector(tdata_width-1 downto 0);
    M_AXIS_PDTI_TUSER   : out std_logic_vector(127 downto 0);
    M_AXIS_PDTI_TVALID  : out std_logic    
  );
end entity;

architecture pdti_dac_pulse of pdti_dac_pulse is
    signal GATE_reg  : std_logic := '0';
    signal GATE_reg2 : std_logic := '0';
begin

    

    OUTPUT : process(ACLK)
    begin
        if rising_edge(ACLK) then
        
            GATE_reg                <= GATE;
            GATE_reg2               <= GATE_reg;
            
            if GATE_reg = '1' then
                M_AXIS_PDTI_TDATA   <= MOD_VAL;
            else
                M_AXIS_PDTI_TDATA   <= (others=>'0');
            end if;
            M_AXIS_PDTI_TVALID      <= '1';
            
            M_AXIS_PDTI_TUSER       <= (88=>'1', others=>'0'); --1 sample/cycle
            M_AXIS_PDTI_TUSER(95 downto 93) <= FORMAT(2 downto 0);
            M_AXIS_PDTI_TUSER(64)   <= GATE_reg;
            M_AXIS_PDTI_TUSER(72)   <= GATE_reg and not GATE_reg2; --Sync
            
        end if;
    end process;

end architecture;
