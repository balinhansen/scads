inch=25.4;

shell=1.2;

cell_width=3.4*inch;
cell_length=5.15*inch;
cell_depth=.12*inch;

overlap=1;

box_width=7.5;
box_height=10;

center_void=1.25*inch;

big_fineness=120;

finger_width=10;
finger_length=50;
finger_gap=2;
fingers=floor((cell_length-box_width*2-shell*2-center_void)/2/(finger_width+finger_gap))-1;

echo(fingers);

module boxtube(l,w,h,t){
    difference(){
        
        cube([w,h,l]);
        translate([t,t,-0.001])
        cube([w-t*2,h-t*2,l+0.002]);
    }
}



// box tubes

translate([shell+cell_depth,0,0]){
    boxtube(cell_width+box_height*2+shell*2,box_height,box_width,shell);

    translate([0,cell_length-box_width+shell*2,0])
    boxtube(cell_width+box_height*2+shell*2,box_height,box_width,shell);
}
// holder

translate([0,0,box_height]){
    difference(){
        // shell
        cube([shell*2+cell_depth,cell_length+shell*2,cell_width+shell*2]);
            translate([shell,shell,shell])
            //cell
        cube([cell_depth,cell_length,cell_width+shell+0.001]);
            //window
            translate([-0.001,shell+overlap,shell+overlap])
            cube([shell+0.002,cell_length-overlap*2,cell_width-overlap+shell+0.001]);
        
        // electrical access center hole
        //circle
        translate([shell+cell_depth-0.001,cell_length/2+shell,cell_width/2])
        rotate([0,90,0])
        cylinder(shell+0.002,center_void/2,center_void/2,$fn=big_fineness);
        //square
        translate([shell+cell_depth-0.001,cell_length/2-center_void/2+shell,shell+cell_width/2])
        cube([shell+0.002,center_void,cell_width/2+shell+0.001]);
        

        //finger extensions
        for (i=[0:fingers]){
            
            translate([shell+cell_depth-0.001,cell_length/2-center_void/2-shell*3-finger_width-(finger_width+finger_gap)*i,cell_width-finger_length+shell*2])
            cube([shell+0.002,finger_gap,finger_length+0.001]);
            }
        
        
        for (i=[0:fingers]){
            
            translate([shell+cell_depth-0.001,cell_length/2+center_void/2+shell*3+finger_width+(finger_width+finger_gap)*i,cell_width-finger_length+shell*2])
            cube([shell+0.002,finger_gap,finger_length+0.001]);
            }
        }
        
        // finger extensions
        
        for (i=[0:fingers-1]){
            // tabs
            translate([shell-0.001,cell_length/2-center_void/2-shell*3-finger_width-(finger_width+finger_gap)*i-finger_width,cell_width-shell+shell*2])
            cube([cell_depth+0.001,finger_width,shell]);
            // supports
            translate([cell_depth+shell*2-0.001,cell_length/2-center_void/2-shell*3-finger_width-(finger_width+finger_gap)*i-finger_width/2-shell/2,cell_width-finger_length-shell+shell*2])
            cube([shell+0.001,shell,shell]);
            }
        
        
        for (i=[0:fingers-1]){
            // tabs
            translate([shell-0.001,cell_length/2+center_void/2+shell*3+finger_width+(finger_width+finger_gap)*i+finger_gap,cell_width-shell+shell*2])
            cube([cell_depth+0.001,finger_width,shell]);
            //supports
            translate([cell_depth+shell*2-0.001,cell_length/2+center_void/2+shell*3+finger_width+(finger_width+finger_gap)*i+finger_gap+finger_width/2-shell/2,cell_width-finger_length-shell+shell*2])
            cube([shell+0.001,shell,shell]);
            
            }
        
}
