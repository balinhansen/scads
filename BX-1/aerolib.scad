inch=25.4;
slip=0.007*inch;
kerf=0.0035*inch;
comfort=0.25;

build_stl=0;

fineness_stl=200;
fineness_low=40;

printer_bed=100;
printer_extruder=0.4;
printer_layer=0.31;

cargo_width=1*inch;
cargo_space=cargo_width+kerf*2;

hull_thickness=0.8;

hull_support=hull_thickness*2+kerf;

hull_width=cargo_width+kerf*4+hull_thickness*4;
hull_height=2*inch+hull_support*4+kerf*4;

conduit_large=cargo_width/2+kerf*2;

airframe_connector_length=5;
airframe_connector_seam=0.8;
airframe_lock_depth=0.1;
airframe_lock_length=0.3;
airframe_lock_float=0.1;

cabin_length=100;//4*inch;

wing_span=72*inch;
wing_root_chord=4*inch;
wing_segment=4*inch;
wing_root_height=0.75*inch;
wing_taper=.25*3/16*inch;
wing_dihedral_angle=5;

wing_connector_length=10;
wing_connector_float=0.1;
wing_connector_block=1;
wing_lock_depth=0.2;
wing_lock=0.5; //0.5;

wing_angle_of_attack=5;

tail_height=4*inch;
tail_rudder_chord=inch;
tail_taper_percent=0.5;

fineness=build_stl?fineness_stl:fineness_low;



module airframe_linkage(){
    difference(){
        hull(){
            translate([0,-0.5*(hull_height-hull_width),0])
            circle(0.5*hull_width,$fn=fineness);
            
            translate([0,0.5*(hull_height-hull_width),0])
            circle(0.5*hull_width,$fn=fineness);
        }
        square(cargo_space,center=true);
        
        translate([0,0.5*cargo_space+hull_support+conduit_large/2,0])
        circle(conduit_large/2,$fn=fineness);
        
        translate([0,-0.5*cargo_space-hull_support-conduit_large/2,0])
        circle(conduit_large/2,$fn=fineness);
    }
}

module airframe_inset(){
    difference(){
        hull(){
            translate([0,-0.5*(hull_height-hull_width),0])
            circle(0.5*hull_width-hull_support/2-kerf,$fn=fineness);
            
            translate([0,0.5*(hull_height-hull_width),0])
            circle(0.5*hull_width-hull_support/2-kerf,$fn=fineness);
        }
        square(size=[cargo_space,cargo_space+hull_support*2+kerf*2],center=true);
        
        translate([0,0.5*cargo_space+hull_support+kerf,0])
        circle(cargo_space/2,$fn=fineness);
        
        translate([0,-0.5*cargo_space-hull_support-kerf,0])
        circle(cargo_space/2,$fn=fineness);
    
    }
}

module airframe_outset(){
    difference(){
        hull(){
            translate([0,-0.5*(hull_height-hull_width),0])
            circle(0.5*hull_width,$fn=fineness);
            
            translate([0,0.5*(hull_height-hull_width),0])
            circle(0.5*hull_width,$fn=fineness);
        }
        
        //square(size=[cargo_space+hull_support+kerf*2,cargo_space+(hull_support+kerf)*2],center=true);
        
        hull(){
        translate([0,0.5*cargo_space+hull_support,0])
        circle(cargo_space/2+hull_support/2,$fn=fineness);
        
        translate([0,-0.5*cargo_space-hull_support-kerf,0])
        circle(cargo_space/2+hull_support/2,$fn=fineness);
        }
    }
}


module airframe_outset_cutout(){
    hull(){
            translate([0,-0.5*(hull_height-hull_width),0])
            circle(0.5*hull_width+kerf,$fn=fineness);
            
            translate([0,0.5*(hull_height-hull_width),0])
            circle(0.5*hull_width+kerf,$fn=fineness);
        }
}

module airframe_outset_shell(){
    hull(){
            translate([0,-0.5*(hull_height-hull_width),0])
            circle(0.5*hull_width+kerf+hull_thickness,$fn=fineness);
            
            translate([0,0.5*(hull_height-hull_width),0])
            circle(0.5*hull_width+kerf+hull_thickness,$fn=fineness);
        }
}

