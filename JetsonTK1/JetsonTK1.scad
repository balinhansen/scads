inch=25.4;

fineness_stl=240;
fineness_low=40;

build_stl=1;

fineness=build_stl?fineness_stl:fineness_low;


tegra_length=5*inch;
tegra_width=5*inch;
tegra_height=1.5*inch;

//shell_thickness=1/16*inch;


module serial_cutout(shell_thickness){
    linear_extrude(shell_thickness+0.002,convexity=10)
    offset(delta=0.5)
    serial_shape();
    /*
    polygon(
    points=[
    [0,1/8*inch],
    [3/16*inch+1.5,1/8*inch],
    [3/16*inch+1.5,1/16*inch],
    [1*inch+1.5,1/16*inch],
    [1*inch+1.5,1/8*inch],
    [(1+3/16)*inch+3,1/8*inch],
    [(1+3/16)*inch+3,7/16*inch],
    [1*inch+1.5,7/16*inch],
    [1*inch+1.5,1/2*inch],
    [3/16*inch+1.5,1/2*inch],
    [3/16*inch+1.5,7/16*inch],
    [0,7/16*inch]
    ]);
    */
}

module hdmi_cutout(shell_thickness){
    linear_extrude(shell_thickness+0.002,convexity=10)
    offset(delta=0.5)
    polygon(
    points=[
    [0,2],
    [1,2],
    [2,1],
    [13,1],
    [14,2],
    [15,2],
    [15,6],
    [0,6]
    ]);
}

module usb_cutout(shell_thickness){
    linear_extrude(shell_thickness+0.002,convexity=10)
    offset(delta=0.5)
    square(size=[6,14]);
}

module eth_cutout(shell_thickness){
    linear_extrude(shell_thickness+0.002,convexity=10)
    offset(delta=0.5)
    square(size=[16,13.5]);
}

module sound_cutout(shell_thickness){
    translate([0,6,0])
    linear_extrude(shell_thickness+0.002,convexity=10)
    offset(delta=0.5)
    circle(3.5,$fn=fineness);
    
    translate([0,18.5,0])
    linear_extrude(shell_thickness+0.002,convexity=10)
    offset(delta=0.5)
    circle(3.5,$fn=fineness);
}

module usb_mini(shell_thickness){
    translate([0,-0.5,0])
    linear_extrude(shell_thickness+0.002,convexity=10)
    offset(delta=0.5)
    square(size=[8,3]);
}


module jtag_cutout(shell_thickness){
    linear_extrude(shell_thickness+0.002,convexity=10)
    polygon(points=[[0,0],[34,0],[34,10],[0,10],[0,0]]);
}

module power_cutout(shell_thickness){
 cylinder(shell_thickness+0.002,3.5,3.5,$fn=240);   
}

module sdcard_cutout(shell_thickness){
 cube([26,4,shell_thickness+0.002]);   
}

module tegra_io_panel(shell_thickness){
    translate([5,0,0])
    cube(size=[tegra_length-10,tegra_height,shell_thickness]);
}

module tegra_front_panel(){
    
    difference(){
        tegra_io_panel(1/16*inch);
        translate([8,5/16*inch,-0.001])
        serial_cutout(1/16*inch);
        translate([44,5/16*inch,-0.001])
        hdmi_cutout(1/16*inch);
        
        translate([65,5/16*inch,-0.001])
        usb_cutout(1/16*inch);
        
        translate([74,5/16*inch,-0.001])
        eth_cutout(1/16*inch);
        
        translate([99.5,5/16*inch,-0.001])
        sound_cutout(1/16*inch);
        
        translate([108.5,5/16*inch,-0.001])
        usb_mini(1/16*inch);
    }
}

module tegra_jtag_panel(){
    difference(){
        tegra_io_panel(1/16*inch);
        
        translate([10,5/16*inch,-0.001])
        jtag_cutout(1/16*inch);
    }
}

module tegra_rear_panel(){
    difference(){
        tegra_io_panel(1/16*inch);
        
        translate([53.5,4.25+5/16*inch,-0.001])
        power_cutout(1/16*inch);
        
        translate([82,5/16*inch,-0.001])
        sdcard_cutout(1/16*inch);
    }
}


//tegra_front_panel();
//tegra_jtag_panel();
tegra_rear_panel();



module serial_shape(){
    /*
    polygon(
    points=[
    [0,1/8*inch],
    [3/16*inch+1.5,1/8*inch],
    [3/16*inch+1.5,1/16*inch],
    [1*inch+1.5,1/16*inch],
    [1*inch+1.5,1/8*inch],
    [(1+3/16)*inch+3,1/8*inch],
    [(1+3/16)*inch+3,7/16*inch],
    [1*inch+1.5,7/16*inch],
    [1*inch+1.5,1/2*inch],
    [3/16*inch+1.5,1/2*inch],
    [3/16*inch+1.5,7/16*inch],
    [0,7/16*inch]
    ]);
    */
    union(){
        hull(){
            translate([1.5+7.5,9,0])
            circle(2.5,$fn=fineness);
            translate([1.5+21.5,9,0])
            circle(2.5,$fn=fineness);
            
            translate([1.5+8.5,4.5,0])
            circle(2.5,$fn=fineness);
            translate([1.5+20.5,4.5,0])
            circle(2.5,$fn=fineness);
        }
        
        hull(){
            translate([3,6.75,0])
            circle(3,$fn=fineness);
            translate([29,6.75,0])
            circle(3,$fn=fineness);
        }
        
    }
}

module serial_test(){
    difference(){
        translate([0,0,-0.001])
        linear_extrude(shell_thickness+0.002)
        offset(delta=2.5)
        serial_shape();
        
        translate([0,0,-0.002])
        linear_extrude(shell_thickness+0.004)
        offset(delta=0.5)
        serial_shape();
    }
}

//serial_test();
