build_stl=1;
big_overrides=0;

    
inch=25.4;
// kerf=0.007*25.4;  // Too Tight at 5:1 @ 0.3mm layer height
//kerf=(0.007*25.4+0.05); // Attempt for 5:1 @ 0.3mm could be better!
kerf=big_overrides?(0.007*25.4):0; // Attempt for 5:1 @ 0.3mm GOODish! Testing!
round_kerf_adj=big_overrides?0.1:0.0035*inch;
accessory_kerf_adj=big_overrides?(kerf+0.05):0;
flat_kerf_adj=big_overrides?-0.075:0;

//kerf=0.2;


//xy_shrink=128/127; //1; // PLA == 128/127;
xy_shrink=1;

echo(kerf);
knob_fineness_stl=0.5*240;
knob_fineness_low=16;
knob_adjustment=0.0; // 0.1 for Shaxon PLA

knob_fineness=build_stl?knob_fineness_stl:knob_fineness_low;
technic_hole_adjustment=0.00;

lego_length=8; // 8/8*50;
lego_height=0.4*lego_length;
lego_block_height=1.2*lego_length;

lego_knob_height=1.8/8*lego_length;
lego_knob_width=(4.9+knob_adjustment)/8*lego_length;
lego_tube_hole=(4.9+technic_hole_adjustment)/8*lego_length+(kerf+round_kerf_adj)*2;

lego_tube=(big_overrides?6.4137:6.51371)/8*lego_length-kerf; // 6.51371/8*lego_length; //6.51371/8*lego_length;

lego_accessory_hole=(3.1)/8*lego_length+(round_kerf_adj+accessory_kerf_adj)*2;
lego_accessory_peg=3.1/8*lego_length-(kerf)*2;

lego_changer_height=5.7/8*lego_length;

lego_technic_hole_height=5.8/8*lego_length;
lego_technic_hole=(4.9+technic_hole_adjustment)/8*lego_length+(kerf+round_kerf_adj)*2;
lego_technic_hole_support=7.2/8*lego_length;
lego_technic_bevel=(6.2+technic_hole_adjustment)/8*lego_length+(kerf+round_kerf_adj)*2;
lego_technic_bevel_depth=0.8/8*lego_length;
lego_technic_axle_width=4.8/8*lego_length;
lego_technic_axle_tooth=2/8*lego_length;
lego_technic_axle_stop=1.6/8*lego_length;
lego_technic_axle_stop_width=6.1/8*lego_length;

lego_technic_beam_width=7.4/8*lego_length;

lego_pad_width_spec=0.6;
lego_pad_width_adj=0.2;
lego_pad_width=(lego_pad_width_spec+lego_pad_width_adj)/8*lego_length;

lego_wall_thickness=1.2;

lego_pad_depth_spec=(8-4.9)/2-lego_wall_thickness; //0.3;
lego_pad_depth_adj=0.0;
lego_pad_depth=(lego_pad_depth_spec+lego_pad_depth_adj);



function getLegoLength()=lego_length;
function getLegoBlockHeight()=lego_block_height;

module knob(){
    translate([lego_length/2,lego_length/2,-0.001])
    cylinder(lego_knob_height+0.001,lego_knob_width/2,lego_knob_width/2,$fn=knob_fineness);
}

module peg(height){
    cylinder(height-1/8*lego_length+0.001,lego_accessory_peg/2,lego_accessory_peg/2,$fn=knob_fineness);
}

module tube(height){
    difference(){
        cylinder(height-1/8*lego_length+0.001,lego_tube/2,lego_tube/2,$fn=knob_fineness);
        translate([0,0,-0.001])
        cylinder(height-1/8*lego_length+0.003,lego_tube_hole/2,lego_tube_hole/2,$fn=knob_fineness);
    }
}

module technic_brick_hole(height){
    cylinder(height+0.003,lego_tube_hole/2,lego_tube_hole/2,$fn=knob_fineness);
}

