# 737 MAX Lighting System
# Israel Emmanuel

var LIGHTS: {
    Active: {
        beaconUpper = props.globals.initNode("/systems/lighting/beacon-upper", 0, "BOOL"),
        beaconLower = props.globals.initNode("/systems/lighting/beacon-lower", 0, "BOOL"),
        strobeLeft = props.globals.initNode("/systems/lighting/strobe-left", 0, "BOOL"),
        strobeRight = props.globals.initNode("/systems/lighting/strobe-right", 0, "BOOL"),
        positionAft = props.globals.initNode("/systems/lighting/position-aft", 0, "BOOL"),
        positionLeft = props.globals.initNode("/systems/lighting/position-left", 0, "BOOL"),
        positionRight = props.globals.initNode("/systems/lighting/position-right", 0, "BOOL"),
    },
    init: func() {
        var beacon = aircraft.light.new( "/systems/lighting/beacon", [0,2, ], "/controls/lighting/beacon" );
        var strobe = aircraft.light.new( "/systems/lighting/strobe", [0,2, ], "/controls/lighting/strobe" );
    },
    Switch: {
        afdsFlood: props.globals.getNode("/controls/lighting/afds-flood"),
        antiCollision: props.globals.getNode("/controls/lighting/anti-collision"),
        background: props.globals.getNode("/controls/lighting/background"),
        breaker: props.globals.getNode("/controls/lighting/breaker"),
        du: [props.globals.getNode("/controls/lighting/du-1"), props.globals.getNode("/controls/lighting/du-2"), props.globals.getNode("/controls/lighting/du-3"), props.globals.getNode("/controls/lighting/du-4")],
        exit: props.globals.getNode("/controls/lighting/exit"),
        landing: [props.globals.getNode("/controls/lighting/landing-l"), props.globals.getNode("/controls/lighting/landing-r")],
        logo: props.globals.getNode("/controls/lighting/logo"),
        mainPanel: [props.globals.getNode("/controls/lighting/main-panel-capt"), props.globals.getNode("/controls/lighting/main-panel-fo")],
        ohPanel: props.globals.getNode("/controls/lighting/oh-panel"),
        position: props.globals.getNode("/controls/lighting/position"),
        rwyTurnoff: [props.globals.getNode("/controls/lighting/rwy-turnoff-l"), props.globals.getNode("/controls/lighting/rwy-turnoff-r")],
        wheelWell: props.globals.getNode("/controls/lighting/wheel-well"),
        wing: props.globals.getNode("/controls/lighting/wing"),
    },
};