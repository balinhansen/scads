inch=25.4;
fineness=50;
wire_fineness=40;

turn=0.375*inch;
wire=2.589;
gap=(2+5/8)*inch;
wave=(5+3/4)*inch;
fingers=6.5*inch;
angle=22.4;
holder=1.2;
divisions=3;
cut=2;
lip=0.2;
clearance=0.1;



module slice(angle=360){         
    for (i=[0:divisions]){
        rotate([0,0,i*angle/divisions])
        translate([0,-cut/2,-0.001])
        children();
    }
}

module wire_holder(){

    rotate([0,0,90+angle/2])
    translate([0,0,-holder-wire/2])
    difference(){
        
        cylinder(wire+holder*2+clearance*2,turn/2+wire+holder,turn/2+wire+holder,$fn=fineness);
        
        translate([0,0,holder])
        slice(180-angle)
        cube(size=[turn/2+wire+holder+0.001,cut,wire+holder*2+0.002]);
        
        translate([0,0,-0.001])
        cylinder(wire+holder*2+clearance*2+0.002,turn/2-holder,turn/2-holder,$fn=fineness);
        
        translate([0,0,wire/2+holder+clearance])
    rotate_extrude(angle=360,convexity=10)
        translate([wire/2+turn/2,0,0])
        circle(wire/2+clearance,$fn=wire_fineness);
        
        translate([0,0,wire/2+holder-0.001])
        difference(){
            
            cylinder(wire+holder*2+0.002,turn/2+wire-lip,turn/2+wire-lip,$fn=fineness);
            translate([0,0,-0.001])
            cylinder(wire+holder*2+0.004,turn/2+lip,turn/2+lip,$fn=fineness);
        }
        
        rotate([0,0,180-angle])
        translate([0,0,holder])
        rotate_extrude(angle=180+angle,$fn=fineness,convexity=10)
        square([turn+wire/2,wire+holder+clearance*2+0.001]);
        
    rotate([0,0,90-angle/2])
        translate([turn/2+wire+wire/2,turn/2+wire+holder+clearance,holder+wire/2+clearance])
        rotate([90,0,0])
        cylinder(turn+wire*2+holder*2+clearance*4,wire/2+clearance,wire/2+clearance,$fn=wire_fineness);


    }
}




module whisker_right(){

%rotate([0,0,90+angle/2])
    translate([0,0,clearance])
rotate_extrude(angle=180-angle,$fn=fineness,convexity=10)
translate([turn/2+wire/2,0,0])
circle(wire/2,$fn=wire_fineness);

%rotate([0,0,90+angle/2])
translate([turn/2+wire/2,0,clearance])
rotate([90,0,0])
linear_extrude(fingers,convexity=10)
circle(wire/2,$fn=wire_fineness);

%rotate([0,0,90-angle/2])
translate([-turn/2-wire/2,0,clearance])
rotate([90,0,0])
linear_extrude(fingers,convexity=10)
circle(wire/2,$fn=wire_fineness);
    
    wire_holder();
}

module whisker_left(){
    rotate([0,0,180])
    whisker_right();
}


module whisker_pair(){
translate([gap/2,0,wire/2+holder])
whisker_right();
translate([-gap/2,0,wire/2+holder])
whisker_left();
    translate([0,0,holder/2])
    cube(size=[gap+turn+holder*2+wire*2,turn+wire*2+holder*2,holder],center=true);
    }
    
for (i=[0:0-6
    ]){
    translate([0,wave*i,0])
    whisker_pair();
}