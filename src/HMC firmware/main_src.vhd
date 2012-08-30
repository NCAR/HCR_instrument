----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:01:07 07/17/2012 
-- Design Name: 
-- Module Name:    main_src - Behavioral 
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
USE IEEE.STD_LOGIC_1164.ALL;
USE     IEEE.std_logic_arith.all;
USE     IEEE.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity main_src is
    Port ( 

--			Unused FPGA inputs	 
--				RDS_GND : in  STD_LOGIC;
--          PW_GND : in  STD_LOGIC;
				ONE_PPS : in STD_LOGIC;

--       Unused Pentek Timing Signals
--				TIMER_6 : in  STD_LOGIC;      		
--          TIMER_7 : in  STD_LOGIC;
				RX_GATE : in  STD_LOGIC;  							
					
--			Pentek Timing Signals (Connector PN 4)
				EXT_CLK : in  STD_LOGIC;	-- 15.625 MHz clock; 125 MHz/8
				T0 : in  STD_LOGIC;						
				MOD_PULSE : in  STD_LOGIC;			 	
				SYNC_PULSE : in  STD_LOGIC;	  				
				EMS_TRIG : in  STD_LOGIC;

--			Power Monitoring
				STATUS_5V : in  STD_LOGIC;
				STATUS_8V : in  STD_LOGIC;
            STATUS_12V : in  STD_LOGIC;
				STATUS_15V : in  STD_LOGIC;
            STATUS_28V : in  STD_LOGIC;			

--			PMC730 Commands
				HV_ON_730 : in  STD_LOGIC;	-- High voltage cmd from PMC730
				FIL_ON_730 : in STD_LOGIC; -- Filament on cmd from PMC730
				RESET_730 : in STD_LOGIC; -- FPGA reset cmd from PMC730
				OPS_MODE_730 : in STD_LOGIC_VECTOR(1 downto 0); -- Operationsl mode cmd from PMC730

--			EMS latching circulator Built in Test (BIT) complementary inputs				
				BIT_EMS_P : in  STD_LOGIC_VECTOR(7 downto 1);  -- EMS latching circulator positive BIT
				BIT_EMS_N : in  STD_LOGIC_VECTOR(7 downto 1);  -- EMS latching circulator negative BIT

-- 		EMS latching circulator complementary control signals
				EMS_OUT : out  STD_LOGIC_VECTOR(7 downto 1); -- EMS latching circulator outputs
				
--			Modulator complementary timing and control signals
				MOD_PULSE_OUT_P : out  STD_LOGIC;			 	
				MOD_PULSE_OUT_N : out  STD_LOGIC;
				SYNC_PULSE_OUT_P : out  STD_LOGIC;			 	
				SYNC_PULSE_OUT_N : out  STD_LOGIC;
				HV_ON_P : out  STD_LOGIC;
				HV_ON_N : out  STD_LOGIC;
				FIL_ON_P : out  STD_LOGIC;
				FIL_ON_N : out  STD_LOGIC;
				
--  		Status information				
				MOD_PULSE_DISABLE : out  STD_LOGIC;				-- Fault sum status
				STATUS : out  STD_LOGIC_VECTOR(2 downto 0);  -- Status bits
				
--			CMU timing signals
				MOD_PULSE_FUSELAGE: out STD_LOGIC;           			
				SYNC_PULSE_FUSELAGE: out STD_LOGIC; 				

---- route spare connector (P3)
              SPARE1: out STD_LOGIC;
              SPARE2: out STD_LOGIC;
              SPARE3: out STD_LOGIC;
              SPARE4: out STD_LOGIC;
              SPARE5: out STD_LOGIC;
              SPARE6: out STD_LOGIC;
              SPARE7: out STD_LOGIC				  
				  
--		Unused signals available on FPGA only
--              SPARE10: inout STD_LOGIC;
--              SPARE11: inout STD_LOGIC;
--              SPARE12: inout STD_LOGIC;
--              SPARE13: inout STD_LOGIC;
--              SPARE14: inout STD_LOGIC;
--              SPARE15: inout STD_LOGIC;
--              SPARE16: inout STD_LOGIC;
--              SPARE17: inout STD_LOGIC;
--              SPARE18: inout STD_LOGIC;
--              SPARE19: inout STD_LOGIC;
--              SPARE21: inout STD_LOGIC;
--              SPARE22: inout STD_LOGIC;
--              SPARE23: inout STD_LOGIC;
);
end main_src;

