
/* This file was generated by CanFestival tools and should not be modified. */

#include "ElmoMasterNode.h"

/**************************************************************************/
/* Declaration of mapped variables                                        */
/**************************************************************************/
UNS64 ElmoMaster_PDOReplies[] =		/* Mapped at index 0x2000, subindex 0x01 - 0x04 */
  {
    0x0,	/* 0 */
    0x0,	/* 0 */
    0x0,	/* 0 */
    0x0	/* 0 */
  };

/**************************************************************************/
/* Declaration of value range types                                       */
/**************************************************************************/

#define valueRange_EMC 0x9F /* Type for index 0x1003 subindex 0x00 (only set of value 0 is possible) */
UNS32 ElmoMasterNode_valueRangeTest (UNS8 typeValue, void * value)
{
  switch (typeValue) {
    case valueRange_EMC:
      if (*(UNS8*)value != (UNS8)0) return OD_VALUE_RANGE_EXCEEDED;
      break;
  }
  return 0;
}

/**************************************************************************/
/* The node id                                                            */
/**************************************************************************/
/* node_id default value.*/
UNS8 ElmoMasterNode_bDeviceNodeId = 0x00;

/**************************************************************************/
/* Array of message processing information */

const UNS8 ElmoMasterNode_iam_a_slave = 0;

TIMER_HANDLE ElmoMasterNode_heartBeatTimers[4] = {TIMER_NONE,TIMER_NONE,TIMER_NONE,TIMER_NONE};

/*
$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

                               OBJECT DICTIONARY

$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
*/

/* index 0x1000 :   Device Type. */
                    UNS32 ElmoMasterNode_obj1000 = 0x0;	/* 0 */
                    subindex ElmoMasterNode_Index1000[] = 
                     {
                       { RO, uint32, sizeof (UNS32), (void*)&ElmoMasterNode_obj1000 }
                     };

/* index 0x1001 :   Error Register. */
                    UNS8 ElmoMasterNode_obj1001 = 0x0;	/* 0 */
                    subindex ElmoMasterNode_Index1001[] = 
                     {
                       { RO, uint8, sizeof (UNS8), (void*)&ElmoMasterNode_obj1001 }
                     };

/* index 0x1003 :   Pre-defined Error Field */
                    UNS8 ElmoMasterNode_highestSubIndex_obj1003 = 0; /* number of subindex - 1*/
                    UNS32 ElmoMasterNode_obj1003[] = 
                    {
                      0x0	/* 0 */
                    };
                    ODCallback_t ElmoMasterNode_Index1003_callbacks[] = 
                     {
                       NULL,
                       NULL,
                     };
                    subindex ElmoMasterNode_Index1003[] = 
                     {
                       { RW, valueRange_EMC, sizeof (UNS8), (void*)&ElmoMasterNode_highestSubIndex_obj1003 },
                       { RO, uint32, sizeof (UNS32), (void*)&ElmoMasterNode_obj1003[0] }
                     };

/* index 0x1005 :   SYNC COB ID. */
                    UNS32 ElmoMasterNode_obj1005 = 0x80;	/* 128 */
                    ODCallback_t ElmoMasterNode_Index1005_callbacks[] = 
                     {
                       NULL,
                     };
                    subindex ElmoMasterNode_Index1005[] = 
                     {
                       { RW, uint32, sizeof (UNS32), (void*)&ElmoMasterNode_obj1005 }
                     };

/* index 0x1006 :   Communication / Cycle Period */
                    UNS32 ElmoMasterNode_obj1006 = 0x0;   /* 0 */

/* index 0x100C :   Guard Time */ 
                    UNS16 ElmoMasterNode_obj100C = 0x0;   /* 0 */

/* index 0x100D :   Life Time Factor */ 
                    UNS8 ElmoMasterNode_obj100D = 0x0;   /* 0 */

/* index 0x1014 :   Emergency COB ID */
                    UNS32 ElmoMasterNode_obj1014 = 0x80 + 0x00;   /* 128 + NodeID */