module technic_hole_support(){
    translate([0,0,lego_technic_hole_height])
    rotate([-90,0,0])
    translate([0,0,0.1+lego_technic_bevel_depth])
        cylinder(lego_length-0.2-lego_technic_bevel_depth*2,lego_technic_hole_support/2,lego_technic_hole_support/2,$fn=knob_fineness);
}

module technic_hole_shape(){
     cylinder(lego_length,lego_technic_hole/2,lego_technic_hole/2,$fn=knob_fineness);
        
        translate([0,0,0.1-0.001])
        cylinder(lego_technic_bevel_depth+0.001,lego_technic_bevel/2,lego_technic_bevel/2,$fn=knob_fineness);
        
        translate([0,0,lego_length-0.1-lego_technic_bevel_depth])
        cylinder(lego_technic_bevel_depth+0.001,lego_technic_bevel/2,lego_technic_bevel/2,$fn=knob_fineness);
}

module technic_hole(){
    translate([0,0,lego_technic_hole_height])
    rotate([-90,0,0])
    {
        cylinder(lego_length,lego_technic_hole/2,lego_technic_hole/2,$fn=knob_fineness);
        
        translate([0,0,0.1-0.001])
        cylinder(lego_technic_bevel_depth+0.001,lego_technic_bevel/2,lego_technic_bevel/2,$fn=knob_fineness);
        
        translate([0,0,lego_length-0.1-lego_technic_bevel_depth])
        cylinder(lego_technic_bevel_depth+0.001,lego_technic_bevel/2,lego_technic_bevel/2,$fn=knob_fineness);
    }
}


module technic_knob(){
    difference(){
        knob();
        translate([lego_length/2,lego_length/2,-0.002])
        cylinder(lego_knob_height+0.003,lego_accessory_hole/2,lego_accessory_hole/2,$fn=knob_fineness);
    }
    
}

module knob_perimeter(width,length){
    for (x=[0,length-1]){
        for (y=[0:width-1]){
            translate([x*lego_length,y*lego_length])
            knob();
        }
    }
    for (x=[1:length-2]){
        for (y=[0,width-1]){
            translate([x*lego_length,y*lego_length])
            knob();
        }
    }
}

module technic_knob_perimeter(width,length){
    for (x=[0,length-1]){
        for (y=[0:width-1]){
            translate([x*lego_length,y*lego_length])
            technic_knob();
        }
    }
    for (x=[1:length-2]){
        for (y=[0,width-1]){
            translate([x*lego_length,y*lego_length])
            technic_knob();
        }
    }
}

module xbyy_block(length,width,height){
    translate([0.1,0.1,0])
    cube(size=[lego_length*length-0.2,lego_length*width-0.2,height]);
}


module xbyy_cutout(length,width,height){
    
    if (length == 1 || width == 1){
        
        translate([(lego_wall_thickness+lego_pad_depth)/8*lego_length-(kerf+flat_kerf_adj),(lego_wall_thickness+lego_pad_depth)/8*lego_length-(kerf+flat_kerf_adj),-0.001])
        cube(size=[
        lego_length*length-(((lego_wall_thickness+lego_pad_depth)*2)/8*lego_length)+(kerf+flat_kerf_adj)*2,
        lego_length*width-(((lego_wall_thickness+lego_pad_depth)*2)/8*lego_length)+(kerf+flat_kerf_adj)*2,
        height-1/8*lego_length+0.001]);
        
    }else{
        
        translate([lego_wall_thickness/8*lego_length,lego_wall_thickness/8*lego_length,-0.001])
        cube(size=[lego_length*length-((lego_wall_thickness*2)/8*lego_length),lego_length*width-((lego_wall_thickness*2)/8*lego_length),height-1/8*lego_length+0.001]);
        
    }
}


module xbyy_knobs(length,width,height){
    for (x=[0:length-1]){
        for (y=[0:width-1]){
            
            translate([lego_length*x,lego_length*y,height])
            knob();
        }
    }
}