architecture Behavioral of main_src is

--   Signal declarations
signal radar_pwr_ok : STD_LOGIC;
signal ems_pwr_ok : STD_LOGIC; 
signal hv_dly : STD_LOGIC;
signal hv_count : STD_LOGIC_VECTOR(23 downto 0);
signal count_enable : STD_LOGIC;
signal tx_dly : STD_LOGIC;									-- Delay before reading EMS BIT on transmit
signal ems_tx_count : STD_LOGIC_VECTOR(2 downto 0);
signal rx_dly : STD_LOGIC;									-- Delay before reading EMS BIT on receive
signal ems_rx_count : STD_LOGIC_VECTOR(2 downto 0);
signal l_ems_trig : STD_LOGIC;							-- Latched EMS_TRIG signal
signal ems_tx_count_enable : STD_LOGIC;
signal ems_rx_count_enable : STD_LOGIC;
signal end_cycle : STD_LOGIC;								--	End of cycle flag
signal ems_tx_ok : STD_LOGIC;
signal ems_rx_ok : STD_LOGIC;
signal ems_tx_stat : STD_LOGIC;
signal ems_rx_stat : STD_LOGIC;
signal l_tx_dly : STD_LOGIC;
signal l_rx_dly : STD_LOGIC;
signal half_hz : STD_LOGIC; 	-- 1/2 Hz Clock
signal pps_count : STD_LOGIC_VECTOR(1 downto 0); 
signal l_rx_gate : STD_LOGIC;

-- State machine declarations
type state_type is (s0,s1,s2,s3);
signal state: state_type;

Begin

--   Asynchronous Processes ------------------------------------------------------------------

-- Tx Control
HV_ON_P <= HV_ON_730;
HV_ON_N <= NOT HV_ON_730;
FIL_ON_P <= FIL_ON_730;
FIL_ON_N <= NOT FIL_ON_730;
SYNC_PULSE_OUT_P <= SYNC_PULSE;
SYNC_PULSE_OUT_N <= NOT SYNC_PULSE;

-- Unassigned Spare Signals


-- Tx Inputs to CMU

SYNC_PULSE_FUSELAGE <= SYNC_PULSE;

-- Check key power supply voltages
CHECK_VOLT: process (STATUS_5V, STATUS_8V, STATUS_12V, STATUS_15V, STATUS_28V)
	begin
-- 	Uncomment when get another status bit on next HMC hardware revision	
--		if (STATUS_8V = '1' or STATUS_12V = '1' or STATUS_15V = '1') then 
--			radar_pwr_ok <= '0';
--		else 
--			radar_pwr_ok <= '1';
--		end if; 
		if (STATUS_5V = '1' or STATUS_28V = '1') then 
			ems_pwr_ok <= '0';
		else 
			ems_pwr_ok <= '1';
 		end if; 

	end process; 
	
-- Check EMS BIT
CHECK_BIT: process (BIT_EMS_P,BIT_EMS_N)
begin
	if (BIT_EMS_N <= "0101110" AND BIT_EMS_P <= "1111111") then   -- vertical transmit mode
		ems_tx_stat <= '1';
	else
		ems_tx_stat <= '0';
	end if;
	if (BIT_EMS_N <= "1010011" AND BIT_EMS_P <= "1111111") then   -- vertical transmit mode
		ems_rx_stat <= '1';
	else
		ems_rx_stat <= '0';
	end if;	
end process;

-- Assign test signals to SPARE outputs for debug

	SPARE1 <= hv_dly;
	SPARE2 <= tx_dly;
	SPARE3 <= rx_dly;
	SPARE4 <= ems_tx_stat;
	SPARE5 <= ems_tx_ok;
	SPARE6 <= end_cycle;
	SPARE7 <= ems_pwr_ok;
	
--- End Asychronous Processes --------------------------------------------------------------------

-- Synchronous Processes -------------------------------------------------------------------------

