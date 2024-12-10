--
-- position_encoder_tb.vhd
--    Author: Adam Karboski <karboski@ucar.edu>
--
-- Copyright (c) 2021 University Corporation for Atmospheric Research
-- All rights reserved.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.std_logic_arith.all;
USE IEEE.std_logic_unsigned.all;


entity position_encoder_tb is
end position_encoder_tb;

architecture position_encoder_tb of position_encoder_tb is

component position_encoder is
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
end component position_encoder;

signal aclk         : std_logic := '0';
signal aresetn      : std_logic := '0';
signal ctl_reg      : std_logic_vector(31 downto 0) := (others=>'0');
signal ROT_A        : std_logic := '0';
signal ROT_B        : std_logic := '0';
signal TILT_A       : std_logic := '0';
signal TILT_B       : std_logic := '0';
signal AZ_MOSI      : std_logic := '0';
signal AZ_SCK       : std_logic := '0';
signal AZ_SSEL      : std_logic := '0';
signal EL_MOSI      : std_logic := '0';
signal EL_SCK       : std_logic := '0';
signal EL_SSEL      : std_logic := '0';
signal pos_enc_0    : std_logic_vector(31 downto 0) := (others=>'0');
signal pos_enc_1    : std_logic_vector(31 downto 0) := (others=>'0');

begin

    aresetn <= '1' after 32ns;
    aclk    <= not aclk after 5ns; 
    
    rot_a   <= not rot_a after 100ns;
    rot_b   <= rot_a after 50ns;
    
    tilt_b  <= not tilt_b after 100ns;
    tilt_a  <= tilt_b after 50ns;     

	DUT: position_encoder
	PORT MAP (
        aclk      => aclk,       
        aresetn   => aresetn,   
        ctl_reg   => ctl_reg,   
        ROT_A     => ROT_A,     
        ROT_B     => ROT_B,     
        TILT_A    => TILT_A,    
        TILT_B    => TILT_B,    
        AZ_MOSI   => AZ_MOSI,   
        AZ_SCK    => AZ_SCK,    
        AZ_SSEL   => AZ_SSEL,   
        EL_MOSI   => EL_MOSI,   
        EL_SCK    => EL_SCK,    
        EL_SSEL   => EL_SSEL,   
        pos_enc_0 => pos_enc_0, 
        pos_enc_1 => pos_enc_1 	  
	);

end architecture position_encoder_tb;
