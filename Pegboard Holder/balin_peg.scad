// Global Parameters
inch=25.4; // One imperial inch in mm.

// Global Adjustment Parameter
tolerance = 5; // garbage?

// Hook Style
hook_type = "U"; // ["L":L-hook, "R":Round hook, "U":U-hook]
add_shelf_support = "Y"; // [N: No,Y: Yes]
arm_type = "C"; // "C"=cylindrical arm; "B"=box arm.

// Backing Description
hole_size = 0.375*inch*0.5; // [1:10]
backing_board = 0.25*inch; // Backboard thickness
peg_offset = 1*inch; // Hole spacing (Default 1/4")

// Arm Description
arm_length = 3*inch;
hook_width_percentage=100; // garbage?

// End Arm Description
end_arm_percentage=25; // garbage?
end_arm_length=arm_length*(end_arm_percentage/100);

// Peg Description
peg_radius=(hole_size-.5)/2;
peg_height=backing_board-.5-(tolerance/5);
sphere_size=peg_radius*2*(1+tolerance*0.007);

// Holding (top) Peg Description
sphere_standoff=sqrt(pow(sphere_size/2,2)-pow(peg_radius,2));
hold_peg_radius=peg_offset/4; // Top peg
hold_peg_theta=165; // TODO: compute angle


// Hanger Hook Description
hook_width=.25*inch;  //hole_size*(hook_width_percentage/100)-.5;
hook_drop=0;//peg_offset-hook_width;//peg_offset/4;
hook_radius=arm_length/2;
hook_theta=185;

// Hanger Backing Description
back_arm_z=sphere_standoff+backing_board+hook_width/2;
back_arm_drop=peg_offset+hook_width/2+peg_radius+hook_width+hook_drop;
back_arm_nodrop=peg_offset+hook_width/2+peg_radius;
back_arm_support=2*peg_offset+hook_width/2+peg_radius;

// Arm Support Brace Description
brace_adj=peg_offset-hook_drop-hook_width;
brace_length=sqrt(pow(arm_length+hook_width,2)+pow(brace_adj,2));
brace_angle=asin((brace_adj)/brace_length);
brace_offset=brace_length*sin(brace_angle)/2;

// garbage ?
object_width=hole_size*(hook_width_percentage/100)+(tolerance/10);
object_clipping=object_width/2+1;


module fit_peg()
{
    sphere(sphere_size/2,$fn=100);
    
    translate ([0,0,sphere_standoff])
    cylinder(h = backing_board, r1 = peg_radius, r2 = peg_radius,$fn=100);
}

module hold_peg(){
    translate ([peg_offset,0,sphere_standoff])
    cylinder(h = backing_board, r1 = peg_radius, r2 = peg_radius,$fn=100);
    
    translate([peg_offset,0,0])
    sphere(sphere_size/2,$fn=100);
    
    translate([peg_offset+hold_peg_radius,0,0])
    rotate([90,0,180])
    rotate_extrude(angle=-1*hold_peg_theta, convexity=10, center=true, $fn=100)
    translate([hold_peg_radius,0,0])
    circle(r=peg_radius, $fn=100); 
    
    translate([hold_peg_radius+peg_offset,0,0])
    rotate([0,-1*hold_peg_theta,0])
    translate([-1*hold_peg_radius,0,0])
    sphere(sphere_size/2,$fn=100);
}

module back_arm() {

    if ( add_shelf_support == "Y"){
        translate ([-1*(back_arm_support/2-peg_offset-peg_radius),0,back_arm_z])
        cube( size= [back_arm_support,hook_width,hook_width], center=true);
    }else if ( hook_type == "R" ) {
        translate ([-1*(back_arm_nodrop/2-peg_offset-peg_radius),0,back_arm_z])
        cube( size= [back_arm_nodrop,hook_width,hook_width], center=true);
    }else{
        translate ([-1*(back_arm_drop/2-peg_offset-peg_radius),0,back_arm_z])
        cube( size= [back_arm_drop,hook_width,hook_width], center=true);
    }
}

