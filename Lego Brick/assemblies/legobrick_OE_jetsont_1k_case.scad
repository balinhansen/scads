include <../libraries/legobrick_lib.scad>;
include <../Lego Jetson TK1/LegoJetsonTK1.scad>;

big_overrides=1;

lego_length=8;

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



module nvidia_logo(scale){
    
    scale([scale?scale/14:1,scale?scale/14:1,1]){
    translate([6.5,28.5,-0.001])
linear_extrude(height=lego_knob_height+0.001, convexity=10)
    translate([0.001,0.001,0])
//import(file="nvidia.dxf",convexity=7,$fn=10);
import(file="../Lego Jetson TK1/nvidia_a.dxf",convexity=7,$fn=10);
        
translate([6.5+32.35,28.5+26.55,-0.001])
linear_extrude(height=lego_knob_height+0.001, convexity=10)
    translate([0.001,0.001,0])
import(file="../Lego Jetson TK1/nvidia_b.dxf",convexity=7,$fn=10);
    
    
            translate([19.5,16,-0.001])
            linear_extrude(height=lego_knob_height+0.001,convexity=10)
            text("Jetson TK1", font = "Liberation Sans:style=Bold");
            
            
            translate([4,5,-0.001])
            linear_extrude(height=lego_knob_height+0.001,convexity=10)
            text("Legobrick.scad Edition",size=7, font = "Liberation Sans:style=Bold Italic");
            
        
    }
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
            translate([0,2,0])
            nvidia_logo(8*lego_length);
           
            
            translate([19.5,17,lego_block_height/3-0.001])
            linear_extrude(height=lego_knob_height+0.001,convexity=10)
            text("Jetson TK1", font = "Liberation Sans:style=Bold");
            
            
            translate([8,5,lego_block_height/3-0.001])
            linear_extrude(height=lego_knob_height+0.001,convexity=10)
            text("Legobrick.scad Edition",size=7, font = "Liberation Sans:style=Italic");
            
    //cube([1,1,1]);
        }
    }
    
    
}

module logo_vectors(){
    
    union(){
            translate([0,2,0])
            nvidia_logo(10);
           
            
    //cube([1,1,1]);
        }
        
    }



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

lego_badge(10,10,lego_block_height/3);
    
    translate([0,0,lego_block_height/3])
    logo_vectors();

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



//translate([0,0,lego_block_height/4+lego_knob_height*1.25])
//xbyy_brick(2,3,lego_block_height/3);


