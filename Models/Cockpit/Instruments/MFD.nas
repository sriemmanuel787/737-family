print("Loading Multi-Function Display");
var mfd_canvas = nil;
var mfd_display = nil;

var canvas_mfd = {
	new: func(canvas_group) {
		var m = {parents: [canvas_mfd]};
		var mfd = canvas_group;
		var font_mapper = func(family, weight) {
			return "MFD-font.ttf";
		};
		
		canvas.parsesvg(mfd, "Aircraft/737-MAX/Models/Cockpit/Instruments/MFD.svg" , {'font-mapper': font_mapper});
		
		var svg_keys = ["fuel-flow-eng1", "thrust-eng1", "low-oil-pressure-eng1", "oil-filter-bypass-eng1", "start-valve-open-eng1", "fuel-flow-eng2", "thrust-eng2", "low-oil-pressure-eng2", "oil-filter-bypass-eng2", "start-valve-open-eng2", "flap-dial", "le-flaps-transit", "le-flaps-ext", "fuel-total", "fuel-left", "fuel-center", "fuel-right", "eng1-ff", "eng1-oil-press-readout", "eng1-oil-press", "eng1-oil-temp-readout", "eng1-oil-temp", "eng1-oil-qty", "eng1-vib-readout", "eng1-vib", "eng2-ff", "eng2-oil-press-readout", "eng2-oil-press", "eng2-oil-temp-readout", "eng2-oil-temp", "eng2-oil-qty", "eng2-vib-readout", "eng2-vib", "eng2-n2-grey2", "eng2-n2-grey1", "eng2-n2", "eng2-n2-readout", "eng1-n2-grey2", "eng1-n2-grey1", "eng1-n2", "eng1-n2-readout", "eng2-egt-grey2", "eng2-egt-grey1", "eng2-egt", "eng2-egt-readout", "eng1-egt-grey2", "eng1-egt-grey1", "eng1-egt", "eng1-egt-readout", "eng2-n1-grey2", "eng2-n1-grey1", "eng2-n1", "eng2-n1-limit", "eng2-n1-readout", "eng2-n1-limit-readout", "eng1-n1-grey2", "eng1-n1-grey1", "eng1-n1", "eng1-n1-limit", "eng1-n1-readout", "eng1-n1-limit-readout", "air-temperature", "flt-mode", "press-a", "qty-a", "press-b", "qty-b", "nlg", "mlg-l", "mlg-brake-l1", "mlg-brake-l2", "mlg-brakes-l", "mlg-r", "mlg-brake-r1", "mlg-brake-r2", "mlg-brakes-r", "srs-both", "srs-both-box", "srs-eng1-box", "srs-eng1", "srs-eng2-box", "srs,eng2", "srs-v1-box", "srs-v1", "srs-v2-box", "srs-v2", "srs-wtkgs-box", "srs-wtkgs", "srs-vref-box", "srs-vref", "srs-arrow-box", "srs-arrow", "srs-selected"];
		foreach(var key; svg_keys)
			m[key] = mfd.getElementById(key);

        m.timers=[];
		# Setting centers of elements outside the loop
		m["flap-dial"].setCenter("1026, 1169");

		return m;
	},

	update: func() {
		# Variables
		var eng1n1 = getprop("engines/engine[0]/n1");
		var eng2n1 = getprop("engines/engine[1]/n1");

        # Air Temperature, Flight Mode
		me["air-temperature"].setText(sprintf("%+i", getprop("environment/temperature-degc")));
		me["flt-mode"].setText(getprop("it-autoflight/input/thrustStg"));

		# Engine Warnings
		# Hide these by default, change later if functionality is implemented
		me["oil-filter-bypass-eng1"].hide();
		me["oil-filter-bypass-eng2"].hide();

		if(getprop("controls/engines/engine[0]/starter"))
			me["start-valve-open-eng1"].show();
		else
			me["start-valve-open-eng1"].hide();
		
		if(getprop("engines/engine[0]/oil-pressure-psi") < 20)
			me["low-oil-pressure-eng1"].show();
		else
			me["low-oil-pressure-eng1"].hide();

		if(getprop("controls/engines/engine[0]/throttle") > eng1n1)
			me["thrust-eng1"].show();
		else
			me["thrust-eng1"].hide();

		if((getprop("engines/engine[0]/fuel-flow_pph")/eng1n1) >100)
			me["fuel-flow-eng1"].show();
		else
			me["fuel-flow-eng1"].hide();

		if(getprop("controls/engines/engine[1]/starter"))
			me["start-valve-open-eng2"].show();
		else
			me["start-valve-open-eng2"].hide();
		
		if(getprop("engines/engine[1]/oil-pressure-psi") < 20)
			me["low-oil-pressure-eng2"].show();
		else
			me["low-oil-pressure-eng2"].hide();

		if(getprop("controls/engines/engine[1]/throttle") > getprop("engines/engine[1]/n1"))
			me["thrust-eng2"].show();
		else
			me["thrust-eng2"].hide();

		if((getprop("engines/engine[1]/fuel-flow_pph")/eng1n1) >100)
			me["fuel-flow-eng2"].show();
		else
			me["fuel-flow-eng2"].hide();

		# Flap Dial
		# me["flap-dial"].setRotation();
	},
};

setlistener("sim/signals/fdm-initialized", func() {
	mfd_display = canvas.new({
		"name": "MFD",
		"size": [8192, 8192],
		"view": [4096, 2048],
		"mipmapping": 1
	});
	mfd_display.addPlacement({"node": "screen.mfd-capt"});
	var group = mfd_display.createGroup();
	mfd_canvas = canvas_mfd.new(group);
	update_timer = maketimer(0.1, func mfd_canvas.update());
 	update_timer.start();
 	mfd_canvas.update();
}, 0, 0);