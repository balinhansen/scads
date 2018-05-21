inch=25.4;
thickness=1.6;
kerf=0.0035*inch*2.5;
vkerf=2;

echo(kerf);
comfort=0.25;

grow=0; // 1/16*inch;

fineness=40;
large_fineness=160;

width= (1+9/16)*inch+grow*2; // Small Jiffy
height= (1+5/16)*inch+grow*2; // Small Jiffy
cap_height=2*inch;

corner=0.25*inch;
finger=0.5*inch;
tray_width=0.25*inch;
tray_height=0.375*inch;

adapter_length=10;
teeth=6;
teeth_length=2;

stem=1/4*inch;
arm=3;

pigtail_space=1.5*inch;
pigtail_height=120;

extension_length=6;


hole=0.25*inch;

disk=2.25*inch;

jar=80;


    tooth=(width*PI)/(teeth*2);

module cup(){
    rotate_extrude(angle=360,convexity=10,$fn=large_fineness)

    difference(){
        union(){
            square(size=[width/2-corner/2,corner+thickness]);
            
            translate([0,corner/2+thickness])
            square(size=[width/2+thickness,height-corner/2]);

            translate([width/2-corner/2,corner/2+thickness])
            circle(corner/2+thickness,$fn=fineness);
        }
        
        union(){
            translate([-0.001,thickness])
            square(size=[width/2-corner/2+0.001,corner+0.001]);
            
            translate([-0.001,corner/2+thickness+0.001])
            square(size=[width/2+0.001,height-corner/2+0.001]);

            translate([width/2-corner/2,corner/2+thickness])
            circle(corner/2,$fn=fineness);
        }
    }
}

module disk(){
    cylinder(thickness,disk/2,disk/2,$fn=large_fineness);
}

module hydrofingers(){
    for (i=[0:2]){
        rotate([0,0,360/3*i-atan(finger/(width/2))/2])
        translate([0,0,corner/2+thickness])
        rotate_extrude(angle=atan(finger/(width/2)),convexity=10,$fn=large_fineness)
        square(size=[disk/2+0.2,height-corner/2+0.001]);
    }
    
}

module fingers(){
    for (i=[0:2]){
        rotate([0,0,360/3*i-atan(finger/(width/2))/2])
        translate([0,0,corner/2+thickness])
        rotate_extrude(angle=atan(finger/(width/2)),convexity=10,$fn=large_fineness)
        square(size=[width/2+thickness+1,height-corner/2+0.001]);
    }
}

module holes(){
    
    for (i=[0:2]){
        rotate([0,0,360/3*i])
        translate([0,0,thickness+0.001])
        rotate([90,0,-90])
        linear_extrude(width/2+thickness+0.001,convexity=10)
        difference(){
            circle(hole/2,$fn=fineness);
            translate([-hole,-hole/2-0.001])
            square(size=[hole*2,hole/2+0.001]);
        }
       
    }
}

module finger_cup(){
    difference(){
        cup();
        fingers();
        holes();
    } 
}


module tray(){
        rotate_extrude(angle=360,convexity=10,$fn=large_fineness)

    difference(){
        union(){
            square(size=[width/2-corner/2+tray_width+thickness,corner+thickness]);
            
            translate([0,corner/2+thickness])
            square(size=[width/2+thickness+tray_width+thickness,tray_height-corner/2]);

            translate([width/2-corner/2+tray_width+thickness,corner/2+thickness])
            circle(corner/2+thickness,$fn=fineness);
        }
        
        union(){
            translate([-0.001,thickness])
            square(size=[width/2-corner/2+tray_width+thickness+0.001,corner+0.001]);
            
            translate([-0.001,corner/2+thickness+0.001])
            square(size=[width/2+tray_width+thickness+0.001,tray_height-corner/2+0.001]);

            translate([width/2-corner/2+tray_width+thickness,corner/2+thickness])
            circle(corner/2,$fn=fineness);
        }
    }
}



module cap(){
    rotate_extrude(angle=360,convexity=10,$fn=large_fineness)

