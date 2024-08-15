#737 MAX Property Tree Setup
#Israel Emmanuel (sriemmanuel787)

var Consumables = {
    Fuel:{
        tankRight:  props.globals.getNode("consumables/fuel/tank[0]/level-kg"),
        tankLeft:   props.globals.getNode("consumables/fuel/tank[1]/level-kg"),
        tankCenter: props.globals.getNode("consumables/fuel/tank[2]/level-kg"),
    }
};

var Gear = {
	rollspeedMs: [props.globals.getNode("/gear/gear[0]/rollspeed-ms"), props.globals.getNode("/gear/gear[1]/rollspeed-ms"), props.globals.getNode("/gear/gear[2]/rollspeed-ms")],
	wow: [props.globals.getNode("/gear/gear[0]/wow"), props.globals.getNode("/gear/gear[1]/wow"), props.globals.getNode("/gear/gear[2]/wow")],
};

var Sim = {
	Model: {
		airlineCode:  props.globals.getNode("sim/model/airline-code"),
		registration: props.globals.getNode("sim/model/registration"),
		selcal:       props.globals.getNode("sim/model/selcal"),
	}
	Time: {
		day:         props.globals.getNode("sim/time/utc/day"),
		month:       props.globals.getNode("sim/time/utc/month"),
		timeElapsed: props.globals.getNode("sim/time/elapsed-sec"),
		timeUTC:     props.globals.getNode("sim/time/gmt-string"),
		year:        props.globals.getNode("sim/time/utc/year"),
	}
};

var Systems = {
	Acconfig: {
		Options: {
			deflectedAileronEquipped: props.globals.getNode("/systems/acconfig/options/deflected-aileron-equipped"),
			Du: {
				captPfdFps: props.globals.getNode("/systems/acconfig/options/du/capt-pfd-fps"),
				captMfdFps: props.globals.getNode("/systems/acconfig/options/du/capt-mfd-fps"),
				foPfdFps: props.globals.getNode("/systems/acconfig/options/du/fo-pfd-fps"),
				foMfdFps: props.globals.getNode("/systems/acconfig/options/du/fo-mfd-fps"),
				isfdFps: props.globals.getNode("/systems/acconfig/options/du/isfd-fps"),
			},
			# These settings are custom to the MD-11
			# TODO: #39 I need to adjust these to the 737 MAX
			# egtAboveN1: props.globals.getNode("/systems/acconfig/options/egt-above-n1"),
			# engTapes: props.globals.getNode("/systems/acconfig/options/eng-tapes"),
			# iesiEquipped: props.globals.getNode("/systems/acconfig/options/iesi-equipped"),
			# risingRunwayTBar: props.globals.getNode("/systems/acconfig/options/rising-runway-t-bar"),
			# singleCueFd: props.globals.getNode("/systems/acconfig/options/single-cue-fd"),
		}
	},
	Shake: {
		effect: props.globals.getNode("/systems/shake/effect"),
		shaking: props.globals.getNode("/systems/shake/shaking"),
	},
};