module airframe_lock(){
    linear_extrude(airframe_lock_length,convexity=10)
    difference(){
        hull(){
            translate([0,-0.5*(hull_height-hull_width),0])
            circle(0.5*hull_width-hull_thickness-kerf*2+airframe_lock_depth,$fn=fineness);
            
            translate([0,0.5*(hull_height-hull_width),0])
            circle(0.5*hull_width-hull_thickness-kerf*2+airframe_lock_depth,$fn=fineness);
        }
        hull(){
            translate([0,-0.5*(hull_height-hull_width),0])
            circle(0.5*hull_width-hull_thickness-kerf*2,$fn=fineness);
            
            translate([0,0.5*(hull_height-hull_width),0])
            circle(0.5*hull_width-hull_thickness-kerf*2,$fn=fineness);
        }
    }
}

module airframe_lock_cutout(){
    linear_extrude(airframe_lock_length+kerf*2,convexity=10)
    difference(){
        hull(){
            translate([0,-0.5*(hull_height-hull_width),0])
            circle(0.5*hull_width-hull_thickness-airframe_lock_depth+kerf*2,$fn=fineness);
            
            translate([0,0.5*(hull_height-hull_width),0])
            circle(0.5*hull_width-hull_thickness-airframe_lock_depth+kerf*2,$fn=fineness);
        }
    }
}

module airframe_connector(){
    translate([0,0,-airframe_connector_length-airframe_connector_seam/2])
    union(){
        linear_extrude(airframe_connector_length+0.001,convexity=10)
        airframe_inset();
            
        translate([0,0,airframe_connector_length-0.001])
        linear_extrude(airframe_connector_seam+0.002,convexity=10)
        airframe_linkage();

        translate([0,0,airframe_connector_seam+airframe_connector_length-0.001])
        linear_extrude(+airframe_connector_length+0.001,convexity=10)
        airframe_inset();
        
        
    translate([0,0,airframe_connector_length+airframe_connector_seam+(airframe_connector_length-airframe_lock_length)/2+airframe_lock_float])
airframe_lock();
        
        
    translate([0,0,(airframe_connector_length-airframe_lock_length)/2-airframe_lock_float])
airframe_lock();
        
    }
}

module airframe_cabin_section(){
    translate([0,0,-cabin_length/2])
    difference(){
        linear_extrude(cabin_length,convexity=10)
        airframe_outset();
    
        translate([0,0,(airframe_connector_length-airframe_lock_length)/2-kerf])
        airframe_lock_cutout();
        
        translate([0,0,cabin_length-(airframe_connector_length+airframe_lock_length)/2-kerf])
        airframe_lock_cutout();
    }
    
}

module airframe_deck_section(){
    union(){    
        difference(){
            union(){
                hull(){  
                    translate([0,hull_width/2,hull_thickness*5])
                    sphere(hull_width/2,$fn=fineness);
                    
                    translate([0,hull_width/4,hull_thickness*5])
                    scale([1,1,1.5])
                    sphere(hull_width/2,$fn=fineness);
                }

                hull(){
                    translate([0,hull_width/4,hull_thickness*5])
                    scale([1,1,1.5])
                    sphere(hull_width/2,$fn=fineness);
                    
                    translate([0,-hull_width/6,hull_thickness*5])
                    scale([1,1,3])
                    sphere(hull_width/2,$fn=fineness);
                }
                
                hull(){
                    translate([0,-hull_width/6,hull_thickness*5])
                    scale([1,1,3])
                    sphere(hull_width/2,$fn=fineness);
                    
                    translate([0,-hull_width/2,hull_thickness*5])
                    scale([1,1,2])
                    sphere(hull_width/2,$fn=fineness);
                }
            }
            
            
            union(){
                hull(){  
                    translate([0,hull_width/2,hull_thickness*5])
                    sphere(hull_width/2-hull_thickness,$fn=fineness);
                    
                    translate([0,hull_width/4,hull_thickness*5])
                    scale([1,1,1.5])
                    sphere(hull_width/2-hull_thickness,$fn=fineness);
                }

                hull(){
                    translate([0,hull_width/4,hull_thickness*5])
                    scale([1,1,1.5])
                    sphere(hull_width/2-hull_thickness,$fn=fineness);
                    
                    translate([0,-hull_width/6,hull_thickness*5])
                    scale([1,1,3])
                    sphere(hull_width/2-hull_thickness,$fn=fineness);
                }
                
                hull(){
                    translate([0,-hull_width/6,hull_thickness*5])
                    scale([1,1,3])
                    sphere(hull_width/2-hull_thickness,$fn=fineness);
                    
                    translate([0,-hull_width/2,hull_thickness*5])
                    scale([1,1,2])
                    sphere(hull_width/2-hull_thickness,$fn=fineness);
                }
            }
            
            translate([0,0,-hull_width*.75-0.001+hull_thickness*2.5])
            cube(size=[hull_width+0.002,hull_height+0.002,hull_width*1.5+0.001+hull_thickness*5],center=true);
            
            
        }
    
    
        linear_extrude(hull_thickness*5+0.001,convexity=10)
        airframe_outset();
        
    }
    
    
}
    
