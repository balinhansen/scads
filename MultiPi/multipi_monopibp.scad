inch=25.4;
shell=1.2;
hover=0.1;
kerf=0.0035*inch*2.5;

tiny_fineness=16;
small_fineness=40;
fineness=80;

board_length=85;
board_width=56;
board_thickness=1/16*inch;
board_clearance=1/8*inch;
board_void=16;
show_board=true;

pi_bp_holder_comfort=0.25;
pi_bp_holder_stand=0.5;

vents=true;
vent=2;
vent_space=5;
vent_count=floor((board_length-vent_space*2-vent)/(vent+vent_space))+1;
vent_start=(board_length-vent-vent_space*2-(vent+vent_space)*(vent_count-1))/2;
vent_front_mask=[];
vent_back_mask=[5,6];

case_corner=1/8*inch;
case_length=board_length+20+case_corner*2;
case_width=board_width+20+case_corner*2;
case_height=shell+board_clearance+hover+board_thickness+board_void+shell+hover+shell+0.002;

case_connector_length=5;
case_connector_outer_offset=0;

case_connector_pi_bp_offset=10;

shortest=case_length-board_length >= case_width-board_width?case_width-board_width:case_length-board_length;

shortest_test=shortest>(shell+pi_bp_holder_comfort)?true:false;

shortest_edge=shortest_test?shortest:shell;


pi_bp_holder_connector=5;
connector_shell=1.2;
connector_kerf=0.2;

lock=0.5;
lock_depth=0.2;
lock_kerf=0.0035*inch*2.5;


// Connector shell is shell
connector_is_shell=(connector_shell==shell)?true:false;

// Connector seam thicker than shell?
seam_cladding=(connector_shell*2+connector_kerf)>shell?true:false;

 // Connector shell thicker than shell?
lock_cladding=(connector_shell>shell)?true:false;

// Connector shell thinner that shell?
lock_recess=(connector_shell<shell)?true:false;

pi_bp_seam=8;

cutout_length=shell+pi_bp_holder_stand+pi_bp_holder_comfort+lock_depth+lock_kerf+shell+0.002;
    
    

if (shortest_test==false){
    echo("Notes: Invalid case dimension, defaulting to shell thickness.");
}
    
function ngon(count, radius, i = 0, result = []) = i < count
    ? ngon(count, radius, i + 1, concat(result, [[ radius*sin(360/count*i), radius*cos(360/count*i) ]]))
    : result;



module board(){
    difference(){
        cube(size=[board_length,board_width,board_thickness]);
        pi_bp_screws();
    }
}


// CASE
//###########################


module case_shape(){
    minkowski(){
        translate([case_corner,case_corner,0])
    cube(size=[case_length-case_corner*2,case_width-case_corner*2,0.000001]);
        sphere(case_corner,$fn=small_fineness);
    }
}

module case_shape_cutout(){
    minkowski(){
        translate([case_corner,case_corner,0])
    cube(size=[case_length-case_corner*2,case_width-case_corner*2,0.000001]);
        sphere(case_corner-shell,$fn=small_fineness);
    }
}
    
    
module case_center(){
    translate([(case_length-board_length)/2,(case_width-board_width)/2,0])
    children();
}


module case_bottom(){
    translate([0,0,case_corner])
    difference(){
        case_shape();
        case_shape_cutout();
        cube(size=[case_length,case_width,case_corner+0.001]);
    }
    
}

module case_outer_connector(){
    translate([case_corner+case_connector_outer_offset,case_corner+case_connector_outer_offset,-0.001])
    linear_extrude(case_connector_length+0.001,convexity=10)
    minkowski(){
        square(size=[case_length-case_corner*2-case_connector_outer_offset*2,case_width-case_corner*2-case_connector_outer_offset*2]);
        circle(case_corner,$fn=small_fineness);
    }
}

module case_outer_connector_cutout(){
    translate([case_corner+case_connector_outer_offset,case_corner+case_connector_outer_offset,-0.002])
    linear_extrude(case_connector_length+0.003,convexity=10)
    minkowski(){
        square(size=[case_length-case_corner*2-case_connector_outer_offset*2,case_width-case_corner*2-case_connector_outer_offset*2]);
        circle(case_corner-shell,$fn=small_fineness);
    }
}


module case(){
    case_bottom();
    translate([0,0,case_corner])

    difference(){
    case_outer_connector();
        case_outer_connector_cutout();
    }
}


