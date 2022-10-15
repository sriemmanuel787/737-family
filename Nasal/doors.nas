#Doors By RenanMsV and Gabriel Hernande(YV3399)

# cockpit
var cockpitdoor = aircraft.door.new("/controls/doors/cockpitdoor/", 3);
props.globals.initNode("controls/doors/cockpitdoor/opened",0);
props.globals.initNode("controls/doors/cockpitdoor/state",0);
props.globals.getNode("controls/doors/cockpitdoor/opened").setBoolValue(0);

var cockpitdoortoggle = func {
	if(getprop("controls/doors/cockpitdoor/state") == 1) return;
	setprop("/controls/doors/cockpitdoor/state",1);
	props.globals.getNode("controls/doors/cockpitdoor/sound").setBoolValue(1);
	if(!getprop("controls/doors/cockpitdoor/opened")){
		# closed, please open
		cockpitdoor.move(1);
		settimer(
			func{
				props.globals.getNode("controls/doors/cockpitdoor/opened").setBoolValue(1);
				setprop("/controls/doors/cockpitdoor/state",0);
			}
		,3);
	} else {
		# opened, please close
		cockpitdoor.move(0);
		settimer(
			func{
				props.globals.getNode("controls/doors/cockpitdoor/opened").setBoolValue(0);
				setprop("/controls/doors/cockpitdoor/state",0);
			}
		,3);
	}
}

# left front LF
var doorLF1 = aircraft.door.new("/controls/doors/LFDoor/LFDoorPos1",1);
var doorLF2 = aircraft.door.new("/controls/doors/LFDoor/LFDoorPos2",2);
props.globals.initNode("controls/doors/LFDoor/opened",0);
props.globals.initNode("controls/doors/LFDoor/state",0);
props.globals.getNode("controls/doors/LFDoor/opened").setBoolValue(0);

var doorLFtoggle = func {
	if(getprop("controls/doors/LFDoor/state") == 1) return;
	setprop("/controls/doors/LFDoor/state",1);
	props.globals.getNode("controls/doors/cockpitdoor/sound").setBoolValue(1);
	if (!getprop("controls/doors/LFDoor/opened")){
		# closed, please open
		doorLF1.move(1);
		settimer(
			func{
				doorLF2.move(1);
			}
		,1);
		settimer(
			func{
				props.globals.getNode("controls/doors/LFDoor/opened").setBoolValue(1);
				setprop("/controls/doors/LFDoor/state",0);
			}
		,3);	
	} else {
		# opened, please close
		doorLF2.move(0);
		settimer(
			func{
				doorLF1.move(0);
			}
		,2);
		settimer(
			func{
				props.globals.getNode("controls/doors/LFDoor/opened").setBoolValue(0);
				setprop("/controls/doors/LFDoor/state",0);
			}
		,3);	
	}
}

# left rear LR

var doorLR1 = aircraft.door.new("/controls/doors/LRDoor/LRDoorPos1",1);
var doorLR2 = aircraft.door.new("/controls/doors/LRDoor/LRDoorPos2",2);
props.globals.initNode("controls/doors/LRDoor/opened",0);
props.globals.initNode("controls/doors/LRDoor/state",0);
props.globals.getNode("controls/doors/LRDoor/opened").setBoolValue(0);

var doorLRtoggle = func {
	if(getprop("controls/doors/LRDoor/state") == 1) return;
	setprop("/controls/doors/LRDoor/state",1);
	props.globals.getNode("controls/doors/cockpitdoor/sound").setBoolValue(1);
	if (!getprop("controls/doors/LRDoor/opened")){
		# closed, please open
		doorLR1.move(1);
		settimer(
			func{
				doorLR2.move(1);
			}
		,1);
		settimer(
			func{
				props.globals.getNode("controls/doors/LRDoor/opened").setBoolValue(1);
				setprop("/controls/doors/LRDoor/state",0);
			}
		,3);	
	} else {
		# opened, please close
		doorLR2.move(0);
		settimer(
			func{
				doorLR1.move(0);
			}
		,2);
		settimer(
			func{
				props.globals.getNode("controls/doors/LRDoor/opened").setBoolValue(0);
				setprop("/controls/doors/LRDoor/state",0);
			}
		,3);	
	}
}

# right front RF

var doorRF1 = aircraft.door.new("/controls/doors/RFDoor/RFDoorPos1",1);
var doorRF2 = aircraft.door.new("/controls/doors/RFDoor/RFDoorPos2",2);
props.globals.initNode("controls/doors/RFDoor/opened",0);
props.globals.initNode("controls/doors/RFDoor/state",0);
props.globals.getNode("controls/doors/RFDoor/opened").setBoolValue(0);

