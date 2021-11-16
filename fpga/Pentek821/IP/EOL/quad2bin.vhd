----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:53:09 06/21/2013 
-- Design Name: 
-- Module Name:    QUAD2BIN - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
use ieee.numeric_std.all;

entity QUAD2BIN is
    generic (
        ROT_ENC_TICKS : natural := 400000;
        TILT_ENC_TICKS : natural := 480000);
    port ( 
        RESET : in  STD_LOGIC;
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
end QUAD2BIN;

architecture Behavioral of QUAD2BIN is

component quad2bin_jkff
    Port ( J : in std_logic;
           K : in std_logic;
			  RST : in std_logic;
           CLK : in std_logic;
           Q : out std_logic;
           QN : out std_logic);
end component;

-- Signal declarations
signal rot_encoder_cnt : unsigned(18 downto 0);		-- 400,000 (1000*4*100) counts/revolution of reflector; use both edges of signal
signal tilt_encoder_cnt : unsigned(18 downto 0);		--	480,000 (500*4*30*8) counts/revolution, but limited in travel to ~+/- 3 degrees; note Elmo controller uses both edges of quadrature to get 4 times better resolution!
signal rot_a_filt: STD_LOGIC;
signal rot_b_filt: STD_LOGIC;
signal rot_z_filt: STD_LOGIC;
signal tilt_a_filt: STD_LOGIC;
signal tilt_b_filt: STD_LOGIC;
signal tilt_z_filt: STD_LOGIC;
signal rot_a_filt_d1: STD_LOGIC;
signal rot_b_filt_d1: STD_LOGIC;
signal tilt_a_filt_d1: STD_LOGIC;
signal tilt_b_filt_d1: STD_LOGIC;
signal rot_count_enable: STD_LOGIC;
signal tilt_count_enable: STD_LOGIC;
signal rot_count_direction: STD_LOGIC;
signal tilt_count_direction: STD_LOGIC;
signal rot_a_d1: STD_LOGIC;
signal rot_b_d1: STD_LOGIC;
signal tilt_a_d1: STD_LOGIC;
signal tilt_b_d1: STD_LOGIC;
signal rot_a_d2: STD_LOGIC;
signal rot_b_d2: STD_LOGIC;
signal tilt_a_d2: STD_LOGIC;
signal tilt_b_d2: STD_LOGIC;
signal rot_a_d3: STD_LOGIC;
signal rot_b_d3: STD_LOGIC;
signal tilt_a_d3: STD_LOGIC;
signal tilt_b_d3: STD_LOGIC;
signal rot_a_d4: STD_LOGIC;
signal rot_b_d4: STD_LOGIC;
signal tilt_a_d4: STD_LOGIC;
signal tilt_b_d4: STD_LOGIC;

signal rot_z_d1: STD_LOGIC;
signal rot_z_d2: STD_LOGIC;
signal rot_z_d3: STD_LOGIC;
signal rot_z_d4: STD_LOGIC;
signal tilt_z_d1: STD_LOGIC;
signal tilt_z_d2: STD_LOGIC;
signal tilt_z_d3: STD_LOGIC;
signal tilt_z_d4: STD_LOGIC;

signal rot_a_prefilt: STD_LOGIC;
signal rot_a_prefilt1: STD_LOGIC;
signal rot_b_prefilt: STD_LOGIC;
signal rot_b_prefilt1: STD_LOGIC;
signal tilt_a_prefilt: STD_LOGIC;
signal tilt_a_prefilt1: STD_LOGIC;
signal tilt_b_prefilt: STD_LOGIC;
signal tilt_b_prefilt1: STD_LOGIC;
signal rot_z_prefilt: STD_LOGIC;
signal rot_z_prefilt1: STD_LOGIC;
signal tilt_z_prefilt: STD_LOGIC;
signal tilt_z_prefilt1: STD_LOGIC;

-- signal tilt_corr: STD_LOGIC_VECTOR(18 downto 0);

begin

-- Add some flip-flops to prevent metastability due to asynchronous clock
QUAD_SYNC: process(RESET,CLK,ROT_A,ROT_B,TILT_A,TILT_B,ROT_Z,TILT_Z)
begin
	if (RESET = '1') then
		rot_a_d1 <= '0';
		rot_b_d1 <= '0';
		tilt_a_d1 <= '0';
		tilt_b_d1 <= '0';
		rot_a_d2 <= '0';
		rot_b_d2 <= '0';
		tilt_a_d2 <= '0';
		tilt_b_d2 <= '0';
		rot_a_d3 <= '0';
		rot_b_d3 <= '0';
		tilt_a_d3 <= '0';
		tilt_b_d3 <= '0';
		rot_a_d4 <= '0';
		rot_b_d4 <= '0';
		tilt_a_d4 <= '0';
		tilt_b_d4 <= '0';		
		rot_z_d1 <= '0';
		tilt_z_d1 <= '0';
		rot_z_d2 <= '0';
		tilt_z_d2 <= '0';
		rot_z_d3 <= '0';
		tilt_z_d3 <= '0';
		rot_z_d4 <= '0';
		tilt_z_d4 <= '0';		
	elsif (rising_edge (CLK)) then
		rot_a_d4 <= rot_a_d3;
		rot_b_d4 <= rot_b_d3;	
		rot_a_d3 <= rot_a_d2;
		rot_b_d3 <= rot_b_d2;	
		rot_a_d2 <= rot_a_d1;
		rot_b_d2 <= rot_b_d1;	
		rot_a_d1 <= ROT_A;
		rot_b_d1 <= ROT_B;
		tilt_a_d4 <= tilt_a_d3;
		tilt_b_d4 <= tilt_b_d3;			
		tilt_a_d3 <= tilt_a_d2;
		tilt_b_d3 <= tilt_b_d2;
		tilt_a_d2 <= tilt_a_d1;
		tilt_b_d2 <= tilt_b_d1;			
		tilt_a_d1 <= TILT_A;
		tilt_b_d1 <= TILT_B;
		rot_z_d4 <= rot_z_d3;		
		rot_z_d3 <= rot_z_d2;
		rot_z_d2 <= rot_z_d1;
		rot_z_d1 <= ROT_Z;
		tilt_z_d4 <= tilt_z_d3;
		tilt_z_d3 <= tilt_z_d2;		
		tilt_z_d2 <= tilt_z_d1;
		tilt_z_d1 <= TILT_Z;
	end if;
end process;

-- Filter inputs to prevent noise spikes from corrupting data

		rot_a_prefilt <= rot_a_d4 AND rot_a_d3 AND rot_a_d2;
		rot_a_prefilt1 <= NOT(rot_a_d4 OR rot_a_d3 OR rot_a_d2);
		rot_b_prefilt <= rot_b_d4 AND rot_b_d3 AND rot_b_d2;
		rot_b_prefilt1 <= NOT(rot_b_d4 OR rot_b_d3 OR rot_b_d2);
		tilt_a_prefilt <= tilt_a_d4 AND tilt_a_d3 AND tilt_a_d2;
		tilt_a_prefilt1 <= NOT(tilt_a_d4 OR tilt_a_d3 OR tilt_a_d2);
		tilt_b_prefilt <= tilt_b_d4 AND tilt_b_d3 AND tilt_b_d2;
		tilt_b_prefilt1 <= NOT(tilt_b_d4 OR tilt_b_d3 OR tilt_b_d2);
		rot_z_prefilt <= rot_z_d4 AND rot_z_d3 AND rot_z_d2;
		rot_z_prefilt1 <= NOT(rot_z_d4 OR rot_z_d3 OR rot_z_d2);
		tilt_z_prefilt <= tilt_z_d4 AND tilt_z_d3 AND tilt_z_d2;
		tilt_z_prefilt1 <= NOT(tilt_z_d4 OR tilt_z_d3 OR tilt_z_d2);
		
FF1 : quad2bin_jkff
PORT MAP ( J => rot_a_prefilt,	
			  K => rot_a_prefilt1,
			  RST => RESET,
			  CLK => CLK,
			  Q => rot_a_filt,
			  Qn => open
			);
FF2 : quad2bin_jkff
PORT MAP ( J => rot_b_prefilt,	
			  K => rot_b_prefilt1,
			  RST => RESET,
			  CLK => CLK,
			  Q => rot_b_filt,
			  Qn => open
			);
FF3 : quad2bin_jkff
PORT MAP ( J => rot_z_prefilt,	
			  K => rot_z_prefilt1,
			  RST => RESET,
			  CLK => CLK,
			  Q => rot_z_filt,
			  Qn => open
			);
FF4 : quad2bin_jkff
PORT MAP ( J => tilt_a_prefilt,	
			  K => tilt_a_prefilt1,
			  RST => RESET,
			  CLK => CLK,
			  Q => tilt_a_filt,
			  Qn => open
			);
FF5 : quad2bin_jkff
PORT MAP ( J => tilt_b_prefilt,	
			  K => tilt_b_prefilt1,
			  RST => RESET,
			  CLK => CLK,
			  Q => tilt_b_filt,
			  Qn => open
			);
FF6 : quad2bin_jkff
PORT MAP ( J => tilt_z_prefilt,	
			  K => tilt_z_prefilt1,
			  RST => RESET,
			  CLK => CLK,
			  Q => tilt_z_filt,
			  Qn => open
			);			
--	rot_a_filt <= rot_a_d2;
--	rot_b_filt <= rot_b_d2;
--	tilt_a_filt <= tilt_a_d2;
--	tilt_b_filt <= tilt_b_d2;
--	rot_z_filt <= rot_z_d2;
--	tilt_z_filt <= tilt_z_d2;

DECODE: process(RESET,CLK,rot_a_filt,rot_b_filt,tilt_a_filt,tilt_b_filt,rot_a_filt_d1,rot_b_filt_d1,tilt_a_filt_d1,tilt_b_filt_d1)
begin
	if (RESET = '1') then
		rot_a_filt_d1 <= '0';
		rot_b_filt_d1 <= '0';
		tilt_a_filt_d1 <= '0';
		tilt_b_filt_d1 <= '0';
	elsif (rising_edge (CLK)) then
		rot_a_filt_d1 <= rot_a_filt;
		rot_b_filt_d1 <= rot_b_filt;
		tilt_a_filt_d1 <= tilt_a_filt;
		tilt_b_filt_d1 <= tilt_b_filt;
	end if;
	rot_count_enable <= rot_a_filt XOR rot_a_filt_d1 XOR rot_b_filt XOR rot_b_filt_d1;
	rot_count_direction <= rot_a_filt XOR rot_b_filt_d1;
	tilt_count_enable <= tilt_a_filt XOR tilt_a_filt_d1 XOR tilt_b_filt XOR tilt_b_filt_d1;
	tilt_count_direction <= tilt_a_filt XOR tilt_b_filt_d1;
end process;

QUAD2BIN_ROT: process(CLK)
    constant ROT_ENC_MIN : unsigned(rot_encoder_cnt'high downto 0) := (others=>'0');
    constant ROT_ENC_MAX : unsigned(rot_encoder_cnt'high downto 0) := to_unsigned(ROT_ENC_TICKS-1, rot_encoder_cnt'high+1);
begin
    if (rising_edge (CLK)) then
    
        if rot_count_enable = '1' then
            if rot_count_direction = '1' then                 -- IF A leads, B count up
                if rot_encoder_cnt = ROT_ENC_MAX then
                    rot_encoder_cnt <= ROT_ENC_MIN;
                else
                    rot_encoder_cnt <= rot_encoder_cnt + 1;
                end if;
            else                                               -- IF B leads, A count down
                if rot_encoder_cnt = ROT_ENC_MIN then
                    rot_encoder_cnt <= ROT_ENC_MAX;
                else
                    rot_encoder_cnt <= rot_encoder_cnt - 1;
                end if;
            end if;
        end if;
        
        if RESET = '1' or rot_z_filt = '1' then
            rot_encoder_cnt <= ROT_ENC_MIN;
        end if;
        
    end if;
end process;

QUAD2BIN_TILT: process(CLK)
    constant TILT_ENC_MIN : unsigned(tilt_encoder_cnt'high downto 0) := (others=>'0');
    constant TILT_ENC_MAX : unsigned(tilt_encoder_cnt'high downto 0) := to_unsigned(TILT_ENC_TICKS-1, tilt_encoder_cnt'high+1);
begin
    if (rising_edge (CLK)) then
    
        if tilt_count_enable = '1' then
            if tilt_count_direction = '1' then                 -- IF A leads, B count up
                if tilt_encoder_cnt = TILT_ENC_MAX then
                    tilt_encoder_cnt <= TILT_ENC_MIN;
                else
                    tilt_encoder_cnt <= tilt_encoder_cnt + 1;
                end if;
            else                                               -- IF B leads, A count down
                if tilt_encoder_cnt = TILT_ENC_MIN then
                    tilt_encoder_cnt <= TILT_ENC_MAX;
                else
                    tilt_encoder_cnt <= tilt_encoder_cnt - 1;
                end if;
            end if;
        end if;
        
        if RESET = '1' or tilt_z_filt = '1' then
            tilt_encoder_cnt <= TILT_ENC_MIN;
        end if;
        
    end if;
end process;

-- Scale rotation and tilt to fit into 16 bits; can't shift std_logic_vectors directly need to 
-- perform type conversion first
LATCH_POS: process(RESET,CLK,DATA_STROBE,rot_encoder_cnt,tilt_encoder_cnt)
begin
	if (RESET = '1') then
--		temp <= (others => '0');
--		temp1 <= (others => '0');	
		ROT_POS <= (others => '0');
		TILT_POS <= (others => '0');		
	elsif (rising_edge (CLK)) then
		if (DATA_STROBE = '1') then
--			temp <= to_bitvector(rot_encoder_cnt) sra 1;
--			temp1 <= to_bitvector(tilt_encoder_cnt) sra 1;	
--			temp <= to_bitvector(rot_encoder_cnt) sra 3;
--			temp1 <= to_bitvector(tilt_encoder_cnt) sra 3;

--			increment/decrement counters each PRT for testing
--			rot_encoder_cnt <= rot_encoder_cnt + 1;
--			tilt_encoder_cnt <= tilt_encoder_cnt - 1;
			ROT_POS(rot_encoder_cnt'high downto 0) <= std_logic_vector(rot_encoder_cnt);
			TILT_POS(tilt_encoder_cnt'high downto 0) <= std_logic_vector(tilt_encoder_cnt);
		end if;		
	end if;	
end process;

--rot_posit <= To_StdUlogicVector(temp(15 downto 0));
--tilt_posit <= To_StdUlogicVector(temp1(15 downto 0));	
--ROT_POS <= To_StdLogicVector(rot_posit);
--TILT_POS <= To_StdLogicVector(tilt_posit);

end Behavioral;




library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity quad2bin_jkff is
    Port ( J : in  STD_LOGIC;
           K : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           Q : out  STD_LOGIC;
           QN : out  STD_LOGIC);
end quad2bin_jkff;

architecture Behavioral of quad2bin_jkff is
signal Qi: std_logic := '0';
signal QNi: std_logic := '1';
begin
process(J,K,CLK,RST)
begin	
	if (RST = '1') then
		Qi <= '0';
		QNi <= '1';
	elsif (rising_edge (CLK)) then
      if(J='0' and K='0') then
         Qi <= Qi;
         QNi <= QNi;
      elsif(J='0' and K='1') then
          Qi <= '0';
          QNi <= '1';
      elsif(J='1' and K='0') then
           Qi <= '1';
           QNi <= '0';
      elsif(J='1' and K='1') then
           Qi <= NOT Qi;
           QNi <= NOT QNi;
      end if;
	end if;
	end process;
	Q<=Qi;
	QN<= QNi;
end Behavioral;


