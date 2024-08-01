# McDonnell Douglas MD-11 ISFD
# Copyright (c) 2024 Josh Davidson (Octal450)

var display = nil;
var isfd = nil;

var Value = {
	Ai: {
		center: nil,
		pitch: 0,
		roll: 0,
	},
	Alt: {
		indicated: 0,
		Tape: {
			eight: 0,
			eightT: "",
			five: 0,
			fiveT: "",
			four: 0,
			fourT: "",
			hundreds: 0,
			hundredsGeneva: 0,
			middleOffset: 0,
			middleText: 0,
			offset: 0,
			one: 0,
			oneT: "",
			seven: 0,
			sevenT: "",
			six: 0,
			sixT: "",
			tenThousands: 0,
			tenThousandsGeneva: 0,
			thousands: 0,
			thousandsGeneva: 0,
			three: 0,
			threeT: "",
			tens: 0,
			two: 0,
			twoT: "",
		},
	},
	Asi: {
		ias: 0,
		mach: 0,
		machLatch: 0,
		Tape: {
			ias: 0,
			tens: 0,
			tensGeneva: 0,
		},
	},
	Hdg: {
		indicated: 0,
		Tape: {
			leftText1: "0",
			leftText2: "0",
			leftText3: "0",
			leftText4: "0",
			middleOffset: 0,
			middleText: 0,
			offset: 0,
			rightText1: "0",
			rightText2: "0",
			rightText3: "0",
			rightText4: "0",
		},
	},
	Qnh: {
		inhg: 0,
	},
};

var canvasBase = {
	init: func(canvasGroup, file) {
		var font_mapper = func(family, weight) {
			return "BoeingCDU-Large.ttf";
		};
		
		canvas.parsesvg(canvasGroup, file, {"font-mapper": font_mapper});
		
		var svgKeys = me.getKeys();
		foreach(var key; svgKeys) {
			me[key] = canvasGroup.getElementById(key);
			
			
		}
		
		me.page = canvasGroup;
		
		return me;
	},
	getKeys: func() {
		return [];
	},
	setup: func() {
		# Hide the pages by default
		isfd.page.hide();
	},
	update: func() {
		if (systems.DUController.updateIsfd) {
			isfd.update();
		}
	},
};

var canvasIsfd = {
	new: func(canvasGroup, file) {
		var m = {parents: [canvasIsfd, canvasBase]};
		m.init(canvasGroup, file);
		
		return m;
	},
	update: func() {

	},
};

var init = func() {
	display = canvas.new({
		"name": "ISFD",
		"size": [512, 512],
		"view": [512, 512],
		"mipmapping": 1
	});
	
	display.addPlacement({"node": "isfd.screen"});
	
	var isfdGroup = display.createGroup();
	
	isfd = canvasIsfd.new(isfdGroup, "Aircraft/737-MAX/Nasal/Displays/res/ISFD.svg");
	
	canvasBase.setup();
	update.start();
	
	if (pts.Systems.Acconfig.Options.Du.isfdFps.getValue() != 10) {
		rateApply();
	}
}

var rateApply = func() {
	update.restart(1 / pts.Systems.Acconfig.Options.Du.isfdFps.getValue());
}

var update = maketimer(0.1, func() { # runs at 10FPS
	canvasBase.update();
});

var showIsfd = func() {
	var dlg = canvas.Window.new([256, 256], "dialog", nil, 0).set("resize", 1);
	dlg.setCanvas(display);
	dlg.set("title", "Integrated Standby Flight Display");
}

var roundAbout = func(x) {
	var y = x - int(x);
	return y < 0.5 ? int(x) : 1 + int(x);
}

var roundAboutAlt = func(x) { # For altitude tape numbers
	var y = x * 0.5 - int(x * 0.5);
	return y < 0.5 ? 2 * int(x * 0.5) : 2 + 2 * int(x * 0.5);
}

# Controls the geneva drive animation for the airspeed indicator
var genevaAsiHundreds = func(input) {
	var m = math.floor(input / 10);
	var s = math.max(0, (math.mod(input, 1) - 0.9) * 10);
	if (math.mod(input / 10, 1) < 0.9) s = 0;
	return m + s;
}

var genevaAsiTens = func(input) {
	var m = math.floor(input);
	var s = math.max(0, (math.mod(input, 1) - 0.9) * 10);
	return m + s;
}

# Controls the geneva drive animation for the altitude indicator
var genevaAltTenThousands = func(input) {
	var m = math.floor(input / 100);
	var s = math.max(0, (math.mod(input, 1) - 0.8) * 5);
	if (math.mod(input / 10, 1) < 0.9 or math.mod(input / 100, 1) < 0.9) s = 0;
	return m + s;
}

var genevaAltThousands = func(input) {
	var m = math.floor(input / 10);
	var s = math.max(0, (math.mod(input, 1) - 0.8) * 5);
	if (math.mod(input / 10, 1) < 0.9) s = 0;
	return m + s;
}

var genevaAltHundreds = func(input) {
	var m = math.floor(input);
	var s = math.max(0, (math.mod(input, 1) - 0.8) * 5);
	return m + s;
}