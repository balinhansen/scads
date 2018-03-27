inch=25.4;
thickness=1.6;
kerf=0.0035*inch*2.5;
echo(kerf);


fineness=40;
large_fineness=160;

width=(1+9/16)*inch;
height=(1+5/16)*inch;
cap_height=2*inch;

corner=0.25*inch;
finger=0.5*inch;
tray_width=0.25*inch;
tray_height=0.5*inch;

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



module finger_cup(){
    difference(){
        
        cup();

        for (i=[0:2]){
            rotate([0,0,360/3*i])
            
            translate([0,0,corner/2+thickness])
            rotate_extrude(angle=atan(finger/(width/2)),convexity=10,$fn=large_fineness)
            square(size=[width/2+thickness+1,height-corner/2+0.001]);
            //cube(size=[width/2+thickness,finger,height-corner/2]);
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

module finger_cap(){
    difference(){
        cap();
        
        for (i=[0:2]){
            rotate([0,0,360/3*i+atan((finger-kerf)/(width/2))])
            
            translate([0,0,corner/2+thickness-0.001])
            rotate_extrude(angle=360/3-atan((finger-kerf*2)/(width/2)),convexity=10,$fn=large_fineness)
            square(size=[width/2+thickness+1,height-corner/2+kerf+0.001]);
            //cube(size=[width/2+thickness,finger,height-corner/2]);
        }
        
    }
}

module tray(){
        rotate_extrude(angle=360,convexity=10,$fn=large_fineness)

    difference(){
        union(){
            square(size=[width/2-corner/2+tray_width,corner+thickness]);
            
            translate([0,corner/2+thickness])
            square(size=[width/2+thickness+tray_width,tray_height-corner/2]);

            translate([width/2-corner/2+tray_width,corner/2+thickness])
            circle(corner/2+thickness,$fn=fineness);
        }
        
        union(){
            translate([-0.001,thickness])
            square(size=[width/2-corner/2+tray_width+0.001,corner+0.001]);
            
            translate([-0.001,corner/2+thickness+0.001])
            square(size=[width/2+tray_width+0.001,tray_height-corner/2+0.001]);

            translate([width/2-corner/2+tray_width,corner/2+thickness])
            circle(corner/2,$fn=fineness);
        }
    }
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

//finger_tray_cup();
print_finger_cap();