#737 MAX Property Tree Setup
#Israel Emmanuel

var Autopilot = {
	Route: {
		active: props.globals.getNode("/autopilot/route-manager/active"),
		Departure: {
			airport: props.globals.getNode("/autopilot/route-manager/departure/airport"),
			fieldElevationFt: props.globals.getNode("/autopilot/route-manager/departure/field-elevation-ft"),
			runway: props.globals.getNode("/autopilot/route-manager/departure/runway"),
			sid: props.globals.getNode("/autopilot/route-manager/departure/sid"),
		},
		Destination: {
			airport: props.globals.getNode("/autopilot/route-manager/destination/airport"),
			approach: props.globals.getNode("/autopilot/route-manager/destination/approach"),
			fieldElevationFt: props.globals.getNode("/autopilot/route-manager/destination/field-elevation-ft"),
			runway: props.globals.getNode("/autopilot/route-manager/destination/runway"),
			star: props.globals.getNode("/autopilot/route-manager/destination/sid"),
		},
		distanceRemainingNm: props.globals.getNode("/autopilot/route-manager/distance-remaining-nm"),
		totalDistance: props.globals.getNode("/autopilot/route-manager/total-distance"),
		WpCur: {
			eta: props.globals.getNode("/autopilot/route-manager/wp[0]/eta"),
			id: props.globals.getNode("/autopilot/route-manager/wp[0]/id"),
		},
	},
};

var Consumables = {
    Fuel: {
        tankRight:  props.globals.getNode("consumables/fuel/tank[0]/level-kg"),
        tankLeft:   props.globals.getNode("consumables/fuel/tank[1]/level-kg"),
        tankCenter: props.globals.getNode("consumables/fuel/tank[2]/level-kg"),
    },
};

