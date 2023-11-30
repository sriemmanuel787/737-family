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
		
		canvas.parsesvg(NDWide, "Aircraft/737-MAX/Models/Cockpit/Screens/NDWide.svg" , {'font-mapper': font_mapper});
		
		var svg_keys = ["true-airspeed", "ground-speed", "wind-speed", "wind-heading", "wind-arrow", "range", "wpt-next", "wpt-time", "wpt-distance", "NM", "heading", "heading-mode", "hdg-mode", "heading-ap", "TFC", "WPT", "ARPT", "TERR", "WX-A", "vor1hdg", "vor2hdg", "dme1", "dme2", "vor1", "vor2", "anp", "rnp", "hdg-ap", "hdg-track", "range-half", "overlay-norm", "compass"];
		foreach(var key; svg_keys)
			m[key] = NDWide.getElementById(key);

        m.timers=[];
		return m;
	},

	update: func(){
        # Center Setting
        me["heading-ap"].setCenter(me["compass"].getCenter());
        me["vor1hdg"].setCenter(me["compass"].getCenter());
        me["vor2hdg"].setCenter(me["compass"].getCenter());
        me["hdg-ap"].setCenter(me["compass"].getCenter());
        me["hdg-track"].setCenter(me["compass"].getCenter());
        me["vor2hdg"].setCenter(me["compass"].getCenter());
        
        # Wind and Range
        me["ground-speed"].setText(sprintf("%i", getprop("velocities/groundspeed-kt")));
        me["true-airspeed"].setText(sprintf("%i", getprop("velocities/airspeed-kt")));
        me["wind-heading"].setText(sprintf("%03i", getprop("environment/wind-from-heading-deg")));
        me["wind-speed"].setText(sprintf("%i", getprop("environment/wind-speed-kt")));
        me["range"].setText(sprintf("%i", getprop("instrumentation/efis[0]/inputs/range-nm")));
        me["range-half"].setText(sprintf("%i", getprop("instrumentation/efis[0]/inputs/range-nm")/2));
        me["wind-arrow"].setRotation(getprop("environment/wind-from-heading-deg")*D2R);

        # Next Waypoint
        if(getprop("autopilot/route-manager/wp") == nil){
            me["wpt-next"].hide();
            me["wpt-time"].hide();
            me["wpt-distance"].hide();
            me["NM"].hide();
        }else{
            me["wpt-next"].show().setText(getprop("autopilot/route-manager/wp/id"));
            me["wpt-time"].show().setText(getprop("autopilot/route-manager/wp/eta"));
            me["wpt-distance"].show().setText(sprintf("%.01f", getprop("autopilot/route-manager/wp/dist")));
            me["NM"].show();
        }
        

        # Route Drawing
        if(getprop("autopilot/route-manager/wp[0]/id") != ""){
            var start = [getprop("autopilot/route-manager/route/wp[0]/latitude-deg"), getprop("autopilot/route-manager/route/wp[0]/longitude-deg")];
            var pos = [getprop("position/latitude-deg"), getprop("position/longitude-deg")];
            # Haversine formula, to find the distance bewteen the first waypoint and the current position
            var dist = 7917.5*math.asin(math.sqrt(math.pow(math.sin(math.abs(start[0]-pos[0])/2), 2) + math.cos(start[0])*math.cos(pos[0])*math.pow(math.sin(math.abs(start[1]-pos[1])/2), 2)));
            var angle = math.atan2(math.cos(start[0]) * math.sin(math.abs(start[1]-pos[1])), math.cos(pos[0]) * math.sin(start[0]) - (math.sin(pos[0]) * math.cos(start[0]) * math.cos(math.abs(start[1]-pos[1]))));
        }
        
        # Take the heading from previous waypoint to next waypoint and subtract from currect heading.
        # Take the cos() of that angle and move it along the x-axis, then the sin() and move it along the y-axis().
        # Do this for every waypoint in the list.
        var mi2px = 888/getprop("instrumentation/efis[0]/inputs/range-nm");
        

        # for(var i = 1; i < getprop("autopilot/route-manager/route/num"); i++){
            
        # }

        # Compass
        me["compass"].setRotation(-getprop("orientation/heading-deg")*D2R);
        me["hdg-ap"].setRotation(-getprop("orientation/heading-deg")*D2R);
        me["vor1hdg"].setRotation(-getprop("orientation/heading-deg")*D2R);
        me["vor2hdg"].setRotation(-getprop("orientation/heading-deg")*D2R);
        me["heading-ap"].setRotation(-getprop("orientation/heading-deg")*D2R);
        me["compass"].setRotation(-getprop("orientation/heading-deg")*D2R);
        me["hdg-track"].setRotation((getprop("orientation/heading-deg")*D2R)-(getprop("orientation/track-deg")*D2R));
        me["heading"].setText(sprintf("%03i", getprop("orientation/heading-deg")));
        if(getprop("instrumentation/efis[0]/trk-selected"))
            me["hdg-mode"].setText("TRK");
        else
            me["hdg-mode"].setText("HDG");

        # VOR-DME
        me["dme1"].setText(sprintf("%.03d", getprop("instrumentation/dme[0]/frequencies/selected-mhz")));
        me["dme2"].setText(sprintf("%.03d", getprop("instrumentation/dme[1]/frequencies/selected-mhz")));

        if(getprop("instrumentation/nav[0]/nav-id") == "")
            me["vor1"].setText("------");
        else
            me["vor1"].setText(getprop("instrumentation/nav[0]/nav-id"));
            
        if(getprop("instrumentation/nav[1]/nav-id") == "")
            me["vor2"].setText("------");
        else
            me["vor2"].setText(getprop("instrumentation/nav[1]/nav-id"));

        # Map modes
        if(getprop("instrumentation/efis[0]/inputs/arpt")){
            me["ARPT"].show();
        }else{
            me["ARPT"].hide();
        }

        if(getprop("instrumentation/efis[0]/inputs/wpt")){
            me["WPT"].show();
        }else{
            me["WPT"].hide();
        }

        if(getprop("instrumentation/efis[0]/inputs/terr")){
            me["TERR"].show();
        }else{
            me["TERR"].hide();
        }

        if(getprop("instrumentation/efis[0]/inputs/wxr")){
            me["WX-A"].show();
        }else{
            me["WX-A"].hide();
        }
	}
};