module xbyy_technic_knobs(length,width,height){
    for (x=[0:length-1]){
        for (y=[0:width-1]){
            
            translate([lego_length*x,lego_length*y,height])
            technic_knob();
        }
    }
}

module xbyy_pegs(length,dir,height){
    if (!dir){
        for (i=[1:length-1]){
            translate([lego_length*i,lego_length/2,0])
            peg(height);
        }
    }else{
        for (i=[1:length-1]){
            translate([lego_length/2,lego_length*i,0])
            peg(height);
        }
    }
}

module xbyy_tubes(length,width,height){
    for (x=[1:length-1]){
        for (y=[1:width-1]){
            
            translate([lego_length*x,lego_length*y,0])
            tube(height);
        }
    }
}

module xbyy_technic_holes(length,width,height){
    for (x=[1:length-1]){
        for (y=[1:width-1]){
            
            translate([lego_length*x,lego_length*y,0])
            technic_brick_hole(height);
        }
    }
}

module xbyy_pads(length,width,height){
    for (x=[0:length-1]){
        translate([lego_length/2+lego_length*x-lego_pad_width/2,(lego_wall_thickness/8*lego_length)-0.001,0])
        cube(size=[lego_pad_width,lego_pad_depth/8*lego_length-(kerf+flat_kerf_adj)+0.001,height-1+0.001]);
        
        translate([lego_length/2+lego_length*x-lego_pad_width/2,lego_length*width-(lego_wall_thickness/8*lego_length)-lego_pad_depth/8*lego_length+(kerf+flat_kerf_adj),0])
        cube(size=[lego_pad_width,lego_pad_depth/8*lego_length+0.001-(kerf+flat_kerf_adj),height-1+0.001]);
        
    }
    
    for (y=[0:width-1]){
        translate([(lego_wall_thickness/8*lego_length)-0.001,lego_length/2+lego_length*y-lego_pad_width/2,0])
        cube(size=[lego_pad_depth/8*lego_length+0.001-(kerf+flat_kerf_adj),lego_pad_width,height-1+0.001]);
        
        translate([lego_length*length-(lego_wall_thickness/8*lego_length)-lego_pad_depth/8*lego_length+(kerf+flat_kerf_adj),lego_length/2+lego_length*y-lego_pad_width/2,0])
        cube(size=[lego_pad_depth/8*lego_length-(kerf+flat_kerf_adj)+0.001,lego_pad_width,height-1+0.001]);
        
    }
}


module lego_outer_pads(length,width,height){
    for (x=[0:length-1]){
            translate([lego_length/2+lego_length*x-lego_pad_width/2,(lego_wall_thickness/8*lego_length)+width*lego_length+0.1-0.001,0])
            cube(size=[lego_pad_width,lego_pad_depth/8*lego_length+0.001,height-1+0.001]);
            
            translate([lego_length/2+lego_length*x-lego_pad_width/2,-0.1-(lego_wall_thickness/8*lego_length)-lego_pad_depth/8*lego_length,0])
            cube(size=[lego_pad_width,lego_pad_depth/8*lego_length+0.001,height-1+0.001]);
            
        }
        
        for (y=[0:width-1]){
            translate([(lego_wall_thickness/8*lego_length)+length*lego_length+0.1-0.001,lego_length/2+lego_length*y-lego_pad_width/2,0])
            cube(size=[lego_pad_depth/8*lego_length+0.001,lego_pad_width,height-1+0.001]);
            
            translate([-(lego_wall_thickness/8*lego_length)-lego_pad_depth/8*lego_length-0.1,lego_length/2+lego_length*y-lego_pad_width/2,0])
            cube(size=[lego_pad_depth/8*lego_length+0.001,lego_pad_width,height-1+0.001]);
            
        }
       
}

module x_technic_hole_supports(length){
    for (x=[1:length-1]){
        translate([lego_length*x,0,0])
        technic_hole_support();
    }
}