/* index 0x1016 :   Consumer Heartbeat Time. */
                    UNS8 ElmoMasterNode_highestSubIndex_obj1016 = 4; /* number of subindex - 1*/
                    UNS32 ElmoMasterNode_obj1016[] = 
                    {
                      0x0,	/* 0 */
                      0x0,	/* 0 */
                      0x0,	/* 0 */
                      0x0	/* 0 */
                    };
                    subindex ElmoMasterNode_Index1016[] = 
                     {
                       { RO, uint8, sizeof (UNS8), (void*)&ElmoMasterNode_highestSubIndex_obj1016 },
                       { RW, uint32, sizeof (UNS32), (void*)&ElmoMasterNode_obj1016[0] },
                       { RW, uint32, sizeof (UNS32), (void*)&ElmoMasterNode_obj1016[1] },
                       { RW, uint32, sizeof (UNS32), (void*)&ElmoMasterNode_obj1016[2] },
                       { RW, uint32, sizeof (UNS32), (void*)&ElmoMasterNode_obj1016[3] }
                     };

/* index 0x1017 :   Producer Heartbeat Time */ 
                    UNS16 ElmoMasterNode_obj1017 = 0x0;   /* 0 */

/* index 0x1018 :   Identity. */
                    UNS8 ElmoMasterNode_highestSubIndex_obj1018 = 4; /* number of subindex - 1*/
                    UNS32 ElmoMasterNode_obj1018_Vendor_ID = 0x0;	/* 0 */
                    UNS32 ElmoMasterNode_obj1018_Product_Code = 0x0;	/* 0 */
                    UNS32 ElmoMasterNode_obj1018_Revision_Number = 0x0;	/* 0 */
                    UNS32 ElmoMasterNode_obj1018_Serial_Number = 0x0;	/* 0 */
                    subindex ElmoMasterNode_Index1018[] = 
                     {
                       { RO, uint8, sizeof (UNS8), (void*)&ElmoMasterNode_highestSubIndex_obj1018 },
                       { RO, uint32, sizeof (UNS32), (void*)&ElmoMasterNode_obj1018_Vendor_ID },
                       { RO, uint32, sizeof (UNS32), (void*)&ElmoMasterNode_obj1018_Product_Code },
                       { RO, uint32, sizeof (UNS32), (void*)&ElmoMasterNode_obj1018_Revision_Number },
                       { RO, uint32, sizeof (UNS32), (void*)&ElmoMasterNode_obj1018_Serial_Number }
                     };

/* index 0x1280 :   Client SDO 1 Parameter. */
                    UNS8 ElmoMasterNode_highestSubIndex_obj1280 = 3; /* number of subindex - 1*/
                    UNS32 ElmoMasterNode_obj1280_COB_ID_Client_to_Server_Transmit_SDO = 0x67D;	/* 1661 */
                    UNS32 ElmoMasterNode_obj1280_COB_ID_Server_to_Client_Receive_SDO = 0x5FD;	/* 1533 */
                    UNS8 ElmoMasterNode_obj1280_Node_ID_of_the_SDO_Server = 0x7D;	/* 125 */
                    subindex ElmoMasterNode_Index1280[] = 
                     {
                       { RO, uint8, sizeof (UNS8), (void*)&ElmoMasterNode_highestSubIndex_obj1280 },
                       { RW, uint32, sizeof (UNS32), (void*)&ElmoMasterNode_obj1280_COB_ID_Client_to_Server_Transmit_SDO },
                       { RW, uint32, sizeof (UNS32), (void*)&ElmoMasterNode_obj1280_COB_ID_Server_to_Client_Receive_SDO },
                       { RW, uint8, sizeof (UNS8), (void*)&ElmoMasterNode_obj1280_Node_ID_of_the_SDO_Server }
                     };

/* index 0x1281 :   Client SDO 2 Parameter. */
                    UNS8 ElmoMasterNode_highestSubIndex_obj1281 = 3; /* number of subindex - 1*/
                    UNS32 ElmoMasterNode_obj1281_COB_ID_Client_to_Server_Transmit_SDO = 0x67E;	/* 1662 */
                    UNS32 ElmoMasterNode_obj1281_COB_ID_Server_to_Client_Receive_SDO = 0x5FE;	/* 1534 */
                    UNS8 ElmoMasterNode_obj1281_Node_ID_of_the_SDO_Server = 0x7E;	/* 126 */
                    subindex ElmoMasterNode_Index1281[] = 
                     {
                       { RO, uint8, sizeof (UNS8), (void*)&ElmoMasterNode_highestSubIndex_obj1281 },
                       { RW, uint32, sizeof (UNS32), (void*)&ElmoMasterNode_obj1281_COB_ID_Client_to_Server_Transmit_SDO },
                       { RW, uint32, sizeof (UNS32), (void*)&ElmoMasterNode_obj1281_COB_ID_Server_to_Client_Receive_SDO },
                       { RW, uint8, sizeof (UNS8), (void*)&ElmoMasterNode_obj1281_Node_ID_of_the_SDO_Server }
                     };