module airframe_tail_section(){
    translate([0,0,hull_thickness*5])
    difference(){
    
        hull(){
            translate([0,hull_height/2-hull_width/2,0])
            scale([1,1,2*(4*inch-hull_width/4-hull_thickness*5)/(hull_width)])
            sphere(hull_width/2,$fn=fineness);
            
            translate([0,-hull_height/2+hull_width/2,0])
            scale([1,1,1.25*(4*inch-hull_width/4)/(2*hull_width)])
            sphere(hull_width/2,$fn=fineness);
            
            
            translate([0,hull_height/2-hull_width/2,4*inch-hull_width/4-hull_thickness*5])
            sphere(hull_width/4,$fn=fineness);
        }
        
        hull(){
            
            translate([0,hull_height/2-hull_width/2,0])
            scale([1,1,2*(4*inch-hull_width/4-hull_thickness*5)/(hull_width)])
            sphere(hull_width/2-hull_thickness,$fn=fineness);
            
            translate([0,-hull_height/2+hull_width/2,0])
            scale([1,1,1.25*(4*inch-hull_width/4)/(2*hull_width)])
            sphere(hull_width/2-hull_thickness,$fn=fineness);
            
            
            translate([0,hull_height/2-hull_width/2,4*inch-hull_width/4-hull_thickness*5])
            sphere(hull_width/4-hull_thickness,$fn=fineness);
            
        }
        translate([0,0,-2*inch-0.001])
        cube(size=[hull_width+0.002,hull_height+0.002,4*inch+0.002],center=true);
    }
    difference(){
    linear_extrude(hull_thickness*5+0.001,convexity=10)
        airframe_outset();
        translate([0,0,(airframe_connector_length-airframe_lock_length)/2-kerf])
        airframe_lock_cutout();
    }
    
}


module wing_shape_outset(){
    minkowski(){
        hull(){
            translate([wing_root_height/4+wing_root_height/2+1.5*wing_root_height/3,0,0])
            scale([2,1])
            circle(wing_root_height/4,$fn=fineness);
          
            translate([wing_root_chord-.75*wing_root_height-wing_taper*2.5-hull_thickness*2,-wing_root_height/4+wing_taper/2,0])
            scale([2,1])
            circle(wing_taper/2,$fn=fineness);
        }     
        difference(){
            //translate([-wing_root_height*0.75,0,0])
            scale([3,1,1])
            circle(wing_root_height/4,$fn=fineness);
            translate([-wing_root_height/4*3,-wing_root_height/4,0])
            square([wing_root_height/4*6,wing_root_height/4]);
        }
        circle(hull_thickness+kerf,$fn=fineness);
    }
}

