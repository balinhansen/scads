inch=25.4;
fineness=48;
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

battery_text="AAA";
battery_bank=1;
battery_count=8; 
battery_length=44.5;    // 18650 65.2;    // 50.5 AA;  // 28: 21/23
battery_width=10.5;     // 18650 18;       // AA   14.5;   // 10: 21/23
battery_spacing=1;
battery_holder_shell=1.6;
battery_clip_shell=1.2;
battery_clip_length=battery_length/4;
battery_knob=1;
battery_knob_width=3.5;
battery_clip_angle=15;
battery_clip_space=1;
battery_hover=1;

battery_bank_length=105;
battery_bank_width=(battery_width+battery_spacing)*(battery_count/2)+battery_width/2;
battery_bank_depth=battery_width+sin(60)*battery_width+battery_spacing/2;

wire=2;
wire_shell=1;

screw_is_wire=0;
screw_shell=1;


screw_hole_diameter=2;
screw_head=10;
screw_head_height=0;//1/2*inch;

screw_in_glass=0;
screw_outside_glass=0;

light_board=1;
light_board_length=50;
light_board_width=7.5;
light_board_depth=1/16*inch;

box_corner=3;
box_shell=2;

prevailing_width=((screw_head>light_board_width && screw_in_glass)?screw_head:light_board_width);

glass_length=light_board_length+comfort*2+wire*2+wire_shell*4+comfort*2+(screw_in_glass?screw_head*2:0+comfort*2);

glass_width=prevailing_width+comfort*2+glass_connector_holder_shell*2+comfort*2;

glass_height=screw_in_glass?screw_head_height:0;

prevailing_height=glass_connector>glass_height?glass_connector:glass_height;

controller_board=1;
controller_board_width=1.2*inch;
controller_board_height=1.2*inch;


module glass(){
    union(){
        translate([0,0,prevailing_height])
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
                    cylinder(prevailing_height/2,glass_width/4+shell,glass_width/4+shell,$fn=fineness);
                    cube(size=[glass_length+glass_width/4,glass_width/2,prevailing_height/2]);
                }
                
                translate([glass_width/4+shell,glass_width/4+shell,(glass_connector-lock_height)/2-connector_float])
                minkowski(){
                    cylinder(lock_height/2,glass_width/4+shell+lock_depth,glass_width/4+shell+lock_depth,$fn=fineness);
                    cube(size=[glass_length+glass_width/4,glass_width/2,lock_height/2]);
                }
        
            }
            
            translate([glass_width/4+shell,glass_width/4+shell,-0.003])
            minkowski(){
                cylinder(prevailing_height/2,glass_width/4,glass_width/4,$fn=fineness);
                cube(size=[glass_length+glass_width/4,glass_width/2,prevailing_height/2+0.006]);
            }
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


module wire(length){
    translate([wire/2+wire_shell,wire/2+wire_shell,0])
    
    translate([0,0,-0.003])
    hull(){
        cylinder(length+0.006,wire/2,wire/2,$fn=fineness);
        
        translate([0,wire+comfort,0])
        cylinder(length+0.006,wire/2,wire/2,$fn=fineness);
    }
}

module wires(length){
    translate([-wire/2-wire_shell,-wire/2-wire_shell,0])
    wire(length);
    
    translate([-wire/2-wire_shell+light_board_length+wire+wire_shell*2+comfort*2,-wire/2-wire_shell,0])
    wire(length);
}

module wires_move(){
    translate([
            wire+shell+comfort+glass_connector_holder_shell+comfort+glass_width/4+(screw_in_glass?screw_head:0),
            wire+shell+comfort+glass_connector_holder_shell+comfort+(prevailing_width-wire_shell*2-wire*2-comfort)/2,
            0])
    children();
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

module screw_hole(length=glass_connector_holder_shell){
    translate([0,0,-0.002])
    cylinder(length+0.004,screw_hole_diameter/2,screw_hole_diameter/2,$fn=fineness);
}

module light_base(){
    difference(){
        translate([glass_width/4+shell,glass_width/4+shell,0])
        minkowski(){
            cylinder(glass_connector_holder_shell/2,glass_width/4+shell+kerf+glass_connector_holder_shell,glass_width/4+shell+kerf+glass_connector_holder_shell,$fn=fineness);
            cube(size=[glass_length,glass_width/2,glass_connector_holder_shell/2]);
        }
        
        if (screw_in_glass){
        translate([shell+comfort+glass_connector_holder_shell+comfort+glass_width/4,shell+comfort+glass_connector_holder_shell+comfort+screw_head/2,0])
        screw_hole();
            
        translate([shell+comfort+glass_connector_holder_shell+comfort+glass_width/4+screw_head+wire+wire_shell*2+comfort+light_board_length+comfort+wire+wire_shell*2+prevailing_width/2,shell+comfort+glass_connector_holder_shell+comfort+screw_head/2,0])
        screw_hole();
        
        }
            translate([
            shell+comfort+glass_connector_holder_shell+comfort+glass_width/4+(screw_in_glass?screw_head:0),
            shell+comfort+glass_connector_holder_shell+comfort+(prevailing_width-wire_shell*2-wire*2-comfort)/2,
            0])
    wire(glass_connector);


    translate([
            shell+comfort+glass_connector_holder_shell+comfort+glass_width/4+wire+wire_shell*2+comfort*2+(screw_in_glass?screw_head:0)+light_board_length,
            shell+comfort+glass_connector_holder_shell+comfort+(prevailing_width-wire_shell*2-wire*2-comfort)/2,
            0])
    wire(glass_connector);
    }
}

module glass_connector_holder_cutout(){
    
