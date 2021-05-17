use <legolib.scad>;
use <Lego Jetson TK1/LegoJetsonTK1.scad>;


lego_length=getLegoLength();
lego_block_height=getLegoBlockHeight();

module brick_test(){
xbyy_brick(2,1,lego_block_height/3);

translate([lego_length,lego_length,0])
rotate([0,0,180])
translate([-lego_length,0,-1.5*lego_block_height/3])
xbyy_brick(2,1,lego_block_height/3);

translate([0,0,1.5*lego_block_height/3])
xbyy_brick(2,2,lego_block_height/3);

translate([0,0,3*lego_block_height/3])
xbyy_brick(2,2,lego_block_height/3);

translate([0,0,4.5*lego_block_height/3])
xbyy_brick(1,1,lego_block_height/3);

translate([-lego_length/2,-3*lego_length/2,6*lego_block_height/3])
xbyy_brick(2,3,lego_block_height/3);

translate([lego_length/2,0,-3*lego_block_height/3])
xbyy_brick(1,1,lego_block_height/3);

translate([0,0,7*lego_block_height/3])
    lego_antenna(lego_block_height*2);
    
translate([0,0,8.5*lego_block_height/3])
    lego_round_brick(lego_block_height/3,1);
    
    
translate([-lego_length/2,-3*lego_length/2,11*lego_block_height/3])
technic_xbyy_brick(2,3,lego_block_height/3);
}

module brick_test_print(){
    
xbyy_brick(1,1,lego_block_height/3);
    
    translate([lego_length+5,0,0])
xbyy_brick(2,1,lego_block_height/3);
    
    translate([0,lego_length+5,0])
xbyy_brick(2,2,lego_block_height/3);
    
}

module technic_test(){
    

    x_technic_brick(2,lego_block_height);
    
    translate([0,0,5.8/8*lego_length+0.5*lego_length])
    rotate([-90,0,0])
    translate([lego_length/2,0,-1.1*lego_block_height/3])
    xbyy_brick(1,1,lego_block_height/3);
    
    translate([0,0,lego_block_height])
    x_technic_brick(1,lego_block_height);
    translate([lego_length/2,-lego_length,5.8/8*lego_length+lego_block_height])
rotate([-90,0,0])
    lego_technic_axle_stopped(3,1);

}

module print_test_full(){
    space=5/8*lego_length;
    
xbyy_brick(1,1,lego_block_height/3);
    
    translate([lego_length+space,0,0])
xbyy_brick(2,1,lego_block_height/3);
    
    translate([0,lego_length+space,0])
technic_xbyy_brick(2,2,lego_block_height/3);
    
    translate([lego_length*2+space,lego_length+space,0])
    lego_round_brick(lego_block_height/3,1);
    
    translate([lego_length*2+space,lego_length*2+space*2,0])
    x_technic_brick(1,lego_block_height);
    
    translate([0,lego_length*3+space*2,0])
    lego_antenna(lego_block_height);
    
    translate([lego_length*3+space*2,0,0])
    xbyy_brick(2,4,lego_block_height/3);
    
    translate([lego_length*1+space,lego_length*3+space*3,0])
    xbyy_brick(4,1,lego_block_height/3);
    
}

module print_callibration_test(length){
    
    %cube(size=[(2.5+length)*lego_length,(2.5+length)*lego_length,0.01]);
    
    translate([lego_length*2.5,0,0])
    xbyy_brick(length,1,lego_block_height/3);
    
    translate([0,lego_length*2.5,0])
    xbyy_brick(1,length,lego_block_height/3);
    
    diag=floor((sqrt(pow((length+2.5)*lego_length,2)+pow((length+2.5)*lego_length,2))-sqrt(pow(lego_length,2)/2)*2)/lego_length);
    
    offset=sqrt(pow( (sqrt(pow((length+2.5)*lego_length,2)*2)-diag*lego_length),2)/2)/2;
    
    echo("Diagonal length: ");
    echo(diag);
    
    translate([offset,offset,0])
    
    rotate([0,0,45])
    translate([0,-lego_length/2,0])
    //cube(size=[(sqrt(pow((length+2.5)*lego_length,2)*2)-diag*lego_length)/2,1,1]);
    xbyy_brick(diag,1,lego_block_height/3);
    
    
}


