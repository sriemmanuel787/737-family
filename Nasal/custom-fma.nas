# IT-AUTOFLIGHT V4.0.9 Custom FMA File
# Make sure you enable custom-fma in the config
# Copyright (c) 2024 Josh Davidson (Octal450)

var UpdateFma = {
	latText: "T/O",
	spdText: "PITCH",
	thrText: "THR LIM",
	vertText: "T/O CLB",
    latMode: {"" : "", "T/O" : "", "RLOU" : "ROLLOUT", "HDG" : "HDG SEL", "ALGN" : "VOR/LOC", "ROLL" : "", "LNAV" : "LNAV", "LOC" : "VOR/LOC"}, # B/CRS and FAC not supported
    spdMode: {"" : "", "PITCH" : "N1", "RETARD" : "RETARD", "THRUST" : "MCP SPD"}, # GA, FMC SPD, THR HLD, ARM not supported
	# thrMode: {"" : ""}, TODO: #42 Implement this hash once derates and limits are supported
    vertMode: {"" : "", "T/O CLB" : "TO/GA", "ROLLOUT" : "", "ALT HLD" : "ALT HLD", "FPA" : "", "V/S" : "V/S", "ALT CAP" : "ALT/ACQ", "FLARE" : "FLARE", "SPD CLB" : "MCP SPD", "SPD DES" : "MCP SPD", "G/S" : "G/S", "G/A CLB" : "TO/GA"}, # G/P and VNAV SPD/PTH/ALT not supported
	thr: func() { # Called when speed/thrust modes change
		Fma.throttle.setValue(thrMode[Text.spd.getValue()]);
		Fma.throttle.setValue(Text.thr.getValue());
	},
	arm: func() { # Called when armed modes change
		Output.lnavArm.getBoolValue();
		Output.locArm.getBoolValue();
		Output.gsArm.getBoolValue();
	},
	lat: func() { # Called when lateral mode changes
        Fma.roll.setValue(latMode[Text.lat.getValue()]);
	},
	vert: func() { # Called when vertical mode changes
        Fma.pitch.setValue(vertMode[Text.vert.getValue()]);
	},
};
