-- Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2017.2.1 (win64) Build 1957588 Wed Aug  9 16:32:24 MDT 2017
-- Date        : Thu Oct 26 16:19:56 2017
-- Host        : Mike-PC running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim
--               C:/pentek/ip/2017.2/wip/px_vita49_pkt/px_vita49_pkt.srcs/sources_1/ip/px_vita49_xpm_cdc_async_rst/px_vita49_xpm_cdc_async_rst_sim_netlist.vhdl
-- Design      : px_vita49_xpm_cdc_async_rst
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xcku035-ffva1156-2-e
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity px_vita49_xpm_cdc_async_rst_xpm_cdc_async_rst is
  port (
    src_arst : in STD_LOGIC;
    dest_clk : in STD_LOGIC;
    dest_arst : out STD_LOGIC
  );
  attribute DEF_VAL : string;
  attribute DEF_VAL of px_vita49_xpm_cdc_async_rst_xpm_cdc_async_rst : entity is "1'b1";
  attribute DEST_SYNC_FF : integer;
  attribute DEST_SYNC_FF of px_vita49_xpm_cdc_async_rst_xpm_cdc_async_rst : entity is 4;
  attribute INIT : string;
  attribute INIT of px_vita49_xpm_cdc_async_rst_xpm_cdc_async_rst : entity is "1";
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of px_vita49_xpm_cdc_async_rst_xpm_cdc_async_rst : entity is "xpm_cdc_async_rst";
  attribute RST_ACTIVE_HIGH : integer;
  attribute RST_ACTIVE_HIGH of px_vita49_xpm_cdc_async_rst_xpm_cdc_async_rst : entity is 0;
  attribute VERSION : integer;
  attribute VERSION of px_vita49_xpm_cdc_async_rst_xpm_cdc_async_rst : entity is 0;
  attribute XPM_MODULE : string;
  attribute XPM_MODULE of px_vita49_xpm_cdc_async_rst_xpm_cdc_async_rst : entity is "TRUE";
  attribute xpm_cdc : string;
  attribute xpm_cdc of px_vita49_xpm_cdc_async_rst_xpm_cdc_async_rst : entity is "ASYNC_RST";
end px_vita49_xpm_cdc_async_rst_xpm_cdc_async_rst;

architecture STRUCTURE of px_vita49_xpm_cdc_async_rst_xpm_cdc_async_rst is
  signal arststages_ff : STD_LOGIC_VECTOR ( 3 downto 0 );
  attribute RTL_KEEP : string;
  attribute RTL_KEEP of arststages_ff : signal is "true";
  attribute async_reg : string;
  attribute async_reg of arststages_ff : signal is "true";
  attribute xpm_cdc of arststages_ff : signal is "ASYNC_RST";
  signal reset_pol : STD_LOGIC;
  attribute ASYNC_REG_boolean : boolean;
  attribute ASYNC_REG_boolean of \arststages_ff_reg[0]\ : label is std.standard.true;
  attribute XPM_CDC of \arststages_ff_reg[0]\ : label is "ASYNC_RST";
  attribute ASYNC_REG_boolean of \arststages_ff_reg[1]\ : label is std.standard.true;
  attribute XPM_CDC of \arststages_ff_reg[1]\ : label is "ASYNC_RST";
  attribute ASYNC_REG_boolean of \arststages_ff_reg[2]\ : label is std.standard.true;
  attribute XPM_CDC of \arststages_ff_reg[2]\ : label is "ASYNC_RST";
  attribute ASYNC_REG_boolean of \arststages_ff_reg[3]\ : label is std.standard.true;
  attribute XPM_CDC of \arststages_ff_reg[3]\ : label is "ASYNC_RST";
begin
  dest_arst <= arststages_ff(3);
\arststages_ff[3]_i_1\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => src_arst,
      O => reset_pol
    );
\arststages_ff_reg[0]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '1'
    )
        port map (
      C => dest_clk,
      CE => '1',
      CLR => reset_pol,
      D => '1',
      Q => arststages_ff(0)
    );
\arststages_ff_reg[1]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '1'
    )
        port map (
      C => dest_clk,
      CE => '1',
      CLR => reset_pol,
      D => arststages_ff(0),
      Q => arststages_ff(1)
    );
\arststages_ff_reg[2]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '1'
    )
        port map (
      C => dest_clk,
      CE => '1',
      CLR => reset_pol,
      D => arststages_ff(1),
      Q => arststages_ff(2)
    );
\arststages_ff_reg[3]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '1'
    )
        port map (
      C => dest_clk,
      CE => '1',
      CLR => reset_pol,
      D => arststages_ff(2),
      Q => arststages_ff(3)
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity px_vita49_xpm_cdc_async_rst_px_xpm_cdc_async_rst is
  port (
    dest_arst : out STD_LOGIC;
    src_arst : in STD_LOGIC;
    dest_clk : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of px_vita49_xpm_cdc_async_rst_px_xpm_cdc_async_rst : entity is "px_xpm_cdc_async_rst";
end px_vita49_xpm_cdc_async_rst_px_xpm_cdc_async_rst;

architecture STRUCTURE of px_vita49_xpm_cdc_async_rst_px_xpm_cdc_async_rst is
  attribute DEF_VAL : string;
  attribute DEF_VAL of rst_inst : label is "1'b1";
  attribute DEST_SYNC_FF : integer;
  attribute DEST_SYNC_FF of rst_inst : label is 4;
  attribute INIT : string;
  attribute INIT of rst_inst : label is "1";
  attribute RST_ACTIVE_HIGH : integer;
  attribute RST_ACTIVE_HIGH of rst_inst : label is 0;
  attribute VERSION : integer;
  attribute VERSION of rst_inst : label is 0;
  attribute XPM_CDC : string;
  attribute XPM_CDC of rst_inst : label is "ASYNC_RST";
  attribute XPM_MODULE : string;
  attribute XPM_MODULE of rst_inst : label is "TRUE";
begin
rst_inst: entity work.px_vita49_xpm_cdc_async_rst_xpm_cdc_async_rst
     port map (
      dest_arst => dest_arst,
      dest_clk => dest_clk,
      src_arst => src_arst
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity px_vita49_xpm_cdc_async_rst is
  port (
    dest_clk : in STD_LOGIC;
    src_arst : in STD_LOGIC;
    dest_arst : out STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of px_vita49_xpm_cdc_async_rst : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of px_vita49_xpm_cdc_async_rst : entity is "px_vita49_xpm_cdc_async_rst,px_xpm_cdc_async_rst,{}";
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of px_vita49_xpm_cdc_async_rst : entity is "yes";
  attribute x_core_info : string;
  attribute x_core_info of px_vita49_xpm_cdc_async_rst : entity is "px_xpm_cdc_async_rst,Vivado 2017.2.1";
end px_vita49_xpm_cdc_async_rst;

architecture STRUCTURE of px_vita49_xpm_cdc_async_rst is
begin
U0: entity work.px_vita49_xpm_cdc_async_rst_px_xpm_cdc_async_rst
     port map (
      dest_arst => dest_arst,
      dest_clk => dest_clk,
      src_arst => src_arst
    );
end STRUCTURE;