module wing_shape_inset(){
    minkowski(){
        hull(){
            translate([wing_root_height/4+wing_root_height/2+1.5*wing_root_height/3,0,0])
            scale([2,1])
            circle(wing_root_height/4,$fn=fineness);
          
            translate([wing_root_chord-.75*wing_root_height-wing_taper*2.5-hull_thickness*2,-wing_root_height/4+wing_taper/2,0])
            scale([2,1])
            circle(wing_taper/2,$fn=fineness);
        } 
        
        difference(){
            //translate([-wing_root_height*0.75,0,0])
            scale([3,1,1])
            circle(wing_root_height/4,$fn=fineness);
            translate([-wing_root_height/4*3,-wing_root_height/4,0])
            square([wing_root_height/4*6,wing_root_height/4]);
        }
        
        //circle(hull_thickness+kerf,$fn=fineness);
    }
}

module wing_shape_innerkerf(){
    offset(r=-kerf)
    wing_shape_inset();
}

module wing_shape_connector(){
    offset(r=-kerf-hull_thickness)
    wing_shape_inset();
}

module wing_shape_lockpad(){
    offset(r=-kerf-hull_thickness-wing_lock_depth)
    wing_shape_inset();
}

module wing_shape_block(){
    offset(r=-wing_connector_block)
    wing_shape_inset();
}

module wing_shape_lock(){
    offset(r=-wing_lock_depth)
    wing_shape_inset();
}

module wing_shape_lock_cutout(){
    offset(r=-wing_lock_depth-kerf)
    wing_shape_inset();
}




module wing_connector_insert(){
    difference(){
        union(){
            
            // Insert 
            
            translate([0,0,-0.001])
            linear_extrude(wing_connector_length+0.001,convexity=10)
            difference(){
                wing_shape_innerkerf();
                wing_shape_connector();
            }
            //wing_shape_lock_cutout();
            
            // Lock padding
            
            translate([0,0,wing_connector_length/2-wing_lock/2-hull_thickness+wing_connector_float])
            linear_extrude(wing_lock+hull_thickness*2,convexity=10)
            difference(){
                offset(r=-hull_thickness/2)
                wing_shape_innerkerf();
                wing_shape_lockpad();
            }
        }
        
        // Lock Cutout
        
        translate([0,0,wing_connector_length/2-wing_lock/2-kerf+wing_connector_float])
        linear_extrude(wing_lock+kerf*2,convexity=10)
        difference(){
            wing_shape_outset();
            wing_shape_lock_cutout();
        }
    }
}

module wing_connector(){
    translate([0,0,wing_connector_float]){
        translate([0,0,hull_thickness])
        wing_connector_insert();

        linear_extrude(hull_thickness,convexity=10)
        difference(){
            wing_shape_outset();
            wing_shape_connector();
        }

        mirror([0,0,1])
        wing_connector_insert();
    }
}


module wing_segment(){
    linear_extrude(wing_segment,convexity=10)
    difference(){
        wing_shape_outset();
        wing_shape_inset();
    }
    
    translate([0,0,wing_connector_length/2-wing_lock/2])
    linear_extrude(wing_lock,convexity=10)
    difference(){
        offset(r=-hull_thickness/2)
        wing_shape_outset();
        wing_shape_lock();
    }

    translate([0,0,wing_segment-wing_connector_length/2-wing_lock/2])
    linear_extrude(wing_lock,convexity=10)
    difference(){
        offset(r=-hull_thickness/2)
        wing_shape_outset();
        wing_shape_lock();
    }

}