module x_technic_holes(length){
    for (x=[1:length-1]){
        translate([lego_length*x,0,0])
        technic_hole();
    }
}


module xbyy_brick(width,length,height){
    union(){
        difference(){
        xbyy_block(width,length,height);
        xbyy_cutout(width,length,height);
        }
        xbyy_knobs(width,length,height);
        
        if (width > 1 && length == 1){
            xbyy_pegs(width,0,height);
        }
        
        if (width == 1 && length > 1){
            xbyy_pegs(length,1,height);
        }
        
        if (width > 1 && length > 1){
            xbyy_tubes(width,length,height);
            xbyy_pads(width,length,height);
        }
    }
}

module technic_xbyy_brick(width,length,height){
    union(){
        difference(){
        xbyy_block(width,length,height);
        xbyy_cutout(width,length,height);
            xbyy_technic_holes(width,length,height);
        }
        xbyy_knobs(width,length,height);
        
        if (width > 1 && length == 1){
            xbyy_pegs(width,0,height);
        }
        
        if (width == 1 && length > 1){
            xbyy_pegs(length,1,height);
        }
        
        if (width > 1 && length > 1){
            xbyy_tubes(width,length,height);
            xbyy_pads(width,length,height);
        }
    }
}

module lego_round_brick(height,technic){
    difference(){
        union(){
            translate([lego_length/2,lego_length/2,0]){
            translate([0,0,2.2/8*lego_length])
            cylinder(height-2.2/8*lego_length,(lego_length-0.2)/2,(lego_length-0.2)/2,$fn=knob_fineness);
            
            cylinder(2.2/8*lego_length,lego_tube/2,lego_tube/2,$fn=knob_fineness);
            }
            translate([0,0,height-0.001])
            knob();
        }
        translate([lego_length/2,lego_length/2,-0.001])
        cylinder(height-1/8*lego_length+0.002,lego_tube_hole/2,lego_tube_hole/2,$fn=knob_fineness);
        
        if (technic){
            
            translate([lego_length/2,lego_length/2,height-1/8*lego_length-0.001])
            cylinder(lego_knob_height+1/8*lego_length+0.002,lego_accessory_hole/2,lego_accessory_hole/2,$fn=knob_fineness);
            
        }else{
            
            translate([lego_length/2,lego_length/2,height-1/8*lego_length-0.001])
            cylinder(1.8/8*lego_length+0.001,lego_accessory_hole/2,lego_accessory_hole/2,$fn=knob_fineness);
            
        }
        
    }
}


module lego_antenna(height){
    difference(){
        union(){
            translate([lego_length/2,lego_length/2,0]){
            cylinder(3.2/8*lego_length,lego_tube/2,lego_tube/2,$fn=knob_fineness);
                
                
            translate([0,0,3.2/8*lego_length-0.001])
            cylinder(1.8/8*lego_length+0.001,lego_knob_width/2,lego_knob_width/2,$fn=knob_fineness);
                
            translate([0,0,5/8*lego_length-0.001])
            cylinder(height-5/8*lego_length-lego_accessory_peg/2+0.001,lego_accessory_peg/2,lego_accessory_peg/2,$fn=knob_fineness);
            
            
            translate([0,0,height-lego_accessory_peg/2])
            sphere(lego_accessory_peg/2,$fn=knob_fineness);
            }
        }
        translate([lego_length/2,lego_length/2,0]){
            translate([0,0,-0.001])
        cylinder(2.2/8*lego_length+0.002,lego_tube_hole/2,lego_tube_hole/2,$fn=knob_fineness);
        
        translate([0,0,2.2/8*lego_length-0.001])
            cylinder(1.8/8*lego_length,lego_accessory_hole/2,lego_accessory_hole/2,$fn=knob_fineness);
        
        }
     }
}

