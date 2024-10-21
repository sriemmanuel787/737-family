# Boeing 737 MAX Main Libraries

print(" ______ ____ ______      __  __          __   __");
print("|____  |___ \____  |    |  \/  |   /\    \ \ / /");
print("    / /  __) |  / /_____| \  / |  /  \    \ V / ");
print("   / /  |__ <  / /______| |\/| | / /\ \    > <    the");
print("  / /   ___) |/ /       | |  | |/ ____ \  / . \   random");
print(" /_/   |____//_/        |_|  |_/_/    \_\/_/ \_\\  developers");
print("the random developers");

setprop("/sim/menubar/default/menu[0]/item[0]/enabled", 0);
setprop("/sim/menubar/default/menu[2]/item[0]/enabled", 0);
setprop("/sim/menubar/default/menu[2]/item[2]/enabled", 0);
setprop("/sim/menubar/default/menu[5]/item[8]/enabled", 0);
setprop("/sim/menubar/default/menu[5]/item[9]/enabled", 0);
setprop("/sim/menubar/default/menu[5]/item[10]/enabled", 0);
setprop("/sim/menubar/default/menu[5]/item[11]/enabled", 0);
setprop("/sim/multiplay/visibility-range-nm", 130);

var initDone = 0;
var systemsInit = func() {
	systems.ELEC.init();
	systems.FUEL.init();
	systems.HYD.init();
	systems.PNEU.init();
	if (initDone) { # Anytime after sim init
		# Figure out what goes here
	} else { # Sim init
		# And here as well
	}
}

var fdmInit = setlistener("/sim/signals/fdm-initialized", func() {
	acconfig.SYSTEM.fdmInit();
	systemsInit();
	systemsLoop.start();
	slowLoop.start();
	lightsLoop.start();
	canvas_isfd.init();
	canvas_mfd.init();
	canvas_nd.init();
	canvas_pfd.init();
	removelistener(fdmInit);
	initDone = 1;
	acconfig.SYSTEM.finalInit();
});

var systemsLoop = maketimer(0.1, func() {
	fms.CORE.loop();
	mcdu.BASE.loop();
	systems.FADEC.loop();
	systems.DUController.loop();
	SHAKE.loop();
	
	if (pts.Sim.Replay.replayState.getBoolValue()) {
		pts.Controls.Flight.wingflexEnable.setBoolValue(0);
	} else {
		pts.Controls.Flight.wingflexEnable.setBoolValue(1);
	}
	
	pts.Services.Chocks.enableTemp = pts.Services.Chocks.enable.getBoolValue();
	pts.Velocities.groundspeedKtTemp = pts.Velocities.groundspeedKt.getValue();
	if ((pts.Velocities.groundspeedKtTemp >= 2 or !pts.Fdm.JSBSim.Position.wow.getBoolValue()) and pts.Services.Chocks.enableTemp) {
		pts.Services.Chocks.enable.setBoolValue(0);
	}
	
	if ((pts.Velocities.groundspeedKtTemp >= 2 or (!systems.GEAR.Switch.brakeParking.getBoolValue() and !pts.Services.Chocks.enableTemp)) and !acconfig.SYSTEM.autoConfigRunning.getBoolValue()) {
		if (systems.ELEC.Switch.groundCart.getBoolValue() or systems.ELEC.Switch.extPwr.getBoolValue() or systems.ELEC.Switch.extGPwr.getBoolValue()) {
			systems.ELEC.Switch.groundCart.setBoolValue(0);
			systems.ELEC.Switch.extPwr.setBoolValue(0);
			systems.ELEC.Switch.extGPwr.setBoolValue(0);
		}
		if (systems.PNEU.Switch.groundAir.getBoolValue()) {
			systems.PNEU.Switch.groundAir.setBoolValue(0);
		}
	}
});

var slowLoop = maketimer(1, func() {
	if (acconfig.SYSTEM.Error.active.getBoolValue()) {
		systemsInit();
	}
});

setlistener("/fdm/jsbsim/position/wow", func() {
	if (initDone) {
		instruments.XPDR.airGround();
	}
}, 0, 0);

