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
  tdata_width : integer := 32
);
port (
  ACLK                : in  std_logic;
  ARESETN             : in  std_logic;
  GATE                : in  std_logic;
  MOD_VAL             : in  std_logic_vector(31 downto 0) := (others=>'0');
  DO_SYNC             : in  std_logic;      
  S_AXIS_PDTI_TDATA   : in  std_logic_vector(tdata_width-1 downto 0);
  S_AXIS_PDTI_TUSER   : in  std_logic_vector(127 downto 0);
  S_AXIS_PDTI_TVALID  : in  std_logic;
  M_AXIS_PDTI_TDATA   : out std_logic_vector(tdata_width-1 downto 0);
  M_AXIS_PDTI_TUSER   : out std_logic_vector(127 downto 0);
  M_AXIS_PDTI_TVALID  : out std_logic    
);
end entity;

architecture pdti_dac_pulse of pdti_dac_pulse is
     signal gate_reg : std_logic := '0';
begin

OUTPUT : process(ACLK)
begin
    if rising_edge(ACLK) then
   
        if GATE = '1' then
            M_AXIS_PDTI_TDATA   <= MOD_VAL;
        else
            M_AXIS_PDTI_TDATA   <= (others=>'0');
        end if;

        M_AXIS_PDTI_TVALID      <= S_AXIS_PDTI_TVALID;        
        M_AXIS_PDTI_TUSER       <= S_AXIS_PDTI_TUSER;

        gate_reg                <= GATE;
        
        if DO_SYNC = '1' then
            M_AXIS_PDTI_TUSER(72) <= gate and not gate_reg;
        end if;
        
    end if;
end process;

end architecture;
