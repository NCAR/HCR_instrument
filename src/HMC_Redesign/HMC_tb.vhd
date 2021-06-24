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
	 GENERIC(
		TESTBENCH_MODE : boolean := false );
    PORT(
        RESETn_CPCI       : in  std_logic; -- cPCI RESETn line
        T0                : in  std_logic;
        MOD_PULSE         : in  std_logic;
        EMS_TRIG          : in  std_logic;
        RX_GATE           : in  std_logic;
        POL_MODE_PENTEK   : in  std_logic_vector(1 downto 0);
        RESETn_PENTEK     : in  std_logic; -- RESETn from the Pentek. Was TX_GATE
        EXT_CLK           : in  std_logic; -- 15.625 MHz clock;    125 MHz/8
        SYNC_PULSE_CLK    : in  std_logic; -- 217.01389 MHz clock; 125 MHz/8/72
        HV_FLAG           : out std_logic;
        --ONE_PPS           : in  std_logic;
        EMS_PWR_ERROR     : in  std_logic;
        HV_ON_730         : in  std_logic; -- High voltage cmd from PMC730
        FIL_ON_730        : in  std_logic; -- Filament on cmd from PMC730
        OPS_MODE_730      : in  std_logic_vector(2 downto 0); -- Operationsl mode cmd from PMC730
        STATUS_ACK        : in  std_logic; -- Status receipt acknowledgement
        BIT_EMS           : in  std_logic_vector(7 downto 1); -- EMS latching circulator BIT
        EMS_OUT           : out std_logic_vector(7 downto 1); -- EMS latching circulator outputs
        MOD_PULSE_HMC     : out std_logic;
        SYNC_PULSE_HMC    : out std_logic;
        HV_ON_HMC         : out std_logic;
        FIL_ON_HMC        : out std_logic;
        WG_SW_TERM        : in  std_logic; -- BIT indication when waveguide switch is into load
        WG_SW_NOISE       : in  std_logic; -- BIT indication when waveguide switch is into noise source
        WG_SW_CTRL_TERM   : out std_logic; -- Terminate waveguide switch into load
        WG_SW_CTRL_NOISE  : out std_logic; -- Terminate waveguide switch into noise source
        NOISE_SOURCE_EN   : out std_logic; -- Turn on noise source
        WG_SW_ERROR       : out std_logic; -- Waveguide switch BIT doesn't match command
        MOD_PULSE_DISABLE : out std_logic; -- Fault sum status
        EMS_ERROR_1       : out std_logic; -- EMS switch 1 BIT error
        EMS_ERROR_2       : out std_logic; -- EMS switch 2 BIT error
        EMS_ERROR_3       : out std_logic; -- EMS switch 3 BIT error
        EMS_ERROR_45      : out std_logic; -- EMS switch 4,5 BIT error
        EMS_ERROR_67      : out std_logic; -- EMS switch 6,7 BIT error
        EMS_ERROR_EVENT   : out std_logic; -- EMS switch BIT error count
        TEST_BIT_0        : in  std_logic;
        TEST_BIT_1        : in  std_logic;
        SPARE_STATUS0     : out std_logic;
        SPARE_STATUS1     : out std_logic;
        U6_OE             : out std_logic;
        SPARE2            : out std_logic;
        SPARE3            : out std_logic
        );
    END COMPONENT;


   --Inputs
   signal POL_MODE_PENTEK : std_logic_vector(1 downto 0) := (others => '0');
   signal TX_GATE : std_logic := '0';
   signal RESET : std_logic := '0';
   signal EXT_CLK : std_logic := '0';
   signal T0 : std_logic := '0';
   signal MOD_PULSE : std_logic := '0';
   signal SYNC_PULSE_CLK : std_logic := '0';
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
   signal HV_FLAG : std_logic;
   signal SPARE2 : std_logic;
   signal SPARE3 : std_logic;

   -- Clock period definitions
   constant EXT_CLK_period : time := 64 ns;

	signal testbench_state : integer := 0;

