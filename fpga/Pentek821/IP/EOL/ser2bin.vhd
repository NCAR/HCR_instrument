----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:33:26 05/27/2014 
-- Design Name: 
-- Module Name:    ser2bin - Behavioral 
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
USE IEEE.std_logic_arith.all;
USE IEEE.std_logic_unsigned.all;

library work;
use work.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
-- use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ser2bin is
    Generic (   
        N : positive := 16;                                             -- 16bit serial word length is default
        CPOL : std_logic := '0';                                        -- SPI mode selection (mode 0 default)
        CPHA : std_logic := '0';                                        -- CPOL = clock polarity, CPHA = clock phase.
        PREFETCH : positive := 3);                                      -- prefetch lookahead cycles
		  
    Port ( RESET : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           AZ_MOSI : in  STD_LOGIC;
           AZ_SCK : in  STD_LOGIC;
           AZ_SSEL : in  STD_LOGIC;
           EL_MOSI : in  STD_LOGIC;
           EL_SCK : in  STD_LOGIC;
           EL_SSEL : in  STD_LOGIC;
           DATA_STROBE : in  STD_LOGIC;
           AZ_POS : out  STD_LOGIC_VECTOR (31 downto 0);
           EL_POS : out  STD_LOGIC_VECTOR (31 downto 0);
           HSKP1 : out  STD_LOGIC_VECTOR (31 downto 0);
           HSKP2 : out  STD_LOGIC_VECTOR (31 downto 0);
           HSKP3 : out  STD_LOGIC_VECTOR (31 downto 0);
           HSKP4 : out  STD_LOGIC_VECTOR (31 downto 0));
end ser2bin;

architecture Behavioral of ser2bin is

-- Component Declarations
Component ser2bin_spi is
    Generic (   
    N : positive := 32;                                             -- 32bit serial word length is default
    CPOL : std_logic := '0';                                        -- SPI mode selection (mode 0 default)
    CPHA : std_logic := '0';                                        -- CPOL = clock polarity, CPHA = clock phase.
    PREFETCH : positive := 3);                                      -- prefetch lookahead cycles
Port (  
    clk_i : in std_logic := 'X';                                    -- internal interface clock (clocks di/do registers)
    spi_ssel_i : in std_logic := 'X';                               -- spi bus slave select line
    spi_sck_i : in std_logic := 'X';                                -- spi bus sck clock (clocks the shift register core)
    spi_mosi_i : in std_logic := 'X';                               -- spi bus mosi input
    spi_miso_o : out std_logic := 'X';                              -- spi bus spi_miso_o output
    di_req_o : out std_logic;                                       -- preload lookahead data request line
    di_i : in  std_logic_vector (N-1 downto 0) := (others => 'X');  -- parallel load data in (clocked in on rising edge of clk_i)
    wren_i : in std_logic := 'X';                                   -- user data write enable
    wr_ack_o : out std_logic;                                       -- write acknowledge
    do_valid_o : out std_logic;                                     -- do_o data valid strobe, valid during one clk_i rising edge.
    do_o : out  std_logic_vector (N-1 downto 0);                    -- parallel output (clocked out on falling clk_i)
    --- debug ports: can be removed for the application circuit ---
    do_transfer_o : out std_logic;                                  -- debug: internal transfer driver
    wren_o : out std_logic;                                         -- debug: internal state of the wren_i pulse stretcher
    rx_bit_next_o : out std_logic;                                  -- debug: internal rx bit
    state_dbg_o : out std_logic_vector (5 downto 0);                -- debug: internal state register
    sh_reg_dbg_o : out std_logic_vector (N-1 downto 0)              -- debug: internal shift register
);                    
end component;


-- Signal Definitions

