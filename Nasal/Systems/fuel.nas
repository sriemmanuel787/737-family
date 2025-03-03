# Boeing 737 Fuel System

var FUEL = {
	Fail: {
		pumpsC: props.globals.getNode("/systems/failures/fuel/pumps-c"),
		pumpsL: props.globals.getNode("/systems/failures/fuel/pumps-l"),
		pumpsR: props.globals.getNode("/systems/failures/fuel/pumps-r"),
	},
	Switch: {
		pumpAftC: props.globals.getNode("/controls/fuel/pump-aft-c"),
		pumpAftL: props.globals.getNode("/controls/fuel/pump-aft-l"),
		pumpAftR: props.globals.getNode("/controls/fuel/pump-aft-r"),
		pumpFwdC: props.globals.getNode("/controls/fuel/pump-fwd-c"),
		pumpFwdL: props.globals.getNode("/controls/fuel/pump-fwd-l"),
		pumpFwdR: props.globals.getNode("/controls/fuel/pump-fwd-r"),
		xFeed: props.globals.getNode("/controls/fuel/x-feed"),
	},
	init: func() {
		me.resetFailures();
		me.Switch.pumpAftC.setValue(0);
		me.Switch.pumpAftL.setBoolValue(0);
		me.Switch.pumpAftR.setBoolValue(0);
		me.Switch.pumpFwdC.setValue(0);
		me.Switch.pumpFwdL.setBoolValue(0);
		me.Switch.pumpFwdR.setBoolValue(0);
		me.Switch.xFeed.setBoolValue(0);
	},
	resetFailures: func() {
		me.Fail.pumpsC.setBoolValue(0);
		me.Fail.pumpsL.setBoolValue(0);
		me.Fail.pumpsR.setBoolValue(0);
	},
};
