#737 MAX Property Tree Setup
#Israel Emmanuel

var Consumables = {
    Fuel: {
        tankRight:  props.globals.getNode("consumables/fuel/tank[0]/level-kg"),
        tankLeft:   props.globals.getNode("consumables/fuel/tank[1]/level-kg"),
        tankCenter: props.globals.getNode("consumables/fuel/tank[2]/level-kg"),
    },
};

var Gear = {
	rollspeedMs: [props.globals.getNode("/gear/gear[0]/rollspeed-ms"), props.globals.getNode("/gear/gear[1]/rollspeed-ms"), props.globals.getNode("/gear/gear[2]/rollspeed-ms")],
	wow: [props.globals.getNode("/gear/gear[0]/wow"), props.globals.getNode("/gear/gear[1]/wow"), props.globals.getNode("/gear/gear[2]/wow")],
};

var Instrumentation = {
	Adf: {
		Frequencies: {
			selectedKhz: [props.globals.getNode("/instrumentation/adf[0]/frequencies/selected-khz"), props.globals.getNode("/instrumentation/adf[1]/frequencies/selected-khz")],
		},
	},
	AirspeedIndicator: {
		indicatedMach: [props.globals.getNode("/instrumentation/airspeed-indicator[0]/indicated-mach"), props.globals.getNode("/instrumentation/airspeed-indicator[1]/indicated-mach"), props.globals.getNode("/instrumentation/airspeed-indicator[2]/indicated-mach")],
		indicatedSpeedKt: [props.globals.getNode("/instrumentation/airspeed-indicator[0]/indicated-speed-kt"), props.globals.getNode("/instrumentation/airspeed-indicator[1]/indicated-speed-kt"), props.globals.getNode("/instrumentation/airspeed-indicator[2]/indicated-speed-kt")],
		servicable: [props.globals.getNode("/instrumentation/airspeed-indicator[0]/servicable"), props.globals.getNode("/instrumentation/airspeed-indicator[1]/servicable"), props.globals.getNode("/instrumentation/airspeed-indicator[2]/servicable")],
	},
	Altimeter: {
		indicatedAltitudeFt: [props.globals.getNode("/instrumentation/altimeter[0]/indicated-altitude-ft"), props.globals.getNode("/instrumentation/altimeter[1]/indicated-altitude-ft"), props.globals.getNode("/instrumentation/altimeter[2]/indicated-altitude-ft")],
		settingHpa: [props.globals.getNode("/instrumentation/altimeter[0]/setting-hpa"), props.globals.getNode("/instrumentation/altimeter[1]/setting-hpa"), props.globals.getNode("/instrumentation/altimeter[2]/setting-hpa")],
		settingInhg: [props.globals.getNode("/instrumentation/altimeter[0]/setting-inhg"), props.globals.getNode("/instrumentation/altimeter[1]/setting-inhg"), props.globals.getNode("/instrumentation/altimeter[2]/setting-inhg")],
	},
	Comm: {
		Frequencies: {
			selectedMhz: [props.globals.getNode("/instrumentation/comm[0]/frequencies/selected-mhz"), props.globals.getNode("/instrumentation/comm[1]/frequencies/selected-mhz"), props.globals.getNode("/instrumentation/comm[2]/frequencies/selected-mhz")],
			selectedMhzFmt: [props.globals.getNode("/instrumentation/comm[0]/frequencies/selected-mhz-fmt"), props.globals.getNode("/instrumentation/comm[1]/frequencies/selected-mhz-fmt"), props.globals.getNode("/instrumentation/comm[2]/frequencies/selected-mhz-fmt")],
			standbyMhz: [props.globals.getNode("/instrumentation/comm[0]/frequencies/standby-mhz"), props.globals.getNode("/instrumentation/comm[1]/frequencies/standby-mhz"), props.globals.getNode("/instrumentation/comm[2]/frequencies/standby-mhz")],
			standbyMhzFmt: [props.globals.getNode("/instrumentation/comm[0]/frequencies/standby-mhz-fmt"), props.globals.getNode("/instrumentation/comm[1]/frequencies/standby-mhz-fmt"), props.globals.getNode("/instrumentation/comm[2]/frequencies/standby-mhz-fmt")],
		},
	},
	Dme: {
		indicatedDistanceNm: [props.globals.getNode("/instrumentation/dme[0]/indicated-distance-nm"), props.globals.getNode("/instrumentation/dme[1]/indicated-distance-nm"), props.globals.getNode("/instrumentation/dme[2]/indicated-distance-nm")],
		inRange: [props.globals.getNode("/instrumentation/dme[0]/in-range"), props.globals.getNode("/instrumentation/dme[1]/in-range"), props.globals.getNode("/instrumentation/dme[2]/in-range")],
	},
	Efis: {
		hdgTrkSelected: [props.globals.initNode("/instrumentation/efis[0]/hdg-trk-selected", 0, "BOOL"), props.globals.initNode("/instrumentation/efis[1]/hdg-trk-selected", 0, "BOOL")],
		Inputs: {
			arpt: [props.globals.initNode("/instrumentation/efis[0]/inputs/arpt", 0, "BOOL"), props.globals.initNode("/instrumentation/efis[1]/inputs/arpt", 0, "BOOL")],
			data: [props.globals.initNode("/instrumentation/efis[0]/inputs/data", 0, "BOOL"), props.globals.initNode("/instrumentation/efis[1]/inputs/data", 0, "BOOL")],
			lhVorAdf: [props.globals.initNode("/instrumentation/efis[0]/inputs/lh-vor-adf", 0, "INT"), props.globals.initNode("/instrumentation/efis[1]/inputs/lh-vor-adf", 0, "INT")],
			ndCentered: [props.globals.initNode("/instrumentation/efis[0]/inputs/nd-centered", 0, "BOOL"), props.globals.initNode("/instrumentation/efis[1]/inputs/nd-centered", 0, "BOOL")],
			rangeNm: [props.globals.initNode("/instrumentation/efis[0]/inputs/range-nm", 10, "INT"), props.globals.initNode("/instrumentation/efis[1]/inputs/range-nm", 10, "INT")],
			rhVorAdf: [props.globals.initNode("/instrumentation/efis[0]/inputs/rh-vor-adf", 0, "INT"), props.globals.initNode("/instrumentation/efis[1]/inputs/rh-vor-adf", 0, "INT")],
			sta: [props.globals.initNode("/instrumentation/efis[0]/inputs/sta", 0, "BOOL"), props.globals.initNode("/instrumentation/efis[1]/inputs/sta", 0, "BOOL")],
			tfc: [props.globals.initNode("/instrumentation/efis[0]/inputs/tfc", 0, "BOOL"), props.globals.initNode("/instrumentation/efis[1]/inputs/tfc", 0, "BOOL")],
			wpt: [props.globals.initNode("/instrumentation/efis[0]/inputs/wpt", 0, "BOOL"), props.globals.initNode("/instrumentation/efis[1]/inputs/wpt", 0, "BOOL")],
		},
		Mfd: {
			displayMode: [props.globals.initNode("/instrumentation/efis[0]/mfd/display-mode", "MAP", "STRING"), props.globals.initNode("/instrumentation/efis[1]/mfd/display-mode", "MAP", "STRING")],
			trueNorth: [props.globals.initNode("/instrumentation/efis[0]/mfd/true-north", 0, "BOOL"), props.globals.initNode("/instrumentation/efis[1]/mfd/true-north", 0, "BOOL")],
		},
	},
	MarkerBeacon: {
		inner: props.globals.getNode("/instrumentation/marker-beacon/inner"),
		middle: props.globals.getNode("/instrumentation/marker-beacon/middle"),
		outer: props.globals.getNode("/instrumentation/marker-beacon/outer"),
	},
	MkViii: {
		Inputs: {
			Discretes: {
				momentaryFlapOverride: props.globals.getNode("/instrumentation/mk-viii/inputs/discretes/momentary-flap-override"),
				selfTest: props.globals.getNode("/instrumentation/mk-viii/inputs/discretes/self-test"),
			},
		},
	},
	Nav: {
		Frequencies: {
			selectedMhz: [props.globals.getNode("/instrumentation/nav[0]/frequencies/selected-mhz"), props.globals.getNode("/instrumentation/nav[1]/frequencies/selected-mhz"), props.globals.getNode("/instrumentation/nav[2]/frequencies/selected-mhz")],
		},
		headingNeedleDeflectionNorm: [props.globals.getNode("/instrumentation/nav[0]/heading-needle-deflection-norm"), props.globals.getNode("/instrumentation/nav[1]/heading-needle-deflection-norm"), props.globals.getNode("/instrumentation/nav[2]/heading-needle-deflection-norm")],
		gsInRange: [props.globals.getNode("/instrumentation/nav[0]/gs-in-range"), props.globals.getNode("/instrumentation/nav[1]/gs-in-range"), props.globals.getNode("/instrumentation/nav[2]/gs-in-range")],
		gsNeedleDeflectionNorm: [props.globals.getNode("/instrumentation/nav[0]/gs-needle-deflection-norm"), props.globals.getNode("/instrumentation/nav[1]/gs-needle-deflection-norm"), props.globals.getNode("/instrumentation/nav[2]/gs-needle-deflection-norm")],
		hasGs: [props.globals.getNode("/instrumentation/nav[0]/has-gs"), props.globals.getNode("/instrumentation/nav[1]/has-gs"), props.globals.getNode("/instrumentation/nav[2]/has-gs")],
		inRange: [props.globals.getNode("/instrumentation/nav[0]/in-range"), props.globals.getNode("/instrumentation/nav[1]/in-range"), props.globals.getNode("/instrumentation/nav[2]/in-range")],
		navId: [props.globals.getNode("/instrumentation/nav[0]/nav-id"), props.globals.getNode("/instrumentation/nav[1]/nav-id"), props.globals.getNode("/instrumentation/nav[2]/nav-id")],
		navLoc: [props.globals.getNode("/instrumentation/nav[0]/nav-loc"), props.globals.getNode("/instrumentation/nav[1]/nav-loc"), props.globals.getNode("/instrumentation/nav[2]/nav-loc")],
		Radials: {
			selectedDeg: [props.globals.getNode("/instrumentation/nav[0]/radials/selected-deg"), props.globals.getNode("/instrumentation/nav[1]/radials/selected-deg"), props.globals.getNode("/instrumentation/nav[2]/radials/selected-deg")],
		},
		signalQualityNorm: [props.globals.getNode("/instrumentation/nav[0]/signal-quality-norm"), props.globals.getNode("/instrumentation/nav[1]/signal-quality-norm"), props.globals.getNode("/instrumentation/nav[2]/signal-quality-norm")],
	},
	Pfd: {
		hdgPreSel: props.globals.initNode("/instrumentation/pfd/heading-pre-sel", 0, "DOUBLE"),
		hdgSel: props.globals.initNode("/instrumentation/pfd/heading-sel", 0, "DOUBLE"),
		hdgDeg: [props.globals.initNode("/instrumentation/pfd/heading-deg[0]", 0, "DOUBLE"), props.globals.initNode("/instrumentation/pfd/heading-deg[1]", 0, "DOUBLE")],
		slipSkid: props.globals.initNode("/instrumentation/pfd/slip-skid", 0, "DOUBLE"),
		spdFms: props.globals.initNode("/instrumentation/pfd/spd-fms", 0, "DOUBLE"),
		spdPreSel: props.globals.initNode("/instrumentation/pfd/spd-pre-sel", 0, "DOUBLE"),
		spdSel: props.globals.initNode("/instrumentation/pfd/spd-sel", 0, "DOUBLE"),
		speedTrend: props.globals.initNode("/instrumentation/pfd/speed-trend", 0, "DOUBLE"),
		trackBug: [props.globals.initNode("/instrumentation/pfd/track-bug[0]", 0, "DOUBLE"), props.globals.initNode("/instrumentation/pfd/track-bug[1]", 0, "DOUBLE")],
		vsBugDn: props.globals.initNode("/instrumentation/pfd/vs-bug-dn", 0, "DOUBLE"),
		vsBugUp: props.globals.initNode("/instrumentation/pfd/vs-bug-up", 0, "DOUBLE"),
		vsNeedleDn: props.globals.initNode("/instrumentation/pfd/vs-needle-dn", 0, "DOUBLE"),
		vsNeedleUp: props.globals.initNode("/instrumentation/pfd/vs-needle-up", 0, "DOUBLE"),
		vsDigit: props.globals.initNode("/instrumentation/pfd/vs-digit", 0, "DOUBLE"),
	},
};

