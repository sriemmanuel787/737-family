# ==============================================================================
# 737 MAX Engine Indicator and Crew Alerting System
# Israel Emmanuel
# ==============================================================================

var IESI_canvas = nil;
var IESI_display = nil;

var canvas_IESI = {
	new: func(canvas_group) {
		var m = {parents: [canvas_IESI]};
		var IESI = canvas_group;
		var font_mapper = func(family, weight) {
			return "OCRBMT.TTF";
		};
		
		canvas.parsesvg(IESI, "Aircraft/737-MAX/Models/Cockpit/Screens/IESI.svg" , {'font-mapper': font_mapper});
		
		var svg_keys = ["app", "press-set", "loc-gswhite", "loc-gsblack", "loc-hdgwhite", "loc-hdgblack", "loc-gs", "loc-hdg", "alt-00000", "alt-10000", "alt-1000", "alt-100", "alt-20", "alt-tape9", "alt-tape8", "alt-tape7", "alt-tape6", "alt-tape5", "alt-tape4", "alt-tape3", "alt-tape2", "alt-tape1", "alt-tape0", "spd-100", "spd-10", "spd-1", "spd-tape", "compass", "turn-coordinator", "attitude", "ground", "sky"];
		foreach(var key; svg_keys)
			m[key] = IESI.getElementById(key);

        m.timers=[];
		return m;
	},

	update: func(){
        # Compass and attitude
        me["compass"].setRotation(-getprop("orientation/heading-deg")*D2R);
        me["attitude"].setTranslation(0, getprop("orientation/pitch-deg")*4).setCenter(121,134-(getprop("orientation/pitch-deg")*4)).setRotation(-getprop("orientation/roll-deg")*D2R);
        me["ground"].setTranslation(0, getprop("orientation/pitch-deg")*4).setCenter(121,134-(getprop("orientation/pitch-deg")*4)).setRotation(-getprop("orientation/roll-deg")*D2R);
        me["sky"].setTranslation(0, getprop("orientation/pitch-deg")*4).setCenter(121,134-(getprop("orientation/pitch-deg")*4)).setRotation(-getprop("orientation/roll-deg")*D2R);
        if(getprop("orientation/roll-deg") > 45){
            me["turn-coordinator"].setCenter(121,134).setRotation(-45*D2R);
        } elsif (getprop("orientation/roll-deg") < -45){
            me["turn-coordinator"].setCenter(121,134).setRotation(45*D2R);
        } else {
            me["turn-coordinator"].setCenter(121,134).setRotation(-getprop("orientation/roll-deg")*D2R);
        }
	}
};

setlistener("sim/signals/fdm-initialized", func() {
	IESI_display = canvas.new({
		"name": "IESI",
		"size": [2080, 2040],
		"view": [260, 255],
		"mipmapping": 1
	});
	IESI_display.addPlacement({"node": "screen.iesi"});
	var group = IESI_display.createGroup();
	IESI_canvas = canvas_IESI.new(group);
	me.update_timer = maketimer(0.05, func me.update() );
 	me.update_timer.start();
 	IESI_canvas.update();
}, 0, 0);

#setlistener("sim/signals/reinit", func IESI_display.del());