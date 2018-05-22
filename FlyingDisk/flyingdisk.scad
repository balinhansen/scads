module ferooil(){
    difference(){
        
        cylinder(0.4,50,50,$fn=240);
        translate([0,0,-0.001])
        cylinder(0.402,30,30,$fn=240);
        
        translate([0,0,-0.001])
        difference(){
            cylinder(0.201,45,45,$fn=240);
            translate([0,0,-0.001])
            cylinder(0.203,35,35,$fn=240);
        }
    }




    translate([0,0,0.4-0.001])
    difference(){
        cylinder(0.101,47.5,47.5,$fn=240);
        translate([0,0,-0.001])
        cylinder(0.103,32.5,32.5,$fn=240);
    }


    translate([0,0,0.5-0.001])
    difference(){
        cylinder(0.101,45,45,$fn=240);
        translate([0,0,-0.001])
        cylinder(0.103,35,35,$fn=240);
    }
}

module flattest(){
    
    difference(){
        
        cylinder(0.3,50,50,$fn=240);
        translate([0,0,-0.001])
        cylinder(0.302,30,30,$fn=240);
        
    }
   
}

module aerotop(){
        flattest();
    for (i=[0:2]){
        rotate([0,0,120*i])
        translate([0,-5/2,0])
        cube([30+0.001,5,0.3]);
    }
    translate([0,0,0.3-0.001])
    cylinder(30,3/2,3/2,$fn=40);
}

//ferooil();
//flattest();
aerotop();