/*
// CROSS SECTION TESTS
//color([1,0,0,0.5])
difference(){
    union(){
        //x_technic_brick(1,lego_block_height);
        //translate([0,0,5.8/8*lego_length+.5*lego_length])
        //rotate([-90,0,0])
        //translate([0,0,-lego_block_height/3])
        //lego_round_brick(lego_block_height/3,0);
                
        translate([0,0,lego_block_height/3])
        lego_round_brick(lego_block_height/3,1);
        
        translate([0,0,lego_block_height/3*2])
        xbyy_brick(1,2,lego_block_height/3);
        //lego_round_brick(lego_block_height/3,1);
        
        lego_antenna(lego_block_height*2);
        //translate([0,0,lego_block_height/3*4])
        //lego_round_brick(lego_block_height/3,1);
        
        translate([0,0,lego_block_height])
        xbyy_brick(1,1,lego_block_height/3);
        
    }
    cube([lego_length/2,lego_length,lego_block_height*2]);
    
    }
*/
    /*  // Radio Shack Solar Panel #2770051

    //xbyy_brick(2,16,lego_block_height/3);
    //xbyy_knobrow(2,5,0,lego_block_height/3);
    //xbyy_knobrow(2,2,0,lego_block_height/3);
    //xbyy_knobedge_corner(4,2,0,lego_block_height/3);
    //xbyy_knobedge_side(2,13,0,lego_block_height/3);

    //xbyy_overhang(11,1.0,lego_block_height/3,0);
    //xbyy_overhang(9,2.5,lego_block_height/3,0);
    
    //xbyy_overhang_corner(2,4,1.0,2.5,lego_block_height/3,0);
    //xbyy_overhang_corner(4,2,2.5,1.0,lego_block_height/3,0);

    //xbyy_overhang_corner(2,4,4.5,3.0,lego_block_height/3,1);
    //xbyy_overhang_corner(4,2,3.0,4.5,lego_block_height/3,1);

    //xbyy_overhang(15,3.0,lego_block_height/3,1);
    //xbyy_overhang(5,4.5,lego_block_height/3,1);
    
    */
    
    
    // nVidia Jetson TK1 Case
    
    //xbyy_knobedge_corner_stand(3,3,0,lego_block_height/3);
    //xbyy_brick(1,12,lego_block_height/3);
    //for (i=[0:3]){
    //translate([i*(lego_length+5),0,0])    
    //xbyy_brick(1,6,lego_block_height/3);
    //}



//x_wall_panel(14,4*lego_block_height);
//lego_nvidia_jetson_io_panel();
//lego_nvidia_jetson_jtag_panel();
//lego_nvidia_jetson_rear_panel();


//lego_nvidia_logo(14,14,lego_block_height/3);

lego_badge(5,6,lego_block_height/3);

//xbyy_brick(2,18,lego_block_height/3);
//xbyy_brick(2,14,lego_block_height/3);

//x_wall_panel(16,lego_block_height);
//x_wall_panel(10,lego_block_height);

   //xbyy_wall_panel_corner(2,2,4*lego_block_height);
    //xbyy_wall_panel_corner(4,4,1*lego_block_height);
    
//x_technic_brick(1,lego_block_height);
//x_technic_brick(3,lego_block_height);



//translate([0,0,lego_block_height/4+lego_knob_height*1.25])
//xbyy_brick(2,3,lego_block_height/3);


//xbyy_brick(1,1,lego_block_height/3);
//translate([-lego_length/2,0,1.5*lego_block_height/3])
//xbyy_brick(2,1,lego_block_height/3);

//translate([0,0,-1.5*lego_block_height/3])
//xbyy_brick(2,2,lego_block_height/3);

//lego_badge(8,8,lego_block_height/3);


//x_technic_brick(4,lego_block_height);

//lego_technic_axle_stopped(3,1);

//minkowski(){
  //  lego_technic_axle_end();
   // sphere(0.1/8*lego_length,$fn=knob_fineness);
//}

//lego_technic_beam(3);


//xbyy_brick(2,2,lego_block_height/3);

// BRICK KERF TEST

    
        //x_technic_brick(1,lego_block_height);
        //xbyy_brick(1,1,lego_block_height/3);
        //xbyy_brick(2,2,lego_block_height/3);
        //twobytwo_centerknob(lego_block_height/3);
        /*
        xbyy_knobs(2,2,0);
        translate([lego_length/2,lego_length/2,0])
        knob();
        */
        
        //lego_antenna(lego_block_height*2);
        //lego_round_brick(lego_block_height/3,1);
//translate([0,0,-1.5*lego_block_height/3])
//lego_round_brick(lego_block_height/3,0);
//translate([0,0,1.5*lego_block_height/3])
//xbyy_brick(1,1,lego_block_height/3);


//xbyy_brick(1,18,lego_block_height/3);

//brick_test();
//technic_test();
//brick_test_print();

//scale([xy_shrink,xy_shrink,1])
//print_test_full();

//print_callibration_test(10);

