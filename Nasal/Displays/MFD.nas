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
		
		canvas.parsesvg(mfd, "Aircraft/737-family/Nasal/Displays/res/MFD.svg" , {'font-mapper': font_mapper});
		
		var svg_keys = ["Add SVG elements here"];
		foreach(var key; svg_keys)
			m[key] = mfd.getElementById(key);

        m.timers=[];

		return m;
	},

	update: func() {
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