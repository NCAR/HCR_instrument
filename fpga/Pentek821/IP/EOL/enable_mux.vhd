--
-- enable_mux.vhd
--    Author: Adam Karboski <karboski@ucar.edu>
--
-- Copyright (c) 2021 University Corporation for Atmospheric Research
-- All rights reserved.

library ieee;
use ieee.std_logic_1164.all;

entity enable_mux is
  generic (
    n : integer := 32
  );
  port (
    EN : in    std_logic;
    I  : in    std_logic_vector(n-1 downto 0);
    O  : out   std_logic_vector(n-1 downto 0)
  );
end entity;

architecture enable_mux of enable_mux is
begin

  O <= I when EN='1' else (others=>'0');

end architecture;