module airframe_wing_mount(){  
    difference(){
        
        difference(){
            translate([0,0,hull_width])
            translate([0,hull_width/2+wing_connector_length,0])
            rotate([90,wing_angle_of_attack,0])
            translate([hull_thickness+kerf,0,-hull_thickness-kerf-hull_thickness-wing_connector_float])
            linear_extrude(hull_width+hull_thickness*2+kerf*2+hull_thickness*2+wing_connector_float*2+wing_connector_length*2,convexity=10)
            difference(){
                wing_shape_outset();
                //wing_shape_inset();
            }
            translate([-10,0,0])
            rotate([90,0,90])
            linear_extrude(110,convexity=10)
            airframe_outset_cutout();
        }
        
        difference(){
            translate([0,0,hull_width])
            translate([0,hull_width/2+wing_connector_length,0])
            rotate([90,wing_angle_of_attack,0])
            {
                // Block
                translate([hull_thickness+kerf,0,-hull_thickness-kerf-hull_thickness-wing_connector_float-0.001])
                linear_extrude(hull_width+hull_thickness*2+kerf*2+hull_thickness*2+wing_connector_float*2+wing_connector_length*2+0.002,convexity=10)
                wing_shape_block();
                
                // Void Center
                translate([hull_thickness+kerf,0,-hull_thickness-kerf-hull_thickness-wing_connector_float+wing_connector_length+wing_connector_float+hull_thickness])
                linear_extrude(hull_width+hull_thickness*2+kerf*2,convexity=10)
                wing_shape_inset();
                
                // Void Right
                translate([hull_thickness+kerf,0,-hull_thickness-kerf-hull_thickness-wing_connector_float-0.001])
                linear_extrude(wing_connector_length+wing_connector_float-0.001,convexity=10)
                wing_shape_lock();
                
                // Void Left
                translate([hull_thickness+kerf,0,-hull_thickness-kerf-hull_thickness-wing_connector_float+wing_connector_length+wing_connector_float+hull_width+hull_thickness*2+kerf*2+hull_thickness*2+0.001])
                linear_extrude(wing_connector_length+wing_connector_float-0.001,convexity=10)
                wing_shape_lock();
                
                // Right connector
                translate([hull_thickness+kerf,0,-hull_thickness-kerf-hull_thickness-wing_connector_float-0.001])
                linear_extrude(wing_connector_length/2-wing_lock/2+0.001,convexity=10)
                wing_shape_inset();
            
                // Right lock void
                translate([hull_thickness+kerf,0,-hull_thickness-kerf-hull_thickness-wing_connector_float+wing_connector_length/2+wing_lock/2-0.001])
                linear_extrude(wing_connector_length/2-wing_lock/2+wing_connector_float+0.001,convexity=10)
                wing_shape_inset();
                
                
                // Left connector
                translate([hull_thickness+kerf,0,-hull_thickness-kerf-hull_thickness-wing_connector_float+hull_width+wing_connector_length*2+hull_thickness*2+kerf*2+hull_thickness*2+wing_connector_float*2-wing_connector_length/2+wing_lock/2+0.001])
                linear_extrude(wing_connector_length/2-wing_lock/2+0.001,convexity=10)
                wing_shape_inset();
            
                // Left lock void
                translate([hull_thickness+kerf,0,-hull_thickness-kerf-hull_thickness-wing_connector_float+hull_width+wing_connector_length*2+hull_thickness*2+kerf*2+hull_thickness*2+wing_connector_float-wing_connector_length])
                linear_extrude(wing_connector_length/2-wing_lock/2+0.001,convexity=10)
                wing_shape_inset();
            
             
            }
            
            rotate([90,0,90])
            linear_extrude(100,convexity=10)
            airframe_outset_shell();
        }
        //cube(80,center=true);
    }
}



module tail_shape(){
    difference(){
        hull(){
            translate([wing_root_height/4,0,0])
            circle(wing_root_height/4,$fn=fineness);
            
            translate([wing_root_chord-wing_root_height/8-tail_rudder_chord,0,0])
            circle(wing_root_height/8,$fn=fineness);
        }
        
        translate([wing_root_chord-wing_root_height/8-tail_rudder_chord,0,0])
        scale([1,1.25])
        circle(wing_root_height/8+0.001,$fn=fineness);
    }
}

module rudder_shape(){
    hull(){
        //translate([wing_root_height/8,0,0])
        circle(wing_root_height/8-kerf*2,$fn=fineness);
        
        translate([wing_root_height/8+tail_rudder_chord-kerf*2-wing_taper/2,0,0])
        circle(wing_taper/2,$fn=fineness);
    }
}


