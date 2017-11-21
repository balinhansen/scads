inch=25.4;

boards=1;
standoff=0;

color=1;
spacing=1;

kerf=0.007*inch;

make_stl=0;

show_branding=0;

bevel=3;

corners=3;

low_fineness=16;
low_font_fineness=1;
low_disk_fineness=48;
stl_fineness=80;
stl_font_fineness=40;
stl_disk_fineness=320;

fineness=make_stl?stl_fineness:low_fineness;

font_fineness=make_stl?stl_font_fineness:low_font_fineness;

disk_fineness=make_stl?stl_disk_fineness:low_disk_fineness;

screw_length=10;
screw_head=2.2;

thickness=screw_length+screw_head;


shell_thickness=1.4;
nut_kerf=2.2;

board_bevel=3;
board_zpos=4;
board_thickness=1/20*inch;
support_thickness=2.2;
io_support_thickness=bevel-(shell_thickness-kerf)/2;

shell_connector=shell_thickness/2;
shell_split=board_zpos+board_thickness+0.5;

cladding_offset=3;
cladding_override=1;

if (make_stl){
    fineness=stl_fineness;
    font_fineness=stl_font_fineness;
}

module PiZero(){
    difference(){
        minkowski(){
            cylinder(board_thickness/2,board_bevel,board_bevel,$fn=fineness);
            translate([bevel+board_bevel,bevel+board_bevel,board_zpos])
                cube(size=[65-board_bevel*2,30-board_bevel*2,board_thickness/2]);
        }
        translate([bevel,bevel,0])
        ScrewHoles();
    }
}

module PiZeroKerf(){
    minkowski(){
        cylinder(board_thickness/2+kerf*2,board_bevel+kerf,board_bevel+kerf,$fn=fineness);
        translate([bevel+board_bevel,bevel+board_bevel,board_zpos])
            cube(size=[65-board_bevel*2,30-board_bevel*2,board_thickness/2]);
    }
}

// Screws

module ScrewHoles(){
    translate([3.5,3.5,0])
    Screw();
    
    translate([3.5,26.5,0])
    Screw();
    
    translate([61.5,3.5,0])
    Screw();
    
    translate([61.5,26.5,0])
    Screw();
}

module Screw(){
    translate([0,0,-0.002])
    cylinder(thickness+0.004,1.6,1.6,$fn=fineness);
}



// IO Cutouts

module GPIOCutout(){
    translate([bevel+32.5-(20*inch/10)/2,30+bevel,board_zpos+board_thickness])
    cube(size=[20*inch/10,bevel+1,2+0.001]);
}

module CameraIOCutout(){
    translate([65+bevel-65/2,bevel+(30-20)/2,board_zpos+board_thickness])
    cube(size=[bevel+1+65/2,20,1.5]);
}

module MicroSDCutout(){
    translate([bevel+14,12/2+bevel+16.9,board_zpos+board_thickness])
    rotate([0,0,180])
    cube([bevel+1+14,12,2.5]);
}

module MicroSDShellCutout(){
    h=thickness-(board_zpos+board_thickness)-2.5;
    
    translate([-22.5+bevel+1,16.9+bevel,board_zpos+board_thickness+2.5])
    translate([0,0,-0.001])
    intersection(){
        cylinder(h,22.5+shell_thickness,22.5+shell_thickness,$fn=disk_fineness);
            translate([22.5-((bevel+1+shell_thickness)/2)+shell_thickness,0,h/2])
            cube(size=[bevel+shell_thickness+1,12+shell_thickness*2,h],center=true);
    }
}

module MicroSDNailCutout(){
    h=thickness-(board_zpos+board_thickness);
    
    translate([-22.5+bevel+1,16.9+bevel,board_zpos+board_thickness])
    translate([0,0,-0.002])
    intersection(){
        cylinder(h+0.002,22.5,22.5,$fn=disk_fineness);
            translate([22.5-((bevel+1)/2)-0.001,0,h/2])
            cube(size=[bevel+1+0.001,12,h+0.004],center=true);
    }
}

module MicroSDTab(){
    
    translate([-22.5+bevel+1,16.9+bevel,board_zpos+board_thickness])
    
        translate([0,0,2.5])
        intersection(){
            cylinder(shell_thickness,22.5+shell_thickness,22.5+shell_thickness,$fn=disk_fineness);
            translate([22.5-((bevel+1+shell_thickness)/2)+shell_thickness,0,shell_thickness/2-0.001])
            cube(size=[bevel+shell_thickness+1,12+shell_thickness*2,shell_thickness+0.002],center=true);
        }
}

