use <JetsonTK1.scad>;

build_stl=1;

inch=25.4;
kerf=0.0035*25.4;
xy_shrink=1; // PLA == 128/127;

nub_fineness_stl=0.5*240;
nub_fineness_low=16;
nub_adjustment=0.1; // 0.1 for Shaxon PLA

nub_fineness=build_stl?nub_fineness_stl:nub_fineness_low;
technic_hole_adjustment=0.05;

lego_length=40; // 8/8*50;
lego_height=0.4*lego_length;
lego_block_height=1.2*lego_length;

lego_nub_height=1.8/8*lego_length;
lego_nub_width=(4.8+nub_adjustment)/8*lego_length;
lego_tube_hole=(4.8+technic_hole_adjustment)/8*lego_length+kerf*2;

lego_tube=6.51371/8*lego_length; //6.51371/8*lego_length;

lego_accessory_hole=(3+0.15)/8*lego_length;
lego_accessory_peg=3/8*lego_length;

lego_technic_hole_height=5.8/8*lego_length;
lego_technic_hole=(4.8+technic_hole_adjustment)/8*lego_length+kerf*2;
lego_technic_hole_support=7.2/8*lego_length;
lego_technic_bevel=(6.2+technic_hole_adjustment)/8*lego_length+kerf*2;
lego_technic_bevel_depth=0.8/8*lego_length;
lego_technic_axle_width=4.8/8*lego_length-kerf*2;
lego_technic_axle_tooth=2/8*lego_length;
lego_technic_axle_stop=1.6/8*lego_length;
lego_technic_axle_stop_width=6.2/8*lego_length;

lego_technic_beam_width=7.4/8*lego_length;

lego_pad_width_spec=0.6;
lego_pad_width_adj=0.2;
lego_pad_width=(lego_pad_width_spec+lego_pad_width_adj)/8*lego_length;

lego_pad_depth_spec=0.3;
lego_pad_depth_adj=0.05;
lego_pad_depth=(lego_pad_depth_spec+lego_pad_depth_adj)/8*lego_length;

lego_wall_thickness=1.2;

module knob(){
    translate([lego_length/2,lego_length/2,-0.001])
    cylinder(lego_nub_height+0.001,lego_nub_width/2,lego_nub_width/2,$fn=nub_fineness);
}

module peg(height){
    cylinder(height-1/8*lego_length+0.001,lego_accessory_peg/2,lego_accessory_peg/2,$fn=nub_fineness);
}

module tube(height){
    difference(){
        cylinder(height-1/8*lego_length+0.001,lego_tube/2,lego_tube/2,$fn=nub_fineness);
        translate([0,0,-0.001])
        cylinder(height-1/8*lego_length+0.003,lego_nub_width/2+kerf,lego_nub_width/2+kerf,$fn=nub_fineness);
    }
}

module technic_hole_support(){
    translate([0,0,lego_technic_hole_height])
    rotate([-90,0,0])
    translate([0,0,0.1+lego_technic_bevel_depth])
        cylinder(lego_length-0.2-lego_technic_bevel_depth*2,lego_technic_hole_support/2,lego_technic_hole_support/2,$fn=nub_fineness);
}

module technic_hole_shape(){
     cylinder(lego_length,lego_technic_hole/2,lego_technic_hole/2,$fn=nub_fineness);
        
        translate([0,0,0.1-0.001])
        cylinder(lego_technic_bevel_depth+0.001,lego_technic_bevel/2,lego_technic_bevel/2,$fn=nub_fineness);
        
        translate([0,0,lego_length-0.1-lego_technic_bevel_depth])
        cylinder(lego_technic_bevel_depth+0.001,lego_technic_bevel/2,lego_technic_bevel/2,$fn=nub_fineness);
}

module technic_hole(){
    translate([0,0,lego_technic_hole_height])
    rotate([-90,0,0])
    {
        cylinder(lego_length,lego_technic_hole/2,lego_technic_hole/2,$fn=nub_fineness);
        
        translate([0,0,0.1-0.001])
        cylinder(lego_technic_bevel_depth+0.001,lego_technic_bevel/2,lego_technic_bevel/2,$fn=nub_fineness);
        
        translate([0,0,lego_length-0.1-lego_technic_bevel_depth])
        cylinder(lego_technic_bevel_depth+0.001,lego_technic_bevel/2,lego_technic_bevel/2,$fn=nub_fineness);
    }
}


module technic_knob(){
    difference(){
        knob();
        translate([lego_length/2,lego_length/2,-0.002])
        cylinder(lego_nub_height+0.003,lego_accessory_hole/2+kerf,lego_accessory_hole/2+kerf,$fn=nub_fineness);
    }
    
}

module xbyy_block(length,width,height){
    translate([0.1,0.1,0])
    cube(size=[lego_length*length-0.2,lego_length*width-0.2,height]);
}


module xbyy_cutout(length,width,height){
    
