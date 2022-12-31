# ==============================================================================
# 737 MAX Primary Flight Display
# Israel Emmanuel
# ==============================================================================

var PFDF_canvas = nil;
var PFDF_display = nil;
var months = ["JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"];

var canvas_PFDF = {
	new: func(canvas_group) {
		var m = {parents: [canvas_PFDF]};
		var PFDF = canvas_group;
		var font_mapper = func(family, weight) {
			return "OCRBMT.TTF";
		};
		
		canvas.parsesvg(PFDF, "Aircraft/737-MAX/Models/Instruments/res/PFD-FO.svg" , {'font-mapper': font_mapper});
		
		var svg_keys = ["ground", "sky", "attitude", "turn-coordinator", "max-attitude", "afds-mode", "single-ch-back", "single-ch", "vor1", "vor2", "dme1", "dme2", "flt-no", "xpdr", "selcal", "registration", "day", "month", "year", "elapsed", "utc", "timer-arm", "timer-analog", "back-trans", "compass-text", "compass", "ap-heading", "sel-hdg", "hdg-type", "press-set", "wind-arrow", "wind-speed", "wind-heading","wing-stats", "ground-speed", "true-airspeed", "fd-horizontal", "fd-vertical", "alt-ground", "ap-alt-tape", "alt-tape0", "alt-tape1", "alt-tape2", "alt-tape3", "alt-tape4", "alt-tape5", "alt-tape6", "alt-tape7", "alt-tape8", "alt-tape9", "alt-neg", "alt-20", "alt-100", "alt-1000", "alt-10000", "alt-00000", "alt-m", "alt-final-box", "alt-final", "ap-alt-thousand", "ap-alt-hundred", "ap-alt-meter", "spd-box", "spd-tape", "mach", "spd-1", "spd-10", "spd-100", "spd-ap", "spd-limitUR", "spd-limitUB", "spd-limitLR", "spd-limitLB", "spd-limitY", "aoa-needle", "vs-neg", "vs-pos", "vnav", "lnav", "a-throttle", "ap-mode"];
		foreach(var key; svg_keys)
			m[key] = PFDF.getElementById(key);

        m["alt-tape0"].set("clip", "rect(58, 540, 406, 479)");
        m["alt-tape1"].set("clip", "rect(58, 540, 406, 479)");
        m["alt-tape2"].set("clip", "rect(58, 540, 406, 479)");
        m["alt-tape3"].set("clip", "rect(58, 540, 406, 479)");
        m["alt-tape4"].set("clip", "rect(58, 540, 406, 479)");
        m["alt-tape5"].set("clip", "rect(58, 540, 406, 479)");
        m["alt-tape6"].set("clip", "rect(58, 540, 406, 479)");
        m["alt-tape7"].set("clip", "rect(58, 540, 406, 479)");
        m["alt-tape8"].set("clip", "rect(58, 540, 406, 479)");
        m["alt-tape9"].set("clip", "rect(58, 540, 406, 479)");
        m["alt-ground"].set("clip", "rect(58, 540, 406, 479)");
        m["alt-20"].set("clip", "rect(210, 561, 254, 498)");
        m["alt-100"].set("clip", "rect(210, 561, 254, 498)");
        m["alt-1000"].set("clip", "rect(210, 561, 254, 498)");
        m["alt-10000"].set("clip", "rect(210, 561, 254, 498)");
        m["spd-1"].set("clip", "rect(207, 157, 256, 113)");
        m["spd-10"].set("clip", "rect(207, 157, 256, 113)");
        m["spd-100"].set("clip", "rect(207, 157, 256, 113)");
        m["spd-limitUR"].set("clip", "rect(58, 182, 406, 176)");
        m["spd-limitUB"].set("clip", "rect(58, 182, 406, 176)");
        m["spd-limitLR"].set("clip", "rect(58, 182, 406, 176)");
        m["spd-limitLB"].set("clip", "rect(58, 182, 406, 176)");
        m["spd-limitY"].set("clip", "rect(58, 182, 406, 176)");
        m["spd-tape"].set("clip", "rect(58, 176, 406, 115)");
        m["aoa-needle"].set("clip", "rect(112, 593, 352, 570)");

        # Center Setting
        # m["ground"].setCenter(323, 232);
        # m["sky"].setCenter(323, 232);
        m["turn-coordinator"].setCenter(323, 232);
        m["ap-heading"].setCenter(323, 654);
        m.timers=[];

		return m;
	},

    newMFD: func() {
 		me.update_timer = maketimer(0.05, func me.update());
 		me.update_timer.start();
 		me.update_slow_timer.start();
 		me.update_ap_modes_timer.start();
    },

	update: func() {
        #Setup stuff
        me["back-trans"].setColorFill(0, 0, 0, 0.3);

		# Artificial Horizon
        me["ground"].setTranslation(0, getprop("orientation/pitch-deg")*4.8);
        me["sky"].setTranslation(0, getprop("orientation/pitch-deg")*4.8);
        me["attitude"].setTranslation(0, getprop("orientation/pitch-deg")*4.8);
        me["ground"].setRotation(getprop("orientation/roll-deg")*D2R);
        me["sky"].setRotation(getprop("orientation/roll-deg")*D2R);
        me["attitude"].setRotation(getprop("orientation/roll-deg")*D2R);
        if (getprop("orientation/roll-deg") > 60)
            me["turn-coordinator"].setRotation(-60*D2R);
        elsif (getprop("orientation/roll-deg") < -60)
            me["turn-coordinator"].setRotation(60*D2R);
        else
            me["turn-coordinator"].setRotation(-getprop("orientation/roll-deg")*D2R);

        # AFDS Mode
        if(getprop("autopilot/display/afds-mode") == "SINGLE CH") {
            me["single-ch"].show();
            me["single-ch-back"].show();
            me["afds-mode"].hide();
        } else {
            me["single-ch"].hide();
            me["single-ch-back"].hide();
            me["afds-mode"].show();
            me["afds-mode"].setText(getprop("autopilot/display/afds-mode"));
        }

        # NAV Radio
        me["dme1"].setText(sprintf("%.03d", getprop("instrumentation/nav[0]/frequencies/selected-mhz")));
        me["dme2"].setText(sprintf("%0.3d", getprop("instrumentation/nav[1]/frequencies/selected-mhz")));

        # Auxiliary Panel
        me["flt-no"].setText(getprop("instrumentation/registration/flt-no"));
        me["xpdr"].setText(getprop("instrumentation/transponder/id-code"));
        me["selcal"].setText("AF-XS");
        me["registration"].setText(getprop("instrumentation/registration/registration"));
        me["elapsed"].setText(sprintf("%i:%02i", getprop("sim/time/elapsed-sec")/60, math.mod(getprop("sim/time/elapsed-sec"), 60)));
        me["day"].setText(sprintf("%i", getprop("sim/time/utc/day")));
        me["month"].setText(months[getprop("sim/time/utc/month") - 1]);
        me["year"].setText(sprintf("%i", math.mod(getprop("sim/time/utc/year"), 100)));
        me["utc"].setText(sprintf("%sz", getprop("sim/time/gmt-string")));

        # Heading
        me["compass-text"].setRotation(-getprop("orientation/heading-deg")*D2R);
        me["compass"].setRotation(-getprop("orientation/heading-deg")*D2R);
        me["ap-heading"].setRotation(-getprop("it-autoflight/input/hdg")*D2R);
        me["ap-heading"].setRotation(-getprop("orientation/heading-deg")*D2R);
        me["sel-hdg"].setText(sprintf("%i", getprop("it-autoflight/input/hdg")));

        # Wind and Speeds
        me["ground-speed"].setText(sprintf("%i", getprop("velocities/groundspeed-kt")));
        me["true-airspeed"].setText(sprintf("%i", getprop("velocities/airspeed-kt")));
        me["wind-heading"].setText(sprintf("%03i", getprop("environment/wind-from-heading-deg")));
        me["wind-speed"].setText(sprintf("%i", getprop("environment/wind-speed-kt")));
        me["wind-arrow"].setRotation(getprop("environment/wind-from-heading-deg")*D2R);

        # Flight Director
        if(getprop("it-autoflight/input/fd1")) {
            me["fd-horizontal"].show();
            me["fd-vertical"].show();
            me["fd-horizontal"].setTranslation(0, getprop("it-autoflight/fd/pitch-bar"));
            me["fd-vertical"].setTranslation(getprop("it-autoflight/fd/roll-bar"), 0);
        } else {
            me["fd-horizontal"].hide();
            me["fd-vertical"].hide();
        }
        
        # Altitude and VNAV
        if(getprop("position/altitude-ft")-getprop("it-autoflight/input/alt") > 400)
            me["ap-alt-tape"].setTranslation(0, 174);
        elsif(getprop("position/altitude-ft")-getprop("it-autoflight/input/alt") < -400)
            me["ap-alt-tape"].setTranslation(0, -174);
        else
            me["ap-alt-tape"].setTranslation(0, 174/400*(getprop("position/altitude-ft")-getprop("it-autoflight/input/alt")));
        
        # Hiding upper tapes by default
        me["alt-tape0"].hide();
        me["alt-tape1"].hide();
        me["alt-tape2"].hide();
        me["alt-tape3"].hide();
        me["alt-tape4"].hide();
        me["alt-tape5"].hide();
        me["alt-tape6"].hide();
        me["alt-tape7"].hide();
        me["alt-tape8"].hide();
        me["alt-tape9"].hide();

        # Moving the tapes
        me["alt-ground"].show().setTranslation(0, getprop("position/altitude-agl-ft")*0.44);

        if(getprop("position/altitude-ft") < 4600) {
            me["alt-tape0"].show().setTranslation(0, getprop("position/altitude-ft")*0.44);
            me["alt-tape1"].show().setTranslation(0, getprop("position/altitude-ft")*0.44);
        } elsif (getprop("position/altitude-ft") < 9600) {
            me["alt-tape1"].show().setTranslation(0, getprop("position/altitude-ft")*0.44);
            me["alt-tape2"].show().setTranslation(0, (getprop("position/altitude-ft")-4600)*0.44);
        } elsif (getprop("position/altitude-ft") < 14600) {
            me["alt-tape2"].show().setTranslation(0, (getprop("position/altitude-ft")-4600)*0.44);
            me["alt-tape3"].show().setTranslation(0, (getprop("position/altitude-ft")-9600)*0.44);
        } elsif (getprop("position/altitude-ft") < 19600) {
            me["alt-tape3"].show().setTranslation(0, (getprop("position/altitude-ft")-9600)*0.44);
            me["alt-tape4"].show().setTranslation(0, (getprop("position/altitude-ft")-14600)*0.44);
        } elsif (getprop("position/altitude-ft") < 24600) {
            me["alt-tape4"].show().setTranslation(0, (getprop("position/altitude-ft")-14600)*0.44);
            me["alt-tape5"].show().setTranslation(0, (getprop("position/altitude-ft")-19600)*0.44);
        } elsif (getprop("position/altitude-ft") < 29600) {
            me["alt-tape5"].show().setTranslation(0, (getprop("position/altitude-ft")-19600)*0.44);
            me["alt-tape6"].show().setTranslation(0, (getprop("position/altitude-ft")-24600)*0.44);
        } elsif (getprop("position/altitude-ft") < 34600) {
            me["alt-tape6"].show().setTranslation(0, (getprop("position/altitude-ft")-24600)*0.44);
            me["alt-tape7"].show().setTranslation(0, (getprop("position/altitude-ft")-29600)*0.44);
        } elsif (getprop("position/altitude-ft") < 39600) {
            me["alt-tape7"].show().setTranslation(0, (getprop("position/altitude-ft")-29600)*0.44);
            me["alt-tape8"].show().setTranslation(0, (getprop("position/altitude-ft")-34600)*0.44);
        } elsif (getprop("position/altitude-ft") < 44600) {
            me["alt-tape8"].show().setTranslation(0, (getprop("position/altitude-ft")-34600)*0.44);
            me["alt-tape9"].show().setTranslation(0, (getprop("position/altitude-ft")-39600)*0.44);
        }

        # Low-altitude box
        if(getprop("position/altitude-agl-ft") < 100)
            me["alt-final"].setText(sprintf("%i", math.round(getprop("position/altitude-agl-ft"), 2)));
        elsif (getprop("position/altitude-agl-ft") < 500)
            me["alt-final"].setText(sprintf("%i", math.round(getprop("position/altitude-agl-ft"), 10)));
        elsif (getprop("position/altitude-agl-ft") < 2520)
            me["alt-final"].setText(sprintf("%i", math.round(getprop("position/altitude-agl-ft"), 20)));
        else {
            me["alt-final"].hide();
            me["alt-final-box"].hide();
        }

        # Altitude box
        if(getprop("position/altitude-ft") < 0)
            me["alt-neg"].show();
        else
            me["alt-neg"].hide();
        
        if(getprop("position/altitude-ft") < 10000)
            me["alt-00000"].show();
        else
            me["alt-00000"].hide();

        me["alt-20"].setTranslation(0, math.mod(getprop("position/altitude-ft"), 100)*0.86);

        if(math.mod(getprop("position/altitude-ft"), 100) > 80)
            me["alt-100"].setTranslation(0, math.mod((getprop("position/altitude-ft") - math.mod(getprop("position/altitude-ft"), 100)) * 0.2755, 248) + ((math.mod(getprop("position/altitude-ft"), 100) - 80) * 1.385));
        else
            me["alt-100"].setTranslation(0, math.mod((getprop("position/altitude-ft") - math.mod(getprop("position/altitude-ft"), 100)) * 0.2755, 248));

        if(math.mod(getprop("position/altitude-ft"), 1000) > 900)
            me["alt-1000"].setTranslation(0, math.mod((getprop("position/altitude-ft") - math.mod(getprop("position/altitude-ft"), 1000)) * 0.3, 270.2) + ((math.mod(getprop("position/altitude-ft"), 1000) - 900) * 0.303));
        else
            me["alt-1000"].setTranslation(0, math.mod((getprop("position/altitude-ft") - math.mod(getprop("position/altitude-ft"), 1000)) * 0.3, 270.2));

        if(math.mod(getprop("position/altitude-ft"), 10000) > 9000)
            me["alt-10000"].setTranslation(0, math.mod((getprop("position/altitude-ft") - math.mod(getprop("position/altitude-ft"), 10000)) * 0.03, 270.2) + ((math.mod(getprop("position/altitude-ft"), 10000) - 9000) * 0.0303));
        else
            me["alt-10000"].setTranslation(0, math.mod((getprop("position/altitude-ft") - math.mod(getprop("position/altitude-ft"), 10000)) * 0.03, 270.2));

        me["alt-m"].setText(sprintf("%i", getprop("position/altitude-ft") * FT2M));
        me["ap-alt-meter"].setText(sprintf("%i", getprop("it-autoflight/input/alt") * FT2M));
        me["ap-alt-thousand"].setText(sprintf("%i", getprop("it-autoflight/input/alt") / 1000));
        me["ap-alt-hundred"].setText(sprintf("%03i", math.mod(getprop("it-autoflight/input/alt"), 1000)));

        # Speed Tape
        me["spd-tape"].setTranslation(0, getprop("instrumentation/airspeed-indicator/indicated-speed-kt") * 2.9);
        me["spd-limitLR"].setTranslation(0, getprop("instrumentation/airspeed-indicator/indicated-speed-kt") * 2.9);
        me["spd-limitLB"].setTranslation(0, getprop("instrumentation/airspeed-indicator/indicated-speed-kt") * 2.9);
        me["spd-limitUR"].setTranslation(0, getprop("instrumentation/airspeed-indicator/indicated-speed-kt") * 2.9);
        me["spd-limitUB"].setTranslation(0, getprop("instrumentation/airspeed-indicator/indicated-speed-kt") * 2.9);
        me["spd-limitY"].setTranslation(0, getprop("instrumentation/airspeed-indicator/indicated-speed-kt") * 2.9);

        if (getprop("controls/flight/flaps") > 0) {
            me["spd-limitUR"].setTranslation(0, getprop(sprintf("limits/max-flap-extension-speed[%s]/speed", getprop("controls/flight/flaps") * 8)) * 2.9);
            me["spd-limitUB"].setTranslation(0, getprop(sprintf("limits/max-flap-extension-speed[%s]/speed", getprop("controls/flight/flaps") * 8)) * 2.9);
        }

        if (getprop("instrumentation/weu/state/stall-speed") != nil) {
            me["spd-limitLR"].setTranslation(0,-getprop("instrumentation/weu/state/stall-speed") * 2.9);
            me["spd-limitLB"].setTranslation(0,-getprop("instrumentation/weu/state/stall-speed") * 2.9);
            me["spd-limitY"].setTranslation(0,-getprop("instrumentation/weu/state/stall-speed") * 2.9);
        }
        
        if (getprop("instrumentation/airspeed-indicator/indicated-speed-kt") < 45) {
            me["spd-1"].setTranslation(0, 105);
            me["spd-10"].setTranslation(0, 136.2);
        } else {
            me["spd-1"].setTranslation(0, math.mod(getprop("instrumentation/airspeed-indicator/indicated-speed-kt"), 10) * 21.3);
            if(math.mod(getprop("instrumentation/airspeed-indicator/indicated-speed-kt"), 10) > 9)
                me["spd-10"].setTranslation(0, math.mod(getprop("instrumentation/airspeed-indicator/indicated-speed-kt")-math.mod(getprop("instrumentation/airspeed-indicator/indicated-speed-kt"), 10), 100) * 3.43 + (math.mod(getprop("instrumentation/airspeed-indicator/indicated-speed-kt"), 10) - 9) * 34.3);
            else
                me["spd-10"].setTranslation(0, math.mod(getprop("instrumentation/airspeed-indicator/indicated-speed-kt")-math.mod(getprop("instrumentation/airspeed-indicator/indicated-speed-kt"), 10), 100) * 3.43);

            if(math.mod(getprop("instrumentation/airspeed-indicator/indicated-speed-kt"), 100) > 90)
                me["spd-100"].setTranslation(0, math.mod(getprop("instrumentation/airspeed-indicator/indicated-speed-kt")-math.mod(getprop("instrumentation/airspeed-indicator/indicated-speed-kt"), 100), 1000) * 0.343 + (math.mod(getprop("instrumentation/airspeed-indicator/indicated-speed-kt"), 100) - 90) * 3.43);
            else
                me["spd-100"].setTranslation(0, math.mod(getprop("instrumentation/airspeed-indicator/indicated-speed-kt")-math.mod(getprop("instrumentation/airspeed-indicator/indicated-speed-kt"), 100), 1000) * 0.343);
        }
        me["mach"].setText(sprintf(".%.03d", getprop("velocities/mach")));

        if (getprop("it-autoflight/input/kts-mach"))
            me["spd-ap"].setText(sprintf(".%.03d", getprop("it-autoflight/input/spd-mach")));
        else
            me["spd-ap"].setText(sprintf("%i", getprop("it-autoflight/input/spd-kts")));

        
        
        # AOA Indicator
        if (math.abs(getprop("velocities/vertical-speed-fps")*60) < 1000)
            me["aoa-needle"].setRotation(getprop("velocities/vertical-speed-fps")*0.056*60*D2R);
        elsif (math.abs(getprop("velocities/vertical-speed-fps")*60) < 2000)
            me["aoa-needle"].setRotation(getprop("velocities/vertical-speed-fps")*0.03425*60*D2R);
        elsif (math.abs(getprop("velocities/vertical-speed-fps")*60) < 6000)
            me["aoa-needle"].setRotation(getprop("velocities/vertical-speed-fps")*0.011833*60*D2R);
        else {
            if(getprop("velocities/vertical-speed-fps") * 60 > 0)
                me["aoa-needle"].setRotation(71*D2R);
            elsif(getprop("velocities/vertical-speed-fps") * 60 < 0)
                me["aoa-needle"].setRotation(71*D2R);
        }
            


        if(getprop("velocities/vertical-speed-fps")*60 > 500) {
            me["vs-pos"].show().setText(sprintf("%i", getprop("velocities/vertical-speed-fps")*60 - math.mod(getprop("velocities/vertical-speed-fps")*60, 50)));
            me["vs-neg"].hide();
        } elsif (getprop("velocities/vertical-speed-fps")*60 < -500) {
            me["vs-neg"].show().setText(sprintf("%i", -getprop("velocities/vertical-speed-fps")*60 + math.mod(getprop("velocities/vertical-speed-fps")*60, 50)));
            me["vs-pos"].hide();
        } else {
            me["vs-pos"].hide();
            me["vs-neg"].hide();
        }

        # Autopilot Modes
        me["a-throttle"].setText(getprop("autopilot/display/throttle-mode"));
        me["lnav"].setText(getprop("it-autoflight/mode/lat"));
        me["vnav"].setText(getprop("it-autoflight/mode/vert"));
	},
};

setlistener("sim/signals/fdm-initialized", func() {
	PFDF_display = canvas.new({
		"name": "PFDF",
		"size": [1940, 1452],
		"view": [970, 726],
		"mipmapping": 1
	});
	PFDF_display.addPlacement({"node": "screen4.full"});
	var group = PFDF_display.createGroup();
	PFDF_canvas = canvas_PFDF.new(group);
    PFDF_canvas.newMFD();
 	PFDF_canvas.update();
}, 0, 0);

#setlistener("sim/signals/reinit", func PFDF_display.del());

var showPFDF = func() {
	var dlg = canvas.Window.new([485, 363], "dialog").set("resize", 0.5);
	dlg.setCanvas(PFDF_display);
}