var annunciator_canvas = nil;
var annunciator_display = nil;

var canvas_annunciator = {
	new: func(canvas_group)
	{
		var m = { parents: [canvas_annunciator] };
		var annunciator = canvas_group;
		var font_mapper = func(family, weight)
		{
			if( family == "'Liberation Sans'" and weight == "normal" )
				return "LiberationFonts/LiberationSans-Regular.ttf";
		};
		
		canvas.parsesvg(annunciator, "Aircraft/737-MAX/Models/Cockpit/AP-OH/annunciator.svg", {'font-mapper': font_mapper});
		
		var svg_keys = ["air-cond", "overhead", "eng", "ovht-det", "apu", "elec", "doors", "hyd", "anti-ice", "fuel", "irs", "flt-cont"];
		foreach(var key; svg_keys) {
			m[key] = annunciator.getElementById(key);
		}

		return m;
	},
	update: func()
	{
        # Fuel Light
		if(getprop("controls/fuel/tank[0]/pump-fwd") == 0 or getprop("controls/fuel/tank[0]/pump-aft") == 0 or getprop("controls/fuel/tank[1]/pump-fwd") == 0 or getprop("controls/fuel/tank[1]/pump-aft") == 0 or getprop("controls/fuel/tank[0]/pump-aft") == 0 or getprop("controls/fuel/tank[2]/pump-left") == 0 or getprop("controls/fuel/tank[2]/pump-right") == 0)
            me["fuel"].show();
        else
            me["fuel"].hide();

        # Engine
        if(getprop("engines/engine[0]/egt-actual") >= 600 or getprop("engines/engine[1]/egt-actual") >= 600)
            me["eng"].show();
        else
            me["eng"].hide();

        # Doors
        if(getprop("controls/doors/LFDoor/LFDoorPos1/position-norm") > 0 or getprop("controls/doors/RFDoor/RFDoorPos1/position-norm") > 0 or getprop("controls/doors/LRDoor/LRDoorPos1/position-norm") > 0 or getprop("controls/doors/RRDoor/RRDoorPos1/position-norm") > 0)
            me["door"].show();
        else
            me["door"].hide();
		settimer(func me.update(), 0.1);
	},
};

setlistener("sim/signals/fdm-initialized", func() {
	annunciator_display = canvas.new({
		"name": "annunciator",
		"size": [512, 512],
		"view": [512, 512],
		"mipmapping": 1
	});
	annunciator_display.addPlacement({"node": "annunciator.L"});
    annunciator_display.addPlacement({"node": "annunciator.R"});
	var group = annunciator_display.createGroup();
	annunciator_canvas = canvas_annunciator.new(group);
	annunciator_canvas.update();
}, 0, 0);