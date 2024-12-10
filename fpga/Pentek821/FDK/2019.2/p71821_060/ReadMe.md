
Digital Transceiver

A. Karboski, 3/28/2018

    
Building

    Open the project in Vivado 2017.2
    
    Click 'Generate Bitstream'. This will run all the requisite steps and copy the output to the bitstream folder.
    
    Alternate flow for chipscope:
    
      Click 'Run Synthesis'.
    
      After synthesis, mark debug nets and set up debug. Save the constraints.
    
      Run the following from the TCL console:
      source [path]/FDK/2017.2/p71821_060/implement.tcl
    
Coding

    When you change an IP, you must execute 'Refresh IP Repository' then 'Report IP Status' then upgrade any changed IP.
    Sometimes you may need to reset the output products of the affected BDs at this point. In rare cases I had to delete the project's cache directory.
    


    

