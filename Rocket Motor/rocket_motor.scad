// Rocket Motor Sizes: A: 13, A/B/C: 18, D/E; 20, E/F/G: 24, F/G/H/I 29, G/H/I/J 38, I/J/K/L 54


inch=25.4;
length=649;
outer_radius=27;
inner_radius=23;
fineness=34;

ring_width=2;
ring_depth=0.5;
ring_spacing=3;
rings_top_length=inch;
rings_bottom_length=inch*2;

module tube(){
    difference(){
        cylinder(length,outer_radius,outer_radius,$fn=fineness);
     translate([0,0,-0.01])
        cylinder(length+0.02,inner_radius,inner_radius,$fn=fineness);
    
        for (i=[0:floor(rings_bottom_length/(ring_width+ring_spacing))-1]){
            translate([0,0,ring_spacing+i*(ring_width+ring_spacing)])
            cylinder(ring_width,inner_radius+ring_depth,inner_radius+ring_depth);
        }
 
        for (i=[0:floor(rings_top_length/(ring_width+ring_spacing))-1]){
            translate([0,0,length-ring_spacing-ring_width-i*(ring_width+ring_spacing)])
            cylinder(ring_width,inner_radius+ring_depth,inner_radius+ring_depth);
        }
        
        }
    
}

tube();