--
-- position_encoder.vhd
--    Author: Adam Karboski <karboski@ucar.edu>
--
-- Copyright (c) 2021 University Corporation for Atmospheric Research
-- All rights reserved.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.std_logic_arith.all;
USE IEEE.std_logic_unsigned.all;


entity position_encoder is
	port (
        aclk    : in std_logic;
        aresetn : in std_logic;
        ctl_reg : in std_logic_vector(31 downto 0); --bit0: 0=r/t,1=az/el. bit1:r/t Zero
        ROT_A   : in std_logic;
        ROT_B   : in std_logic;
        TILT_A  : in std_logic;
        TILT_B  : in std_logic;
        AZ_MOSI : in std_logic;
        AZ_SCK  : in std_logic;
        AZ_SSEL : in std_logic;
        EL_MOSI : in std_logic;
        EL_SCK  : in std_logic;
        EL_SSEL : in std_logic;
        pos_enc_0 : out std_logic_vector(31 downto 0);  --rot or az
        pos_enc_1 : out std_logic_vector(31 downto 0)); --tilt or el
end position_encoder;

architecture position_encoder of position_encoder is

component QUAD2BIN
    Port (  RESET : in  STD_LOGIC;
			CLK : in  STD_LOGIC;
            ROT_A : in  STD_LOGIC;
            ROT_B : in  STD_LOGIC;
            ROT_Z : in  STD_LOGIC;
            TILT_A : in  STD_LOGIC;
            TILT_B : in  STD_LOGIC;
            TILT_Z : in  STD_LOGIC;
            DATA_STROBE : in STD_LOGIC;
            ROT_POS : out  STD_LOGIC_VECTOR (31 downto 0);
            TILT_POS : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component SER2BIN
    Port (  RESET : in  STD_LOGIC;
            CLK : in  STD_LOGIC;
            AZ_MOSI : in  STD_LOGIC;
            AZ_SCK : in  STD_LOGIC;
            AZ_SSEL : in  STD_LOGIC;
            EL_MOSI : in  STD_LOGIC;
            EL_SCK : in  STD_LOGIC;
            EL_SSEL : in  STD_LOGIC;
            DATA_STROBE : in STD_LOGIC;
            AZ_POS : out  STD_LOGIC_VECTOR (31 downto 0);
            EL_POS : out  STD_LOGIC_VECTOR (31 downto 0);
            HSKP1 : out  STD_LOGIC_VECTOR (31 downto 0);
            HSKP2 : out  STD_LOGIC_VECTOR (31 downto 0);
            HSKP3 : out  STD_LOGIC_VECTOR (31 downto 0);
            HSKP4 : out  STD_LOGIC_VECTOR (31 downto 0));			  
end component;

signal RESET    : std_logic;
signal rot_pos  : std_logic_vector(31 downto 0) := (others=>'0');
signal tilt_pos : std_logic_vector(31 downto 0) := (others=>'0');
signal az_pos   : std_logic_vector(31 downto 0) := (others=>'0');
signal el_pos   : std_logic_vector(31 downto 0) := (others=>'0');

begin

    RESET <= aresetn;
    
    pos_enc_0 <= rot_pos when CTL_REG(0) = '0' else az_pos;
    pos_enc_1 <= tilt_pos when CTL_REG(0) = '0' else el_pos;

	Q2B: QUAD2BIN
	PORT MAP (  RESET       => RESET,
				CLK         => aclk,
				ROT_A       => ROT_A,
				ROT_B       => ROT_B,
				ROT_Z       => CTL_REG(1),
				TILT_A      => TILT_A,
				TILT_B      => TILT_B,
				TILT_Z      => CTL_REG(1),
				DATA_STROBE => '1',
				ROT_POS     => rot_pos,
				TILT_POS    => tilt_pos
	);

	S2B: SER2BIN
	PORT MAP (  RESET       => RESET,
				CLK         => aclk,
				AZ_MOSI     => AZ_MOSI,
				AZ_SCK      => AZ_SCK,
				AZ_SSEL     => AZ_SSEL,
				EL_MOSI     => EL_MOSI,
				EL_SCK      => EL_SCK,
				EL_SSEL     => EL_SSEL,
				DATA_STROBE => '1',
				AZ_POS      => az_pos,
				EL_POS      => el_pos				  
	);

end architecture position_encoder;
