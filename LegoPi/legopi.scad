use <../Lego Brick/legolib.scad>;
use <../PocketPi/pilib.scad>;

inch=25.4;
kerf=0.007*inch;

shrinkage=1/(127/128)-1;

echo(shrinkage);
lego_length=getLegoLength();
lego_block_height=getLegoBlockHeight();


//translate([0,0,lego_block_height/3])


module PiZeroStand(){
    translate([-65/2,-30/2,0]){
        translate([3,3,0])
        difference(){
            BoardSupport();
            
            translate([0,0,1.6])
            PiZeroKerf();
        }

        PiZeroHolePlace(){
            translate([0,0,-0.001])
            cylinder(1.6-kerf,3,3,$fn=72);
            
          translate([0,0,1.6-kerf-0.001])
            cylinder(0.001+1/16*inch-1.375,1.375,1.375,$fn=36);
            
            
            translate([0,0,1.6+1/16*inch-1.375-kerf])
            sphere(1.375,$fn=36);
        }
    
    }
    
    translate([-lego_length*9/2,-lego_length*5/2,-lego_block_height/3])
    difference(){
        translate([0,0,lego_block_height/3])
        LegoPiConnector();
        translate([3-65/2+lego_length*9/2,3-30/2+lego_length*5/2])
        translate([0,0,lego_block_height/3])
        BoardSupportCutout();
        
    }  
}


module LegoPiConnector(){
    for (x=[0,3,4]){
        translate([lego_length*x,0])
        technic_knob();
    }
    
    for (x=[0:8]){
        translate([lego_length*x,lego_length*4])
        technic_knob();
    }
    
    
    for (y=[1:3]){
        translate([0,lego_length*y])
        technic_knob();
    }
    
    for (y=[1:3]){
        translate([lego_length*8,lego_length*y])
        technic_knob();
    }
}


module LegoPiBottom(){

lego_badge(5,9,lego_block_height/3);

difference(){
translate([lego_length*9/2,lego_length*5/2,lego_block_height/3])
PiZeroStand();
    translate([3,3,lego_block_height/3-1.6])
    LegoPiIOCutouts();
}
/*
    difference(){
        translate([0,0,lego_block_height/3])
        lego_badge_notubes(5,9,lego_block_height/3*2);
        translate([3,3,lego_block_height/3-1.6]){
            Cutouts();
            MicroSDNailCutout();
        }
    }
*/
}



//  MicroSD Cutout and Shell


module LegoPiMicroSDCutout(){
    translate([bevel+14,12/2+bevel+16.9,board_zpos+board_thickness])
    rotate([0,0,180])
    cube([bevel+1+24,12,2.5]);
}



module LegoPiMicroSDShellCutout(offsetx,offsety,depthx,top,zpos,shell,fineness){
    
    h=top-zpos;
    
    translate([-22.5+offsetx+1,16.9+offsety,zpos])
    translate([0,0,-0.001])
    intersection(){
        cylinder(h,22.5+shell,22.5+shell,$fn=fineness);
            translate([22.5-((depthx+1+shell)/2)+shell,0,h/2])
            cube(size=[depthx+shell+1,12+shell*2,h],center=true);
    }
}

module LegoPiMicroSDNailCutout(offsetx,offsety,depthx,top,zpos,fineness){
    
    h=top-zpos;
    
    translate([-22.5+offsetx+1,16.9+offsety,zpos])
    translate([0,0,-0.002])
    intersection(){
        cylinder(h+0.002,22.5,22.5,$fn=fineness);
            translate([22.5-((depthx+1)/2)-0.001,0,h/2])
            cube(size=[10+depthx+1+0.001,12,h+0.004],center=true);
    }
}

module LegoPiMicroSDTab(offsetx,offsety,depthx,zpos,shell,fineness){
    translate([-22.5+offsetx+1,16.9+offsety,zpos])
    
        
        intersection(){
            cylinder(shell,22.5+shell,22.5+shell,$fn=fineness);
            translate([22.5-((depthx+1+shell)/2)+shell,0,shell/2-0.001])
            cube(size=[depthx+shell+1,12+shell*2,shell+0.002],center=true);
        }
}




// MiniHDMI Cutout and Shell


module LegoPiHDMIMiniCladdingCutout(offsetx,offsety,depthy,top,zpos){
    
