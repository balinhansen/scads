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
show_board=false;

holder_comfort=0.25;
holder_stand=0.5;

vents=true;
vent=2;
vent_space=5;
vent_count=floor((board_length-vent_space*2-vent)/(vent+vent_space))+1;
vent_start=(board_length-vent-vent_space*2-(vent+vent_space)*(vent_count-1))/2;
vent_front_mask=[];
vent_back_mask=[5,6];

echo(vent_count);
echo(vent_start);

case_length=3.5*inch;
case_width=2.5*inch;
case_height=shell+board_clearance+hover+board_thickness+board_void+shell+hover+shell+0.002;


corner=1/8*inch;


shortest=case_length-board_length >= case_width-board_width?case_width-board_width:case_length-board_length;

shortest_test=shortest>(shell+holder_comfort)?true:false;

shortest_edge=shortest_test?shortest:shell;


connector=5;
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

pi_b_seam=8;

cutout_length=shell+holder_stand+holder_comfort+lock_depth+lock_kerf+shell+0.002;
    
    

if (shortest_test==false){
    echo("Notes: Invalid case dimension, defaulting to shell thickness.");
}
    
function ngon(count, radius, i = 0, result = []) = i < count
    ? ngon(count, radius, i + 1, concat(result, [[ radius*sin(360/count*i), radius*cos(360/count*i) ]]))
    : result;



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

module holder_connector_shape(){
    difference(){
        offset(r=shell+lock_kerf+shell,$fn=fineness)
        holder_void();
        offset(r=shell+lock_kerf,$fn=fineness)
        holder_void();
    }
}

module holder_connector_lock_shape(){
    offset(r=shell+lock_kerf+lock_depth,$fn=fineness)
    holder_void();
}

module holder_connector_joint_shape(){
    difference(){
        offset(r=lock_kerf+shell*2,$fn=fineness)
        holder_void();
        holder_void();
    }
}

module holder_vents(){
    zpos=shell+board_clearance+hover+board_thickness+pi_b_seam+connector/2+shell+hover;
    height=board_void-pi_b_seam-connector/2-shell-hover;
    
    holder_center()
    rotate([90,0,0])
    for (i=[0:vent_count-1]){
        translate([vent_start+vent/2,vent/2+zpos+shell/2,(!search(i,vent_back_mask)?-shell:0.002)-holder_comfort*2-board_width-0.001])
        linear_extrude((!search(i,vent_back_mask)?shell+0.001:0)+(!search(i,vent_front_mask)?shell+0.001:0)+holder_comfort*2+board_width,convexity=10)
        translate([vent_space+i*(vent+vent_space),0])
        hull(){
            circle(vent/2,$fn=tiny_fineness);
            translate([0,height-vent])
            circle(vent/2,$fn=tiny_fineness);
        }
    }
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


module holder_lock_shape(){
    difference(){
        offset(r=shell+lock_depth, $fn=small_fineness)
        holder_void();
        offset(r=shell-0.2, $fn=small_fineness)
        holder_void();
    }
}

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

module pi_b_screwheads(){
    translate([0,0,-0.001])
    pi_b_screw_positions()
    m2p5_screwhead(2.2+0.002);
}


// Pi Model B (original) IO Cutouts


module hdmi_cutout(cutout_length){
    rotate([90,0,0])
    translate([0.5,0,-holder_stand-holder_comfort-0.001])
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
    cube(size=[26,cutout_length+0.002,4+0.001]);
    
    rotate([0,0,90])
    translate([-4,-cutout_length+shell+holder_stand+holder_comfort-0.001,-4])
    cube(size=[32.5,-shell+cutout_length+0.002,4+0.001]);
}

module usb_micro_b_cutout(cutout_length){
    translate([+0.001+holder_stand+holder_comfort,8+0.5,0])
    rotate([90,0,-90])
    linear_extrude(cutout_length+0.002,convexity=10)
    offset(delta=0.5)
    polygon(points=[[1,0],[7,0],[8,1],[8,3.25],[0,3.25],[0,1]]);
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
    
    translate([36.5+holder_comfort,0,shell+board_clearance+board_thickness+hover])
    holder_center()
    hdmi_cutout(cutout_length);
    
    translate([holder_stand+holder_comfort-0.001,18+holder_comfort-shell+0.001,shell+board_clearance])
    holder_center()
    sd_cutout(cutout_length);
    
    translate([0,3.25,shell+board_clearance+board_thickness+hover])
    holder_center()
    usb_micro_b_cutout(cutout_length);
    
    translate([46+holder_comfort,56+holder_comfort*2,shell+board_clearance+board_thickness+hover+3.5])
    holder_center()
    rca_cutout(cutout_length);
    
    translate([64.5+holder_comfort,56+holder_comfort*2,shell+board_clearance+board_thickness+hover+2.75])
    holder_center()
    3p5_trs_cutout(cutout_length);
    
