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
 		me.update_timer.start();
 		me.update_slow_timer.start();
 		me.update_ap_modes_timer.start();
    },

	update: func(){
        # Center Setting
        me["n1-dial1"].setCenter(72, 106);
        me["throttle-n1"].setCenter(72, 106);
        me["egt-dial1"].setCenter(72, 196);
        me["n2-dial1"].setCenter(72, 296);
        me["n1-dial2"].setCenter(197, 106);
        me["throttle-n2"].setCenter(197, 106);
        me["egt-dial2"].setCenter(197, 196);
        me["n2-dial2"].setCenter(197, 296);
        me["flap-dial"].setCenter(363, 408);

        # Engine N1
        me["n1-dial1"].setRotation(getprop("engines/engine[0]/n1")*2*D2R);
        me["throttle-n1"].setRotation((getprop("controls/engines/engine[0]/throttle")-0.9)*200*D2R);
        me["egt-dial1"].setRotation(getprop("engines/engine[0]/egt-actual")*0.2*D2R);
        me["n2-dial1"].setRotation(getprop("engines/engine[0]/n2")*2*D2R);
        me["n1-text1"].setText(sprintf("%0.1f", getprop("engines/engine[0]/n1")));
        me["throttle-num1"].setText(sprintf("%0.1f", getprop("controls/engines/engine[0]/throttle")*100));
        me["egt-text1"].setText(sprintf("%i", getprop("engines/engine[0]/egt-actual")));
        me["n2-text1"].setText(sprintf("%0.1f", getprop("engines/engine[0]/n2")));
        me["fuelflow1"].setText(sprintf("%0.2f", getprop("engines/engine[0]/fuel-flow_pph")*LB2KG/1000));
        if(getprop("engines/engine[0]/n2") > 18 and getprop("engines/engine[0]/n2") < 24)
            me["motoring1"].show();
        else
            me["motoring1"].hide();

        if(getprop("controls/engines/engine[0]/starter"))
            me["start-valve-open1"].show();
        else
            me["start-valve-open1"].hide();
        me["oil-filter-bypass1"].hide();
        if(getprop("engines/engine[0]/oil-pressure-psi") < 20)
            me["low-oil-pressure1"].show();
        else
            me["low-oil-pressure1"].hide();
        if(getprop("controls/engines/engine[0]/throttle") > getprop("engines/engine[0]/n1"))
            me["thrust1"].show();
        else
            me["thrust1"].hide();
        if(getprop("engines/engine[0]/fuel-flow_pph")/getprop("engines/engine[0]/n1") > 100)
            me["fuel-flow1"].show();
        else
            me["fuel-flow1"].hide();
        
        
        # Engine N2
        me["n1-dial2"].setRotation(getprop("engines/engine[1]/n1")*2*D2R);
        me["throttle-n2"].setRotation((getprop("controls/engines/engine[1]/throttle")-0.9)*200*D2R);
        me["egt-dial2"].setRotation(getprop("engines/engine[1]/egt-actual")*0.2*D2R);
        me["n2-dial2"].setRotation(getprop("engines/engine[1]/n2")*2*D2R);
        me["n1-text2"].setText(sprintf("%0.1f", getprop("engines/engine[1]/n1")));
        me["throttle-num2"].setText(sprintf("%0.1f", getprop("controls/engines/engine[1]/throttle")*100));
        me["egt-text2"].setText(sprintf("%i", getprop("engines/engine[1]/egt-actual")));
        me["n2-text2"].setText(sprintf("%0.1f", getprop("engines/engine[1]/n2")));
        me["fuelflow2"].setText(sprintf("%0.2f", getprop("engines/engine[1]/fuel-flow_pph")*LB2KG/1000));
        if(getprop("engines/engine[1]/n2") > 18 and getprop("engines/engine[1]/n2") < 24)
            me["motoring2"].show();
        else
            me["motoring2"].hide();

		if(getprop("controls/engines/engine[1]/starter"))
            me["start-valve-open2"].show();
        else
            me["start-valve-open2"].hide();
        me["oil-filter-bypass2"].hide();
        if(getprop("engines/engine[1]/oil-pressure-psi") < 20)
            me["low-oil-pressure2"].show();
        else
            me["low-oil-pressure2"].hide();
        if(getprop("controls/engines/engine[1]/throttle") > getprop("engines/engine[1]/n1"))
            me["thrust2"].show();
        else
            me["thrust2"].hide();
        if(getprop("engines/engine[1]/fuel-flow_pph")/getprop("engines/engine[1]/n1") > 100)
            me["fuel-flow2"].show();
        else
            me["fuel-flow2"].hide();

        if(getprop("surface-positions/flap-pos-norm") > 0)
            me["flap-ext"].show();
        else
            me["flap-ext"].hide();
        
        # Flap Dial
        if(getprop("surface-positions/flap-pos-norm") <= 0.125)
            me["flap-dial"].setRotation(getprop("surface-positions/flap-pos-norm")*8*33.7*D2R);
        elsif(getprop("surface-positions/flap-pos-norm") <= 0.25)
            me["flap-dial"].setRotation(getprop("surface-positions/flap-pos-norm")*4*77.9*D2R);
        elsif(getprop("surface-positions/flap-pos-norm") <= 0.375)
            me["flap-dial"].setRotation(getprop("surface-positions/flap-pos-norm")*8/3*114.6*D2R);
        elsif(getprop("surface-positions/flap-pos-norm") <= 5)
            me["flap-dial"].setRotation(getprop("surface-positions/flap-pos-norm")*2*153.9*D2R);
        elsif(getprop("surface-positions/flap-pos-norm") <= 0.625)
            me["flap-dial"].setRotation(getprop("surface-positions/flap-pos-norm")*1.6*180*D2R);
        elsif(getprop("surface-positions/flap-pos-norm") <= 0.75)
            me["flap-dial"].setRotation(getprop("surface-positions/flap-pos-norm")*4/3*208.7*D2R);
        elsif(getprop("surface-positions/flap-pos-norm") <= 0.825)
            me["flap-dial"].setRotation(getprop("surface-positions/flap-pos-norm")*8/7*239*D2R);
        elsif(getprop("surface-positions/flap-pos-norm") <= 1)
            me["flap-dial"].setRotation(getprop("surface-positions/flap-pos-norm")*270*D2R);

        if(math.mod(getprop("surface-positions/flap-pos-norm")*8, 1) != 0)
            me["flap-trans"].show();
        else
            me["flap-trans"].hide();

        # Fuel Tanks
        me["tank-l"].setText(sprintf("%0.2f", getprop("consumables/fuel/tank[0]/level-kg")/1000));
        me["tank-r"].setText(sprintf("%0.2f", getprop("consumables/fuel/tank[1]/level-kg")/1000));
        me["tank-c"].setText(sprintf("%0.2f", getprop("consumables/fuel/tank[2]/level-kg")/1000));
        me["total"].setText(sprintf("%0.1f", (getprop("consumables/fuel/tank[0]/level-kg") + getprop("consumables/fuel/tank[1]/level-kg") + getprop("consumables/fuel/tank[2]/level-kg"))/1000));

        # Temperature and Flight Mode
        me["air-temp"].setText(sprintf("%+ic"), getprop("environment/temperature-degc"));
        me["flt-mode"].setText(getprop("it-autoflight/input/thrustStg"));
	}
};

setlistener("sim/signals/fdm-initialized", func() {
	EICAS_display = canvas.new({
		"name": "EICAS",
		"size": [968, 1452],
		"view": [484, 726],
		"mipmapping": 1
	});
	EICAS_display.addPlacement({"node": "screen2.R"});
    EICAS_display.addPlacement({"node": "screen3.L"});
	var group = EICAS_display.createGroup();
	EICAS_canvas = canvas_EICAS.new(group);
    EICAS_canvas.newMFD();
 	EICAS_canvas.update();
}, 0, 0);

#setlistener("sim/signals/reinit", func EICAS_display.del());

var showEICAS = func() {
	var dlg = canvas.Window.new([484, 726], "dialog").set("resize", 1);
	dlg.setCanvas(EICAS_display);
}