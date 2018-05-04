inch=25.4;
thickness=0.5;
width=3/8*inch;
height=15/16*inch;
depth=2.5*inch;

fineness=100;

module end(){
    translate([width+thickness,height+thickness,0])
    sphere (thickness/2,center=true,$fn=fineness);
    
    translate([width+thickness,0,0])
    sphere (thickness/2,center=true,$fn=fineness);
    
    translate([0,height+thickness,0])
    sphere (thickness/2,center=true,$fn=fineness);
    
    sphere (thickness/2,center=true,$fn=fineness);
    
    rotate([0,90,0])
    cylinder(width+thickness,thickness/2,thickness/2,$fn=fineness);
    
    translate([0,height+thickness,0])
    rotate([0,90,0])
    cylinder(width+thickness,thickness/2,thickness/2,$fn=fineness);
    
    rotate([-90,0,0])
    cylinder(height+thickness,thickness/2,thickness/2,$fn=fineness);
    
    translate([width+thickness,0,0])
    rotate([-90,0,0])
    cylinder(height+thickness,thickness/2,thickness/2,$fn=fineness);
    
}

module bars(){
    translate([width+thickness,height+thickness,0])
    cylinder(depth-thickness,thickness/2,thickness/2,$fn=fineness);
    
    translate([0,height+thickness,0])
    cylinder(depth-thickness,thickness/2,thickness/2,$fn=fineness);
    
    translate([width+thickness,0,0])
    cylinder(depth-thickness,thickness/2,thickness/2,$fn=fineness);
    
    cylinder(depth-thickness,thickness/2,thickness/2,$fn=fineness);
}

module sides(){
    translate([0,-thickness/2,0])
    cube(size=[width+thickness,thickness,depth-thickness]);
    
    translate([0,height+thickness/2,0])
    cube(size=[width+thickness,thickness,depth-thickness]);
    
    translate([-thickness/2,0,0])
    cube(size=[thickness,height+thickness,depth-thickness]);
    
    translate([width+thickness/2,0,0])
    cube(size=[thickness,height+thickness,depth-thickness]);
}

module box(){
    translate([0,0,depth-thickness])
    end();

    end();

    bars();
    sides();
}

union() box();