
difference(){
    union(){
        translate([13,5,4-0.001])
        cube(size=[22,8,5+0.001]);

        difference(){
            cube([35,18,4]);
            translate([7,9,-0.001])
            cylinder(4+0.002,3,3,$fn=80);
        }
    }
    translate([25,9,-0.001])
    cylinder(4+0.001,5.2,2.7,$fn=80);
}