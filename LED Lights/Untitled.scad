inch=25.4;

light_length=50;
light_width=7.5;

rings=4;
ring_spacing=1;

fineness=90;
shell=1;

module light_mount(){
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

difference(){
    light_mount();
    //translate([0,0,-0.001])
    //cube([10,10,10+0.001]);
}