// PI B (ORIGINAL) CASE HOLDER / CONNECTOR

module case_pi_bp_connector(){
    pi_bp_holder_center()
    translate([case_corner+case_connector_pi_bp_offset,case_corner+case_connector_pi_bp_offset,shell-0.001])
    linear_extrude(case_corner-shell+case_connector_length+0.001,convexity=10)
    minkowski(){
        square(size=[board_length-case_corner*2-case_connector_pi_bp_offset*2,board_width-case_corner*2-case_connector_pi_bp_offset*2]);
        circle(case_corner,$fn=small_fineness);
    }
}

module case_pi_bp_connector_cutout(){
    pi_bp_holder_center()
    translate([case_corner+case_connector_pi_bp_offset,case_corner+case_connector_pi_bp_offset,shell-0.002])
    linear_extrude(case_corner-shell+case_connector_length+0.003,convexity=10)
    minkowski(){
        square(size=[board_length-case_corner*2-case_connector_pi_bp_offset*2,board_width-case_corner*2-case_connector_pi_bp_offset*2]);
        circle(case_corner-shell,$fn=small_fineness);
    }
}


module case_connector(){

    difference(){
        case_pi_bp_connector();
        case_pi_bp_connector_cutout();
    }

}



// PI B+ CONTAINER
// ##########################




module pi_bp_holder_void(){
    square(size=[board_length+pi_bp_holder_comfort*2,board_width+pi_bp_holder_comfort*2]);
}

module pi_bp_holder_center(){
    translate([(case_length-board_length-pi_bp_holder_comfort*2)/2,(case_width-board_width-pi_bp_holder_comfort*2)/2])
    children();
}

module pi_bp_holder_stand_shape(){
    difference(){
        offset(r=shell, $fn=small_fineness)
        pi_bp_holder_void();
        offset(r=-pi_bp_holder_comfort-pi_bp_holder_stand, $fn=small_fineness)
        pi_bp_holder_void();
    }
}

module pi_bp_holder_shape(){
    difference(){
        offset(r=shell, $fn=small_fineness)
        pi_bp_holder_void();
        pi_bp_holder_void();
    }
}

module pi_bp_holder_plate(){
    linear_extrude(shell,convexity=10)
    offset(r=shell, $fn=small_fineness)
    pi_bp_holder_void();
}

module pi_bp_holder_connector_shape(){
    difference(){
        offset(r=shell+lock_kerf+shell,$fn=fineness)
        pi_bp_holder_void();
        offset(r=shell+lock_kerf,$fn=fineness)
        pi_bp_holder_void();
    }
}

module pi_bp_holder_connector_lock_shape(){
    offset(r=shell+lock_kerf+lock_depth,$fn=fineness)
    pi_bp_holder_void();
}

module pi_bp_holder_connector_joint_shape(){
    difference(){
        offset(r=lock_kerf+shell*2,$fn=fineness)
        pi_bp_holder_void();
        pi_bp_holder_void();
    }
}

module pi_bp_holder_vents(){
    zpos=shell+board_clearance+hover+board_thickness+pi_bp_seam+pi_bp_holder_connector/2+shell+hover;
    height=board_void-pi_bp_seam-pi_bp_holder_connector/2-shell-hover;
    
    pi_bp_holder_center()
    rotate([90,0,0])
    for (i=[0:vent_count-1]){
        translate([vent_start+vent/2,vent/2+zpos+shell/2,(!search(i,vent_back_mask)?-shell:0.002)-pi_bp_holder_comfort*2-board_width-0.001])
        linear_extrude((!search(i,vent_back_mask)?shell+0.001:0)+(!search(i,vent_front_mask)?shell+0.001:0)+pi_bp_holder_comfort*2+board_width,convexity=10)
        translate([vent_space+i*(vent+vent_space),0])
        hull(){
            circle(vent/2,$fn=tiny_fineness);
            translate([0,height-vent])
            circle(vent/2,$fn=tiny_fineness);
        }
    }
}



module pi_bp_holder_lock_shape(){
    difference(){
        offset(r=shell+lock_depth, $fn=small_fineness)
        pi_bp_holder_void();
        offset(r=shell-0.2, $fn=small_fineness)
        pi_bp_holder_void();
    }
}



// SCREWS
//############################



module m2p5_screw(length){
    cylinder(length,1.6,1.6,$fn=small_fineness);
}

module m2p5_screwhead(length){
    cylinder(length,3.1,3.1,$fn=small_fineness);
}