module HDMIPoly(){
    polygon([[1,0],[0,1],[0,3.5],[11.5,3.5],[11.5,1],[10.5,0]]);
}


module HDMICladdingPoly(){
    polygon([[0,0],[0,3.5],[11.5,3.5],[11.5,0]]);
}

module USBMicroPoly(){
    polygon([[1,0],[0,1],[0,3.0],[7.5,3.0],[7.5,1],[6.5,0]]);
}

module USBMicroCladdingPoly(){
    polygon([[0,0],[0,3.0],[7.5,3.0],[7.5,0]]);
}

module HDMIMiniCutout(){
    translate([bevel+12.4-(11.5/2),bevel,board_zpos+board_thickness])
    rotate([90,0,0])
 linear_extrude(bevel+1,convexity=10)
    offset(r=kerf)
    HDMIPoly();
}

module USBMicroCutout(){
      translate([bevel+41.4-(7.5/2),bevel,board_zpos+board_thickness])
    rotate([90,0,0])
    linear_extrude(bevel+1,convexity=10)
    offset(r=kerf)
    USBMicroPoly();
}

module USBMicroCutoutB(){
      translate([bevel+54-(7.5/2),bevel,board_zpos+board_thickness])
    rotate([90,0,0])
    linear_extrude(bevel+1,convexity=10)
    offset(r=kerf)
    USBMicroPoly();
}

module HDMIMiniCladdingCutout(){
    translate([bevel+12.4,bevel-io_support_thickness+0.001,board_zpos+board_thickness-cladding_offset])
    rotate([90,0,0])
    linear_extrude(bevel+1,convexity=10)
    offset(delta=cladding_offset)
    translate([-11.5/2,3,0])
    HDMICladdingPoly();
}

module USBMicroCladdingCutoutA(){
    translate([bevel+41.4,bevel-io_support_thickness+0.001,board_zpos+board_thickness-cladding_offset])
    rotate([90,0,0])
    linear_extrude(bevel+1,convexity=10)
    offset(delta=cladding_offset)
    translate([-7.5/2,3,0])
    USBMicroCladdingPoly();
}

module USBMicroCladdingCutoutB(){
    translate([bevel+54,bevel-io_support_thickness+0.001,board_zpos+board_thickness-cladding_offset])
    rotate([90,0,0])
    linear_extrude(bevel+1,convexity=10)
    offset(delta=cladding_offset)
    translate([-7.5/2,3,0])
    USBMicroCladdingPoly();
}



// Screw Cutouts


module ScrewHead(){
    
    // Top Mounts
    translate([0,0,0.001])
    cylinder(nut_kerf+0.002,5.9/2,5.9/2,$fn=fineness);
}

module ScrewHeads(){
    
    // Bottom Screw Stands
    translate([3.5,3.5,thickness-nut_kerf])
    ScrewHead();
    
    translate([3.5,26.5,thickness-nut_kerf])
    ScrewHead();
    
    translate([61.5,3.5,thickness-nut_kerf])
    ScrewHead();
    
    translate([61.5,26.5,thickness-nut_kerf])
    ScrewHead();
}

module ScrewHeadStand(){
    
    translate([0,0,0])
    cylinder(nut_kerf+0.001,5.9/2+shell_thickness,5.9/2+shell_thickness,$fn=fineness);
}

module ScrewHeadStands(){
    translate([3.5,3.5,thickness-nut_kerf-shell_thickness])
    ScrewHeadStand();
    
    translate([3.5,26.5,thickness-nut_kerf-shell_thickness])
    ScrewHeadStand();
    
    translate([61.5,3.5,thickness-nut_kerf-shell_thickness])
    ScrewHeadStand();
    
    translate([61.5,26.5,thickness-nut_kerf-shell_thickness])
    ScrewHeadStand();
}

module TopScrewStand(){
    translate([0,0,board_zpos+board_thickness+kerf*2])
    cylinder(thickness-board_zpos-nut_kerf-shell_thickness-board_thickness-kerf,1.6+shell_thickness,1.6+shell_thickness,$fn=fineness);
}

module TopScrewStands(){
    translate([3.5,3.5,0])
    TopScrewStand();
    
    translate([3.5,26.5,0])
    TopScrewStand();
    
