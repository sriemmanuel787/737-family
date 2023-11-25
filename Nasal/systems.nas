# B737-MAX Systems File

print(" ______ ____ ______      __  __          __   __");
print("|____  |___ \____  |    |  \/  |   /\    \ \ / /");
print("    / /  __) |  / /_____| \  / |  /  \    \ V / ");
print("   / /  |__ <  / /______| |\/| | / /\ \    > <  ");
print("  / /   ___) |/ /       | |  | |/ ____ \  / . \ ");
print(" /_/   |____//_/        |_|  |_/_/    \_\/_/ \_\\");
print("-----------------------------------------------------------------------");
print("Gabriel Hernandez (YV3399), Joshua Davidson (Octal450), Israel Emmanuel (sriemmanuel787)");
print("Report all bugs on GitHub Issues tab, or on the FlightGear Discord server.");
print("Enjoy your flight!!!");
print("-----------------------------------------------------------------------");
print(" ");

setprop("instrumentation/attitude-indicator/spin", 1);
setprop("options/OHPtemp", 1);

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
	boeing737.shaketimer.start();
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
