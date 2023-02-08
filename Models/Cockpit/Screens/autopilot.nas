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
		
		canvas.parsesvg(AP, "Aircraft/737-MAX/Models/Cockpit/Screens/autopilot.svg" , {'font-mapper': font_mapper});
		
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
        if(getprop("it-autoflight/input/vs") == 0 or getprop("it-autoflight/input/vert") != 1)
            me["v-speed"].hide();
        else
            me["v-speed"].setText(sprintf("%i", getprop("it-autoflight/input/vs")));

        if(getprop("it-autoflight/input/kts-mach") == 0)
            me["ias-mach"].setText(sprintf("%i", getprop("it-autoflight/input/spd-kts")));
        else
            me["ias-mach"].setText(sprintf("%i", getprop("it-autoflight/input/spd-mach")));
            
        me["altitude"].setText(sprintf("%i", getprop("it-autoflight/input/alt")));
	}
};

setlistener("sim/signals/fdm-initialized", func() {
	AP_display = canvas.new({
		"name": "AP",
		"size": [1024, 1024],
		"view": [1024, 1024],
		"mipmapping": 1
	});
	AP_display.addPlacement({"node": "ap.course1"});
    AP_display.addPlacement({"node": "ap.speed"});
    AP_display.addPlacement({"node": "ap.heading"});
    AP_display.addPlacement({"node": "ap.altitude"});
    AP_display.addPlacement({"node": "ap.vspeed"});
    AP_display.addPlacement({"node": "ap.course2"});
	var group = AP_display.createGroup();
	AP_canvas = canvas_AP.new(group);
    AP_canvas.newMFD();
 	AP_canvas.update();
}, 0, 0);

#setlistener("sim/signals/reinit", func AP_display.del());