    if (length == 1 || width == 1){
        
        translate([0.1+(lego_wall_thickness+lego_pad_depth_spec)/8*lego_length,0.1+(lego_wall_thickness+lego_pad_depth_spec)/8*lego_length,-0.001])
        cube(size=[lego_length*length-0.2-(((lego_wall_thickness+lego_pad_depth_spec)*2)/8*lego_length),lego_length*width-0.2-(((lego_wall_thickness+lego_pad_depth_spec)*2)/8*lego_length),height-1/8*lego_length+0.001]);
        
    }else{
        
        translate([0.1+lego_wall_thickness/8*lego_length,0.1+lego_wall_thickness/8*lego_length,-0.001])
        cube(size=[lego_length*length-0.2-((lego_wall_thickness*2)/8*lego_length),lego_length*width-0.2-((lego_wall_thickness*2)/8*lego_length),height-1/8*lego_length+0.001]);
        
    }
}


module xbyy_knobs(length,width,height){
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

module xbyy_pads(length,width,height){
    for (x=[0:length-1]){
        translate([lego_length/2+lego_length*x-lego_pad_width/2,(lego_wall_thickness/8*lego_length)+0.1-0.001,0])
        cube(size=[lego_pad_width,lego_pad_depth+0.001,height-1+0.001]);
        
        translate([lego_length/2+lego_length*x-lego_pad_width/2,lego_length*width-0.1-(lego_wall_thickness/8*lego_length)-lego_pad_depth,0])
        cube(size=[lego_pad_width,lego_pad_depth+0.001,height-1+0.001]);
        
    }
    
    for (y=[0:width-1]){
        translate([(lego_wall_thickness/8*lego_length)+0.1-0.001,lego_length/2+lego_length*y-lego_pad_width/2,0])
        cube(size=[lego_pad_depth+0.001,lego_pad_width,height-1+0.001]);
        
        translate([lego_length*length-(lego_wall_thickness/8*lego_length)-lego_pad_depth-0.1,lego_length/2+lego_length*y-lego_pad_width/2,0])
        cube(size=[lego_pad_depth+0.001,lego_pad_width,height-1+0.001]);
        
    }
}


module lego_outer_pads(length,width,height){
    for (x=[0:length-1]){
            translate([lego_length/2+lego_length*x-lego_pad_width/2,(lego_wall_thickness/8*lego_length)+width*lego_length+0.1-0.001,0])
            cube(size=[lego_pad_width,lego_pad_depth+0.001,height-1+0.001]);
            
            translate([lego_length/2+lego_length*x-lego_pad_width/2,-0.1-(lego_wall_thickness/8*lego_length)-lego_pad_depth,0])
            cube(size=[lego_pad_width,lego_pad_depth+0.001,height-1+0.001]);
            
        }
        
        for (y=[0:width-1]){
            translate([(lego_wall_thickness/8*lego_length)+length*lego_length+0.1-0.001,lego_length/2+lego_length*y-lego_pad_width/2,0])
            cube(size=[lego_pad_depth+0.001,lego_pad_width,height-1+0.001]);
            
            translate([-(lego_wall_thickness/8*lego_length)-lego_pad_depth-0.1,lego_length/2+lego_length*y-lego_pad_width/2,0])
            cube(size=[lego_pad_depth+0.001,lego_pad_width,height-1+0.001]);
            
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
    cylinder(lego_block_height/3*2-1/16*inch+0.001,3.5,3.5,$fn=nub_fineness);
        translate([0,0,-0.001])
        cylinder(lego_block_height/3*2-1/16*inch+0.002-1,1.9,1.9,$fn=nub_fineness);
    }
    
    translate([lego_length+5,lego_length+5,lego_block_height-1/16*inch-0.001])
    cylinder(0.001+1/16*inch,1.375,1.375,$fn=nub_fineness);
    
    
    translate([lego_length+5,lego_length+5,lego_block_height])
    sphere(1.375,$fn=nub_fineness);
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
            }
            
            // SIDE CUTOUTS 
            
            xbyy_cutout(2,length,height);
            
            translate([lego_length*(width-2),0,0])
            xbyy_cutout(2,length,height);
            
            
            xbyy_cutout(width,2,height);
            
            translate([0,lego_length*(length-2),0])
            xbyy_cutout(width,2,height);
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
        
        translate([lego_length*((width-wid_odd)/2),lego_length*((length-len_odd)/2),0])
        xbyy_tubes(wid_odd,len_odd,height);
        
        // PADS
        
        translate([lego_length*2,lego_length*2,0])
        lego_outer_pads(width-4,length-4,height);
        
        translate([lego_length*((width-wid_odd)/2),lego_length*((length-len_odd)/2),0]){
            if (pad){
                lego_outer_pads(wid_odd,len_odd,height);
            }
            xbyy_pads(wid_odd,len_odd,height);
        }
        
        xbyy_pads(width,length,height);
        
        translate([lego_length*2,lego_length*2,0])
        xbyy_pads(width-4,length-4,height);
       
    }
    
}

module lego_nvidia_jetson_io_panel(){
    