    translate([61.5,3.5,0])
    TopScrewStand();
    
    translate([61.5,26.5,0])
    TopScrewStand();
}

    // Bottom Mounts
    
    
function ngon(count, radius, i = 0, result = []) = i < count
    ? ngon(count, radius, i + 1, concat(result, [[ radius*sin(360/count*i), radius*cos(360/count*i) ]]))
    : result;

module HexHole(){
    translate([0,0,-0.001])
    linear_extrude(2+0.002,convexity=10)
    polygon(ngon(6,5.9/2));

//cylinder(2,1.6,1.6,$fn=fineness);    
}

module Hexes(){
    translate([3.5,3.5,0])
    HexHole();
    
    translate([3.5,26.5,0])
    HexHole();
    
    translate([61.5,3.5,0])
    HexHole();
    
    translate([61.5,26.5,0])
    HexHole();
    
}

module HexStands(){
    translate([3.5,3.5,0])
    HexStand();
    
    translate([3.5,26.5,0])
    HexStand();
    
    translate([61.5,3.5,0])
    HexStand();
    
    translate([61.5,26.5,0])
    HexStand();
    
}

module HexStand(){
    translate([0,0,shell_thickness])
    linear_extrude(nut_kerf,convexity=10)
    polygon(ngon(6,5.9/2+shell_thickness));
}


module BottomScrewStand(){
    stand_height=(1)?19:5;
    
    stand_height=(nut_kerf+shell_thickness*2 < board_zpos)?board_zpos-nut_kerf-shell_thickness:(board_zpos-nut_kerf-shell_thickness);

    translate([0,0,-0.001])
    cylinder(stand_height+0.001,1.6+shell_thickness,1.6+shell_thickness,$fn=fineness);
}

module BottomScrewStands(){
    
    translate([3.5,3.5,0])
    BottomScrewStand();
    
    translate([3.5,26.5,0])
    BottomScrewStand();
    
    translate([61.5,3.5,0])
    BottomScrewStand();
    
    translate([61.5,26.5,0])
    BottomScrewStand();
}

module BottomStands(){
    translate([bevel,bevel,0])
    difference(){
        HexStands();
            Hexes();
            ScrewHoles();
    }

    translate([bevel,bevel,nut_kerf+shell_thickness])
    difference(){
        BottomScrewStands();
        ScrewHoles();
    }
}

    // Shell Halves

module PocketPiTop(){
    union(){
        difference(){
            TopShell();
            translate([bevel,bevel,0])
            ScrewHeads();
        
            translate([65+bevel*2,0,thickness])
            rotate([0,180,0])
            Branding();
        }
        translate([bevel,bevel,0])
        difference(){
            ScrewHeadStands();
            translate([-bevel,-bevel,0])
            CameraIOCutout();
            ScrewHeads();
            ScrewHoles();
        }
        translate([bevel,bevel,0])
        difference(){
            TopScrewStands();
            translate([-bevel,-bevel,0])
            CameraIOCutout();
            ScrewHoles();
        }
    }
}

module PocketPiBottom(){
    difference(){
        union(){
            BottomShell();
            BoardSupport();
        }
        translate([bevel,bevel,0]){
            Hexes();
            ScrewHoles();
        }
    }



    BottomStands();
}



// PocketPi Shell


module Shell(){
 minkowski(){
  sphere(bevel,$fn=fineness);
  translate([bevel,bevel,bevel])     
    cube(size=[65,30,thickness-bevel*2]);
 }   
}

module ShellConnectorCutout(){
    translate([bevel,bevel,shell_split])
    minkowski(){
        cylinder(shell_connector/2+0.001,bevel-shell_thickness/2+kerf/2,bevel-shell_thickness/2+kerf/2,$fn=fineness);
        cube(size=[65,30,shell_connector/2+0.001]);
    }
}

module ShellConnectorCutoutB(){
    translate([bevel,bevel,shell_split])
   
    difference(){
         
        translate([0,0,-0.001])
        minkowski(){
            cylinder(shell_connector/2+0.001,bevel+0.001,bevel+0.001,$fn=fineness);
            cube(size=[65,30,shell_connector/2]);
        }
        translate([0,0,-0.001]);
        minkowski(){
            cylinder(shell_connector/2+0.002,bevel-shell_thickness/2-kerf/2,bevel-shell_thickness/2-kerf/2,$fn=fineness);
            translate([0,0,-0.001])
            cube(size=[65,30,shell_connector/2+0.002]);
        }
    }
}

