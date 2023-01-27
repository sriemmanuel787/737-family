# ==============================================================================
# 737 MAX Navigation Display
# Israel Emmanuel
# ==============================================================================

var NDWide_canvas = nil;
var NDWide_display = nil;

var canvas_NDWide = {
	new: func(canvas_group) {
		var m = {parents: [canvas_NDWide]};
		var NDWide = canvas_group;
		var font_mapper = func(family, weight) {
			return "OCRBMT.TTF";
		};
		
		canvas.parsesvg(NDWide, "Aircraft/737-MAX/Models/Instruments/res/NDWide.svg" , {'font-mapper': font_mapper});
		
		var svg_keys = [];
		foreach(var key; svg_keys)
			m[key] = NDWide.getElementById(key);

        m.timers=[];
		return m;
	},

    newMFD: func(){
 		me.update_timer = maketimer(0.05, func me.update() );
 		me.update_timer.start();
 		me.update_slow_timer.start();
 		me.update_ap_modes_timer.start();
    },

	update: func(){
        # Wind and Range
        me["ground-speed"].setText(sprintf("%i", getprop("velocities/groundspeed-kt")));
        me["true-airspeed"].setText(sprintf("%i", getprop("velocities/true-airspeed-kt")));
        me["wind-heading"].setText(sprintf("%i", getprop("environment/wind-from-heading-deg")));
        me["wind-speed"].setText(sprintf("%i", getprop("environment/wind-speed-kt")));
        me["range"].setText(sprintf("%i", getprop("instrumentation/efis/input/range-nm")));

        # Next Waypoint
        me["wpt-next"].setText(getprop("autopilot/route-manager/wp/id"));
        me["wpt-time"].setText(getprop("autopilot/route-manager/wp/eta"));
        me["wpt-distance"].setText(sprintf("%.01f", getprop("autopilot/route-manager/wp/dist")));
        for (var i=0; i < getprop("autopilot/route-manager/route/num"); i = i+1) {
            
        }
	}
};

setlistener("sim/signals/fdm-initialized", func() {
	NDWide_display = canvas.new({
		"name": "NDWide",
		"size": [968, 1452],
		"view": [484, 726],
		"mipmapping": 1
	});
	NDWide_display.addPlacement({"node": "screen2.R"});
    NDWide_display.addPlacement({"node": "screen3.L"});
	var group = NDWide_display.createGroup();
	NDWide_canvas = canvas_NDWide.new(group);
    NDWide_canvas.newMFD();
 	NDWide_canvas.update();
}, 0, 0);

#setlistener("sim/signals/reinit", func NDWide_display.del());

var showNDWide = func() {
	var dlg = canvas.Window.new([484, 726], "dialog").set("resize", 1);
	dlg.setCanvas(NDWide_display);
}