-- Half Hz Counter

HALF_HZ_COUNTER: process (RESET_730, ONE_PPS)
begin
	if (RESET_730 = '1') then
		half_hz <= '0';
		pps_count <= "00";
	elsif (rising_edge (ONE_PPS)) then
		if (pps_count <= "01") then
			half_hz <= '1';
			pps_count <= "00";
		else
			pps_count <= pps_count + 1;
			half_hz <= '0';
		end if;
	end if;
end process;

-- Update status every two seconds
UPDATE_STAT: process (RESET_730, half_hz, ems_pwr_ok, ems_tx_ok, ems_rx_ok)
begin
	if (RESET_730 = '1') then
		STATUS <= "000";   -- good status
	elsif (rising_edge (half_hz)) then
		STATUS(0) <= NOT ems_pwr_ok;
		STATUS(1) <= NOT ems_tx_ok;
		STATUS(2) <= NOT ems_rx_ok;
		MOD_PULSE_DISABLE <= NOT (ems_pwr_ok AND ems_tx_ok);
--		if (ems_pwr_ok = '0') then
--			STATUS <= "001";
--		elsif (ems_tx_ok = '0') then
--			STATUS <= "10";
--		elsif (ems_rx_ok = '0') then
--			STATUS <= "11";
--		else
--			STATUS <= "00";
--		end if;
	end if;	
end process;

-- Latch EMS delays
LATCH_DLY: process (EXT_CLK, RESET_730, tx_dly, rx_dly)
begin
	if (RESET_730 = '1') then
		l_tx_dly <= '0';
		l_rx_dly <= '0';
	elsif (rising_edge (EXT_CLK)) then
		l_tx_dly <= tx_dly;
		l_rx_dly <= rx_dly;
	end if;
end process;

-- Update EMS status when BIT is valid
EMS_STAT: process (EXT_CLK, RESET_730, ems_tx_stat, ems_rx_stat, tx_dly, rx_dly, l_tx_dly, l_rx_dly, end_cycle)
begin
	if (RESET_730 = '1') then
		ems_tx_ok <= '1';
		ems_rx_ok <= '1';
	elsif (rising_edge (EXT_CLK)) then
		ems_tx_ok <= ((NOT l_tx_dly AND tx_dly AND ems_tx_stat) OR ems_tx_ok) AND NOT end_cycle;
		ems_rx_ok <= ((NOT l_rx_dly AND rx_dly AND ems_rx_stat) OR ems_rx_ok) AND NOT end_cycle;
	end if;
end process;
	
-- Sets 1 second safety delay from HV_ON to enabling transmit triggers				
DELAY_1SEC: process (EXT_CLK, RESET_730, HV_ON_730)
begin 
	if (RESET_730 = '1') then
      hv_count <= "000000000000000000000000";
		hv_dly <= '0';
		count_enable <= '1';	
   elsif (rising_edge (EXT_CLK)) then				
		if (HV_ON_730 = '0') then
			if(hv_count = "111100000000000000000000") then -- ~1sec delay
				hv_count <= "000000000000000000000000";
				count_enable <= '0';
				hv_dly <= '1';
			elsif (count_enable = '1') then	
				hv_count <= hv_count + 1;
			end if;
		else	
				hv_count <= "000000000000000000000000";
				hv_dly <= '0';
				count_enable <= '1';
		end if;
	end if;
end process;

-- Generate registered EMS_TRIG
LATCH_EMS_TRIG: process (EXT_CLK, RESET_730, EMS_TRIG)
begin
	if (RESET_730 = '1') then
		l_ems_trig <= '0';
	elsif (rising_edge (EXT_CLK)) then
		l_ems_trig <= EMS_TRIG;
	end if;
end process;	

-- Generate EMS Transmit and Receive BIT count enables
EMS_CNT_EN: process (EXT_CLK, RESET_730, EMS_TRIG, l_ems_trig)
begin
	if (RESET_730 = '1') then
      ems_tx_count_enable <= '0';
		ems_rx_count_enable <= '0';
	elsif (rising_edge (EXT_CLK)) then
		ems_tx_count_enable <= ((EMS_TRIG AND NOT l_ems_trig) OR ems_tx_count_enable) AND NOT end_cycle; -- rising edge of EMS_TRIG
		ems_rx_count_enable <= ((NOT EMS_TRIG AND l_ems_trig) OR ems_rx_count_enable) AND NOT end_cycle; -- falling edge of EMS_TRIG
	end if;
