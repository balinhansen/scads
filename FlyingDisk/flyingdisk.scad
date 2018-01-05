difference(){
    
    cylinder(0.4,50,50,$fn=240);
    translate([0,0,-0.001])
    cylinder(0.402,30,30,$fn=240);
    
    translate([0,0,-0.001])
    difference(){
        cylinder(0.201,45,45,$fn=240);
        translate([0,0,-0.001])
        cylinder(0.203,35,35,$fn=240);
    }
}

translate([0,0,0.4-0.001])
difference(){
    cylinder(0.101,47.5,47.5,$fn=240);
    translate([0,0,-0.001])
    cylinder(0.103,32.5,32.5,$fn=240);
}


translate([0,0,0.5-0.001])
difference(){
    cylinder(0.101,45,45,$fn=240);
    translate([0,0,-0.001])
    cylinder(0.103,35,35,$fn=240);
}