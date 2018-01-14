inch=25.4;
fineness=24;
kerf=0.007*inch;
comfort=0.25;

width=inch/2;
height=inch/2;
length=inch*2;

glass_connector=7.5/2;
glass_connector_holder_shell=1.2;

connector_float=0.1;
lock_height=0.5;
lock_depth=0.1;//kerf*1.5;

shell=1.6;

battery_bank=1;
battery_count=8;
battery_length=50.5;
battery_width=15.5;

battery_bank_length=80;
battery_bank_width=60;
battery_bank_depth=20;

wire=2;
wire_shell=1;

screw_is_wire=1;
screw_shell=1;


screw_hole_diameter=2;
screw_head=10;
screw_head_height=1/2*inch;
screw_in_glass=0;
screw_outside_glass=0;

light_board=1;
light_board_length=50;
light_board_width=7.5;
light_board_depth=1/16*inch;

box_corner=5;
box_shell=2;

provailing_width=((screw_head>light_board_width && screw_in_glass)?screw_head:light_board_width);

glass_length=light_board_length+comfort*2+wire*2+wire_shell*4+(screw_in_glass?screw_head*2:0);
glass_width=provailing_width+comfort*4+glass_connector_holder_shell*2;
glass_height=7.5+comfort*4;

controller_board=1;
controller_board_width=1.2*inch;
controller_board_height=1.2*inch;



module glass(){
    union(){
        translate([0,0,glass_connector])
        rotate([0,90,0])
        difference(){
            translate([0,glass_width/2+shell,glass_width/4+shell])
            minkowski(){
                cylinder(glass_length+glass_width/4,glass_width/4,glass_width/4,$fn=fineness);
                rotate([0,-90,0])
                sphere(glass_width/4+shell,$fn=fineness);
            }
            
            translate([0.001,-0.001,-0.001])
            cube(size=[glass_width/2+shell+0.001,glass_width+shell*2+0.002,glass_length+glass_width+shell*2+0.002]);
            
            translate([0,glass_width/2+shell,glass_width/4+shell])
            minkowski(){
                
                cylinder(glass_length+glass_width/4,glass_width/4,glass_width/4,$fn=fineness);
                rotate([0,-90,0])
                sphere(glass_width/4,$fn=fineness);
            }
        }
        
       
        difference(){
            union(){
                
                translate([glass_width/4+shell,glass_width/4+shell,0])
                
                minkowski(){
                    //translate([0,0,-0.001])
                    cylinder(glass_connector/2,glass_width/4+shell,glass_width/4+shell,$fn=fineness);
                    cube(size=[glass_length+glass_width/4,glass_width/2,glass_connector/2]);
                }
                
                translate([glass_width/4+shell,glass_width/4+shell,(glass_connector-lock_height)/2-connector_float])
                minkowski(){
                    cylinder(lock_height/2,glass_width/4+shell+lock_depth,glass_width/4+shell+lock_depth,$fn=fineness);
                    cube(size=[glass_length+glass_width/4,glass_width/2,lock_height/2]);
                }
        
            }
            
            translate([glass_width/4+shell,glass_width/4+shell,-0.003])
            minkowski(){
                cylinder(glass_connector/2,glass_width/4,glass_width/4,$fn=fineness);
                cube(size=[glass_length+glass_width/4,glass_width/2,glass_connector/2+0.006]);
            }

            
        }
    }

}

module glass_connector_holder(){
    
    difference(){
        
        translate([glass_width/4+shell+comfort,glass_width/4+shell,0])
        minkowski(){
            cylinder(glass_connector/2+connector_float,glass_width/4-comfort,glass_width/4-comfort,$fn=fineness);
            cube(size=[glass_length+glass_width/4,glass_width/2,glass_connector/2]);
        }
        
        translate([glass_width/4+shell,glass_width/4+shell,-.003])
        minkowski(){
            cylinder(glass_connector/2+0.006+connector_float,glass_width/4-glass_connector_holder_shell-comfort,glass_width/4-glass_connector_holder_shell-comfort,$fn=fineness);
            cube(size=[glass_length+glass_width/4,glass_width/2,glass_connector/2]);
        }
    }
    
    
    difference(){
        difference(){
            
            translate([glass_width/4+shell,glass_width/4+shell,0])
            minkowski(){
                cylinder(glass_connector/2,glass_width/4+shell+glass_connector_holder_shell,glass_width/4+shell+glass_connector_holder_shell,$fn=fineness);
                cube(size=[glass_length+glass_width/4,glass_width/2,glass_connector/2]);
            }
            
            translate([glass_width/4+shell,glass_width/4+shell,-0.001])
            minkowski(){
                cylinder(glass_connector/2,glass_width/4+shell+kerf,glass_width/4+shell+kerf,$fn=fineness);
                cube(size=[glass_length+glass_width/4,glass_width/2,glass_connector+0.002]);
            }
        }
        
        
        translate([glass_width/4+shell,glass_width/4+shell,(glass_connector-lock_height)/2-kerf])
        minkowski(){
            cylinder(lock_height/2,glass_width/4+shell+lock_depth+kerf,glass_width/4+shell+lock_depth+kerf,$fn=fineness);
            cube(size=[glass_length+glass_width/4,glass_width/2,lock_height/2+kerf*2]);
        }

    }
    
}

module light_board_crosssection(){
    //cube(size[light_board_lenght/2,light_board_dep
   scale([.5,1,1]) 
 translate([-kerf-glass_connector_holder_shell,-kerf-glass_connector_holder_shell,-0.002])
    
    cube([
    light_board_length+glass_width+2*kerf+glass_connector_holder_shell*2+shell*2,
    
    light_board_width+comfort*2+glass_connector_holder_shell*2+comfort*2+shell*2+kerf*2+glass_connector_holder_shell*2,
    
    light_board_depth+glass_connector+shell+glass_width+0.003
    
    ]);
}