module twobytwo_centerknob(height){
    union(){
        difference(){
        xbyy_block(2,2,height);
        xbyy_cutout(2,2,height);
        }
        translate([lego_length/2,lego_length/2,0])
        xbyy_knobs(1,1,height);
        
        
        xbyy_tubes(2,2,height);
        xbyy_pads(2,2,height);
    }
}

module xbyy_knobrow(width,length,knob_offset,height){
    difference(){   
        xbyy_block(width,length,height);
        xbyy_cutout(width,length,height);
    }
        translate([knob_offset,0,0])
        xbyy_knobs(1,length,height);
        xbyy_tubes(width,length,height);
        xbyy_pads(width,length,height);
}

module x_technic_brick(length,height){
    difference(){
        union(){
            difference(){
            xbyy_block(length,1,height);
            xbyy_cutout(length,1,height);
            }
            if (length > 1){
                x_technic_hole_supports(length);
            }else{
                translate([-lego_length/2,0,0])
                x_technic_hole_supports(2);
            }
            
            if (length > 1){
                xbyy_pegs(length,0,height);
            }
            xbyy_knobs(length,1,height);
        }
        
        if (length > 1){
            x_technic_holes(length);
        }else{
            translate([-lego_length/2,0,0])
            x_technic_holes(2);
        }
    }
}



module xbyy_knobedge_corner(width,length,corner,height){
    difference(){   
        xbyy_block(width,length,height);
        xbyy_cutout(width,length,height);
    }
        xbyy_knobs(1,length,height);
    
        
        translate([lego_length,corner?(length-1)*lego_length:0,0])
        xbyy_knobs(width-1,1,height);
    
        xbyy_tubes(width,length,height);
        xbyy_pads(width,length,height);
}

module xbyy_knobedge_side(width,length,corner,height){
    difference(){   
        xbyy_block(width,length,height);
        xbyy_cutout(width,length,height);
    }
        xbyy_knobs(1,length,height);
    
        
        translate([lego_length,0,0])
        xbyy_knobs(width-1,1,height);
    
        translate([lego_length,(length-1)*lego_length,0])
        xbyy_knobs(width-1,1,height);
    
        xbyy_tubes(width,length,height);
        xbyy_pads(width,length,height);
}

module xbyy_overhang(length,over,height,flat){
    union(){
        difference(){
            xbyy_block(1+over/8,length,height);
            xbyy_cutout(1,length,height);
                
            if (over > 1.5){
                translate([lego_length,(lego_wall_thickness+0.3)/8*lego_length+0.1,-0.001])
                cube(size=[(over-1.5)/8*lego_length,length*lego_length-((lego_wall_thickness+0.3)*2)/8*lego_length-0.2,height-1/8*lego_length+0.001]);
            }
        }
        
        if (!flat){
            xbyy_knobs(1,length,height);
        }
        
        if (length > 1){
            xbyy_pegs(length,1,height);
        }
    }
}

module xbyy_overhang_corner(width,length,over_l,over_r,height,flat){
    union(){
        difference(){
            xbyy_block(width,length,height);
            union(){
                xbyy_cutout(1,length,height);
                xbyy_cutout(width,1,height);
            }
        
            translate([over_l+lego_length-0.1,over_r+lego_length-0.1,-0.001])
            cube([lego_length*(width-1)+0.001,lego_length*(length-1)+0.001,height+0.002]);
        
            if (over_l > 1.5){
                translate([lego_length,lego_length,-0.001])
                cube(size=[(over_l-1.5)/8*lego_length,(length-1)*lego_length-((lego_wall_thickness+0.3))/8*lego_length-0.1,height-1/8*lego_length+0.001]);
            }
            
            if (over_r > 1.5){
                translate([lego_length,lego_length,-0.001])
                cube(size=[(width-1)*lego_length-((lego_wall_thickness+0.3))/8*lego_length-0.1,(over_r-1.5)/8*lego_length,height-1/8*lego_length+0.001]);
            }
        }
        
