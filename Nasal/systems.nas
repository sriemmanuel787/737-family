# Boeing 737 MAX Main Libraries

print(" ______ ____ ______      __  __          __   __");
print("|____  |___ \____  |    |  \/  |   /\    \ \ / /");
print("    / /  __) |  / /_____| \  / |  /  \    \ V / ");
print("   / /  |__ <  / /______| |\/| | / /\ \    > <  ");
print("  / /   ___) |/ /       | |  | |/ ____ \  / . \ ");
print(" /_/   |____//_/        |_|  |_/_/    \_\/_/ \_\\");
print("the random developers");

setprop("/sim/menubar/default/menu[0]/item[0]/enabled", 0);
setprop("/sim/menubar/default/menu[2]/item[0]/enabled", 0);
setprop("/sim/menubar/default/menu[2]/item[2]/enabled", 0);
setprop("/sim/menubar/default/menu[5]/item[8]/enabled", 0);
setprop("/sim/menubar/default/menu[5]/item[9]/enabled", 0);
setprop("/sim/menubar/default/menu[5]/item[10]/enabled", 0);
setprop("/sim/menubar/default/menu[5]/item[11]/enabled", 0);
setprop("/sim/multiplay/visibility-range-nm", 130);

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

var altAlertModeSwitch = func {
	var warning_b = getprop("b737/warnings/altitude-alert-b-conditions");
	var diff_0 = getprop("b737/helpers/alt-diff-ft[0]");
	var diff_1 = getprop("b737/helpers/alt-diff-ft[1]");

	if (warning_b) {
		var diff = diff_1;
	} else {
		var diff = diff_0;
	}

	if (diff < 600) {
		setprop("b737/warnings/altitude-alert-mode", 1);
	} else {
		setprop("b737/warnings/altitude-alert-mode", 0);
	}
}
setlistener( "/b737/warnings/altitude-alert", altAlertModeSwitch, 0, 0);

setprop("controls/lighting/AFDSbrt","0");

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
