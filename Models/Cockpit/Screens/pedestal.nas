# ==============================================================================
# 737 MAX Navigation Display
# Israel Emmanuel
# ==============================================================================

var pedestal_canvas = nil;
var pedestal_display = nil;

var canvas_pedestal = {
	new: func(canvas_group) {
		var m = {parents: [canvas_pedestal]};
		var pedestal = canvas_group;
		var font_mapper = func(family, weight) {
			return "Std7SegCustom.TTF";
		};
		
		canvas.parsesvg(pedestal, "Aircraft/737-MAX/Models/Cockpit/Screens/pedestal.svg" , {'font-mapper': font_mapper});
		
		var svg_keys = ["rudder-trim", "commact1", "commact2", "navact1", "navact2", "adfact1", "adfact2", "commsty1", "commsty2", "navsty1", "navsty2", "adfsty1", "adfsty2", "adf1", "adf2", "ant1", "ant2", "transponder-code", "atc1", "atc2"];
		foreach(var key; svg_keys)
			m[key] = pedestal.getElementById(key);

        m.timers=[];
		return m;
	},

	update: func(){
        me["rudder-trim"].setTranslation(getprop("fdm/trim/rudder") * 16, 0);

        if(getprop("instrumentation/comm[0]/power-btn")){
            me["commact1"].show().setText(sprintf("%.03f", getprop("instrumentation/comm[0]/frequencies/selected-mhz")));
            me["commsty1"].show().setText(sprintf("%.03f", getprop("instrumentation/comm[0]/frequencies/standby-mhz")));
        } else {
            me["commact1"].hide();
            me["commsty1"].hide();
        }

        if(getprop("instrumentation/comm[1]/power-btn")){
            me["commact2"].show().setText(sprintf("%.03f", getprop("instrumentation/comm[1]/frequencies/selected-mhz")));
            me["commsty2"].show().setText(sprintf("%.03f", getprop("instrumentation/comm[1]/frequencies/standby-mhz")));
        } else {
            me["commact2"].hide();
            me["commsty2"].hide();
        }
        
        
        me["navact1"].setText(sprintf("%.02f", getprop("instrumentation/nav[0]/frequencies/selected-mhz")));
        me["navact2"].setText(sprintf("%.02f", getprop("instrumentation/nav[1]/frequencies/selected-mhz")));
        me["adfact1"].setText(sprintf("%.01f", getprop("instrumentation/adf[0]/frequencies/selected-khz")));
        me["adfact2"].setText(sprintf("%.01f", getprop("instrumentation/adf[1]/frequencies/selected-khz")));
        me["navsty1"].setText(sprintf("%.02f", getprop("instrumentation/nav[0]/frequencies/standby-mhz")));
        me["navsty2"].setText(sprintf("%.02f", getprop("instrumentation/nav[1]/frequencies/standby-mhz")));
        me["adfsty1"].setText(sprintf("%.01f", getprop("instrumentation/adf[0]/frequencies/standby-khz")));
        me["adfsty2"].setText(sprintf("%.01f", getprop("instrumentation/adf[1]/frequencies/standby-khz")));
        me["transponder-code"].setText(sprintf("%i", getprop("instrumentation/transponder/id-code")));

        if(getprop("instrumentation/adf[0]/mode") == "adf"){
            me["adf1"].show();
            me["ant1"].hide();
        }
        elsif(getprop("instrumentation/adf[0]/mode") == "ant"){
            me["adf1"].hide();
            me["ant1"].show();
        }

        if(getprop("instrumentation/adf[1]/mode") == "adf"){
            me["adf2"].show();
            me["ant2"].hide();
        }
        elsif(getprop("instrumentation/adf[1]/mode") == "ant"){
            me["adf2"].hide();
            me["ant2"].show();
        }
        
        if(getprop("instrumentation/transponder/inputs/mode") == 1){
            me["atc1"].show();
            me["atc2"].hide();
        }elsif(getprop("instrumentation/transponder/inputs/mode") == 2){
            me["atc1"].hide();
            me["atc2"].show();
        }
	}
};

setlistener("sim/signals/fdm-initialized", func() {
	pedestal_display = canvas.new({
		"name": "pedestal",
		"size": [1024, 1024],
		"view": [1024, 1024],
		"mipmapping": 1
	});
	pedestal_display.addPlacement({"node": "pd.commact1"});
    pedestal_display.addPlacement({"node": "pd.commact2"});
    pedestal_display.addPlacement({"node": "pd.navact1"});
    pedestal_display.addPlacement({"node": "pd.navact2"});
    pedestal_display.addPlacement({"node": "pd.adfact1"});
    pedestal_display.addPlacement({"node": "pd.adfact2"});
    pedestal_display.addPlacement({"node": "pd.commsty1"});
    pedestal_display.addPlacement({"node": "pd.commsty2"});
    pedestal_display.addPlacement({"node": "pd.navsty1"});
    pedestal_display.addPlacement({"node": "pd.navsty2"});
    pedestal_display.addPlacement({"node": "pd.adfsty1"});
    pedestal_display.addPlacement({"node": "pd.adfsty2"});
    pedestal_display.addPlacement({"node": "pd.transponder"});
    pedestal_display.addPlacement({"node": "pd.trim-rudderscreen"});
	var group = pedestal_display.createGroup();
	pedestal_canvas = canvas_pedestal.new(group);
	update_timer = maketimer(0.5, func pedestal_canvas.update());
 	update_timer.start();
 	pedestal_canvas.update();
}, 0, 0);

#setlistener("sim/signals/reinit", func pedestal_display.del());