module m2p5_stand(length,width,hole){
    difference(){
        translate([0,0,-0.001])
        cylinder(length+0.001,width/2,width/2,$fn=small_fineness);
        translate([0,0,-0.002])
        cylinder(length+0.003,hole/2,hole/2,$fn=small_fineness);
    }
}

module m2p5_screwhead_stand(length,width,hole){
    difference(){
        translate([0,0,-0.001])
        cylinder(length+0.001,width/2,width/2,$fn=small_fineness);
        translate([0,0,-0.002])
        cylinder(length-shell+0.002,hole/2,hole/2,$fn=small_fineness);
    }
}

module m2p5_hexnut(length){
    translate([0,0,-0.001])
    rotate([0,0,30])
    linear_extrude(length,convexity=10)
    polygon(ngon(6,5.9/2));
}

module m2p5_hexnut_stand(length){
    translate([0,0,-0.001])
    rotate([0,0,30])
    linear_extrude(length,convexity=10)
    polygon(ngon(6,5.9/2+shell));
}

module pi_bp_screw_positions(){
    translate([3.5,3.5])
    children();
    
    translate([61.5,3.5])
    children();
    
    translate([3.5,52.5])
    children();
    
    translate([61.5,52.5])
    children();
}

module pi_bp_screws(){
    translate([0,0,-0.001])
    pi_bp_screw_positions()
    m2p5_screw(board_thickness+0.002);
}

module pi_bp_screwheads(){
    translate([0,0,-0.001])
    pi_bp_screw_positions()
    m2p5_screwhead(2.2+0.002);
}



//  CUTOUTS
//#############################

// Pi Model B+ (Original B+, 2, 3, 3B+, ... ) IO Cutouts


module pi_bp_hdmi_cutout(cutout_length){
    rotate([90,0,0])
    translate([0,0,-pi_bp_holder_stand+pi_bp_holder_comfort])
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
    [15,5.5],
    [0,5.5]
    ]);
}

module pi_bp_sdmicro_cutout(cutout_length){
    rotate([0,0,90])
    translate([-0.5,+0.001,-board_clearance-shell-0.001])
    cube(size=[15.6,cutout_length+0.002,board_clearance+shell+0.001]);
    
    rotate([0,0,90])
    translate([-1.5,-0.002,-board_clearance])
    cube(size=[14.6+1+1+3,pi_bp_holder_stand+pi_bp_holder_comfort+0.001,board_clearance+0.001]);
}

module pi_bp_usb_micro_b_cutout(cutout_length){
    rotate([90,0,0])
    translate([0,0,-pi_bp_holder_stand-pi_bp_holder_comfort])
    linear_extrude(cutout_length+0.002,convexity=10)
    offset(delta=0.5)
    polygon(points=[[1,0],[7,0],[8,1],[8,3.25],[0,3.25],[0,1]]);
}

module pi_bp_3p5trs_cutout(cutout_length){
    rotate([90,0,0])
    translate([0,4,0])
    cylinder(cutout_length,4,4,$fn=small_fineness);
}

module pi_bp_ethernet_cutout(cutout_length){
    translate([-pi_bp_holder_comfort-pi_bp_holder_stand-0.001,0,-0.5])
    cube(size=[cutout_length,17,14.75]);
}

module usb_dual_a_cutout(cutout_length){
    translate([-pi_bp_holder_comfort-pi_bp_holder_stand-0.001,-0.5,-0.5])
    cube(size=[cutout_length,14.25,17.5]);
}

module usb_dual_a_two_cutout(cutout_length){
    translate([-pi_bp_holder_comfort-pi_bp_holder_stand-0.001,-0.5,-0.5])
    cube(size=[cutout_length,14.25,17.5]);
}



module pi_bp_cutouts(){
    
    translate([6.8+7.5+10.2+pi_bp_holder_comfort,0,shell+board_clearance+board_thickness+hover+1])
    pi_bp_holder_center()
    pi_bp_hdmi_cutout(cutout_length);
    
    translate([pi_bp_holder_stand+pi_bp_holder_comfort-0.001,21.5+pi_bp_holder_comfort-shell+0.001,shell+board_clearance])
    pi_bp_holder_center()
    pi_bp_sdmicro_cutout(cutout_length);
    
    translate([6.8,0,shell+board_clearance+board_thickness+hover])
    pi_bp_holder_center()
    pi_bp_usb_micro_b_cutout(cutout_length);
    
