# IT-AUTOFLIGHT V4.0.9 Custom FMA File
# Make sure you enable custom-fma in the config
# Copyright (c) 2024 Josh Davidson (Octal450)
var Fma = {
	ap: props.globals.initNode("/instrumentation/pfd/fma/ap-mode", "", "STRING"),
	thr: props.globals.initNode("/instrumentation/pfd/fma/thr-mode", "", "STRING"),
	pitch: props.globals.initNode("/instrumentation/pfd/fma/pitch-mode", "", "STRING"),
	pitchArm: props.globals.initNode("/instrumentation/pfd/fma/pitch-mode-armed", "", "STRING"),
	roll: props.globals.initNode("/instrumentation/pfd/fma/roll-mode", "", "STRING"),
	rollArm: props.globals.initNode("/instrumentation/pfd/fma/roll-mode-armed", "", "STRING"),
	Blink: {
		active: [0, 0, 0],
		count: [0, 0, 0],
		diff: [0, 0, 0],
		elapsed: 0,
		hide: [0, 0, 0],
		time: [-10, -10, -10],
	},
	loop: func() {
		me.Blink.elapsed = pts.Sim.Time.elapsedSec.getValue();
		
		for (var i = 0; i < 3; i = i + 1) {
			if (me.Blink.elapsed < me.Blink.time[i] + 5) {
				me.Blink.active[i] = 1;
				me.Blink.count[i] = math.floor(math.max(me.Blink.elapsed - me.Blink.time[i], 0) * 2);
				me.Blink.hide[i] = !math.mod(me.Blink.count[i], 2);
			} else {
				me.Blink.active[i] = 0;
				me.Blink.count[i] = 0;
				me.Blink.hide[i] = 0;
			}
		}
	},
	startBlink: func(w) { # 0 Speed, 1 Roll, 2 Pitch
		me.Blink.time[w] = pts.Sim.Time.elapsedSec.getValue();
		me.loop(); # Force update
	},
	stopBlink: func(w) {
		me.Blink.time[w] = -5;
	},
};

var UpdateFma = {
    latMode: {"" : "", "T/O" : "", "RLOU" : "ROLLOUT", "HDG" : "HDG SEL", "ALGN" : "VOR/LOC", "ROLL" : "", "LNAV" : "LNAV", "LOC" : "VOR/LOC"}, # B/CRS and FAC not supported
    thrMode: {"RETARD" : "RETARD", "THR LIM" : "N1", "IDLE" : "", "MACH" : "MCP SPD", "SPEED" : "MCP SPD"}, # GA, FMC SPD, THR HLD not supported
    vertMode: {"" : "", "T/O CLB" : "TO/GA", "ROLLOUT" : "", "ALT HLD" : "ALT HLD", "FPA" : "", "V/S" : "V/S", "ALT CAP" : "ALT/ACQ", "FLARE" : "FLARE", "SPD CLB" : "MCP SPD", "SPD DES" : "MCP SPD", "G/S" : "G/S", "G/A CLB" : "TO/GA"}, # G/P and VNAV SPD/PTH/ALT not supported
	thr: func() { # Called when speed/thrust modes change
		Fma.thr.setValue(me.thrMode[Text.thr.getValue()]);
	},
	arm: func() { # Called when armed modes change
		# Pitch Modes
		if (Output.lnavArm.getBoolValue()) {
			Fma.pitchArm.setValue("LNAV");
		} elsif (Output.gsArm.getBoolValue()) {
			if (Text.vert.getValue() == "V/S") {
				Fma.pitchArm.setValue("G/S V/S");
			} else {
				Fma.pitchArm.setValue("G/S");
			}
		} elsif (Text.vert.getValue() == "V/S") {
			Fma.pitchArm.setValue("V/S");
		} elsif (Text.vert.getValue() == "FLARE") {
			Fma.pitchArm.setValue("FLARE");
		} else {
			Fma.pitchArm.setValue("");
		}

		# Roll Modes
		if (Output.lnavArm.getBoolValue()) {
			Fma.rollArm.setValue("LNAV");
		} elsif (Output.locArm.getBoolValue()) {
			if (Output.lnavArm.getBoolValue()) {
				Fma.rollArm.setValue("LNAV VOR/LOC");
			} else {
				Fma.rollArm.setValue("VOR/LOC");
			}
		} else {
			Fma.rollArm.setValue("");
		}
	},
	lat: func() { # Called when lateral mode changes
        Fma.roll.setValue(me.latMode[Text.lat.getValue()]);
	},
	vert: func() { # Called when vertical mode changes
        Fma.pitch.setValue(me.vertMode[Text.vert.getValue()]);
	},
};
