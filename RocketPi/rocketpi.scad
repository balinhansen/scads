use <pizerolib.scad>;

inch=25.4;
shell=0.4;
fineness=25;
large_fineness=240;
show_board=0;

board_thickness=getBoardThickness();

if (show_board){
    translate([0,0,shell+0.1])
    PiZeroBoard();
}

translate([0,0,shell-0.001])
PiZeroHolePositions()
m25_peg(board_thickness+0.1+0.001);

translate([0,0,0])
difference(){
    PiZeroBoardShape()
    cylinder(shell+board_thickness/2,3+0.25+shell,3+0.25+shell,$fn=fineness);
    
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

translate([0,15,sqrt(pow(16.5,2)-pow(15.25,2))])
rotate([0,90,0])
difference(){
    cylinder(5,33/2+shell,33/2+shell,$fn=large_fineness);
    translate([0,0,-0.001])
    cylinder(5+0.002,33/2,33/2,$fn=large_fineness);
}
