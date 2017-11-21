inch=25.4;
kerf=0.0035*inch*2;
gold=1.61803398875;

fineness_stl=200;
fineness_low=40;

fineness_sm_stl=50;
fineness_sm_low=10;

build_stl=false;

fineness=build_stl?fineness_stl:fineness_low;
fineness_sm=build_stl?fineness_sm_stl:fineness_sm_low;

box_width=1*inch;//4*inch;
box_length=1*inch;//3*inch;
box_height=1*inch;//4*inch;

box_shell=1.2; //1/16*inch;
box_air_hole=3/32*inch;
box_finger_hole=3/4*inch;

box_slit_width=3/8*inch;
box_slit_length=.5*inch;//3.5*inch;

corner=1/4*inch;

module box(){
    translate([corner,corner,corner])
    minkowski(){
        cube([box_width-corner*2,box_length-corner*2,box_height-corner*2]);
        sphere(corner,$fn=fineness);
    }
}

module box_top_cutout(){
    translate([-0.001,-0.001,box_height-corner])
    cube([box_width+0.002,box_length+0.002,corner+0.001]);
}

module box_outer_cutout(){
    translate([-0.001,-0.001,box_height-corner-box_shell])
    cube([box_width+0.002,box_length+0.002,corner+box_shell+0.001]);
}

module box_inner_cutout(){
    translate([-0.001,-0.001,box_height-corner-box_shell*2])
    cube([box_width+0.002,box_length+0.002,corner+box_shell*2+0.001]);
}


module box_outer_space(){
    translate([corner,corner,corner])
    minkowski(){
        cube([box_width-corner*2,box_length-corner*2,box_height-corner+0.001]);
        sphere(corner-box_shell,$fn=fineness);
    }
}

module box_inner(){
    difference(){
        translate([corner,corner,corner])
        minkowski(){
            cube([box_width-corner*2,box_length-corner*2,box_height-corner*2+0.001]);
            sphere(corner-box_shell-kerf,$fn=fineness);
        }
        
        box_outer_cutout();
    }
}

module box_inner_space_whole(){
    translate([corner,corner,0])
    minkowski(){
        cube([box_width-corner*2,box_length-corner*2,box_height-corner+0.001]);
        sphere(corner-box_shell*2-kerf,$fn=fineness);
    }
}

module box_inner_space(){
    difference(){
        box_inner_space_whole();
        box_inner_cutout();
    }
}

module box_outer_shell(){
    difference(){
        box();
        box_outer_space();
        box_top_cutout();
        translate([box_width/2,box_length/2,-0.001])
        cylinder(box_shell*3,box_air_hole/2,box_air_hole/2,$fn=fineness_sm);
    }
        
}

module box_inner_shell(){
    difference(){
        box_inner();
        
        box_inner_space();
        
        translate([box_width/2,box_length/2,box_height-corner-box_shell*2-0.001])
        cylinder(box_shell+0.002,box_finger_hole/2,box_finger_hole/2,$fn=fineness);
        
        translate([(box_width-box_slit_length)/2,box_length/2,box_height-corner-box_shell*2-0.001])
        linear_extrude(box_shell+0.002,convexity=10)
        hull(){
            translate([box_slit_width,0,0])
            circle(box_slit_width/2,$fn=fineness);
            translate([box_slit_length-box_slit_width,0,0])
            circle(box_slit_width/2,$fn=fineness);
        }
    }
}


module box_lid_cutout(){
    translate([-0.001+corner,-0.001+corner,box_height-corner-box_shell])
    linear_extrude(box_shell+kerf+0.001,convexity=10)
    difference(){
        minkowski(){
            square([box_width-corner*2,box_length-corner*2]);
            circle(corner+0.001,$fn=fineness);
        }
        minkowski(){
            square([box_width-corner*2,box_length-corner*2]);
            circle(corner-box_shell-kerf,$fn=fineness);
        }
    }
}

module box_lid_tongue(){
    
    translate([(box_width-box_slit_length+box_slit_width*2)/2,box_length/2,(box_height-box_shell*2)/2])
    translate([0,0,box_shell])
    union(){
        linear_extrude((box_height-box_shell*2)/2-box_shell+0.001,convexity=10)
        hull(){
            translate([box_shell,0,0])
            circle(box_shell,$fn=fineness);
            
            translate([box_slit_length-box_slit_width*2,0,0])
            circle(box_shell,$fn=fineness);
        }
        hull(){
            translate([box_shell,0,0])
            sphere(box_shell,$fn=fineness);
            
            translate([box_slit_length-box_slit_width*2,0,0])
            sphere(box_shell,$fn=fineness);
        }
    }
}

module box_lid_tongue_long(){
    
    translate([(box_width-box_slit_length+box_slit_width*2)/2,box_length/2,box_length/2+box_shell*2])
    translate([0,0,box_shell])
    union(){
        linear_extrude(box_height-box_shell*4-box_length/2+0.001,convexity=10)
        hull(){
            translate([box_shell,0,0])
            circle(box_shell,$fn=fineness_sm);
            
            translate([box_slit_length-box_slit_width*2,0,0])
            circle(box_shell,$fn=fineness_sm);
        }
        hull(){
            translate([box_shell,0,0])
            sphere(box_shell,$fn=fineness_sm);
            
            translate([box_slit_length-box_slit_width*2,0,0])
            sphere(box_shell,$fn=fineness_sm);
        }
    }
}

module box_lid(){
    union(){
        difference(){
            box();
            translate([0,0,box_shell])
            box_inner_space_whole();
            translate([-0.001,-0.001,0])
            cube([box_width+0.002,box_length+0.002,box_height-corner-box_shell+kerf]);
            box_lid_cutout();
        }
        box_lid_tongue_long();
    }
    
}

module box_closed(){
    box_lid();
    box_inner_shell();
    box_outer_shell();
}

module box_exploded(){
    
    translate([0,0,box_height*2-box_length/2])
    box_lid();
    
    translate([0,0,box_height])
    box_inner_shell();
    
    box_outer_shell();
}

module box_lid_stl(){
    //translate([0,0,box_height*1.5])
    //color([0.5,0.5,0.5,0.3])
    translate([box_width/2,box_length/2,box_height/2])
    rotate([0,180,0])
    translate([-box_width/2,-box_length/2,-box_height/2])
    box_lid();
}

module box_inner_stl(){
    //translate([0,0,box_height])
    //color([0.5,0.5,0.5,0.3])
    translate([box_width/2,box_length/2,box_height/2-corner-box_shell])
    rotate([0,180,0])
    translate([-box_width/2,-box_length/2,-box_height/2])
    box_inner_shell();
}

module box_outer_stl(){
    //color([0.5,0.5,0.5,0.3])
    box_outer_shell();
}

box_closed();

//box_lid_stl();
//box_inner_stl();
//box_outer_stl();