var Sim = {
	Model: {
		airlineCode:  props.globals.getNode("sim/model/airline-code"),
		registration: props.globals.getNode("sim/model/registration"),
		selcal:       props.globals.getNode("sim/model/selcal"),
	},
	Time: {
		day:         props.globals.getNode("sim/time/utc/day"),
		month:       props.globals.getNode("sim/time/utc/month"),
		timeElapsed: props.globals.getNode("sim/time/elapsed-sec"),
		timeUTC:     props.globals.getNode("sim/time/gmt-string"),
		year:        props.globals.getNode("sim/time/utc/year"),
	},
};

var Systems = {
	Acconfig: {
		Options: {
			deflectedAileronEquipped: props.globals.getNode("/systems/acconfig/options/deflected-aileron-equipped"),
			Du: {
				captPfdFps: props.globals.getNode("/systems/acconfig/options/du/capt-pfd-fps"),
				captMfdFps: props.globals.getNode("/systems/acconfig/options/du/capt-mfd-fps"),
				foPfdFps: props.globals.getNode("/systems/acconfig/options/du/fo-pfd-fps"),
				foMfdFps: props.globals.getNode("/systems/acconfig/options/du/fo-mfd-fps"),
				isfdFps: props.globals.getNode("/systems/acconfig/options/du/isfd-fps"),
			},
			# These settings are custom to the MD-11
			# TODO: #39 I need to adjust these to the 737 MAX
			# egtAboveN1: props.globals.getNode("/systems/acconfig/options/egt-above-n1"),
			# engTapes: props.globals.getNode("/systems/acconfig/options/eng-tapes"),
			# iesiEquipped: props.globals.getNode("/systems/acconfig/options/iesi-equipped"),
			# risingRunwayTBar: props.globals.getNode("/systems/acconfig/options/rising-runway-t-bar"),
			# singleCueFd: props.globals.getNode("/systems/acconfig/options/single-cue-fd"),
		},
	},
	Shake: {
		effect: props.globals.getNode("/systems/shake/effect"),
		shaking: props.globals.getNode("/systems/shake/shaking"),
	},
};