inch=25.4;
thickness=0.8;
cap_width=32;
cap_height=17;

module cap(){
        
    difference(){
        cylinder(cap_height+thickness,cap_width/2+thickness,cap_width/2+thickness,$fn=200);
        translate([0,0,thickness])
            cylinder(cap_height+0.001,cap_width/2,cap_width/2,$fn=200);
    }
}

module support(){
    difference(){
        cylinder(thickness+75,100/2,100/2,$fn=2000);
        translate([0,0,thickness])
        cylinder(thickness+75+0.002,100/2-thickness,100/2-thickness,$fn=2000);
    }
}

union(){
    cap();
    support();
}