var doorRFtoggle = func {
	if(getprop("controls/doors/RFDoor/state") == 1) return;
	setprop("/controls/doors/RFDoor/state",1);
	props.globals.getNode("controls/doors/cockpitdoor/sound").setBoolValue(1);
	if (!getprop("controls/doors/RFDoor/opened")){
		# closed, please open
		doorRF1.move(1);
		settimer(
			func{
				doorRF2.move(1);
			}
		,1);
		settimer(
			func{
				props.globals.getNode("controls/doors/RFDoor/opened").setBoolValue(1);
				setprop("/controls/doors/RFDoor/state",0);
			}
		,3);	
	} else {
		# opened, please close
		doorRF2.move(0);
		settimer(
			func{
				doorRF1.move(0);
			}
		,2);
		settimer(
			func{
				props.globals.getNode("controls/doors/RFDoor/opened").setBoolValue(0);
				setprop("/controls/doors/RFDoor/state",0);
			}
		,3);	
	}
}

# right rear RR

var doorRR1 = aircraft.door.new("/controls/doors/RRDoor/RRDoorPos1",1);
var doorRR2 = aircraft.door.new("/controls/doors/RRDoor/RRDoorPos2",2);
props.globals.initNode("controls/doors/RRDoor/opened",0);
props.globals.initNode("controls/doors/RRDoor/state",0);
props.globals.getNode("controls/doors/RRDoor/opened").setBoolValue(0);

var doorRRtoggle = func {
	if(getprop("controls/doors/RRDoor/state") == 1) return;
	setprop("/controls/doors/RRDoor/state",1);
	props.globals.getNode("controls/doors/cockpitdoor/sound").setBoolValue(1);
	if (!getprop("controls/doors/RRDoor/opened")){
		# closed, please open
		doorRR1.move(1);
		settimer(
			func{
				doorRR2.move(1);
			}
		,1);
		settimer(
			func{
				props.globals.getNode("controls/doors/RRDoor/opened").setBoolValue(1);
				setprop("/controls/doors/RRDoor/state",0);
			}
		,3);	
	} else {
		# opened, please close
		doorRR2.move(0);
		settimer(
			func{
				doorRR1.move(0);
			}
		,2);
		settimer(
			func{
				props.globals.getNode("controls/doors/RRDoor/opened").setBoolValue(0);
				setprop("/controls/doors/RRDoor/state",0);
			}
		,3);	
	}
}

# cargo front CF

var doorCF1 = aircraft.door.new("/controls/doors/CFDoor/CFDoorPos1",1);
var doorCF2 = aircraft.door.new("/controls/doors/CFDoor/CFDoorPos2",2);
props.globals.initNode("controls/doors/CFDoor/opened",0);
props.globals.initNode("controls/doors/CFDoor/state",0);
props.globals.getNode("controls/doors/CFDoor/opened").setBoolValue(0);

var doorCFtoggle = func {
	if(getprop("controls/doors/CFDoor/state") == 1) return;
	setprop("/controls/doors/CFDoor/state",1);
	if (!getprop("controls/doors/CFDoor/opened")){
		# closed, please open
		doorCF1.move(1);
		settimer(
			func{
				doorCF2.move(1);
			}
		,1);
		settimer(
			func{
				props.globals.getNode("controls/doors/CFDoor/opened").setBoolValue(1);
				setprop("/controls/doors/CFDoor/state",0);
			}
		,3);	
	} else {
		# opened, please close
		doorCF2.move(0);
		settimer(
			func{
				doorCF1.move(0);
			}
		,2);
		settimer(
			func{
				props.globals.getNode("controls/doors/CFDoor/opened").setBoolValue(0);
				setprop("/controls/doors/CFDoor/state",0);
			}
		,3);	
	}
}

# cargo rear CR

var doorCR1 = aircraft.door.new("/controls/doors/CRDoor/CRDoorPos1",1);
var doorCR2 = aircraft.door.new("/controls/doors/CRDoor/CRDoorPos2",2);
props.globals.initNode("controls/doors/CRDoor/opened",0);
props.globals.initNode("controls/doors/CRDoor/state",0);
props.globals.getNode("controls/doors/CRDoor/opened").setBoolValue(0);

var doorCRtoggle = func {
	if(getprop("controls/doors/CRDoor/state") == 1) return;
	setprop("/controls/doors/CRDoor/state",1);
	if (!getprop("controls/doors/CRDoor/opened")){
		# closed, please open
		doorCR1.move(1);
		settimer(
			func{
				doorCR2.move(1);
			}
		,1);
		settimer(
			func{
				props.globals.getNode("controls/doors/CRDoor/opened").setBoolValue(1);
				setprop("/controls/doors/CRDoor/state",0);
			}
		,3);	
	} else {
		# opened, please close
		doorCR2.move(0);
		settimer(
			func{
				doorCR1.move(0);
			}
		,2);
		settimer(
			func{
				props.globals.getNode("controls/doors/CRDoor/opened").setBoolValue(0);
				setprop("/controls/doors/CRDoor/state",0);
			}
		,3);	
	}
}
