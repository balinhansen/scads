inch = 25.4;
disk_radius=.375*inch/2;
//disk_thickness=inch/64*3-0.2;
disk_bottom_radius=inch*0.118/2;
disk_top_radius=inch*0.279/2;

disk_thickness=(disk_top_radius-disk_bottom_radius)*tan(41/180*atan(1)*4);

echo(disk_thickness);

peg_radius=.125*inch/2;
peg_length=inch/8;

cladding=2;

back_plate=2;

horizontal_spacing=2*inch;
vertical_spacing=4.625*inch;


outlet_radius=.69*inch;
outlet_height=1.12*inch;
outlet_spacing=.41*inch;
outlet_depth=10;

outlet_plate_width=2.75*inch;
outlet_plate_height=4.5*inch;
outlet_plate_depth=.25*inch;

outlet_screw_radius=0.15*inch/2;

module outlet(){
    difference(){
        cylinder(10,outlet_radius,outlet_radius,center=true,$fn=100);
        
        translate([outlet_spacing/2+outlet_height/2,0,0])
        cube(size=[outlet_spacing,outlet_radius*2,12],center=true);
         
        translate([-outlet_spacing/2+-outlet_height/2,0,0])
        cube(size=[outlet_spacing,outlet_radius*2,12],center=true);
    }
}

module tap_plate(){
    difference(){
        cube(size=[outlet_plate_height,outlet_plate_width,
          outlet_plate_depth]);
        
        translate([outlet_height/2+outlet_spacing/2+outlet_plate_height/2,outlet_plate_width/2,outlet_depth/2-1])
        outlet();
        
        translate([-outlet_height/2+-outlet_spacing/2+outlet_plate_height/2,outlet_plate_width/2,outlet_depth/2-1])
        outlet();
        
        translate([outlet_plate_height/2, outlet_plate_width/2,outlet_depth/2-1])
        cylinder(10, outlet_screw_radius,outlet_screw_radius,center=true,$fn=100);
    }
}

module disk(){
    cylinder(disk_thickness,disk_bottom_radius,disk_top_radius,center=true,$fn=100);
}

module peg(){
    cylinder(peg_length,peg_radius,peg_radius,center=true,$fn=100);
}

module cladding(){
    translate([0,horizontal_spacing/2,cladding/2])
    
    cube(size=[peg_radius*2+cladding*2,peg_radius*2+cladding*2+horizontal_spacing,cladding],center=true);
}

module tap_brace(){
    translate([0,0,cladding+peg_length+disk_thickness/2])
    disk();
    
    translate([0,0,cladding+peg_length/2])
    peg();
}

module tap_bracket(){
    translate([0,horizontal_spacing,0])
    tap_brace();

    tap_brace();
    
    cladding();

}

module tap_mount(){
    translate([vertical_spacing,0,0])
    tap_bracket();
    
    tap_bracket();
}


//tap_plate();
tap_mount();