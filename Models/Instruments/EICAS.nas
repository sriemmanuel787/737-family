# ==============================================================================
# 737 MAX Engine Indicator and Crew Alerting System
# Israel Emmanuel
# ==============================================================================

var EICAS_canvas = nil;
var EICAS_display = nil;

var canvas_EICAS = {
	new: func(canvas_group) {
		var m = {parents: [canvas_EICAS]};
		var EICAS = canvas_group;
		var font_mapper = func(family, weight) {
			return "OCRBMT.TTF";
		};
		
		canvas.parsesvg(EICAS, "Aircraft/737-MAX/Models/Instruments/res/EICAS.svg" , {'font-mapper': font_mapper});
		
		var svg_keys = ["fuelflow1", "fuelflow2", "oil-press1", "oil-press2", "oil-temp1", "oil-temp2", "oil-qty1", "oil-qty2", "vib1", "vib2", "oil-press-meter1", "oil-press-meter2", "oil-temp-meter1", "oil-temp-meter2", "vib-meter1", "vib-meter2", "throttle-num1", "throttle-num2", "throttle-n1", "throttle-n2", "n1-text1", "n1-dial1", "n1-text2", "n1-dial2", "egt-text1", "egt-dial1", "egt-text2", "egt-dial2", "motoring1", "motoring2", "n2-dial1", "n2-text1", "n2-dial2", "n2-text2", "fuel-flow1", "thrust1", "low-oil-pressure1", "oil-filter-bypass1", "start-valve-open1", "fuel-flow2", "thrust2", "low-oil-pressure2", "oil-filter-bypass2", "start-valve-open2", "tank-r", "tank-c", "tank-l", "total", "air-temp", "flt-mode", "flap-trans", "flap-ext", "flap-dial"];
		foreach(var key; svg_keys)
			m[key] = EICAS.getElementById(key);

        m.timers=[];
		return m;
	},

    newMFD: func(){
 		me.update_timer = maketimer(0.05, func me.update() );
 		me.update_slow_timer = maketimer(0.2, func me.update_slow() );
 		me.update_ap_modes_timer = maketimer(0.2, func me.update_ap_modes() );
 		me.update_timer.start();
 		me.update_slow_timer.start();
 		me.update_ap_modes_timer.start();
    },

	update: func(){
        # Center Setting
        me["n1-dial1"].setCenter(72, 106);
        me["throttle-n1"].setCenter(72, 106);
        me["n1-dial2"].setCenter(197, 106);
        me["throttle-n2"].setCenter(197, 106);
        me["throttle-n1"].setCenter(72, 196);
        me["n1-dial2"].setCenter(197, 196);
        me["n2-dial1"].setCenter(72, 296);
        me["n2-dial2"].setCenter(197, 296);
        me["flap-dial"].setCenter(363, 408);
		
	}
};

setlistener("sim/signals/fdm-initialized", func() {
	EICAS_display = canvas.new({
		"name": "EICAS",
		"size": [484, 726],
		"view": [128, 192],
		"mipmapping": 1
	});
	EICAS_display.addPlacement({"node": "EICAS.captL"});
	var group = EICAS_display.createGroup();
	EICAS_canvas = canvas_EICAS.new(group);
    EICAS_canvas.newMFD();
 	#EICAS_canvas.update();
}, 0, 0);

#setlistener("sim/signals/reinit", func EICAS_display.del());

var showEICAS = func() {
	var dlg = canvas.Window.new([1024, 1515], "dialog").set("resize", 1);
	dlg.setCanvas(EICAS_display);
}