module tail(){
    union(){
       linear_extrude(1,convexity=10) 
        //linear_extrude(tail_height-wing_root_height/4+0.001,convexity=10,scale=[tail_taper_percent,tail_taper_percent])
        translate([-wing_root_chord+wing_root_height/8+tail_rudder_chord,0,0])
        difference(){
            tail_shape();
            offset(r=-hull_thickness)
            tail_shape();
        }
        /*
        translate([0,0,tail_height-wing_root_height/4])
        difference(){
            hull(){
                translate([(-wing_root_chord+tail_rudder_chord+wing_root_height/4+wing_root_height/8)*tail_taper_percent,0, ])
                scale(tail_taper_percent)
                sphere(wing_root_height/4,$fn=fineness);
                
                scale(tail_taper_percent)
                sphere(wing_root_height/8,$fn=fineness);
            }
            
            hull(){
                translate([(-wing_root_chord+tail_rudder_chord+wing_root_height/4+wing_root_height/8)*tail_taper_percent,0, ])
                scale(tail_taper_percent)
                sphere(wing_root_height/4-hull_thickness,$fn=fineness);
                
                scale(tail_taper_percent)
                sphere(wing_root_height/8-hull_thickness,$fn=fineness);
            }
            translate([(-wing_root_chord+tail_rudder_chord+wing_root_height/8)*tail_taper_percent,-wing_root_height/4,-wing_root_height/4])
            cube([(wing_root_chord-tail_rudder_chord)*tail_taper_percent,wing_root_height/2,wing_root_height/4]);
            
            
        }
        */
    }
}

module rudder(){
    linear_extrude(tail_height-wing_root_height/8-wing_root_height/4,convexity=10,scale=[tail_taper_percent,tail_taper_percent])
    difference(){
        rudder_shape();
        offset(r=-hull_thickness)
        rudder_shape();
    }
}


module airframe_assembled(){
    rotate([0,270,0])
    rotate([0,0,270])
    airframe_tail_section();
    
    translate([airframe_connector_seam/2+airframe_lock_float,0,0])
    rotate([0,270,0])
    rotate([0,0,270])
    airframe_connector();
        
        translate([airframe_connector_seam+airframe_lock_float*2,0,0])
    rotate([0,90,0])
    rotate([0,0,270])
        translate([0,0,cabin_length/2])
        airframe_cabin_section();
    
    
    translate([(airframe_connector_seam/2+airframe_lock_float)+(airframe_connector_seam+airframe_lock_float*2)+cabin_length,0,0])
    rotate([0,270,0])
    rotate([0,0,270])
    airframe_connector();
    
    
        translate([(airframe_connector_seam+airframe_lock_float*2)*2+cabin_length,0,0])
    rotate([0,90,0])
    rotate([0,0,270])
        translate([0,0,cabin_length/2])
        airframe_cabin_section();
    
    
    translate([(airframe_connector_seam/2+airframe_lock_float)+(airframe_connector_seam+airframe_lock_float*2)*2+cabin_length*2,0,0])
    rotate([0,270,0])
    rotate([0,0,270])
    airframe_connector();
    
    
        translate([(airframe_connector_seam+airframe_lock_float*2)*3+cabin_length*2,0,0])
    rotate([0,90,0])
    rotate([0,0,90])
    airframe_deck_section();
        //translate([0,0,cabin_length/2])
        //airframe_cabin_section();
        
        translate([cabin_length*1.5,0,0])
        rotate([0,0,180])
        airframe_wing_mount();
    
}


module airframe_test(){
difference(){
    union(){
        
    //airframe_assembled();
//rotate([90,0,0])
//airframe_deck_section();
//airframe_tail_section();
//airframe_cabin_section();
        /*
        translate([0,0,-airframe_connector_seam/2-airframe_lock_float])
        airframe_connector();
        
        translate([0,0,cabin_length+airframe_connector_seam/2+airframe_lock_float])
        airframe_connector();
*/
//translate([0,0,10])
//airframe_wing_mount();
//wing_connector();
wing_segment();
        
//rotate([0,0,-wing_angle_of_attack])
//wing_segment();

//cube([4*inch,1,1]);

//tail();
//rudder();
    }
    //translate([-100,0,-100])
    //cube(100);
}
}

//color([0.8,0.4,0.4,0.6])
airframe_test();
//cube(1*inch*0.9,center=true);