use <pizerolib.scad>;

inch=25.4;
kerf=0.0053*inch;
shell=0.4;
fineness=25;
large_fineness=240;
show_board=1;

sled_height=11;
fuselage_width=33;

sled_height_allowed=sqrt(pow(fuselage_width,2)-pow(30+shell*2+0.25*2+kerf*2,2));
echo(concat("Sled height allowed: ",sled_height_allowed));


board_thickness=getBoardThickness();

if (show_board){
    translate([0,0,1+shell+0.1])
    PiZeroBoard();
}

translate([0,0,1+shell-0.001])
PiZeroHolePositions()
m25_peg(board_thickness+0.1+0.001);

translate([0,0,shell-0.001])
PiZeroHolePositions()
cylinder(1.001,2.4,2.4,$fn=fineness);

translate([0,0,0])
difference(){
    union(){
        PiZeroBoardShape()
        cylinder(shell+board_thickness/2,3+0.25+shell,3+0.25+shell,$fn=fineness);
        translate([-5-0.25-shell,-0.25-shell,0])
        cube([65+0.25*2+shell*2+5*2,30+0.25*2+shell*2,shell+0.001]);
    }
    
    translate([0,0,shell])
    PiZeroBoardShape()
    cylinder(board_thickness/2+0.1,3+0.25,3+0.25,$fn=fineness);
    
    difference(){
        translate([0,0,-0.001])
        PiZeroBoardShape()
        cylinder(shell+0.002,3+0.25-(shell<1)?1:shell,3+0.25-(shell<1)?1:shell,$fn=fineness);
        
        PiZeroHolePositions()
        cylinder(shell+0.004,2.4+shell,2.4+shell,$fn=fineness);
        
        for (i=[0:3]){
            translate([+65/4*i,0,0])
            rotate([0,0,-atan((65/4)/30)])
            translate([-1.5,0,-0.002])
            cube(size=[3,sqrt(pow(30,2)+pow(65/4,2)),shell+0.004]);
            
            
            translate([+65/4*(i+1),0,0])
            rotate([0,0,atan((65/4)/30)])
            translate([-1.5,0,-0.002])
            cube(size=[3,sqrt(pow(30,2)+pow(65/4,2)),shell+0.004]);
        }
        translate([0,15-1.5,-0.002])
        cube(size=[65,3,shell+0.004]);
    }
}

depth=sqrt(pow(fuselage_width,2)-pow(30+shell*2+0.25*2+kerf*2,2));

translate([0,15,depth/2-kerf])
rotate([0,90,0])
    union(){
        difference(){
        cylinder(5,fuselage_width/2+shell,fuselage_width/2+shell,$fn=large_fineness);
        translate([0,0,-0.001])
        cylinder(5+0.002,fuselage_width/2,fuselage_width/2,$fn=large_fineness);
    }
    difference(){
        cylinder(5,fuselage_width/2+shell/2,fuselage_width/2+shell/2,$fn=large_fineness);
        
        translate([-depth/2,-15-0.25-shell-kerf,-0.001])
        cube(size=[depth,30+shell*2+0.25*2+kerf*2,5+0.002]);
        
        translate([-depth/2+shell*2,-fuselage_width/2,-0.001])
        cube(size=[depth-shell*4,fuselage_width,5+0.002]);
        
        translate([-fuselage_width/2,-30/2-0.25-shell-kerf+shell*2,-0.001])
        cube(size=[fuselage_width,30+0.25*2+shell*2+kerf*2-shell*4,5+0.002]);
    }
}
