--------------------------------------------------------------------------------
-- Company:   NCAR/EOL
-- Engineer:  Loew
--
-- Create Date:   15:38:24 05/29/2013
-- Design Name:
-- Project Name:  HMC_Redesign
-- Target Device:
-- Tool versions:
-- Description:
--
-- VHDL Test Bench Created by ISE for module: HMC_src
--
-- Revision:
-- HMC V5 updates: 7/2/21 - Karboski
--
-- Notes:
--
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

--------------------------------------------------------------------------------
-- USE 'RUN ALL'; TESTBENCH WILL SELF-CHECK AND THEN HALT
--------------------------------------------------------------------------------

ENTITY HMC_tb IS
END HMC_tb;

ARCHITECTURE behavior OF HMC_tb IS

    -- Component Declaration for the Unit Under Test (UUT)

    COMPONENT x_HMC_src
     GENERIC(
        C_U6_DELAY          : integer;
        C_HV_DELAY          : integer;
        C_WG_DELAY          : integer
        );
    PORT(
        RESETn_CPCI       : in  std_logic; -- cPCI RESETn line
        T0                : in  std_logic;
        MOD_PULSE         : in  std_logic;
        EMS_TRIG          : in  std_logic;
        RX_GATE           : in  std_logic;
        HVn_CMD_PENTEK    : in  std_logic; -- HV command from the Pentek. Was TX_GATE
        EXT_CLK           : in  std_logic; -- 15.625 MHz clock;    125 MHz/8
        SYNC_PULSE_CLK    : in  std_logic; -- 217.01389 MHz clock; 125 MHz/8/72
        HVn_FLAG          : out std_logic;
        --ONE_PPS           : in  std_logic;
        EMS_PWR_ERROR     : in  std_logic;
        HV_ON_730n        : in  std_logic; -- High voltage cmd from PMC730
        FIL_ON_730n       : in  std_logic; -- Filament on cmd from PMC730
        OPS_MODE_730      : in  std_logic_vector(2 downto 0); -- Operationsl mode cmd from PMC730
        STATUS_ACK        : in  std_logic; -- Status receipt acknowledgement
        BIT_EMS           : in  std_logic_vector(7 downto 1); -- EMS latching circulator BIT
        EMS_OUT           : out std_logic_vector(7 downto 1); -- EMS latching circulator outputs
        MOD_PULSE_HMC     : out std_logic;
        SYNC_PULSE_HMC    : out std_logic;
        HV_ON_HMCn        : out std_logic;
        FIL_ON_HMCn       : out std_logic;
        WG_SW_TERMn       : in  std_logic; -- BIT indication when waveguide switch is into load
        WG_SW_NOISEn      : in  std_logic; -- BIT indication when waveguide switch is into noise source
        WG_SW_CTRL_TERMn  : out std_logic; -- Terminate waveguide switch into load
        WG_SW_CTRL_NOISEn : out std_logic; -- Terminate waveguide switch into noise source
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
        U6_OEn            : out std_logic;
        SPARE2            : out std_logic;
        SPARE3            : out std_logic
        );
    END COMPONENT;


    --Inputs
    signal HVn_CMD_PENTEK : std_logic := '0';
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
    signal HV_ON_730n : std_logic := '1';
    signal FIL_ON_730n : std_logic := '1';
    signal OPS_MODE_730 : std_logic_vector(2 downto 0) := (others => '0');
    signal STATUS_ACK : std_logic := '0';
    signal BIT_EMS : std_logic_vector(7 downto 1) := (others => '0');
    signal WG_SW_TERMn : std_logic := '0';
    signal WG_SW_NOISEn : std_logic := '1';
    signal TEST_BIT_0 : std_logic := '0';
    signal TEST_BIT_1 : std_logic := '0';

     --Outputs
    signal EMS_OUT : std_logic_vector(7 downto 1);
    signal MOD_PULSE_HMC : std_logic;
    signal SYNC_PULSE_HMC : std_logic;
    signal HV_ON_HMCn : std_logic;
    signal FIL_ON_HMCn : std_logic;
    signal WG_SW_CTRL_TERMn : std_logic;
    signal WG_SW_CTRL_NOISEn : std_logic;
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
    signal U6_OEn : std_logic;
    signal HVn_FLAG : std_logic;
    signal SPARE2 : std_logic;
    signal SPARE3 : std_logic;

    -- Clock period definitions
    constant EXT_CLK_period : time := 64 ns;

    signal testbench_state : integer := 0;