module light_board(){
    translate([0,0,-0.001])
cube([light_board_length,light_board_width,light_board_depth+0.001]);
    
}


module wire(){
    translate([wire/2+wire_shell,wire/2+wire_shell,0])
    
    translate([0,0,-0.003])
    hull(){
        cylinder(glass_connector/2+0.002,wire/2,wire/2,$fn=fineness);
        
        translate([0,wire+comfort,0])
        cylinder(glass_connector/2+0.006,wire/2,wire/2,$fn=fineness);
    }
}

module wire_shell(){
    translate([wire/2+wire_shell,wire/2+wire_shell,-0.001])
    difference(){
        hull(){
            cylinder(glass_connector/2+0.001,wire/2+wire_shell,wire/2+wire_shell,$fn=fineness);
            
            translate([0,wire+comfort,0])
            cylinder(glass_connector/2+0.001,wire/2+wire_shell,wire/2+wire_shell,$fn=fineness);
        }
        translate([0,0,-0.001])
        hull(){
            cylinder(glass_connector/2+0.003,wire/2,wire/2,$fn=fineness);
            
            translate([0,wire+comfort,0])
            cylinder(glass_connector/2+0.003,wire/2,wire/2,$fn=fineness);
        }
    }
}

module screw_hole(){
    translate([0,0,-0.001])
    cylinder(glass_connector_holder_shell+0.002,screw_hole_diameter/2,screw_hole_diameter/2,$fn=fineness);
}

module light_base(){
    difference(){
        translate([glass_width/4+shell,glass_width/4+shell,0])
        minkowski(){
            cylinder(glass_connector_holder_shell/2,glass_width/4+shell+glass_connector_holder_shell,glass_width/4+shell+glass_connector_holder_shell,$fn=fineness);
            cube(size=[glass_length+glass_width/4,glass_width/2,glass_connector_holder_shell/2]);
        }
        
        if (screw_in_glass){
        translate([shell+comfort+glass_connector_holder_shell+comfort+glass_width/4+provailing_width/2,shell+comfort+glass_connector_holder_shell+comfort+screw_head/2,0])
        screw_hole();
            
        translate([shell+comfort+glass_connector_holder_shell+comfort+glass_width/4+screw_head+wire+wire_shell*2+comfort+light_board_length+comfort+wire+wire_shell*2+provailing_width/2,shell+comfort+glass_connector_holder_shell+comfort+screw_head/2,0])
        screw_hole();
        
        }
            translate([
            shell+comfort+glass_connector_holder_shell+comfort+glass_width/4+(screw_in_glass?screw_head:0),
            shell+comfort+glass_connector_holder_shell+comfort+(provailing_width-wire_shell*2-wire*2-comfort)/2,
            0])
    wire();


    translate([
            shell+comfort+glass_connector_holder_shell+comfort+glass_width/4+wire+wire_shell*2+comfort*2+(screw_in_glass?screw_head:0)+light_board_length,
            shell+comfort+glass_connector_holder_shell+comfort+(provailing_width-wire_shell*2-wire*2-comfort)/2,
            0])
    wire();
    }
}

module glass_connector(){

    difference(){
        union(){
            

    color([0.9,0.85,0.8,1])
    translate([0,0,0])
    light_base();
            
    color([0,0.4,0.0,1])
    translate([shell+comfort+glass_connector_holder_shell+comfort+glass_width/4+wire+wire_shell*2+comfort+(screw_in_glass?screw_head:0),comfort+glass_connector_holder_shell+comfort+shell+((provailing_width-light_board_width)/2),glass_connector_holder_shell])
    light_board();



    color([0.9,0.85,0.8,1]){
        translate([
                shell+comfort+glass_connector_holder_shell+comfort+glass_width/4+(screw_in_glass?screw_head:0),
                shell+comfort+glass_connector_holder_shell+comfort+(provailing_width-wire_shell*2-wire*2-comfort)/2,glass_connector_holder_shell])
        wire_shell();


        translate([
                shell+comfort+glass_connector_holder_shell+comfort+glass_width/4+wire+wire_shell*2+comfort*2+(screw_in_glass?screw_head:0)+light_board_length,
                shell+comfort+glass_connector_holder_shell+comfort+(provailing_width-wire_shell*2-wire*2-comfort)/2,glass_connector_holder_shell])
        wire_shell();
    }
            
    color([0.9,0.85,0.8,1])
    translate([0,0,,glass_connector_holder_shell])
    glass_connector_holder();

    translate([0,0,glass_connector_holder_shell+connector_float])
    color([0.4,0.4,0.8,0.6])
    glass();


        }
        
        //light_board_crosssection();
    }  
    
}

translate([glass_connector_holder_shell+battery_bank_length/2-((glass_connector_holder_shell*2+kerf*2+glass_length))/2,
    glass_connector_holder_shell+3*(battery_bank_width+box_corner*2)/4-(glass_connector_holder_shell*2+kerf*2+glass_width+shell*2)/2,
battery_bank_depth+box_corner*2-box_shell])
    glass_connector();


difference(){

    translate([box_corner,box_corner,box_corner])
    minkowski(){
    cube(size=[battery_bank_length,battery_bank_width,battery_bank_depth]);
        sphere(box_corner,$fn=fineness);
    }

    translate([box_corner,box_corner,box_corner])
    minkowski(){
    cube(size=[battery_bank_length,battery_bank_width,battery_bank_depth]);
        sphere(box_corner-box_shell,$fn=fineness);
    }
    
    //cube([battery_bank_length+box_corner*2,battery_bank_width+box_corner*2,(battery_bank_depth+box_corner*2)/2]);
}