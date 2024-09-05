print("Loading Primary Flight Display...");
var pfd_canvas = nil;
var pfd_display = nil;

var Value = {
	Airspeed: {
		iasKts: 0,
		iasMach: 0,
		stall: 0,
		vmo: 0,
	},
	Altitude: {
		indicatedAltitudeFt: 0,
		radioAlt: 0,
		radioAltServiceable: 0,
		settingHpa: 0,
		serviceable: 0,
	},
	Autopilot: {
		Input: {
			alt: 0,
			fd: 0,
			hdg: 0,
			kts: 0,
			ktsMach: 0,
			mach: 0,
		},
		pitchArm: "",
		pitchMode: "",
		pitchModeChg: 0,
		pitchModePrev: "",
		rollArm: "",
		rollMode: "",
		rollModeChg: 0,
		rollModePrev: "",
		thrMode: "",
		thrModeChg: 0,
		thrModePrev: "",
	},
	Navigation: {
		Adf: {
			selectedKhz: 0,
		},
		Dme: {
			indicatedDistanceNm: 0,
			inRange: 0,
		},
		gsInRange: 0,
		gsNeedleDeflectionNorm: 0,
		hasGs: 0,
		headingNeedleDeflectionNorm: 0,
		inRange: 0,
		MarkerBeacon: {
			inner: 0,
			innerTimeUpdate: 0,
			innerTimeStart: 0,
			middle: 0,
			middleTimeUpdate: 0,
			middleTimeStart: 0,
			outer: 0,
			outerTimeUpdate: 0,
			outerTimeStart: 0,
		},
		navId: "",
		navLoc: "",
		radialSelectedDeg: 0,
		selectedMhz: 0,
		signalQualityNorm: 0,
	},
	Time: {
		elapsedSec: 0,
	},
	Vsi: {
		indicatedSpeedFpm: 0,
		serviceable: 0,
	},
};