end process;
	
-- Sets delay from EMS switch trigger to EMS switch BIT valid on transmit
EMS_TX_DELAY: process (EXT_CLK, RESET_730, ems_tx_count_enable)
begin 
	if (RESET_730 = '1') then
      ems_tx_count <= "000";
		tx_dly <= '0';	
   elsif (rising_edge (EXT_CLK)) then				
		if (ems_tx_count_enable = '1') then
			if(ems_tx_count = "100") then 
				ems_tx_count <= "000";
				tx_dly <= '1';
			else
				ems_tx_count <= ems_tx_count + 1;
			end if;
		else	
				ems_tx_count <= "000";
				tx_dly <= '0';
		end if;
	end if;
end process;

-- Sets delay from EMS switch trigger to EMS switch BIT valid on receive
EMS_RX_DELAY: process (EXT_CLK, RESET_730, ems_rx_count_enable)
begin 
	if (RESET_730 = '1') then
      ems_rx_count <= "000";
		rx_dly <= '0';	
   elsif (rising_edge (EXT_CLK)) then				
		if (ems_rx_count_enable = '1') then
			if(ems_rx_count = "100") then 
				ems_rx_count <= "000";
				rx_dly <= '1';
			else
				ems_rx_count <= ems_rx_count + 1;
			end if;
		else	
				ems_rx_count <= "000";
				rx_dly <= '0';
		end if;
	end if;
end process;

-- Defines cycle over which State Machine operates
CYCLE: process (EXT_CLK, RESET_730, RX_GATE, l_rx_gate)
begin
	if (RESET_730 = '1') then
      end_cycle <= '0';
		l_rx_gate <= '0';
   elsif (rising_edge (EXT_CLK)) then
		l_rx_gate <= RX_GATE;
		end_cycle <= l_rx_gate AND NOT RX_GATE;  -- end cycle on falling edge of rx_gate!
	end if;
end process;

------------------------ End Sychronous Processes ----------------------------------------------------

------------------------ State Machine ----------------------------------------------------------------

STATE_MACHINE: process (RESET_730,EXT_CLK)
begin
	if (RESET_730 = '1') then
		state <= s0;
	elsif (rising_edge (EXT_CLK)) then
		case state is
			when s0 =>
				if (OPS_MODE_730 = "11" AND EMS_TRIG = '1' AND T0 = '1' AND tx_dly = '0' AND rx_dly = '0' AND ems_pwr_ok = '1') then   -- Test Mode
					state <= s1;
				elsif(EMS_TRIG = '1' AND T0 = '1'AND tx_dly = '0' AND rx_dly = '0' AND hv_dly = '1' AND ems_pwr_ok = '1') then
					state <= s1;
				end if;		
			when s1 =>
				if (OPS_MODE_730 = "11" AND ems_tx_ok = '1' AND rx_dly = '0' AND ems_pwr_ok = '1') then    -- Test Mode
					state <= s2;
				elsif(ems_tx_ok = '1' AND rx_dly = '0' AND hv_dly = '1' AND ems_pwr_ok = '1') then
					state <= s2;
--				elsif(ems_tx_ok = '0' AND rx_dly = '0' AND tx_dly = '1' ) then
--					state <=s0;
				elsif(ems_pwr_ok = '0' AND rx_dly = '0' AND tx_dly = '1') then
					state <=s0;
				elsif(hv_dly = '0' AND rx_dly = '0' AND tx_dly = '1') then
					state <=s0;					
				end if;			
			when s2 =>
				if (OPS_MODE_730 = "11" AND tx_dly = '1' AND ems_pwr_ok = '1') then  -- Test Mode
					state <= s3;
				elsif(rx_dly = '1' AND tx_dly = '1' AND hv_dly = '1' AND ems_pwr_ok = '1') then
					state <= s3;
				elsif(rx_dly = '1' AND tx_dly = '1' AND hv_dly = '0' AND ems_pwr_ok = '1') then
					state <=s0;					
				elsif(rx_dly = '1' AND tx_dly = '1' AND hv_dly = '1' AND ems_pwr_ok = '0') then
					state <=s0;
				elsif(rx_dly = '1' AND tx_dly = '1' AND hv_dly = '0' AND ems_pwr_ok = '0') then
					state <=s0;										
				end if;
			when s3 =>
				if(RX_GATE = '0' AND ems_tx_ok = '1' AND rx_dly = '0' AND tx_dly = '0' AND hv_dly = '1' AND ems_pwr_ok = '1') then
					state <= s0;
				end if;
		end case;
	end if;