/* index 0x1282 :   Client SDO 3 Parameter. */
                    UNS8 ElmoMasterNode_highestSubIndex_obj1282 = 3; /* number of subindex - 1*/
                    UNS32 ElmoMasterNode_obj1282_COB_ID_Client_to_Server_Transmit_SDO = 0x67F;	/* 1663 */
                    UNS32 ElmoMasterNode_obj1282_COB_ID_Server_to_Client_Receive_SDO = 0x5FF;	/* 1535 */
                    UNS8 ElmoMasterNode_obj1282_Node_ID_of_the_SDO_Server = 0x7F;	/* 127 */
                    subindex ElmoMasterNode_Index1282[] = 
                     {
                       { RO, uint8, sizeof (UNS8), (void*)&ElmoMasterNode_highestSubIndex_obj1282 },
                       { RW, uint32, sizeof (UNS32), (void*)&ElmoMasterNode_obj1282_COB_ID_Client_to_Server_Transmit_SDO },
                       { RW, uint32, sizeof (UNS32), (void*)&ElmoMasterNode_obj1282_COB_ID_Server_to_Client_Receive_SDO },
                       { RW, uint8, sizeof (UNS8), (void*)&ElmoMasterNode_obj1282_Node_ID_of_the_SDO_Server }
                     };

/* index 0x1400 :   Receive PDO 1 Parameter. */
                    UNS8 ElmoMasterNode_highestSubIndex_obj1400 = 6; /* number of subindex - 1*/
                    UNS32 ElmoMasterNode_obj1400_COB_ID_used_by_PDO = 0x0;	/* 0 */
                    UNS8 ElmoMasterNode_obj1400_Transmission_Type = 0x0;	/* 0 */
                    UNS16 ElmoMasterNode_obj1400_Inhibit_Time = 0x0;	/* 0 */
                    UNS8 ElmoMasterNode_obj1400_Compatibility_Entry = 0x0;	/* 0 */
                    UNS16 ElmoMasterNode_obj1400_Event_Timer = 0x0;	/* 0 */
                    UNS8 ElmoMasterNode_obj1400_SYNC_start_value = 0x0;	/* 0 */
                    subindex ElmoMasterNode_Index1400[] = 
                     {
                       { RO, uint8, sizeof (UNS8), (void*)&ElmoMasterNode_highestSubIndex_obj1400 },
                       { RW, uint32, sizeof (UNS32), (void*)&ElmoMasterNode_obj1400_COB_ID_used_by_PDO },
                       { RW, uint8, sizeof (UNS8), (void*)&ElmoMasterNode_obj1400_Transmission_Type },
                       { RW, uint16, sizeof (UNS16), (void*)&ElmoMasterNode_obj1400_Inhibit_Time },
                       { RW, uint8, sizeof (UNS8), (void*)&ElmoMasterNode_obj1400_Compatibility_Entry },
                       { RW, uint16, sizeof (UNS16), (void*)&ElmoMasterNode_obj1400_Event_Timer },
                       { RW, uint8, sizeof (UNS8), (void*)&ElmoMasterNode_obj1400_SYNC_start_value }
                     };

/* index 0x1401 :   Receive PDO 2 Parameter. */
                    UNS8 ElmoMasterNode_highestSubIndex_obj1401 = 6; /* number of subindex - 1*/
                    UNS32 ElmoMasterNode_obj1401_COB_ID_used_by_PDO = 0x0;	/* 0 */
                    UNS8 ElmoMasterNode_obj1401_Transmission_Type = 0x0;	/* 0 */
                    UNS16 ElmoMasterNode_obj1401_Inhibit_Time = 0x0;	/* 0 */
                    UNS8 ElmoMasterNode_obj1401_Compatibility_Entry = 0x0;	/* 0 */
                    UNS16 ElmoMasterNode_obj1401_Event_Timer = 0x0;	/* 0 */
                    UNS8 ElmoMasterNode_obj1401_SYNC_start_value = 0x0;	/* 0 */
                    subindex ElmoMasterNode_Index1401[] = 
                     {
                       { RO, uint8, sizeof (UNS8), (void*)&ElmoMasterNode_highestSubIndex_obj1401 },
                       { RW, uint32, sizeof (UNS32), (void*)&ElmoMasterNode_obj1401_COB_ID_used_by_PDO },
                       { RW, uint8, sizeof (UNS8), (void*)&ElmoMasterNode_obj1401_Transmission_Type },
                       { RW, uint16, sizeof (UNS16), (void*)&ElmoMasterNode_obj1401_Inhibit_Time },
                       { RW, uint8, sizeof (UNS8), (void*)&ElmoMasterNode_obj1401_Compatibility_Entry },
                       { RW, uint16, sizeof (UNS16), (void*)&ElmoMasterNode_obj1401_Event_Timer },
                       { RW, uint8, sizeof (UNS8), (void*)&ElmoMasterNode_obj1401_SYNC_start_value }
                     };

