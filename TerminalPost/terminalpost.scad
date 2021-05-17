base=1.80;
hole_fineness=120;
outer_fineness=240;
sphere_fineness=96;

difference(){
    
    union(){
        difference(){
            translate([0,0,0.75])
            minkowski(){
                cylinder(base-0.75,11.55/2-0.75,11.55/2-0.75,$fn=outer_fineness);
                sphere(0.75,$fn=sphere_fineness);
            }
            translate([-11.55/2-0.1,-11.55/2-0.1,base])
            cube([11.55+0.2,11.55+0.2,0.75+0.1]);
        }
        cylinder(2.45,9.5/2,9.5/2,$fn=outer_fineness);
        }
        
        translate([-11.55/2,8.5-11.55/2,base])
        cube([11.55,11.55/2,2.45-base+0.1]);
        
        translate([0,0,-0.1])
        cylinder(3,4/2,4/2,$fn=hole_fineness);
    }
        