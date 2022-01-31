--
-- pdti_fir_tweak.vhd
--    Author: Adam Karboski <karboski@ucar.edu>
--
-- Copyright (c) 2021 University Corporation for Atmospheric Research
-- All rights reserved.

-- This block reformats a "24IQ" Pentek AXI stream so that the Xilinx FIR can use it

library ieee;
use ieee.std_logic_1164.all;

entity pdti_fir_tweak is
  port (
    ACLK                : in  std_logic;
    ARESETN             : in  std_logic;
    S_AXIS_PDTI_TDATA   : in  std_logic_vector(31 downto 0);
    S_AXIS_PDTI_TUSER   : in  std_logic_vector(127 downto 0);
    S_AXIS_PDTI_TVALID  : in  std_logic;
    M_AXIS_DATA_TDATA   : out std_logic_vector(47 downto 0);
    M_AXIS_DATA_TUSER   : out std_logic_vector(127 downto 0);
    M_AXIS_DATA_TVALID  : out std_logic;
    M_AXIS_FSEL_TDATA   : out std_logic_vector(7 downto 0);
    M_AXIS_FSEL_TVALID  : out std_logic          
  );
end entity;

architecture pdti_fir_tweak of pdti_fir_tweak is
    signal data_reg : std_logic_vector(23 downto 0) := (others=>'0');
begin

    OUTPUT : process(ACLK)
    begin
        if rising_edge(ACLK) then

            M_AXIS_DATA_TDATA       <= (others=>'0');
            M_AXIS_DATA_TUSER       <= (others=>'0');
            M_AXIS_DATA_TVALID      <= '0';
            M_AXIS_FSEL_TDATA       <= (others=>'0');
            M_AXIS_FSEL_TVALID      <= '0'; 

            if S_AXIS_PDTI_TVALID = '1' then

                --Reformat the interleaved IQ to parallel
                if S_AXIS_PDTI_TUSER(92) = '0' then
                    -- Read and store the I sample
                    data_reg                            <= S_AXIS_PDTI_TDATA(31 downto 8);
                else
                    -- Combine the Q sample and the stored I sample
                    M_AXIS_DATA_TDATA                   <= data_reg & S_AXIS_PDTI_TDATA(31 downto 8);
                    -- Divert the filter select bits
                    M_AXIS_FSEL_TDATA(2 downto 0)       <= S_AXIS_PDTI_TUSER(31 downto 29);
                    M_AXIS_DATA_TUSER                   <= S_AXIS_PDTI_TUSER;
                    M_AXIS_DATA_TUSER(31 downto 29)     <= "000";
                    --Mark the data format (24 bit)
                    M_AXIS_DATA_TUSER(94 downto 92)     <= "100";
                    -- Output
                    M_AXIS_DATA_TVALID                  <= '1';
                    M_AXIS_FSEL_TVALID                  <= '1'; 
                end if;

            end if;

        end if;
    end process;

end architecture;