    difference(){
    x_wall_panel(14,4*lego_block_height);
    
        translate([0.1,-8,-5/16*inch+lego_block_height/3*2]){
    rotate([90,0,90]){
        //tegra_io_panel();
        translate([8,5/16*inch,-0.001])
        serial_cutout(1.6);
        translate([44,5/16*inch,-0.001])
        hdmi_cutout(1.6);
        
        translate([65,5/16*inch,-0.001])
        usb_cutout(1.6);
        
        translate([74,5/16*inch,-0.001])
        eth_cutout(1.6);
        
        translate([99.5,5/16*inch,-0.001])
        sound_cutout(1.6);
        
        translate([108.5,5/16*inch,-0.001])
        usb_mini(1.6);
        }}
    
    }
}

module lego_nvidia_jetson_jtag_panel(){
    
    difference(){
    x_wall_panel(14,4*lego_block_height);
    
        translate([0.1,-8,-5/16*inch+lego_block_height/3*2]){
    rotate([90,0,90]){
        //tegra_io_panel();
        translate([10,5/16*inch,-0.001])
        jtag_cutout(1.6);
        }}
    
    }
}

module lego_nvidia_jetson_rear_panel(){
    
    difference(){
    x_wall_panel(14,4*lego_block_height);
    
        translate([0.1,-8,-5/16*inch+lego_block_height/3*2]){
    rotate([90,0,90]){
        //tegra_io_panel();
        translate([53.5,4.25+5/16*inch,-0.001])
        power_cutout(1.6);
        
        translate([82,5/16*inch,-0.001])
        sdcard_cutout(1.6);
        }}
    
    }
}



module nvidia_logo(){
    
    translate([6.5,28.5,lego_block_height/3-0.001])
linear_extrude(height=lego_nub_height+0.001, convexity=10)
    translate([0.001,0.001,0])
//import(file="nvidia.dxf",convexity=7,$fn=10);
import(file="nvidia_a.dxf",convexity=7,$fn=10);
        
translate([6.5+32.35,28.5+26.55,lego_block_height/3-0.001])
linear_extrude(height=lego_nub_height+0.001, convexity=10)
    translate([0.001,0.001,0])
import(file="nvidia_b.dxf",convexity=7,$fn=10);
    
}

module lego_nvidia_logo(length,width,height){

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
            nvidia_logo();
           
            
            translate([19.5,11,lego_block_height/3-0.001])
            linear_extrude(height=lego_nub_height+0.001,convexity=10)
            text("Jetson TK1", font = "Liberation Sans:style=Bold");
            
    //cube([1,1,1]);
        }
    }
    
    
}

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




//x_wall_panel(14,4*lego_block_height);
//lego_nvidia_jetson_io_panel();
//lego_nvidia_jetson_jtag_panel();
//lego_nvidia_jetson_rear_panel();


//lego_nvidia_logo(14,14,lego_block_height/3);

//lego_badge(9,9,lego_block_height/3);

//xbyy_brick(2,18,lego_block_height/3);
//xbyy_brick(2,14,lego_block_height/3);

//x_wall_panel(16,lego_block_height);
//x_wall_panel(10,lego_block_height);

    //xbyy_wall_panel_corner(2,2,4*lego_block_height);
    //xbyy_wall_panel_corner(4,4,1*lego_block_height);
    
//x_technic_brick(1,lego_block_height);
//x_technic_brick(3,lego_block_height);



//translate([0,0,lego_block_height/4+lego_nub_height*1.25])
//xbyy_brick(2,3,lego_block_height/3);



//      Technic Experiments

module lego_technic_beam(length){
    difference(){
        hull(){
            cylinder(lego_length-0.2,lego_technic_beam_width/2,lego_technic_beam_width/2,$fn=nub_fineness);
            translate([(length-1)*lego_length,0,0])
            cylinder(lego_length-0.2,lego_technic_beam_width/2,lego_technic_beam_width/2,$fn=nub_fineness);
        }
        for (i=[0:length-1]){
            translate([lego_length*i,0,-0.1])
            technic_hole_shape();
        }
    }
}

module lego_technic_axle_shape(){
    offset(r=0.2/8*lego_length,$fn=nub_fineness)
    offset(r=-0.4/8*lego_length,$fn=nub_fineness)
    offset(r=0.2/8*lego_length,$fn=nub_fineness)
    difference(){
        circle(lego_technic_axle_width/2,lego_length,$fn=nub_fineness);
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
        sphere(lego_technic_axle_width/2,$fn=nub_fineness);
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
    cylinder(lego_technic_axle_stop,lego_technic_axle_stop_width/2,lego_technic_axle_stop_width/2,$fn=nub_fineness);
}

//lego_technic_axle_stopped(3,1);

//minkowski(){
  //  lego_technic_axle_end();
   // sphere(0.1/8*lego_length,$fn=nub_fineness);
//}

//lego_technic_beam(2);

xbyy_brick(1,1,lego_block_height/3);