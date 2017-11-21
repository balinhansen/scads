inch=25.4;
kerf=0.007*inch;

fineness_stl=200;
fineness_low=40;

thickness=1.2;

build_stl=true;

width=39.5;
height=3.4;
stack=.5;
slip=.5;

radius=width/2;

outer_edge=radius+thickness*2+kerf*2;

conn_inner_edge=radius+thickness+kerf*2;

stack_edge=radius+thickness+kerf;

fineness=build_stl?fineness_stl:fineness_low;


module ingot(){
    cylinder(height,radius,radius,$fn=fineness);
}

module bottom(){
    difference(){
        cylinder(height/2+thickness+stack,outer_edge,outer_edge,$fn=fineness);
        translate([0,0,stack+thickness])
        ingot();
        //translate([0,0,-0.001])
        //cylinder(stack+0.001,radius,radius,$fn=fineness);
       difference(){
            translate([0,0,stack+thickness+height/4])
            cylinder(height/2,outer_edge+0.001,outer_edge+0.001,$fn=fineness);
            translate([0,0,stack+thickness+height/4-0.001])
            cylinder(height/2+0.002,conn_inner_edge-kerf,conn_inner_edge-kerf,$fn=fineness);
        }
        translate([0,0,-0.001])
        cylinder(stack+0.001,stack_edge+slip/2,stack_edge+slip/2,$fn=fineness);
    }
}

module top(){
    difference(){
        cylinder(height/2+thickness+stack,outer_edge,outer_edge,$fn=fineness);
        translate([0,0,-height/2-0.001])
        ingot();
        
        translate([0,0,height/2+thickness])
        cylinder(stack+0.001,radius,radius,$fn=fineness);
        
        
        difference(){
            translate([0,0,height/2+thickness+0.001])
            cylinder(stack,outer_edge+0.001,outer_edge+0.001,$fn=fineness);
            translate([0,0,height/2+thickness-0.001])
            cylinder(stack+0.002,stack_edge-slip/2,stack_edge-slip/2,$fn=fineness);
        }
        
        translate([0,0,-0.001])
        cylinder(height/4+0.001,conn_inner_edge+kerf,conn_inner_edge+kerf,$fn=fineness);
    }
}


//color([0.5,0.5,0.5,0.5])
translate([0,0,(stack+thickness+height/2)*3])
top();

//color([0.5,0.5,0.5,0.5])
translate([0,0,(stack+thickness+height/2)*2])
bottom();


//color([0.5,0.5,0.5,0.5])
translate([0,0,(stack+thickness+height/2)*1])
top();

//color([0.5,0.5,0.5,0.5])
bottom();

