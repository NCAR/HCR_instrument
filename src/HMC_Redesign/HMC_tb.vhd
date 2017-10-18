--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:38:24 05/29/2013
-- Design Name:   
-- Module Name:   //cit/eol/EOL Documents Folders/ericloew/My Documents/MyFiles/HIAPER Cloud Radar/HMC_Redesign/HMC_tb.vhd
-- Project Name:  HMC_Redesign
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: HMC_src
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;

-----------------------------------------------------------------------------------------
-- NEED TO RUN SIMULATION FOR 1016 MILLISECONDS TO SEE CORRECT BEHAVIOR !!!
-----------------------------------------------------------------------------------------
 
ENTITY HMC_tb IS
END HMC_tb;
 
ARCHITECTURE behavior OF HMC_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT HMC_src
    PORT(
         TIMER_6 : IN  std_logic;
         TIMER_7 : IN  std_logic;
         TX_GATE : IN  std_logic;
         RESET : IN  std_logic;
         EXT_CLK : IN  std_logic;
         T0 : IN  std_logic;
         MOD_PULSE : IN  std_logic;
         SYNC_PULSE : IN  std_logic;
         EMS_TRIG : IN  std_logic;
         RX_GATE : IN  std_logic;
         ONE_PPS : IN  std_logic;
         EMS_PWR_ERROR : IN  std_logic;
         HV_ON_730 : IN  std_logic;
         FIL_ON_730 : IN  std_logic;
         OPS_MODE_730 : IN  std_logic_vector(2 downto 0);
         STATUS_ACK : IN  std_logic;
         BIT_EMS : IN  std_logic_vector(7 downto 1);
         EMS_OUT : OUT  std_logic_vector(7 downto 1);
         MOD_PULSE_HMC : OUT  std_logic;
         SYNC_PULSE_HMC : OUT  std_logic;
         HV_ON_HMC : OUT  std_logic;
         FIL_ON_HMC : OUT  std_logic;
         WG_SW_TERM : IN  std_logic;
         WG_SW_NOISE : IN  std_logic;
         WG_SW_CTRL_TERM : OUT  std_logic;
         WG_SW_CTRL_NOISE : OUT  std_logic;
         NOISE_SOURCE_EN : OUT  std_logic;
         WG_SW_ERROR : OUT  std_logic;
         MOD_PULSE_DISABLE : OUT  std_logic;
         EMS_ERROR_1 : OUT  std_logic;
         EMS_ERROR_2 : OUT  std_logic;
         EMS_ERROR_3 : OUT  std_logic;
         EMS_ERROR_45 : OUT  std_logic;
         EMS_ERROR_67 : OUT  std_logic;
         EMS_ERROR_EVENT : OUT  std_logic;
         TEST_BIT_0 : IN  std_logic;
         TEST_BIT_1 : IN  std_logic;
         SPARE_STATUS0 : OUT  std_logic;
         SPARE_STATUS1 : OUT  std_logic;
			U6_OE: OUT STD_LOGIC;				
         SPARE1 : OUT  std_logic;
         SPARE2 : OUT  std_logic;
         SPARE3 : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal TIMER_6 : std_logic := '0';
   signal TIMER_7 : std_logic := '0';
   signal TX_GATE : std_logic := '0';
   signal RESET : std_logic := '0';
   signal EXT_CLK : std_logic := '0';
   signal T0 : std_logic := '0';
   signal MOD_PULSE : std_logic := '0';
   signal SYNC_PULSE : std_logic := '0';
   signal EMS_TRIG : std_logic := '0';
   signal RX_GATE : std_logic := '0';
   signal ONE_PPS : std_logic := '0';
   signal EMS_PWR_ERROR : std_logic := '0';
   signal HV_ON_730 : std_logic := '1';
   signal FIL_ON_730 : std_logic := '0';
   signal OPS_MODE_730 : std_logic_vector(2 downto 0) := (others => '0');
   signal STATUS_ACK : std_logic := '0';
   signal BIT_EMS : std_logic_vector(7 downto 1) := (others => '0');
   signal WG_SW_TERM : std_logic := '0';
   signal WG_SW_NOISE : std_logic := '1';
   signal TEST_BIT_0 : std_logic := '0';
   signal TEST_BIT_1 : std_logic := '0';

 	--Outputs
   signal EMS_OUT : std_logic_vector(7 downto 1);
   signal MOD_PULSE_HMC : std_logic;
   signal SYNC_PULSE_HMC : std_logic;
   signal HV_ON_HMC : std_logic;
   signal FIL_ON_HMC : std_logic;
   signal WG_SW_CTRL_TERM : std_logic;
   signal WG_SW_CTRL_NOISE : std_logic;
   signal NOISE_SOURCE_EN : std_logic;
   signal WG_SW_ERROR : std_logic;
   signal MOD_PULSE_DISABLE : std_logic;
   signal EMS_ERROR_1 : std_logic;
   signal EMS_ERROR_2 : std_logic;
   signal EMS_ERROR_3 : std_logic;
   signal EMS_ERROR_45 : std_logic;
   signal EMS_ERROR_67 : std_logic;
   signal EMS_ERROR_EVENT : std_logic;
   signal SPARE_STATUS0 : std_logic;
   signal SPARE_STATUS1 : std_logic;
   signal U6_OE : std_logic;	
   signal SPARE1 : std_logic;
   signal SPARE2 : std_logic;
   signal SPARE3 : std_logic;

   -- Clock period definitions
   constant EXT_CLK_period : time := 64 ns;
 
BEGIN 
	-- Instantiate the Unit Under Test (UUT)
   uut: HMC_src PORT MAP (
          TIMER_6 => TIMER_6,
          TIMER_7 => TIMER_7,
          TX_GATE => TX_GATE,
          RESET => RESET,
          EXT_CLK => EXT_CLK,
          T0 => T0,
          MOD_PULSE => MOD_PULSE,
          SYNC_PULSE => SYNC_PULSE,
          EMS_TRIG => EMS_TRIG,
          RX_GATE => RX_GATE,
          ONE_PPS => ONE_PPS,
          EMS_PWR_ERROR => EMS_PWR_ERROR,
          HV_ON_730 => HV_ON_730,
          FIL_ON_730 => FIL_ON_730,
          OPS_MODE_730 => OPS_MODE_730,
          STATUS_ACK => STATUS_ACK,
          BIT_EMS => BIT_EMS,
          EMS_OUT => EMS_OUT,
          MOD_PULSE_HMC => MOD_PULSE_HMC,
          SYNC_PULSE_HMC => SYNC_PULSE_HMC,
          HV_ON_HMC => HV_ON_HMC,
          FIL_ON_HMC => FIL_ON_HMC,
          WG_SW_TERM => WG_SW_TERM,
          WG_SW_NOISE => WG_SW_NOISE,
          WG_SW_CTRL_TERM => WG_SW_CTRL_TERM,
          WG_SW_CTRL_NOISE => WG_SW_CTRL_NOISE,
          NOISE_SOURCE_EN => NOISE_SOURCE_EN,
          WG_SW_ERROR => WG_SW_ERROR,
          MOD_PULSE_DISABLE => MOD_PULSE_DISABLE,
          EMS_ERROR_1 => EMS_ERROR_1,
          EMS_ERROR_2 => EMS_ERROR_2,
          EMS_ERROR_3 => EMS_ERROR_3,
          EMS_ERROR_45 => EMS_ERROR_45,
          EMS_ERROR_67 => EMS_ERROR_67,
          EMS_ERROR_EVENT => EMS_ERROR_EVENT,
          TEST_BIT_0 => TEST_BIT_0,
          TEST_BIT_1 => TEST_BIT_1,
          SPARE_STATUS0 => SPARE_STATUS0,
          SPARE_STATUS1 => SPARE_STATUS1,
			 U6_OE => U6_OE,
          SPARE1 => SPARE1,
          SPARE2 => SPARE2,
          SPARE3 => SPARE3
        );

   -- Clock process definitions
   EXT_CLK_process :process
   begin
		EXT_CLK <= '0';
		wait for EXT_CLK_period/2;
		EXT_CLK <= '1';
		wait for EXT_CLK_period/2;
   end process;
 
	HEART_BEAT: process -- one pps heartbeat, for now make it every prt
	begin
		ONE_PPS <= '1';
		wait for 101376 ns;
--		wait for 10 ns;	-- for test
		ONE_PPS <= '0';
		wait for 101376 ns;
--		wait for 10 ns;  -- for test
	end process;

	PMC_730: process	-- PMC730 generated command signals
   begin
		wait for 100 ns;
		RESET <= '0'; -- reset firmware
		wait for 500 ns; -- turn HV_ON, Filament on
		HV_ON_730 <= '0';
		EMS_PWR_ERROR <= '0';  	-- good status	
		RESET <= '1'; 			-- take out of reset state!
		wait;             -- wait forever; i.e. don't cycle
	end process;

	PENTEK_TIMING: process	-- Pentek Generated Timing Signals
   begin
		T0 <= '1';
		EMS_TRIG <= '1';
		wait for 128 ns; 
		T0 <= '0';
		wait for 272 ns;
		MOD_PULSE <= '1';
		wait for 512 ns;
		MOD_PULSE <= '0';
		wait for 256 ns;
		EMS_TRIG <= '0';
		RX_GATE <= '1';
		wait for 97280 ns;  -- 380 gates @ 256 ns/gate
		RX_GATE <= '0';
		wait for 2928 ns;
   end process;
	
		SYNC_CLK: process   -- Generate 217 kHz sync clock
   begin	 
		SYNC_PULSE <= '1';
		wait for 2304 ns;
		SYNC_PULSE <= '0';
		wait for 2304 ns;
	end process;

	EMS_BIT: process -- Generate EMS BIT response; Ops mode will use previous state for current cycle
	variable CNT : integer range 0 to 1024;
	begin
--		WG_SW_NOISE <= '0';  -- update switch status
--		WG_SW_TERM <= '1';		
		wait for 320 ns;  -- 320 ns is max delay measured
-- Vertical transmit receive both
		OPS_MODE_730 <= "100";   -- Next cycle ops mode is noise source
		BIT_EMS <= "0101110";
		wait for 1168 ns;
		BIT_EMS <= "1010011"; 
		wait for 99788 ns;
		STATUS_ACK <= '1';  -- clear status every PRT for testing
		wait for 100 ns;
		STATUS_ACK <= '0';
		
---- Cycle through EMS BITE errors in next few PRT's
--		wait for 320 ns;  -- 320 ns is max delay measured
--		OPS_MODE_730 <= "100";   
--		BIT_EMS <= "0101111";  -- ems_error_1	
--		wait for 1168 ns;
--		BIT_EMS <= "1010001";  -- ems_error_2	
--		wait for 99788 ns;
--		STATUS_ACK <= '1';  -- clear status every PRT for testing
--		wait for 100 ns;
--		STATUS_ACK <= '0';
--		
--		wait for 320 ns;  -- 320 ns is max delay measured
--		OPS_MODE_730 <= "100";   
--		BIT_EMS <= "0101010";	-- ems_error_3
--		wait for 1168 ns;
--		BIT_EMS <= "1001011"; 	-- ems_error_45
--		wait for 99788 ns;
--		STATUS_ACK <= '1';  -- clear status every PRT for testing
--		wait for 100 ns;
--		STATUS_ACK <= '0';
--		
--		wait for 320 ns;  -- 320 ns is max delay measured
--		OPS_MODE_730 <= "100";   
--		BIT_EMS <= "1001110";	-- ems_error_67
--		wait for 1168 ns;
--		BIT_EMS <= "1010011"; 
--		wait for 99788 ns;
--		STATUS_ACK <= '1';  -- clear status every PRT for testing
--		wait for 100 ns;
--		STATUS_ACK <= '0';
--		

-- Loop for 1000 PRTs (~100 milliseconds to allow waveguide switch to switch
		CNT := 0;
		while (CNT <= 1000) loop
		wait for 320 ns;  -- 320 ns is max delay measured
-- 	Noise source cal
			if (CNT = 988) then
				WG_SW_NOISE <= '0';  -- update switch status
				WG_SW_TERM <= '1';
--			elsif (CNT = 1000) then
----				OPS_MODE_730 <= "101";  -- next ops mode is Corner reflector cal, vertical tx w/reduced power on receive
--				WG_SW_NOISE <= '0';  -- update switch status;
--				WG_SW_TERM <= '1';
			else
				OPS_MODE_730 <= "100"; -- keep in Noise source cal mode
			end if;
		BIT_EMS <= "0101101";
		wait for 1168 ns;
		BIT_EMS <= "0101101";
		wait for 99788 ns;	
		STATUS_ACK <= '1';  -- clear status every PRT for testing
		wait for 100 ns;
		STATUS_ACK <= '0';
			CNT := CNT + 1;
		end loop;
-- Loop for 125 PRTs (~100 milliseconds to allow waveguide switch to switch
	CNT := 0;
	while (CNT < 125) loop
		wait for 320 ns;  -- 320 ns is max delay measured
		if (CNT = 123) then
				WG_SW_NOISE <= '1';  -- update switch status;
				WG_SW_TERM <= '0';
		end if;
-- Vertical Tx, simultaneous receive	
		OPS_MODE_730 <= "101"; -- Next ops mode is corner reflector cal, vertical tx
		BIT_EMS <= "0101110";
		wait for 1168 ns;
		BIT_EMS <= "1010011";
		wait for 99788 ns;
		STATUS_ACK <= '1';  -- clear status every PRT for testing
		wait for 100 ns;
		STATUS_ACK <= '0';
		
-- Corner reflector cal, vertical tx w/reduced power on receive
		wait for 320 ns;  -- 320 ns is max delay measured		
		OPS_MODE_730 <= "110"; -- Next ops mode is Test Mode, no tx
		BIT_EMS <= "0101110";
		wait for 1168 ns;
		BIT_EMS <= "0000011";
		wait for 99788 ns;		
		STATUS_ACK <= '1';  -- clear status every PRT for testing
		wait for 100 ns;
		STATUS_ACK <= '0';		

-- Test Mode, no tx
			wait for 320 ns;  -- 320 ns is max delay measured		
			OPS_MODE_730 <= "000";  -- Next ops mode is horizontal tx, simultaneous receive
			BIT_EMS <= "0101110";
			wait for 1168 ns;
			BIT_EMS <= "1010011";
			wait for 99788 ns;
			STATUS_ACK <= '1';  -- clear status every PRT for testing
			wait for 100 ns;
			STATUS_ACK <= '0';
-- Ops Mode, horizontal tx
			wait for 320 ns;  -- 320 ns is max delay measured		
			OPS_MODE_730 <= "010";  -- Next ops mode is HHVV V tx, simultaneous receive
			BIT_EMS <= "0101001";
			wait for 1168 ns;
			BIT_EMS <= "1010010";
			wait for 99788 ns;
			STATUS_ACK <= '1';  -- clear status every PRT for testing
			wait for 100 ns;
			STATUS_ACK <= '0';	
-- Ops Mode, HHVV
			wait for 320 ns;  -- 320 ns is max delay measured		
			OPS_MODE_730 <= "010";  -- Next ops mode is HHVV H tx, simultaneous receive
			BIT_EMS <= "0101110";
			wait for 1168 ns;
			BIT_EMS <= "1010011";
			wait for 99788 ns;
			STATUS_ACK <= '1';  -- clear status every PRT for testing
			wait for 100 ns;
			STATUS_ACK <= '0';	

			wait for 320 ns;  -- 320 ns is max delay measured		
			OPS_MODE_730 <= "010";  -- Next ops mode is HHVV H tx, simultaneous receive
			BIT_EMS <= "0101001";
			wait for 1168 ns;
			BIT_EMS <= "1010010";
			wait for 99788 ns;
			STATUS_ACK <= '1';  -- clear status every PRT for testing
			wait for 100 ns;
			STATUS_ACK <= '0';
			
			wait for 320 ns;  -- 320 ns is max delay measured		
			OPS_MODE_730 <= "010";  -- Next ops mode is HHVV V tx, simultaneous receive
			BIT_EMS <= "0101001";
			wait for 1168 ns;
			BIT_EMS <= "1010010";
			wait for 99788 ns;
			STATUS_ACK <= '1';  -- clear status every PRT for testing
			wait for 100 ns;
			STATUS_ACK <= '0';
			
			wait for 320 ns;  -- 320 ns is max delay measured		
			OPS_MODE_730 <= "001";  -- Next ops mode is vertical tx, simultaneous receive
			BIT_EMS <= "0101110";
			wait for 1168 ns;
			BIT_EMS <= "1010011";
			wait for 99788 ns;
			STATUS_ACK <= '1';  -- clear status every PRT for testing
			wait for 100 ns;
			STATUS_ACK <= '0';
		CNT := CNT + 1;
	end loop;			
	end process;  
END;

