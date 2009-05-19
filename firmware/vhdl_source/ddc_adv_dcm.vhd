----********************************************************************************************
-- Red Rapids
-- 797 N. Grove Rd, Suite 101
-- Richardson, TX 75081
-- www.redrapids.com (support@redrapids.com)
--
-- File: ddc_adv_dcm.vhd - Release DSK-320-003-R05 - Thu Dec 21 17:19:56 CST 2006
--


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use IEEE.numeric_std.all; 

Library UNISIM; 
use UNISIM.Vcomponents.all; 


entity DDC_ADV_DCM is
	GENERIC(
		 CLKIN_PERIOD 	  		: real := 8.0;  -- 8.0 nanoseconds
		 DLL_FREQUENCY_MODE	: string := "LOW" ;
		 DFS_FREQUENCY_MODE	: string := "LOW" ;
		 CLKDV_DIVIDE        : real := 8.0;
		 CLKFX_MULTIPLY		: integer := 2;
		 CLKFX_DIVIDE			: integer := 4;
		 PHASE_SHIFT        	: integer := 0);

	PORT (
			Rst		  	: in std_logic;
			Adc_clk		: in std_logic;
--			Filter_clk	: out std_logic;
			Timer_clk	: out std_logic;
			Start_clk   : out std_logic;
			Locked		: out std_logic
			);			
end DDC_ADV_DCM;
    	
architecture BEHAVIORAL of DDC_ADV_DCM is     		

	signal ddc_dcm_clk0		: std_logic;
--	signal ddc_dcm_clk2x 	: std_logic;
	signal ddc_dcm_clkfx 	: std_logic;
	signal ddc_clk_fb			: std_logic;
	signal ddc_dcm_clk8d    : std_logic;
	
begin 
	ADC_CLK_BUFG_INST 		: BUFG 
	PORT MAP(I => ddc_dcm_clk0, O => ddc_clk_fb);

	START_CLK_BUFG_INST  	: BUFG 
	PORT MAP(I => ddc_dcm_clk8d, O => Start_clk);
	
--	FILTER_CLK_BUFG_INST    : BUFG 
--	PORT MAP(I => ddc_dcm_clk2x, O => Filter_clk);

	TIMER_CLK_BUFG_INST  	: BUFG 
	PORT MAP(I => ddc_dcm_clkfx, O => Timer_clk);
	
	
	
	DCM_ADV_HI_INST : DCM_ADV
	    GENERIC MAP (
	       CLKIN_PERIOD 	   	=> CLKIN_PERIOD,	-- 125 MHz  
	       DLL_FREQUENCY_MODE  => DLL_FREQUENCY_MODE,
	       DFS_FREQUENCY_MODE  => DFS_FREQUENCY_MODE,
			 CLKDV_DIVIDE        => CLKDV_DIVIDE,
	       CLKOUT_PHASE_SHIFT  => "FIXED",
	       CLKFX_MULTIPLY		=> CLKFX_MULTIPLY,
			 CLKFX_DIVIDE			=> CLKFX_DIVIDE,
	       PHASE_SHIFT         => PHASE_SHIFT) 
		PORT MAP (
				RST          =>  Rst,
	       	PSCLK        =>  '0',
		   	PSEN         =>  '0',
		   	PSINCDEC     =>  '0',
		        
		   	CLKIN        =>  ADC_clk,
		   	CLKFB        =>  ddc_clk_fb,
		   
		   	LOCKED       =>  Locked,
				CLK0         =>  ddc_dcm_clk0,
				CLKDV        =>  ddc_dcm_clk8d,
				CLK180       =>  open,
				CLK270       =>  open,
--				CLK2X        =>  ddc_dcm_clk2x,
				CLK2X        =>  open,
				CLK2X180     =>  open,
				CLK90        =>  open,
				CLKFX        =>  ddc_dcm_clkfx,
				CLKFX180     =>  open);
        
end BEHAVIORAL;
    	
    	