        translate([offsetx+12.4-3-11.5/2,0,zpos-0.1])
        cube([11.5+6,depthy+0.1+0.1,top-zpos+0.2]);
}


module LegoPiHDMIMiniCladdingShell(offsetx,offsety,depthy,top,zpos,shell){
    
    difference(){
        
        translate([offsetx+12.4-3-shell-11.5/2,0.1,zpos])
        cube([11.5+6+shell*2,depthy+shell+0.1-0.25-0.1,top-zpos]);
        
        LegoPiHDMIMiniCladdingCutout(offsetx,offsety,depthy-0.25-0.1,top,zpos-0.1);
          
        translate([offsetx+12.4-3-shell-11.5/2-0.1,depthy-1.25,zpos-0.1])
        cube([11.5+6+shell*2+0.2,shell+0.1+0.1+1.25,3+0.1]);
            
        
         translate([offsetx+12.4+11.5/2-0.1,depthy-0.25,zpos+1.6+1/20*inch-0.1])
        cube([2.25+0.1,shell+0.1+0.1,2.55-1/20*inch+0.1]);
        
         translate([offsetx+12.4-11.5/2-3-shell-0.1,shell,zpos-0.1])
        cube([shell+0.2,lego_length*5/2-30/2,1.8+0.1+kerf]);
        
        
         translate([offsetx+12.4+11.5/2+3-0.1,shell,zpos-0.1])
        cube([shell+0.2,lego_length*5/2-30/2,1.8+0.1+kerf]);
        
    
        translate([0.5,3,lego_block_height/3-1.6]){
            
            HDMIMiniCutoutNoDetail();
        }
        
    }
    
        // translate([offsetx+12.4+11.5/2-0.1,depthy-0.25,zpos+1.6+1/20*inch-0.1])
       // cube([2.25+0.1,shell+0.1+0.1,2.55-1/20*inch+0.1]);
        
}




module LegoPiUSBMicroCladdingCutout(offsetx,offsety,depthy,top,zpos){
    
        translate([offsetx+41.4-3-8.05/2,0,zpos-0.1])
        cube([8.05+12.6+6,depthy+0.1+0.1,top-zpos+0.2]);
}


module LegoPiUSBMicroCladdingShell(offsetx,offsety,depthy,top,zpos,shell){
    
    difference(){
        
        translate([offsetx+41.4-3-shell-8.05/2,0.1,zpos])
        cube([7.5+12.6+6+shell*2,depthy+shell+0.1-0.25-0.1,top-zpos]);
        
        LegoPiUSBMicroCladdingCutout(offsetx,offsety,depthy-0.25-0.1,top,zpos-0.1);
          
        translate([offsetx+41.4-3-shell-8.05/2-0.1,depthy-1.25,zpos-0.1])
        cube([8.05+12.6+6+shell*2+0.2,shell+0.1+0.1+1.25,3+0.1]);
        
        translate([offsetx+41.4-8.05/2-3-shell-0.1,shell,zpos-0.1])
        cube([shell+0.2,lego_length*5/2-30/2,1.8+0.1+kerf]);
        
        translate([offsetx+54+8.05/2+3-0.1,shell,zpos-0.1])
        cube([shell+0.2,lego_length*5/2-30/2,1.8+0.1+kerf]);
        
        translate([0.5,3,lego_block_height/3-1.6]){
            
            USBMicroCutoutNoDetail();
            USBMicroCutoutBNoDetail();
        }
        
    }
    
        
}





module LegoPiIOCutouts(){
    
    HDMIMiniCutoutNoDetail();
    USBMicroCutoutNoDetail();
    USBMicroCutoutBNoDetail();
    GPIOCutout();
    MicroSDCutout();
    CameraIOCutout();
    
}


module LegoPiTop(){
    
    // LegoPi Top Shell
    
    difference(){
        translate([0,0,lego_block_height/3])
        lego_badge_notubes(5,9,lego_block_height);
        
        translate([-65/2+lego_length*9/2-3,-30/2+lego_length*5/2-3,lego_block_height/3-1.6]){
            LegoPiIOCutouts();
        
        }
        
        LegoPiMicroSDNailCutout(-65/2+lego_length*9/2+2.5,-30/2+lego_length*5/2,-65/2+lego_length*9/2+2.5-0.1,lego_block_height/3*4+0.1,lego_block_height/3+1.6+1/20*inch+2.5-0.1,320);
        
        LegoPiHDMIMiniCladdingCutout(-65/2+lego_length*9/2,-30/2+1+lego_length*5/2,-30/2+lego_length*5/2-0.1,lego_block_height/3*4,lego_block_height/3);
        
        LegoPiUSBMicroCladdingCutout(-65/2+lego_length*9/2,-30/2+1+lego_length*5/2,-30/2+lego_length*5/2-0.1,lego_block_height/3*4,lego_block_height/3);
        
    }
    
