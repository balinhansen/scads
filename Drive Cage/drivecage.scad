inch=25.4;
drives=6;
thickness=1.6;

bar_fineness=128;
width=0.5*inch;
height=1*inch;
gap=0.75*inch;
bracket=1.6;
bracket_depth=0.2*inch;
bracket_angle=30;
kerf=0.0035*inch;

screw_hole=3.5052+0.2+0.5;
screw_fineness=64;
screw_height=6.35+0.25+kerf;
screw_dist=101.60;
screw_head=8;
bracket_a=1.125*inch;
bracket_b=1.125*screw_dist;

foot_width=inch;
foot_fineness=128;

bevel=gap/14;
bevel_fineness=32;

if (tan(bracket_angle)*bracket_depth+bracket > gap){
    echo("gap too long, suggested angle: ");
    echo(atan((gap/2-bracket)/bracket_depth));
}

module bar(){
    translate([gap/2,0,width/4]){
    difference(){
    
        translate([-gap/2,0,0])
    union(){    
    cube([drives*inch+drives*gap,width,thickness]);
        scale([1,1,0.5])
        translate([0,width/2,0])
        rotate([0,90,0])
        difference(){
        cylinder(drives*inch+drives*gap,width/2,width/2,$fn=bar_fineness);
            translate([-width/2,-width/2,-0.001])
            cube([width/2-0.001,width,drives*inch+drives*gap+0.002]);
            }
    }
        for (i=[0:drives-1]){
            translate([gap/2+i*(height+gap)+screw_height,width/2,-0.001])
            cylinder(thickness+0.002,screw_hole/2,screw_hole/2,$fn=screw_fineness);
            
            translate([gap/2+i*(height+gap)+screw_height,width/2,-width/4-0.001])
            cylinder(width/4+0.001,screw_head/2,screw_head/2,$fn=screw_fineness);
        }
    }
    
    for (i=[0:drives-1]){
        translate([gap/2+i*(height+gap),width,thickness])
        rotate([90,0,0])
        linear_extrude(width,convexity=10)
        polygon([[0,-0.001],[0,bracket_depth],[-1*bracket,bracket_depth],[-bracket-tan(bracket_angle)*bracket_depth,0],[-bracket-tan(bracket_angle)*bracket_depth,-0.001]]);
    }
}
}

module drive(){
    cube([1*inch,5.75*inch,4*inch]);
}

module holder(){
    
bar();

translate([0,0,(width/4+thickness)/2]){
rotate([0,90,0])
translate([0,width/2,gap/7])
    scale([1,1,((foot_width-foot_width/7)/2)/foot_width])
    difference(){
sphere(foot_width/2,$fn=foot_fineness);
        translate([0,0,-foot_width/4])
        cube([foot_width,foot_width,foot_width/2],center=true);
    }
    

rotate([0,90,0])
translate([0,width/2,gap/14])
cylinder(gap/14,foot_width/2,foot_width/2,$fn=foot_fineness);

rotate([0,90,0])
translate([0,width/2,gap/14])
    minkowski(){
cylinder(0.001,foot_width/2-bevel,foot_width/2-bevel,$fn=foot_fineness);
    sphere(bevel,$fn=bevel_fineness);
    }
}
}

module cage(){

translate([0,bracket_a-width/2,0])
holder();

translate([0,bracket_b-width/2,0])
holder();


for (i=[0:drives-1]){
    translate([gap+i*(height+gap),0,thickness+width/4+kerf])
    color([0.5,0.5,0.5,0.3])
    drive();
}

}


//rotate([0,-90,0])
//cage();

rotate([90,0,0])
holder();