signal az_do_o : std_logic_vector (N-1 downto 0);		-- SPI target parallel data out
signal el_do_o : std_logic_vector (N-1 downto 0);		-- SPI target parallel data out
signal az_o : std_logic_vector (N-1 downto 0);			-- Synchronized angle
signal el_o : std_logic_vector (N-1 downto 0);			-- Synchronized angle
signal az_temp : std_logic_vector (N-1 downto 0);  	-- temporary angle
signal el_temp : std_logic_vector (N-1 downto 0);  	-- temporary angle
signal az_cookie : std_logic_vector (N-1 downto 0) := x"FFFF";  	-- Az sync cookie
signal el_cookie : std_logic_vector (N-1 downto 0) := x"FFFF";  	-- El sync cookie
signal az_do_valid_o : std_logic;							-- SPI target valid data strobe
signal el_do_valid_o : std_logic;							-- SPI target valid data strobe
signal az_do_transfer_o : std_logic;
signal el_do_transfer_o : std_logic;
-- signal di_req_s : std_logic;
-- signal wren_s : std_logic := '0';
signal az_wren_o : std_logic := 'U';
signal el_wren_o : std_logic := 'U';
-- signal wren_ack_o_s : std_logic := 'U';
signal az_rx_bit_next_o : std_logic;
signal el_rx_bit_next_o : std_logic;
signal az_state_dbg_o : std_logic_vector (5 downto 0);
signal el_state_dbg_o : std_logic_vector (5 downto 0);

-- Az state machine; reads Az angle from Az SPI I/F
TYPE az_type is (az0,az1,az2,az3,az4);
SIGNAL az_state: az_type;

-- El state machine; reads El angle from El SPI I/F
TYPE el_type is (el0,el1,el2,el3,el4);
SIGNAL el_state: el_type;

begin

-- Component Instantiations

-- Azimuth SPI target I/F; receive only, transmit not supported!
 AZ_spi: ser2bin_spi
     generic map (N => N, CPOL => CPOL, CPHA => CPHA, PREFETCH => PREFETCH)
        port map(
            clk_i => CLK,
            spi_ssel_i => AZ_SSEL,
            spi_sck_i => AZ_SCK,
            spi_mosi_i => AZ_MOSI,
            spi_miso_o => open,
				di_req_o => open,
            di_i => open,
            wren_i => open,
            do_valid_o => az_do_valid_o,
            do_o => az_do_o,
            ----- debug -----
            do_transfer_o => az_do_transfer_o,
            wren_o => az_wren_o,
--          wren_ack_o => s_wren_ack_o,
--          rx_bit_reg_o => s_rx_bit_reg_o,
            rx_bit_next_o => az_rx_bit_next_o,				
            state_dbg_o => az_state_dbg_o
--            sh_reg_dbg_o => s_sh_reg_dbg_o
        );
		  
-- Elevation SPI target I/F; receive only, transmit not supported!
 EL_spi: ser2bin_spi
     generic map (N => N, CPOL => CPOL, CPHA => CPHA, PREFETCH => PREFETCH)
        port map(
            clk_i => CLK,
            spi_ssel_i => EL_SSEL,
            spi_sck_i => EL_SCK,
            spi_mosi_i => EL_MOSI,
            spi_miso_o => open,
				di_req_o => open,
            di_i => open,
            wren_i => open,
            do_valid_o => el_do_valid_o,
            do_o => el_do_o,
            ----- debug -----
            do_transfer_o => el_do_transfer_o,
            wren_o => el_wren_o,
--          wren_ack_o => s_wren_ack_o,
--          rx_bit_reg_o => s_rx_bit_reg_o,
            rx_bit_next_o => el_rx_bit_next_o,				
            state_dbg_o => el_state_dbg_o
--            sh_reg_dbg_o => s_sh_reg_dbg_o
        );
		  
LATCH_POS: process(RESET,CLK,DATA_STROBE,az_o,el_o)
begin
	if (RESET = '1') then
		AZ_POS <= (others => '0');
		EL_POS <= (others => '0');		
	elsif (rising_edge (CLK)) then
		if (DATA_STROBE = '1') then
			AZ_POS(15 downto 0) <= az_o;
			EL_POS(15 downto 0) <= el_o;
		end if;		
	end if;	