# Temporary until proper systems are available
var doMagicStartup = func {
    # systems.FUEL.Switch.pump1Aft.setBoolValue(1);
    # systems.FUEL.Switch.pump1Fwd.setBoolValue(1);
    # systems.FUEL.Switch.pump2LAft.setBoolValue(1);
    # systems.FUEL.Switch.pump2RAft.setBoolValue(1);
    # systems.FUEL.Switch.pump2Fwd.setBoolValue(1);
    settimer(func {
        setprop("/controls/electrical/switches/gen-1", 1);
        setprop("/controls/electrical/switches/gen-2", 1);
        setprop("/controls/hydraulics/switches/l-pump-1", 1);
        setprop("/controls/hydraulics/switches/l-pump-2", 1);
        setprop("/controls/hydraulics/switches/r-pump-1", 1);
        setprop("/controls/hydraulics/switches/r-pump-2", 1);
        setprop("/controls/engines/engine[0]/cutoff", 0);
        setprop("/controls/engines/engine[0]/cutoff-switch", 0);
        setprop("/controls/engines/engine[1]/cutoff", 0);
        setprop("/controls/engines/engine[1]/cutoff-switch", 0);
        setprop("/fdm/jsbsim/propulsion/set-running", 0);
        setprop("/fdm/jsbsim/propulsion/set-running", 1);
        # setprop("/engines/engine[0]/state", 3);
        # setprop("/engines/engine[1]/state", 3);
    }, 0.5);
}

var doorLF = aircraft.door.new("/systems/doors/left-fwd", 6);
var doorLA = aircraft.door.new("/systems/doors/left-aft", 6);
var doorRF = aircraft.door.new("/systems/doors/right-fwd", 6);
var doorRA = aircraft.door.new("/systems/doors/right-aft", 6);
var cargoF = aircraft.door.new("/systems/doors/cargo-fwd", 6);
var cargoA = aircraft.door.new("/systems/doors/cargo-aft", 6);

var systems_started = 0;
setlistener("sim/signals/fdm-initialized", func {	
        if (systems_started == 1) return;
        systems_started = 1;
	systems.elec_init();
	systems.hyd_init();
}, 0, 0);
	
var timerstall = maketimer(5, func(){

	
	var alt_agl = getprop("position/altitude-agl-ft") - 6.5; # get altitude above ground
	var curspd = getprop("velocities/airspeed-kt"); # get IAS
	var getstallspd = getprop("instrumentation/weu/state/stall-speed"); # get stall speed
	
	if (alt_agl > 8 and curspd < getstallspd) { # if we are off the ground and if speed is less than stall speed
		setprop("b737/sound/stall",1); # turn on the stall sound
		}
});
timerstall.start(); # begin the timer
setprop("b737/sound/stall",0);

## SOUNDS
#########

# seatbelt/no smoking sign triggers
setlistener("controls/switches/seatbelt-sign", func {
	props.globals.getNode("sim/sound/seatbelt-sign").setBoolValue(1);
	settimer(func {
		props.globals.getNode("sim/sound/seatbelt-sign").setBoolValue(0);
	}, 2);
}, 0, 0);
setlistener("controls/switches/no-smoking-sign", func {
	props.globals.getNode("sim/sound/no-smoking-sign").setBoolValue(1);
	settimer(func {
		props.globals.getNode("sim/sound/no-smoking-sign").setBoolValue(0);
	}, 2);
}, 0, 0);

setlistener("controls/switches/switch", func {
	if(!getprop("controls/switches/switch")) return;
 	settimer(func {
		props.globals.getNode("controls/switches/switch").setBoolValue(0);
 	}, 0.1);
}, 0, 0);

setlistener("controls/doors/cockpitdoor/sound", func {
	if(!getprop("controls/doors/cockpitdoor/sound")) return;
 	settimer(func {
  		props.globals.getNode("controls/doors/cockpitdoor/sound").setBoolValue(0);
 	}, 3);
}, 0, 0);

setlistener("controls/lighting/landing-lights", func {
	if(getprop("controls/lighting/landing-lights")) setprop("controls/lighting/landing-lights-norm",1); else setprop("controls/lighting/landing-lights-norm",0);
}, 0, 0);

# selected engine system
props.globals.initNode("sim/input/selected/SelectedEngine73X", 0, "INT");
setlistener("sim/input/selected/SelectedEngine73X", func {
	a = getprop("sim/input/selected/SelectedEngine73X");
	if (a == 0) {
		setprop("sim/input/selected/engine", 1);
		setprop("sim/input/selected/engine[1]", 1);
	} else if(a == 1) {
		setprop("sim/input/selected/engine", 0);
		setprop("sim/input/selected/engine[1]", 1);

	} else if(a == -1) {
		setprop("sim/input/selected/engine", 1);
		setprop("sim/input/selected/engine[1]", 0);
	}
}, 0, 0);