    difference(){
        union(){
            translate([0,height+cap_height-corner/2-thickness])
            square(size=[width/2-corner/2,corner+thickness]);
            
            translate([0,thickness+corner/2+kerf])
            square(size=[width/2+thickness,height-corner/2+cap_height-corner/2-kerf]);

            translate([width/2-corner/2,height+cap_height-corner/2+thickness])
            circle(corner/2+thickness,$fn=fineness);
        }
        
        union(){
            translate([-0.001,height+cap_height-corner/2-thickness-0.001])
            square(size=[width/2-corner/2+0.001,corner+0.001]);
            
            translate([-0.001,corner/2+thickness-0.001])
            square(size=[width/2,cap_height+height-corner]);

            translate([width/2-corner/2,height+cap_height-corner/2+thickness])
            circle(corner/2,$fn=fineness);
        }
    }
}

module fingervoids(){
    for (i=[0:2]){
        rotate([0,0,360/3*i+atan((finger-kerf)/(width/2))-atan(finger/(width/2))/2])
        
        translate([0,0,corner/2+thickness-0.001])
        rotate_extrude(angle=360/3-atan((finger-kerf*2)/(width/2)),convexity=10,$fn=large_fineness)
        square(size=[width/2+thickness+1,height-corner/2+kerf+0.001]);
    }
}

module finger_cap(){
    difference(){
        cap();
        fingervoids();
    }
}

module teethvoids(){
    for (i=[0:teeth-1]){
        rotate([0,0,360/teeth*i+atan(kerf/(width/2))/2])
        
        rotate_extrude(angle=360/(teeth*2)+atan(kerf/(width/2)),convexity=10,$fn=large_fineness)
        square(size=[width/2+thickness+1,teeth_length+0.001]);
    }
}

module adapter(){
    difference(){
        rotate_extrude(angle=360,convexity=10,$fn=large_fineness)
        translate([0,corner/2+thickness+kerf,0])
        difference(){
            square(size=[width/2+thickness,height-corner/2+adapter_length]);
            translate([-0.001,-0.001,0])
            square(size=[width/2+0.001,height-corner/2+adapter_length+0.002]);
        }
        fingervoids();
        translate([0,0,thickness+height+kerf+adapter_length-teeth_length])
        teethvoids();
    }
}

module adapted_pigtail(){
    difference(){
        rotate_extrude(angle=360,convexity=10,$fn=large_fineness)
        translate([0,corner/2+thickness+kerf,0])
        difference(){
            square(size=[width/2+thickness,height-corner/2+adapter_length]);
            translate([-0.001,-0.001,0])
            square(size=[width/2+0.001,height-corner/2+adapter_length+0.002]);
        }
        fingervoids();
        
        rotate([0,0,-60-(atan((stem-kerf*2)/(width/2)))/2])
        
        translate([0,0,height-thickness+-0.001])
        rotate_extrude(angle=atan((stem-kerf*2)/(width/2)),convexity=10,$fn=large_fineness)
        square(size=[width/2+thickness+1,height-corner/2+kerf+0.001]);
        /*
        translate([0,0,thickness+height+kerf+adapter_length-teeth_length])
        teethvoids();
        */
    }
    
    // Pigtail Ring
    translate([0,0,corner/2+thickness+kerf+height-corner/2+adapter_length-arm])
    rotate_extrude(angle=180,convexity=10,$fn=fineness)
    translate([stem/2,0])
    square([thickness*2,arm]);
    
    // Pigtail Arm Back
    
    translate([thickness,stem/2,corner/2+thickness+kerf+height-corner/2+adapter_length-arm])
    rotate([0,0,90])
    cube([width/2-stem/2+0.001,thickness*2,arm]);
    
    // Pigtail Arm Right
    
    translate([stem/2,0,corner/2+thickness+kerf+height-corner/2+adapter_length-arm])
    rotate([0,0,-30])
    cube([width/2-stem/2+1+0.001,thickness*2,arm]);
    
