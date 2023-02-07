# ==============================================================================
# 737 MAX Navigation Display
# Israel Emmanuel
# ==============================================================================

var AP_canvas = nil;
var AP_display = nil;

var canvas_AP = {
	new: func(canvas_group) {
		var m = {parents: [canvas_AP]};
		var AP = canvas_group;
		var font_mapper = func(family, weight) {
			return "Std7SegCustom.TTF";
		};
		
		canvas.parsesvg(AP, "Aircraft/737-MAX/Models/Cockpit/Screens/autopilot.nas" , {'font-mapper': font_mapper});
		
		var svg_keys = ["course1", "heading", "course2", "v-speed", "ias-mach", "altitude"];
		foreach(var key; svg_keys)
			m[key] = AP.getElementById(key);

        m.timers=[];
		return m;
	},

    newMFD: func(){
 		me.update_timer = maketimer(0.05, func me.update() );
 		me.update_timer.start();
    },

	update: func(){
        me["course1"].setText(sprintf("%03i", getprop("it-autoflight/input/true-course")));
        me["course2"].setText(sprintf("%03i", getprop("it-autoflight/input/true-course")));
        me["heading"].setText(sprintf("%03i", getprop("it-autoflight/input/hdg")));
        me["v-speed"].setText(getprop("it-autoflight/input/vs"));
	}
};

setlistener("sim/signals/fdm-initialized", func() {
	AP_display = canvas.new({
		"name": "AP",
		"size": [1024, 1024],
		"view": [1024, 1024],
		"mipmapping": 1
	});
	AP_display.addPlacement({"node": "screen2.full"});
	var group = AP_display.createGroup();
	AP_canvas = canvas_AP.new(group);
    AP_canvas.newMFD();
 	AP_canvas.update();
}, 0, 0);

#setlistener("sim/signals/reinit", func AP_display.del());

var showAP = func() {
	var dlg = canvas.Window.new([880, 660], "dialog").set("resize", 1);
	dlg.setCanvas(AP_display);
}