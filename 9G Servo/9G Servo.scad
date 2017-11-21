servo_box_length=22.5;
servo_box_width=11.8;
servo_box_height=22.7;

servo_cog_height=4;
servo_lcog_radius=11.8/2;
servo_scog_radius=5/2;
servo_scog_offset=2.9;

falange_length=4.7;
falange_height=2.5;
falange_offset=18.4-falange_height;

falange_screw_offset=2.3;
falange_screw_radius=2/2;
falange_screw_slot=1.3;

horn_height=3.2;
horn_radius=4.6/2;

module servo_falange(){    
    difference(){
        cube(size=[falange_length,servo_box_width,falange_height]);
        
        translate([falange_screw_offset,servo_box_width/2,-1])
        cylinder(falange_height+2,falange_screw_radius,falange_screw_radius,$fn=100);
        
        translate([-1,servo_box_width/2-falange_screw_slot/2,-1])
        cube(size=[1+falange_screw_offset,falange_screw_slot,falange_height+2]);
    }
}

module servo(){
    
    // Servo Box
    translate([falange_length,0,0])
    cube(size=[servo_box_length,servo_box_width,servo_box_height]);
    
    // Large Cog
    translate([servo_lcog_radius+falange_length,servo_box_width/2,servo_box_height])
    cylinder(servo_cog_height,servo_lcog_radius,servo_lcog_radius,$fn=100);
    
    // Small Cog
    translate([servo_lcog_radius*2+falange_length+servo_scog_offset,servo_box_width/2,servo_box_height])
    cylinder(servo_cog_height,servo_scog_radius,servo_scog_radius,$fn=100);
    
    translate([servo_lcog_radius*2+falange_length+servo_scog_offset-servo_scog_radius,servo_box_width/2,servo_box_height+2])
    cube(size=[servo_scog_radius*2,servo_scog_radius*2,servo_cog_height],center=true);
   
    // Obverse Falange
    translate([0,0,falange_offset])
    servo_falange();
    
    // Reverse Falange
    translate([servo_box_length+falange_length*2,servo_box_width,falange_offset])
    rotate([0,0,180])
    servo_falange();
    
    // Horn Mount
    translate([falange_length+servo_lcog_radius,servo_box_width/2,servo_box_height+servo_cog_height])
    cylinder(horn_height,horn_radius,horn_radius,$fn=100);
}

servo();