end process;

L_AZ_TEMP : process (RESET,CLK,az_do_o,az_do_valid_o)
begin
		if RESET = '1' then
			az_temp <= x"0000";
		elsif (rising_edge (CLK) and az_do_valid_o = '1') then     -- if strobe is valid, latch parallel data from SPI target
			az_temp <= az_do_o;						
		end if;
end process;

L_EL_TEMP : process (RESET,CLK,el_do_o,el_do_valid_o)
begin
		if RESET = '1' then
			el_temp <= x"0000";
		elsif (rising_edge (CLK) and el_do_valid_o = '1') then     -- if strobe is valid, latch parallel data from SPI target
			el_temp <= el_do_o;						
		end if;
end process;

-- Replace these lines with Az and El state machines, once multi-word serial format is supported by SPI Master
az_o <= az_temp;
el_o <= el_temp;
HSKP1 <= x"a5a5a5a5";
HSKP2 <= x"5a5a5a5a";
HSKP3 <= x"12345678";
HSKP4 <= x"9abcdef0";

---- Azimuth State Machine
--AZ_STATE_MACHINE: process (RESET,CLK,az_state,az_temp,az_do_valid_o,az_do_o,az_cookie)
--begin
--	if (RESET = '1') then
--		az_state <= az0;
--		az_temp <= x"0000";
--	elsif (rising_edge (CLK) and az_do_valid_o = '1') then
--		case Az_state is
--			when az0 =>
--				az_temp <= az_do_o;
--					if az_temp = az_cookie then
--						az_o <= az_temp;
--						az_state <= az1;		-- if sync'd goto next state
--					else
--						az_state <= az0;		-- otherwise wait to sync up
--					end if;
--			when az1 =>
--				az_temp <= az_do_o;
--				HSKP1 <= az_temp;
--				az_state <= az2;			
--			when az2 =>
--				az_temp <= az_do_o;
--				HSKP2 <= az_temp;
--					az_state <= az3;
--			when az3 =>
--				az_temp <= az_do_o;
--				HSKP3 <= az_temp;
--					az_state <= az4;
--			when az4 =>
--				az_temp <= az_do_o;
--				HSKP4 <= az_temp;
--					az_state <= az0;
--			when others =>
--					az_state <= az0;
--		end case;
--	end if;
--end process;
--
---- Elevation State Machine
--El_STATE_MACHINE: process (RESET,CLK,el_state,el_temp,el_do_valid_o,el_do_o,el_cookie)
--begin
--	if (RESET = '1') then
--		el_state <= el0;
--		el_temp <= x"0000";
--	elsif (rising_edge (CLK) and el_do_valid_o = '1') then
--		case El_state is
--			when el0 =>
--				el_temp <= el_do_o;
--					if el_temp = el_cookie then
--						el_o <= el_temp;
--						el_state <= el1;		-- if sync'd goto next state
--					else
--						el_state <= el0;		-- otherwise wait to sync up
--					end if;
--			when el1 =>
--				el_temp <= el_do_o;
--				HSKP1 <= el_temp;
--				el_state <= el2;			
--			when el2 =>
--				el_temp <= el_do_o;
--				HSKP2 <= el_temp;
--					el_state <= el3;
--			when el3 =>
--				el_temp <= el_do_o;
--				HSKP3 <= el_temp;
--					el_state <= el4;
--			when el4 =>
--				el_temp <= el_do_o;
--				HSKP4 <= el_temp;
--					el_state <= el0;
--			when others =>
--					el_state <= el0;
--		end case;
--	end if;
--end process;
		  
end Behavioral;