module arm() {
translate ([-15.75,0,arm_length/2+5]) 
    //cube( size= [hook_width,hook_width,arm_length], center=true);
    cylinder(arm_length,hook_width/2,hook_width/2,center=true,$fn=100);
}

module end_arm() {
    translate ([-1*(hook_drop+hook_width)+(end_arm_length/2),0,arm_length+5])
    cube( size= [end_arm_length+hook_width,hook_width,hook_width], center=true);
}

module cylinder_arm() {
    arm_z=sphere_standoff+backing_board+hook_width*1.25;
    translate ([-1*(hook_drop+hook_width),0,arm_length/2+arm_z]) 
    cylinder(arm_length+hook_width/2,hook_width/2,hook_width/2,center=true,$fn=100);
    
    translate ([-1*(hook_drop+hook_width),0,arm_length+arm_z+0.25*hook_width]) 
    sphere(hook_width/2,center=true,$fn=100);
}

module cylinder_end_arm() {
    end_arm_height=arm_length+sphere_standoff+backing_board+hook_width*1.5;
    translate ([-1*(hook_drop+hook_width)+(end_arm_length/2),0,end_arm_height])
    rotate([0,90,0])
    cylinder(end_arm_length,hook_width/2, hook_width/2,center=true,$fn=100);
    
    translate([-1*(hook_drop+hook_width)+(end_arm_length),0,end_arm_height])
    sphere(hook_width/2,center=true,$fn=100);
}

module hook() {
	translate ([-1*peg_radius,0,hook_radius+back_arm_z])
    rotate(a=[90,90,0])
	rotate_extrude(angle=-1*hook_theta, convexity = 10, $fn = 100)
    translate([hook_radius, 0, 0])
    square(size=hook_width, center=true, $fn = 100);
}

module brace_arm() {
	translate ([-1*peg_offset,0,0])
    fit_peg();
    //brace_length=25;
    
    translate ([brace_offset-peg_offset,0,(brace_length*cos(brace_angle))/2+backing_board+sphere_standoff+hook_width/2])
	rotate([0,brace_angle,0])
    cube( size= [hook_width,hook_width,brace_length], center=true);
}

module brace() {
difference() {
    brace_arm();
    //translate ([-15.75+hook_width,0,arm_length/2+5])
    //cube( size= [hook_width,hook_width+2,arm_length], center=true);
}
}

// The Whole Enchilada

/*
rotate(a=[90,0,0])
difference() {
union() {
translate ([inch-peg_offset,0,0])fit_peg();
translate ([inch,0,0]) fit_peg();
if ( add_shelf_support == "Y" && peg_item != "R") { brace(); }
back_arm();
if ( peg_item == "L" || peg_item == "B" || peg_item == "U" ) { arm(); }
if ( peg_item == "R" || peg_item == "B") { hook(); }
if ( peg_item == "U" ) { end_arm(); }

}
translate ([0,-object_clipping,0]) cube( size= [190,3,190], center=true); // clipping plane
translate ([0,object_clipping,0]) cube( size= [190,3,190], center=true); // clipping plane
}
*/

module pegboard_hook(){
rotate([90,0,0]){
    if (hook_type == "L"){
        fit_peg();
        hold_peg();
        back_arm();
        cylinder_arm();
    }
    
    if (hook_type == "U"){
        fit_peg();
        hold_peg();
        back_arm();
        cylinder_arm();
        cylinder_end_arm();
    }
    
    if (hook_type == "R"){
        fit_peg();
        hold_peg();
        back_arm();
        hook();
    }
    if (add_shelf_support=="Y"){
        brace();       
    }
}
}

union(){
    pegboard_hook();
    //translate([0,0,peg_offset])
    //pegboard_hook();
}