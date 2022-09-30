# 737 MAX Engine Indicating and Crew Alerting System
# Based off of MD-11 by Joshua Davidson (Octal450)
# Refactored by Israel Emmanuel (sriemmanuel787)

var roundToNearest = func(n, m) {
	var x = int(n/m)*m;
	if((math.mod(n,m)) > (m/2) and n > 0)
			x = x + m;
	if((m - (math.mod(n,m))) > (m/2) and n < 0)
			x = x - m;
	return x;
}

var canvasEng = {
	new: func(canvasGroup, file) {
		var m = {parents: [canvasEng, canvasBase]};
		m.init(canvasGroup, file);
		
		return m;
	},
	getKeys: func() {
		return ["fuel-flow1", "fuel-flow2", "oil-press1", "oil-press2", "oil-temp1", "oil-temp2", "oil-qty1", "oil-qty2", "vib1", "vib2", "oil-press-meter1", "oil-press-meter2", "vib-meter1", "vib-meter2", "throttle-num1", "throttle-num2", "throttle-n1", "throttle-n2", "n1-text1", "n1-dial1", "n1-text2", "n1-dial2", "egt-text1", "egt-dial1", "egt-text2", "egt-dial2", "motoring1", "motoring2", "n2-text1", "n2-dial1", "n2-text2", "n2-dial2", "fuel-flow", "thrust", "low-oil-pressure", "oil-filter-bypass", "start-valve-open", "fuel-flow2", "thrust2", "low-oil-pressure2", "oil-filter-bypass2", "start-valve-open2", "tank-r", "tank-c", "tank-l", "total", "flt-mode", "air-temp", "flap-dial"];
	},
	
	setup: func() {},
	update: func() {
		var SCALE = 256/121; # constant for expansion to 2-factor res

		# center setting
		me["n1-dial1"].setCenter(72*SCALE,106*SCALE);
		me["throttle-n1"].setCenter(72*SCALE,106*SCALE);
		me["n2-dial1"].setCenter(197*SCALE,106*SCALE);
		me["throttle-n2"].setCenter(197*SCALE,106*SCALE);
		me["egt-dial1"].setCenter(72*SCALE,196*SCALE);
		me["egt-dial2"].setCenter(197*SCALE,196*SCALE);
		me["n2-dial1"].setCenter(72*SCALE,196*SCALE);
		me["n2-dial2"].setCenter(197*SCALE,296*SCALE);
		me["flap-dial"].setCenter(363*SCALE,408*SCALE);

		# Fuel
		me["tank-r"].setText(getprop("/consumables/fuel/tank[0]/level-kg")/1000);
		me["tank-c"].setText(getprop("/consumables/fuel/tank[2]/level-kg")/1000);
		me["tank-l"].setText(getprop("/consumables/fuel/tank[1]/level-kg")/1000);
		me["total"].setText((getprop("/consumables/fuel/tank[0]/level-kg") + getprop("/consumables/fuel/tank[1]/level-kg") + getprop("/consumables/fuel/tank[2]/level-kg"))/1000);
		
		#N1
		me["n1-dial1"].setRotation(getprop("/engines/engine[0]/n1")*2*D2R);
		me["n1-dial2"].setRotation(getprop("/engines/engine[1]/n1")*2*D2R);
		me["n1-dial1"].setRotation(getprop()*2*D2R); # property needs to be inserted
		me["n1-dial2"].setRotation(getprop()*2*D2R); # property needs to be inserted
		#EGT
		
		#N2
		me["n2-dial1"].setRotation(getprop("/engines/engine[0]/n2")*2*D2R);
		me["n2-dial2"].setRotation(getprop("/engines/engine[1]/n2")*2*D2R);
		if (getprop("/engines/engine[0]/n2") > 18 and getprop("/engines/engine[0]/n2") < 24){
			me["motoring1"].show();
		}else{
			me["motoring1"].hide();
		}
		if (getprop("/engines/engine[1]/n2") > 18 and getprop("/engines/engine[1]/n2") < 24){
			me["motoring2"].show();
		}else{
			me["motoring2"].hide();
		}
		
		#Oil and Fuel Flow
		me["fuel-flow1"].setText()
		
		#Warnings
		if (getprop("/controls/engines/engine[0]/starter") > 0){
			me["start-valve-open"].show();
		}else{
			me["start-valve-open"].hide();
		}
		
		if (getprop("/controls/engines/engine[1]/starter") > 0){
			me["start-valve-open2"].show();
		}else{
			me["start-valve-open2"].hide();
		}
		
		#Misc
		me["air-temp"].setText(roundToNearest(getprop("/fdm/jsbsim/propulsion/tat-c"),1) + "c");
		if (getprop("/it-autoflight/input/thrustStg") == "G/A" or getprop("/it-autoflight/input/thrustStg") == "TO") 
			me["flt-mode"].setText(sprintf("%s",getprop("/it-autoflight/input/thrustStg")));
		else
      		me["flt-mode"].setText(sprintf("%s","CRZ"));

		if (getprop("/surface-positions/flap-pos-norm[0]") <= 0.125){
			me["flap-dial"].setRotation(getprop("/surface-positions/flap-pos-norm[0]")*272*D2R);
		}else if (getprop("/surface-positions/flap-pos-norm[0]") <= 0.25){
			me["flap-dial"].setRotation(getprop("/surface-positions/flap-pos-norm[0]")*311.2*D2R);
		}else if (getprop("/surface-positions/flap-pos-norm[0]") <= 0.375){
			me["flap-dial"].setRotation(getprop("/surface-positions/flap-pos-norm[0]")*306.7*D2R);
		}else if (getprop("/surface-positions/flap-pos-norm[0]") <= 0.5){
			me["flap-dial"].setRotation(getprop("/surface-positions/flap-pos-norm[0]")*309*D2R);
		}else if (getprop("/surface-positions/flap-pos-norm[0]") <= 0.625){
			me["flap-dial"].setRotation(getprop("/surface-positions/flap-pos-norm[0]")*288*D2R);
		}else if (getprop("/surface-positions/flap-pos-norm[0]") <= 0.75){
			me["flap-dial"].setRotation(getprop("/surface-positions/flap-pos-norm[0]")*159.3*D2R);
		}else if (getprop("/surface-positions/flap-pos-norm[0]") <= 0.875){
			me["flap-dial"].setRotation(getprop("/surface-positions/flap-pos-norm[0]")*221.7*D2R);
		}else{
			me["flap-dial"].setRotation(getprop("/surface-positions/flap-pos-norm[0]")*270*D2R);
		}
	}
};




var init = func() {
	eicas = canvas.new({
		"name": "EICAS",
		"size": [692, 1024],
		"view": [692, 1024],
		"mipmapping": 1
	});
	
	eicas.addPlacement({"node": "capt.screenL"});
	
	var engGroup = display.createGroup();
	
	eng = canvasEng.new(engGroup, "Aircraft/MD-11/Nasal/Displays/res/ENG.svg");
	
	canvasBase.setup();
	update.start();
	
	if (pts.Systems.Acconfig.Options.Du.sdFps.getValue() != 10) {
		rateApply();
	}
}