        if (!flat){
            xbyy_knobs(width,1,height);
            xbyy_knobs(1,length,height);
        }
        
        if (length > 1){
            xbyy_pegs(length,1,height);
        }
        
        if (width > 1){
            xbyy_pegs(width,0,height);
        }
    }
    
    
}

module xbyy_knobedge_corner_stand(width,length,corner,height){
    difference(){   
        xbyy_block(width,length,height);
        xbyy_cutout(width,length,height);
    }
        xbyy_knobs(1,length,height);
    
        
        translate([lego_length,corner?(length-1)*lego_length:0,0])
        xbyy_knobs(width-1,1,height);
    
        xbyy_tubes(width,length,height);
        xbyy_pads(width,length,height);
    
    translate([lego_length+5,lego_length+5,lego_block_height/3-0.001])
    difference(){
    cylinder(lego_block_height/3*2-1/16*inch+0.001,3.5,3.5,$fn=knob_fineness);
        translate([0,0,-0.001])
        cylinder(lego_block_height/3*2-1/16*inch+0.002-1,1.9,1.9,$fn=knob_fineness);
    }
    
    translate([lego_length+5,lego_length+5,lego_block_height-1/16*inch-0.001])
    cylinder(0.001+1/16*inch,1.375,1.375,$fn=knob_fineness);
    
    
    translate([lego_length+5,lego_length+5,lego_block_height])
    sphere(1.375,$fn=knob_fineness);
}



module x_wall_panel(length,height){
    union(){
        difference(){
            xbyy_block(1,length,lego_block_height/3);
            xbyy_cutout(1,length,lego_block_height/3);
        }

        translate([0,0,height-1.6])
        xbyy_block(1,length,1.6);
        
        translate([0.1,0.1,lego_block_height/3-0.001])
        cube(size=[1.6,lego_length*length-0.2,height-lego_block_height/3-1.6+0.002]);
        
        
        xbyy_knobs(1,length,height);

        if (length > 1){
            xbyy_pegs(length,1,lego_block_height/3);
        }
    }
}

module xbyy_wall_panel_corner(width,length,height){
    union(){
        difference(){
            union(){
            xbyy_block(1,width,lego_block_height/3);
            xbyy_block(length,1,lego_block_height/3);
            }
            union(){
            xbyy_cutout(1,width,lego_block_height/3);
            xbyy_cutout(length,1,lego_block_height/3);
            }
        }

        translate([0,0,height-1.6])
        xbyy_block(1,width,1.6);
        
        translate([0,0,height-1.6])
        xbyy_block(length,1,1.6);
        
        translate([lego_length-0.1-1.6,lego_length-1.6,lego_block_height/3-0.001])
        cube(size=[1.6,lego_length*(width-1)+1.6-0.2,height-lego_block_height/3-1.6+0.002]);
        
        translate([lego_length-1.6,lego_length-0.1-1.6,lego_block_height/3-0.001])
        cube(size=[lego_length*(length-1)+1.6-0.2,1.6,height-lego_block_height/3-1.6+0.002]);
        
        
        xbyy_knobs(1,width,height);
        xbyy_knobs(length,1,height);

        if (length > 1){
            xbyy_pegs(length,0,lego_block_height/3);
        }
        if (width > 1){
            xbyy_pegs(width,1,lego_block_height/3);
        }
    }
}


module lego_badge(length,width,height){
    
    len_odd=(length%2)?3:2;
    wid_odd=(width%2)?3:2;
    center=(width>=6 && length>=6);
    pad=(width>=8 && length >=8);
    
