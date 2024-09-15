# Boeing 737 MAX PFD

var pfd1 = nil;
var pfd1Display = nil;
var pfd1Error = nil;
var pfd2 = nil;
var pfd2Display = nil;
var pfd2Error = nil;

var canvasBase = {
	init: func(canvasGroup, file) {
		var font_mapper = func(family, weight) {
			return "DULarge.ttf";
		};
		
		canvas.parsesvg(canvasGroup, file, {"font-mapper": font_mapper});
		
		var svgKeys = me.getKeys();
		foreach(var key; svgKeys) {
			me[key] = canvasGroup.getElementById(key);
			
			var clip_el = canvasGroup.getElementById(key ~ "_clip");
			if (clip_el != nil) {
				clip_el.setVisible(0);
				var tranRect = clip_el.getTransformedBounds();
				
				var clip_rect = sprintf("rect(%d, %d, %d, %d)", 
					tranRect[1], # 0 ys
					tranRect[2], # 1 xe
					tranRect[3], # 2 ye
					tranRect[0] # 3 xs
				);
				
				# Coordinates are top, right, bottom, left (ys, xe, ye, xs) ref: l621 of simgear/canvas/CanvasElement.cxx
				me[key].set("clip", clip_rect);
				me[key].set("clip-frame", canvas.Element.PARENT);
			}
		}
		
		Value.Ai.center = me["AI_center"].getCenter();
		
		me.aiBackgroundTrans = me["AI_background"].createTransform();
		me.aiBackgroundRot = me["AI_background"].createTransform();
		
		me.aiScaleTrans = me["AI_scale"].createTransform();
		me.aiScaleRot = me["AI_scale"].createTransform();
		
		me.fpdTrans = me["FPD"].createTransform();
		me.fpdRot = me["FPD"].createTransform();
		
		me.fpvTrans = me["FPV"].createTransform();
		me.fpvRot = me["FPV"].createTransform();
		
		me.fdVTrans = me["FD_v"].createTransform();
		me.fdVRot = me["FD_v"].createTransform();
		
		me.page = canvasGroup;
		
		return me;
	},
	getKeys: func() {
		return [];
	},
	setup: func() {
		# Hide the pages by default
		pfd1.page.hide();
		pfd1.setup();
		pfd1Error.page.hide();
		pfd2.page.hide();
		pfd2.setup();
		pfd2Error.page.hide();
	},
	update: func() {
		if (systems.DUController.updatePfd1) {
			pfd1.update();
		}
		if (systems.DUController.updatePfd2) {
			pfd2.update();
		}
	},
	updateBase: func(n) {
	},
};

var canvasPfd1 = {
	new: func(canvasGroup, file) {
		var m = {parents: [canvasPfd1, canvasBase]};
		m.init(canvasGroup, file);
		
		return m;
	},
	setup: func() {
		# Hide unimplemented objects
		me["ALT_fms"].hide();
		me["ALT_fms_dn"].hide();
		me["ALT_fms_up"].hide();
	},
	update: func() {
		me.updateBase(0);
	},
};

var canvasPfd2 = {
	new: func(canvasGroup, file) {
		var m = {parents: [canvasPfd2, canvasBase]};
		m.init(canvasGroup, file);
		
		return m;
	},
	setup: func() {
		# Hide unimplemented objects
		me["ALT_fms"].hide();
		me["ALT_fms_dn"].hide();
		me["ALT_fms_up"].hide();
	},
	update: func() {		
		me.updateBase(1);
	},
};

var canvasPfd1Error = {
	init: func(canvasGroup, file) {
		var font_mapper = func(family, weight) {
			return "LiberationFonts/LiberationSans-Regular.ttf";
		};
		
		canvas.parsesvg(canvasGroup, file, {"font-mapper": font_mapper});
		me.page = canvasGroup;
		
		return me;
	},
	new: func(canvasGroup, file) {
		var m = {parents: [canvasPfd1Error]};
		m.init(canvasGroup, file);
		
		return m;
	},
};

var canvasPfd2Error = {
	init: func(canvasGroup, file) {
		var font_mapper = func(family, weight) {
			return "LiberationFonts/LiberationSans-Regular.ttf";
		};
		
		canvas.parsesvg(canvasGroup, file, {"font-mapper": font_mapper});
		me.page = canvasGroup;
		
		return me;
	},
	new: func(canvasGroup, file) {
		var m = {parents: [canvasPfd2Error]};
		m.init(canvasGroup, file);
		
		return m;
	},
};

var init = func() {
	pfd1Display = canvas.new({
		"name": "PFD1",
		"size": [1024, 1024],
		"view": [1024, 1024],
		"mipmapping": 1
	});
	pfd2Display = canvas.new({
		"name": "PFD2",
		"size": [1024, 1024],
		"view": [1024, 1024],
		"mipmapping": 1
	});
	
	pfd1Display.addPlacement({"node": "pfd1.screen"});
	pfd2Display.addPlacement({"node": "pfd2.screen"});
	
	var pfd1Group = pfd1Display.createGroup();
	var pfd1ErrorGroup = pfd1Display.createGroup();
	var pfd2Group = pfd2Display.createGroup();
	var pfd2ErrorGroup = pfd2Display.createGroup();
	
	pfd1 = canvasPfd1.new(pfd1Group, "Aircraft/737-MAX/Nasal/Displays/res/PFD.svg");
	pfd1Error = canvasPfd1Error.new(pfd1ErrorGroup, "Aircraft/737-MAX/Nasal/Displays/res/Error.svg");
	pfd2 = canvasPfd2.new(pfd2Group, "Aircraft/737-MAX/Nasal/Displays/res/PFD.svg");
	pfd2Error = canvasPfd2Error.new(pfd2ErrorGroup, "Aircraft/737-MAX/Nasal/Displays/res/Error.svg");
	
	canvasBase.setup();
	update.start();
	
	if (pts.Systems.Acconfig.Options.Du.pfdFps.getValue() != 20) {
		rateApply();
	}
}

var rateApply = func() {
	update.restart(1 / pts.Systems.Acconfig.Options.Du.pfdFps.getValue());
}

var update = maketimer(0.05, func() { # 20FPS
	canvasBase.update();
});

var showPfd1 = func() {
	var dlg = canvas.Window.new([512, 512], "dialog", nil, 0).set("resize", 1);
	dlg.setCanvas(pfd1Display);
	dlg.set("title", "Captain's PFD");
}

var showPfd2 = func() {
	var dlg = canvas.Window.new([512, 512], "dialog", nil, 0).set("resize", 1);
	dlg.setCanvas(pfd2Display);
	dlg.set("title", "First Officer's PFD");
}