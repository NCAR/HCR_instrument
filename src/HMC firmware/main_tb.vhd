--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:04:14 07/17/2012
-- Design Name:   
-- Module Name:   //cit/eol/EOL Documents Folders/paloma/My Documents/HCR/HCR_GATOR_BACKUP/three_input2/main_tb.vhd
-- Project Name:  three_input2
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: main_src
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
 
ENTITY main_tb IS
END main_tb;
 
ARCHITECTURE behavior OF main_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT main_src
    PORT(
			
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
				MOD_PULSE_DISABLE : out  STD_LOGIC;				-- Mod Pulse Status Bit
				STATUS : out  STD_LOGIC_VECTOR(2 downto 0);
				
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

    END COMPONENT;
    

   --Inputs

	signal STATUS_5V : std_logic := '1';
	signal STATUS_8V : std_logic := '1';
	signal STATUS_12V : std_logic := '1';
	signal STATUS_15V : std_logic := '1';
	signal STATUS_28V : std_logic := '1';
	signal EMS_TRIG : std_logic := '0';
	signal EXT_CLK : std_logic := '0';
	signal FIL_ON_730 : std_logic := '0';
	signal OPS_MODE_730 : std_logic_vector(1 downto 0) := "00";
	signal HV_ON_730 : std_logic := '1';
	signal BIT_EMS_P : std_logic_vector(7 downto 1);
	signal BIT_EMS_N : std_logic_vector(7 downto 1);
	signal SYNC_PULSE : std_logic := '0';
	signal MOD_PULSE : std_logic := '0';
	signal ONE_PPS : std_logic := '0';
   signal RX_GATE : std_logic := '0';
	signal T0 : std_logic := '0';
	signal RESET_730 : std_logic := '0';
	
 	--Outputs
   signal EMS_OUT : std_logic_vector(7 downto 1);
	signal SYNC_PULSE_OUT_P : std_logic;
	signal SYNC_PULSE_OUT_N : std_logic;
	signal MOD_PULSE_OUT_P : std_logic;
	signal MOD_PULSE_OUT_N : std_logic;
	signal STATUS : std_logic_vector(2 downto 0);
	signal SPARE1 : std_logic;		-- debug test signal
	signal SPARE2 : std_logic;		-- debug test signal
	signal SPARE3 : std_logic;		-- debug test signal
	signal SPARE4 : std_logic;		-- debug test signal
	signal SPARE5 : std_logic;		-- debug test signal
	signal SPARE6 : std_logic;		-- debug test signal
	signal SPARE7 : std_logic;		-- debug test signal
	-- Inouts 
     -- Clock period definitions
  constant EXT_CLK_period : time := 8 ns; -- clock period/2, clock is 62.5MHz,

-- Simulation based on 101376 ns PRT, 256 ns Tx pulsewidth

BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: main_src PORT MAP (
--			 RADAR_POWER_OK => RADAR_POWER_OK, 
			 STATUS_5V =>	STATUS_5V,
			 STATUS_8V =>	STATUS_8V, 
			 STATUS_12V =>	STATUS_12V,
			 STATUS_15V =>	STATUS_15V,  			 
			 STATUS_28V =>	STATUS_28V, 					 
			 MOD_PULSE_OUT_P => MOD_PULSE_OUT_P, 
			 MOD_PULSE_OUT_N => MOD_PULSE_OUT_N, 
			 SYNC_PULSE_OUT_P => SYNC_PULSE_OUT_P, 		
			 SYNC_PULSE_OUT_N => SYNC_PULSE_OUT_N,
			 ONE_PPS => ONE_PPS,
			 RX_GATE => RX_GATE,
			 T0 => T0,
			 MOD_PULSE => MOD_PULSE, 
			 SYNC_PULSE => SYNC_PULSE, 	
			 EMS_TRIG => EMS_TRIG,
			 EXT_CLK => EXT_CLK, 
			 HV_ON_730 => HV_ON_730, 
			 FIL_ON_730 => FIL_ON_730,
			 OPS_MODE_730 => OPS_MODE_730,
			 EMS_OUT => EMS_OUT,   
			 BIT_EMS_P => BIT_EMS_P,
			 RESET_730 => RESET_730,
			 STATUS => STATUS,
			 SPARE1 => SPARE1,
			 SPARE2 => SPARE2,
			 SPARE3 => SPARE3,
			 SPARE4 => SPARE4,
			 SPARE5 => SPARE5,
			 SPARE6 => SPARE6,	
			 SPARE7 => SPARE7,				 
			 BIT_EMS_N => BIT_EMS_N	 
			 
        );
 
	EXT_CLK_process :process
   begin
		EXT_CLK <= '1';
		wait for EXT_CLK_period;				
		EXT_CLK <= '0';
		wait for EXT_CLK_period;
	end process;
   
	HEART_BEAT: process -- one pps heartbeat, for now make it every prt
	begin
		ONE_PPS <= '1';
		wait for 101376 ns;
		ONE_PPS <= '0';
		wait for 101376 ns;
	end process;

	PMC_730: process	-- PMC730 generated command signals
   begin
		wait for 100 ns;
		RESET_730 <= '1'; -- reset firmware
		wait for 500 ns; -- turn HV_ON
		HV_ON_730 <= '0'; 
		STATUS_5V <= '0';  	-- good status	
		STATUS_28V <= '0';   -- good status	
		RESET_730 <= '0'; -- take out of reset state!
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
	begin
		wait for 320 ns;  -- 320 ns is max delay measured
		OPS_MODE_730 <= "01";
		BIT_EMS_N <= "0101110";
		BIT_EMS_P <= "1111111";
		wait for 1376 ns;
		BIT_EMS_N <= "1010011";
		BIT_EMS_P <= "1111111";
		wait for 99680 ns;
		wait for 320 ns;  -- 320 ns is max delay measured
		OPS_MODE_730 <= "10";
		BIT_EMS_N <= "0101101";
		BIT_EMS_P <= "1111111";
		wait for 1376 ns;
		BIT_EMS_N <= "0101101";
		BIT_EMS_P <= "1111111";
		wait for 99680 ns;		
		wait for 320 ns;  -- 320 ns is max delay measured
		OPS_MODE_730 <= "11";
		BIT_EMS_N <= "0101110";
		BIT_EMS_P <= "1111111";
		wait for 1376 ns;
		BIT_EMS_N <= "0000011";
		BIT_EMS_P <= "1111111";
		wait for 99680 ns;	
		wait for 320 ns;  -- 320 ns is max delay measured
		OPS_MODE_730 <= "00";
		BIT_EMS_N <= "0101110";
		BIT_EMS_P <= "1111111";
		wait for 1376 ns;
		BIT_EMS_N <= "1010011";
		BIT_EMS_P <= "1111111";
		wait for 99680 ns;				
	end process;  
END;
