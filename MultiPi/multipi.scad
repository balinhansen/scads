inch=25.4;
shell=1.2;
hover=0.1;
kerf=0.0035*inch*2.5;

small_fineness=40;
fineness=80;

board_length=85;
board_width=56;
board_thickness=1/16*inch;
board_clearance=1/8*inch;


holder_comfort=0.25;
holder_stand=0.5;


case_length=3.5*inch;
case_width=2.5*inch;


corner=1/8*inch;

shortest=case_length-board_length >= case_width-board_width?case_width-board_width:case_length-board_length;

shortest_test=shortest>(shell+holder_comfort)?true:false;

shortest_edge=shortest_test?shortest:shell;




pi_b_seam=8;





if (shortest_test==false){
    echo("Notes: Invalid case dimension, defaulting to shell thickness.");
}
    
module board(){
    difference(){
        cube(size=[board_length,board_width,board_thickness]);
        pi_b_screws();
    }
}




module holder_void(){
    square(size=[board_length+holder_comfort*2,board_width+holder_comfort*2]);
}

module holder_center(){
    translate([(case_length-board_length-holder_comfort*2)/2,(case_width-board_width-holder_comfort*2)/2])
    children();
}

module holder_stand_shape(){
    difference(){
        offset(r=shell, $fn=small_fineness)
        holder_void();
        offset(r=-holder_comfort-holder_stand, $fn=small_fineness)
        holder_void();
    }
}

module holder_shape(){
    difference(){
        offset(r=shell, $fn=small_fineness)
        holder_void();
        holder_void();
    }
}

module holder_plate(){
    linear_extrude(shell,convexity=10)
    offset(r=shell, $fn=small_fineness)
    holder_void();
}



module case_shape(){
    minkowski(){
        translate([corner,corner,0])
    cube(size=[case_length-corner*2,case_width-corner*2,shell]);
        sphere(corner,$fn=small_fineness);
    }
}
    
    
module case_center(){
    translate([(case_length-board_length)/2,(case_width-board_width)/2,0])
    children();
}


module m2p5_screw(length){
    cylinder(length,1.5,1.5,$fn=small_fineness);
}

module m2p5_stand(length,width,hole){
    difference(){
        translate([0,0,-0.001])
        cylinder(length+0.001,width/2,width/2,$fn=small_fineness);
        translate([0,0,-0.002])
        cylinder(length+0.003,hole/2,hole/2,$fn=small_fineness);
    }
}

module pi_b_screw_positions(){
    translate([25.5,18])
    children();
    
    translate([80,43.5])
    children();
}

module pi_b_screws(){
    translate([0,0,-0.001])
    pi_b_screw_positions()
    m2p5_screw(board_thickness+0.002);
}

module hdmi_cutout(cutout_length){
    rotate([90,0,0])
    translate([0,0,-holder_stand-holder_comfort-0.001])
    linear_extrude(cutout_length,convexity=10)
    offset(delta=0.5)
    polygon(
    points=[
    [0,1],
    [1,1],
    [2,0],
    [13,0],
    [14,1],
    [15,1],
    [15,5],
    [0,5]
    ]);
}

module sd_cutout(cutout_length){
    rotate([0,0,90])
    translate([0,+0.001,-4])
    cube(size=[25,cutout_length+0.002,4+0.001]);
    
    rotate([0,0,90])
    translate([-4,-cutout_length+shell+holder_stand+holder_comfort-0.001,-4])
    cube(size=[31.5,-shell+cutout_length+0.002,4+0.001]);
}

module usb_micro_b_cutout(cutout_length){
    translate([-shell-0.001,0,0])
    rotate([90,0,90])
    linear_extrude(cutout_length+0.002,convexity=10)
    offset(delta=0.5)
    polygon(points=[[1,0],[7,0],[8,1],[8,3],[0,3],[0,1]]);
}

module rca_cutout(cutout_length){
    rotate([90,0,180])
    translate([0,4.5,-holder_comfort-holder_stand])
    cylinder(cutout_length,5,5,$fn=fineness);
}

module 3p5_trs_cutout(cutout_length){
    rotate([90,0,180])
    translate([0,4,-holder_comfort-holder_stand])
    cylinder(cutout_length,4,4,$fn=small_fineness);
}

module ethernet_cutout(cutout_length){
    translate([-holder_comfort-holder_stand-0.001,-0.5,-0.5])
    cube(size=[cutout_length,17,14.75]);
}

module usb_dual_a_cutout(cutout_length){
    translate([-holder_comfort-holder_stand-0.001,-0.5,-0.5])
    cube(size=[cutout_length,14.25,17.5]);
}


module pi_b_cutouts(){
    cutout_length=shell+holder_stand+holder_comfort+0.002;
    
    translate([36,0,shell+board_clearance+board_thickness+hover])
    holder_center()
    hdmi_cutout(cutout_length);
    
    
    //translate([holder_stand+holder_comfort,17.5-shell+0.001,shell+board_clearance])
    translate([holder_stand+holder_comfort-0.001,17-shell+0.001,shell+board_clearance])
    holder_center()
    sd_cutout(cutout_length);
    
    translate([0,3,shell+board_clearance+board_thickness+hover])
    holder_center()
    usb_micro_b_cutout(cutout_length);
    
    translate([45.5,56+holder_comfort*2,shell+board_clearance+board_thickness+hover+3.5])
    holder_center()
    rca_cutout(cutout_length);
    
    
    translate([64.5,56+holder_comfort*2,shell+board_clearance+board_thickness+hover+3.25])
    holder_center()
    3p5_trs_cutout(cutout_length);
    
    translate([85+holder_comfort*2,2,shell+board_clearance+board_thickness+hover])
    holder_center()
    ethernet_cutout(cutout_length);
    
    translate([85+holder_comfort*2,24.5,shell+board_clearance+board_thickness+hover])
    holder_center()
    usb_dual_a_cutout(cutout_length);
    
}

module pi_b_holder(){
    difference(){
        translate([0,0,shell-0.001])
        holder_center()
        linear_extrude(board_clearance-shell+0.002,convexity=10)
        holder_shape();
        pi_b_cutouts();
    }
    
    difference(){
        translate([0,0,board_clearance])
        holder_center()
        linear_extrude(shell,convexity=10)
        holder_stand_shape();
        pi_b_cutouts();
    }
    
    difference(){
        translate([0,0,board_clearance+shell-0.001])
        holder_center()
        linear_extrude(pi_b_seam+hover+board_thickness+0.001,convexity=10)
        holder_shape();
        pi_b_cutouts();
    }
    
    translate([0,0,shell-0.001])
    case_center()
    pi_b_screw_positions()
    m2p5_stand(board_clearance,6.5,3);
    
    
    translate([0,0,shell+board_clearance+hover])
    case_center()
    translate([0,0,0])
    board();
    
    difference(){
        holder_center()
        holder_plate();
        case_center()
        pi_b_screws();
    }
}

//pi_b_cutouts();

//board();

difference(){
    pi_b_holder();
    translate([0,case_width/2,0])
    cube(size=[case_length/2,case_width/2,20]);
}