    // Pigtail Arm Left
    
    translate([-stem/2,0,corner/2+thickness+kerf+height-corner/2+adapter_length-arm])
    rotate([0,0,210])
    translate([0,-thickness*2,0])
    cube([width/2-stem/2+1+0.001,thickness*2,arm]);
    
    
    // Pigtail
    pigheight=pigtail_height-height-adapter_length+thickness*2+corner/2-arm/2-kerf;
    pigtwist=pigheight/pigtail_space*360;
    echo(pigtwist);
    
    translate([0,0,corner/2+thickness+kerf+height-corner/2+adapter_length-arm/2])
    linear_extrude(height=pigtail_height-height-adapter_length+thickness*2+corner/2-arm/2-kerf,twist=-pigtwist,convexity=10,$fn=fineness)
    rotate([0,0,atan(thickness/(stem/2+thickness*2))])
    translate([stem/2+thickness,0])
    circle(thickness);
}


module extension(){
    difference(){
        rotate_extrude(angle=360,convexity=10,$fn=large_fineness)
        difference(){
            square(size=[width/2+thickness,extension_length]);
            translate([-0.001,-0.001,0])
            square(size=[width/2+0.001,extension_length+0.002]);
        }
        translate([0,0,-0.001])
        rotate([0,0,360/(teeth*2)])
        teethvoids();
        
        translate([0,0,extension_length-teeth_length])
        teethvoids();
    }
}

function parabola(width, height, x, y, fine, i = 0, result = []) = i <= fine
    ? parabola(width, height, x, y, fine, i + 1, concat(result, [[ width/fine*i, pow(2/fine*i,2)/4*height]]))
    : result;


function parabola_reverse(width, height, x, y, fine, i, result = []) = i >= 0
    ? parabola_reverse(width, height, x, y, fine, i - 1, concat(result, [[ x+width/fine*i, y+pow(2/fine*i,2)/4*height]]))
    : result;

function parabola_reverse_shell(width, height, x, y, shell, fine, i, result = []) = i >= 0
    ? parabola_reverse_shell(width, height, x, y, shell, fine, i - 1, concat(result, [[ x+(width+shell)/fine*i, y+pow(2/fine*i,2)/4*height-cos(atan(2*(i/fine)*(height/width)))*shell]]))
    : result;


module paraboloid(paraboloid_fineness,rotation_fineness){
    rotate_extrude(angle=360,convexity=10,$fn=rotation_fineness)
polygon(concat(parabola(width/2,width/2,0,0,paraboloid_fineness),[[width/2,width/2+2]],[[width/2+thickness,width/2+2]],parabola_reverse_shell(width/2,width/2,0,0,thickness,paraboloid_fineness,paraboloid_fineness)));

}

module reflector(){
    difference(){
        translate([0,0,width/2+2+0.001])
        rotate([0,180,0])
        paraboloid(fineness,large_fineness);
        
        rotate([0,0,360/(teeth*2)])
        teethvoids();
    }
}

