var terr = props.globals.initNode("instrumentation/terrain-type", "", "STRING");
latDeg = props.globals.getNode("/position/latitude-deg");
longDeg = props.globals.getNode("/position/longitude-deg");

var terrUpdate = func{
    terr.setValue(geodinfo(latDeg.getValue(), longDeg.getValue())[1].names[0]);
};

var timer = maketimer(0.1, terrUpdate);
timer.simulatedTime = 1;
timer.start();