    // MicroSD Shell and Tab
    
    difference(){
  
        LegoPiMicroSDShellCutout(-65/2+lego_length*9/2+2.5,-30/2+lego_length*5/2,-65/2+lego_length*9/2+2.5-0.1,lego_block_height/3*4,lego_block_height/3+1.6+1/20*inch+1.5,1.2,320);

        LegoPiMicroSDNailCutout(-65/2+lego_length*9/2+2.5,-30/2+lego_length*5/2,-65/2+lego_length*9/2+2.5-0.1,lego_block_height/3*4+0.1,lego_block_height/3+1.6+1/20*inch+1.5-0.1,320);
    }
    
    difference(){
        translate([-65/2+lego_length*9/2+2.5,0,0])
        LegoPiMicroSDTab(-65/2+lego_length*9/2+2.5,-30/2+lego_length*5/2,-65/2+lego_length*9/2+2.5-0.1,lego_block_height/3+1.6+1/20*inch+1.5,1.2,320);
    
        LegoPiMicroSDNailCutout(-65/2+lego_length*9/2+2.5,-30/2+lego_length*5/2,-65/2+lego_length*9/2+2.5-0.1,lego_block_height/3*4+0.1,lego_block_height/3+1.6+1/20*inch+1.5-0.1,320);
    }
    

    // HDMI Shell
    
    
    LegoPiHDMIMiniCladdingShell(-65/2+lego_length*9/2,-30/2+1+lego_length*5/2,-30/2+lego_length*5/2-0.1,lego_block_height/3*4,lego_block_height/3,1.2);
    
    
    // USB Shell
    
    
    LegoPiUSBMicroCladdingShell(-65/2+lego_length*9/2,-30/2+1+lego_length*5/2,-30/2+lego_length*5/2-0.1,lego_block_height/3*4,lego_block_height/3,1.2);
    
    
    // Support Pillars
    
    module LegoPiPillar(top,zpos){
        translate([0,0,zpos])
        difference(){
            cylinder(top-zpos,3,3,$fn=48);
            translate([0,0,-0.1])
            cylinder(top-zpos+0.2,3-1.2,3-1.2,$fn=48);
        }
    }
    
    translate([-65/2+lego_length*9/2,-30/2+lego_length*5/2,0])
    PiZeroHolePlace()
    LegoPiPillar(lego_block_height/3*4,lego_block_height/3+1.6+1/20*inch+kerf);
    
    // Knobs
    
    translate([lego_length,lego_length,0])
    xbyy_technic_knobs(8,4,lego_block_height/3*4);
    
    xbyy_technic_knobs(1,2,lego_block_height/3*4);
    
    translate([0,lego_length*4,lego_block_height/3*4])
    technic_knob();
    
    translate([lego_length*3,0,lego_block_height/3*4])
    technic_knob();
    
    translate([lego_length*8,0,lego_block_height/3*4])
    technic_knob();
    
}

module PrintLegoPiBottom(){
    scale([1/(1-shrinkage),1/(1-shrinkage),1]) 
    LegoPiBottom();
}
   
module PrintLegoPiTop(){
    scale([1/(1-shrinkage),1/(1-shrinkage),1]) 
    translate([0,0,-lego_block_height/3])
    LegoPiTop();
}

module PrintLegoPi(){
    scale([1/(1-shrinkage),1/(1-shrinkage),1]) 
    LegoPiBottom();
    
    scale([1/(1-shrinkage),1/(1-shrinkage),1]) 
    translate([0,lego_length*5+5,-lego_block_height/3])
    LegoPiTop();
}

module DemoLegoPi(){
    LegoPiBottom();

    translate([-3-65/2+lego_length*9/2,-3-30/2+lego_length*5/2,lego_block_height/3-1.6])
    PiZero();

    LegoPiTop();
}

//PrintLegoPi();
PrintLegoPiTop();
//PrintLegoPiBottom();
//DemoLegoPi();