module hydroponic(){
    difference(){
        union(){
            translate([0,0,height])
            difference(){
                disk();
                translate([0,0,-0.001])
                cylinder(thickness+0.002,width/2,width/2,$fn=large_fineness);
            }
            cup();
        }
        for (i=[0:2]){
            rotate([0,0,i*360/3]){
                rotate([0,0,60]){
                    
                    translate([2*hole*sqrt(3)/2,-0.001]){
                        rotate([0,0,-10]){
                            cylinder(height+thickness+0.002,hole/2,hole/2,$fn=fineness);
                                translate([0,-hole/2])
                            rotate_extrude(angle=20,convexity=10,$fn=large_fineness)
                            square([disk/2+0.2,thickness+height+0.002]);
                            
                                translate([cos(90+20)*hole/2,sin(90+20)*hole/2])
                            rotate_extrude(angle=20,convexity=10,$fn=large_fineness)
                            square([disk/2+0.2,thickness+height+0.002]);
                            
                            rotate();
                            translate([0,-hole/2])
                            cube(size=[disk,hole,thickness+height+0.002]);
                            
                        }
                    }
                    
                    translate([hole*2,2*hole*sqrt(3)/2,0-0.001]){
                        rotate([0,0,30]){
                            cylinder(height+thickness+0.002,hole/2,hole/2,$fn=fineness);
                                translate([0,-hole/2])
                            rotate_extrude(angle=20,convexity=10,$fn=large_fineness)
                            square([disk/2+0.2,thickness+height+0.002]);
                            
                                translate([cos(90+20)*hole/2,sin(90+20)*hole/2])
                            rotate_extrude(angle=20,convexity=10,$fn=large_fineness)
                            square([disk/2+0.2,thickness+height+0.002]);
                            
                            rotate();
                            translate([0,-hole/2])
                            cube(size=[disk,hole,thickness+height+0.002]);
                            
                        }
                    }
                    
                    translate([hole*2,-2*hole*sqrt(3)/2,0-0.001]){
                        rotate([0,0,-50]){
                            cylinder(height+thickness+0.002,hole/2,hole/2,$fn=fineness);
                                translate([0,-hole/2])
                            rotate_extrude(angle=20,convexity=10,$fn=large_fineness)
                            square([disk/2+0.2,thickness+height+0.002]);
                            
                                translate([cos(90+20)*hole/2,sin(90+20)*hole/2])
                            rotate_extrude(angle=20,convexity=10,$fn=large_fineness)
                            square([disk/2+0.2,thickness+height+0.002]);
                            
                            rotate();
                            translate([0,-hole/2])
                            cube(size=[disk,hole,thickness+height+0.002]);
                            
                        }
                    }
                    
                }
            }
        }
        hydrofingers();
    }
}

module hydrolid(){
    difference(){
        cylinder(thickness,jar/2,jar/2,$fn=large_fineness);
        translate([0,0,-0.001]){
            cylinder(thickness+0.002,width/2+thickness+comfort,width/2+thickness+comfort,$fn=large_fineness);
                translate([0,-width/2-thickness-comfort,0])
            cube(size=[jar/2+0.001,width+thickness*2+comfort*2,thickness+0.002]);
        }
    }
}

module hydrolidsert(){
    union(){
        rotate([0,0,180])
        hydrolid();
        intersection(){
            difference(){
                cylinder(thickness+vkerf+0.001,jar/2,jar/2,$fn=large_fineness);
                translate([0,0,-0.001]){
                    cylinder(thickness+vkerf+0.003,width/2+thickness+comfort,width/2+thickness+comfort,$fn=large_fineness);
                }
            }
            
            translate([0,-width/2-thickness-comfort+kerf,thickness-0.001])
            cube(size=[jar/2+0.001,width+thickness*2+comfort*2-kerf*2,thickness+vkerf+0.001]);
        }
    }
}


module preview(){
    finger_tray_cup();
    finger_cap();
}

module finger_tray_cup(){
    finger_cup();
    tray();
}

module print_finger_cap(){
    translate([0,0,height+cap_height+thickness*2])
    rotate([0,180,0])
    finger_cap();
    
}

module print_reflector(){
translate([0,0,thickness+height+kerf+adapter_length+kerf-teeth_length+extension_length-teeth_length+kerf])
    rotate([0,180,0])
    difference(){
        reflector();
        cylinder(width,5.75,5.75,$fn=fineness);
    }
}

//print_reflector();

hydroponic();
translate([0,0,height-thickness-0.1]){
hydrolid();
}
translate([0,0,height-thickness-vkerf-0.1]){
hydrolidsert();
}

//preview();


//translate([0,0,-corner/2-thickness-kerf])
//adapted_pigtail();

/*
adapter();

translate([0,0,thickness+height+kerf+adapter_length+kerf-teeth_length])
extension();
*/



//polygon(concat(parabola(10,10,0,0,10),parabola_reverse(10,10,0,-1,10,10)));

//print_finger_cap();