/* index 0x1402 :   Receive PDO 3 Parameter. */
                    UNS8 ElmoMasterNode_highestSubIndex_obj1402 = 6; /* number of subindex - 1*/
                    UNS32 ElmoMasterNode_obj1402_COB_ID_used_by_PDO = 0x0;	/* 0 */
                    UNS8 ElmoMasterNode_obj1402_Transmission_Type = 0x0;	/* 0 */
                    UNS16 ElmoMasterNode_obj1402_Inhibit_Time = 0x0;	/* 0 */
                    UNS8 ElmoMasterNode_obj1402_Compatibility_Entry = 0x0;	/* 0 */
                    UNS16 ElmoMasterNode_obj1402_Event_Timer = 0x0;	/* 0 */
                    UNS8 ElmoMasterNode_obj1402_SYNC_start_value = 0x0;	/* 0 */
                    subindex ElmoMasterNode_Index1402[] = 
                     {
                       { RO, uint8, sizeof (UNS8), (void*)&ElmoMasterNode_highestSubIndex_obj1402 },
                       { RW, uint32, sizeof (UNS32), (void*)&ElmoMasterNode_obj1402_COB_ID_used_by_PDO },
                       { RW, uint8, sizeof (UNS8), (void*)&ElmoMasterNode_obj1402_Transmission_Type },
                       { RW, uint16, sizeof (UNS16), (void*)&ElmoMasterNode_obj1402_Inhibit_Time },
                       { RW, uint8, sizeof (UNS8), (void*)&ElmoMasterNode_obj1402_Compatibility_Entry },
                       { RW, uint16, sizeof (UNS16), (void*)&ElmoMasterNode_obj1402_Event_Timer },
                       { RW, uint8, sizeof (UNS8), (void*)&ElmoMasterNode_obj1402_SYNC_start_value }
                     };

/* index 0x1403 :   Receive PDO 4 Parameter. */
                    UNS8 ElmoMasterNode_highestSubIndex_obj1403 = 6; /* number of subindex - 1*/
                    UNS32 ElmoMasterNode_obj1403_COB_ID_used_by_PDO = 0x0;	/* 0 */
                    UNS8 ElmoMasterNode_obj1403_Transmission_Type = 0x0;	/* 0 */
                    UNS16 ElmoMasterNode_obj1403_Inhibit_Time = 0x0;	/* 0 */
                    UNS8 ElmoMasterNode_obj1403_Compatibility_Entry = 0x0;	/* 0 */
                    UNS16 ElmoMasterNode_obj1403_Event_Timer = 0x0;	/* 0 */
                    UNS8 ElmoMasterNode_obj1403_SYNC_start_value = 0x0;	/* 0 */
                    subindex ElmoMasterNode_Index1403[] = 
                     {
                       { RO, uint8, sizeof (UNS8), (void*)&ElmoMasterNode_highestSubIndex_obj1403 },
                       { RW, uint32, sizeof (UNS32), (void*)&ElmoMasterNode_obj1403_COB_ID_used_by_PDO },
                       { RW, uint8, sizeof (UNS8), (void*)&ElmoMasterNode_obj1403_Transmission_Type },
                       { RW, uint16, sizeof (UNS16), (void*)&ElmoMasterNode_obj1403_Inhibit_Time },
                       { RW, uint8, sizeof (UNS8), (void*)&ElmoMasterNode_obj1403_Compatibility_Entry },
                       { RW, uint16, sizeof (UNS16), (void*)&ElmoMasterNode_obj1403_Event_Timer },
                       { RW, uint8, sizeof (UNS8), (void*)&ElmoMasterNode_obj1403_SYNC_start_value }
                     };

