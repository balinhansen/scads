inch=25.4;

box_depth=50;
box_corner=5;
box_fineness=48;
box_shell=1.6;

kerf=0.007*inch;

box_connector=5;
lock=0.5;
lock_depth=0.1;
lock_hover=0.1;


edge_fineness=15;

debug_points=5;
bug_width=20;
bug_fineness=48;

debug_post=5;
debug_post_fineness=32;


module debug_post(){
    translate([0,0,-0.001])
    union(){
        cylinder(box_depth-debug_post/2-box_shell-box_corner-lock_hover+0.001,debug_post/2,debug_post/2,$fn=debug_post_fineness);
        translate([0,0,box_depth-debug_post/2-box_shell-box_corner-lock_hover])
        sphere(debug_post/2,$fn=debug_post_fineness);
        
        cylinder((box_depth-box_shell-box_corner-lock_hover)/4,debug_post*3/4,debug_post/2,$fn=debug_post_fineness);
    }
}

module debug_posts(){
    translate([0,0,box_shell]){
        for (i=[0:debug_points-1]){
            rotate([0,0,360/debug_points*i])
            translate([bug_width+debug_post/2,0,0])
            debug_post();
        }

        debug_post();
    }
}

module bowl(){
    translate([0,0,box_corner])
    difference(){
        minkowski(){
            hull(){
                for (i=[0:debug_points-1]){
                    rotate([0,0,360/debug_points*i])
                    translate([debug_post/2+bug_width+debug_post+bug_width/2-box_corner,0,0])
                    cylinder(box_depth-box_corner-box_connector-lock_hover,bug_width/2,bug_width/2,$fn=bug_fineness);
                }
            }
            sphere(box_corner,$fn=box_fineness);
        }
        
        minkowski(){
            hull(){
                for (i=[0:debug_points-1]){
                    rotate([0,0,360/debug_points*i])
                    translate([debug_post/2+bug_width+debug_post+bug_width/2-box_corner,0,0])
                    cylinder(box_depth-box_corner+box_shell-lock_hover,bug_width/2,bug_width/2,$fn=bug_fineness);
                }
            }
            sphere(box_corner-box_shell,$fn=box_fineness);
        }
        
        
        
        translate([0,0,box_depth-box_corner-box_connector/2-lock_hover])
        cube([debug_post+bug_width*2+debug_post*2+bug_width*2+box_shell*2,debug_post+bug_width*2+debug_post*2+bug_width*2+box_corner*2,box_corner*2-box_connector+lock_hover+0.001],center=true);
        
     // Lock
translate([0,0,box_depth-box_corner-box_corner-lock_hover-(box_connector+lock)/2-kerf])
        minkowski(){
            hull(){
                for (i=[0:debug_points-1]){
                    rotate([0,0,360/debug_points*i])
                    translate([debug_post/2+bug_width+debug_post+bug_width/2-box_corner,0,0])
                    cylinder(lock/2,bug_width/2,bug_width/2,$fn=bug_fineness);
                }
            }
            cylinder(lock/2+kerf*2,box_corner-box_shell+lock_depth,box_corner-box_shell+lock_depth,$fn=box_fineness);
        }
   
        
    }
}
        

module bug_bowl_lid(){
    translate([0,0,-box_connector-lock_hover]){
    difference(){
        union(){
                 // Lock

            translate([0,0,box_depth-(box_connector+lock)/2])
            minkowski(){
                hull(){
                    for (i=[0:debug_points-1]){
                        rotate([0,0,360/debug_points*i])
                        translate([debug_post/2+bug_width+debug_post+bug_width/2-box_corner,0,0])
                        cylinder(lock/2,bug_width/2,bug_width/2,$fn=bug_fineness);
                    }
                }
                cylinder(lock/2,box_corner-box_shell-kerf+lock_depth,box_corner-box_shell-kerf+lock_depth,$fn=box_fineness);
            }
            
            // Connector
            
            translate([0,0,box_depth-box_connector])
            minkowski(){
                hull(){
                    for (i=[0:debug_points-1]){
                        rotate([0,0,360/debug_points*i])
                        translate([debug_post/2+bug_width+debug_post+bug_width/2-box_corner,0,0])
                        cylinder(box_connector/2,bug_width/2,bug_width/2,$fn=bug_fineness);
                    }
                }
                cylinder(box_connector/2+box_shell+0.1+0.001,box_corner-box_shell-kerf,box_corner-box_shell-kerf,$fn=box_fineness);
            }
            
        }
        
        // Connector Cutout
        
        translate([0,0,box_depth-box_connector-0.001])
            minkowski(){
                hull(){
                    for (i=[0:debug_points-1]){
                        rotate([0,0,360/debug_points*i])
                        translate([debug_post/2+bug_width+debug_post+bug_width/2-box_corner,0,0])
                        cylinder(box_connector/2,bug_width/2,bug_width/2,$fn=bug_fineness);
                    }
                }
                cylinder(box_connector/2+box_shell+0.1+0.003,box_corner-box_shell*2-kerf,box_corner-box_shell*2-kerf,$fn=box_fineness);
            }
            
        }
        
        // Lid
        translate([0,0,box_shell+box_corner+0.1])
    difference(){
        minkowski(){
            hull(){
                
                for (i=[0:debug_points-1]){
                    rotate([0,0,360/debug_points*i])
                    translate([debug_post/2+bug_width+debug_post+bug_width/2-box_corner,0,0])
                    cylinder(box_depth-box_corner-box_shell,bug_width/2,bug_width/2,$fn=bug_fineness);
                }
            }
            sphere(box_corner,$fn=box_fineness);
        }
        
        // Lid Cutout
        
        minkowski(){
            hull(){
                for (i=[0:debug_points-1]){
                    rotate([0,0,360/debug_points*i])
                    translate([debug_post/2+bug_width+debug_post+bug_width/2-box_corner,0,0])
                    cylinder(box_depth-box_corner-box_shell,bug_width/2,bug_width/2,$fn=bug_fineness);
                }
            }
            scale([(box_corner-box_shell*2-kerf)/(box_corner-box_shell),(box_corner-box_shell*2-kerf)/(box_corner-box_shell),1])
            sphere(box_corner-box_shell,$fn=box_fineness);
        }
        
        translate([0,0,box_depth/2-box_corner-box_shell-0.001])
        cube([debug_post+bug_width*2+debug_post*2+bug_width*2+box_shell*2,debug_post+bug_width*2+debug_post*2+bug_width*2+box_corner*2,box_depth+0.1+0.001],center=true);
        
        
    }
}
}

        //translate([0,0,box_depth/2-0.001])
        //cube([debug_post+bug_width*2+debug_post*2+bug_width*2+box_shell*2,debug_post+bug_width*2+debug_post*2+bug_width*2+box_corner*2,box_depth+0.1+0.001],center=true);
        

module bug_bowl_crosssection(){
    
        translate([(debug_post+bug_width*2+debug_post*2+bug_width*2+box_shell*2)/4,0,box_depth/2])
        cube([(debug_post+bug_width*2+debug_post*2+bug_width*2+box_shell*2)/2+0.002,2*(debug_post+bug_width*2+debug_post*2+bug_width*2+box_corner*2)+0.002,box_depth+0.002],center=true);
}


      
debug_posts();
    
difference(){
union(){
    bowl();
    
    //rotate([0,180,0])
    translate([0,0,-box_depth])
    translate([0,0,box_depth])
    bug_bowl_lid();
}
    bug_bowl_crosssection();
}
