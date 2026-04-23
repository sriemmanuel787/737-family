# Boeing 737 Hydraulic System
# Copyright (c) 2024 Josh Davidson (Octal450)

var HYD = {
	Fail: {
		elec1Pump: props.globals.getNode("/systems/failures/hydraulics/elec-1-pump"),
		elec2Pump: props.globals.getNode("/systems/failures/hydraulics/elec-2-pump"),
		eng1Pump: props.globals.getNode("/systems/failures/hydraulics/eng-1-pump"),
		eng2Pump: props.globals.getNode("/systems/failures/hydraulics/eng-2-pump"),
		ptu: props.globals.getNode("/systems/failures/hydraulics/ptu"),
		standbyPump: props.globals.getNode("/systems/failures/hydraulics/standby-pump"),
		sysALeak: props.globals.getNode("/systems/failures/hydraulics/sys-a-leak"),
		sysBLeak: props.globals.getNode("/systems/failures/hydraulics/sys-b-leak"),
	},
	Psi: {
		elec1Pump: props.globals.getNode("/systems/hydraulics/elec-1-pump-psi"),
		elec2Pump: props.globals.getNode("/systems/hydraulics/elec-2-pump-psi"),
		eng1Pump: props.globals.getNode("/systems/hydraulics/eng-1-pump-psi"),
		eng2Pump: props.globals.getNode("/systems/hydraulics/eng-2-pump-psi"),
		ptu: props.globals.getNode("/systems/hydraulics/ptu-psi"),
		standby: props.globals.getNode("/systems/hydraulics/standby-psi"),
		sysA: props.globals.getNode("/systems/hydraulics/sys-a-psi"),
		sysB: props.globals.getNode("/systems/hydraulics/sys-b-psi"),
	},
	Qty: {
		sysA: props.globals.getNode("/systems/hydraulics/sys-a-qty"),
		sysAInput: props.globals.getNode("/systems/hydraulics/sys-l-qty-input"),
		sysB: props.globals.getNode("/systems/hydraulics/sys-b-qty"),
		sysBInput: props.globals.getNode("/systems/hydraulics/sys-r-qty-input"),
	},
	Switch: {
		elec1Pump: props.globals.getNode("/controls/hydraulics/elec-1"),
		elec2Pump: props.globals.getNode("/controls/hydraulics/elec-2"),
		eng1Pump: props.globals.getNode("/controls/hydraulics/eng-1"),
		eng2Pump: props.globals.getNode("/controls/hydraulics/eng-2"),
		altFlapsArm: props.globals.getNode("/controls/flt-control/alt-flaps-arm"),
		rudderA: props.globals.getNode("/controls/flt-control/rudder-a"),
		rudderB: props.globals.getNode("/controls/flt-control/rudder-b"),
	},
	init: func() {
		me.resetFailures();
		me.Qty.sysAInput.setValue(math.round((rand() * 10) + 90, 0.1)); # 90 to 100 percent serviced
		me.Qty.sysBInput.setValue(math.round((rand() * 10) + 90, 0.1)); # 90 to 100 percent serviced
		me.Switch.elec1Pump.setBoolValue(0);
		me.Switch.elec2Pump.setBoolValue(0);
		me.Switch.eng1Pump.setBoolValue(0);
		me.Switch.eng2Pump.setBoolValue(0);
		me.Switch.altFlapsArm.setBoolValue(0);
		me.Switch.rudderA.setValue(0); # 0 is treated as the normal guarded position
		me.Switch.rudderB.setValue(0);
	},
	resetFailures: func() {
		me.Fail.elec1Pump.setBoolValue(0);
		me.Fail.elec2Pump.setBoolValue(0);
		me.Fail.eng1Pump.setBoolValue(0);
		me.Fail.eng2Pump.setBoolValue(0);
		me.Fail.ptu.setBoolValue(0);
		me.Fail.standbyPump.setBoolValue(0);
		me.Fail.sysALeak.setBoolValue(0);
		me.Fail.sysBLeak.setBoolValue(0);
	},
};