/* index 0x1600 :   Receive PDO 1 Mapping. */
                    UNS8 ElmoMasterNode_highestSubIndex_obj1600 = 1; /* number of subindex - 1*/
                    UNS32 ElmoMasterNode_obj1600[] = 
                    {
                      0x20000140	/* 536871232 */
                    };
                    subindex ElmoMasterNode_Index1600[] = 
                     {
                       { RW, uint8, sizeof (UNS8), (void*)&ElmoMasterNode_highestSubIndex_obj1600 },
                       { RW, uint32, sizeof (UNS32), (void*)&ElmoMasterNode_obj1600[0] }
                     };

/* index 0x1601 :   Receive PDO 2 Mapping. */
                    UNS8 ElmoMasterNode_highestSubIndex_obj1601 = 1; /* number of subindex - 1*/
                    UNS32 ElmoMasterNode_obj1601[] = 
                    {
                      0x20000240	/* 536871488 */
                    };
                    subindex ElmoMasterNode_Index1601[] = 
                     {
                       { RW, uint8, sizeof (UNS8), (void*)&ElmoMasterNode_highestSubIndex_obj1601 },
                       { RW, uint32, sizeof (UNS32), (void*)&ElmoMasterNode_obj1601[0] }
                     };

/* index 0x1602 :   Receive PDO 3 Mapping. */
                    UNS8 ElmoMasterNode_highestSubIndex_obj1602 = 1; /* number of subindex - 1*/
                    UNS32 ElmoMasterNode_obj1602[] = 
                    {
                      0x20000340	/* 536871744 */
                    };
                    subindex ElmoMasterNode_Index1602[] = 
                     {
                       { RW, uint8, sizeof (UNS8), (void*)&ElmoMasterNode_highestSubIndex_obj1602 },
                       { RW, uint32, sizeof (UNS32), (void*)&ElmoMasterNode_obj1602[0] }
                     };

/* index 0x1603 :   Receive PDO 4 Mapping. */
                    UNS8 ElmoMasterNode_highestSubIndex_obj1603 = 1; /* number of subindex - 1*/
                    UNS32 ElmoMasterNode_obj1603[] = 
                    {
                      0x20000440	/* 536872000 */
                    };
                    subindex ElmoMasterNode_Index1603[] = 
                     {
                       { RW, uint8, sizeof (UNS8), (void*)&ElmoMasterNode_highestSubIndex_obj1603 },
                       { RW, uint32, sizeof (UNS32), (void*)&ElmoMasterNode_obj1603[0] }
                     };

/* index 0x2000 :   Mapped variable ElmoMaster_PDOReplies */
                    UNS8 ElmoMasterNode_highestSubIndex_obj2000 = 4; /* number of subindex - 1*/
                    ODCallback_t ElmoMaster_PDOReplies_callbacks[] = 
                     {
                       NULL,
                       NULL,
                       NULL,
                       NULL,
                       NULL,
                     };
                    subindex ElmoMasterNode_Index2000[] = 
                     {
                       { RO, uint8, sizeof (UNS8), (void*)&ElmoMasterNode_highestSubIndex_obj2000 },
                       { RW, uint64, sizeof (UNS64), (void*)&ElmoMaster_PDOReplies[0] },
                       { RW, uint64, sizeof (UNS64), (void*)&ElmoMaster_PDOReplies[1] },
                       { RW, uint64, sizeof (UNS64), (void*)&ElmoMaster_PDOReplies[2] },
                       { RW, uint64, sizeof (UNS64), (void*)&ElmoMaster_PDOReplies[3] }
                     };

/**************************************************************************/
/* Declaration of pointed variables                                       */
/**************************************************************************/