module BottomSlice(){
 difference(){
     Shell();
     translate([-0.001,-0.001,shell_split+shell_connector])
     cube([65+bevel*2+0.002,30+bevel*2+0.002,thickness-shell_split+0.001]);
     ShellConnectorCutout();
 }
}

module TopSlice(){
 difference(){
     Shell();
     translate([-0.001,-0.001,-0.001])
     cube([65+bevel*2+0.002,30+bevel*2+0.002,shell_split+0.001]);
     ShellConnectorCutoutB();
 }
}

module Inset(){
 minkowski(){
  sphere(bevel-shell_thickness,$fn=fineness);
     translate([bevel,bevel,bevel])
     cube(size=[65,30,thickness-bevel*2]);
 }    
}


module Cutouts(){
    HDMIMiniCutout();
    HDMIMiniCladdingCutout();
    USBMicroCutout();
    USBMicroCutoutB();
    USBMicroCladdingCutoutA();
    USBMicroCladdingCutoutB();
    GPIOCutout();
    MicroSDCutout();
    CameraIOCutout();
}

module BottomShell(){
    difference(){
        BottomSlice();
        Inset();
        
        Cutouts();
        
        Branding();
    }
}

module TopShell(){
    union(){
        difference(){
            TopSlice();
            Inset();
            MicroSDShellCutout();
            Cutouts();
        }
        difference(){
            intersection(){
                TopSlice();
                MicroSDShellCutout();
            }
            MicroSDNailCutout();
            MicroSDCutout();
        }
        difference(){
            translate([3,0,0])
        MicroSDTab();
            MicroSDNailCutout();
        }
    }
}

module BoardSupport(){
    
    difference(){
        minkowski(){
            
            cylinder((board_zpos-shell_thickness+board_thickness/2)/2,board_bevel+support_thickness/2,board_bevel+support_thickness/2,$fn=fineness);
             translate([bevel+board_bevel,bevel+board_bevel,shell_thickness])
             cube(size=[65-board_bevel*2,30-board_bevel*2,(board_zpos-shell_thickness)/2]);
        }

        minkowski(){
            cylinder((board_zpos-shell_thickness+board_thickness/2)/2,board_bevel-support_thickness/2,board_bevel-support_thickness/2,$fn=fineness);
             translate([bevel+board_bevel,bevel+board_bevel,shell_thickness-0.001])
             cube(size=[65-board_bevel*2,30-board_bevel*2,(board_zpos-shell_thickness)/2+0.002]);
        }
        
        PiZeroKerf();

    }
}

module Branding(){
    if (show_branding){
    translate([32.5+bevel,25+bevel])
    linear_extrude(0.4,convexity=10)
    rotate([0,180,0])
    text("BalinTech", font="Liberation Sans:style=Bold",size=7,halign="center",valign="center",$fn=font_fineness);
    
    translate([32.5+bevel,15+bevel])
    linear_extrude(0.4,convexity=10)
    rotate([0,180,0])
    text("PocketPi", font="Liberation Sans:style=Bold",size=11,halign="center",valign="center",$fn=font_fineness);
    
    translate([32.5+bevel,5+bevel])
    linear_extrude(0.4,convexity=10)
    rotate([0,180,0])
    text("OpenSCAD Edition", font="Liberation Sans:style=Bold",size=4,halign="center",valign="center",$fn=font_fineness);
    }
}



// Render View(s)



//PiZero();

//Shell();


module Render(){
    //color([0.5,0.5,0.5,0.7])
    n=5;
    x=5;


    if (spacing){
        translate([0,0,2*x+n])
        PocketPiTop();
    }else{
        PocketPiTop();
    }

    if (spacing){
        translate([0,0,x+n])
        PiZero();
    }else{
        PiZero();
    }

    PocketPiBottom();
}


module PrintTop(){
    translate([0,30/2+bevel,0])
    rotate([180,0,0])
    translate([0,-30/2-bevel,-thickness])
    PocketPiTop();
}

module PrintBottom(){
    PocketPiBottom();
}

module PrintBoth(){
PrintTop();
    translate([0,30+bevel*2+3,0])
    PrintBottom();
}



//union()
//
//Render();
//PrintBoth();
union(){
    PrintBottom();
    //PrintTop();
}
//color([1,1,0,0.4])
//PocketPiTop();
//PocketPiBottom();
//CameraIOCutout();