setlistener("sim/signals/fdm-initialized", func() {
	NDWide_display = canvas.new({
		"name": "NDWide",
		"size": [1760, 1320],
		"view": [880, 660],
		"mipmapping": 1
	});
	NDWide_display.addPlacement({"node": "screen2.full"});
	var group = NDWide_display.createGroup();
    var testMap = group.createChild("map");
    testMap.setController("Aircraft position");
    testMap.setRange(25);
    testMap.setTranslation(440,330);
    var r = func(name,vis=1,zindex=nil) return caller(0)[0];
    # TFC, APT and APS are the layer names as per $FG_ROOT/Nasal/canvas/map and the names used in each .lcontroller file
    # in this case, it will load the traffic layer (TFC), airports (APT) and render an airplane symbol (APS)
    foreach(var type; [r('TFC'),r('APT'), r('APS') ] )
            testMap.addLayer(factory: canvas.SymbolLayer, type_arg: type.name, visible: type.vis, priority: type.zindex,);
	NDWide_canvas = canvas_NDWide.new(group);
	update_timer = maketimer(0.1, func NDWide_canvas.update());
 	update_timer.start();
 	NDWide_canvas.update();
}, 0, 0);

#setlistener("sim/signals/reinit", func NDWide_display.del());

var showNDWide = func() {
	var dlg = canvas.Window.new([880, 660], "dialog").set("resize", 1);
	dlg.setCanvas(NDWide_display);
}