------------------------------ COPYRIGHT NOTICE -----------------------------------------------------------------------
--                                                                   
--      This file is part of the SPI MASTER/SLAVE INTERFACE project http://opencores.org/project,spi_master_slave                
--
--      Author(s):      Jonny Doin, jdoin@opencores.org, jonnydoin@gmail.com
--                                                                   
--      Copyright (C) 2011 Jonny Doin
--      -----------------------------
--                                                                   
--      This source file may be used and distributed without restriction provided that this copyright statement is not    
--      removed from the file and that any derivative work contains the original copyright notice and the associated 
--      disclaimer. 
--                                                                   
--      This source file is free software; you can redistribute it and/or modify it under the terms of the GNU Lesser 
--      General Public License as published by the Free Software Foundation; either version 2.1 of the License, or 
--      (at your option) any later version.
--                                                                   
--      This source is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied
--      warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more  
--      details.
--
--      You should have received a copy of the GNU Lesser General Public License along with this source; if not, download 
--      it from http://www.gnu.org/licenses/lgpl.txt
--                                                                   
-----------------------------------------------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity ser2bin_spi is
    Generic (   
        N : positive := 32;                                             -- 32bit serial word length is default
        CPOL : std_logic := '0';                                        -- SPI mode selection (mode 0 default)
        CPHA : std_logic := '0';                                        -- CPOL = clock polarity, CPHA = clock phase.
        PREFETCH : positive := 3);                                      -- prefetch lookahead cycles
    Port (  
        clk_i : in std_logic := 'X';                                    -- internal interface clock (clocks di/do registers)
        spi_ssel_i : in std_logic := 'X';                               -- spi bus slave select line
        spi_sck_i : in std_logic := 'X';                                -- spi bus sck clock (clocks the shift register core)
        spi_mosi_i : in std_logic := 'X';                               -- spi bus mosi input
        spi_miso_o : out std_logic := 'X';                              -- spi bus spi_miso_o output
        di_req_o : out std_logic;                                       -- preload lookahead data request line
        di_i : in  std_logic_vector (N-1 downto 0) := (others => 'X');  -- parallel load data in (clocked in on rising edge of clk_i)
        wren_i : in std_logic := 'X';                                   -- user data write enable
        wr_ack_o : out std_logic;                                       -- write acknowledge
        do_valid_o : out std_logic;                                     -- do_o data valid strobe, valid during one clk_i rising edge.
        do_o : out  std_logic_vector (N-1 downto 0);                    -- parallel output (clocked out on falling clk_i)
        --- debug ports: can be removed for the application circuit ---
        do_transfer_o : out std_logic;                                  -- debug: internal transfer driver
        wren_o : out std_logic;                                         -- debug: internal state of the wren_i pulse stretcher
        rx_bit_next_o : out std_logic;                                  -- debug: internal rx bit
        state_dbg_o : out std_logic_vector (5 downto 0);                -- debug: internal state register
        sh_reg_dbg_o : out std_logic_vector (N-1 downto 0)              -- debug: internal shift register
    );                      
end ser2bin_spi;

--================================================================================================================
-- SYNTHESIS CONSIDERATIONS
-- ========================
-- There are several output ports that are used to simulate and verify the core operation. 
-- Do not map any signals to the unused ports, and the synthesis tool will remove the related interfacing
-- circuitry. 
-- The same is valid for the transmit and receive ports. If the receive ports are not mapped, the
-- synthesis tool will remove the receive logic from the generated circuitry.
-- Alternatively, you can remove these ports and related circuitry once the core is verified and
-- integrated to your circuit.
--================================================================================================================

