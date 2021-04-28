library ieee;
use ieee.std_logic_1164.all;

use std.textio.all;
use work.txt_util.all;
 
 
entity FILE_LOG is
  generic (
         log_file:       string  := "data.txt";
         num_chan:       integer := 1;
         out_res :       integer := 1
        );
port(
     CLK              : in std_logic;
     RSTN             : in std_logic;
     valid            : in std_logic;
     data             : in std_logic_vector((num_chan*out_res)-1 downto 0)
      );
end FILE_LOG;
   
   
architecture log_to_file of FILE_LOG is
  signal internal_debug : std_logic :='0';
  
    file l_file: TEXT open write_mode is log_file;


begin



-- write data and control information to a file

receive_data: process

variable l: line;
   
begin                                       

   -- print header for the logfile
   print(l_file, "#  Valid Data: ");
   print(l_file, " ");


  -- wait until RSTN='0';
   wait until RSTN='1';

   
   while true loop
     if valid = '1' then
        internal_debug<= '1';
     -- write digital data into log file
       print(l_file, hstr(data)& "h");
     
     end if;
            wait until CLK = '1';

   end loop;

 end process receive_data;



end log_to_file;
 