var Fdm = {
	Jsbsim: {
		Accelerations: {
			Ny: props.globals.getNode("/fdm/jsbsim/accelerations/Ny"),
		},
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
		radioAlt: [props.globals.getNode("/instrumentation/radar-altimeter[0]/radar-altitude-ft"), props.globals.getNode("/instrumentation/radar-altimeter[1]/radar-altitude-ft")],
		radioAltServiceable: [props.globals.getNode("/instrumentation/radar-altimeter[0]/serviceable"), props.globals.getNode("/instrumentation/radar-altimeter[1]/serviceable")],
		serviceable: [props.globals.getNode("/instrumentation/airspeed-indicator[0]/serviceable"), props.globals.getNode("/instrumentation/airspeed-indicator[1]/serviceable"), props.globals.getNode("/instrumentation/airspeed-indicator[2]/serviceable")],
	},
	Altimeter: {
		indicatedAltitudeFt: [props.globals.getNode("/instrumentation/altimeter[0]/indicated-altitude-ft"), props.globals.getNode("/instrumentation/altimeter[1]/indicated-altitude-ft"), props.globals.getNode("/instrumentation/altimeter[2]/indicated-altitude-ft")],
		radioAlt: [props.globals.getNode("/instrumentation/radar-altimeter[0]/radar-altitude-ft"), props.globals.getNode("/instrumentation/radar-altimeter[1]/radar-altitude-ft")],
		radioAltServiceable: [props.globals.getNode("/instrumentation/radar-altimeter[0]/serviceable"), props.globals.getNode("/instrumentation/radar-altimeter[1]/serviceable")],
		serviceable: [props.globals.getNode("/instrumentation/altimeter[0]/serviceable"), props.globals.getNode("/instrumentation/altimeter[1]/serviceable"), props.globals.getNode("/instrumentation/altimeter[2]/serviceable")],
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
		Inputs: {
			baroInHpa: [props.globals.initNode("/instrumentation/efis[0]/inputs/baro-in-hpa", 0, "BOOL"), props.globals.initNode("/instrumentation/efis[1]/inputs/baro-in-hpa", 0, "BOOL")], # 0 is HPA, 1 is INHG
			baroSelected: [props.globals.initNode("/instrumentation/efis[0]/inputs/baro-selected", 0, "INT"), props.globals.initNode("/instrumentation/efis[1]/inputs/baro-selected", 0, "INT")],
			baroStd: [props.globals.initNode("/instrumentation/efis[0]/inputs/baro-std", 0, "INT"), props.globals.initNode("/instrumentation/efis[1]/inputs/baro-std", 0, "INT")],
			fpv: [props.globals.initNode("/instrumentation/efis[0]/inputs/fpv", 0, "BOOL"), props.globals.initNode("/instrumentation/efis[1]/inputs/fpv", 0, "BOOL")],
			minsAltitude: [props.globals.initNode("/instrumentation/efis[0]/inputs/mins-altitude", 2500, "INT"), props.globals.initNode("/instrumentation/efis[1]/inputs/mins-altitude", 2500, "INT")],
			minsBaroRadio: [props.globals.initNode("/instrumentation/efis[0]/inputs/mins-baro-radio", 0, "BOOL"), props.globals.initNode("/instrumentation/efis[1]/inputs/mins-baro-radio", 0, "BOOL")], # 0 is BARO, 1 is RADIO
			mtrs: [props.globals.initNode("/instrumentation/efis[0]/inputs/mtrs", 0, "BOOL"), props.globals.initNode("/instrumentation/efis[1]/inputs/mtrs", 0, "BOOL")],
			ndCentered: [props.globals.initNode("/instrumentation/efis[0]/inputs/nd-centered", 0, "BOOL"), props.globals.initNode("/instrumentation/efis[1]/inputs/nd-centered", 0, "BOOL")],
			NdLayer: {
				arpt: [props.globals.initNode("/instrumentation/efis[0]/inputs/arpt", 0, "BOOL"), props.globals.initNode("/instrumentation/efis[1]/inputs/arpt", 0, "BOOL")],
				data: [props.globals.initNode("/instrumentation/efis[0]/inputs/data", 0, "BOOL"), props.globals.initNode("/instrumentation/efis[1]/inputs/data", 0, "BOOL")],
				pos: [props.globals.initNode("/instrumentation/efis[0]/inputs/pos", 0, "BOOL"), props.globals.initNode("/instrumentation/efis[1]/inputs/pos", 0, "BOOL")],
				sta: [props.globals.initNode("/instrumentation/efis[0]/inputs/sta", 0, "BOOL"), props.globals.initNode("/instrumentation/efis[1]/inputs/sta", 0, "BOOL")],
				tfc: [props.globals.initNode("/instrumentation/efis[0]/inputs/tfc", 0, "BOOL"), props.globals.initNode("/instrumentation/efis[1]/inputs/tfc", 0, "BOOL")],
				terr: [props.globals.initNode("/instrumentation/efis[0]/inputs/terr", 0, "BOOL"), props.globals.initNode("/instrumentation/efis[1]/inputs/terr", 0, "BOOL")],
				vsd: [props.globals.initNode("/instrumentation/efis[0]/inputs/vsd", 0, "BOOL"), props.globals.initNode("/instrumentation/efis[1]/inputs/vsd", 0, "BOOL")],
				wpt: [props.globals.initNode("/instrumentation/efis[0]/inputs/wpt", 0, "BOOL"), props.globals.initNode("/instrumentation/efis[1]/inputs/wpt", 0, "BOOL")],
				wxr: [props.globals.initNode("/instrumentation/efis[0]/inputs/wxr", 0, "BOOL"), props.globals.initNode("/instrumentation/efis[1]/inputs/wxr", 0, "BOOL")],
			},
			ndMode: [props.globals.initNode("/instrumentation/efis[0]/inputs/nd-mode", "MAP", "STRING"), props.globals.initNode("/instrumentation/efis[1]/inputs/nd-mode", "MAP", "STRING")],
			rangeNm: [props.globals.initNode("/instrumentation/efis[0]/inputs/range-nm", 10, "INT"), props.globals.initNode("/instrumentation/efis[1]/inputs/range-nm", 10, "INT")],
			vorAdf1: [props.globals.initNode("/instrumentation/efis[0]/inputs/vor-adf1", 0, "INT"), props.globals.initNode("/instrumentation/efis[1]/inputs/vor-adf1", 0, "INT")],
			vorAdf2: [props.globals.initNode("/instrumentation/efis[0]/inputs/vor-adf2", 0, "INT"), props.globals.initNode("/instrumentation/efis[1]/inputs/vor-adf2", 0, "INT")],
			vsd: [props.globals.initNode("/instrumentation/efis[0]/inputs/vsd", 0, "BOOL"), props.globals.initNode("/instrumentation/efis[1]/inputs/vsd", 0, "BOOL")],
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
		mmo: props.globals.getNode("/instrumentation/pfd/mmo-kt"),
	},
	Vsi: {
		indicatedSpeedFpm: props.globals.getNode("/instrumentation/vertical-speed-indicator/indicated-speed-fpm"),
		serviceable: props.globals.getNode("/instrumentation/vertical-speed-indicator/serviceable"),
	},
};

var Orientation = {
	alpha: props.globals.getNode("/orientation/alpha-deg"),
	headingDeg: props.globals.getNode("/orientation/heading-deg"),
	pitchDeg: props.globals.getNode("/orientation/pitch-deg"),
	rollDeg: props.globals.getNode("/orientation/roll-deg"),
	trackDeg: props.globals.getNode("/orientation/track-deg"),
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
			fuelDials: props.globals.getNode("/systems/acconfig/options/fuel-dials"),
			oilVib: props.globals.getNode("/systems/acconfig/options/eng-oil-vib"),
		},
	},
	Shake: {
		effect: props.globals.getNode("/systems/shake/effect"),
		shaking: props.globals.getNode("/systems/shake/shaking"),
	},
};