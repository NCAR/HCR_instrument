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
        SYNC_PULSE_CLK    : in  std_logic; -- 217.01389 kHz clock; 125 MHz/8/72
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

    signal count : integer := 0;
    
    signal force_ems_error_vector : std_logic_vector(7 downto 1) := (others => '0');
    signal force_wg_error : std_logic := '0';


    -- Enumeration of OPS_MODE_730
    constant OPS_730_RESET          : std_logic_vector(2 downto 0) := o"0"; -- Reset mode
    constant OPS_730_SPARE1         : std_logic_vector(2 downto 0) := o"1"; -- Spare mode
    constant OPS_730_SPARE2         : std_logic_vector(2 downto 0) := o"2"; -- Spare mode
    constant OPS_730_TRANSMIT       : std_logic_vector(2 downto 0) := o"3"; -- Transmit HV?, receive H and V. HV? is determined by Pentek scheduler
    constant OPS_730_ATTENUATED     : std_logic_vector(2 downto 0) := o"4"; -- Corner reflector transmit HV?, receive H and V.
    constant OPS_730_NOISE          : std_logic_vector(2 downto 0) := o"5"; -- Noise source cal, no tx
    constant OPS_730_TEST           : std_logic_vector(2 downto 0) := o"6"; -- Test Mode, no tx
    constant OPS_730_ISOL_NOISE     : std_logic_vector(2 downto 0) := o"7"; -- vertical transmit, receive both, but enable noise source for testing

    -- Enumeration of pulse_mode. These are used internally and don't correspond to the 730 modes.
    constant NUM_PULSE_MODES        : integer := 8;
    constant PULSE_MODE_H_TX        : integer := 0;  -- horizontal transmit, receive both
    constant PULSE_MODE_V_TX        : integer := 1;  -- vertical transmit, receive both
    constant PULSE_MODE_CREF_H      : integer := 2;  -- Corner reflector horizontal transmit, receive both
    constant PULSE_MODE_CREF_V      : integer := 3;  -- Corner reflector cal, vertical tx w/increased NF
    constant PULSE_MODE_NOISE       : integer := 4;  -- Noise source cal, no tx
    constant PULSE_MODE_ISOL_NOISE  : integer := 5;  -- vertical transmit, receive both, but enable noise source for testing
    constant PULSE_MODE_TEST        : integer := 6;  -- Test Mode, no tx
    constant PULSE_MODE_EMS_RESET   : integer := 7;  -- Toggles all of the EMS lines, no tx

    type ems_type   is array(0 to NUM_PULSE_MODES-1) of std_logic_vector(7 downto 1);

    --Switch values for when EMS_TRIG = 0
    constant C_RX_EMS_SWITCH_VAL : ems_type := (
        PULSE_MODE_H_TX         => "1010010",
        PULSE_MODE_V_TX         => "1010011",
        PULSE_MODE_CREF_H       => "0000010",
        PULSE_MODE_CREF_V       => "0000011",
        PULSE_MODE_NOISE        => "0101101",
        PULSE_MODE_ISOL_NOISE   => "1010011",
        PULSE_MODE_TEST         => "1010011",
        PULSE_MODE_EMS_RESET    => "1010010",
        others                  => "0000000"
    );

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
        wait for 500 ns;
        FIL_ON_730n <= '0';
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
        --slightly different timing, in case it matters somehow
        T0 <= '1';
        wait for 64 ns;
        EMS_TRIG <= '1';
        wait for 64ns;
        T0 <= '0';
        wait for 272 ns;
        MOD_PULSE <= '1';
        wait for 512 ns;
        MOD_PULSE <= '0';
        wait for 256 ns;
        EMS_TRIG <= '0';
        wait for 128ns;
        RX_GATE <= '1';
        wait for 97152 ns;  -- 380 gates @ 256 ns/gate
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

    BIT_EMS <= (EMS_OUT xor force_ems_error_vector) after EXT_CLK_period*3;
    WG_SW_TERMn <= (WG_SW_CTRL_TERMn xor force_wg_error) after EXT_CLK_period*1000;
    WG_SW_NOISEn <= (WG_SW_CTRL_NOISEn xor force_wg_error) after EXT_CLK_period*1000;

    EMS_BIT: process
        variable CNT : integer range 0 to 1024;
        variable err : std_logic  := '0';
    begin

        OPS_MODE_730 <= OPS_730_RESET;
        wait until RX_GATE = '1';
        wait until RX_GATE = '0';
        HV_ON_730n <= '0';

        OPS_MODE_730 <= OPS_730_NOISE;
        for k in 1 to 40 loop
            wait until RX_GATE = '1';
            wait until RX_GATE = '0';
        end loop;
        
        OPS_MODE_730 <= OPS_730_TRANSMIT;
        for k in 1 to 100 loop
        
            -- test transmit EMS errors
            force_ems_error_vector <= "0000000";
            EMS_PWR_ERROR <= '0';
            case k is
                when 30 => force_ems_error_vector <= "0000001";
                when 33 => force_ems_error_vector <= "0000010";
                when 36 => force_ems_error_vector <= "0000100";
                when 39 => force_ems_error_vector <= "0001000";
                when 42 => force_ems_error_vector <= "0010000";
                when 45 => force_ems_error_vector <= "0100000";
                when 48 => force_ems_error_vector <= "1000000";
                when 51 => EMS_PWR_ERROR <= '1';
                when 82 => EMS_PWR_ERROR <= '1';
                when others =>
            end case;

            wait until RX_GATE = '1';
            if force_ems_error_vector /= "0000000" or ems_pwr_error /= '0' then
                assert MOD_PULSE_DISABLE = '1' report "Undetected TX EMS error at count " & integer'image(k) severity failure;
            end if;

            -- test receive EMS errors
            force_ems_error_vector <= "0000000";
            EMS_PWR_ERROR <= '0';
            HV_ON_730n <= '0';
            case k is
                when 60 => force_ems_error_vector <= "0000001";
                when 63 => force_ems_error_vector <= "0000010";
                when 66 => force_ems_error_vector <= "0000100";
                when 69 => force_ems_error_vector <= "0001000";
                when 72 => force_ems_error_vector <= "0010000";
                when 75 => force_ems_error_vector <= "0100000";
                when 78 => force_ems_error_vector <= "1000000";
                when 81 => EMS_PWR_ERROR <= '1';
                when 82 => EMS_PWR_ERROR <= '1';
                when 85 => HV_ON_730n <= '1';
                when others =>
            end case;
            
            wait for EXT_CLK_period*1000;

            if force_ems_error_vector /= "0000000" or ems_pwr_error /= '0' then
                assert EMS_ERROR_EVENT = '1' report "Undetected RX EMS error at count " & integer'image(k) severity failure;
            end if;
            
            STATUS_ACK <= '1';
            wait for EXT_CLK_period*2;
            HVn_CMD_PENTEK <= not HVn_CMD_PENTEK;
            STATUS_ACK <= '0';
            wait until RX_GATE = '0';
        end loop;
        
        OPS_MODE_730 <= OPS_730_ATTENUATED;
        for k in 1 to 20 loop
            wait until RX_GATE = '1';
            wait until RX_GATE = '0';
        end loop;
        
        OPS_MODE_730 <= OPS_730_TEST;
        for k in 1 to 20 loop
            wait until RX_GATE = '1';
            wait until RX_GATE = '0';
        end loop;        
        
        OPS_MODE_730 <= OPS_730_ISOL_NOISE;
        for k in 1 to 20 loop
            wait until RX_GATE = '1';
            wait until RX_GATE = '0';
        end loop;

        OPS_MODE_730 <= OPS_730_TRANSMIT;
        force_wg_error <= '1';
        for k in 1 to 40 loop

            wait until RX_GATE = '1';
            wait for EXT_CLK_period*1000;
            STATUS_ACK <= '1';
            wait for EXT_CLK_period*2;
            STATUS_ACK <= '0';
            wait until RX_GATE = '0';
            if k = 20 then 
                force_wg_error <= '0';
            end if;
        end loop;

        assert false report "Simulation completed successfully" severity failure;
        wait;

    end process;
END;