    translate([53.5+pi_bp_holder_comfort,pi_bp_holder_comfort*2,shell+board_clearance+board_thickness+hover-0.5])
    pi_bp_holder_center()
    pi_bp_3p5trs_cutout(cutout_length);
    
    translate([85+pi_bp_holder_comfort*2,2.3,shell+board_clearance+board_thickness+hover])
    pi_bp_holder_center()
    pi_bp_ethernet_cutout(cutout_length);
    
    translate([85+pi_bp_holder_comfort*2,2.3+15.9+4.2,shell+board_clearance+board_thickness+hover])
    pi_bp_holder_center()
    usb_dual_a_cutout(cutout_length);
    
    translate([85+pi_bp_holder_comfort*2,2.3+15.9+4.2+13.1+4.9-1,shell+board_clearance+board_thickness+hover])
    pi_bp_holder_center()
    usb_dual_a_two_cutout(cutout_length);
    
}


// Pi Model B+ (B+, 2, 3, 3B+, ... ) Connector Cutouts

module pi_bp_hdmi_cutout_connector(cutout_length){
    rotate([90,0,0])
    translate([0,0,-pi_bp_holder_stand-pi_bp_holder_comfort-0.001])
    linear_extrude(cutout_length,convexity=10)
    square(size=[16,pi_bp_seam-5.5+pi_bp_holder_connector/2+0.002]);
}

module pi_bp_usb_micro_b_cutout_connector(cutout_length){
   
    rotate([90,0,0])
    
    translate([0,0,pi_bp_holder_stand+pi_bp_holder_comfort+0.5,0])
    
    linear_extrude(cutout_length+0.002,convexity=10)
    square(size=[9,pi_bp_seam+3.5+pi_bp_holder_connector/2+0.002]);
}

/*
module pi_bp_rca_cutout_connector(cutout_length){
    rotate([0,0,90])
    translate([-pi_bp_holder_comfort-pi_bp_holder_stand,-5,0])
    cube(size=[cutout_length,10,pi_bp_holder_connector/2+shell+hover+0.001]);
}
*/


/*
module pi_bp_rca_cutout_connector_top(cutout_length){
    rotate([0,0,90])
    translate([-pi_bp_holder_comfort-pi_bp_holder_stand,-5,0])
    cube(size=[cutout_length,10,pi_bp_holder_connector/2+shell+hover+0.001]);
}
*/

module pi_bp_3p5trs_cutout_connector(cutout_length){
    rotate([0,0,-90])
    translate([-pi_bp_holder_comfort-pi_bp_holder_stand,-4,0])
    cube(size=[cutout_length,8,pi_bp_holder_connector/2+shell+hover+pi_bp_seam+0.001]);
}

module pi_bp_ethernet_cutout_connector(cutout_length){
    translate([-pi_bp_holder_comfort-pi_bp_holder_stand-0.001,-0.5,0])
    cube(size=[cutout_length,17,pi_bp_holder_connector/2+1+0.001]);
}

module usb_dual_a_cutout_connector(cutout_length){
    translate([-pi_bp_holder_comfort-pi_bp_holder_stand-0.001,-0.5,0])
    cube(size=[cutout_length,14.25,pi_bp_holder_connector/2+1+0.001]);
}

module pi_bp_cutouts_connector_top(){
    
    translate([6.8+7.5+10.2+pi_bp_holder_comfort-0.5,0,shell+board_clearance+board_thickness+hover+pi_bp_seam-pi_bp_holder_connector/2-0.001])
    pi_bp_holder_center()
    pi_bp_hdmi_cutout_connector(cutout_length);
    
    
    translate([6.8-0.5,0.001,1+shell+board_clearance+board_thickness+hover-0.001])
    pi_bp_holder_center()
    pi_bp_usb_micro_b_cutout_connector(cutout_length);
    
    
    /* No RCA
    translate([46+pi_bp_holder_comfort,56+pi_bp_holder_comfort*2,shell+board_clearance+board_thickness+hover+3+5])
    pi_bp_holder_center()
    pi_bp_rca_cutout_connector(cutout_length);
    */
    
    
    translate([53.5+pi_bp_holder_comfort,0,shell+board_clearance+board_thickness+hover+4])
    pi_bp_holder_center()
    pi_bp_3p5trs_cutout_connector(cutout_length);
    
    
    
    
    
