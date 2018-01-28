inch=25.4;

light_length=100;
light_width=7.5;

rings=3;
ring_spacing=1;

fineness=90;
shell=1;

module light_mount(rings){
    difference(){
        cylinder(rings*light_width+(rings+1)*ring_spacing,light_length/PI/2-1/16*inch,light_length/PI/2-1/16*inch,$fn=fineness);

        translate([0,0,-0.001])
        cylinder(rings*light_width+(rings+1)*ring_spacing+0.002,light_length/PI/2-1/16*inch-shell,light_length/PI/2-1/16*inch-shell,$fn=fineness);
            
        for (i=[0:rings-1]){
            
            translate([0,0,i*(light_width+ring_spacing)+ring_spacing-0.001+shell])
            cylinder(light_width-shell*2,light_length/PI/2-shell,light_length/PI/2-shell,$fn=fineness);
            
        }
   }


    for (i=[0:rings-1]){
        difference(){
            translate([0,0,i*(light_width+ring_spacing)+ring_spacing])
            cylinder(light_width,light_length/PI/2,light_length/PI/2,$fn=fineness);
            
            translate([0,0,i*(light_width+ring_spacing)+ring_spacing-0.001])
            cylinder(light_width+0.002,light_length/PI/2-1/16*inch-shell,light_length/PI/2-1/16*inch-shell,$fn=fineness);
        
            translate([0,0,i*(light_width+ring_spacing)+ring_spacing-0.001+shell])
            cylinder(light_width-shell*2,light_length/PI/2-shell,light_length/PI/2-shell,$fn=fineness);
            
        }
    
    }

}

    light_mount(1);

translate([-light_width/2-ring_spacing,0,light_width+ring_spacing*2])
rotate([0,90,0])
difference(){
    light_mount(1);
    translate([0,-20,-0.001])
    cube([20,40,10+0.001]);
}

rotate([0,180,0])
translate([-light_width/2-ring_spacing,0,0])
rotate([0,90,0])
difference(){
    light_mount(1);
    translate([0,-20,-0.001])
    cube([20,40,10+0.001]);
}



translate([light_width/2+ring_spacing,0,light_width/2+ring_spacing])
rotate([0,90,0])
rotate([0,0,90])
translate([-light_width/2-ring_spacing,0,0])
rotate([0,90,0])
difference(){
    light_mount(1);
    translate([0,-20,-0.001])
    cube([20,40,10+0.001]);
}


translate([-light_width/2-ring_spacing,0,light_width/2+ring_spacing])
rotate([0,-90,0])
rotate([0,0,90])
translate([-light_width/2-ring_spacing,0,0])
rotate([0,90,0])
difference(){
    light_mount(1);
    translate([0,-20,-0.001])
    cube([20,40,10+0.001]);
}