    translate([85+holder_comfort*2,2.5,shell+board_clearance+board_thickness+hover])
    holder_center()
    ethernet_cutout(cutout_length);
    
    translate([85+holder_comfort*2,24.5,shell+board_clearance+board_thickness+hover])
    holder_center()
    usb_dual_a_cutout(cutout_length);
    
}


// Pi Model B (original) Connector Cutouts

module hdmi_cutout_connector(cutout_length){
    rotate([90,0,0])
    translate([0,0,-holder_stand-holder_comfort-0.001])
    linear_extrude(cutout_length,convexity=10)
    square(size=[16,pi_b_seam-5.5+connector/2+0.002]);
}

module usb_micro_b_cutout_connector(cutout_length){
    translate([+0.001+holder_stand+holder_comfort,8+0.5,0])
    rotate([90,0,-90])
    linear_extrude(cutout_length+0.002,convexity=10)
    square(size=[9,pi_b_seam-3.5+connector/2+0.002]);
}

module rca_cutout_connector(cutout_length){
    rotate([0,0,90])
    translate([-holder_comfort-holder_stand,-5,0])
    cube(size=[cutout_length,10,connector/2+shell+hover+0.001]);
}

module rca_cutout_connector_top(cutout_length){
    rotate([0,0,90])
    translate([-holder_comfort-holder_stand,-5,0])
    cube(size=[cutout_length,10,connector/2+shell+hover+0.001]);
}

module 3p5_trs_cutout_connector(cutout_length){
    rotate([0,0,90])
    translate([-holder_comfort-holder_stand,-4,0])
    cube(size=[cutout_length,8,connector/2+shell+hover+0.001]);
}

module ethernet_cutout_connector(cutout_length){
    translate([-holder_comfort-holder_stand-0.001,-0.5,0])
    cube(size=[cutout_length,17,connector/2+1+0.001]);
}

module usb_dual_a_cutout_connector(cutout_length){
    translate([-holder_comfort-holder_stand-0.001,-0.5,0])
    cube(size=[cutout_length,14.25,connector/2+1+0.001]);
}

module pi_b_cutouts_connector_top(){
    
    translate([holder_comfort+36.5,0,shell+board_clearance+board_thickness+hover+pi_b_seam-connector/2-0.001])
    holder_center()
    hdmi_cutout_connector(cutout_length);
    
    /*
    translate([0,3,shell+board_clearance+board_thickness+hover+3.5-0.001])
    holder_center()
    usb_micro_b_cutout_connector(cutout_length);
    */
    
    translate([46+holder_comfort,56+holder_comfort*2,shell+board_clearance+board_thickness+hover+3+5])
    holder_center()
    rca_cutout_connector(cutout_length);
    
    translate([64.5+holder_comfort,56+holder_comfort*2,shell+board_clearance+board_thickness+hover+2.75+4])
    holder_center()
    3p5_trs_cutout_connector(cutout_length);
    
    /*
    translate([85+holder_comfort*2,2,shell+board_clearance+board_thickness+hover+pi_b_seam-connector/2-0.001])
    holder_center()
    ethernet_cutout_connector(cutout_length);
    
    translate([85+holder_comfort*2,24.5,shell+board_clearance+board_thickness+hover+pi_b_seam-connector/2-0.001])
    holder_center()
    usb_dual_a_cutout_connector(cutout_length);
    */
}

module pi_b_cutouts_connector_bottom(){
    /*
    translate([36.5,0,shell+board_clearance+board_thickness+hover+pi_b_seam-connector/2-1])
    holder_center()
    hdmi_cutout_connector(cutout_length);
    
    translate([0,3,shell+board_clearance+board_thickness+hover+pi_b_seam-connector/2-1])
    holder_center()
    usb_micro_b_cutout_connector(cutout_length);
    */
    
    translate([46+holder_comfort,56+holder_comfort*2,shell+board_clearance+board_thickness+hover+3+5-connector/2-shell-hover-0.001])
    holder_center()
    rca_cutout_connector(cutout_length);
    
    translate([64.5+holder_comfort,56+holder_comfort*2,shell+board_clearance+board_thickness+hover+2.75+4-connector/2-shell-hover-0.001])
    holder_center()
    3p5_trs_cutout_connector(cutout_length);
    
    /*
    translate([85+holder_comfort*2,2,shell+board_clearance+board_thickness+hover+pi_b_seam-connector/2-1])
    holder_center()
    ethernet_cutout_connector(cutout_length);
    
    translate([85+holder_comfort*2,24.5,shell+board_clearance+board_thickness+hover+pi_b_seam-connector/2-1])
    holder_center()
    usb_dual_a_cutout_connector(cutout_length);
    */
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
    
    
    // Holder shell wall
    
    difference(){
        translate([0,0,board_clearance+shell-0.001])
        holder_center()
        linear_extrude(connector/2+pi_b_seam+hover+board_thickness+0.001,convexity=10)
        holder_shape();
        pi_b_cutouts();
        pi_b_cutouts_connector_top();
    }
    
