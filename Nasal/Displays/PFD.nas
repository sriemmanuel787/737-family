# Boeing 737 MAX PFD

print("Loading Primary Flight Display...");
var pfd1 = nil;
var pfd1Display = nil;
var pfd2 = nil;
var pfd2Display = nil;

var Value = {
	Airspeed: {
		gsKts: 0,
		iasKts: 0,
		iasMach: 0,
		stall: 0,
		tasKts: 0,
		vmo: 0,
	},
	Altitude: {
		indicatedAltitudeFt: 0,
		radioAlt: 0,
		radioAltServiceable: 0,
		settingHpa: 0,
		serviceable: 0,
	},
	Attitude: {
		alpha: 0,
		indicatedPitchDeg: 0,
		indicatedRollDeg: 0,
		indicatedSlipSkid: 0,
	},
	Autopilot: {
		fd: 0,
		fdPitch: 0,
		fdRoll: 0,
		Input: {
			alt: 0,
			hdg: 0,
			kts: 0,
			ktsMach: 0,
			mach: 0,
			vs: 0,
		},
		lat: 0,
		pitchArm: "",
		pitchMode: "",
		pitchModeChg: 0,
		pitchModePrev: "",
		rollArm: "",
		rollMode: "",
		rollModeChg: 0,
		rollModePrev: "",
		Route: {
			departureAlt: 0,
			destinationAlt: 0,
			distanceRemainingNm: 0,
			totalDistance: 0,
		},
		thrMode: "",
		thrModeChg: 0,
		thrModePrev: "",
		vert: 0,
	},
	Efis: {
		baroInHpa: 0,
		baroSelected: 0,
		baroStd: 0,
		fpv: 0,
		minsAltitude: 0,
		minsBaroRadio: 0,
		mtrs: 0,
	},
	Heading: {
		indicatedHeadingDeg: 0,
		indicatedTrackDeg: 0,
		magTru: 0,
		magTruChg: 0,
		magTruPrev: 0,
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

var canvasBase = {
	init: func(canvasGroup, file) {
		var font_mapper = func(family, weight) {
			return "MFD-font.ttf";
		};
		
		canvas.parsesvg(canvasGroup, file, {"font-mapper": font_mapper});
		
		var svgKeys = me.getKeys();
		foreach(var key; svgKeys) {
			me[key] = canvasGroup.getElementById(key);
		}

		# These run once - do not put inside update()
		# Clipping boxes are (top, right, bottom, left)
		var spdTapeClip = "rect(160, 682, 1142, 437)";
		var spdBoxClip = "rect(590, 554, 720, 435)";
		var altTapeClip = "rect(160, 1636, 1142, 1422)";
		var altBoxClip = "rect(595, 1693, 715, 1519)";
		me["spd-back"].setColorFill(0, 0, 0, 0.2);
		me["alt-back"].setColorFill(0, 0, 0, 0.2);
		me["labels-back"].setColorFill(0, 0, 0, 0.2);
		me["vs-back"].setColorFill(0, 0, 0, 0.2);
		me["spd-tick-r"].set("clip", spdTapeClip);
		me["spd-r"].set("clip", spdTapeClip);
		me["spd-tick-v1"].set("clip", spdTapeClip);
		me["spd-v1"].set("clip", spdTapeClip);
		me["spd-tick-up"].set("clip", spdTapeClip);
		me["spd-up"].set("clip", spdTapeClip);
		me["spd-tick-ref"].set("clip", spdTapeClip);
		me["spd-ref"].set("clip", spdTapeClip);
		me["spd-tick-1"].set("clip", spdTapeClip);
		me["spd-1"].set("clip", spdTapeClip);
		me["spd-tick-5"].set("clip", spdTapeClip);
		me["spd-5"].set("clip", spdTapeClip);
		me["spd-tick-15"].set("clip", spdTapeClip);
		me["spd-15"].set("clip", spdTapeClip);
		me["spd-vref-20"].set("clip", spdTapeClip);
		me["spd-80-kts"].set("clip", spdTapeClip);
		me["spd-v2-15"].set("clip", spdTapeClip);
		me["spd-spare-bug"].set("clip", spdTapeClip);
		me["spd-ap"].set("clip", spdTapeClip);
		me["spd-trend-up"].set("clip", "rect(160, 612, 655, 592)");
		me["spd-trend-down"].set("clip", "rect(655, 612, 1150, 592)");
		me["spd-limitLY"].set("clip", spdTapeClip);
		me["spd-limitLR"].set("clip", spdTapeClip);
		me["spd-limitLB"].set("clip", spdTapeClip);
		me["spd-limitUY"].set("clip", spdTapeClip);
		me["spd-limitUR"].set("clip", spdTapeClip);
		me["spd-limitUB"].set("clip", spdTapeClip);
		me["spd-box-1"].set("clip", spdBoxClip);
		me["spd-box-10"].set("clip", spdBoxClip);
		me["spd-box-100"].set("clip", spdBoxClip);
		me["spd-tape"].set("clip", spdTapeClip);
		me["vs-needle"].set("clip", "rect(314, 1791, 996, 1724)");
		me["vs-needle"].setCenter(1854, 655);
		me["alt-mins"].set("clip", altTapeClip);
		me["alt-ap"].set("clip", altTapeClip);
		me["alt-tape0"].set("clip", altTapeClip);
		me["alt-tape1"].set("clip", altTapeClip);
		me["alt-tape2"].set("clip", altTapeClip);
		me["alt-tape3"].set("clip", altTapeClip);
		me["alt-tape4"].set("clip", altTapeClip);
		me["alt-tape5"].set("clip", altTapeClip);
		me["alt-tape6"].set("clip", altTapeClip);
		me["alt-tape7"].set("clip", altTapeClip);
		me["alt-ground-close"].set("clip", altTapeClip);
		me["alt-ground"].set("clip", altTapeClip);
		me["alt-10000"].set("clip", altBoxClip);
		me["alt-1000"].set("clip", altBoxClip);
		me["alt-100"].set("clip", altBoxClip);
		me["alt-20"].set("clip", altBoxClip);
		# me["slip-skid"].setCenter(1024, 655);
		# me["bank-angle"].setCenter(1024, 655);
		var compassCenter = me["compass-label"].getCenter();
		me["heading-track"].setCenter(compassCenter);
		me["heading-ap"].setCenter(compassCenter);

		me.attitudeTransPitch = me["group-artificial-horizon"].createTransform();
		me.attitudeTransRoll = me["group-artificial-horizon"].createTransform();
		me.fpvTrans = me["flight-path-vector"].createTransform();
		me.fpvRot = me["flight-path-vector"].createTransform();
		
		me.page = canvasGroup;
		
		return me;
	},
	getKeys: func() {
		return ["group-fail-warn", "group-ap-modes", "group-speed", "group-navigation", "group-vs", "group-altitude", "group-attitude", "group-artificial-horizon", "fail-no-vspd", "fail-spd-lim", "fail-sel-spd", "fail-fd", "fail-dme", "fail-fpv", "fail-fac", "fail-loc", "fail-hdg", "fail-ra", "fail-att", "fail-vert", "fail-gp", "fail-gs", "fail-alt", "fail-ldg-alt", "fail-roll", "fail-pitch", "fail-spd", "warning-msg", "warning-back", "ap-pitch-arm", "ap-roll-arm", "ap-pitch-mode", "ap-roll-mode", "ap-thr-mode", "ap-pitch-box", "ap-roll-box", "ap-thr-box", "spd-tick-r", "spd-r", "spd-tick-v1", "spd-v1", "spd-tick-up", "spd-up", "spd-tick-ref", "spd-ref", "spd-tick-1", "spd-1", "spd-tick-5", "spd-5", "spd-tick-15", "spd-15", "spd-vref-20", "spd-80-kts", "spd-v2-15", "spd-spare-bug", "srs-speed", "srs-selected", "spd-mach", "spd-ap-readout", "spd-ap-box", "spd-ap", "spd-trend-up", "spd-trend-down", "spd-limitLY", "spd-limitLR", "spd-limitLB", "spd-limitUY", "spd-limitUR", "spd-limitUB", "spd-box-1", "spd-box-10", "spd-box-100", "spd-box", "spd-tape", "spd-border", "spd-back", "rising-rwy", "inner-marker", "middle-marker", "outer-marker", "marker-color", "ils-ident", "ils-dist", "nav-src", "course-dev-vert", "anp-vert", "course-dev-lat", "anp-lat", "lines-lat-app", "lines-vert-ils", "lines-lat-ils", "lines-vert-std", "lines-lat-std", "vs-labels", "vs-selected", "vs-pos-readout", "vs-neg-readout", "vs-needle", "vs-border", "vs-back", "alt-mins-readout", "alt-mins-mode", "alt-press-std", "alt-press-std-set", "alt-press-units", "alt-press", "alt-final", "alt-final-box", "alt-ap-1000", "alt-ap-100", "alt-ap-m-unit", "alt-ap-m-readout", "alt-ap-m-back", "alt-ap-back", "alt-m-readout", "alt-m-unit", "alt-m-back", "alt-10000", "alt-1000", "alt-100", "alt-20", "alt-0", "alt-neg", "alt-tape-back", "alt-mins", "alt-ap", "alt-tape0", "alt-tape1", "alt-tape2", "alt-tape3", "alt-tape4", "alt-tape5", "alt-tape6", "alt-tape7", "alt-ground-close", "alt-ground", "alt-border", "alt-back", "airplane-symbol-b", "airplane-symbol-w", "slip-skid", "bank-angle", "aoa-shaker", "aoa-needle", "aoa-readout", "aoa-approach-upper", "aoa-approach-lower", "aoa-approach", "pitch-limit-indicator", "flight-path-vector", "fd-pitch", "fd-roll", "ladder", "labels-back", "sky", "ground", "heading-mode", "heading-mode-box", "heading-ap-readout", "wind-stats", "true-airspeed", "ground-speed", "vor1", "vor2", "dme1", "dme2", "heading-ap", "heading-track", "compass-label"];
	},
	setup: func() {
		# Hide the pages by default
		pfd1.page.hide();
		pfd1.setup();
		pfd2.page.hide();
		pfd2.setup();
	},
	update: func() {
		pfd1.update();
		pfd2.update();
		# if (systems.DUController.updatePfd1) {
		# 	pfd1.update();
		# }
		# if (systems.DUController.updatePfd2) {
		# 	pfd2.update();
		# }
	},
	updateBase: func(n) {
		Value.Airspeed.vmo = pts.Instrumentation.Pfd.mmo.getValue();
		Value.Attitude.indicatedPitchDeg = pts.Orientation.pitchDeg.getValue();
		Value.Attitude.indicatedRollDeg = pts.Orientation.rollDeg.getValue();
		Value.Attitude.indicatedSlipSkid = pts.Fdm.Jsbsim.Accelerations.Ny.getValue();
		Value.Autopilot.fdPitch = itaf.Fd.pitchBar.getValue();
		Value.Autopilot.fdRoll = itaf.Fd.rollBar.getValue();
		Value.Autopilot.Input.alt = itaf.Input.alt.getValue();
		Value.Autopilot.Input.hdg = itaf.Input.hdg.getValue();
		Value.Autopilot.Input.kts = itaf.Input.kts.getValue();
		Value.Autopilot.Input.ktsMach = itaf.Input.ktsMach.getBoolValue();
		Value.Autopilot.Input.mach = itaf.Input.mach.getValue();
		Value.Autopilot.Input.vs = itaf.Input.vs.getValue();
		Value.Autopilot.lat = itaf.Output.lat.getValue();
		Value.Autopilot.pitchArm = itaf.Fma.pitchArm.getValue();
		Value.Autopilot.pitchMode = itaf.Fma.pitch.getValue();
		Value.Autopilot.rollArm = itaf.Fma.rollArm.getValue();
		Value.Autopilot.rollMode = itaf.Fma.roll.getValue();
		Value.Autopilot.Route.departureAlt = pts.Autopilot.Route.Departure.fieldElevationFt.getValue();
		Value.Autopilot.Route.destinationAlt = pts.Autopilot.Route.Destination.fieldElevationFt.getValue();
		Value.Autopilot.Route.distanceRemainingNm = pts.Autopilot.Route.distanceRemainingNm.getValue();
		Value.Autopilot.Route.totalDistance = pts.Autopilot.Route.totalDistance.getValue();
		Value.Autopilot.thrMode = itaf.Fma.thr.getValue();
		Value.Autopilot.vert = itaf.Output.vert.getValue();
		Value.Heading.indicatedHeadingDeg = pts.Orientation.headingDeg.getValue();
		Value.Navigation.MarkerBeacon.inner = pts.Instrumentation.MarkerBeacon.inner.getBoolValue();
		Value.Navigation.MarkerBeacon.middle = pts.Instrumentation.MarkerBeacon.middle.getBoolValue();
		Value.Navigation.MarkerBeacon.outer = pts.Instrumentation.MarkerBeacon.outer.getBoolValue();
		Value.Time.elapsedSec = pts.Sim.Time.timeElapsed.getValue();
		Value.Vsi.indicatedSpeedFpm = itaf.Internal.vs.getValue();
		Value.Vsi.serviceable = pts.Instrumentation.Vsi.serviceable.getBoolValue();

		# Pilot-specific values
		# These generally come from sensors which only one pilot uses at a time, unless in an emergency
		# TODO: #44 Implement source switching and crosscheck with other sensors for failures
        
		Value.Airspeed.iasKts = pts.Instrumentation.AirspeedIndicator.indicatedSpeedKt[n].getValue();
		Value.Airspeed.iasMach = pts.Instrumentation.AirspeedIndicator.indicatedMach[n].getValue();
		Value.Altitude.indicatedAltitudeFt = pts.Instrumentation.Altimeter.indicatedAltitudeFt[n].getValue();
		# Value.Altitude.radioAlt = pts.Instrumentation.Altimeter.radioAlt[n].getValue();
		Value.Altitude.radioAltServiceable = pts.Instrumentation.Altimeter.radioAltServiceable[n].getBoolValue();
		Value.Efis.baroInHpa = pts.Instrumentation.Efis.Inputs.baroInHpa[n].getValue();
		Value.Efis.baroSelected = pts.Instrumentation.Efis.Inputs.baroSelected[n].getBoolValue();
		Value.Efis.baroStd = pts.Instrumentation.Efis.Inputs.baroStd[n].getValue();
		Value.Efis.fpv = pts.Instrumentation.Efis.Inputs.fpv[n].getBoolValue();
		Value.Efis.minsAltitude = pts.Instrumentation.Efis.Inputs.minsAltitude[n].getValue();
		Value.Efis.minsBaroRadio = pts.Instrumentation.Efis.Inputs.minsBaroRadio[n].getValue();
		Value.Efis.mtrs = pts.Instrumentation.Efis.Inputs.mtrs[n].getBoolValue();
		Value.Navigation.Adf.selectedKhz = pts.Instrumentation.Adf.Frequencies.selectedKhz[n].getValue();
		Value.Navigation.Dme.indicatedDistanceNm = pts.Instrumentation.Dme.indicatedDistanceNm[n].getValue();
		Value.Navigation.Dme.inRange = pts.Instrumentation.Dme.inRange[n].getBoolValue();
		Value.Navigation.gsInRange = pts.Instrumentation.Nav.gsInRange[n].getBoolValue();
		Value.Navigation.gsNeedleDeflectionNorm = pts.Instrumentation.Nav.gsNeedleDeflectionNorm[n].getValue();
		Value.Navigation.hasGs = pts.Instrumentation.Nav.hasGs[n].getValue();
		Value.Navigation.inRange = pts.Instrumentation.Nav.inRange[n].getBoolValue();
		Value.Navigation.navId = pts.Instrumentation.Nav.navId[n].getValue();
		Value.Navigation.navLoc = pts.Instrumentation.Nav.navLoc[n].getBoolValue();
		Value.Navigation.radialSelectedDeg = pts.Instrumentation.Nav.Radials.selectedDeg[n].getValue();
		Value.Navigation.selectedMhz = pts.Instrumentation.Nav.Frequencies.selectedMhz[n].getValue();
		Value.Navigation.signalQualityNorm = pts.Instrumentation.Nav.signalQualityNorm[n].getValue();
		if (n == 0) {
			Value.Autopilot.fd = itaf.Output.fd1.getBoolValue();
		} elsif (n == 1) {
			Value.Autopilot.fd = itaf.Output.fd2.getBoolValue();
		}

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
			me["spd-ap-readout"].show().setText(Value.Autopilot.Input.ktsMach ? sprintf("%.3f", Value.Autopilot.Input.mach) : sprintf("%i", Value.Autopilot.Input.kts));
			me["spd-ap"].show();
			me["fail-sel-spd"].hide();
		} else {
			me["spd-ap-box"].hide();
			me["spd-ap-readout"].hide();
			me["spd-ap"].hide();
			me["fail-sel-spd"].show();
		}

		if (Value.Airspeed.iasMach < 0.4) {
			me["spd-mach"].hide();
		} else {
			me["spd-mach"].show().setText(sprintf("%.3f", Value.Airspeed.iasMach));
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
			me["spd-box-1"].setTranslation(0, 68 * 5);
			me["spd-box-10"].setTranslation(0, 91 * 4);
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
		# ANP isn't supported yet
		me["anp-lat"].hide();
		me["anp-vert"].hide();
		if (Value.Navigation.selectedMhz != 0) {
			if (Value.Navigation.signalQualityNorm >= 0.95 and Value.Navigation.navLoc) {
				me["group-navigation"].show();
				if (Value.Altitude.radioAlt <= 2500) {	
					me["rising-rwy"].show();
					if (Value.Altitude.radioAlt < 200) {
						me["rising-rwy"].setTranslation(0, Value.Altitude.radioAlt * 1.75);
					}
				} else {
					me["rising-rwy"].hide();
				}

				# Marker Beacon
				if (Value.Navigation.MarkerBeacon.inner) {
					me["marker-color"].show().setColorFill(1, 1, 1, 1);
					me["inner-marker"].show();
					me["middle-marker"].hide();
					me["outer-marker"].hide();
				} elsif (Value.Navigation.MarkerBeacon.middle) {
					me["marker-color"].show().setColorFill(1, 0.75, 0, 1);
					me["inner-marker"].hide();
					me["middle-marker"].show();
					me["outer-marker"].hide();
				} elsif (Value.Navigation.MarkerBeacon.outer) {
					me["marker-color"].show().setColorFill(0, 1, 1, 1);
					me["inner-marker"].hide();
					me["middle-marker"].hide();
					me["outer-marker"].show();
				} else {
					me["marker-color"].hide();
					me["inner-marker"].hide();
					me["middle-marker"].hide();
					me["outer-marker"].hide();
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
				me["course-dev-lat"].setColor(1, 1, 1, 1).setColorFill(0, 0, 0, 0).setTranslation(200, 0);
			} elsif (Value.Navigation.headingNeedleDeflectionNorm <= -10) {
				me["course-dev-lat"].setColor(1, 1, 1, 1).setColorFill(0, 0, 0, 0).setTranslation(-200, 0);
			} else {
				me["course-dev-lat"].setColor(0, 0, 0, 0).setColorFill(1, 0, 1, 1).setTranslation(Value.Navigation.headingNeedleDeflectionNorm * 20, 0);
			}
			if (Value.Navigation.hasGs) {
				me["course-dev-vert"].show();
				if (Value.Navigation.gsNeedleDeflectionNorm >= 10) {
					me["course-dev-vert"].setColor(1, 1, 1, 1).setColorFill(0, 0, 0, 0).setTranslation(0, 200);
				} elsif (Value.Navigation.gsNeedleDeflectionNorm <= 10) {
					me["course-dev-vert"].setColor(1, 1, 1, 1).setColorFill(0, 0, 0, 0).setTranslation(0, -200);
				} else {
					me["course-dev-vert"].setColor(0, 0, 0, 0).setColorFill(1, 0, 1, 1).setTranslation(0, Value.Navigation.gsNeedleDeflectionNorm * 20);
				}
			}
		}

		# Vertical Speed
		if (Value.Vsi.serviceable) {	
			me["group-vs"].show();
			me["fail-vert"].hide();
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
			
			me["vs-needle"].setRotation(math.clamp(47.11 * math.atan2(Value.Vsi.indicatedSpeedFpm * 0.001518, 1), -68.84847, 68.84847) * D2R);
			if (Value.Autopilot.vert == 1) {
				me["vs-selected"].show();
				me["vs-selected"].setTranslation(0, -234.7 * math.atan(Value.Autopilot.Input.vs * 0.0007042, 1));
			} else {
				me["vs-selected"].hide();
			}
		} else {
			me["group-vs"].hide();
			me["fail-vert"].show();
		}

		# Altitude
		me["alt-mins-readout"].setText(sprintf("%i", Value.Efis.minsAltitude));
		me["alt-mins-mode"].setText(Value.Efis.minsBaroRadio ? "RADIO" : "BARO");
		if (Value.Efis.baroStd == 0) {
			me["alt-press-std"].hide();
			me["alt-press-std-set"].hide();
			me["alt-press-units"].hide();
			me["alt-press"].show().setText("STD");
		} elsif (Value.Efis.baroStd == 1) {
			me["alt-press-std"].hide();
			me["alt-press-std-set"].hide();
			me["alt-press-units"].show().setText(Value.Efis.baroInHpa ? "IN" : "HPA");
			me["alt-press"].show().setText(Value.Efis.baroInHpa ? sprintf("%.2f", Value.Efis.baroSelected) : sprintf("%i", Value.Efis.baroSelected));
		} else {
			me["alt-press-std"].show();
			me["alt-press-std-set"].show().setText(Value.Efis.baroInHpa ? sprintf("%.2f IN", Value.Efis.baroSelected) : sprintf("%i HPA", Value.Efis.baroSelected));
			me["alt-press-units"].hide();
			me["alt-press"].hide();
		}

		if (Value.Altitude.radioAltServiceable) {
			me["fail-ra"].hide();
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

		if (Value.Efis.mtrs) {
			if (Value.Autopilot.vert != 3 or Value.Autopilot.vert != 9) {
				me["alt-ap-m-unit"].show();
				me["alt-ap-m-readout"].show();
				me["alt-ap-m-back"].show();
				me["alt-ap-m-readout"].setText(sprintf("%i", Value.Autopilot.Input.alt * FT2M));
			} else {
				me["alt-ap-m-unit"].hide();
				me["alt-ap-m-readout"].hide();
				me["alt-ap-m-back"].hide();
			}
			me["alt-m-readout"].show();
			me["alt-m-unit"].show();
			me["alt-m-back"].show();
			me["alt-m-readout"].setText(sprintf("%i", Value.Altitude.indicatedAltitudeFt * FT2M));
		} else {
			me["alt-ap-m-unit"].hide();
			me["alt-ap-m-readout"].hide();
			me["alt-ap-m-back"].hide();
			me["alt-m-readout"].hide();
			me["alt-m-unit"].hide();
			me["alt-m-back"].hide();
		}

		if (Value.Autopilot.vert != 3 or Value.Autopilot.vert != 9) {
			if (Value.Autopilot.Input.alt >= 1000) {
				me["alt-ap-1000"].show();
				me["alt-ap-1000"].setText(sprintf("%i", math.floor(Value.Autopilot.Input.alt / 1000)));
			} else {
				me["alt-ap-1000"].hide();
			}
			me["alt-ap-100"].show();
			me["alt-ap-back"].show();
			me["alt-ap"].show();
			me["alt-ap-100"].setText(sprintf("%03i", math.floor(math.mod(Value.Autopilot.Input.alt, 100))));
			if (Value.Altitude.indicatedAltitudeFt - Value.Autopilot.Input.alt >= 412.5) {
				me["alt-ap"].setTranslation(0, 495);
			} elsif (Value.Altitude.indicatedAltitudeFt - Value.Autopilot.Input.alt <= -412.5) {
				me["alt-ap"].setTranslation(0, -495);
			} else {
				me["alt-ap"].setTranslation(0, (Value.Altitude.indicatedAltitudeFt - Value.Autopilot.Input.alt) * 1.2);
			}
		} else {
			me["alt-ap-1000"].hide();
			me["alt-ap-100"].hide();
			me["alt-ap-back"].hide();
			me["alt-ap"].hide();
		}

		me["alt-mins"].setTranslation(0, (Value.Altitude.indicatedAltitudeFt - Value.Efis.minsAltitude) * 1.2);
		if (Value.Altitude.indicatedAltitudeFt < Value.Efis.minsAltitude) {
			me["alt-mins"].setColorFill(1, 0.75, 0, 1);
		} else {
			me["alt-mins"].setColorFill(0, 1, 0, 1);
		}

		if (Value.Autopilot.Route.totalDistance - Value.Autopilot.Route.distanceRemainingNm > 400 or Value.Autopilot.Route.distanceRemainingNm * 2 > Value.Autopilot.Route.totalDistance) {
			me["alt-ground"].setTranslation(0, (Value.Altitude.indicatedAltitudeFt - Value.Autopilot.Route.destinationAlt) * 1.2);
			me["alt-ground-close"].setTranslation(0, (Value.Altitude.indicatedAltitudeFt - Value.Autopilot.Route.destinationAlt) * 1.2);
		} else {
			me["alt-ground"].setTranslation(0, (Value.Altitude.indicatedAltitudeFt - Value.Autopilot.Route.departureAlt) * 1.2);
			me["alt-ground-close"].setTranslation(0, (Value.Altitude.indicatedAltitudeFt - Value.Autopilot.Route.departureAlt) * 1.2);
		}

		me["alt-tape0"].setTranslation(0, Value.Altitude.indicatedAltitudeFt * 1.2);
		for (var i = 0; i < 7; i += 1) {
			me["alt-tape" ~ (i + 1) ~ ""].setTranslation(0, Value.Altitude.indicatedAltitudeFt * 1.2 - (6000 * i))
		}
		
		me["alt-20"].setTranslation(0, math.mod(Value.Altitude.indicatedAltitudeFt, 100) * 2.45);
		me["alt-100"].setTranslation(0, math.mod(math.floor(Value.Altitude.indicatedAltitudeFt/100), 10) * 81);
		if (math.mod(Value.Altitude.indicatedAltitudeFt, 100) > 80) {
			me["alt-100"].setTranslation(0, (math.mod(math.floor(Value.Altitude.indicatedAltitudeFt/100), 10) + (math.mod(Value.Altitude.indicatedAltitudeFt, 100) - 80) * 0.05) * 81);
		}

		me["alt-1000"].setTranslation(0, math.mod(math.floor(Value.Altitude.indicatedAltitudeFt/1000), 10) * 86);
		if (math.mod(Value.Altitude.indicatedAltitudeFt, 1000) > 980) {
			me["alt-1000"].setTranslation(0, (math.mod(math.floor(Value.Altitude.indicatedAltitudeFt/1000), 10) + (math.mod(Value.Altitude.indicatedAltitudeFt, 1000) - 980) * 0.05) * 86);
		}
		
		if (Value.Altitude.indicatedAltitudeFt < 0) {
			me["alt-neg"].show();
			me["alt-0"].hide();
			me["alt-10000"].hide();
		} elsif (Value.Altitude.indicatedAltitudeFt < 10000) {
			me["alt-neg"].hide();
			me["alt-0"].show();
			me["alt-10000"].hide();
		} else {
			me["alt-neg"].hide();
			me["alt-0"].hide();
			me["alt-10000"].show();
			me["alt-10000"].setTranslation(0, math.mod(math.floor(Value.Altitude.indicatedAltitudeFt/10000), 10) * 86);
			if (math.mod(Value.Altitude.indicatedAltitudeFt, 10000) > 9980) {
				me["alt-10000"].setTranslation(0, (math.mod(math.floor(Value.Altitude.indicatedAltitudeFt/10000), 10) + (math.mod(Value.Altitude.indicatedAltitudeFt, 10000) - 9980) * 0.05) * 86);
			}
		}
		
		# Attitude
		me.attitudeTransPitch.setTranslation(0, Value.Attitude.indicatedPitchDeg * 14);
		me.attitudeTransRoll.setRotation(-Value.Attitude.indicatedRollDeg * D2R, [1024, 655]);
		if (Value.Attitude.indicatedRollDeg > 60) {
			me["bank-angle"].setRotation(-60 * D2R);
		} elsif (Value.Attitude.indicatedRollDeg < -60) {
			me["bank-angle"].setRotation(60 * D2R);
		} else {
			me["bank-angle"].setRotation(-Value.Attitude.indicatedRollDeg * D2R);
		}

		if (Value.Attitude.indicatedRollDeg + Value.Attitude.indicatedSlipSkid > 60) {
			me["slip-skid"].setRotation(-60 * D2R);
		} elsif (Value.Attitude.indicatedRollDeg < -60) {
			me["slip-skid"].setRotation(60 * D2R);
		} else {
			me["slip-skid"].setRotation(-Value.Attitude.indicatedRollDeg * D2R);
		}

		if (math.abs(Value.Attitude.indicatedRollDeg) > 35) {
			me["bank-angle"].setColor(1, 0.75, 0, 1).setColorFill(1, 0.75, 0, 1);
		} else {
			me["bank-angle"].setColor(1, 1, 1, 1).setColorFill(0, 0, 0, 0);
		}

		if (Value.Efis.fpv) {
			me["flight-path-vector"].show().setRotation(-Value.Attitude.indicatedRollDeg * D2R);
			me.fpvTrans.setTranslation(math.clamp(Value.Heading.indicatedTrackDeg, -20, 20) * 14, math.clamp(Value.Attitude.alpha, -20, 20) * 14);
			me.fpvRot.setRotation(-Value.Attitude.indicatedRollDeg * D2R, [1024, 655]);
		} else {
			me["flight-path-vector"].hide();
		}

		if (Value.Autopilot.fd) {
			me["fd-pitch"].show().setTranslation(0, -Value.Autopilot.fdPitch * 14);
			me["fd-roll"].show().setTranslation(-Value.Autopilot.fdRoll * 14, 0);
		} else {
			me["fd-pitch"].hide();
			me["fd-roll"].hide();
		}

		# Compass Panel
		me["compass-label"].setRotation(-Value.Heading.indicatedHeadingDeg * D2R);
		me["heading-track"].setRotation((Value.Heading.indicatedTrackDeg - Value.Heading.indicatedHeadingDeg) * D2R);
		me["heading-ap"].setRotation((Value.Autopilot.Input.hdg - Value.Heading.indicatedHeadingDeg) * D2R);
		me["heading-ap-readout"].setText(sprintf("%i", Value.Autopilot.Input.hdg));
		me["heading-mode"].setText(Value.Heading.magTru ? "TRU" : "MAG");
		if (Value.Heading.magTru != Value.Heading.magTruPrev and Value.Heading.magTruPrev == 1) {
			Value.Heading.magTruPrev = Value.Heading.magTru;
			Value.Heading.magTruChg = Value.Sim.elapsedSec;
		}
		if (Value.Heading.magTru) {
			me["heading-mode-box"].setColorFill(1, 1, 1, 1);
			
		} else {
			me["heading-mode-box"].setColorFill(0, 1, 0, 1);
			if (Value.Time.elapsedSec - Value.Heading.magTruChg < 10) {
				me["heading-mode-box"].show();
			} else {
				me["heading-mode-box"].hide();
			}
		}
	},
};

var canvasPfd1 = {
	new: func(canvasGroup, file) {
		var m = {parents: [canvasPfd1, canvasBase]};
		m.init(canvasGroup, file);
		
		return m;
	},
	setup: func() {
		# Hide unimplemented objects
		me["anp-lat"].hide();
		me["anp-vert"].hide();

        # Hide failure flags by default
		me["fail-spd-lim"].hide();
		me["fail-fd"].hide();
		me["fail-dme"].hide();
		me["fail-fpv"].hide();
		me["fail-fac"].hide();
		me["fail-loc"].hide();
		me["fail-hdg"].hide();
		me["fail-ra"].hide();
		me["fail-att"].hide();
		me["fail-gp"].hide();
		me["fail-gs"].hide();
		me["fail-alt"].hide();
		me["fail-ldg-alt"].hide();
		me["fail-roll"].hide();
		me["fail-pitch"].hide();
		me["fail-spd"].hide();
		me["warning-msg"].hide();
		me["warning-back"].hide();
	},
	update: func() {
		me.updateBase(0);
	},
};

var canvasPfd2 = {
	new: func(canvasGroup, file) {
		var m = {parents: [canvasPfd2, canvasBase]};
		m.init(canvasGroup, file);
		
		return m;
	},
	setup: func() {
		# Hide unimplemented objects
		me["anp-lat"].hide();
		me["anp-vert"].hide();

        # Hide failure flags by default
		me["fail-spd-lim"].hide();
		me["fail-fd"].hide();
		me["fail-dme"].hide();
		me["fail-fpv"].hide();
		me["fail-fac"].hide();
		me["fail-loc"].hide();
		me["fail-hdg"].hide();
		me["fail-ra"].hide();
		me["fail-att"].hide();
		me["fail-gp"].hide();
		me["fail-gs"].hide();
		me["fail-alt"].hide();
		me["fail-ldg-alt"].hide();
		me["fail-roll"].hide();
		me["fail-pitch"].hide();
		me["fail-spd"].hide();
		me["warning-msg"].hide();
		me["warning-back"].hide();
	},
	update: func() {		
		me.updateBase(1);
	},
};

var init = func() {
	pfd1Display = canvas.new({
		"name": "PFD1",
		"size": [2048, 2048],
		"view": [2048, 2048],
		"mipmapping": 1
	});
	pfd2Display = canvas.new({
		"name": "PFD2",
		"size": [2048, 2048],
		"view": [2048, 2048],
		"mipmapping": 1
	});
	
	pfd1Display.addPlacement({"node": "pfd1.screen"});
	pfd2Display.addPlacement({"node": "pfd2.screen"});
	
	var pfd1Group = pfd1Display.createGroup();
	var pfd2Group = pfd2Display.createGroup();
	
	pfd1 = canvasPfd1.new(pfd1Group, "Aircraft/737-family/Nasal/Displays/res/PFD.svg");
	pfd2 = canvasPfd2.new(pfd2Group, "Aircraft/737-family/Nasal/Displays/res/PFD.svg");
	
	canvasBase.setup();
	update.start();
	
	if (pts.Systems.Acconfig.Options.Du.captPfdFps.getValue() != 20) {
		rateApply(0);
	}
	if (pts.Systems.Acconfig.Options.Du.foPfdFps.getValue() != 20) {
		rateApply(1);
	}
}

var rateApply = func(n) {
	if (n == 0) {
		update.restart(1 / pts.Systems.Acconfig.Options.Du.captPfdFps.getValue());
	}
	if (n == 1) {
		update.restart(1 / pts.Systems.Acconfig.Options.Du.foPfdFps.getValue());
	}
}

var update = maketimer(0.05, func() { # 20FPS
	canvasBase.update();
});

var showPfd1 = func() {
	var dlg = canvas.Window.new([512, 512], "dialog", nil, 0).set("resize", 1);
	dlg.setCanvas(pfd1Display);
	dlg.set("title", "Captain's PFD");
}

var showPfd2 = func() {
	var dlg = canvas.Window.new([512, 512], "dialog", nil, 0).set("resize", 1);
	dlg.setCanvas(pfd2Display);
	dlg.set("title", "First Officer's PFD");
}