    translate([glass_width/4+shell,glass_width/4+shell,-0.001])
            minkowski(){
                cylinder(glass_connector/2+0.002,glass_width/4+shell+glass_connector_holder_shell,glass_width/4+shell+glass_connector_holder_shell,$fn=fineness);
                cube(size=[glass_length+glass_width/4-wire,glass_width/2,glass_connector/2+glass_connector_holder_shell]);
            }
}



module glass_connector_holder(){
    
    difference(){
        
        translate([glass_width/4+shell,glass_width/4+shell,0])
        minkowski(){
            cylinder(glass_connector/2,glass_width/4-comfort,glass_width/4-comfort,$fn=fineness);
            cube(size=[glass_length+glass_width/4,glass_width/2,glass_connector/2]);
        }
        
        translate([glass_width/4+shell,glass_width/4+shell,-.003])
        minkowski(){
            cylinder(glass_connector/2+0.006,glass_width/4-glass_connector_holder_shell-comfort,glass_width/4-glass_connector_holder_shell-comfort,$fn=fineness);
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

module glass_connector(){

    difference(){
        union(){
            

    color([0.9,0.85,0.8,1])
    translate([0,0,0])
    light_base();
            
    color([0,0.4,0.0,1])
    translate([shell+comfort+glass_connector_holder_shell+comfort+glass_width/4+wire+wire_shell*2+comfort+(screw_in_glass?screw_head:0),comfort+glass_connector_holder_shell+comfort+shell+((prevailing_width-light_board_width)/2),glass_connector_holder_shell])
    light_board();



    color([0.9,0.85,0.8,1]){
        translate([
                shell+comfort+glass_connector_holder_shell+comfort+glass_width/4+(screw_in_glass?screw_head:0),
                shell+comfort+glass_connector_holder_shell+comfort+(prevailing_width-wire_shell*2-wire*2-comfort)/2,glass_connector_holder_shell])
        wire_shell();


        translate([
                shell+comfort+glass_connector_holder_shell+comfort+glass_width/4+wire+wire_shell*2+comfort*2+(screw_in_glass?screw_head:0)+light_board_length,
                shell+comfort+glass_connector_holder_shell+comfort+(prevailing_width-wire_shell*2-wire*2-comfort)/2,glass_connector_holder_shell])
        wire_shell();
    }
            
    color([0.9,0.85,0.8,1])
    translate([0,0,glass_connector_holder_shell])
    glass_connector_holder();

    translate([0,0,glass_connector_holder_shell+connector_float])
    color([0.4,0.4,0.8,0.6])
    glass();


        }
        
        //light_board_crosssection();
    }  
    
}


module light_box(){
    /*
    translate([glass_connector_holder_shell+battery_bank_length/2-((glass_connector_holder_shell*2+kerf*2+glass_length))/2-wire/2,
        glass_connector_holder_shell+3*(battery_bank_width+box_corner*2)/4-(glass_connector_holder_shell*2+kerf+glass_width+shell*2)/2,battery_bank_depth+box_corner*2-glass_connector_holder_shell])
        glass_connector();
    */
    
    translate([(battery_bank_length+box_corner*2)/2,3*battery_bank_width/4+box_corner,battery_bank_depth+box_corner*2-glass_connector_holder_shell])
    {
        light();
    }

    color([0.9,0.85,0.8,1])
    difference(){

        translate([box_corner,box_corner,box_corner])
        minkowski(){
        cube(size=[battery_bank_length,battery_bank_width,battery_bank_depth+glass_connector]);
            sphere(box_corner,$fn=fineness);
        }

        translate([box_corner,box_corner,box_corner])
        minkowski(){
        cube(size=[battery_bank_length,battery_bank_width,battery_bank_depth]);
            sphere(box_corner-box_shell,$fn=fineness);
        }
        
        
        cube([battery_bank_length+box_corner*2+0.002,battery_bank_width+box_corner*2,(battery_bank_depth+box_corner*2)/2]);
        
        /*
        cube([(battery_bank_length+box_corner*2)/2,battery_bank_width+box_corner*2,battery_bank_depth+box_corner*2]);
        
        
        cube([battery_bank_length+box_corner*2,(battery_bank_width+box_corner*2)/2,battery_bank_depth+box_corner*2]);
        */
        
        /*
        translate([glass_connector_holder_shell+battery_bank_length/2-((glass_connector_holder_shell*2+kerf*2+glass_length))/2,
        glass_connector_holder_shell+3*(battery_bank_width+box_corner*2)/4-(glass_connector_holder_shell*2+kerf+glass_width+shell*2)/2,
    battery_bank_depth+box_corner*2-glass_connector_holder_shell])

        glass_connector_holder_cutout();
        */
        
    translate([(battery_bank_length+box_corner*2)/2,3*battery_bank_width/4+box_corner,battery_bank_depth+box_corner*2])
        centered_holder_cutout();
    
 
        /*

    translate([glass_connector_holder_shell+battery_bank_length/2-((glass_connector_holder_shell*2+kerf*2+glass_length))/2-wire/2,
        
    3*(battery_bank_width+box_corner*2)/4-(glass_connector_holder_shell*2+kerf*2+prevailing_width)/2-wire/2-wire/2,

    battery_bank_depth+box_corner*2-box_shell-0.1]){
        
    translate([])
        wires_move()wires(box_corner);
    }

*/  
     translate([(battery_bank_length+box_corner*2)/2,3*battery_bank_width/4+box_corner,battery_bank_depth+box_corner*2-box_shell-0.1])
        {
            centered_wires(4);
            screw_holes(4);
        }
    }

}


module battery(){
    translate([0,battery_width/2,battery_width/2])
    rotate([0,90,0]){
    cylinder(battery_length-battery_knob/2,battery_width/2,battery_width/2,$fn=fineness);
    
        translate([0,0,battery_length-battery_knob-0.001])
        cylinder(battery_knob+0.001,battery_knob_width/2,battery_knob_width/2,$fn=fineness);    
    }
}

module batteries(){
    for (i=[0:battery_count/2-1]){
        translate([0,(battery_width+battery_spacing)*i,0])
        battery();
    }

    for (i=[0:battery_count/2-1]){
        translate([0,(battery_width+battery_spacing)*i+cos(60)*(battery_width+battery_spacing),sin(60)*(battery_width+battery_spacing)])
        battery();
    }
}




module centered_glass(){
    translate([-glass_length/2-glass_width/2-comfort,-shell-glass_width/2,0])
    glass();
}

module centered_holder(){
    translate([-glass_length/2-glass_width/2-glass_connector_holder_shell+kerf/2,-glass_width/2-glass_connector_holder_shell-shell,0])
    translate([glass_connector_holder_shell,glass_connector_holder_shell,0])
    glass_connector_holder();
}

module centered_wire(length=1){
    translate([-wire/2-wire_shell,-wire_shell-wire-comfort/2,0])
    wire(length);
};

module centered_wires(length){
    translate([-light_board_length/2-comfort-wire_shell-wire/2,0,0])
    centered_wire(length);

    translate([light_board_length/2+comfort+wire_shell+wire/2,0,0])
    centered_wire(length);
}

module centered_wire_shell(){
    translate([-wire_shell-wire/2,-wire-comfort/2-wire_shell,0])
    wire_shell();
}

module centered_wire_shells(){
    translate([-light_board_length/2-comfort-wire_shell-wire/2,0,0])
    centered_wire_shell();
    
    translate([light_board_length/2+comfort+wire_shell+wire/2,0,0])
    centered_wire_shell();
}

module centered_lightboard(){
    translate([-light_board_length/2,-light_board_width/2,0])
    light_board();
}

module screw_holes(length=1){
    translate([-light_board_length/2-comfort-wire_shell*2-wire-comfort-screw_head/2,0,0])
    screw_hole(length);

    translate([light_board_length/2+comfort+wire_shell*2+wire+comfort+screw_head/2,0,0])
    screw_hole(length);
}

module screw_hole_pads(){
    translate([-light_board_length/2-comfort-wire_shell*2-wire-comfort-screw_head/2,0,0])
    screw_hole_pad();

    translate([light_board_length/2+comfort+wire_shell*2+wire+comfort+screw_head/2,0,0])
    screw_hole_pad();
}

module screw_hole_pad(height){
    translate([0,0,-0.001])
    cylinder(height+0.001,screw_head/2,screw_head/2,$fn=fineness);
}

module centered_light_base(){
    translate([-light_board_length/2-comfort-wire_shell*2-wire-comfort-screw_head-comfort-glass_width/4-glass_connector_holder_shell-comfort-shell-kerf-glass_connector_holder_shell,
    -prevailing_height/2-comfort-shell-kerf-glass_connector_holder_shell,
    0])
    translate([glass_connector_holder_shell,glass_connector_holder_shell,0])
    light_base();
}

module centered_base_plate(){
    translate([-glass_length/2-glass_width/2-glass_connector_holder_shell,-glass_width/2-shell-kerf-glass_connector_holder_shell,0])
    
    translate([glass_width/4+shell,glass_width/4+shell,0])
    translate([glass_connector_holder_shell+kerf/2,glass_connector_holder_shell+kerf,0])
    minkowski(){
        cylinder(glass_connector_holder_shell/2,glass_width/4+shell+glass_connector_holder_shell,glass_width/4+shell+glass_connector_holder_shell,$fn=fineness);
        cube(size=[glass_length+glass_width/4,glass_width/2,glass_connector_holder_shell/2]);
    }
}

module light(){
    difference(){
        
        union(){
            translate([0,0,glass_connector_holder_shell-0.001]){
            
            

            color([0.9,0.85,0.8,1]){
                    centered_holder();
                            
                    centered_lightboard();

                    //centered_wires(4);

                    centered_wire_shells();
                        if (screw_in_glass){
                        difference(){
                            screw_hole_pads();
                            
                            screw_holes();
                        }
                    }
                }
                
            }
            color([0.9,0.85,0.8,1]){
                difference(){
                    centered_base_plate();
                    centered_wires(4);
                    if (screw_in_glass){
                        screw_holes(4);
                    }
                }
            }
            
            
            translate([0,0,glass_connector_holder_shell-0.001])
            color([0.4,0.4,0.8,0.6])
            translate([+comfort/2+kerf,0,connector_float])
            centered_glass();
               
            
        }
    }
}


/*
translate([((battery_bank_length+box_corner*2)-battery_length)/2,box_corner,box_corner])
color([0.2,0.2,0.2,1])
batteries();
*/


//light_box();


/*
rotate([0,180,0])
translate([0,-glass_width/2-glass_connector_holder_shell-shell,0])
centered_holder();


*/

module battery_cutout(){
    translate([-battery_length/2,0,+battery_width/2+0.1])
    rotate([0,90,0])
    cylinder(battery_length,battery_width/2+comfort,battery_width/2+comfort,$fn=fineness);
}

module centered_battery(){
    translate([-battery_length/2,-battery_width/2,battery_hover])
    battery();
}


module battery_holder(){
    
    translate([0,0,battery_clip_shell]){
        
    difference(){
        union(){
        translate([-battery_length/2*3/4-battery_holder_shell,-sin(60)*battery_width/2,-0.001])
        cube(size=[battery_holder_shell,sin(60)*battery_width,battery_hover-1+cos(60)*battery_width/2+0.001]);

        translate([battery_length/2*3/4,-sin(60)*battery_width/2,-.001])
        cube(size=[battery_holder_shell,sin(60)*battery_width,battery_hover-1+cos(60)*battery_width/2+0.001]);

        }
    translate([0,0,battery_hover])
    battery_cutout();
    }
    
    centered_battery();
    
    translate([0,0,-0.001]){
        
        
    // Left Holder
    
    
        translate([-battery_clip_length/2,battery_width/2+comfort,-0.001])
        cube(size=[battery_clip_length,battery_clip_shell,battery_width/2+sin(battery_clip_angle)*battery_width/2+battery_hover+0.002]);
        
          translate([-battery_clip_length/2,battery_width/2+comfort-(battery_width/2+comfort - cos(battery_clip_angle)*battery_width/2),battery_width/2+sin(battery_clip_angle)*battery_width/2+battery_hover])
        cube(size=[battery_clip_length,battery_width/2-cos(battery_clip_angle)*battery_width/2+battery_clip_shell+comfort,battery_clip_shell]);
        
        
        
        // Right Holder
        
        
        translate([-battery_clip_length/2,-battery_width/2-comfort-battery_clip_shell,-0.001])
        cube(size=[battery_clip_length,battery_clip_shell,battery_width/2+sin(battery_clip_angle)*battery_width/2+battery_hover+0.002]);
        
        translate([-battery_clip_length/2,-1*(battery_width/2+comfort-(battery_width/2+comfort - cos(battery_clip_angle)*battery_width/2)+comfort)-(battery_width/2-cos(battery_clip_angle)*battery_width/2+battery_clip_shell),battery_width/2+sin(battery_clip_angle)*battery_width/2+battery_hover])
        cube(size=[battery_clip_length,battery_width/2-cos(battery_clip_angle)*battery_width/2+battery_clip_shell+comfort,battery_clip_shell]);
        
        
    }
    
    
    
    translate([0,0,-0.001]){
        
    // Positive Terminal
    
    translate([battery_length/2+comfort+battery_clip_shell+battery_clip_space,-battery_width/4,0])
    cube(size=[battery_clip_shell,battery_width/2,battery_width+battery_hover+battery_clip_shell+comfort]);
    
    translate([battery_length/2+comfort-comfort-battery_knob+0.001,-battery_width/4,battery_width+battery_hover-battery_clip_shell+battery_clip_shell+comfort])
    cube(size=[comfort+battery_knob+comfort+battery_clip_shell+battery_clip_space+0.001,battery_width/2,battery_clip_shell]);
   
    translate([battery_length/2+comfort,-battery_width/4,battery_hover])
    cube(size=[battery_clip_shell,battery_width/2,battery_width-battery_clip_shell+battery_clip_shell+comfort+0.001]);
  
    
    translate([battery_length/2,-battery_width/4,battery_width/2+battery_hover+battery_knob_width/2+comfort])
    cube(size=[battery_knob+comfort+0.001,battery_width/2,battery_clip_shell]);
    
    translate([battery_length/2,-battery_width/4,battery_width/2+battery_hover-battery_knob_width/2-battery_clip_shell-comfort])
    cube(size=[battery_knob+comfort+0.001,battery_width/2,battery_clip_shell]);
    
        
        
    // Negative Terminal 
        
        // Stand
    translate([-1*(battery_length/2+comfort+battery_clip_shell+battery_clip_space)-battery_clip_shell,-battery_width/4,0])
    cube(size=[battery_clip_shell,battery_width/2,battery_width+battery_hover+battery_clip_shell+comfort]);
    
        // Plate Knuckle
    translate([-1*(battery_length/2+comfort)-battery_clip_shell-battery_clip_space-0.001,-battery_width/4,battery_width+battery_hover-battery_clip_shell+battery_clip_shell+comfort])
    cube(size=[battery_clip_shell+battery_clip_space+comfort*2+0.001,battery_width/2,battery_clip_shell]);
   
        // Plate
    translate([-1*(battery_length/2+comfort)-battery_clip_shell,-battery_width/4,battery_hover+battery_clip_space])
    cube(size=[battery_clip_shell,battery_width/2,battery_width+comfort+battery_hover-battery_clip_shell+0.001]);
}  
    
    translate([0,0,-0.001])
    linear_extrude(0.4+0.001,convexity=10)
    text(battery_text,3,font = "Liberation Sans:style=Bold",halign="center",valign="center");

    translate([battery_length/2+(-battery_knob-comfort+comfort+battery_clip_shell+battery_clip_space+battery_clip_shell)/2,0,battery_hover+battery_width+comfort+battery_clip_shell-0.001])
    linear_extrude(0.4+0.001,convexity=10)
    text("+",3,font = "Liberation Sans:style=Bold",halign="center",valign="center");

    translate([-battery_length/2+comfort-(comfort*2+battery_clip_shell+battery_clip_space+battery_clip_shell)/2,0,battery_hover+battery_width+comfort+battery_clip_shell-0.001])
    linear_extrude(0.4+0.001,convexity=10)
    text("G",3,font = "Liberation Sans:style=Bold",halign="center",valign="center");

    // Base 
    translate([0,0,-battery_clip_shell/2])
    cube(size=[battery_length+comfort*2+battery_clip_shell*2+battery_clip_space*2+battery_clip_shell*2,battery_width+comfort*2+battery_clip_shell*2,battery_clip_shell],center=true);
    }
    
}

module centered_holder_cutout(){
    translate([-glass_length/2-glass_width/4-shell-kerf-comfort*2-glass_connector_holder_shell,-glass_width/2-shell-glass_connector_holder_shell,0])

    translate([glass_connector_holder_shell,glass_connector_holder_shell,0])
    glass_connector_holder_cutout();
}


//light();
//rotate([0,180,0])
//color([0.9,0.85,0.8,1])
battery_holder();
//light();