architecture rtl of ser2bin_spi is
    -- constants to control FlipFlop synthesis
    constant SHIFT_EDGE  : std_logic := (CPOL xnor CPHA);   -- MOSI data is captured and shifted at this SCK edge
    constant CHANGE_EDGE : std_logic := (CPOL xor CPHA);    -- MISO data is updated at this SCK edge

    ------------------------------------------------------------------------------------------
    -- GLOBAL RESET:
    --      all signals are initialized to zero at GSR (global set/reset) by giving explicit
    --      initialization values at declaration. This is needed for all Xilinx FPGAs, and 
    --      especially for the Spartan-6 and newer CLB architectures, where a local reset can
    --      reduce the usability of the slice registers, due to the need to share the control
    --      set (RESET/PRESET, CLOCK ENABLE and CLOCK) by all 8 registers in a slice.
    --      By using GSR for the initialization, and reducing RESET local init to the really
    --      essential, the model achieves better LUT/FF packing and CLB usability.
    ------------------------------------------------------------------------------------------
    -- internal state signals for register and combinatorial stages
    signal state_next : natural range N downto 0 := 0;      -- state 0 is idle state
    signal state_reg : natural range N downto 0 := 0;       -- state 0 is idle state
    -- shifter signals for register and combinatorial stages
    signal sh_next : std_logic_vector (N-1 downto 0);
    signal sh_reg : std_logic_vector (N-1 downto 0);
    -- mosi and miso connections
    signal rx_bit_next : std_logic;                         -- sample of MOSI input
    signal tx_bit_next : std_logic;
    signal tx_bit_reg : std_logic;                          -- drives MISO during sequential logic
    signal preload_miso : std_logic;                        -- controls the MISO MUX
    -- buffered di_i data signals for register and combinatorial stages
    signal di_reg : std_logic_vector (N-1 downto 0);
    -- internal wren_i stretcher for fsm combinatorial stage
    signal wren : std_logic;
    signal wr_ack_next : std_logic := '0';
    signal wr_ack_reg : std_logic := '0';
    -- buffered do_o data signals for register and combinatorial stages
    signal do_buffer_next : std_logic_vector (N-1 downto 0);
    signal do_buffer_reg : std_logic_vector (N-1 downto 0);
    -- internal signal to flag transfer to do_buffer_reg
    signal do_transfer_next : std_logic := '0';
    signal do_transfer_reg : std_logic := '0';
    -- internal input data request signal 
    signal di_req_next : std_logic := '0';
    signal di_req_reg : std_logic := '0';
    -- cross-clock do_valid_o logic
    signal do_valid_next : std_logic := '0';
    signal do_valid_A : std_logic := '0';
    signal do_valid_B : std_logic := '0';
    signal do_valid_C : std_logic := '0';
    signal do_valid_D : std_logic := '0';
    signal do_valid_o_reg : std_logic := '0';
    -- cross-clock di_req_o logic
    signal di_req_o_next : std_logic := '0';
    signal di_req_o_A : std_logic := '0';
    signal di_req_o_B : std_logic := '0';
    signal di_req_o_C : std_logic := '0';
    signal di_req_o_D : std_logic := '0';
    signal di_req_o_reg : std_logic := '0';
