# Boeing 737 MAX PFD

print("Loading Primary Flight Display...");
var pfd1 = nil;
var pfd1Display = nil;
var pfd1Error = nil;
var pfd2 = nil;
var pfd2Display = nil;
var pfd2Error = nil;

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
		m["spd-back"].setColorFill(0, 0, 0, 0.2);
		m["alt-back"].setColorFill(0, 0, 0, 0.2);
		m["labels-back"].setColorFill(0, 0, 0, 0.2);
		m["vs-back"].setColorFill(0, 0, 0, 0.2);
		m["spd-tick-r"].set("clip", spdTapeClip);
		m["spd-r"].set("clip", spdTapeClip);
		m["spd-tick-v1"].set("clip", spdTapeClip);
		m["spd-v1"].set("clip", spdTapeClip);
		m["spd-tick-up"].set("clip", spdTapeClip);
		m["spd-up"].set("clip", spdTapeClip);
		m["spd-tick-ref"].set("clip", spdTapeClip);
		m["spd-ref"].set("clip", spdTapeClip);
		m["spd-tick-1"].set("clip", spdTapeClip);
		m["spd-1"].set("clip", spdTapeClip);
		m["spd-tick-5"].set("clip", spdTapeClip);
		m["spd-5"].set("clip", spdTapeClip);
		m["spd-tick-15"].set("clip", spdTapeClip);
		m["spd-15"].set("clip", spdTapeClip);
		m["spd-vref-20"].set("clip", spdTapeClip);
		m["spd-80-kts"].set("clip", spdTapeClip);
		m["spd-v2-15"].set("clip", spdTapeClip);
		m["spd-spare-bug"].set("clip", spdTapeClip);
		m["spd-ap"].set("clip", spdTapeClip);
		m["spd-trend-up"].set("clip", "rect(160, 612, 655, 592)");
		m["spd-trend-down"].set("clip", "rect(655, 612, 1150, 592)");
		m["spd-limitLY"].set("clip", spdTapeClip);
		m["spd-limitLR"].set("clip", spdTapeClip);
		m["spd-limitLB"].set("clip", spdTapeClip);
		m["spd-limitUY"].set("clip", spdTapeClip);
		m["spd-limitUR"].set("clip", spdTapeClip);
		m["spd-limitUB"].set("clip", spdTapeClip);
		m["spd-box-1"].set("clip", spdBoxClip);
		m["spd-box-10"].set("clip", spdBoxClip);
		m["spd-box-100"].set("clip", spdBoxClip);
		m["spd-tape"].set("clip", spdTapeClip);
		m["vs-needle"].set("clip", "rect(314, 1791, 996, 1724)");
		m["vs-needle"].setCenter(1854, 655);
		m["alt-mins"].set("clip", altTapeClip);
		m["alt-ap"].set("clip", altTapeClip);
		m["alt-tape0"].set("clip", altTapeClip);
		m["alt-tape1"].set("clip", altTapeClip);
		m["alt-tape2"].set("clip", altTapeClip);
		m["alt-tape3"].set("clip", altTapeClip);
		m["alt-tape4"].set("clip", altTapeClip);
		m["alt-tape5"].set("clip", altTapeClip);
		m["alt-tape6"].set("clip", altTapeClip);
		m["alt-tape7"].set("clip", altTapeClip);
		m["alt-ground-close"].set("clip", altTapeClip);
		m["alt-ground"].set("clip", altTapeClip);
		m["alt-10000"].set("clip", altBoxClip);
		m["alt-1000"].set("clip", altBoxClip);
		m["alt-100"].set("clip", altBoxClip);
		m["alt-20"].set("clip", altBoxClip);
		m["slip-skid"].setCenter(1024, 655);
		m["bank-angle"].setCenter(1024, 655);
		var compassCenter = m["compass-label"].getCenter();
		m["heading-track"].setCenter(compassCenter);
		m["heading-ap"].setCenter(compassCenter);

		me.attitudeTransPitch = m["group-artificial-horizon"].createTransform();
		me.attitudeTransRoll = m["group-artificial-horizon"].createTransform();
		me.fpvTrans = m["flight-path-vector"].createTransform();
		me.fpvRot = m["flight-path-vector"].createTransform();
		
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
		pfd1Error.page.hide();
		pfd2.page.hide();
		pfd2.setup();
		pfd2Error.page.hide();
	},
	update: func() {
		if (systems.DUController.updatePfd1) {
			pfd1.update();
		}
		if (systems.DUController.updatePfd2) {
			pfd2.update();
		}
	},
	updateBase: func(n) {
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
		me["ALT_fms"].hide();
		me["ALT_fms_dn"].hide();
		me["ALT_fms_up"].hide();
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
		me["ALT_fms"].hide();
		me["ALT_fms_dn"].hide();
		me["ALT_fms_up"].hide();
	},
	update: func() {		
		me.updateBase(1);
	},
};

var canvasPfd1Error = {
	init: func(canvasGroup, file) {
		var font_mapper = func(family, weight) {
			return "LiberationFonts/LiberationSans-Regular.ttf";
		};
		
		canvas.parsesvg(canvasGroup, file, {"font-mapper": font_mapper});
		me.page = canvasGroup;
		
		return me;
	},
	new: func(canvasGroup, file) {
		var m = {parents: [canvasPfd1Error]};
		m.init(canvasGroup, file);
		
		return m;
	},
};

var canvasPfd2Error = {
	init: func(canvasGroup, file) {
		var font_mapper = func(family, weight) {
			return "LiberationFonts/LiberationSans-Regular.ttf";
		};
		
		canvas.parsesvg(canvasGroup, file, {"font-mapper": font_mapper});
		me.page = canvasGroup;
		
		return me;
	},
	new: func(canvasGroup, file) {
		var m = {parents: [canvasPfd2Error]};
		m.init(canvasGroup, file);
		
		return m;
	},
};

var init = func() {
	pfd1Display = canvas.new({
		"name": "PFD1",
		"size": [1024, 1024],
		"view": [1024, 1024],
		"mipmapping": 1
	});
	pfd2Display = canvas.new({
		"name": "PFD2",
		"size": [1024, 1024],
		"view": [1024, 1024],
		"mipmapping": 1
	});
	
	pfd1Display.addPlacement({"node": "pfd1.screen"});
	pfd2Display.addPlacement({"node": "pfd2.screen"});
	
	var pfd1Group = pfd1Display.createGroup();
	var pfd1ErrorGroup = pfd1Display.createGroup();
	var pfd2Group = pfd2Display.createGroup();
	var pfd2ErrorGroup = pfd2Display.createGroup();
	
	pfd1 = canvasPfd1.new(pfd1Group, "Aircraft/737-MAX/Nasal/Displays/res/PFD.svg");
	pfd1Error = canvasPfd1Error.new(pfd1ErrorGroup, "Aircraft/737-MAX/Nasal/Displays/res/Error.svg");
	pfd2 = canvasPfd2.new(pfd2Group, "Aircraft/737-MAX/Nasal/Displays/res/PFD.svg");
	pfd2Error = canvasPfd2Error.new(pfd2ErrorGroup, "Aircraft/737-MAX/Nasal/Displays/res/Error.svg");
	
	canvasBase.setup();
	update.start();
	
	if (pts.Systems.Acconfig.Options.Du.pfdFps.getValue() != 20) {
		rateApply();
	}
}

var rateApply = func() {
	update.restart(1 / pts.Systems.Acconfig.Options.Du.pfdFps.getValue());
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