BEGIN
	-- Instantiate the Unit Under Test (UUT)
   uut: HMC_src
	GENERIC MAP (
		TESTBENCH_MODE => true )
	PORT MAP (
          RESETn_CPCI => '1',
          RESETn_PENTEK => RESET,
          EXT_CLK => EXT_CLK,
			 POL_MODE_PENTEK => POL_MODE_PENTEK,
          T0 => T0,
          MOD_PULSE => MOD_PULSE,
          SYNC_PULSE_CLK => SYNC_PULSE_CLK,
          EMS_TRIG => EMS_TRIG,
          RX_GATE => RX_GATE,
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
          HV_FLAG => HV_FLAG,
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
		SYNC_PULSE_CLK <= '1';
		wait for 2304 ns;
		SYNC_PULSE_CLK <= '0';
		wait for 2304 ns;
	end process;

	EMS_BIT: process -- Generate EMS BIT response; Ops mode will use previous state for current cycle
	variable CNT : integer range 0 to 1024;
	begin
		WG_SW_NOISE <= '0';  -- update switch status
		WG_SW_TERM <= '1';
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

		testbench_state <= 1;
-- Loop for 1000 PRTs (~100 milliseconds to allow waveguide switch to switch
		CNT := 0;
		while (CNT <= 1000) loop
		wait for 320 ns;  -- 320 ns is max delay measured
-- 	Noise source cal
			if (CNT = 988) then
				WG_SW_NOISE <= '0';  -- update switch status
				WG_SW_TERM <= '1';
			elsif (CNT = 1000) then
				OPS_MODE_730 <= o"2"; POL_MODE_PENTEK <= "00";  -- Next ops mode is vertical tx, simultaneous receive
				WG_SW_NOISE <= '1';  -- update switch status;
				WG_SW_TERM <= '0';

			else
				OPS_MODE_730 <= "100"; -- keep in Noise source cal mode
			end if;
		BIT_EMS <= "0101101";
        assert EMS_OUT = "0101101" report "Bad EMS_OUT at 0101101" severity failure;
		case CNT is
			when 101 => BIT_EMS(1) <= '0';
			when 102 => BIT_EMS(2) <= '1';
			when 103 => BIT_EMS(3) <= '0';
			when 104 => BIT_EMS(4) <= '0';
			when 105 => BIT_EMS(5) <= '1';
			when 106 => BIT_EMS(6) <= '0';
			when 107 => BIT_EMS(7) <= '1';
			when others =>
		end case;
		wait for 1168 ns;
		BIT_EMS <= "0101101";
        assert EMS_OUT = "0101101" report "Bad EMS_OUT at 0101101" severity failure;
		case CNT is
			when 108 => BIT_EMS(1) <= '0';
			when 109 => BIT_EMS(2) <= '1';
			when 110 => BIT_EMS(3) <= '0';
			when 111 => BIT_EMS(4) <= '0';
			when 112 => BIT_EMS(5) <= '1';
			when 113 => BIT_EMS(6) <= '0';
			when 114 => BIT_EMS(7) <= '1';
			when others =>
		end case;
		wait for 99788 ns;
		STATUS_ACK <= '1';  -- clear status every PRT for testing
		wait for 100 ns;
		STATUS_ACK <= '0';
			CNT := CNT + 1;
		end loop;

testbench_state <= 14;


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
        assert EMS_OUT = "0101110" report "Bad EMS_OUT at 0101110" severity failure;
		assert EMS_OUT = "0101110" severity failure;
		wait for 1168 ns;
		BIT_EMS <= "1010011";
        assert EMS_OUT = "1010011" report "Bad EMS_OUT at 1010011" severity failure;
		wait for 99788 ns;
		STATUS_ACK <= '1';  -- clear status every PRT for testing
		wait for 100 ns;
		STATUS_ACK <= '0';
testbench_state <= 3;
-- Corner reflector cal, vertical tx w/reduced power on receive
		wait for 320 ns;  -- 320 ns is max delay measured
		OPS_MODE_730 <= "110"; -- Next ops mode is Test Mode, no tx
		BIT_EMS <= "0101110";
        assert EMS_OUT = "0101110" report "Bad EMS_OUT at 0101110" severity failure;
		wait for 1168 ns;
		BIT_EMS <= "0000011";
        assert EMS_OUT = "0000011" report "Bad EMS_OUT at 0000011" severity failure;
		wait for 99788 ns;
		STATUS_ACK <= '1';  -- clear status every PRT for testing
		wait for 100 ns;
		STATUS_ACK <= '0';
testbench_state <= 4;
-- Test Mode, no tx
			wait for 320 ns;  -- 320 ns is max delay measured
			OPS_MODE_730 <= o"2"; POL_MODE_PENTEK <= "01";  -- Next ops mode is horizontal tx, simultaneous receive
			BIT_EMS <= "0101110";
        assert EMS_OUT = "0101110" report "Bad EMS_OUT at 0101110" severity failure;
			wait for 1168 ns;
			BIT_EMS <= "1010011";
        assert EMS_OUT = "1010011" report "Bad EMS_OUT at 1010011" severity failure;
			wait for 99788 ns;
			STATUS_ACK <= '1';  -- clear status every PRT for testing
			wait for 100 ns;
			STATUS_ACK <= '0';
-- Ops Mode, horizontal tx
			wait for 320 ns;  -- 320 ns is max delay measured
			OPS_MODE_730 <= o"2"; POL_MODE_PENTEK <= "10";  -- Next ops mode is HHVV V tx, simultaneous receive
			BIT_EMS <= "0101001";
        assert EMS_OUT = "0101001" report "Bad EMS_OUT at 0101001" severity failure;
			wait for 1168 ns;
			BIT_EMS <= "1010010";
        assert EMS_OUT = "1010010" report "Bad EMS_OUT at 1010010" severity failure;
			wait for 99788 ns;
			STATUS_ACK <= '1';  -- clear status every PRT for testing
			wait for 100 ns;
			STATUS_ACK <= '0';
-- Ops Mode, HHVV
			wait for 320 ns;  -- 320 ns is max delay measured
			OPS_MODE_730 <= o"2"; POL_MODE_PENTEK <= "10";  -- Next ops mode is HHVV H tx, simultaneous receive
			BIT_EMS <= "0101110";
        assert EMS_OUT = "0101110" report "Bad EMS_OUT at 0101110" severity failure;
			wait for 1168 ns;
			BIT_EMS <= "1010011";
        assert EMS_OUT = "1010011" report "Bad EMS_OUT at 1010011" severity failure;
			wait for 99788 ns;
			STATUS_ACK <= '1';  -- clear status every PRT for testing
			wait for 100 ns;
			STATUS_ACK <= '0';

			wait for 320 ns;  -- 320 ns is max delay measured
			OPS_MODE_730 <= o"2"; POL_MODE_PENTEK <= "10";  -- Next ops mode is HHVV H tx, simultaneous receive
			BIT_EMS <= "0101001";
        assert EMS_OUT = "0101001" report "Bad EMS_OUT at 0101001" severity failure;
			wait for 1168 ns;
			BIT_EMS <= "1010010";
        assert EMS_OUT = "1010010" report "Bad EMS_OUT at 1010010" severity failure;
			wait for 99788 ns;
			STATUS_ACK <= '1';  -- clear status every PRT for testing
			wait for 100 ns;
			STATUS_ACK <= '0';

			wait for 320 ns;  -- 320 ns is max delay measured
			OPS_MODE_730 <= o"2"; POL_MODE_PENTEK <= "10";  -- Next ops mode is HHVV V tx, simultaneous receive
			BIT_EMS <= "0101001";
        assert EMS_OUT = "0101001" report "Bad EMS_OUT at 0101001" severity failure;
			wait for 1168 ns;
			BIT_EMS <= "1010010";
        assert EMS_OUT = "1010010" report "Bad EMS_OUT at 1010010" severity failure;
			wait for 99788 ns;
			STATUS_ACK <= '1';  -- clear status every PRT for testing
			wait for 100 ns;
			STATUS_ACK <= '0';

			wait for 320 ns;  -- 320 ns is max delay measured
			OPS_MODE_730 <= o"2"; POL_MODE_PENTEK <= "00";  -- Next ops mode is vertical tx, simultaneous receive
			BIT_EMS <= "0101110";
        assert EMS_OUT = "0101110" report "Bad EMS_OUT at 0101110" severity failure;
			wait for 1168 ns;
			BIT_EMS <= "1010011";
        assert EMS_OUT = "1010011" report "Bad EMS_OUT at 1010011" severity failure;
			wait for 99788 ns;
			STATUS_ACK <= '1';  -- clear status every PRT for testing
			wait for 100 ns;
			STATUS_ACK <= '0';
		CNT := CNT + 1;
	end loop;
assert false report "(NO FAILURE) End of stimulus" severity failure;
	end process;
END;

