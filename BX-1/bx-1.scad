inch=25.4;
kerf=0.0035*inch;

build_stl=0;

fineness_stl=200;
fineness_low=40;

cargo_width=1*inch;
cargo_space=cargo_width+kerf*2;

hull_thickness=0.8;

hull_support=hull_thickness*2+kerf;

hull_width=cargo_width+kerf*4+hull_thickness*4;
hull_height=2*inch+hull_support*4+kerf*4;

conduit_large=cargo_width/2+kerf*2;

wing_span=72*inch;
wing_root_chord=4*inch;
wing_segment=4*inch;
wing_root_height=0.75*inch;
wing_taper=.25*3/16*inch;
wing_dihedral_angle=5;

wing_angle_of_attack=10;

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

module airframe_outset(){
    difference(){
        hull(){
            translate([0,-0.5*(hull_height-hull_width),0])
            circle(0.5*hull_width,$fn=fineness);
            
            translate([0,0.5*(hull_height-hull_width),0])
            circle(0.5*hull_width,$fn=fineness);
        }
        
        square(size=[cargo_space+hull_support+kerf*2,cargo_space+(hull_support+kerf)*2],center=true);
        
        translate([0,0.5*cargo_space+hull_support+kerf,0])
        circle(cargo_space/2+hull_support/2+kerf,$fn=fineness);
        
        translate([0,-0.5*cargo_space-hull_support-kerf,0])
        circle(cargo_space/2+hull_support/2+kerf,$fn=fineness);
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

module airframe_connector(){
    union(){
        linear_extrude(hull_thickness*5+0.001,convexity=10)
        airframe_inset();
            
        translate([0,0,hull_thickness*5-0.001])
        linear_extrude(hull_thickness*2+0.002,convexity=10)
        airframe_linkage();

        translate([0,0,hull_thickness*7-0.001])
        linear_extrude(hull_thickness*5+0.001,convexity=10)
        airframe_inset();
    }
}

module airframe_cabin_section(){
    linear_extrude(4*inch-hull_thickness*2,convexity=10)
    airframe_outset();
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
    linear_extrude(hull_thickness*5+0.001,convexity=10)
        airframe_outset();
    
}


module wing_shape_outset(){
    minkowski(){
        hull(){
            translate([wing_root_height/2+1.5*wing_root_height/3,0,0])
            circle(wing_root_height/4,$fn=fineness);
          
            translate([wing_root_chord-.75*wing_root_height-wing_taper/2,-wing_root_height/4+wing_taper/2,0])
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
            translate([wing_root_height/2+1.5*wing_root_height/3,0,0])
            circle(wing_root_height/4,$fn=fineness);
          
            translate([wing_root_chord-.75*wing_root_height-wing_taper/2,-wing_root_height/4+wing_taper/2,0])
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

module wing_segment(){
    linear_extrude(wing_segment,convexity=10)
    difference(){
        wing_shape_outset();
        wing_shape_inset();
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

//rotate([90,0,0])
//airframe_deck_section();
//airframe_tail_section();

//airframe_connector();


//rotate([0,0,-wing_angle_of_attack])
//wing_segment();

//cube([4*inch,1,1]);

module tail(){
    union(){
        linear_extrude(tail_height-wing_root_height/4+0.001,convexity=10,scale=[tail_taper_percent,tail_taper_percent])
        translate([-wing_root_chord+wing_root_height/8+tail_rudder_chord,0,0])
        difference(){
            tail_shape();
            offset(r=-hull_thickness)
            tail_shape();
        }
        
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

tail();
rudder();
