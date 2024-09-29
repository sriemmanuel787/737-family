# McDonnell Douglas MD-80 Electrical System
# Copyright (c) 2024 Josh Davidson (Octal450)

var ELEC = {
	Bus: {
		acGenL: props.globals.getNode("/systems/electrical/bus/ac-gen-l"),
		acGenR: props.globals.getNode("/systems/electrical/bus/ac-gen-r"),
		acGndSvc: props.globals.getNode("/systems/electrical/bus/ac-gndsvc"),
		acTie: props.globals.getNode("/systems/electrical/bus/ac-tie"),
		acL: props.globals.getNode("/systems/electrical/bus/ac-l"),
		acR: props.globals.getNode("/systems/electrical/bus/ac-r"),
		acRadioL: props.globals.getNode("/systems/electrical/bus/ac-radio-l"),
		acRadioR: props.globals.getNode("/systems/electrical/bus/ac-radio-r"),
		dcBat: props.globals.getNode("/systems/electrical/bus/dc-bat"),
		dcBatDirect: props.globals.getNode("/systems/electrical/bus/dc-bat-direct"),
		dcL: props.globals.getNode("/systems/electrical/bus/dc-l"),
		dcR: props.globals.getNode("/systems/electrical/bus/dc-r"),
		dcRadioL: props.globals.getNode("/systems/electrical/bus/dc-radio-l"),
		dcRadioR: props.globals.getNode("/systems/electrical/bus/dc-radio-r"),
		dcTie: props.globals.getNode("/systems/electrical/bus/dc-tie"),
		dcTrans: props.globals.getNode("/systems/electrical/bus/dc-trans"),
		emerAc: props.globals.getNode("/systems/electrical/bus/emer-ac"),
		emerDc: props.globals.getNode("/systems/electrical/bus/emer-dc"),
		instAcL: props.globals.getNode("/systems/electrical/bus/inst-ac-l"),
		instAcR: props.globals.getNode("/systems/electrical/bus/inst-ac-r"),
	},
	Fail: {
		acTie: props.globals.getNode("/systems/failures/electrical/ac-tie"),
		apu: props.globals.getNode("/systems/failures/electrical/apu"),
		battery: props.globals.getNode("/systems/failures/electrical/battery"),
		dcTie: props.globals.getNode("/systems/failures/electrical/dc-tie"),
		genL: props.globals.getNode("/systems/failures/electrical/gen-l"),
		genR: props.globals.getNode("/systems/failures/electrical/gen-r"),
	},
	Generic: {
		efis: props.globals.initNode("/systems/electrical/outputs/efis", 0, "DOUBLE"),
		fgcp: props.globals.initNode("/systems/electrical/outputs/fgcp", 0, "DOUBLE"),
		fma: [props.globals.initNode("/systems/electrical/outputs/fma[0]", 0, "DOUBLE"), props.globals.initNode("/systems/electrical/outputs/fma[1]", 0, "DOUBLE")],
	},
	Source: {
		Apu: {
			hertz: props.globals.getNode("/systems/electrical/sources/apu/output-hertz"),
			pmgHertz: props.globals.getNode("/systems/electrical/sources/apu/pmg-hertz"),
			pmgVolt: props.globals.getNode("/systems/electrical/sources/apu/pmg-volt"),
			volt: props.globals.getNode("/systems/electrical/sources/apu/output-volt"),
		},
		Bat1: {
			amp: props.globals.getNode("/systems/electrical/sources/bat-1/amp"),
			percent: props.globals.getNode("/systems/electrical/sources/bat-1/percent"),
			volt: props.globals.getNode("/systems/electrical/sources/bat-1/volt"),
		},
		Bat2: {
			amp: props.globals.getNode("/systems/electrical/sources/bat-2/amp"),
			percent: props.globals.getNode("/systems/electrical/sources/bat-2/percent"),
			volt: props.globals.getNode("/systems/electrical/sources/bat-2/volt"),
		},
		batChargerPowered: props.globals.getNode("/systems/electrical/sources/bat-charger-powered"),
		Ext: {
			hertz: props.globals.getNode("/systems/electrical/sources/ext/output-hertz"),
			volt: props.globals.getNode("/systems/electrical/sources/ext/output-volt"),
		},
		IdgL: {
			outputHertz: props.globals.getNode("/systems/electrical/sources/idg-l/output-hertz"),
			outputVolt: props.globals.getNode("/systems/electrical/sources/idg-l/output-volt"),
			pmgHertz: props.globals.getNode("/systems/electrical/sources/idg-l/pmg-hertz"),
			pmgVolt: props.globals.getNode("/systems/electrical/sources/idg-l/pmg-volt"),
		},
		IdgR: {
			outputHertz: props.globals.getNode("/systems/electrical/sources/idg-r/output-hertz"),
			outputVolt: props.globals.getNode("/systems/electrical/sources/idg-r/output-volt"),
			pmgHertz: props.globals.getNode("/systems/electrical/sources/idg-r/pmg-hertz"),
			pmgVolt: props.globals.getNode("/systems/electrical/sources/idg-r/pmg-volt"),
		},
		Si1: {
			volt: props.globals.getNode("/systems/electrical/sources/si-1/output-volt"),
		},
		TrL1: {
			amp: props.globals.getNode("/systems/electrical/sources/tr-l1/output-amp"),
			volt: props.globals.getNode("/systems/electrical/sources/tr-l1/output-volt"),
		},
		TrL2: {
			amp: props.globals.getNode("/systems/electrical/sources/tr-l2/output-amp"),
			volt: props.globals.getNode("/systems/electrical/sources/tr-l2/output-volt"),
		},
		TrR1: {
			amp: props.globals.getNode("/systems/electrical/sources/tr-r1/output-amp"),
			volt: props.globals.getNode("/systems/electrical/sources/tr-r1/output-volt"),
		},
		TrR2: {
			amp: props.globals.getNode("/systems/electrical/sources/tr-r2/output-amp"),
			volt: props.globals.getNode("/systems/electrical/sources/tr-r2/output-volt"),
		},
	},
	Switch: {
		acTie: props.globals.getNode("/controls/electrical/switches/ac-tie"),
		apuGndSvc: props.globals.getNode("/controls/electrical/switches/apu-gndsvc"),
		apuPwrL: props.globals.getNode("/controls/electrical/switches/apu-pwr-l"),
		apuPwrR: props.globals.getNode("/controls/electrical/switches/apu-pwr-r"),
		battery: props.globals.getNode("/controls/electrical/switches/battery"),
		csdL: props.globals.getNode("/controls/electrical/switches/csd-l"),
		csdR: props.globals.getNode("/controls/electrical/switches/csd-r"),
		dcTie: props.globals.getNode("/controls/electrical/switches/dc-tie"),
		emerPwr: props.globals.getNode("/controls/electrical/switches/emer-pwr"),
		extGndSvc: props.globals.getNode("/controls/electrical/switches/ext-gndsvc"),
		extPwrL: props.globals.getNode("/controls/electrical/switches/ext-pwr-l"),
		extPwrR: props.globals.getNode("/controls/electrical/switches/ext-pwr-r"),
		galley: props.globals.getNode("/controls/electrical/switches/galley"),
		genApu: props.globals.getNode("/controls/electrical/switches/gen-apu"),
		genL: props.globals.getNode("/controls/electrical/switches/gen-l"),
		genR: props.globals.getNode("/controls/electrical/switches/gen-r"),
		groundCart: props.globals.getNode("/controls/electrical/switches/ground-cart"),
	},
	init: func() {
		me.resetFailures();
		me.Switch.acTie.setBoolValue(1);
		me.Switch.apuGndSvc.setBoolValue(0);
		me.Switch.apuPwrL.setBoolValue(0);
		me.Switch.apuPwrR.setBoolValue(0);
		me.Switch.battery.setBoolValue(0);
		me.Switch.csdL.setBoolValue(1);
		me.Switch.csdR.setBoolValue(1);
		me.Switch.dcTie.setBoolValue(0);
		me.Switch.emerPwr.setBoolValue(0);
		me.Switch.extGndSvc.setBoolValue(0);
		me.Switch.extPwrL.setBoolValue(0);
		me.Switch.extPwrR.setBoolValue(0);
		me.Switch.galley.setBoolValue(1);
		me.Switch.genApu.setBoolValue(1);
		me.Switch.genL.setValue(1);
		me.Switch.genR.setValue(1);
		me.Switch.groundCart.setBoolValue(0);
		me.Source.Bat1.percent.setValue(99.9);
		me.Source.Bat2.percent.setValue(99.9);
	},
	resetFailures: func() {
		me.Switch.csdL.setBoolValue(1);
		me.Switch.csdR.setBoolValue(1);
		me.Fail.acTie.setBoolValue(0);
		me.Fail.apu.setBoolValue(0);
		me.Fail.battery.setBoolValue(0);
		me.Fail.dcTie.setBoolValue(0);
		me.Fail.genL.setBoolValue(0);
		me.Fail.genR.setBoolValue(0);
	},
};