const indextable ElmoMasterNode_objdict[] = 
{
  { (subindex*)ElmoMasterNode_Index1000,sizeof(ElmoMasterNode_Index1000)/sizeof(ElmoMasterNode_Index1000[0]), 0x1000},
  { (subindex*)ElmoMasterNode_Index1001,sizeof(ElmoMasterNode_Index1001)/sizeof(ElmoMasterNode_Index1001[0]), 0x1001},
  { (subindex*)ElmoMasterNode_Index1005,sizeof(ElmoMasterNode_Index1005)/sizeof(ElmoMasterNode_Index1005[0]), 0x1005},
  { (subindex*)ElmoMasterNode_Index1016,sizeof(ElmoMasterNode_Index1016)/sizeof(ElmoMasterNode_Index1016[0]), 0x1016},
  { (subindex*)ElmoMasterNode_Index1018,sizeof(ElmoMasterNode_Index1018)/sizeof(ElmoMasterNode_Index1018[0]), 0x1018},
  { (subindex*)ElmoMasterNode_Index1280,sizeof(ElmoMasterNode_Index1280)/sizeof(ElmoMasterNode_Index1280[0]), 0x1280},
  { (subindex*)ElmoMasterNode_Index1281,sizeof(ElmoMasterNode_Index1281)/sizeof(ElmoMasterNode_Index1281[0]), 0x1281},
  { (subindex*)ElmoMasterNode_Index1282,sizeof(ElmoMasterNode_Index1282)/sizeof(ElmoMasterNode_Index1282[0]), 0x1282},
  { (subindex*)ElmoMasterNode_Index1400,sizeof(ElmoMasterNode_Index1400)/sizeof(ElmoMasterNode_Index1400[0]), 0x1400},
  { (subindex*)ElmoMasterNode_Index1401,sizeof(ElmoMasterNode_Index1401)/sizeof(ElmoMasterNode_Index1401[0]), 0x1401},
  { (subindex*)ElmoMasterNode_Index1402,sizeof(ElmoMasterNode_Index1402)/sizeof(ElmoMasterNode_Index1402[0]), 0x1402},
  { (subindex*)ElmoMasterNode_Index1403,sizeof(ElmoMasterNode_Index1403)/sizeof(ElmoMasterNode_Index1403[0]), 0x1403},
  { (subindex*)ElmoMasterNode_Index1600,sizeof(ElmoMasterNode_Index1600)/sizeof(ElmoMasterNode_Index1600[0]), 0x1600},
  { (subindex*)ElmoMasterNode_Index1601,sizeof(ElmoMasterNode_Index1601)/sizeof(ElmoMasterNode_Index1601[0]), 0x1601},
  { (subindex*)ElmoMasterNode_Index1602,sizeof(ElmoMasterNode_Index1602)/sizeof(ElmoMasterNode_Index1602[0]), 0x1602},
  { (subindex*)ElmoMasterNode_Index1603,sizeof(ElmoMasterNode_Index1603)/sizeof(ElmoMasterNode_Index1603[0]), 0x1603},
  { (subindex*)ElmoMasterNode_Index2000,sizeof(ElmoMasterNode_Index2000)/sizeof(ElmoMasterNode_Index2000[0]), 0x2000},
};

const indextable * ElmoMasterNode_scanIndexOD (UNS16 wIndex, UNS32 * errorCode, ODCallback_t **callbacks)
{
	int i;
	*callbacks = NULL;
	switch(wIndex){
		case 0x1000: i = 0;break;
		case 0x1001: i = 1;break;
		case 0x1005: i = 2;*callbacks = ElmoMasterNode_Index1005_callbacks; break;
		case 0x1016: i = 3;break;
		case 0x1018: i = 4;break;
		case 0x1280: i = 5;break;
		case 0x1281: i = 6;break;
		case 0x1282: i = 7;break;
		case 0x1400: i = 8;break;
		case 0x1401: i = 9;break;
		case 0x1402: i = 10;break;
		case 0x1403: i = 11;break;
		case 0x1600: i = 12;break;
		case 0x1601: i = 13;break;
		case 0x1602: i = 14;break;
		case 0x1603: i = 15;break;
		case 0x2000: i = 16;*callbacks = ElmoMaster_PDOReplies_callbacks; break;
		default:
			*errorCode = OD_NO_SUCH_OBJECT;
			return NULL;
	}
	*errorCode = OD_SUCCESSFUL;
	return &ElmoMasterNode_objdict[i];
}

/* 
 * To count at which received SYNC a PDO must be sent.
 * Even if no pdoTransmit are defined, at least one entry is computed
 * for compilations issues.
 */
s_PDO_status ElmoMasterNode_PDO_status[1] = {s_PDO_status_Initializer};

const quick_index ElmoMasterNode_firstIndex = {
  0, /* SDO_SVR */
  5, /* SDO_CLT */
  8, /* PDO_RCV */
  12, /* PDO_RCV_MAP */
  0, /* PDO_TRS */
  0 /* PDO_TRS_MAP */
};

const quick_index ElmoMasterNode_lastIndex = {
  0, /* SDO_SVR */
  7, /* SDO_CLT */
  11, /* PDO_RCV */
  15, /* PDO_RCV_MAP */
  0, /* PDO_TRS */
  0 /* PDO_TRS_MAP */
};

const UNS16 ElmoMasterNode_ObjdictSize = sizeof(ElmoMasterNode_objdict)/sizeof(ElmoMasterNode_objdict[0]); 

CO_Data ElmoMasterNode_Data = CANOPEN_NODE_DATA_INITIALIZER(ElmoMasterNode);
