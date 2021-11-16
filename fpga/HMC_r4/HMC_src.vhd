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

entity HMC_src is
    Port ( 

--			Unused FPGA inputs	 
--				RDS_GND : in  STD_LOGIC;
--          PW_GND : in  STD_LOGIC;

--       Unused Pentek Timing Signals
				TIMER_6 : in  STD_LOGIC;      		
            TIMER_7 : in  STD_LOGIC;
				TX_GATE : in  STD_LOGIC;

--			cPCI Signals				
				RESET: in  STD_LOGIC;  -- cPCI reset line
				
--			Pentek Timing Signals (Connector PN 4)
				EXT_CLK : in  STD_LOGIC;	-- 15.625 MHz clock; 125 MHz/8
				T0 : in  STD_LOGIC;						
				MOD_PULSE : in  STD_LOGIC;			 	
				SYNC_PULSE : in  STD_LOGIC;	  				
				EMS_TRIG : in  STD_LOGIC;
				RX_GATE : in  STD_LOGIC;  

--			GPS input
				ONE_PPS : in STD_LOGIC;				
				
--			Power Monitoring
				EMS_PWR_ERROR : in  STD_LOGIC;

--			PMC730 Commands
				HV_ON_730 : in  STD_LOGIC;	-- High voltage cmd from PMC730
				FIL_ON_730 : in STD_LOGIC; -- Filament on cmd from PMC730
				OPS_MODE_730 : in STD_LOGIC_VECTOR(2 downto 0); -- Operationsl mode cmd from PMC730
				STATUS_ACK: in  STD_LOGIC;	-- Status receipt acknowledgement
				
--			EMS latching circulator Built in Test (BIT) complementary inputs				
				BIT_EMS : in  STD_LOGIC_VECTOR(7 downto 1);  -- EMS latching circulator BIT

-- 		EMS latching circulator complementary control signals
				EMS_OUT : out  STD_LOGIC_VECTOR(7 downto 1); -- EMS latching circulator outputs
				
--			Modulator timing and control signals
				MOD_PULSE_HMC : out  STD_LOGIC;			 	
				SYNC_PULSE_HMC : out  STD_LOGIC;			 	
				HV_ON_HMC : out  STD_LOGIC;
				FIL_ON_HMC : out  STD_LOGIC;
				
--			Noise source calibration control

				WG_SW_TERM: in STD_LOGIC; 			-- BIT indication when waveguide switch is into load
				WG_SW_NOISE: in STD_LOGIC; 		-- BIT indication when waveguide switch is into noise source
				WG_SW_CTRL_TERM: out STD_LOGIC; 	-- Terminate waveguide switch into load
				WG_SW_CTRL_NOISE: out STD_LOGIC; -- Terminate waveguide switch into noise source
				NOISE_SOURCE_EN: out STD_LOGIC; 	-- Turn on noise source
				WG_SW_ERROR: out STD_LOGIC;		-- Waveguide switch BIT doesn't match command					
				
--  		Status information				
				MOD_PULSE_DISABLE : out  STD_LOGIC;				-- Fault sum status
				EMS_ERROR_1 : 	out  STD_LOGIC; 					-- EMS switch 1 BIT error
				EMS_ERROR_2 : 	out  STD_LOGIC; 					-- EMS switch 2 BIT error
				EMS_ERROR_3 : 	out  STD_LOGIC; 					-- EMS switch 3 BIT error
				EMS_ERROR_45 : 	out  STD_LOGIC; 				-- EMS switch 4,5 BIT error
				EMS_ERROR_67 : 	out  STD_LOGIC; 				-- EMS switch 6,7 BIT error
				EMS_ERROR_EVENT : 	out  STD_LOGIC; 				-- EMS switch BIT error count

-- 		General spares
				TEST_BIT_0: IN STD_LOGIC;
				TEST_BIT_1: IN STD_LOGIC;
				SPARE_STATUS0: OUT STD_LOGIC;
				SPARE_STATUS1: OUT STD_LOGIC;	

--			U6 Output Enable control, allows Pentek to be discovered on PCI bus
				U6_OE: OUT STD_LOGIC;					
				 				
--			Route spare connector (P3)
            SPARE1: out STD_LOGIC;
            SPARE2: out STD_LOGIC;
            SPARE3: out STD_LOGIC
--              SPARE4: out STD_LOGIC;
--              SPARE5: out STD_LOGIC;
--              SPARE6: out STD_LOGIC;
--              SPARE7: out STD_LOGIC				  
				  
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
end HMC_src;

architecture Behavioral of HMC_src is
-- Uncomment for "Safe" mode
--BEGIN
----	EMS latching circulator complementary control signals
--	EMS_OUT <= "ZZZZZZZ";
--				
----			Modulator timing and control signals
--	MOD_PULSE_HMC <= 'Z';			 	
--	SYNC_PULSE_HMC <= 'Z';
--	HV_ON_HMC <= 'Z';
--	FIL_ON_HMC <= 'Z';
--				
----			Noise source calibration control
--	WG_SW_CTRL_TERM <= 'Z';
--	WG_SW_CTRL_NOISE <= 'Z';
--	NOISE_SOURCE_EN <= 'Z';
--	WG_SW_ERROR <= 'Z';
--				
----  		Status information				
--	MOD_PULSE_DISABLE <= 'Z';
--	EMS_ERROR_1 <= 'Z';
--	EMS_ERROR_2 <= 'Z';
--	EMS_ERROR_3 <= 'Z';
--	EMS_ERROR_45 <= 'Z';
--	EMS_ERROR_67 <= 'Z';
--	EMS_ERROR_EVENT <= 'Z';
--
---- 		General spares
--	SPARE_STATUS0 <= 'Z';
--	SPARE_STATUS1 <= 'Z';
--				 				
----			Route spare connector (P3)
--   SPARE1 <= 'Z';
--   SPARE2 <= 'Z';
--   SPARE3 <= 'Z';
--				
--END;
--   Signal declarations

signal ems_pwr_ok : STD_LOGIC; 
signal hv_dly : STD_LOGIC;
signal hv_count : STD_LOGIC_VECTOR(23 downto 0);
signal count_enable : STD_LOGIC;
signal U6_count : STD_LOGIC_VECTOR(23 downto 0);
signal U6_dly : STD_LOGIC;
signal U6_count_enable : STD_LOGIC;
signal wg_dly : STD_LOGIC;
signal wg_count : STD_LOGIC_VECTOR(20 downto 0);
signal wg_count_enable : STD_LOGIC;
signal wg_change_state : STD_LOGIC;
signal wg_stat : STD_LOGIC;
signal tx_dly : STD_LOGIC;									-- Delay before reading EMS BIT on transmit
signal ems_tx_count : STD_LOGIC_VECTOR(4 downto 0);
signal rx_dly : STD_LOGIC;									-- Delay before reading EMS BIT on receive
signal ems_rx_count : STD_LOGIC_VECTOR(4 downto 0);
signal l_ems_trig : STD_LOGIC;							-- Latched EMS_TRIG signal
signal ems_tx_count_enable : STD_LOGIC;
signal ems_rx_count_enable : STD_LOGIC;
signal end_cycle : STD_LOGIC;								--	End of cycle flag
signal ems_tx_ok : STD_LOGIC;
signal ems_rx_ok : STD_LOGIC;
signal ems_tx_stat : STD_LOGIC;
signal ems_rx_stat : STD_LOGIC;
signal ems_tx_error: STD_LOGIC;
signal ems_1_tx_stat : STD_LOGIC;
signal ems_2_tx_stat : STD_LOGIC;
signal ems_3_tx_stat : STD_LOGIC;
signal ems_45_tx_stat : STD_LOGIC;
signal ems_67_tx_stat : STD_LOGIC;
signal ems_1_rx_stat : STD_LOGIC;
signal ems_2_rx_stat : STD_LOGIC;
signal ems_3_rx_stat : STD_LOGIC;
signal ems_45_rx_stat : STD_LOGIC;
signal ems_67_rx_stat : STD_LOGIC;
signal ems_1_error : STD_LOGIC;
signal ems_2_error : STD_LOGIC;
signal ems_3_error : STD_LOGIC;
signal ems_45_error : STD_LOGIC;
signal ems_67_error : STD_LOGIC;
signal mod_pulse_error : STD_LOGIC;

signal ems_error_prt : STD_LOGIC;							-- 

signal l_tx_dly : STD_LOGIC;
signal l_rx_dly : STD_LOGIC;

-- signal pps_count : STD_LOGIC; 
signal l_rx_gate : STD_LOGIC;
signal ops_mode : STD_LOGIC_VECTOR(2 downto 0);    -- ops_mode at state S0
signal ops_mode_en : STD_LOGIC; 							-- enables ops mode to be latched
signal pol_state : STD_LOGIC_VECTOR(1 downto 0);   -- polarization state of Tx pulse

signal wg_sw_pos: STD_LOGIC;								-- current waveguide switch position
signal cmd_wg_sw_pos: STD_LOGIC;							-- commanded waveguide switch position

-- signal t0_d1: STD_LOGIC;
-- signal t0_rising: STD_LOGIC;

signal hv_flag: STD_LOGIC;									-- H/V Flag to be sent to Pentek for housekeeping; Tx-H=1, Tx-V=0

-- State machine declarations
type state_type is (s0,s1,s2,s3);
signal state: state_type;

-- for debugging state machine
signal state_code: std_logic_vector(1 downto 0);

Begin

--   Asynchronous Processes ------------------------------------------------------------------

state_code <= "00" when state = s0 else
                     "01" when state = s1 else
                     "10" when state = s2 else
                     "11";
-- Tx Control
HV_ON_HMC <= HV_ON_730;
FIL_ON_HMC <= FIL_ON_730;
-- SYNC_PULSE_HMC <= SYNC_PULSE;
SYNC_PULSE_HMC <= SYNC_PULSE;

-- Check key power supply voltages
CHECK_VOLT: process (EMS_PWR_ERROR)
	begin
		ems_pwr_ok <= NOT EMS_PWR_ERROR;
	end process;

-- Check wavequide switch position    NEED to account for switch delay (~100 msec) before reporting status 
CHECK_WG: process(WG_SW_TERM, WG_SW_NOISE, wg_dly, ops_mode, RESET, cmd_wg_sw_pos)
	begin
		if (RESET = '0') then
			wg_sw_pos <= '0';								-- assume waveguide switch is pointed into termination (normal ops)
			wg_stat <= '0'; 								-- bad status
			WG_SW_ERROR <= '0';							-- assume switch is not in error until we confirm where it is pointed
		elsif (wg_dly = '1') then
			if (ops_mode = "100" or ops_mode = "111")  then					-- Noise source cal or isolation test mode
				if (WG_SW_TERM ='1' AND WG_SW_NOISE = '0') then
					WG_SW_ERROR <= '0';
					wg_stat <= '1';						-- good status
					wg_sw_pos <= '1';
				else
					WG_SW_ERROR <= '1';
					wg_stat <= '0';						-- bad status
					wg_sw_pos <= '0';
				end if;
			else
				if (WG_SW_TERM ='0' AND WG_SW_NOISE = '1') then
					WG_SW_ERROR <= '0';
					wg_sw_pos <= '0';
					wg_stat <= '1';						-- good status					
				else
					WG_SW_ERROR <= '1';
					wg_stat <= '0';						-- bad status
					wg_sw_pos <= '1';
				end if;
		   end if;
			wg_change_state <= wg_sw_pos XOR cmd_wg_sw_pos;
		else													-- waveguide switch is in transition
			wg_sw_pos <= '0';
			wg_stat <= '0';								-- bad status; don't want to transmit in transition
			WG_SW_ERROR <= '0';							-- assume there is no error in transition
		end if;
	end process;

-- Force good waveguide switch status for now to aide in debug
--wg_stat <= '1';
--WG_SW_ERROR <= '0';
--wg_sw_pos <= cmd_wg_sw_pos;
--wg_dly <= '1';

-- Check EMS BIT
CHECK_BITE: process (BIT_EMS,ops_mode,wg_dly,pol_state)
begin
  if wg_dly = '1' then			-- Waveguide switch is not in transition
	case ops_mode is
		when "000" => -- horizontal transmit, receive both		
		-- Transmit
			if (BIT_EMS = "0101001") then
				ems_tx_stat <= '1';
			else
				ems_tx_stat <= '0';
			end if;
			if (BIT_EMS(1)) = '1' then
				ems_1_tx_stat <= '0';
			else
				ems_1_tx_stat <= '1';
			end if;
			if (BIT_EMS(2)) = '0' then
				ems_2_tx_stat <= '0';
			else
				ems_2_tx_stat <= '1';
			end if;
			if (BIT_EMS(3)) = '0' then
				ems_3_tx_stat <= '0';
			else
				ems_3_tx_stat <= '1';
			end if;
			if (BIT_EMS(5 downto 4)) = "01" then
				ems_45_tx_stat <= '0';
			else
				ems_45_tx_stat <= '1';
			end if;
			if (BIT_EMS(7 downto 6)) = "01" then
				ems_67_tx_stat <= '0';
			else
				ems_67_tx_stat <= '1';
			end if;
			
		-- Receive
			if (BIT_EMS = "1010010") then
				ems_rx_stat <= '1';
			else
				ems_rx_stat <= '0';
			end if;
			if (BIT_EMS(1)) = '0' then
				ems_1_rx_stat <= '0';
			else
				ems_1_rx_stat <= '1';
			end if;
			if (BIT_EMS(2)) = '1' then
				ems_2_rx_stat <= '0';
			else
				ems_2_rx_stat <= '1';
			end if;
			if (BIT_EMS(3)) = '0' then
				ems_3_rx_stat <= '0';
			else
				ems_3_rx_stat <= '1';
			end if;
			if (BIT_EMS(5 downto 4)) = "10" then
				ems_45_rx_stat <= '0';
			else
				ems_45_rx_stat <= '1';
			end if;
			if (BIT_EMS(7 downto 6)) = "10" then
				ems_67_rx_stat <= '0';
			else
				ems_67_rx_stat <= '1';
			end if;				
		when "001" => -- vertical transmit, receive both		
		-- Transmit
			if (BIT_EMS = "0101110") then
				ems_tx_stat <= '1';
			else
				ems_tx_stat <= '0';
			end if;
			if (BIT_EMS(1)) = '0' then
				ems_1_tx_stat <= '0';
			else
				ems_1_tx_stat <= '1';
			end if;
			if (BIT_EMS(2)) = '1' then
				ems_2_tx_stat <= '0';
			else
				ems_2_tx_stat <= '1';
			end if;
			if (BIT_EMS(3)) = '1' then
				ems_3_tx_stat <= '0';
			else
				ems_3_tx_stat <= '1';
			end if;
			if (BIT_EMS(5 downto 4)) = "01" then
				ems_45_tx_stat <= '0';
			else
				ems_45_tx_stat <= '1';
			end if;
			if (BIT_EMS(7 downto 6)) = "01" then
				ems_67_tx_stat <= '0';
			else
				ems_67_tx_stat <= '1';
			end if;
			
		-- Receive
			if (BIT_EMS = "1010011") then
				ems_rx_stat <= '1';
			else
				ems_rx_stat <= '0';
			end if;
			if (BIT_EMS(1)) = '1' then
				ems_1_rx_stat <= '0';
			else
				ems_1_rx_stat <= '1';
			end if;
			if (BIT_EMS(2)) = '1' then
				ems_2_rx_stat <= '0';
			else
				ems_2_rx_stat <= '1';
			end if;
			if (BIT_EMS(3)) = '0' then
				ems_3_rx_stat <= '0';
			else
				ems_3_rx_stat <= '1';
			end if;
			if (BIT_EMS(5 downto 4)) = "10" then
				ems_45_rx_stat <= '0';
			else
				ems_45_rx_stat <= '1';
			end if;
			if (BIT_EMS(7 downto 6)) = "10" then
				ems_67_rx_stat <= '0';
			else
				ems_67_rx_stat <= '1';
			end if;		

		when "010" => -- HHVV transmit, receive both		
		-- Transmit 
			case pol_state is
				when "00" => -- H transmit
					if (BIT_EMS = "0101001") then
						ems_tx_stat <= '1';
					else
						ems_tx_stat <= '0';
					end if;
					if (BIT_EMS(1)) = '1' then
						ems_1_tx_stat <= '0';
					else
						ems_1_tx_stat <= '1';
					end if;
					if (BIT_EMS(2)) = '0' then
						ems_2_tx_stat <= '0';
					else
						ems_2_tx_stat <= '1';
					end if;
					if (BIT_EMS(3)) = '0' then
						ems_3_tx_stat <= '0';
					else
						ems_3_tx_stat <= '1';
					end if;
					if (BIT_EMS(5 downto 4)) = "01" then
						ems_45_tx_stat <= '0';
					else
						ems_45_tx_stat <= '1';
					end if;
					if (BIT_EMS(7 downto 6)) = "01" then
						ems_67_tx_stat <= '0';
					else
						ems_67_tx_stat <= '1';
					end if;
			
		-- Receive
					if (BIT_EMS = "1010010") then
						ems_rx_stat <= '1';
					else
						ems_rx_stat <= '0';
					end if;
					if (BIT_EMS(1)) = '0' then
						ems_1_rx_stat <= '0';
					else
						ems_1_rx_stat <= '1';
					end if;
					if (BIT_EMS(2)) = '1' then
						ems_2_rx_stat <= '0';
					else
						ems_2_rx_stat <= '1';
					end if;
					if (BIT_EMS(3)) = '0' then
						ems_3_rx_stat <= '0';
					else
						ems_3_rx_stat <= '1';
					end if;
					if (BIT_EMS(5 downto 4)) = "10" then
						ems_45_rx_stat <= '0';
					else
						ems_45_rx_stat <= '1';
					end if;
					if (BIT_EMS(7 downto 6)) = "10" then
						ems_67_rx_stat <= '0';
					else
						ems_67_rx_stat <= '1';
					end if;
				when "01" => -- H transmit
					if (BIT_EMS = "0101001") then
						ems_tx_stat <= '1';
					else
						ems_tx_stat <= '0';
					end if;
					if (BIT_EMS(1)) = '1' then
						ems_1_tx_stat <= '0';
					else
						ems_1_tx_stat <= '1';
					end if;
					if (BIT_EMS(2)) = '0' then
						ems_2_tx_stat <= '0';
					else
						ems_2_tx_stat <= '1';
					end if;
					if (BIT_EMS(3)) = '0' then
						ems_3_tx_stat <= '0';
					else
						ems_3_tx_stat <= '1';
					end if;
					if (BIT_EMS(5 downto 4)) = "01" then
						ems_45_tx_stat <= '0';
					else
						ems_45_tx_stat <= '1';
					end if;
					if (BIT_EMS(7 downto 6)) = "01" then
						ems_67_tx_stat <= '0';
					else
						ems_67_tx_stat <= '1';
					end if;
			
		-- Receive
					if (BIT_EMS = "1010010") then
						ems_rx_stat <= '1';
					else
						ems_rx_stat <= '0';
					end if;
					if (BIT_EMS(1)) = '0' then
						ems_1_rx_stat <= '0';
					else
						ems_1_rx_stat <= '1';
					end if;
					if (BIT_EMS(2)) = '1' then
						ems_2_rx_stat <= '0';
					else
						ems_2_rx_stat <= '1';
					end if;
					if (BIT_EMS(3)) = '0' then
						ems_3_rx_stat <= '0';
					else
						ems_3_rx_stat <= '1';
					end if;
					if (BIT_EMS(5 downto 4)) = "10" then
						ems_45_rx_stat <= '0';
					else
						ems_45_rx_stat <= '1';
					end if;
					if (BIT_EMS(7 downto 6)) = "10" then
						ems_67_rx_stat <= '0';
					else
						ems_67_rx_stat <= '1';
					end if;
				when "10" => -- V transmit
		-- Transmit
					if (BIT_EMS = "0101110") then
						ems_tx_stat <= '1';
					else
						ems_tx_stat <= '0';
					end if;
					if (BIT_EMS(1)) = '0' then
						ems_1_tx_stat <= '0';
					else
						ems_1_tx_stat <= '1';
					end if;
					if (BIT_EMS(2)) = '1' then
						ems_2_tx_stat <= '0';
					else
						ems_2_tx_stat <= '1';
					end if;
					if (BIT_EMS(3)) = '1' then
						ems_3_tx_stat <= '0';
					else
						ems_3_tx_stat <= '1';
					end if;
					if (BIT_EMS(5 downto 4)) = "01" then
						ems_45_tx_stat <= '0';
					else
						ems_45_tx_stat <= '1';
					end if;
					if (BIT_EMS(7 downto 6)) = "01" then
						ems_67_tx_stat <= '0';
					else
						ems_67_tx_stat <= '1';
					end if;
			
		-- Receive
					if (BIT_EMS = "1010011") then
						ems_rx_stat <= '1';
					else
						ems_rx_stat <= '0';
					end if;
					if (BIT_EMS(1)) = '1' then
						ems_1_rx_stat <= '0';
					else
						ems_1_rx_stat <= '1';
					end if;
					if (BIT_EMS(2)) = '1' then
						ems_2_rx_stat <= '0';
					else
						ems_2_rx_stat <= '1';
					end if;
					if (BIT_EMS(3)) = '0' then
						ems_3_rx_stat <= '0';
					else
						ems_3_rx_stat <= '1';
					end if;
					if (BIT_EMS(5 downto 4)) = "10" then
						ems_45_rx_stat <= '0';
					else
						ems_45_rx_stat <= '1';
					end if;
					if (BIT_EMS(7 downto 6)) = "10" then
						ems_67_rx_stat <= '0';
					else
						ems_67_rx_stat <= '1';
					end if;		
				when "11" => -- V transmit
		-- Transmit
					if (BIT_EMS = "0101110") then
						ems_tx_stat <= '1';
					else
						ems_tx_stat <= '0';
					end if;
					if (BIT_EMS(1)) = '0' then
						ems_1_tx_stat <= '0';
					else
						ems_1_tx_stat <= '1';
					end if;
					if (BIT_EMS(2)) = '1' then
						ems_2_tx_stat <= '0';
					else
						ems_2_tx_stat <= '1';
					end if;
					if (BIT_EMS(3)) = '1' then
						ems_3_tx_stat <= '0';
					else
						ems_3_tx_stat <= '1';
					end if;
					if (BIT_EMS(5 downto 4)) = "01" then
						ems_45_tx_stat <= '0';
					else
						ems_45_tx_stat <= '1';
					end if;
					if (BIT_EMS(7 downto 6)) = "01" then
						ems_67_tx_stat <= '0';
					else
						ems_67_tx_stat <= '1';
					end if;
			
		-- Receive
					if (BIT_EMS = "1010011") then
						ems_rx_stat <= '1';
					else
						ems_rx_stat <= '0';
					end if;
					if (BIT_EMS(1)) = '1' then
						ems_1_rx_stat <= '0';
					else
						ems_1_rx_stat <= '1';
					end if;
					if (BIT_EMS(2)) = '1' then
						ems_2_rx_stat <= '0';
					else
						ems_2_rx_stat <= '1';
					end if;
					if (BIT_EMS(3)) = '0' then
						ems_3_rx_stat <= '0';
					else
						ems_3_rx_stat <= '1';
					end if;
					if (BIT_EMS(5 downto 4)) = "10" then
						ems_45_rx_stat <= '0';
					else
						ems_45_rx_stat <= '1';
					end if;
					if (BIT_EMS(7 downto 6)) = "10" then
						ems_67_rx_stat <= '0';
					else
						ems_67_rx_stat <= '1';
					end if;
				when others =>
				end case;

		when "011" => -- Corner reflector horizontal transmit, receive both		
		-- Transmit
			if (BIT_EMS = "0101001") then
				ems_tx_stat <= '1';
			else
				ems_tx_stat <= '0';
			end if;
			if (BIT_EMS(1)) = '1' then
				ems_1_tx_stat <= '0';
			else
				ems_1_tx_stat <= '1';
			end if;
			if (BIT_EMS(2)) = '0' then
				ems_2_tx_stat <= '0';
			else
				ems_2_tx_stat <= '1';
			end if;
			if (BIT_EMS(3)) = '0' then
				ems_3_tx_stat <= '0';
			else
				ems_3_tx_stat <= '1';
			end if;
			if (BIT_EMS(5 downto 4)) = "01" then
				ems_45_tx_stat <= '0';
			else
				ems_45_tx_stat <= '1';
			end if;
			if (BIT_EMS(7 downto 6)) = "01" then
				ems_67_tx_stat <= '0';
			else
				ems_67_tx_stat <= '1';
			end if;
			
		-- Receive
			if (BIT_EMS = "0000010") then
				ems_rx_stat <= '1';
			else
				ems_rx_stat <= '0';
			end if;
			if (BIT_EMS(1)) = '0' then
				ems_1_rx_stat <= '0';
			else
				ems_1_rx_stat <= '1';
			end if;
			if (BIT_EMS(2)) = '1' then
				ems_2_rx_stat <= '0';
			else
				ems_2_rx_stat <= '1';
			end if;
			if (BIT_EMS(3)) = '0' then
				ems_3_rx_stat <= '0';
			else
				ems_3_rx_stat <= '1';
			end if;
			if (BIT_EMS(5 downto 4)) = "00" then
				ems_45_rx_stat <= '0';
			else
				ems_45_rx_stat <= '1';
			end if;
			if (BIT_EMS(7 downto 6)) = "00" then
				ems_67_rx_stat <= '0';
			else
				ems_67_rx_stat <= '1';
			end if;				
			
		when "100" => -- Noise source cal, no tx
		-- Transmit
			if (BIT_EMS = "0101101") then
				ems_tx_stat <= '1';
			else
				ems_tx_stat <= '0';
			end if;
			if (BIT_EMS(1)) = '1' then
				ems_1_tx_stat <= '0';
			else
				ems_1_tx_stat <= '1';
			end if;
			if (BIT_EMS(2)) = '0' then
				ems_2_tx_stat <= '0';
			else
				ems_2_tx_stat <= '1';
			end if;
			if (BIT_EMS(3)) = '1' then
				ems_3_tx_stat <= '0';
			else
				ems_3_tx_stat <= '1';
			end if;
			if (BIT_EMS(5 downto 4)) = "01" then
				ems_45_tx_stat <= '0';
			else
				ems_45_tx_stat <= '1';
			end if;
			if (BIT_EMS(7 downto 6)) = "01" then
				ems_67_tx_stat <= '0';
			else
				ems_67_tx_stat <= '1';
			end if;						
		-- Receive
			if (BIT_EMS = "0101101") then
				ems_rx_stat <= '1';
			else
				ems_rx_stat <= '0';
			end if;
			if (BIT_EMS(1)) = '1' then
				ems_1_rx_stat <= '0';
			else
				ems_1_rx_stat <= '1';
			end if;
			if (BIT_EMS(2)) = '0' then
				ems_2_rx_stat <= '0';
			else
				ems_2_rx_stat <= '1';
			end if;
			if (BIT_EMS(3)) = '1' then
				ems_3_rx_stat <= '0';
			else
				ems_3_rx_stat <= '1';
			end if;
			if (BIT_EMS(5 downto 4)) = "01" then
				ems_45_rx_stat <= '0';
			else
				ems_45_rx_stat <= '1';
			end if;
			if (BIT_EMS(7 downto 6)) = "01" then
				ems_67_rx_stat <= '0';
			else
				ems_67_rx_stat <= '1';
			end if;					
		when "101" =>	-- Corner reflector cal, vertical tx w/increased NF
		-- Transmit
			if (BIT_EMS = "0101110") then
				ems_tx_stat <= '1';
			else
				ems_tx_stat <= '0';
			end if;
			if (BIT_EMS(1)) = '0' then
				ems_1_tx_stat <= '0';
			else
				ems_1_tx_stat <= '1';
			end if;
			if (BIT_EMS(2)) = '1' then
				ems_2_tx_stat <= '0';
			else
				ems_2_tx_stat <= '1';
			end if;
			if (BIT_EMS(3)) = '1' then
				ems_3_tx_stat <= '0';
			else
				ems_3_tx_stat <= '1';
			end if;
			if (BIT_EMS(5 downto 4)) = "01" then
				ems_45_tx_stat <= '0';
			else
				ems_45_tx_stat <= '1';
			end if;
			if (BIT_EMS(7 downto 6)) = "01" then
				ems_67_tx_stat <= '0';
			else
				ems_67_tx_stat <= '1';
			end if;						
		-- Receive
			if (BIT_EMS = "0000011") then
				ems_rx_stat <= '1';
			else
				ems_rx_stat <= '0';
			end if;	
			if (BIT_EMS(1)) = '1' then
				ems_1_rx_stat <= '0';
			else
				ems_1_rx_stat <= '1';
			end if;
			if (BIT_EMS(2)) = '1' then
				ems_2_rx_stat <= '0';
			else
				ems_2_rx_stat <= '1';
			end if;
			if (BIT_EMS(3)) = '0' then
				ems_3_rx_stat <= '0';
			else
				ems_3_rx_stat <= '1';
			end if;
			if (BIT_EMS(5 downto 4)) = "00" then
				ems_45_rx_stat <= '0';
			else
				ems_45_rx_stat <= '1';
			end if;
			if (BIT_EMS(7 downto 6)) = "00" then
				ems_67_rx_stat <= '0';
			else
				ems_67_rx_stat <= '1';
			end if;						
		when "110" => 	-- Test Mode, no tx
		-- Transmit
			if (BIT_EMS = "0101110") then
				ems_tx_stat <= '1';
			else
				ems_tx_stat <= '0';
			end if;
			if (BIT_EMS(1)) = '0' then
				ems_1_tx_stat <= '0';
			else
				ems_1_tx_stat <= '1';
			end if;
			if (BIT_EMS(2)) = '1' then
				ems_2_tx_stat <= '0';
			else
				ems_2_tx_stat <= '1';
			end if;
			if (BIT_EMS(3)) = '1' then
				ems_3_tx_stat <= '0';
			else
				ems_3_tx_stat <= '1';
			end if;
			if (BIT_EMS(5 downto 4)) = "01" then
				ems_45_tx_stat <= '0';
			else
				ems_45_tx_stat <= '1';
			end if;
			if (BIT_EMS(7 downto 6)) = "01" then
				ems_67_tx_stat <= '0';
			else
				ems_67_tx_stat <= '1';
			end if;						
		-- Receive
			if (BIT_EMS = "1010011") then
				ems_rx_stat <= '1';
			else
				ems_rx_stat <= '0';
			end if;
			if (BIT_EMS(1)) = '1' then
				ems_1_rx_stat <= '0';
			else
				ems_1_rx_stat <= '1';
			end if;
			if (BIT_EMS(2)) = '1' then
				ems_2_rx_stat <= '0';
			else
				ems_2_rx_stat <= '1';
			end if;
			if (BIT_EMS(3)) = '0' then
				ems_3_rx_stat <= '0';
			else
				ems_3_rx_stat <= '1';
			end if;
			if (BIT_EMS(5 downto 4)) = "10" then
				ems_45_rx_stat <= '0';
			else
				ems_45_rx_stat <= '1';
			end if;
			if (BIT_EMS(7 downto 6)) = "10" then
				ems_67_rx_stat <= '0';
			else
				ems_67_rx_stat <= '1';
			end if;
when "111" => -- vertical transmit, receive both, but enable noise source for testing		
		-- Transmit
			if (BIT_EMS = "0101110") then
				ems_tx_stat <= '1';
			else
				ems_tx_stat <= '0';
			end if;
			if (BIT_EMS(1)) = '0' then
				ems_1_tx_stat <= '0';
			else
				ems_1_tx_stat <= '1';
			end if;
			if (BIT_EMS(2)) = '1' then
				ems_2_tx_stat <= '0';
			else
				ems_2_tx_stat <= '1';
			end if;
			if (BIT_EMS(3)) = '1' then
				ems_3_tx_stat <= '0';
			else
				ems_3_tx_stat <= '1';
			end if;
			if (BIT_EMS(5 downto 4)) = "01" then
				ems_45_tx_stat <= '0';
			else
				ems_45_tx_stat <= '1';
			end if;
			if (BIT_EMS(7 downto 6)) = "01" then
				ems_67_tx_stat <= '0';
			else
				ems_67_tx_stat <= '1';
			end if;
			
		-- Receive
			if (BIT_EMS = "1010011") then
				ems_rx_stat <= '1';
			else
				ems_rx_stat <= '0';
			end if;
			if (BIT_EMS(1)) = '1' then
				ems_1_rx_stat <= '0';
			else
				ems_1_rx_stat <= '1';
			end if;
			if (BIT_EMS(2)) = '1' then
				ems_2_rx_stat <= '0';
			else
				ems_2_rx_stat <= '1';
			end if;
			if (BIT_EMS(3)) = '0' then
				ems_3_rx_stat <= '0';
			else
				ems_3_rx_stat <= '1';
			end if;
			if (BIT_EMS(5 downto 4)) = "10" then
				ems_45_rx_stat <= '0';
			else
				ems_45_rx_stat <= '1';
			end if;
			if (BIT_EMS(7 downto 6)) = "10" then
				ems_67_rx_stat <= '0';
			else
				ems_67_rx_stat <= '1';
			end if;					
		when others =>   -- default bad status for all
			ems_tx_stat <= '0';
			ems_rx_stat <= '0';
			ems_1_tx_stat <= '1';
			ems_2_tx_stat <= '1';
			ems_3_tx_stat <= '1';
			ems_45_tx_stat <= '1';
			ems_67_tx_stat <= '1';
			ems_1_rx_stat <= '1';
			ems_2_rx_stat <= '1';
			ems_3_rx_stat <= '1';
			ems_45_rx_stat <= '1';
			ems_67_rx_stat <= '1';						
		end case;
	else									-- Waveguide switch is in transition
		ems_tx_stat <= '1';  		-- report good status for all ems switches during waveguide switch transition
		ems_rx_stat <= '1';  		
		ems_1_tx_stat <= '0';		 
		ems_2_tx_stat <= '0';
		ems_3_tx_stat <= '0';
		ems_45_tx_stat <= '0';
		ems_67_tx_stat <= '0';
		ems_1_rx_stat <= '0';
		ems_2_rx_stat <= '0';
		ems_3_rx_stat <= '0';
		ems_45_rx_stat <= '0';
		ems_67_rx_stat <= '0';
end if;		
end process;

-- Assign test signals to SPARE outputs for debug


	SPARE1 <= hv_flag;
--	SPARE1 <= wg_dly;
----	SPARE2 <= tx_dly;
----	SPARE3 <= rx_dly;
--	SPARE2 <= wg_stat;
--	SPARE3 <= wg_sw_pos;

--	SPARE1 <= HV_ON_730;
	SPARE2 <= state_code(0);
	SPARE3 <= state_code(1);
	


--	SPARE4 <= ems_tx_stat;
--	SPARE5 <= ems_tx_ok;
--	SPARE6 <= end_cycle;
--	SPARE7 <= ems_pwr_ok;
	SPARE_STATUS0 <= TEST_BIT_0;
	SPARE_STATUS1 <= TEST_BIT_1;
	
--- End Asychronous Processes --------------------------------------------------------------------

-- Synchronous Processes -------------------------------------------------------------------------

-- Update EMS switch status
EMS_ERROR_1 <= ems_1_error;
EMS_ERROR_2 <= ems_2_error;
EMS_ERROR_3 <= ems_3_error;
EMS_ERROR_45 <= ems_45_error;
EMS_ERROR_67 <= ems_67_error;			


-- Latch OPS_MODE
SET_OPS_MODE: process (EXT_CLK, RESET, OPS_MODE_730, ops_mode_en)
begin
	if (RESET = '0') then
		ops_mode <= "110";	-- default to bench test
	elsif (rising_edge (EXT_CLK)) then
		if ops_mode_en = '1' then
			ops_mode <= OPS_MODE_730;
		else
			ops_mode <= ops_mode;
		end if;
	end if;
end process;

-- Latch EMS delays
LATCH_DLY: process (EXT_CLK, RESET, tx_dly, rx_dly)
begin
	if (RESET = '0') then
		l_tx_dly <= '0';
		l_rx_dly <= '0';
	elsif (rising_edge (EXT_CLK)) then
		l_tx_dly <= tx_dly;
		l_rx_dly <= rx_dly;
	end if;
end process;

-- Update EMS status when BIT is valid
EMS_STAT: process (EXT_CLK, RESET)
begin
	if (RESET = '0') then
		ems_tx_ok <= '1';
		ems_rx_ok <= '1';
		ems_1_error <= '0';
		ems_2_error <= '0';
		ems_3_error <= '0';
		ems_45_error <= '0';
		ems_67_error <= '0';
		ems_tx_error <= '0';
		mod_pulse_error <= '0';

	elsif (rising_edge (EXT_CLK)) then
		ems_tx_ok <= ((NOT l_tx_dly AND tx_dly AND ems_tx_stat) OR ems_tx_ok) AND NOT end_cycle;

		ems_1_error <= (((NOT l_tx_dly AND tx_dly AND ems_1_tx_stat) OR ems_1_error) AND NOT STATUS_ACK) OR 
							(((NOT l_rx_dly AND rx_dly AND ems_1_rx_stat) OR ems_1_error) AND NOT STATUS_ACK);
		ems_2_error <= (((NOT l_tx_dly AND tx_dly AND ems_2_tx_stat) OR ems_2_error) AND NOT STATUS_ACK) OR 
							(((NOT l_rx_dly AND rx_dly AND ems_2_rx_stat) OR ems_2_error) AND NOT STATUS_ACK);
		ems_3_error <= (((NOT l_tx_dly AND tx_dly AND ems_3_tx_stat) OR ems_3_error) AND NOT STATUS_ACK) OR 
							(((NOT l_rx_dly AND rx_dly AND ems_3_rx_stat) OR ems_3_error) AND NOT STATUS_ACK);
		ems_45_error <= (((NOT l_tx_dly AND tx_dly AND ems_45_tx_stat) OR ems_45_error) AND NOT STATUS_ACK) OR 
							(((NOT l_rx_dly AND rx_dly AND ems_45_rx_stat) OR ems_45_error) AND NOT STATUS_ACK);
		ems_67_error <= (((NOT l_tx_dly AND tx_dly AND ems_67_tx_stat) OR ems_67_error) AND NOT STATUS_ACK) OR 
							(((NOT l_rx_dly AND rx_dly AND ems_67_rx_stat) OR ems_67_error) AND NOT STATUS_ACK);
		ems_tx_error <= (((NOT l_tx_dly AND tx_dly AND NOT ems_tx_stat) OR ems_tx_error) AND NOT STATUS_ACK);
							
		ems_rx_ok <= ((NOT l_rx_dly AND rx_dly AND ems_rx_stat) OR ems_rx_ok) AND NOT end_cycle;
		
		mod_pulse_error <= (NOT (ems_pwr_ok AND NOT ems_tx_error) OR mod_pulse_error) AND NOT STATUS_ACK;
	end if;
end process;

CHECK_MOD_PULSE: process (ops_mode,mod_pulse_error)
begin
	case ops_mode is
		when "110" =>				-- Test mode, no mod_pulse generated
			MOD_PULSE_DISABLE <= '1';
		when "100" =>				-- Noise source cal, no mod_pulse generated
				MOD_PULSE_DISABLE <= '1';
		when "111" =>				-- Noise source isolation test, no mod_pulse generated
				MOD_PULSE_DISABLE <= '1';				
		when others =>
				MOD_PULSE_DISABLE <= mod_pulse_error;
		end case;
end process;

EMS_PRT: process (EXT_CLK, RESET)
begin
	if (RESET = '0') then
		ems_error_prt <= '0';

	elsif (rising_edge (EXT_CLK)) then

		ems_error_prt <= (((NOT l_tx_dly AND tx_dly AND NOT ems_tx_stat) OR ems_error_prt) AND NOT end_cycle) OR 
							(((NOT l_rx_dly AND rx_dly AND NOT ems_rx_stat) OR ems_error_prt) AND NOT end_cycle);
							
	end if;
end process;


EMS_ERROR_EVENT <= ems_error_prt;  -- reports a maximum of one event per PRT
	
-- Sets 1 second safety delay from HV_ON to enabling transmit triggers				
DELAY_1SEC: process (EXT_CLK, RESET, HV_ON_730)
begin 
	if (RESET = '0') then
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

-- Delay for 1 second while Pentek initializes, then enable U6; ohterwise, Pentek isn't discovered on PCI bus!
-- This is a mystery, but haven't sufficient documentation on Pentek to sort it out.
DELAY_U6_ENABLE: process (EXT_CLK, RESET)
begin 
	if (RESET = '0') then
      U6_count <= "000000000000000000000000";
		U6_dly <= '0';
		U6_count_enable <= '1';	
   elsif (rising_edge (EXT_CLK)) then				
		if(U6_count = "111100000000000000000000") then -- ~1sec delay
			U6_count <= "000000000000000000000000";
			U6_count_enable <= '0';
			U6_dly <= '1';
		elsif (U6_count_enable = '1') then	
			U6_count <= U6_count + 1;
		else	
			U6_count <= "000000000000000000000000";
			U6_dly <= '1';
			U6_count_enable <= '0';
		end if;
	end if;
end process;

U6_OE <= NOT U6_dly;
	
-- Sets 100 millisecond safety delay from waveguide switch command to switch in position				
DELAY_100MSEC: process (EXT_CLK, RESET)
begin 
	if (RESET = '0') then
      wg_count <= "000000000000000000000";
		wg_dly <= '0';
		wg_count_enable <= '1';	
   elsif (rising_edge (EXT_CLK)) then				
		if (wg_change_state = '1') then 		-- waveguide switch is commanded to move
			if(wg_count = "101111101011110000011") then 	-- ~100 millisec delay
				wg_count <= "000000000000000000000";
				wg_count_enable <= '0';
				wg_dly <= '1';
			elsif (wg_count_enable = '1') then	
				wg_count <= wg_count + 1;
				wg_dly <= '0';
			end if;
		else	
				wg_count <= "000000000000000000000";
				wg_dly <= '1';
				wg_count_enable <= '1';
		end if;
	end if;
end process;


-- Generate registered EMS_TRIG
LATCH_EMS_TRIG: process (EXT_CLK, RESET, EMS_TRIG)
begin
	if (RESET = '0') then
		l_ems_trig <= '0';
	elsif (rising_edge (EXT_CLK)) then
		l_ems_trig <= EMS_TRIG;
	end if;
end process;	

-- Generate EMS Transmit and Receive BIT count enables
EMS_CNT_EN: process (EXT_CLK, RESET, EMS_TRIG, l_ems_trig)
begin
	if (RESET = '0') then
      ems_tx_count_enable <= '0';
		ems_rx_count_enable <= '0';
	elsif (rising_edge (EXT_CLK)) then
		ems_tx_count_enable <= ((EMS_TRIG AND NOT l_ems_trig) OR ems_tx_count_enable) AND NOT end_cycle; -- rising edge of EMS_TRIG
		ems_rx_count_enable <= ((NOT EMS_TRIG AND l_ems_trig) OR ems_rx_count_enable) AND NOT end_cycle; -- falling edge of EMS_TRIG
	end if;
end process;
	
-- Sets delay from EMS switch trigger to EMS switch BIT valid on transmit
EMS_TX_DELAY: process (EXT_CLK, RESET, ems_tx_count_enable)
begin 
	if (RESET = '0') then
      ems_tx_count <= "00000";
		tx_dly <= '0';	
   elsif (rising_edge (EXT_CLK)) then				
		if (ems_tx_count_enable = '1') then
			if(ems_tx_count = "100") then 
				ems_tx_count <= "00000";
				tx_dly <= '1';
			else
				ems_tx_count <= ems_tx_count + 1;
			end if;
		else	
				ems_tx_count <= "00000";
				tx_dly <= '0';
		end if;
	end if;
end process;

-- Sets delay from EMS switch trigger to EMS switch BIT valid on receive
EMS_RX_DELAY: process (EXT_CLK, RESET, ems_rx_count_enable)
begin 
	if (RESET = '0') then
      ems_rx_count <= "00000";
		rx_dly <= '0';	
   elsif (rising_edge (EXT_CLK)) then				
		if (ems_rx_count_enable = '1') then
			if(ems_rx_count = "100") then 
				ems_rx_count <= "00000";
				rx_dly <= '1';
			else
				ems_rx_count <= ems_rx_count + 1;
			end if;
		else	
				ems_rx_count <= "00000";
				rx_dly <= '0';
		end if;
	end if;
end process;

-- Defines cycle over which State Machine operates
CYCLE: process (EXT_CLK, RESET, RX_GATE, l_rx_gate)
begin
	if (RESET = '0') then
      end_cycle <= '0';
		l_rx_gate <= '0';
   elsif (rising_edge (EXT_CLK)) then
		l_rx_gate <= RX_GATE;
		end_cycle <= l_rx_gate AND NOT RX_GATE;  -- end cycle on falling edge of rx_gate!
	end if;
end process;

HHVV: process (EXT_CLK, RESET, end_cycle, ops_mode)
begin
	if (RESET = '0') then
      pol_state <= "11";	-- initial polarization state := V tx
   elsif (rising_edge (EXT_CLK)) then
		if (ops_mode = "010" AND end_cycle = '1') then
			pol_state <= pol_state + 1;  -- cycle through polarization states
		end if;
	end if;
end process;
------------------------ End Sychronous Processes ----------------------------------------------------

------------------------ State Machine ----------------------------------------------------------------

STATE_MACHINE: process (RESET,EXT_CLK)
begin
	if (RESET = '0') then
		state <= s0;
	elsif (rising_edge (EXT_CLK)) then
		case state is
			when s0 =>
				if (ops_mode = "110" AND EMS_TRIG = '1' AND T0 = '1' AND tx_dly = '0' AND rx_dly = '0' AND ems_pwr_ok = '1' AND wg_stat = '1') then   -- Test Mode
					state <= s1;
				elsif (ops_mode = "100" AND EMS_TRIG = '1' AND T0 = '1' AND tx_dly = '0' AND rx_dly = '0' AND ems_pwr_ok = '1' AND wg_stat = '1') then   -- Noise source cal
					state <= s1;
				elsif (ops_mode = "111" AND EMS_TRIG = '1' AND T0 = '1' AND tx_dly = '0' AND rx_dly = '0' AND ems_pwr_ok = '1' AND wg_stat = '1') then   -- Noise source isolation test
					state <= s1;					
				elsif(EMS_TRIG = '1' AND T0 = '1' AND tx_dly = '0' AND rx_dly = '0' AND hv_dly = '1' AND ems_pwr_ok = '1' AND wg_stat = '1') then
					state <= s1;
				end if;		
			when s1 =>
				if (ops_mode = "110" AND ems_tx_ok = '1' AND rx_dly = '0' AND ems_pwr_ok = '1') then    -- Test Mode
					state <= s2;
				elsif (ops_mode = "100" AND ems_tx_ok = '1' AND rx_dly = '0' AND ems_pwr_ok = '1') then    -- Noise source cal
					state <= s2;
				elsif (ops_mode = "111" AND ems_tx_ok = '1' AND rx_dly = '0' AND ems_pwr_ok = '1') then    -- Noise source isolation test
					state <= s2;										
				elsif(ems_tx_ok = '1' AND rx_dly = '0' AND hv_dly = '1' AND ems_pwr_ok = '1') then
					state <= s2;
-----------------------------------------------------------------------------------------------------
--				WHY AREN'T ALL STATES COVERED HERE???

				elsif(ops_mode = "000" AND hv_dly = '0' AND rx_dly = '0' AND tx_dly = '1') then
					state <=s0;					
				elsif(ops_mode = "001" AND hv_dly = '0' AND rx_dly = '0' AND tx_dly = '1') then
					state <=s0;
				elsif(ops_mode = "010" AND hv_dly = '0' AND rx_dly = '0' AND tx_dly = '1') then
					state <=s0;					
				elsif(ops_mode = "011" AND hv_dly = '0' AND rx_dly = '0' AND tx_dly = '1') then
					state <=s0;										
				elsif(ops_mode = "101" AND hv_dly = '0' AND rx_dly = '0' AND tx_dly = '1') then
					state <=s0;
				end if;
				
-------------------------------------------------------------------------------------------------------------				
			when s2 =>
				if (ops_mode = "110" AND tx_dly = '1' AND ems_pwr_ok = '1') then  -- Test Mode
					state <= s3;
				elsif (ops_mode = "100" AND tx_dly = '1' AND ems_pwr_ok = '1') then  -- Noise source cal
					state <= s3;
				elsif (ops_mode = "111" AND tx_dly = '1' AND ems_pwr_ok = '1') then  -- Noise source isolation test
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
--				if(RX_GATE = '0' AND ems_tx_ok = '1' AND rx_dly = '0' AND tx_dly = '0') then
				if(RX_GATE = '0' AND rx_dly = '0' AND tx_dly = '0') then
					state <= s0;
				end if;
			when others =>
				state <= s0;
		end case;
	end if;
end process;

-- State Machine Ouputs

STATE_OUT: process (state,MOD_PULSE,EMS_TRIG,ops_mode,pol_state)
begin
	case state is
		when S0 => 			-- Reset State, ensure EMS switches transition each PRT
--			ops_mode <= OPS_MODE_730;
			ops_mode_en <= '1';
			MOD_PULSE_HMC <= '0';
			if (ops_mode = "100") then -- Noise source cal, no tx	
--				EMS_OUT <= "0101101";
				EMS_OUT <= "1010010";				
				WG_SW_CTRL_TERM <= '1';
				WG_SW_CTRL_NOISE <= '0';
				NOISE_SOURCE_EN <= '1';
				cmd_wg_sw_pos <= '1';
				
			elsif (ops_mode = "111") then -- Noise source isolation test			
				WG_SW_CTRL_TERM <= '1';
				WG_SW_CTRL_NOISE <= '0';
				NOISE_SOURCE_EN <= '1';
				cmd_wg_sw_pos <= '1';
				
			elsif (ops_mode = "000") then -- Horizontal tx, receive both
				EMS_OUT(3) <= '1';				
				WG_SW_CTRL_TERM <= '0';
				WG_SW_CTRL_NOISE <= '1';
				NOISE_SOURCE_EN <= '0';
				cmd_wg_sw_pos <= '0';

			elsif (ops_mode = "011") then -- Corner reflector cal, horizontal tx w/increased NF
				EMS_OUT(3) <= '1';		
				EMS_OUT(5) <= '1';
				EMS_OUT(7) <= '1';				
				WG_SW_CTRL_TERM <= '0';
				WG_SW_CTRL_NOISE <= '1';
				NOISE_SOURCE_EN <= '0';
				cmd_wg_sw_pos <= '0';				

			elsif (ops_mode = "101") then -- Corner reflector cal, vertical tx w/increased NF
				EMS_OUT(2) <= '0';
				EMS_OUT(5) <= '1';
				EMS_OUT(7) <= '1';				
				WG_SW_CTRL_TERM <= '0';
				WG_SW_CTRL_NOISE <= '1';
				NOISE_SOURCE_EN <= '0';
				cmd_wg_sw_pos <= '0';
			
			elsif (ops_mode = "010") then -- Alternating HHVV
				if (pol_state = "11") then -- V tx, receive both (initial HHVV state)
					EMS_OUT(2) <= '0';	
				elsif (pol_state = "00") then -- H tx, receive both
					EMS_OUT(1) <= '0';	
					EMS_OUT(3) <= '1';	
				elsif (pol_state = "01") then -- H tx, receive both
					EMS_OUT(3) <= '1';								
				elsif (pol_state = "10") then -- V tx, receive both
					EMS_OUT(1) <= '1';	
					EMS_OUT(2) <= '0';		
				end if;
				WG_SW_CTRL_TERM <= '0';
				WG_SW_CTRL_NOISE <= '1';
				NOISE_SOURCE_EN <= '0';
				cmd_wg_sw_pos <= '0';					
			else
				EMS_OUT <= "0000000";
				WG_SW_CTRL_TERM <= '0';
				WG_SW_CTRL_NOISE <= '1';
				NOISE_SOURCE_EN <= '0';
				cmd_wg_sw_pos <= '0';				
			end if;
		when S1 =>
			ops_mode_en <= '0';
			if (ops_mode = "000") then -- Horizontal tx, receive both
				MOD_PULSE_HMC <= '0';
				EMS_OUT(1) <= EMS_TRIG;
				EMS_OUT(2) <= NOT EMS_TRIG;
				EMS_OUT(3) <= '0';
				EMS_OUT(4) <= EMS_TRIG;
				EMS_OUT(5) <= NOT EMS_TRIG;
				EMS_OUT(6) <= EMS_TRIG;
				EMS_OUT(7) <= NOT EMS_TRIG;
				hv_flag <= '1';			-- Tx-H
				WG_SW_CTRL_TERM <= '0';
				WG_SW_CTRL_NOISE <= '1';
				NOISE_SOURCE_EN <= '0';
				cmd_wg_sw_pos <= '0';	
			elsif (ops_mode = "001") then -- Vertical tx, receive both
				MOD_PULSE_HMC <= '0';
				EMS_OUT(1) <= NOT EMS_TRIG;
				EMS_OUT(2) <= '1';
				EMS_OUT(3) <= EMS_TRIG;
				EMS_OUT(4) <= EMS_TRIG;
				EMS_OUT(5) <= NOT EMS_TRIG;
				EMS_OUT(6) <= EMS_TRIG;
				EMS_OUT(7) <= NOT EMS_TRIG;
				hv_flag <= '0';			-- Tx-V				
				WG_SW_CTRL_TERM <= '0';
				WG_SW_CTRL_NOISE <= '1';
				NOISE_SOURCE_EN <= '0';
				cmd_wg_sw_pos <= '0';					
			elsif (ops_mode = "010") then -- HHVV tx, receive both
			   if (pol_state = "00") then  -- transmit H
					MOD_PULSE_HMC <= '0';
					EMS_OUT(1) <= EMS_TRIG;
					EMS_OUT(2) <= NOT EMS_TRIG;
					EMS_OUT(3) <= '0';
					EMS_OUT(4) <= EMS_TRIG;
					EMS_OUT(5) <= NOT EMS_TRIG;
					EMS_OUT(6) <= EMS_TRIG;
					EMS_OUT(7) <= NOT EMS_TRIG;
					hv_flag <= '1';			-- H					
					WG_SW_CTRL_TERM <= '0';
					WG_SW_CTRL_NOISE <= '1';
					NOISE_SOURCE_EN <= '0';
					cmd_wg_sw_pos <= '0';
				elsif (pol_state = "01") then  -- transmit H
					MOD_PULSE_HMC <= '0';
					EMS_OUT(1) <= EMS_TRIG;
					EMS_OUT(2) <= NOT EMS_TRIG;
					EMS_OUT(3) <= '0';
					EMS_OUT(4) <= EMS_TRIG;
					EMS_OUT(5) <= NOT EMS_TRIG;
					EMS_OUT(6) <= EMS_TRIG;
					EMS_OUT(7) <= NOT EMS_TRIG;
					hv_flag <= '1';			-- H
					WG_SW_CTRL_TERM <= '0';
					WG_SW_CTRL_NOISE <= '1';
					NOISE_SOURCE_EN <= '0';
					cmd_wg_sw_pos <= '0';				
				elsif (pol_state = "10") then  -- transmit V
					MOD_PULSE_HMC <= '0';
					EMS_OUT(1) <= NOT EMS_TRIG;
					EMS_OUT(2) <= '1';
					EMS_OUT(3) <= EMS_TRIG;
					EMS_OUT(4) <= EMS_TRIG;
					EMS_OUT(5) <= NOT EMS_TRIG;
					EMS_OUT(6) <= EMS_TRIG;
					EMS_OUT(7) <= NOT EMS_TRIG;
					hv_flag <= '0';			-- V					
					WG_SW_CTRL_TERM <= '0';
					WG_SW_CTRL_NOISE <= '1';
					NOISE_SOURCE_EN <= '0';
					cmd_wg_sw_pos <= '0';										
				else									-- transmit V
					MOD_PULSE_HMC <= '0';
					EMS_OUT(1) <= NOT EMS_TRIG;
					EMS_OUT(2) <= '1';
					EMS_OUT(3) <= EMS_TRIG;
					EMS_OUT(4) <= EMS_TRIG;
					EMS_OUT(5) <= NOT EMS_TRIG;
					EMS_OUT(6) <= EMS_TRIG;
					EMS_OUT(7) <= NOT EMS_TRIG;
					hv_flag <= '0';			-- V					
					WG_SW_CTRL_TERM <= '0';
					WG_SW_CTRL_NOISE <= '1';
					NOISE_SOURCE_EN <= '0';
					cmd_wg_sw_pos <= '0';				
				end if;
			elsif (ops_mode = "011") then -- Corner reflector horizontal tx w/increased NF
				MOD_PULSE_HMC <= '0';
				EMS_OUT(1) <= EMS_TRIG;
				EMS_OUT(2) <= NOT EMS_TRIG;
				EMS_OUT(3) <= '0';
				EMS_OUT(4) <= EMS_TRIG;
				EMS_OUT(5) <= '0';
				EMS_OUT(6) <= EMS_TRIG;
				EMS_OUT(7) <= '0';
				hv_flag <= '1';			-- H
				WG_SW_CTRL_TERM <= '0';
				WG_SW_CTRL_NOISE <= '1';
				NOISE_SOURCE_EN <= '0';
				cmd_wg_sw_pos <= '0';	
			elsif (ops_mode = "100") then -- Noise source cal, no tx
				MOD_PULSE_HMC <= '0';
				EMS_OUT <= "0101101";
				WG_SW_CTRL_TERM <= '1';
				WG_SW_CTRL_NOISE <= '0';
				NOISE_SOURCE_EN <= '1';
				cmd_wg_sw_pos <= '1';
				hv_flag <= '0';			-- V
			elsif (ops_mode = "101") then -- Corner reflector cal, vertical tx w/increased NF
				MOD_PULSE_HMC <= '0';
				EMS_OUT(1) <= NOT EMS_TRIG;
				EMS_OUT(2) <= '1';
				EMS_OUT(3) <= EMS_TRIG;
				EMS_OUT(4) <= EMS_TRIG;
				EMS_OUT(5) <= '0';
				EMS_OUT(6) <= EMS_TRIG;
				EMS_OUT(7) <= '0';
				hv_flag <= '0';			-- V
				WG_SW_CTRL_TERM <= '0';
				WG_SW_CTRL_NOISE <= '1';
				NOISE_SOURCE_EN <= '0';
				cmd_wg_sw_pos <= '0';					
			elsif (ops_mode = "110") then -- Test Mode, no tx
				MOD_PULSE_HMC <= '0';
				EMS_OUT(1) <= NOT EMS_TRIG;
				EMS_OUT(2) <= '1';
				EMS_OUT(3) <= EMS_TRIG;
				EMS_OUT(4) <= EMS_TRIG;
				EMS_OUT(5) <= NOT EMS_TRIG;
				EMS_OUT(6) <= EMS_TRIG;
				EMS_OUT(7) <= NOT EMS_TRIG;
				hv_flag <= '0';			-- V
				WG_SW_CTRL_TERM <= '0';
				WG_SW_CTRL_NOISE <= '1';
				NOISE_SOURCE_EN <= '0';
				cmd_wg_sw_pos <= '0';
			elsif (ops_mode = "111") then -- Vertical tx, receive both, enable noise source for testing
				MOD_PULSE_HMC <= '0';
				EMS_OUT(1) <= NOT EMS_TRIG;
				EMS_OUT(2) <= '1';
				EMS_OUT(3) <= EMS_TRIG;
				EMS_OUT(4) <= EMS_TRIG;
				EMS_OUT(5) <= NOT EMS_TRIG;
				EMS_OUT(6) <= EMS_TRIG;
				EMS_OUT(7) <= NOT EMS_TRIG;
				hv_flag <= '0';			-- V				
				WG_SW_CTRL_TERM <= '1';
				WG_SW_CTRL_NOISE <= '0';
				NOISE_SOURCE_EN <= '1';
				cmd_wg_sw_pos <= '1';									
			else
				MOD_PULSE_HMC <= '0';
				EMS_OUT <= "0000000";
				WG_SW_CTRL_TERM <= '0';
				WG_SW_CTRL_NOISE <= '1';
				NOISE_SOURCE_EN <= '0';
				cmd_wg_sw_pos <= '0';
				hv_flag <= '1';			-- H				
			end if;
		when S2 =>
			ops_mode_en <= '0';
			if (ops_mode = "000") then -- Horizontal tx, receive both
				MOD_PULSE_HMC <= MOD_PULSE;
				EMS_OUT(1) <= EMS_TRIG;
				EMS_OUT(2) <= NOT EMS_TRIG;
				EMS_OUT(3) <= '0';
				EMS_OUT(4) <= EMS_TRIG;
				EMS_OUT(5) <= NOT EMS_TRIG;
				EMS_OUT(6) <= EMS_TRIG;
				EMS_OUT(7) <= NOT EMS_TRIG;
				WG_SW_CTRL_TERM <= '0';
				WG_SW_CTRL_NOISE <= '1';
				NOISE_SOURCE_EN <= '0';
				cmd_wg_sw_pos <= '0';			
			elsif (ops_mode = "001") then -- Vertical tx, receive both	
				MOD_PULSE_HMC <= MOD_PULSE;
				EMS_OUT(1) <= NOT EMS_TRIG;
				EMS_OUT(2) <= '1';
				EMS_OUT(3) <= EMS_TRIG;
				EMS_OUT(4) <= EMS_TRIG;
				EMS_OUT(5) <= NOT EMS_TRIG;
				EMS_OUT(6) <= EMS_TRIG;
				EMS_OUT(7) <= NOT EMS_TRIG;
				WG_SW_CTRL_TERM <= '0';
				WG_SW_CTRL_NOISE <= '1';
				NOISE_SOURCE_EN <= '0';
				cmd_wg_sw_pos <= '0';
			elsif (ops_mode = "010") then -- HHVV tx, receive both
			   if (pol_state = "00") then  -- transmit H
					MOD_PULSE_HMC <= MOD_PULSE;
					EMS_OUT(1) <= EMS_TRIG;
					EMS_OUT(2) <= NOT EMS_TRIG;
					EMS_OUT(3) <= '0';
					EMS_OUT(4) <= EMS_TRIG;
					EMS_OUT(5) <= NOT EMS_TRIG;
					EMS_OUT(6) <= EMS_TRIG;
					EMS_OUT(7) <= NOT EMS_TRIG;
					WG_SW_CTRL_TERM <= '0';
					WG_SW_CTRL_NOISE <= '1';
					NOISE_SOURCE_EN <= '0';
					cmd_wg_sw_pos <= '0';
				elsif (pol_state = "01") then  -- transmit H
					MOD_PULSE_HMC <= MOD_PULSE;
					EMS_OUT(1) <= EMS_TRIG;
					EMS_OUT(2) <= NOT EMS_TRIG;
					EMS_OUT(3) <= '0';
					EMS_OUT(4) <= EMS_TRIG;
					EMS_OUT(5) <= NOT EMS_TRIG;
					EMS_OUT(6) <= EMS_TRIG;
					EMS_OUT(7) <= NOT EMS_TRIG;
					WG_SW_CTRL_TERM <= '0';
					WG_SW_CTRL_NOISE <= '1';
					NOISE_SOURCE_EN <= '0';
					cmd_wg_sw_pos <= '0';				
				elsif (pol_state = "10") then  -- transmit V
					MOD_PULSE_HMC <= MOD_PULSE;
					EMS_OUT(1) <= NOT EMS_TRIG;
					EMS_OUT(2) <= '1';
					EMS_OUT(3) <= EMS_TRIG;
					EMS_OUT(4) <= EMS_TRIG;
					EMS_OUT(5) <= NOT EMS_TRIG;
					EMS_OUT(6) <= EMS_TRIG;
					EMS_OUT(7) <= NOT EMS_TRIG;
					WG_SW_CTRL_TERM <= '0';
					WG_SW_CTRL_NOISE <= '1';
					NOISE_SOURCE_EN <= '0';
					cmd_wg_sw_pos <= '0';										
				else									-- transmit V
					MOD_PULSE_HMC <= MOD_PULSE;
					EMS_OUT(1) <= NOT EMS_TRIG;
					EMS_OUT(2) <= '1';
					EMS_OUT(3) <= EMS_TRIG;
					EMS_OUT(4) <= EMS_TRIG;
					EMS_OUT(5) <= NOT EMS_TRIG;
					EMS_OUT(6) <= EMS_TRIG;
					EMS_OUT(7) <= NOT EMS_TRIG;
					WG_SW_CTRL_TERM <= '0';
					WG_SW_CTRL_NOISE <= '1';
					NOISE_SOURCE_EN <= '0';
					cmd_wg_sw_pos <= '0';				
				end if;				
			elsif (ops_mode = "011") then -- Corner reflector cal Horizontal tx w/increased NF
				MOD_PULSE_HMC <= MOD_PULSE;
				EMS_OUT(1) <= EMS_TRIG;
				EMS_OUT(2) <= NOT EMS_TRIG;
				EMS_OUT(3) <= '0';
				EMS_OUT(4) <= EMS_TRIG;
				EMS_OUT(5) <= '0';
				EMS_OUT(6) <= EMS_TRIG;
				EMS_OUT(7) <= '0';
				WG_SW_CTRL_TERM <= '0';
				WG_SW_CTRL_NOISE <= '1';
				NOISE_SOURCE_EN <= '0';
				cmd_wg_sw_pos <= '0';			
			elsif (ops_mode = "100") then -- Noise source cal, no tx
				MOD_PULSE_HMC <= '0';
				EMS_OUT <= "0101101";
				WG_SW_CTRL_TERM <= '1';
				WG_SW_CTRL_NOISE <= '0';
				NOISE_SOURCE_EN <= '1';
				cmd_wg_sw_pos <= '1';
			elsif (ops_mode = "101") then -- Corner reflector cal, vertical tx w/increased NF
				MOD_PULSE_HMC <= MOD_PULSE;
				EMS_OUT(1) <= NOT EMS_TRIG;
				EMS_OUT(2) <= '1';
				EMS_OUT(3) <= EMS_TRIG;
				EMS_OUT(4) <= EMS_TRIG;
				EMS_OUT(5) <= '0';
				EMS_OUT(6) <= EMS_TRIG;
				EMS_OUT(7) <= '0';
				WG_SW_CTRL_TERM <= '0';
				WG_SW_CTRL_NOISE <= '1';
				NOISE_SOURCE_EN <= '0';
				cmd_wg_sw_pos <= '0';					
			elsif (ops_mode = "110") then -- Test Mode, no tx
				MOD_PULSE_HMC <= '0';
				EMS_OUT(1) <= NOT EMS_TRIG;
				EMS_OUT(2) <= '1';
				EMS_OUT(3) <= EMS_TRIG;
				EMS_OUT(4) <= EMS_TRIG;
				EMS_OUT(5) <= NOT EMS_TRIG;
				EMS_OUT(6) <= EMS_TRIG;
				EMS_OUT(7) <= NOT EMS_TRIG;
				WG_SW_CTRL_TERM <= '0';
				WG_SW_CTRL_NOISE <= '1';
				NOISE_SOURCE_EN <= '0';
				cmd_wg_sw_pos <= '0';
			elsif (ops_mode = "111") then -- Vertical tx, receive both, enable noise source for test	
				MOD_PULSE_HMC <= '0';
				EMS_OUT(1) <= NOT EMS_TRIG;
				EMS_OUT(2) <= '1';
				EMS_OUT(3) <= EMS_TRIG;
				EMS_OUT(4) <= EMS_TRIG;
				EMS_OUT(5) <= NOT EMS_TRIG;
				EMS_OUT(6) <= EMS_TRIG;
				EMS_OUT(7) <= NOT EMS_TRIG;
				WG_SW_CTRL_TERM <= '1';
				WG_SW_CTRL_NOISE <= '0';
				NOISE_SOURCE_EN <= '1';
				cmd_wg_sw_pos <= '1';				
			else
				MOD_PULSE_HMC <= '0';
				EMS_OUT <= "0000000";
				WG_SW_CTRL_TERM <= '0';
				WG_SW_CTRL_NOISE <= '1';
				NOISE_SOURCE_EN <= '0';
				cmd_wg_sw_pos <= '0';					
			end if;						
		when S3 =>
			ops_mode_en <= '0';
			if (ops_mode = "000") then -- Horizontal tx, receive both
				MOD_PULSE_HMC <= MOD_PULSE;
				EMS_OUT(1) <= EMS_TRIG;
				EMS_OUT(2) <= NOT EMS_TRIG;
				EMS_OUT(3) <= '0';
				EMS_OUT(4) <= EMS_TRIG;
				EMS_OUT(5) <= NOT EMS_TRIG;
				EMS_OUT(6) <= EMS_TRIG;
				EMS_OUT(7) <= NOT EMS_TRIG;
				WG_SW_CTRL_TERM <= '0';
				WG_SW_CTRL_NOISE <= '1';
				NOISE_SOURCE_EN <= '0';
				cmd_wg_sw_pos <= '0';	
			elsif (ops_mode = "001") then -- Vertical tx, receive both				
				MOD_PULSE_HMC <= MOD_PULSE;
				EMS_OUT(1) <= NOT EMS_TRIG;
				EMS_OUT(2) <= '1';
				EMS_OUT(3) <= EMS_TRIG;
				EMS_OUT(4) <= EMS_TRIG;
				EMS_OUT(5) <= NOT EMS_TRIG;
				EMS_OUT(6) <= EMS_TRIG;
				EMS_OUT(7) <= NOT EMS_TRIG;
				WG_SW_CTRL_TERM <= '0';
				WG_SW_CTRL_NOISE <= '1';
				NOISE_SOURCE_EN <= '0';
				cmd_wg_sw_pos <= '0';
			elsif (ops_mode = "010") then -- HHVV tx, receive both
				case pol_state is
					when "00" => -- transmit H
						MOD_PULSE_HMC <= MOD_PULSE;
						EMS_OUT(1) <= EMS_TRIG;
						EMS_OUT(2) <= NOT EMS_TRIG;
						EMS_OUT(3) <= '0';
						EMS_OUT(4) <= EMS_TRIG;
						EMS_OUT(5) <= NOT EMS_TRIG;
						EMS_OUT(6) <= EMS_TRIG;
						EMS_OUT(7) <= NOT EMS_TRIG;
						WG_SW_CTRL_TERM <= '0';
						WG_SW_CTRL_NOISE <= '1';
						NOISE_SOURCE_EN <= '0';
						cmd_wg_sw_pos <= '0';
					when "01" =>   -- transmit H
						MOD_PULSE_HMC <= MOD_PULSE;
						EMS_OUT(1) <= EMS_TRIG;
						EMS_OUT(2) <= NOT EMS_TRIG;
						EMS_OUT(3) <= '0';
						EMS_OUT(4) <= EMS_TRIG;
						EMS_OUT(5) <= NOT EMS_TRIG;
						EMS_OUT(6) <= EMS_TRIG;
						EMS_OUT(7) <= NOT EMS_TRIG;
						WG_SW_CTRL_TERM <= '0';
						WG_SW_CTRL_NOISE <= '1';
						NOISE_SOURCE_EN <= '0';
						cmd_wg_sw_pos <= '0';				
					when "10" =>  -- transmit V
						MOD_PULSE_HMC <= MOD_PULSE;
						EMS_OUT(1) <= NOT EMS_TRIG;
						EMS_OUT(2) <= '1';
						EMS_OUT(3) <= EMS_TRIG;
						EMS_OUT(4) <= EMS_TRIG;
						EMS_OUT(5) <= NOT EMS_TRIG;
						EMS_OUT(6) <= EMS_TRIG;
						EMS_OUT(7) <= NOT EMS_TRIG;
						WG_SW_CTRL_TERM <= '0';
						WG_SW_CTRL_NOISE <= '1';
						NOISE_SOURCE_EN <= '0';
						cmd_wg_sw_pos <= '0';										
					when "11" =>	-- transmit V
						MOD_PULSE_HMC <= MOD_PULSE;
						EMS_OUT(1) <= NOT EMS_TRIG;
						EMS_OUT(2) <= '1';
						EMS_OUT(3) <= EMS_TRIG;
						EMS_OUT(4) <= EMS_TRIG;
						EMS_OUT(5) <= NOT EMS_TRIG;
						EMS_OUT(6) <= EMS_TRIG;
						EMS_OUT(7) <= NOT EMS_TRIG;
						WG_SW_CTRL_TERM <= '0';
						WG_SW_CTRL_NOISE <= '1';
						NOISE_SOURCE_EN <= '0';
						cmd_wg_sw_pos <= '0';
					when others =>
				end case;
			elsif (ops_mode = "011") then -- Corner reflector cal, horizontal tx w/increased NF
				MOD_PULSE_HMC <= MOD_PULSE;
				EMS_OUT(1) <= EMS_TRIG;
				EMS_OUT(2) <= NOT EMS_TRIG;
				EMS_OUT(3) <= '0';
				EMS_OUT(4) <= EMS_TRIG;
				EMS_OUT(5) <= '0';
				EMS_OUT(6) <= EMS_TRIG;
				EMS_OUT(7) <= '0';
				WG_SW_CTRL_TERM <= '0';
				WG_SW_CTRL_NOISE <= '1';
				NOISE_SOURCE_EN <= '0';
				cmd_wg_sw_pos <= '0';									
			elsif (ops_mode = "100") then -- Noise source cal, no tx
				MOD_PULSE_HMC <= '0';
				EMS_OUT <= "0101101";
				WG_SW_CTRL_TERM <= '1';
				WG_SW_CTRL_NOISE <= '0';
				NOISE_SOURCE_EN <= '1';
				cmd_wg_sw_pos <= '1';
			elsif (ops_mode = "101") then -- Corner reflector cal, vertical tx w/increased NF
				MOD_PULSE_HMC <= MOD_PULSE;
				EMS_OUT(1) <= NOT EMS_TRIG;
				EMS_OUT(2) <= '1';
				EMS_OUT(3) <= EMS_TRIG;
				EMS_OUT(4) <= EMS_TRIG;
				EMS_OUT(5) <= '0';
				EMS_OUT(6) <= EMS_TRIG;
				EMS_OUT(7) <= '0';
				WG_SW_CTRL_TERM <= '0';
				WG_SW_CTRL_NOISE <= '1';
				NOISE_SOURCE_EN <= '0';
				cmd_wg_sw_pos <= '0';					
			elsif (ops_mode = "110") then -- Test Mode, no tx
				MOD_PULSE_HMC <= '0';
				EMS_OUT(1) <= NOT EMS_TRIG;
				EMS_OUT(2) <= '1';
				EMS_OUT(3) <= EMS_TRIG;
				EMS_OUT(4) <= EMS_TRIG;
				EMS_OUT(5) <= NOT EMS_TRIG;
				EMS_OUT(6) <= EMS_TRIG;
				EMS_OUT(7) <= NOT EMS_TRIG;
				WG_SW_CTRL_TERM <= '0';
				WG_SW_CTRL_NOISE <= '1';
				NOISE_SOURCE_EN <= '0';
				cmd_wg_sw_pos <= '0';
			elsif (ops_mode = "111") then -- Vertical tx, receive both				
				MOD_PULSE_HMC <= '0';
				EMS_OUT(1) <= NOT EMS_TRIG;
				EMS_OUT(2) <= '1';
				EMS_OUT(3) <= EMS_TRIG;
				EMS_OUT(4) <= EMS_TRIG;
				EMS_OUT(5) <= NOT EMS_TRIG;
				EMS_OUT(6) <= EMS_TRIG;
				EMS_OUT(7) <= NOT EMS_TRIG;
				WG_SW_CTRL_TERM <= '1';
				WG_SW_CTRL_NOISE <= '0';
				NOISE_SOURCE_EN <= '1';
				cmd_wg_sw_pos <= '1';				
			else
				MOD_PULSE_HMC <= '0';
				EMS_OUT <= "0000000";
				WG_SW_CTRL_TERM <= '0';
				WG_SW_CTRL_NOISE <= '1';
				NOISE_SOURCE_EN <= '0';
				cmd_wg_sw_pos <= '0';					
			end if;
		when others =>
				ops_mode_en <= '0';
--				ops_mode <= OPS_MODE_730;
				cmd_wg_sw_pos <= '0';
				MOD_PULSE_HMC <= '0';
				EMS_OUT <= "0000000";
				WG_SW_CTRL_TERM <= '0';
				WG_SW_CTRL_NOISE <= '1';
				NOISE_SOURCE_EN <= '0';
				cmd_wg_sw_pos <= '0';
	end case;
end process;	
			
-------------------------------------------------------------------------------------------------------
end Behavioral;