    // Holder connector bottom lock
    difference(){
        translate([0,0,shell+board_clearance+board_thickness+hover+pi_b_seam-lock/2])
        holder_center()
        linear_extrude(lock,convexity=10)
        holder_lock_shape();
        
        pi_b_cutouts();
        
        pi_b_cutouts_connector_top();
    }
    
    // Screws
    
    translate([0,0,shell-0.001]){
        /*
        difference(){
            translate([0,0,2.2-0.001])
            case_center()
            pi_b_screw_positions()
            m2p5_stand(board_clearance-2.2-shell+0.002,6.2,3.2);
        
            case_center()
            pi_b_screw_positions()
            m2p5_screwhead_stand(2.2,6.2+shell*2,6.2);
        }
    */  
        difference(){
            case_center()
            pi_b_screw_positions()
            union(){
                m2p5_screwhead_stand(2.2,6.2+shell*2,6.2);
                translate([0,0,2.2-0.001])
                m2p5_stand(board_clearance-2.2,3.2+shell*2,3.2);
            }
            case_center()
            pi_b_screw_positions()
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
        holder_center()
        holder_plate();
        case_center()
        pi_b_screwheads();
        /*
        case_center()
        pi_b_screwheads();
        */
    }
    
}

module pi_b_holder_top(){
    
    // Holder connector
    
    difference(){
        translate([0,0,shell+board_clearance+board_thickness+hover+pi_b_seam-shell-connector/2-hover])
        holder_center()
        linear_extrude(connector+shell+hover*2+0.001,convexity=10)
        holder_connector_shape();
        
        translate([0,0,shell+board_clearance+board_thickness+hover+pi_b_seam-lock/2-lock_kerf])
        holder_center()
        linear_extrude(lock+lock_kerf*2)
        holder_connector_lock_shape();
        
        pi_b_cutouts();
        pi_b_cutouts_connector_bottom();
    }
    
    // Holder connector joint
    
    difference(){
        translate([0,0,shell+board_clearance+board_thickness+hover+pi_b_seam+connector/2+hover])
        holder_center()
        linear_extrude(shell,convexity=10)
        holder_connector_joint_shape();
        pi_b_cutouts();
    }
    // Holder top wall
    
    difference(){
        translate([0,0,shell+board_clearance+board_thickness+hover+pi_b_seam+connector/2+hover+shell-0.001])
        holder_center()
        linear_extrude(board_void-pi_b_seam-hover-shell-shell+0.002,convexity=10)
        holder_shape();
        pi_b_cutouts();
        holder_vents();
    }
    
    // Holder top plate
    
    translate([0,0,shell+board_clearance+board_thickness+hover+board_void+shell+hover-0.001])
    difference(){
        holder_center()
        holder_plate();
        
        case_center()
        pi_b_screw_positions()
        m2p5_hexnut(shell+0.002);
        
    }
    
    translate([0,0,shell+board_clearance+board_thickness+hover+hover])
    case_center()
    pi_b_screw_positions()
    m2p5_stand(board_void-2.2+shell+0.001,3.2+shell*2,3.2);
    
    translate([0,0,shell+board_clearance+board_thickness+hover+hover+board_void+shell-2.2])
    case_center()
    pi_b_screw_positions()
    difference(){
        m2p5_hexnut_stand(shell+2.2+0.001,3.2+shell*2,3.2);
        translate([0,0,shell])
        m2p5_hexnut(2.2+0.002);
        translate([0,0,-0.002])
        m2p5_screw(shell+0.004);
    }
}

//pi_b_cutouts();

//board();

module pi_b_monopi_render(){
    pi_b_holder();
    pi_b_holder_top();
}

module pi_b_monopi_render_crosssection(){
    
    difference(){
        pi_b_holder();
        translate([0,case_width/2,-0.001])
        cube(size=[case_length/2,case_width/2,case_height]);
    }
    difference(){
        pi_b_holder_top();
        translate([0,case_width/2,-0.001])
        cube(size=[case_length/2,case_width/2,case_height]);
    }
}

module pi_b_print_bottom(){
    pi_b_holder();
}

module pi_b_print_top(){
    translate([0,0,case_height])
    rotate([180,0,0])
    pi_b_holder_top();
}

module pi_b_print_both(){
    pi_b_print_bottom();
    translate([0,(case_width+lock_kerf+shell+shell+lock_kerf)*2+5,0])
    pi_b_print_top();
}



//pi_b_monopi_render_crosssection();
pi_b_monopi_render();
//pi_b_print_both();
//pi_b_print_top();
//pi_b_print_bottom();

/*
color([1,0,0,0.4])
pi_b_cutouts_connector_top();


color([0,0,1,0.4])
pi_b_cutouts_connector_bottom();
*/

//holder_vents();