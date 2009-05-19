-----------------------------------------------------------------
-- ***** VHDL for DDC User Block Module in Pentek Model 7142 ***** --
-- *********************** Signal FPGA *********************** --
-----------------------------------------------------------------
-- Title        : DDC User Block
-- Project      : Model 7142 Signal FPGA
-----------------------------------------------------------------
-- Filename     : DDC_USER_BLOCK.VHD
-- Author       : E. Loew
-- Created      : 12/3/08
-- Last Modified: 12/3/08
-- Modified by  : 
-----------------------------------------------------------------
--  Change log  :
--      
-----------------------------------------------------------------
-- This Module implements a digital downconverter (DDC) implemented in
-- Matlab System Generator. The DDC is comprised of a fixed decimating
-- polyphase Kaiser filter, which also produces quadrature signals, 
-- and a Gaussian filter which provides final filtering to match the
-- radar pulsewidth
-----------------------------------------------------------------

LIBRARY IEEE;
USE     IEEE.std_logic_1164.all;
USE     IEEE.std_logic_arith.all;
USE     IEEE.std_logic_unsigned.all;

ENTITY DDC_USER_BLOCK is
PORT (
    CLK             : in  std_logic;
    
	 FEN_IN          : in  std_logic;

    FIFO_DAT_IN     : in  std_logic_vector (31 downto 0);

    FIFO_DAT_OUT    : out std_logic_vector (31 downto 0);

    FEN_OUT         : out std_logic;
	 
	 CLK_12			  : in std_logic;

	 G_ADDR			  : in std_logic_vector(3 downto 0);

	 G_DATA    		  : in std_logic_vector(17 downto 0);

	 G_SEL			  : in std_logic_vector(1 downto 0);

	 G_WR				  : in std_logic;

	 K_ADDR   		  : in std_logic_vector(3 downto 0);

	 K_DATA			  : in std_logic_vector(17 downto 0);

	 K_SEL			  : in std_logic_vector(2 downto 0);

	 K_WR				  : in std_logic;

	 STOP				  : in std_logic;

	 G_READCOEF		  : out std_logic_vector(17 downto 0);

	 K_READCOEF		  : out std_logic_vector(17 downto 0);
	 
	 RX_GATE			  : in std_logic
    
	 );
END DDC_USER_BLOCK;


-----------------------------------------------------------------

ARCHITECTURE STRUCTURE of DDC_USER_BLOCK is

-----------------------------------------------------------------
-- ************** Main Architecture  Definition ************** --
-----------------------------------------------------------------

-- Insert DDC structure here
COMPONENT casc_filter_reva
PORT (

    Ce_1				  : in  std_logic;	
	 	
	 Ce_8				  : in  std_logic;	
	 
	 CHA_in			  : in std_logic_vector(13 downto 0);

	 Clk_1           : in  std_logic;

	 Clk_8			  : in std_logic;
	 
	 G_addr			  : in std_logic_vector(3 downto 0);

	 G_data    		  : in std_logic_vector(17 downto 0);

	 G_sel			  : in std_logic_vector(1 downto 0);

	 G_wr				  : in std_logic;

	 K_addr   		  : in std_logic_vector(3 downto 0);

	 K_data			  : in std_logic_vector(17 downto 0);

	 K_sel			  : in std_logic_vector(2 downto 0);

	 K_wr				  : in std_logic;

	 Stop				  : in std_logic;
	 
	 CHA_I_Out		  : out std_logic_vector(15 downto 0);
	 
	 CHA_Q_Out		  : out std_logic_vector(15 downto 0);

	 G_readcoef		  : out std_logic_vector(17 downto 0);

	 K_readcoef		  : out std_logic_vector(17 downto 0)
	
    );
END COMPONENT;

-- Signal Definitions
SIGNAL ddc_out		  : std_logic_vector(31 downto 0);

BEGIN

-- Instantiate DDC

    DDC_A : casc_filter_reva
    PORT MAP(

        Ce_1            => '1',
		  
		  Ce_8            => '1',
		  
        CHA_In     	   => Fifo_Dat_In(15 downto 2), -- for now only operates on unpacked data!

		  Clk_1			   => CLK,
		  
		  Clk_8			   => CLK_12,
        		   
		  G_addr			   => G_ADDR,
		  
		  G_data    		=> G_DATA,
		  
		  G_sel			   => G_SEL,
		  
		  G_wr				=> G_WR,
	 
	     K_addr   		   => K_ADDR,
	 
		  K_data			   => K_DATA,
	 
		  K_sel			   => K_SEL,
	 
		  K_wr				=> K_WR,
		  
		  Stop				=> STOP,

        CHA_I_Out	      => ddc_out(15 downto 0),
		  
		  CHA_Q_Out	      => ddc_out(31 downto 16),
	 
		  G_readcoef		=> G_READCOEF,  
	 
		  K_readcoef		=> K_READCOEF  
		  
    );
-- Pipeline FEN_IN to meet timing

PROCESS (CLK, FEN_IN, RX_GATE)
	BEGIN
		if (rising_edge(CLK)) then
			FEN_OUT         <= FEN_IN AND RX_GATE;
		end if;
END PROCESS;

-- Re-align DDC DATA with FEN_OUT

PROCESS (CLK, ddc_out)
	BEGIN
		if (rising_edge(CLK)) then
			FIFO_DAT_OUT 				<= ddc_out;
		end if;
END PROCESS;



END STRUCTURE;