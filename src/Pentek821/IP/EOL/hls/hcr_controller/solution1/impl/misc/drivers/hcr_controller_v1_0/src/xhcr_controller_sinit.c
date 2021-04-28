// ==============================================================
// Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC v2019.2 (64-bit)
// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// ==============================================================
#ifndef __linux__

#include "xstatus.h"
#include "xparameters.h"
#include "xhcr_controller.h"

extern XHcr_controller_Config XHcr_controller_ConfigTable[];

XHcr_controller_Config *XHcr_controller_LookupConfig(u16 DeviceId) {
	XHcr_controller_Config *ConfigPtr = NULL;

	int Index;

	for (Index = 0; Index < XPAR_XHCR_CONTROLLER_NUM_INSTANCES; Index++) {
		if (XHcr_controller_ConfigTable[Index].DeviceId == DeviceId) {
			ConfigPtr = &XHcr_controller_ConfigTable[Index];
			break;
		}
	}

	return ConfigPtr;
}

int XHcr_controller_Initialize(XHcr_controller *InstancePtr, u16 DeviceId) {
	XHcr_controller_Config *ConfigPtr;

	Xil_AssertNonvoid(InstancePtr != NULL);

	ConfigPtr = XHcr_controller_LookupConfig(DeviceId);
	if (ConfigPtr == NULL) {
		InstancePtr->IsReady = 0;
		return (XST_DEVICE_NOT_FOUND);
	}

	return XHcr_controller_CfgInitialize(InstancePtr, ConfigPtr);
}

#endif