BEGIN
    -- Instantiate the Unit Under Test (UUT)
    uut: x_HMC_src
    GENERIC MAP (
        C_U6_DELAY => 70000,
        C_HV_DELAY => 70000,
        C_WG_DELAY => 70000
        )
    PORT MAP (
        RESETn_CPCI => RESET,
        EXT_CLK => EXT_CLK,
        HVn_CMD_PENTEK => HVn_CMD_PENTEK,
        T0 => T0,
        MOD_PULSE => MOD_PULSE,
        SYNC_PULSE_CLK => SYNC_PULSE_CLK,
        EMS_TRIG => EMS_TRIG,
        RX_GATE => RX_GATE,
        EMS_PWR_ERROR => EMS_PWR_ERROR,
        HV_ON_730n => HV_ON_730n,
        FIL_ON_730n => FIL_ON_730n,
        OPS_MODE_730 => OPS_MODE_730,
        --ONE_PPS => ONE_PPS,
        STATUS_ACK => STATUS_ACK,
        BIT_EMS => BIT_EMS,
        EMS_OUT => EMS_OUT,
        MOD_PULSE_HMC => MOD_PULSE_HMC,
        SYNC_PULSE_HMC => SYNC_PULSE_HMC,
        HV_ON_HMCn => HV_ON_HMCn,
        FIL_ON_HMCn => FIL_ON_HMCn,
        WG_SW_TERMn => WG_SW_TERMn,
        WG_SW_NOISEn => WG_SW_NOISEn,
        WG_SW_CTRL_TERMn => WG_SW_CTRL_TERMn,
        WG_SW_CTRL_NOISEn => WG_SW_CTRL_NOISEn,
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
        U6_OEn => U6_OEn,
        HVn_FLAG => HVn_FLAG,
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

    HEART_BEAT: process
    begin
        ONE_PPS <= '1';
        wait for 101376 ns;
        ONE_PPS <= '0';
        wait for 101376 ns;
    end process;

    PMC_730: process    -- PMC730 generated command signals
    begin
        wait for 100 ns;
        RESET <= '0'; -- reset firmware
        wait for 500 ns; -- turn HV_ON, Filament on
        HV_ON_730n <= '0';
        FIL_ON_730n <= '0';
        EMS_PWR_ERROR <= '0';      -- good status
        RESET <= '1';             -- take out of reset state!
        wait;             -- wait forever; i.e. don't cycle
    end process;

    PENTEK_TIMING: process    -- Pentek Generated Timing Signals
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
        variable err : std_logic  := '0';
    begin

        WG_SW_NOISEn <= '1';  -- update switch status
        WG_SW_TERMn <= '0';
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
        -- Loop for 50 PRTs
        CNT := 0;
        while (CNT <= 50) loop
            wait for 320 ns;  -- 320 ns is max delay measured
-- Noise source cal
                if (CNT = 20) then
                    WG_SW_NOISEn <= '0';  -- update switch status
                    WG_SW_TERMn <= '1';
                    testbench_state <= 2;
                elsif (CNT = 50) then
                    OPS_MODE_730 <= o"3";
                    HVn_CMD_PENTEK <= '0';  -- Next ops mode is vertical tx, simultaneous receive
                    testbench_state <= 3;
                else
                    OPS_MODE_730 <= o"5"; -- keep in Noise source cal mode
                end if;
            BIT_EMS <= "0101101";
            if (CNT > 25) then
                assert EMS_OUT = "0101101" report "Bad EMS_OUT at 0101101" severity failure;
            end if;
            case CNT is --Trigger the error logic
                when 31 => BIT_EMS(1) <= '0';
                when 32 => BIT_EMS(2) <= '1';
                when 33 => BIT_EMS(3) <= '0';
                when 34 => BIT_EMS(4) <= '0';
                when 35 => BIT_EMS(5) <= '1';
                when 36 => BIT_EMS(6) <= '0';
                when 37 => BIT_EMS(7) <= '1';
                when others =>
            end case;
            wait for 1168 ns;
            BIT_EMS <= "0101101";
            if (CNT > 25) then
                assert EMS_OUT = "0101101" report "Bad EMS_OUT at 0101101" severity failure;
            end if;
            case CNT is
                when 38 => BIT_EMS(1) <= '0';
                when 39 => BIT_EMS(2) <= '1';
                when 40 => BIT_EMS(3) <= '0';
                when 41 => BIT_EMS(4) <= '0';
                when 42 => BIT_EMS(5) <= '1';
                when 43 => BIT_EMS(6) <= '0';
                when 44 => BIT_EMS(7) <= '1';
                when others =>
            end case;
            wait for 99788 ns;
            err := EMS_ERROR_1 or EMS_ERROR_2 or EMS_ERROR_3 or EMS_ERROR_45 or EMS_ERROR_67;
            if (CNT < 31 or CNT > 44) then
                assert err = '0' report "Unexpected EMS error" severity failure;
            else
                assert err = '1' report "EMS error not detected" severity failure;
            end if;
            STATUS_ACK <= '1';  -- clear status every PRT for testing
            wait for 100 ns;
            STATUS_ACK <= '0';
            CNT := CNT + 1;
    end loop;

testbench_state <= 4;

    CNT := 0;
    while (CNT < 8) loop
        wait for 320 ns;  -- 320 ns is max delay measured
        if (CNT = 2) then
                WG_SW_NOISEn <= '1';  -- update switch status;
                WG_SW_TERMn <= '0';
        end if;
-- Vertical Tx, simultaneous receive
        OPS_MODE_730 <= o"4";
        HVn_CMD_PENTEK <= '0';        -- Next ops mode is corner reflector cal, vertical tx
        BIT_EMS <= "0101110";
        assert EMS_OUT = "0101110" or cnt < 3 report "Bad EMS_OUT at 0101110" severity failure;
        wait for 1168 ns;
        BIT_EMS <= "1010011";
        assert EMS_OUT = "1010011" or cnt < 3 report "Bad EMS_OUT at 1010011" severity failure;
        wait for 99788 ns;
        STATUS_ACK <= '1';  -- clear status every PRT for testing
        wait for 100 ns;
        STATUS_ACK <= '0';
        testbench_state <= 5;
-- Corner reflector cal, vertical tx w/reduced power on receive
        wait for 320 ns;  -- 320 ns is max delay measured
        OPS_MODE_730 <= o"6"; -- Next ops mode is Test Mode, no tx
        BIT_EMS <= "0101110";
        assert EMS_OUT = "0101110" or cnt < 3 report "Bad EMS_OUT at 0101110" severity failure;
        wait for 1168 ns;
        BIT_EMS <= "0000011";
        assert EMS_OUT = "0000011" or cnt < 3 report "Bad EMS_OUT at 0000011" severity failure;
        wait for 99788 ns;
        STATUS_ACK <= '1';  -- clear status every PRT for testing
        wait for 100 ns;
        STATUS_ACK <= '0';
        testbench_state <= 6;
-- Test Mode, no tx
        wait for 320 ns;  -- 320 ns is max delay measured
        OPS_MODE_730 <= o"3";
        HVn_CMD_PENTEK <= '1';  -- Next ops mode is horizontal tx, simultaneous receive
        BIT_EMS <= "0101110";
        assert EMS_OUT = "0101110" or cnt < 3 report "Bad EMS_OUT at 0101110" severity failure;
        wait for 1168 ns;
        BIT_EMS <= "1010011";
        assert EMS_OUT = "1010011" or cnt < 3 report "Bad EMS_OUT at 1010011" severity failure;
        wait for 99788 ns;
        STATUS_ACK <= '1';  -- clear status every PRT for testing
        wait for 100 ns;
        STATUS_ACK <= '0';
-- Transmit Mode, horizontal tx
        wait for 320 ns;  -- 320 ns is max delay measured
        OPS_MODE_730 <= o"3";
        HVn_CMD_PENTEK <= '0';  -- Next ops mode is HHVV V tx, simultaneous receive
        BIT_EMS <= "0101001";
        assert EMS_OUT = "0101001" or cnt < 3 report "Bad EMS_OUT at 0101001" severity failure;
        wait for 1168 ns;
        BIT_EMS <= "1010010";
        assert EMS_OUT = "1010010" or cnt < 3 report "Bad EMS_OUT at 1010010" severity failure;
        wait for 99788 ns;
        STATUS_ACK <= '1';  -- clear status every PRT for testing
        wait for 100 ns;
        STATUS_ACK <= '0';
-- Transmit Mode, HHVV
        wait for 320 ns;  -- 320 ns is max delay measured
        OPS_MODE_730 <= o"3";
        HVn_CMD_PENTEK <= '1';  -- Next ops mode is HHVV H tx, simultaneous receive
        BIT_EMS <= "0101110";
        assert EMS_OUT = "0101110" or cnt < 3 report "Bad EMS_OUT at 0101110" severity failure;
        wait for 1168 ns;
        BIT_EMS <= "1010011";
        assert EMS_OUT = "1010011" or cnt < 3 report "Bad EMS_OUT at 1010011" severity failure;
        wait for 99788 ns;
        STATUS_ACK <= '1';  -- clear status every PRT for testing
        wait for 100 ns;
        STATUS_ACK <= '0';

        wait for 320 ns;  -- 320 ns is max delay measured
        OPS_MODE_730 <= o"3";
        HVn_CMD_PENTEK <= '1';  -- Next ops mode is HHVV H tx, simultaneous receive
        BIT_EMS <= "0101001";
        assert EMS_OUT = "0101001" or cnt < 3 report "Bad EMS_OUT at 0101001" severity failure;
        wait for 1168 ns;
        BIT_EMS <= "1010010";
        assert EMS_OUT = "1010010" or cnt < 3 report "Bad EMS_OUT at 1010010" severity failure;
        wait for 99788 ns;
        STATUS_ACK <= '1';  -- clear status every PRT for testing
        wait for 100 ns;
        STATUS_ACK <= '0';

        wait for 320 ns;  -- 320 ns is max delay measured
        OPS_MODE_730 <= o"3";
        HVn_CMD_PENTEK <= '0';  -- Next ops mode is HHVV V tx, simultaneous receive
        BIT_EMS <= "0101001";
        assert EMS_OUT = "0101001" or cnt < 3 report "Bad EMS_OUT at 0101001" severity failure;
        wait for 1168 ns;
        BIT_EMS <= "1010010";
        assert EMS_OUT = "1010010" or cnt < 3 report "Bad EMS_OUT at 1010010" severity failure;
        wait for 99788 ns;
        STATUS_ACK <= '1';  -- clear status every PRT for testing
        wait for 100 ns;
        STATUS_ACK <= '0';

        wait for 320 ns;  -- 320 ns is max delay measured
        OPS_MODE_730 <= o"3";
        HVn_CMD_PENTEK <= '0';  -- Next ops mode is vertical tx, simultaneous receive
        BIT_EMS <= "0101110";
        assert EMS_OUT = "0101110" or cnt < 3 report "Bad EMS_OUT at 0101110" severity failure;
        wait for 1168 ns;
        BIT_EMS <= "1010011";
        assert EMS_OUT = "1010011" or cnt < 3 report "Bad EMS_OUT at 1010011" severity failure;
        wait for 99788 ns;
        STATUS_ACK <= '1';  -- clear status every PRT for testing
        wait for 100 ns;
        STATUS_ACK <= '0';
        CNT := CNT + 1;
    end loop;
        assert false report "(NO ERROR) End of stimulus" severity failure;
    end process;
END;