    /*  Ethernet and USB Not usually needed
    translate([85+pi_bp_holder_comfort*2,2,shell+board_clearance+board_thickness+hover+pi_bp_seam-connector/2-0.001])
    pi_bp_holder_center()
    pi_bp_ethernet_cutout_connector(cutout_length);
    
    translate([85+pi_bp_holder_comfort*2,24.5,shell+board_clearance+board_thickness+hover+pi_bp_seam-connector/2-0.001])
    pi_bp_holder_center()
    usb_dual_a_cutout_connector(cutout_length);
    */
}

module pi_bp_cutouts_connector_bottom(){
    /*
    translate([36.5,0,shell+board_clearance+board_thickness+hover+pi_bp_seam-pi_bp_holder_connector/2-1])
    pi_bp_holder_center()
    pi_bp_hdmi_cutout_connector(cutout_length);
    
    translate([0,3,shell+board_clearance+board_thickness+hover+pi_bp_seam-pi_bp_holder_connector/2-1])
    pi_bp_holder_center()
    pi_bp_usb_micro_b_cutout_connector(cutout_length);
    */
    
    /* No RCA on B+
    translate([46+pi_bp_holder_comfort,56+pi_bp_holder_comfort*2,shell+board_clearance+board_thickness+hover+3+5-pi_bp_holder_connector/2-shell-hover-0.001])
    pi_bp_holder_center()
    pi_bp_rca_cutout_connector(cutout_length);
    */
    
    /* translate([64.5+pi_bp_holder_comfort,56+pi_bp_holder_comfort*2,shell+board_clearance+board_thickness+hover+2.75+4-pi_bp_holder_connector/2-shell-hover-0.001])
    pi_bp_holder_center()
    pi_bp_3p5trs_cutout_connector(cutout_length);
    */
    
    
    /*
    translate([85+pi_bp_holder_comfort*2,2,shell+board_clearance+board_thickness+hover+pi_bp_seam-pi_bp_holder_connector/2-1])
    pi_bp_holder_center()
    pi_bp_ethernet_cutout_connector(cutout_length);
    
    translate([85+pi_bp_holder_comfort*2,24.5,shell+board_clearance+board_thickness+hover+pi_bp_seam-pi_bp_holder_connector/2-1])
    pi_bp_holder_center()
    usb_dual_a_cutout_connector(cutout_length);
    */
}




// PI B+ HOLDER
//#############################



module pi_bp_holder(){
    difference(){
        translate([0,0,shell-0.001])
        pi_bp_holder_center()
        linear_extrude(board_clearance-shell+0.002,convexity=10)
        pi_bp_holder_shape();
        pi_bp_cutouts();
    }
    
    
    difference(){
        translate([0,0,board_clearance])
        pi_bp_holder_center()
        linear_extrude(shell,convexity=10)
        pi_bp_holder_stand_shape();
        pi_bp_cutouts();
    }
    
    
    // Holder shell wall
    
    difference(){
        translate([0,0,board_clearance+shell-0.001])
        pi_bp_holder_center()
        linear_extrude(pi_bp_holder_connector/2+pi_bp_seam+hover+board_thickness+0.001,convexity=10)
        pi_bp_holder_shape();
        pi_bp_cutouts();
        pi_bp_cutouts_connector_top();
    }
    
    // Holder connector bottom lock
    difference(){
        translate([0,0,shell+board_clearance+board_thickness+hover+pi_bp_seam-lock/2])
        pi_bp_holder_center()
        linear_extrude(lock,convexity=10)
        pi_bp_holder_lock_shape();
        
        pi_bp_cutouts();
        
        pi_bp_cutouts_connector_top();
    }
    
    // Screws
    
    translate([0,0,shell-0.001]){
        /*
        difference(){
            translate([0,0,2.2-0.001])
            case_center()
            pi_bp_screw_positions()
            m2p5_stand(board_clearance-2.2-shell+0.002,6.2,3.2);
        
            case_center()
            pi_bp_screw_positions()
            m2p5_screwhead_stand(2.2,6.2+shell*2,6.2);
        }
    */  
        difference(){
            case_center()
            pi_bp_screw_positions()
            union(){
                m2p5_screwhead_stand(2.2,6.2+shell*2,6.2);
                translate([0,0,2.2-0.001])
                m2p5_stand(board_clearance-2.2,3.2+shell*2,3.2);
            }
            case_center()
            pi_bp_screw_positions()
            m2p5_screw(board_clearance);
        }
    }
    
    if (show_board){
        translate([0,0,shell+board_clearance+hover])
        case_center()
        translate([0,0,0])
        %board();
    }
    
