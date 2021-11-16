--
-- pdti_adc_tweak.vhd
--    Author: Adam Karboski <karboski@ucar.edu>
--
-- Copyright (c) 2021 University Corporation for Atmospheric Research
-- All rights reserved.

-- This block overrides PDTI gate and sync with MT_PULSE 

library ieee;
use ieee.std_logic_1164.all;

entity pdti_adc_tweak is
  generic (
    tdata_width : integer := 16;
    mt_pulse_bit : integer := 1
  );
  port (
    ACLK                : in  std_logic;
    ARESETN             : in  std_logic;
    MT_PULSE            : in  std_logic_vector(7 downto 0);
    FILTER_SELECT       : in  std_logic_vector(2 downto 0);
    S_AXIS_PDTI_TDATA   : in  std_logic_vector(tdata_width-1 downto 0);
    S_AXIS_PDTI_TUSER   : in  std_logic_vector(127 downto 0);
    S_AXIS_PDTI_TVALID  : in  std_logic;
    GATE                : out std_logic;
    SYNC                : out std_logic;
    PPS                 : out std_logic;
    M_AXIS_PDTI_TDATA   : out std_logic_vector(tdata_width-1 downto 0);
    M_AXIS_PDTI_TUSER   : out std_logic_vector(127 downto 0);
    M_AXIS_PDTI_TVALID  : out std_logic    
  );
end entity;

architecture pdti_adc_tweak of pdti_adc_tweak is
    signal GATE_i   : std_logic := '0';
    signal GATE_reg : std_logic := '0';
begin

    GATE_i <= MT_PULSE(mt_pulse_bit);

    OUTPUT : process(ACLK)
    begin
        if rising_edge(ACLK) then
        
            --Extract the input signals for use elsewhere
            GATE                    <= S_AXIS_PDTI_TUSER(64);
            SYNC                    <= S_AXIS_PDTI_TUSER(72);
            PPS                     <= S_AXIS_PDTI_TUSER(80);

            M_AXIS_PDTI_TDATA       <= S_AXIS_PDTI_TDATA;
            M_AXIS_PDTI_TVALID      <= S_AXIS_PDTI_TVALID;

            --Override gate and sync
            GATE_reg                <= GATE_i;
            M_AXIS_PDTI_TUSER       <= S_AXIS_PDTI_TUSER;
            M_AXIS_PDTI_TUSER(64)   <= GATE_i;
            M_AXIS_PDTI_TUSER(72)   <= GATE_i and not GATE_reg; --Sync
            M_AXIS_PDTI_TUSER(31 downto 29) <= FILTER_SELECT;
            
        end if;
    end process;

end architecture;
