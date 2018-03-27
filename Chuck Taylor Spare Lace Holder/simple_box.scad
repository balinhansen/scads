inch=25.4;
thickness=0.5;
width=3/8*inch;
height=15/16*inch;
depth=2.5*inch;

module end(){
    translate([width+thickness,height+thickness,0])
    sphere (thickness/2,center=true,$fn=100);
    
    translate([width+thickness,0,0])
    sphere (thickness/2,center=true,$fn=100);
    
    translate([0,height+thickness,0])
    sphere (thickness/2,center=true,$fn=100);
    
    sphere (thickness/2,center=true,$fn=100);
    
    rotate([0,90,0])
    cylinder(width+thickness,thickness/2,thickness/2,$fn=100);
    
    translate([0,height+thickness,0])
    rotate([0,90,0])
    cylinder(width+thickness,thickness/2,thickness/2,$fn=100);
    
    rotate([-90,0,0])
    cylinder(height+thickness,thickness/2,thickness/2,$fn=100);
    
    translate([width+thickness,0,0])
    rotate([-90,0,0])
    cylinder(height+thickness,thickness/2,thickness/2,$fn=100);
    
}

module bars(){
    translate([width+thickness,height+thickness,0])
    cylinder(depth-thickness,thickness/2,thickness/2,$fn=100);
    
    translate([0,height+thickness,0])
    cylinder(depth-thickness,thickness/2,thickness/2,$fn=100);
    
    translate([width+thickness,0,0])
    cylinder(depth-thickness,thickness/2,thickness/2,$fn=100);
    
    cylinder(depth-thickness,thickness/2,thickness/2,$fn=100);
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