    union(){
        difference(){
            xbyy_block(width,length,height);
            
            
            // CENTER PADDING CUTOUTS
            
            if (pad){
                translate([lego_length*2,lego_length*2,0])
                xbyy_cutout(width-4,(length-4-len_odd)/2,height);
                
                translate([lego_length*2,lego_length*(length+len_odd)/2,0])
                xbyy_cutout(width-4,(length-4-len_odd)/2,height);
                
                
                translate([lego_length*2,lego_length*2,0])
                xbyy_cutout((width-4-wid_odd)/2,length-4,height);
                
                translate([lego_length*(width+wid_odd)/2,lego_length*2,0])
                xbyy_cutout((width-4-wid_odd)/2,length-4,height);
                
            }
            
            
            //  CENTER CUTOUT
            
            
            if (center){
                translate([lego_length*((width-wid_odd)/2),lego_length*((length-len_odd)/2),0])
                xbyy_cutout(wid_odd,len_odd,height);
            
            // SIDE CUTOUTS 
            
            xbyy_cutout(2,length,height);
            
            translate([lego_length*(width-2),0,0])
            xbyy_cutout(2,length,height);
            
            
            xbyy_cutout(width,2,height);
            
            translate([0,lego_length*(length-2),0])
            xbyy_cutout(width,2,height);
                
                
            }else{
                
            xbyy_cutout(width,length,height);
            
            }
        }
        //xbyy_knobs(width,length,height);
        
        // SIDE TUBES
        
        xbyy_tubes(2,length,height);
        
        translate([(width-2)*lego_length,0,0])
        xbyy_tubes(2,length,height);
        
        translate([lego_length,0,0])
        xbyy_tubes(width-2,2,height);
       
        translate([lego_length,(length-2)*lego_length,0])
        xbyy_tubes(width-2,2,height);
        
        // CENTER TUBES
        
        if (center){
            translate([lego_length*((width-wid_odd)/2),lego_length*((length-len_odd)/2),0])
            xbyy_tubes(wid_odd,len_odd,height);
        }else{
            translate([lego_length,lego_length,0])
            xbyy_tubes(width-2,length-2,height);
        }
        
        // PADS
        
        if (center){
            
        translate([lego_length*2,lego_length*2,0])
        lego_outer_pads(width-4,length-4,height);
        
        translate([lego_length*((width-wid_odd)/2),lego_length*((length-len_odd)/2),0]){
            if (pad){
                lego_outer_pads(wid_odd,len_odd,height);
            }
            xbyy_pads(wid_odd,len_odd,height);
        }
        
        
        translate([lego_length*2,lego_length*2,0])
        xbyy_pads(width-4,length-4,height);
    }
    xbyy_pads(width,length,height);
        
    }
    
}



module lego_badge_notubes(length,width,height){
    
    union(){
        difference(){
            xbyy_block(width,length,height);
            xbyy_cutout(width,length,height);  
        }
        
    xbyy_pads(width,length,height);
        
    }
    
}
module svg_logo(filename){
    
    translate([6.5,28.5,lego_block_height/3-0.001])
linear_extrude(height=lego_knob_height+0.001, convexity=10)
    translate([0.001,0.001,0])
//import(file="nvidia.dxf",convexity=7,$fn=10);
import(file="nvidia_a.dxf",convexity=7,$fn=10);
        
translate([6.5+32.35,28.5+26.55,lego_block_height/3-0.001])
linear_extrude(height=lego_knob_height+0.001, convexity=10)
    translate([0.001,0.001,0])
import(file=filename,convexity=7,$fn=10);
    
}

module lego_svg_logo(length,width,height){

    union(){
        difference(){
            xbyy_block(width,length,height);
            
            
            translate([lego_length*2,lego_length*2,0])
            xbyy_cutout(width-10,length-4,height);
            
            translate([lego_length*8,lego_length*2,0])
            xbyy_cutout(width-10,length-4,height);
            
            translate([lego_length*2,lego_length*2,0])
            xbyy_cutout(width-4,length-10,height);
            
            translate([lego_length*2,lego_length*8,0])
            xbyy_cutout(width-4,length-10,height);
            
            
            translate([lego_length*6,lego_length*6,0])
            xbyy_cutout(2,2,height);
            
            
            xbyy_cutout(2,length,height);
            
            translate([lego_length*(width-2),0,0])
            xbyy_cutout(2,length,height);
            
            
            xbyy_cutout(width,2,height);
            
            translate([0,lego_length*(length-2),0])
            xbyy_cutout(width,2,height);
        }
        //xbyy_knobs(width,length,height);
        
