the values in test_parameters.txt will be used to fill values in 
param_record_type in the test bench. The parameters are listed as follows.  Each value must be in the format specified with no comma after it.
Eample list is shown below. Boolean values are true or false. All ulogic vaector values are to entered in as hex values with no leading 0x. For example
0xFE would be FE.

parameter fields:

    INDATA_GATE_LENGTH  : integer;                        -- Length in 16 byte samples of active gate time for input stream.
    INDATA_GATE_INACTIVETIME  : integer;                  -- Length in 16 byte samples of inactive gate time between active gates. (must be multiple of  input_data_stream_width)
    INDATA_GATE_REPEAT  : integer;                        -- number of times to repeat the active gate period. 
    PCIE_MAX_PAYLOAD_SIZE: std_ulogic_vector(2 downto 0); -- Controls maximum PCIe payload size allowed. Comes from PCIe Core.
    LINK_START_ADDRESS  : std_ulogic_vector(15 downto 0); -- First Linked List Descriptor address (must be on 64 byte boundaries)  
    PCIE_A_Address      : std_ulogic_vector(63 downto 0); -- PCIe Destination Start Address to program in first descriptor (DWORD address boundary) 
    PCIE_A_MetaAddress  : std_ulogic_vector(63 downto 0); -- PCIe Meta Data Destination Start Address to program in first descriptor (must be DWORD address boundary)   
    BufferA_ByteSize    : integer range 1 to 16383;      -- Buffer A bytes to transfer. (limited in size for test) to program first descriptor with
    PCIE_B_Address      : std_ulogic_vector(63 downto 0); -- PCIe Destination Start Address to program in second descriptor (DWORD address boundary)               
    PCIE_B_MetaAddress  : std_ulogic_vector(63 downto 0); -- PCIe Meta Data Destination Start Address to program in second descriptor (must be DWORD address boundary)   
    BufferB_ByteSize    : integer range 1 to 16383;      -- Buffer B bytes to transfer. (limited in size for test) to program second descriptor with                       
    A_AUTO              : boolean;                     -- First Descriptor Auto Mode (test does not yet support manual setting '0')
    A_WRITE_META        : boolean;                     -- First Descriptor Write Meta Data Enable  
    A_INCR_MODE         : boolean;                     -- First Descriptor Loop Increment Mode
    A_SOP_START         : boolean;                     -- First Descriptor Start when an SOP is reached in data stream
    A_EOP_END           : boolean;                     -- First Descriptor End when an EOP is reached in data stream
    A_LINK_END_INT_EN   : boolean;                     -- First Descriptor Enable Link End Interrupt 
    A_CHAIN_END_INT_EN  : boolean;                     -- First Descriptor Enable Chain End Interrupt 
    A_CHAIN_END         : boolean;                     -- First Descriptor Is End of Chain. 
    A_LOOP_LENGTH       : integer range 0 to 16383;      -- First Descriptor number of times to loop in Loop Increment Mode (# loops -1)
    A_LOOP_ADDR_INCR    : std_ulogic_vector(31 downto 0); -- First Descriptor number of bytes to increment address in loop increment mode.      
    B_AUTO              : boolean;                     -- Second Descriptor Auto Mode (test does not yet support manual setting '0')
    B_WRITE_META        : boolean;                     -- Second Descriptor Write Meta Data Enable           
    B_INCR_MODE         : boolean;                     -- Second Descriptor Loop Increment Mode      
    B_SOP_START         : boolean;                     -- Second Descriptor Start when an SOP is reached in data stream
    B_EOP_END           : boolean;                     -- Second Descriptor End when an EOP is reached in data stream                                                                                         
    B_LINK_END_INT_EN   : boolean;                     -- Second Descriptor Enable Link End Interrupt                                        
    B_CHAIN_END_INT_EN  : boolean;                     -- Second Descriptor Enable Chain End Interrupt                                       
    B_CHAIN_END         : boolean;                     -- Second Descriptor Is End of Chain.                                                                                                 
    B_LOOP_LENGTH       : integer range 0 to 16383;      -- Second Descriptor number of times to loop in Loop Increment Mode (# loops -1)      
    B_LOOP_ADDR_INCR    : std_ulogic_vector(31 downto 0); -- Second Descriptor number of bytes to increment address in loop increment mode.

Example:

64
8
2
1
0000
00000000C0000000
00000000D0000000
1024
00000000E0000EF0
00000000F0000000
513
true
true
false
false
false
true
false
false
5
00000400
true
true
false
false
false
true
false
false
5
00000400
