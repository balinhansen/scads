inch=25.4;
kerf=0.0035*inch*2;
gold=1.61803398875;

fineness_stl=200;
fineness_low=40;

build_stl=false;

fineness=build_stl?fineness_stl:fineness_low;

module ringa(){
    difference(){
        
        cylinder(1/2*inch,1/4*inch,1/4*inch,$fn=fineness);
        translate([0,0,-0.001])
        cylinder(1/2*inch+0.002,1/4*inch-0.8,1/4*inch-0.8,$fn=fineness);
        
    }
}

module ringb(){
    difference(){
        cylinder(1/2*inch,1/4*inch-0.8-kerf,1/4*inch-0.8-kerf,$fn=fineness);
    translate([0,0,-0.001])
        cylinder(1/2*inch+0.002,1/4*inch-1.6-kerf,1/4*inch-1.6-kerf,$fn=fineness);
    }
}

//ringa();
ringb();