        // TUBES
        
        xbyy_tubes(2,length,height);
        translate([(length-2)*lego_length,0,0])
        xbyy_tubes(2,length,height);
        
        translate([lego_length,0,0])
        xbyy_tubes(width-2,2,height);
        translate([lego_length,(width-2)*lego_length,0])
        xbyy_tubes(width-2,2,height);
        
        translate([lego_length*6,lego_length*6,0])
        xbyy_tubes(2,2,height);
        
        // PADS
        
        translate([lego_length*2,lego_length*2,0])
        lego_outer_pads(width-4,length-4,height);
        
        translate([lego_length*6,lego_length*6,0]){
            lego_outer_pads(2,2,height);
            xbyy_pads(2,2,height);
        }
        
        xbyy_pads(width,length,height);
        
        translate([lego_length*2,lego_length*2,0])
        xbyy_pads(width-4,length-4,height);
        
        
        
        
        union(){
            svg_logo();
           
            
            translate([19.5,11,lego_block_height/3-0.001])
            linear_extrude(height=lego_knob_height+0.001,convexity=10)
            text("Jetson TK1", font = "Liberation Sans:style=Bold");
            
    //cube([1,1,1]);
        }
    }
    
    
}

//      Technic Experiments

module lego_technic_beam(length){
    difference(){
        hull(){
            cylinder(lego_length-0.2,lego_technic_beam_width/2,lego_technic_beam_width/2,$fn=knob_fineness);
            translate([(length-1)*lego_length,0,0])
            cylinder(lego_length-0.2,lego_technic_beam_width/2,lego_technic_beam_width/2,$fn=knob_fineness);
        }
        for (i=[0:length-1]){
            translate([lego_length*i,0,-0.1])
            technic_hole_shape();
        }
    }
}

module lego_technic_axle_shape(){
    offset(r=0.2/8*lego_length,$fn=knob_fineness)
    offset(r=-0.4/8*lego_length,$fn=knob_fineness)
    offset(r=0.2/8*lego_length,$fn=knob_fineness)
    difference(){
        circle(lego_technic_axle_width/2,lego_length,$fn=knob_fineness);
        for (i=[0:3]){
            rotate([0,0,360/4*i])
            translate([lego_technic_axle_tooth/2,lego_technic_axle_tooth/2,0])
            square(lego_length-lego_technic_axle_tooth);
        }
    }
    
}

module lego_technic_axle_end(){
    intersection(){
        translate([0,0,-0.001])
        linear_extrude(lego_technic_axle_stop+0.001,convexity=10)
        lego_technic_axle_shape();
        scale([1,1,2*(lego_technic_axle_stop)/lego_technic_axle_width])
        sphere(lego_technic_axle_width/2,$fn=knob_fineness);
    }
}

module lego_technic_axle(length){
    union(){
        translate([0,0,length*lego_length-lego_technic_axle_stop-0.1])
        lego_technic_axle_end();
        
        translate([0,0,lego_technic_axle_stop+0.1])
        linear_extrude(length*lego_length-0.2-lego_technic_axle_stop*2)
        lego_technic_axle_shape();
        
        rotate([0,180,0])
        translate([0,0,-lego_technic_axle_stop-0.1])
        lego_technic_axle_end();
        
    }
}

module lego_technic_axle_stopped(length,stop){
    
    lego_technic_axle(length);
    translate([0,0,lego_length*stop-(lego_technic_axle_stop)/2])
    cylinder(lego_technic_axle_stop,lego_technic_axle_stop_width/2,lego_technic_axle_stop_width/2,$fn=knob_fineness);
}
