# Terrain Sampler

var terr = props.globals.initNode("instrumentation/terrain/type", "", "STRING");
var streak = [props.globals.initNode("instrumentation/terrain/red", 0.0, "DOUBLE"), props.globals.initNode("instrumentation/terrain/green", 0.0, "DOUBLE"), props.globals.initNode("instrumentation/terrain/blue", 0.0, "DOUBLE"), props.globals.initNode("instrumentation/terrain/alpha", 1.0, "DOUBLE")];
latDeg = props.globals.getNode("position/latitude-deg");
longDeg = props.globals.getNode("position/longitude-deg");
season = props.globals.getNode("sim/startup/season");

var terrUpdate = func {
    var info = geodinfo(latDeg.getValue(), longDeg.getValue());
    var ground = info[1].names;
    var region = info[1].region;
    terr.setValue(ground[0]);
    if (ground[0] == "BuiltUpCover" or ground[0] == "Town" or ground[0] == "Freeway" or ground[0] == "pa_taxiway" or ground[0] == "pa_tiedown" or ground[0] == "pc_taxiway" or ground[0] == "pc_tiedown") {
        streak[3].setValue(0);
    } elsif (season.getValue() == "winter") {
        streak[0].setValue(1);
        streak[1].setValue(1);
        streak[2].setValue(1);
    } elsif (region == "African desert") {
        if(ground[0] == "Grass") {
            streak[0].setValue(189/255);
            streak[1].setValue(179/255);
            streak[2].setValue(146/255);
        } elsif (ground[0] == "DryLake") {
            streak[0].setValue(146/255);
            streak[1].setValue(146/255);
            streak[2].setValue(128/255);
        } elsif (ground[0] == "Landmass") {
            streak[0].setValue(168/255);
            streak[1].setValue(163/255);
            streak[2].setValue(135/255);
        } elsif (ground[0] == "Lava") {
            streak[0].setValue(96/255);
            streak[1].setValue(73/255);
            streak[2].setValue(52/255);
        } elsif (ground[0] == "BarrenCover") {
            streak[0].setValue(142/255);
            streak[1].setValue(120/255);
            streak[2].setValue(102/255);
        } elsif (ground[0] == "EvergreenBroadCover") {
            streak[0].setValue(200/255);
            streak[1].setValue(184/255);
            streak[2].setValue(158/255);
        } elsif (ground[0] == "DryCropPastureCover" or ground[0] == "IrrCropPastureCover" or ground[0] == "GrassCover") {
            streak[0].setValue(82/255);
            streak[1].setValue(67/255);
            streak[2].setValue(45/255);
        }
    }
    
};

var timer = maketimer(0.1, terrUpdate);
timer.simulatedTime = 1;
timer.start();