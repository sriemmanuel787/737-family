print("Loading Primary Flight Display");
var pfd_canvas = nil;
var pfd_display = nil;

var Value = {
	Autopilot: {
		pitchArm: "",
		rollArm: "",
		pitchMode: "",
		rollMode: "",
		speedMode: ""
	}
}

var canvas_pfd = {
	new: func(canvas_group) {
		var m = {parents: [canvas_pfd]};
		var pfd = canvas_group;
		var font_mapper = func(family, weight) {
			return "MFD-font.ttf";
		};
		
		canvas.parsesvg(pfd, "Aircraft/737-MAX/Nasal/Displays/res/PFD.svg" , {'font-mapper': font_mapper});
		
		var svg_keys = ["fail-no-vspd", "fail-spd-lim", "fail-sel-spd", "fail-fd", "fail-dme", "fail-fpv", "fail-fac", "fail-loc", "fail-hdg", "fail-ra", "fail-att", "fail-vert", "fail-gp", "fail-gs", "fail-alt", "fail-ldg-alt", "fail-roll", "fail-pitch", "fail-spd", "warning-msg", "warning-back", "ap-pitch-arm", "ap-roll-arm", "ap-pitch-mode", "ap-roll-mode", "ap-speed-mode", "ap-pitch-box", "ap-roll-box", "ap-speed-box", "spd-tick-r", "spd-r", "spd-tick-v1", "spd-v1", "spd-tick-up", "spd-up", "spd-tick-ref", "spd-ref", "spd-tick-1", "spd-1", "spd-tick-5", "spd-5", "spd-tick-15", "spd-15", "spd-vref-20", "spd-80-kts", "spd-v2-15", "spd-spare-bug", "srs-speed", "srs-selected", "spd-mach", "spd-ap-readout", "spd-ap-box", "spd-ap", "spd-limitLY", "spd-limitLR", "spd-limitLB", "spd-limitUY", "spd-limit-UR", "spd-limitUB", "spd-box-1", "spd-box-10", "spd-box-100", "spd-box", "spd-tape", "spd-border", "spd-back", "rising-rwy", "inner-marker", "middle-marker", "outer-marker", "marker-color", "ils-ident", "ils-dist", "nav-src", "course-dev-vert", "anp-vert", "course-dev-lat", "anp-lat", "lines-lat-app", "lines-vert-ils", "lines-lat-ils", "lines-vert-std", "lines-lat-std", "vs-labels", "vs-selected", "vs-pos-readout", "vs-neg-readout", "vs-needle", "vs-border", "vs-back", "alt-mins-readout", "alt-mins-mode", "alt-press-std", "alt-press-std-set", "alt-press-units", "alt-press", "alt-final", "alt-final-box", "alt-ap-1000", "alt-ap-100", "alt-ap-m-unit", "alt-ap-m-readout", "alt-ap-back", "alt-m-readout", "alt-m-unit", "alt-m-back", "alt-10000", "alt-1000", "alt-100", "alt-20", "alt-0", "alt-neg", "alt-tape-back", "alt-mins", "alt-ap", "alt-tape0", "alt-tape1", "alt-tape2", "alt-tape3", "alt-tape4", "alt-tape5", "alt-tape6", "alt-tape7", "alt-ground-close", "alt-ground", "alt-border", "alt-back", "airplane-symbol-b", "airplane-symbol-w", "slip-skid", "bank-angle", "aoa-shaker", "aoa-needle", "aoa-readout", "aoa-approach-upper", "aoa-approach-lower", "aoa-approach", "pitch-limit-indicator", "flight-trend", "fd-pitch", "fd-roll", "ladder", "labels-back", "sky", "ground", "heading-mode", "heading-ap-readout", "wind-stats", "true-airspeed", "ground-speed", "vor1", "vor2", "dme1", "dme2", "heading-ap", "heading-track", "compass-label"];
		foreach(var key; svg_keys)
			m[key] = pfd.getElementById(key);

        m.timers=[];

		# These run once - do not put inside update()
		m["spd-back"].setColorFill(0, 0, 0, 0.2);
		m["alt-back"].setColorFill(0, 0, 0, 0.2);
		m["labels-back"].setColorFill(0, 0, 0, 0.2);
		m["vs-back"].setColorFill(0, 0, 0, 0.2);

		return m;
	},

	update: func() {
		Value.Autopilot.pitchArm = pts.Autoflight.pitchModeArm.getValue();
		Value.Autopilot.rollArm = pts.Autoflight.rollModeArm.getValue();
		Value.Autopilot.pitchMode = pts.Autoflight.pitchMode.getValue();
		Value.Autopilot.rollMode = pts.Autoflight.rollMode.getValue();
		Value.Autopilot.speedMode = pts.Autoflight.spdMode.getValue();

		# Hide failure flags by default
		me["fail-no-vspd"].hide();
		me["fail-spd-lim"].hide();
		me["fail-sel-spd"].hide();
		me["fail-fd"].hide();
		me["fail-dme"].hide();
		me["fail-fpv"].hide();
		me["fail-fac"].hide();
		me["fail-loc"].hide();
		me["fail-hdg"].hide();
		me["fail-ra"].hide();
		me["fail-att"].hide();
		me["fail-vert"].hide();
		me["fail-gp"].hide();
		me["fail-gs"].hide();
		me["fail-alt"].hide();
		me["fail-ldg-alt"].hide();
		me["fail-roll"].hide();
		me["fail-pitch"].hide();
		me["fail-spd"].hide();
		me["warning-msg"].hide();
		me["warning-back"].hide();

		# Autopilot modes
		me["ap-pitch-arm"].setText(Value.Autopilot.pitchArm);
		me["ap-roll-arm"].setText(Value.Autopilot.rollArm);
		me["ap-pitch-mode"].setText(Value.Autopilot.pitchMode);
		me["ap-roll-mode"].setText(Value.Autopilot.rollMode);
		me["ap-speed-mode"].setText(Value.Autopilot.speedMode);
	},
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
	update_timer = maketimer(0.1, func pfd_canvas.update());
 	update_timer.start();
 	pfd_canvas.update();
}, 0, 0);

var showPfd = func() {
	var dlg = canvas.Window.new([512, 512], "dialog").set("resize", 1);
	dlg.setCanvas(pfd_display);
}