    // Holder bottom plate
    
    difference(){
        pi_bp_holder_center()
        pi_bp_holder_plate();
        case_center()
        pi_bp_screwheads();
        
        pi_bp_cutouts();
        /*
        case_center()
        pi_bp_screwheads();
        */
    }
    
}

module pi_b_pi_bp_holder_top(){
    
    // Holder connector
    
    difference(){
        translate([0,0,shell+board_clearance+board_thickness+hover+pi_bp_seam-shell-pi_bp_holder_connector/2-hover])
        pi_bp_holder_center()
        linear_extrude(pi_bp_holder_connector+shell+hover*2+0.001,convexity=10)
        pi_bp_holder_connector_shape();
        
        translate([0,0,shell+board_clearance+board_thickness+hover+pi_bp_seam-lock/2-lock_kerf])
        pi_bp_holder_center()
        linear_extrude(lock+lock_kerf*2)
        pi_bp_holder_connector_lock_shape();
        
        pi_bp_cutouts();
        pi_bp_cutouts_connector_bottom();
    }
    
    // Holder connector joint
    
    difference(){
        translate([0,0,shell+board_clearance+board_thickness+hover+pi_bp_seam+pi_bp_holder_connector/2+hover])
        pi_bp_holder_center()
        linear_extrude(shell,convexity=10)
        pi_bp_holder_connector_joint_shape();
        pi_bp_cutouts();
    }
    // Holder top wall
    
    difference(){
        translate([0,0,shell+board_clearance+board_thickness+hover+pi_bp_seam+pi_bp_holder_connector/2+hover+shell-0.001])
        pi_bp_holder_center()
        linear_extrude(board_void-pi_bp_seam-hover-shell-shell+0.002,convexity=10)
        pi_bp_holder_shape();
        pi_bp_cutouts();
        pi_bp_holder_vents();
    }
    
    // Holder top plate
    
    translate([0,0,shell+board_clearance+board_thickness+hover+board_void+shell+hover-0.001])
    difference(){
        pi_bp_holder_center()
        pi_bp_holder_plate();
        
        case_center()
        pi_bp_screw_positions()
        m2p5_hexnut(shell+0.002);
        
    }
    
    translate([0,0,shell+board_clearance+board_thickness+hover+hover])
    case_center()
    pi_bp_screw_positions()
    m2p5_stand(board_void-2.2+shell+0.001,3.2+shell*2,3.2);
    
    translate([0,0,shell+board_clearance+board_thickness+hover+hover+board_void+shell-2.2])
    case_center()
    pi_bp_screw_positions()
    difference(){
        m2p5_hexnut_stand(shell+2.2+0.001,3.2+shell*2,3.2);
        translate([0,0,shell])
        m2p5_hexnut(2.2+0.002);
        translate([0,0,-0.002])
        m2p5_screw(shell+0.004);
    }
}




// TESTS AND RENDERS
//############################



//pi_bp_cutouts();

module pi_bp_monopi_render(){
    pi_bp_holder();
    pi_b_pi_bp_holder_top();
}

module pi_bp_monopi_render_crosssection(){
    
    difference(){
        pi_bp_holder();
        translate([0,case_width/2,-0.001])
        cube(size=[case_length/2,case_width/2,case_height]);
    }
    difference(){
        pi_b_pi_bp_holder_top();
        translate([0,case_width/2,-0.001])
        cube(size=[case_length/2,case_width/2,case_height]);
    }
}

module pi_bp_print_bottom(){
    pi_bp_holder();
}

module pi_bp_print_top(){
    translate([0,0,case_height])
    rotate([180,0,0])
    pi_b_pi_bp_holder_top();
}

module pi_bp_print_both(){
    pi_bp_print_bottom();
    translate([0,(case_width+lock_kerf+shell+shell+lock_kerf)*2+5,0])
    pi_bp_print_top();
}



//pi_bp_monopi_render_crosssection();

//pi_bp_monopi_render();
//pi_bp_print_both();
//pi_bp_print_top();
pi_bp_print_bottom();

/*
color([1,0,0,0.4])
pi_bp_cutouts_connector_top();


color([0,0,1,0.4])
pi_bp_cutouts_connector_bottom();
*/

//pi_bp_holder_vents();

module multipi_pib(){
    translate([0,0,case_corner+hover+case_connector_length])
    pi_bp_monopi_render();
}

//multipi_pib();