var canvas_pfd = {
	new: func(canvas_group) {
		var m = {parents: [canvas_pfd]};
		var pfd = canvas_group;
		var font_mapper = func(family, weight) {
			return "MFD-font.ttf";
		};
		
		canvas.parsesvg(pfd, "Aircraft/737-MAX/Nasal/Displays/res/PFD.svg" , {'font-mapper': font_mapper});
		
		var svg_keys = ["group-fail-warn", "group-ap-modes", "group-speed", "group-navigation", "group-vs", "group-altitude", "group-attitude", "fail-no-vspd", "fail-spd-lim", "fail-sel-spd", "fail-fd", "fail-dme", "fail-fpv", "fail-fac", "fail-loc", "fail-hdg", "fail-ra", "fail-att", "fail-vert", "fail-gp", "fail-gs", "fail-alt", "fail-ldg-alt", "fail-roll", "fail-pitch", "fail-spd", "warning-msg", "warning-back", "ap-pitch-arm", "ap-roll-arm", "ap-pitch-mode", "ap-roll-mode", "ap-thr-mode", "ap-pitch-box", "ap-roll-box", "ap-thr-box", "spd-tick-r", "spd-r", "spd-tick-v1", "spd-v1", "spd-tick-up", "spd-up", "spd-tick-ref", "spd-ref", "spd-tick-1", "spd-1", "spd-tick-5", "spd-5", "spd-tick-15", "spd-15", "spd-vref-20", "spd-80-kts", "spd-v2-15", "spd-spare-bug", "srs-speed", "srs-selected", "spd-mach", "spd-ap-readout", "spd-ap-box", "spd-ap", "spd-trend-up", "spd-trend-down", "spd-limitLY", "spd-limitLR", "spd-limitLB", "spd-limitUY", "spd-limitUR", "spd-limitUB", "spd-box-1", "spd-box-10", "spd-box-100", "spd-box", "spd-tape", "spd-border", "spd-back", "rising-rwy", "inner-marker", "middle-marker", "outer-marker", "marker-color", "ils-ident", "ils-dist", "nav-src", "course-dev-vert", "anp-vert", "course-dev-lat", "anp-lat", "lines-lat-app", "lines-vert-ils", "lines-lat-ils", "lines-vert-std", "lines-lat-std", "vs-labels", "vs-selected", "vs-pos-readout", "vs-neg-readout", "vs-needle", "vs-border", "vs-back", "alt-mins-readout", "alt-mins-mode", "alt-press-std", "alt-press-std-set", "alt-press-units", "alt-press", "alt-final", "alt-final-box", "alt-ap-1000", "alt-ap-100", "alt-ap-m-unit", "alt-ap-m-readout", "alt-ap-back", "alt-m-readout", "alt-m-unit", "alt-m-back", "alt-10000", "alt-1000", "alt-100", "alt-20", "alt-0", "alt-neg", "alt-tape-back", "alt-mins", "alt-ap", "alt-tape0", "alt-tape1", "alt-tape2", "alt-tape3", "alt-tape4", "alt-tape5", "alt-tape6", "alt-tape7", "alt-ground-close", "alt-ground", "alt-border", "alt-back", "airplane-symbol-b", "airplane-symbol-w", "slip-skid", "bank-angle", "aoa-shaker", "aoa-needle", "aoa-readout", "aoa-approach-upper", "aoa-approach-lower", "aoa-approach", "pitch-limit-indicator", "flight-trend", "fd-pitch", "fd-roll", "ladder", "labels-back", "sky", "ground", "heading-mode", "heading-ap-readout", "wind-stats", "true-airspeed", "ground-speed", "vor1", "vor2", "dme1", "dme2", "heading-ap", "heading-track", "compass-label"];
		foreach(var key; svg_keys)
			m[key] = pfd.getElementById(key);

        m.timers=[];

		# These run once - do not put inside update()
		# Clipping boxes are (top, right, bottom, left)
		m["spd-back"].setColorFill(0, 0, 0, 0.2);
		m["alt-back"].setColorFill(0, 0, 0, 0.2);
		m["labels-back"].setColorFill(0, 0, 0, 0.2);
		m["vs-back"].setColorFill(0, 0, 0, 0.2);
		m["spd-tick-r"].set("clip", "rect(160, 682, 1142, 437)");
		m["spd-r"].set("clip", "rect(160, 682, 1142, 437)");
		m["spd-tick-v1"].set("clip", "rect(160, 682, 1142, 437)");
		m["spd-v1"].set("clip", "rect(160, 682, 1142, 437)");
		m["spd-tick-up"].set("clip", "rect(160, 682, 1142, 437)");
		m["spd-up"].set("clip", "rect(160, 682, 1142, 437)");
		m["spd-tick-ref"].set("clip", "rect(160, 682, 1142, 437)");
		m["spd-ref"].set("clip", "rect(160, 682, 1142, 437)");
		m["spd-tick-1"].set("clip", "rect(160, 682, 1142, 437)");
		m["spd-1"].set("clip", "rect(160, 682, 1142, 437)");
		m["spd-tick-5"].set("clip", "rect(160, 682, 1142, 437)");
		m["spd-5"].set("clip", "rect(160, 682, 1142, 437)");
		m["spd-tick-15"].set("clip", "rect(160, 682, 1142, 437)");
		m["spd-15"].set("clip", "rect(160, 682, 1142, 437)");
		m["spd-vref-20"].set("clip", "rect(160, 682, 1142, 437)");
		m["spd-80-kts"].set("clip", "rect(160, 682, 1142, 437)");
		m["spd-v2-15"].set("clip", "rect(160, 682, 1142, 437)");
		m["spd-spare-bug"].set("clip", "rect(160, 682, 1142, 437)");
		m["spd-ap"].set("clip", "rect(160, 682, 1142, 437)");
		m["spd-trend-up"].set("clip", "rect(160, 612, 655, 592)");
		m["spd-trend-down"].set("clip", "rect(655, 612, 1150, 592)");
		m["spd-limitLY"].set("clip", "rect(160, 682, 1142, 437)");
		m["spd-limitLR"].set("clip", "rect(160, 682, 1142, 437)");
		m["spd-limitLB"].set("clip", "rect(160, 682, 1142, 437)");
		m["spd-limitUY"].set("clip", "rect(160, 682, 1142, 437)");
		m["spd-limitUR"].set("clip", "rect(160, 682, 1142, 437)");
		m["spd-limitUB"].set("clip", "rect(160, 682, 1142, 437)");
		m["spd-box-1"].set("clip", "rect(590, 554, 720, 435)");
		m["spd-box-10"].set("clip", "rect(590, 554, 720, 435)");
		m["spd-box-100"].set("clip", "rect(590, 554, 720, 435)");
		m["spd-tape"].set("clip", "rect(160, 682, 1142, 437)");
		m["vs-needle"].set("clip", "rect(314, 1791, 996, 1724)");
		return m;
	},

	update: func(n) {
		Value.Autopilot.thrMode = itaf.Fma.thr.getValue();
		Value.Autopilot.pitchMode = itaf.Fma.pitch.getValue();
		Value.Autopilot.pitchArm = itaf.Fma.pitchArm.getValue();
		Value.Autopilot.rollMode = itaf.Fma.roll.getValue();
		Value.Autopilot.rollArm = itaf.Fma.rollArm.getValue();
		Value.Autopilot.Input.kts = itaf.Input.kts.getValue();
		Value.Autopilot.Input.mach = itaf.Input.mach.getValue();
		Value.Autopilot.Input.ktsMach = itaf.Input.ktsMach.getBoolValue();
		Value.Airspeed.vmo = pts.Instrumentation.Pfd.mmo.getValue();
		Value.Navigation.MarkerBeacon.inner = pts.Instrumentation.MarkerBeacon.inner.getBoolValue();
		Value.Navigation.MarkerBeacon.middle = pts.Instrumentation.MarkerBeacon.middle.getBoolValue();
		Value.Navigation.MarkerBeacon.outer = pts.Instrumentation.MarkerBeacon.outer.getBoolValue();
		Value.Time.elapsedSec = pts.Sim.Time.timeElapsed.getValue();
		Value.Vsi.indicatedSpeedFpm = itaf.Internal.vs.getValue();
		Value.Vsi.serviceable = pts.Instrumentation.Vsi.serviceable.getBoolValue();

		# Pilot-specific values
		# These generally come from sensors which only one pilot uses at a time, unless in an emergency
		# TODO: #44 Implement source switching and crosscheck with other sensors for failures
		if (n == "capt") {
			Value.Airspeed.iasKts = pts.Instrumentation.AirspeedIndicator.indicatedSpeedKt[0].getValue();
			Value.Airspeed.iasMach = pts.Instrumentation.AirspeedIndicator.indicatedMach[0].getValue();
			Value.Navigation.Adf.selectedKhz = pts.Instrumentation.Adf.Frequencies.selectedKhz[0].getValue();
			Value.Navigation.Dme.indicatedDistanceNm = pts.Instrumentation.Dme.indicatedDistanceNm[0].getValue();
			Value.Navigation.Dme.inRange = pts.Instrumentation.Dme.inRange[0].getBoolValue();
			Value.Navigation.gsInRange = pts.Instrumentation.Nav.gsInRange[0].getBoolValue();
			Value.Navigation.gsNeedleDeflectionNorm = pts.Instrumentation.Nav.gsNeedleDeflectionNorm[0].getValue();
			Value.Navigation.hasGs = pts.Instrumentation.Nav.hasGs[0].getValue();
			Value.Navigation.inRange = pts.Instrumentation.Nav.inRange[0].getBoolValue();
			Value.Navigation.navId = pts.Instrumentation.Nav.navId[0].getValue();
			Value.Navigation.navLoc = pts.Instrumentation.Nav.navLoc[0].getBoolValue();
			Value.Navigation.radialSelectedDeg = pts.Instrumentation.Nav.Radials.selectedDeg[0].getValue();
			Value.Navigation.selectedMhz = pts.Instrumentation.Nav.Frequencies.selectedMhz[0].getValue();
			Value.Navigation.signalQualityNorm = pts.Instrumentation.Nav.signalQualityNorm[0].getValue();
			Value.Altitude.radioAlt = pts.Instrumentation.Altimeter.radioAlt[0].getValue();
			Value.Altitude.radioAltServiceable = pts.Instrumentation.Altimeter.radioAltServiceable[0].getBoolValue();
		} elsif (n == "fo") {
			Value.Airspeed.iasKts = pts.Instrumentation.AirspeedIndicator.indicatedSpeedKt[1].getValue();
			Value.Airspeed.iasMach = pts.Instrumentation.AirspeedIndicator.indicatedMach[1].getValue();
			Value.Navigation.Adf.selectedKhz = pts.Instrumentation.Adf.Frequencies.selectedKhz[1].getValue();
			Value.Navigation.Dme.indicatedDistanceNm = pts.Instrumentation.Dme.indicatedDistanceNm[1].getValue();
			Value.Navigation.Dme.inRange = pts.Instrumentation.Dme.inRange[1].getBoolValue();
			Value.Navigation.gsInRange = pts.Instrumentation.Nav.gsInRange[1].getBoolValue();
			Value.Navigation.gsNeedleDeflectionNorm = pts.Instrumentation.Nav.gsNeedleDeflectionNorm[1].getValue();
			Value.Navigation.hasGs = pts.Instrumentation.Nav.hasGs[1].getValue();
			Value.Navigation.inRange = pts.Instrumentation.Nav.inRange[1].getBoolValue();
			Value.Navigation.navId = pts.Instrumentation.Nav.navId[1].getValue();
			Value.Navigation.navLoc = pts.Instrumentation.Nav.navLoc[1].getBoolValue();
			Value.Navigation.radialSelectedDeg = pts.Instrumentation.Nav.Radials.selectedDeg[1].getValue();
			Value.Navigation.selectedMhz = pts.Instrumentation.Nav.Frequencies.selectedMhz[1].getValue();
			Value.Navigation.signalQualityNorm = pts.Instrumentation.Nav.signalQualityNorm[1].getValue();
			Value.Altitude.radioAlt = pts.Instrumentation.Altimeter.radioAlt[1].getValue();
			Value.Altitude.radioAltServiceable = pts.Instrumentation.Altimeter.radioAltServiceable[1].getBoolValue();
		}

		# Hide failure flags by default
		me["group-fail-warn"].hide();

		# Autopilot Modes
		me["ap-pitch-arm"].setText(Value.Autopilot.pitchArm);
		me["ap-roll-arm"].setText(Value.Autopilot.rollArm);
		me["ap-pitch-mode"].setText(Value.Autopilot.pitchMode);
		me["ap-roll-mode"].setText(Value.Autopilot.rollMode);
		me["ap-thr-mode"].setText(Value.Autopilot.thrMode);
		if (Value.Autopilot.pitchModePrev != Value.Autopilot.pitchMode) {
			Value.Autopilot.pitchModePrev = Value.Autopilot.pitchMode;
			Value.Autopilot.pitchModeChg = Value.Time.elapsedSec;
		}
		if (Value.Time.elapsedSec - Value.Autopilot.pitchModeChg < 10) {
			me["ap-pitch-box"].show();
		} else {
			me["ap-pitch-box"].hide();
		}
		if (Value.Autopilot.rollModePrev != Value.Autopilot.rollMode) {
			Value.Autopilot.rollModePrev = Value.Autopilot.rollMode;
			Value.Autopilot.rollModeChg = Value.Time.elapsedSec;
		}
		if (Value.Time.elapsedSec - Value.Autopilot.rollModeChg < 10) {
			me["ap-roll-box"].show();
		} else {
			me["ap-roll-box"].hide();
		}
		if (Value.Autopilot.thrModePrev != Value.Autopilot.thrMode) {
			Value.Autopilot.thrModePrev = Value.Autopilot.thrMode;
			Value.Autopilot.thrModeChg = Value.Time.elapsedSec;
		}
		if (Value.Time.elapsedSec - Value.Autopilot.thrModeChg < 10) {
			me["ap-thr-box"].show();
		} else {
			me["ap-thr-box"].hide();
		}

		# Speed Tapes
		if (Value.Autopilot.Input.kts != nil or Value.Autopilot.Input.mach != nil) {
			me["spd-ap-box"].show();
			me["spd-ap-readout"].show();
			me["spd-ap"].show();
			if (Value.Autopilot.Input.ktsMach) {
				me["spd-ap-readout"].setText(sprintf("%.3f", Value.Autopilot.Input.mach));
			} else {
				me["spd-ap-readout"].setText(sprintf("%i", Value.Autopilot.Input.kts));
			}
		} else {
			me["spd-ap-box"].hide();
			me["spd-ap-readout"].hide();
			me["spd-ap"].hide();
			me["fail-sel-spd"].show();
		}

		if (Value.Airspeed.iasMach < 0.4) {
			me["spd-mach"].hide();
		} else {
			me["spd-mach"].show();
			me["spd-mach"].setText(sprintf("%.3f", Value.Airspeed.iasMach));
		}

		me["spd-tick-r"].hide(); #.setTranslation(0, Value.Airspeed.iasKts * 8);
		me["spd-r"].hide(); #.setTranslation(0, Value.Airspeed.iasKts * 8);
		me["spd-tick-v1"].hide(); #.setTranslation(0, Value.Airspeed.iasKts * 8);
		me["spd-v1"].hide(); #.setTranslation(0, Value.Airspeed.iasKts * 8);
		me["spd-tick-up"].hide(); #.setTranslation(0, Value.Airspeed.iasKts * 8);
		me["spd-up"].hide(); #.setTranslation(0, Value.Airspeed.iasKts * 8);
		me["spd-tick-ref"].hide(); #.setTranslation(0, Value.Airspeed.iasKts * 8);
		me["spd-ref"].hide(); #.setTranslation(0, Value.Airspeed.iasKts * 8);
		me["spd-tick-1"].hide(); #.setTranslation(0, Value.Airspeed.iasKts * 8);
		me["spd-1"].hide(); #.setTranslation(0, Value.Airspeed.iasKts * 8);
		me["spd-tick-5"].hide(); #.setTranslation(0, Value.Airspeed.iasKts * 8);
		me["spd-5"].hide(); #.setTranslation(0, Value.Airspeed.iasKts * 8);
		me["spd-tick-15"].hide(); #.setTranslation(0, Value.Airspeed.iasKts * 8);
		me["spd-15"].hide(); #.setTranslation(0, Value.Airspeed.iasKts * 8);
		me["spd-vref-20"].hide(); #.setTranslation(0, Value.Airspeed.iasKts * 8);
		me["spd-80-kts"].hide(); #.setTranslation(0, Value.Airspeed.iasKts * 8);
		me["spd-v2-15"].hide(); #.setTranslation(0, Value.Airspeed.iasKts * 8);
		me["spd-spare-bug"].hide(); #.setTranslation(0, Value.Airspeed.iasKts * 8);
		me["fail-no-vspd"].show();
		me["spd-limitLY"].setTranslation(0, (Value.Airspeed.iasKts - Value.Airspeed.stall) * 8);
		me["spd-limitLR"].setTranslation(0, (Value.Airspeed.iasKts - Value.Airspeed.stall) * 8);
		me["spd-limitLB"].setTranslation(0, (Value.Airspeed.iasKts - Value.Airspeed.stall) * 8);
		me["spd-limitUY"].setTranslation(0, (Value.Airspeed.iasKts - Value.Airspeed.vmo) * 8);
		me["spd-limitUR"].setTranslation(0, (Value.Airspeed.iasKts - Value.Airspeed.vmo) * 8);
		me["spd-limitUB"].setTranslation(0, (Value.Airspeed.iasKts - Value.Airspeed.vmo) * 8);
		me["spd-tape"].setTranslation(0, Value.Airspeed.iasKts * 8);
		if (Value.Autopilot.Input.kts - Value.Airspeed.iasKts > 61.875) {
			me["spd-ap"].setTranslation(0, -495);
		} elsif (Value.Autopilot.Input.kts - Value.Airspeed.iasKts < -61.875) {
			me["spd-ap"].setTranslation(0, 495);
		} else {
			me["spd-ap"].setTranslation(0, (Value.Airspeed.iasKts - Value.Autopilot.Input.kts) * 8);
		}
		# TODO: #43 animate v-speed bugs

		if (Value.Airspeed.iasKts <= 45) {
			me["spd-box-1"].setTranslation(0, 68*5);
			me["spd-box-10"].setTranslation(0, 91*4);
		} else {
			me["spd-box-1"].setTranslation(0, math.mod(Value.Airspeed.iasKts, 10) * 68);
			me["spd-box-10"].setTranslation(0, math.mod(math.floor(Value.Airspeed.iasKts/10), 10) * 91);
			if (math.mod(Value.Airspeed.iasKts, 10) > 9) {
				me["spd-box-10"].setTranslation(0, (math.mod(math.floor(Value.Airspeed.iasKts/10), 10) - 9 + math.mod(Value.Airspeed.iasKts, 10)) * 91);
			}
			me["spd-box-100"].setTranslation(0, math.mod(math.floor(Value.Airspeed.iasKts/100), 10) * 91);
			if (math.mod(Value.Airspeed.iasKts, 100) > 99) {
				me["spd-box-100"].setTranslation(0, (math.mod(math.floor(Value.Airspeed.iasKts/100), 10) - 99 + math.mod(Value.Airspeed.iasKts, 100)) * 91);
			}
		}

		# Radio Navigation
		me["rising-rwy"].hide();
		# ANP isn't supported yet
		me["anp-lat"].hide();
		me["anp-vert"].hide();
		if (Value.Navigation.selectedMhz != 0) {
			if (Value.Navigation.signalQualityNorm >= 0.95 and Value.Navigation.navLoc) {
				if (Value.Altitude.radioAlt <= 2500) {	
					me["rising-rwy"].show();
					if (Value.Altitude.radioAlt < 200) {
						me["rising-rwy"].setTranslation(0, Value.Altitude.radioAlt * -1.75);
					}
				} else {
					me["rising-rwy"].hide();
				}

				# Marker Beacon
				if (!Value.Navigation.MarkerBeacon.inner) {
					Value.Navigation.MarkerBeacon.innerTimeStart = Value.Time.elapsedSec;
				}
				if (!Value.Navigation.MarkerBeacon.middle) {
					Value.Navigation.MarkerBeacon.middleTimeStart = Value.Time.elapsedSec;
				}
				if (!Value.Navigation.MarkerBeacon.outer) {
					Value.Navigation.MarkerBeacon.outerTimeStart = Value.Time.elapsedSec;
				}
				me["marker-color"].hide();
				me["inner-marker"].hide();
				me["middle-marker"].hide();
				me["outer-marker"].hide();
				if (Value.Navigation.MarkerBeacon.inner) {
					# On for .125 seconds, off for .125
					me["marker-color"].setColorFill(1, 1, 1, 1);
					if (math.mod(Value.Time.elapsedSec - Value.Navigation.MarkerBeacon.innerTimeStart, 0.25) > 0.125) {
						me["marker-color"].show();
						me["inner-marker"].show();
					} else {
						me["marker-color"].hide();
						me["inner-marker"].hide();
					}
				} elsif (Value.Navigation.MarkerBeacon.middle) {
					# On for .375 seconds, off for .125, on for .125, off for .125
					me["marker-color"].setColorFill(1, 0.75, 0, 1);
					if ((math.mod(Value.Time.elapsedSec - Value.Navigation.MarkerBeacon.middleTimeStart, 0.75) > 0.125 and math.mod(Value.Time.elapsedSec - Value.Navigation.MarkerBeacon.middleTimeStart, 0.75) < 0.25)  or (math.mod(Value.Time.elapsedSec - Value.Navigation.MarkerBeacon.middleTimeStart, 0.75) > 0.375 and math.mod(Value.Time.elapsedSec - Value.Navigation.MarkerBeacon.middleTimeStart, 0.75) < 0.75)) {
						me["marker-color"].show();
						me["middle-marker"].show();
					} else {
						me["marker-color"].hide();
						me["middle-marker"].hide();
					}
				} elsif (Value.Navigation.MarkerBeacon.outer) {
					# On for .375 seconds, off for .125
					me["marker-color"].setColorFill(0, 1, 1, 1);
					if (math.mod(Value.Time.elapsedSec - Value.Navigation.MarkerBeacon.outerTimeStart, 0.5) > 0.125) {
						me["marker-color"].show();
						me["outer-marker"].show();
					} else {
						me["marker-color"].hide();
						me["outer-marker"].hide();
					}
				}
				if (!Value.Navigation.inRange or Value.Navigation.navId == "" or Value.Navigation.navId == nil) {
					me["ils-ident"].setText(sprintf("%.2f/%03d", Value.Navigation.selectedMhz, Value.Navigation.radialSelectedDeg));
				} else {
					me["ils-ident"].setText(sprintf("%s/%03d", Value.Navigation.navId, Value.Navigation.radialSelectedDeg));
				}
				if (Value.Navigation.Dme.inRange) {
					me["ils-dist"].setText(sprintf("DME %.1f", Value.Navigation.Dme.indicatedDistanceNm));
				} else {
					me["ils-dist"].hide();
				}
				me["nav-src"].setText(""); # TODO: #46 Simulate RNP sources				
			} else { # Hide all localiser elements
				me["group-navigation"].hide();
			}
			# Localiser
			# TODO: #48 Simulate different types of localiser lines
			me["lines-lat-app"].hide();
			me["lines-vert-std"].hide();
			me["lines-lat-std"].hide();
			if (Value.Navigation.headingNeedleDeflectionNorm >= 10) {
				me["course-dev-lat"].setTranslation(200, 0);
			} elsif (Value.Navigation.headingNeedleDeflectionNorm <= -10) {
				me["course-dev-lat"].setTranslation(-200, 0);
			} else {
				me["course-dev-lat"].setColorFill(1, 0, 1, 1);
				me["course-dev-lat"].setTranslation(Value.Navigation.headingNeedleDeflectionNorm * 20, 0);
			}
			if (Value.Navigation.hasGs) {
				me["course-dev-vert"].show();
				if (Value.Navigation.gsNeedleDeflectionNorm >= 10) {
					me["course-dev-vert"].setTranslation(0, 200);
				} elsif (Value.Navigation.gsNeedleDeflectionNorm <= 10) {
					me["course-dev-vert"].setTranslation(0, -200);
				} else {
					me["course-dev-vert"].setTranslation(0, Value.Navigation.gsNeedleDeflectionNorm * 20);
				}
			}
		}

		# Vertical Speed
		if (Value.Vsi.serviceable) {	
			if (Value.Vsi.indicatedSpeedFpm >= 400) {
				me["vs-pos-readout"].show();
				me["vs-neg-readout"].hide();
				me["vs-pos-readout"].setText(sprintf("%i", math.floor(Value.Vsi.indicatedSpeedFpm / 50) * 50));
			} elsif (Value.Vsi.indicatedSpeedFpm <= -400) {
				me["vs-pos-readout"].hide();
				me["vs-neg-readout"].show();
				me["vs-neg-readout"].setText(sprintf("%i", math.floor(math.abs(Value.Vsi.indicatedSpeedFpm) / 50) * 50));
			} else {
				me["vs-pos-readout"].hide();
				me["vs-neg-readout"].hide();
			}
		} else {
			me["group-vs"].hide();
			me["fail-vert"].show();
		}

		# Altitude
		if (Value.Altitude.radioAltServiceable) {
			if (Value.Altitude.radioAlt <= 2500) {
				me["alt-final"].show();
				me["alt-final-box"].show();
				if (Value.Altitude.radioAlt <= 100) {
					me["alt-final"].setText(sprintf("%i", math.round(Value.Altitude.radioAlt, 2)));
				} elsif (Value.Altitude.radioAlt <= 500) {
					me["alt-final"].setText(sprintf("%i", math.round(Value.Altitude.radioAlt, 10)));
				} else {
					me["alt-final"].setText(sprintf("%i", math.round(Value.Altitude.radioAlt, 20)));
				}
			} else {
				me["alt-final"].hide();
				me["alt-final-box"].hide();
			}
		} else {
			me["alt-final"].hide();
			me["alt-final-box"].hide();
			me["fail-ra"].show();
		}
	}
		
};

setlistener("sim/signals/fdm-initialized", func() {
	pfd_display = canvas.new({
		"name": "Primary Flight Display",
		"size": [2048, 2048],
		"view": [2048, 2048],
		"mipmapping": 1
	});
	pfd_display.addPlacement({"node": "screen.pfd-capt"});
	var group = pfd_display.createGroup();
	pfd_canvas = canvas_pfd.new(group);
	update_timer = maketimer(0.1, func pfd_canvas.update("capt"));
 	update_timer.start();
 	pfd_canvas.update("capt");
}, 0, 0);

var showPfd = func() {
	var dlg = canvas.Window.new([512, 512], "dialog").set("resize", 1);
	dlg.setCanvas(pfd_display);
}