begin
    --=============================================================================================
    --  GENERICS CONSTRAINTS CHECKING
    --=============================================================================================
    -- minimum word width is 8 bits
    assert N >= 8
    report "Generic parameter 'N' error: SPI shift register size needs to be 8 bits minimum"
    severity FAILURE;    
    -- maximum prefetch lookahead check
    assert PREFETCH <= N-5
    report "Generic parameter 'PREFETCH' error: lookahead count out of range, needs to be N-5 maximum"
    severity FAILURE;    

    --=============================================================================================
    --  GENERATE BLOCKS
    --=============================================================================================

    --=============================================================================================
    --  DATA INPUTS
    --=============================================================================================
    -- connect rx bit input
    rx_bit_proc : rx_bit_next <= spi_mosi_i;

    --=============================================================================================
    --  CROSS-CLOCK PIPELINE TRANSFER LOGIC
    --=============================================================================================
    -- do_valid_o and di_req_o strobe output logic
    -- this is a delayed pulse generator with a ripple-transfer FFD pipeline, that generates a 
    -- fixed-length delayed pulse for the output flags, at the parallel clock domain
    out_transfer_proc : process ( clk_i, do_transfer_reg, di_req_reg,
                                  do_valid_A, do_valid_B, do_valid_D, 
                                  di_req_o_A, di_req_o_B, di_req_o_D) is
    begin
        if clk_i'event and clk_i = '1' then                     -- clock at parallel port clock
            -- do_transfer_reg -> do_valid_o_reg
            do_valid_A <= do_transfer_reg;                      -- the input signal must be at least 2 clocks long
            do_valid_B <= do_valid_A;                           -- feed it to a ripple chain of FFDs
            do_valid_C <= do_valid_B;
            do_valid_D <= do_valid_C;
            do_valid_o_reg <= do_valid_next;                    -- registered output pulse
            --------------------------------
            -- di_req_reg -> di_req_o_reg
            di_req_o_A <= di_req_reg;                           -- the input signal must be at least 2 clocks long
            di_req_o_B <= di_req_o_A;                           -- feed it to a ripple chain of FFDs
            di_req_o_C <= di_req_o_B;                               
            di_req_o_D <= di_req_o_C;                               
            di_req_o_reg <= di_req_o_next;                      -- registered output pulse
        end if;
        -- generate a 2-clocks pulse at the 3rd clock cycle
        do_valid_next <= do_valid_A and do_valid_B and not do_valid_D;
        di_req_o_next <= di_req_o_A and di_req_o_B and not di_req_o_D;
    end process out_transfer_proc;
    -- parallel load input registers: data register and write enable
    in_transfer_proc: process (clk_i, wren_i, wr_ack_reg) is
    begin
        -- registered data input, input register with clock enable
        if clk_i'event and clk_i = '1' then
            if wren_i = '1' then
                di_reg <= di_i;                                 -- parallel data input buffer register
            end if;
        end  if;
        -- stretch wren pulse to be detected by spi fsm (ffd with sync preset and sync reset)
        if clk_i'event and clk_i = '1' then
            if wren_i = '1' then                                -- wren_i is the sync preset for wren
                wren <= '1';
            elsif wr_ack_reg = '1' then                         -- wr_ack is the sync reset for wren
                wren <= '0';
            end if;
        end  if;
    end process in_transfer_proc;

    --=============================================================================================
    --  REGISTER TRANSFER PROCESSES
    --=============================================================================================
    -- fsm state and data registers change on spi SHIFT_EDGE
    core_reg_proc : process (spi_sck_i, spi_ssel_i) is
    begin
        -- FFD registers clocked on SHIFT edge and cleared on idle (spi_ssel_i = 1)
        -- state fsm register (fdr)
        if spi_ssel_i = '1' then                                -- async clr
            state_reg <= 0;                                     -- state falls back to idle when slave not selected
        elsif spi_sck_i'event and spi_sck_i = SHIFT_EDGE then   -- on SHIFT edge, update state register
            state_reg <= state_next;                            -- core fsm changes state with spi SHIFT clock
        end if;
        -- FFD registers clocked on SHIFT edge
        -- rtl core registers (fd)
        if spi_sck_i'event and spi_sck_i = SHIFT_EDGE then      -- on fsm state change, update all core registers
            sh_reg <= sh_next;                                  -- core shift register
            do_buffer_reg <= do_buffer_next;                    -- registered data output
            do_transfer_reg <= do_transfer_next;                -- cross-clock transfer flag
            di_req_reg <= di_req_next;                          -- input data request
            wr_ack_reg <= wr_ack_next;                          -- wren ack for data load synchronization
        end if;
        -- FFD registers clocked on CHANGE edge and cleared on idle (spi_ssel_i = 1)
        -- miso MUX preload control register (fdp)
        if spi_ssel_i = '1' then                                -- async preset
            preload_miso <= '1';                                -- miso MUX sees top bit of parallel input when slave not selected
        elsif spi_sck_i'event and spi_sck_i = CHANGE_EDGE then  -- on CHANGE edge, change to tx_reg output
            preload_miso <= spi_ssel_i;                         -- miso MUX sees tx_bit_reg when it is driven by SCK
        end if;
        -- FFD registers clocked on CHANGE edge
        -- tx_bit register (fd)
        if spi_sck_i'event and spi_sck_i = CHANGE_EDGE then
            tx_bit_reg <= tx_bit_next;                          -- update MISO driver from the MSb
        end if;
    end process core_reg_proc;

    --=============================================================================================
    --  COMBINATORIAL LOGIC PROCESSES
    --=============================================================================================
    -- state and datapath combinatorial logic
    core_combi_proc : process ( sh_reg, sh_next, state_reg, tx_bit_reg, rx_bit_next, do_buffer_reg, 
                                do_transfer_reg, di_reg, di_req_reg, wren, wr_ack_reg) is
    begin
        -- all output signals are assigned to (avoid latches)
        sh_next <= sh_reg;                                              -- shift register
        tx_bit_next <= tx_bit_reg;                                      -- MISO driver
        do_buffer_next <= do_buffer_reg;                                -- output data buffer
        do_transfer_next <= do_transfer_reg;                            -- output data flag
        wr_ack_next <= wr_ack_reg;                                      -- write enable acknowledge
        di_req_next <= di_req_reg;                                      -- data input request
        state_next <= state_reg;                                        -- fsm control state
        case state_reg is
        
            when (N) =>                                                 -- deassert 'di_rdy' and stretch do_valid
                wr_ack_next <= '0';                                     -- acknowledge data in transfer
                di_req_next <= '0';                                     -- prefetch data request: deassert when shifting data
                tx_bit_next <= sh_reg(N-1);                             -- output next MSbit
                sh_next(N-1 downto 1) <= sh_reg(N-2 downto 0);          -- shift inner bits
                sh_next(0) <= rx_bit_next;                              -- shift in rx bit into LSb
                state_next <= state_reg - 1;                            -- update next state at each sck pulse
                
            when (N-1) downto (PREFETCH+3) =>                           -- remove 'do_transfer' and shift bits
                do_transfer_next <= '0';                                -- reset 'do_valid' transfer signal
                di_req_next <= '0';                                     -- prefetch data request: deassert when shifting data
                wr_ack_next <= '0';                                     -- remove data load ack for all but the load stages
                tx_bit_next <= sh_reg(N-1);                             -- output next MSbit
                sh_next(N-1 downto 1) <= sh_reg(N-2 downto 0);          -- shift inner bits
                sh_next(0) <= rx_bit_next;                              -- shift in rx bit into LSb
                state_next <= state_reg - 1;                            -- update next state at each sck pulse
                
            when (PREFETCH+2) downto 3 =>                               -- raise prefetch 'di_req_o' signal
                di_req_next <= '1';                                     -- request data in advance to allow for pipeline delays
                wr_ack_next <= '0';                                     -- remove data load ack for all but the load stages
                tx_bit_next <= sh_reg(N-1);                             -- output next MSbit
                sh_next(N-1 downto 1) <= sh_reg(N-2 downto 0);          -- shift inner bits
                sh_next(0) <= rx_bit_next;                              -- shift in rx bit into LSb
                state_next <= state_reg - 1;                            -- update next state at each sck pulse
                
            when 2 =>                                                   -- transfer received data to do_buffer_reg on next cycle
                di_req_next <= '1';                                     -- request data in advance to allow for pipeline delays
                wr_ack_next <= '0';                                     -- remove data load ack for all but the load stages
                tx_bit_next <= sh_reg(N-1);                             -- output next MSbit
                sh_next(N-1 downto 1) <= sh_reg(N-2 downto 0);          -- shift inner bits
                sh_next(0) <= rx_bit_next;                              -- shift in rx bit into LSb
                do_transfer_next <= '1';                                -- signal transfer to do_buffer on next cycle
                do_buffer_next <= sh_next;                              -- get next data directly into rx buffer
                state_next <= state_reg - 1;                            -- update next state at each sck pulse
                
            when 1 =>                                                   -- transfer rx data to do_buffer and restart if new data is written
                sh_next(0) <= rx_bit_next;                              -- shift in rx bit into LSb
                di_req_next <= '0';                                     -- prefetch data request: deassert when shifting data
                state_next <= N;                                  	    -- next state is top bit of new data
                if wren = '1' then                                      -- load tx register if valid data present at di_reg
                    wr_ack_next <= '1';                                 -- acknowledge data in transfer
                    sh_next(N-1 downto 1) <= di_reg(N-2 downto 0);      -- shift inner bits
                    tx_bit_next <= di_reg(N-1);                         -- first output bit comes from the MSb of parallel data
                else
                    wr_ack_next <= '0';                                 -- no data reload for continuous transfer mode
                    sh_next(N-1 downto 1) <= (others => '0');           -- clear transmit shift register
                    tx_bit_next <= '0';                                 -- send ZERO
                end if;
                
            when 0 =>                                                   -- idle state: start and end of transmission
                sh_next(0) <= rx_bit_next;                              -- shift in rx bit into LSb
                sh_next(N-1 downto 1) <= di_reg(N-2 downto 0);          -- shift inner bits
                tx_bit_next <= di_reg(N-1);                             -- first output bit comes from the MSb of parallel data
                wr_ack_next <= '1';                                     -- acknowledge data in transfer
                di_req_next <= '0';                                     -- prefetch data request: deassert when shifting data
                do_transfer_next <= '0';                                -- clear signal transfer to do_buffer
                state_next <= N;                                        -- next state is top bit of new data
                
            when others =>
                state_next <= 0;                                        -- safe state
                
        end case; 
    end process core_combi_proc;

    --=============================================================================================
    --  OUTPUT LOGIC PROCESSES
    --=============================================================================================
    -- data output processes
    do_o_proc :         do_o <= do_buffer_reg;                          -- do_o always available
    do_valid_o_proc:    do_valid_o <= do_valid_o_reg;                   -- copy registered do_valid_o to output
    di_req_o_proc:      di_req_o <= di_req_o_reg;                       -- copy registered di_req_o to output
    wr_ack_o_proc:      wr_ack_o <= wr_ack_reg;                         -- copy registered wr_ack_o to output

    -----------------------------------------------------------------------------------------------
    -- MISO driver process: preload top bit of parallel data to MOSI at reset
    -----------------------------------------------------------------------------------------------
    -- this is a MUX that selects the combinatorial next tx bit at reset, and the registered tx bit
    -- at sequential operation. The mux gives us a preload of the first bit, simplifying the shifter logic.
    spi_miso_o_proc: process (preload_miso, tx_bit_reg, di_reg) is 
    begin
        if preload_miso = '1' then
            spi_miso_o <= di_reg(N-1);                                  -- copy top bit of parallel data at reset
        else
            spi_miso_o <= tx_bit_reg;                                   -- copy top bit of shifter at sequential operation
        end if;
    end process spi_miso_o_proc;

    --=============================================================================================
    --  DEBUG LOGIC PROCESSES
    --=============================================================================================
    -- these signals are useful for verification, and can be deleted after debug.
    do_transfer_proc:   do_transfer_o <= do_transfer_reg;
    --state_debug_proc:   state_dbg_o <= std_logic_vector(to_unsigned(state_reg, 4)); -- export internal state to debug
    rx_bit_next_proc:   rx_bit_next_o <= rx_bit_next;
    wren_o_proc:        wren_o <= wren;
    sh_reg_debug_proc:  sh_reg_dbg_o <= sh_reg;                                     -- export sh_reg to debug
end architecture rtl;