end process;

-- State Machine Ouputs

STATE_OUT: process (state,MOD_PULSE,EMS_TRIG,OPS_MODE_730)
begin
	case state is
		when S0 => 			-- Reset State
			MOD_PULSE_OUT_P <= '0';
			MOD_PULSE_OUT_N <= '1';
			MOD_PULSE_FUSELAGE <= '0';
			if (OPS_MODE_730 = "01") then -- Noise source cal, no tx	
				EMS_OUT <= "0101101";
			else
				EMS_OUT <= "0000000";
			end if;
		when S1 =>
			if (OPS_MODE_730 = "00") then -- Normal Ops, vertical tx
				MOD_PULSE_OUT_P <= '0';
				MOD_PULSE_OUT_N <= '1';
				MOD_PULSE_FUSELAGE <= '0';
				EMS_OUT(1) <= NOT EMS_TRIG;
				EMS_OUT(2) <= '1';
				EMS_OUT(3) <= EMS_TRIG;
				EMS_OUT(4) <= EMS_TRIG;
				EMS_OUT(5) <= NOT EMS_TRIG;
				EMS_OUT(6) <= EMS_TRIG;
				EMS_OUT(7) <= NOT EMS_TRIG;
			elsif (OPS_MODE_730 = "01") then -- Noise source cal, no tx
				MOD_PULSE_OUT_P <= '0';
				MOD_PULSE_OUT_N <= '1';
				MOD_PULSE_FUSELAGE <= '0';
				EMS_OUT <= "0101101";
			elsif (OPS_MODE_730 = "10") then -- Corner reflector cal, vertical tx w/reduced power
				MOD_PULSE_OUT_P <= '0';
				MOD_PULSE_OUT_N <= '1';
				MOD_PULSE_FUSELAGE <= '0';
				EMS_OUT(1) <= NOT EMS_TRIG;
				EMS_OUT(2) <= '1';
				EMS_OUT(3) <= EMS_TRIG;
				EMS_OUT(4) <= EMS_TRIG;
				EMS_OUT(5) <= '0';
				EMS_OUT(6) <= EMS_TRIG;
				EMS_OUT(7) <= '0';
			elsif (OPS_MODE_730 = "11") then -- Test Mode, no tx
				MOD_PULSE_OUT_P <= '0';
				MOD_PULSE_OUT_N <= '1';
				MOD_PULSE_FUSELAGE <= '0';
				EMS_OUT(1) <= NOT EMS_TRIG;
				EMS_OUT(2) <= '1';
				EMS_OUT(3) <= EMS_TRIG;
				EMS_OUT(4) <= EMS_TRIG;
				EMS_OUT(5) <= NOT EMS_TRIG;
				EMS_OUT(6) <= EMS_TRIG;
				EMS_OUT(7) <= NOT EMS_TRIG;
			end if;
		when S2 =>
			if (OPS_MODE_730 = "00") then -- Normal Ops, vertical tx		
				MOD_PULSE_OUT_P <= MOD_PULSE;
				MOD_PULSE_OUT_N <= NOT MOD_PULSE;
				MOD_PULSE_FUSELAGE <= MOD_PULSE;
				EMS_OUT(1) <= NOT EMS_TRIG;
				EMS_OUT(2) <= '1';
				EMS_OUT(3) <= EMS_TRIG;
				EMS_OUT(4) <= EMS_TRIG;
				EMS_OUT(5) <= NOT EMS_TRIG;
				EMS_OUT(6) <= EMS_TRIG;
				EMS_OUT(7) <= NOT EMS_TRIG;
			elsif (OPS_MODE_730 = "01") then -- Noise source cal, no tx
				MOD_PULSE_OUT_P <= '0';
				MOD_PULSE_OUT_N <= '1';
				MOD_PULSE_FUSELAGE <= '0';
				EMS_OUT <= "0101101";
			elsif (OPS_MODE_730 = "10") then -- Corner reflector cal, vertical tx w/reduced power
				MOD_PULSE_OUT_P <= MOD_PULSE;
				MOD_PULSE_OUT_N <= NOT MOD_PULSE;
				MOD_PULSE_FUSELAGE <= MOD_PULSE;
				EMS_OUT(1) <= NOT EMS_TRIG;
				EMS_OUT(2) <= '1';
				EMS_OUT(3) <= EMS_TRIG;
				EMS_OUT(4) <= EMS_TRIG;
				EMS_OUT(5) <= '0';
				EMS_OUT(6) <= EMS_TRIG;
				EMS_OUT(7) <= '0';
			elsif (OPS_MODE_730 = "11") then -- Test Mode, no tx
				MOD_PULSE_OUT_P <= '0';
				MOD_PULSE_OUT_N <= '1';
				MOD_PULSE_FUSELAGE <= '0';
				EMS_OUT(1) <= NOT EMS_TRIG;
				EMS_OUT(2) <= '1';
				EMS_OUT(3) <= EMS_TRIG;
				EMS_OUT(4) <= EMS_TRIG;
				EMS_OUT(5) <= NOT EMS_TRIG;
				EMS_OUT(6) <= EMS_TRIG;
				EMS_OUT(7) <= NOT EMS_TRIG;
			end if;						
		when S3 =>
			if (OPS_MODE_730 = "00") then -- Normal Ops, vertical tx				
				MOD_PULSE_OUT_P <= MOD_PULSE;
				MOD_PULSE_OUT_N <= NOT MOD_PULSE;
				MOD_PULSE_FUSELAGE <= MOD_PULSE;
				EMS_OUT(1) <= NOT EMS_TRIG;
				EMS_OUT(2) <= '1';
				EMS_OUT(3) <= EMS_TRIG;
				EMS_OUT(4) <= EMS_TRIG;
				EMS_OUT(5) <= NOT EMS_TRIG;
				EMS_OUT(6) <= EMS_TRIG;
				EMS_OUT(7) <= NOT EMS_TRIG;
			elsif (OPS_MODE_730 = "01") then -- Noise source cal, no tx
				MOD_PULSE_OUT_P <= '0';
				MOD_PULSE_OUT_N <= '1';
				MOD_PULSE_FUSELAGE <= '0';
				EMS_OUT <= "0101101";
			elsif (OPS_MODE_730 = "10") then -- Corner reflector cal, vertical tx w/reduced power
				MOD_PULSE_OUT_P <= MOD_PULSE;
				MOD_PULSE_OUT_N <= NOT MOD_PULSE;
				MOD_PULSE_FUSELAGE <= MOD_PULSE;
				EMS_OUT(1) <= NOT EMS_TRIG;
				EMS_OUT(2) <= '1';
				EMS_OUT(3) <= EMS_TRIG;
				EMS_OUT(4) <= EMS_TRIG;
				EMS_OUT(5) <= '0';
				EMS_OUT(6) <= EMS_TRIG;
				EMS_OUT(7) <= '0';
			elsif (OPS_MODE_730 = "11") then -- Test Mode, no tx
				MOD_PULSE_OUT_P <= '0';
				MOD_PULSE_OUT_N <= '1';
				MOD_PULSE_FUSELAGE <= '0';
				EMS_OUT(1) <= NOT EMS_TRIG;
				EMS_OUT(2) <= '1';
				EMS_OUT(3) <= EMS_TRIG;
				EMS_OUT(4) <= EMS_TRIG;
				EMS_OUT(5) <= NOT EMS_TRIG;
				EMS_OUT(6) <= EMS_TRIG;
				EMS_OUT(7) <= NOT EMS_TRIG;
			end if;						
	end case;
end process;	
			
-------------------------------------------------------------------------------------------------------
end Behavioral;

