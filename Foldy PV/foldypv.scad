inch=25.4;

kerf=0.0035*inch;

wire_width=10;
wire_depth=5;

shell=1.2;

cell_width=3.4*inch;
cell_length=5.15*inch;
cell_depth=.12*inch;

overlap=1;

box_width=7.5;
box_height=10;

center_void=1.25*inch;

small_fineness=24;
medium_fineness=48;
big_fineness=120;

finger_width=10;
finger_length=50;
finger_gap=2;
fingers=floor((cell_length-box_width*2-shell*2-center_void)/2/(finger_width+finger_gap))-1;

echo(fingers);



// articulating joints


module joint_malewheel(points,width,depth){
    union(){
        difference(){
        union(){
        for (i=[0:points-1]){
            rotate([0,0,360/points*i])
            rotate([0,90-atan(depth/(width/2)),0])
            translate([1,0,0])
            cylinder(sqrt(pow(width/2,2)+pow(depth,2)),1,1,$fn=small_fineness);
            }
        }
        difference(){
            
            translate([0,0,-1-0.001])
            cube([width+2,width+2,2+depth*2+0.002],center=true);
            translate([0,0,-2.002])
            cylinder(2+depth*2+0.004,width/2,width/2,$fn=big_fineness);
            }
        }
    translate([0,0,0])
    scale([0.25,0.25,depth/(width/2)])
    sphere(width/2,$fn=medium_fineness);
    }
}

module joint_femalewheel(points,width,depth){
    union(){
        difference(){
        union(){
        for (i=[0:points-1]){
            rotate([0,0,360/points*i])
            rotate([0,90-atan((depth+kerf)/(width/2)),0])
            translate([1,0,0])
            cylinder(sqrt(pow(width/2+kerf,2)+pow(depth+kerf,2))+kerf,1+kerf,1+kerf,$fn=small_fineness);
            }
        }
        difference(){
            
            translate([0,0,-1-kerf-0.001])
            cube([width+2,width+2,2+depth*2+kerf*2+1+0.002],center=true);
            translate([0,0,-2-kerf-0.002])
            cylinder(2+depth*2+kerf*2+0.004,width/2+kerf,width/2+kerf,$fn=big_fineness);
            }
        }
    translate([0,0,0])
        scale([1,1,(depth+kerf)/(width/8)])
    scale([0.25,0.25,0.25])
    sphere(width/2+kerf*4,$fn=medium_fineness);
    }
}

module joint_femalewheeldisk(point,width,depth){
    
    rotate([180,0,0])
    translate([0,0,-1])
    difference(){
        cylinder(1.001,width/2,width/2,$fn=big_fineness);
        joint_femalewheel(point,width,depth);
    }
}

module joint_male(points,width,depth){
    translate([0,0,-0.001])
    difference(){
        translate([0,0,0.001])
        joint_malewheel(points,width,depth);
        translate([0,0,-1-depth])
        cube([width+2,width+1,2.001+depth*2],center=true);
    }
    
    //translate([0,0,-(depth+kerf+1)/2])
      //  cube([width+2,width+2,depth+kerf+1],center=true);
}

module joint_female(points,width,depth){
    difference(){
        //translate([0,0,(depth+kerf+1)/2])
        //cube([width+2,width+2,depth+kerf+1],center=true);
        joint_femalewheel(points,width,depth);
        
    }
}

module support(length,back,height){
    translate([0,shell,0])
rotate([90,0,0])
linear_extrude(shell,convexity=10)
polygon([[-0.001,length],[0,length],[height,length/5],[height,-back/5],[0,-back],[-0.001,-back]]);
}

module boxtube(l,w,h,t){
    difference(){
        
        cube([w,h,l]);
        translate([t,t,-0.001])
        cube([w-t*2,h-t*2,l+0.002]);
    }
}




module center_panel(){
// box tubes

translate([shell+cell_depth,0,0]){
    
    
    boxtube(cell_width+box_height*2+shell*2,box_height,box_width,shell);

translate([box_height/2,0,box_height/2])    
rotate([90,0,0])
joint_male(20,10,1);
    
translate([box_height/2,box_width,box_height/2])    
rotate([-90,0,0])
joint_male(20,10,1);


translate([box_height/2,0,box_height*2+cell_width+shell*2-box_height/2])    
rotate([90,0,0])
joint_male(20,10,1);
    
translate([box_height/2,box_width,box_height*2+cell_width+shell*2-box_height/2])    
rotate([-90,0,0])
joint_male(20,10,1);




    translate([0,cell_length-box_width+shell*2,0])
    boxtube(cell_width+box_height*2+shell*2,box_height,box_width,shell);
    

translate([box_height/2,cell_length-box_width+shell*2,box_height/2])    
rotate([90,0,0])
joint_male(20,10,1);
    
    
translate([box_height/2,cell_length-box_width+shell*2+box_width,box_height/2])    
rotate([-90,0,0])
joint_male(20,10,1);

translate([box_height/2,cell_length-box_width+shell*2,box_height*2+cell_width+shell*2-box_height/2])    
rotate([90,0,0])
joint_male(20,10,1);
    
    
translate([box_height/2,cell_length-box_width+shell*2+box_width,box_height*2+cell_width+shell*2-box_height/2])    
rotate([-90,0,0])
joint_male(20,10,1);
    
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
            }
        
        for (i=[-1:fingers-1]){
            // supports
            translate([cell_depth+shell*2-0.001,cell_length/2-center_void/2-shell*3-finger_width-(finger_width+finger_gap)*i-finger_width/2-shell/2,cell_width-finger_length-shell+shell*2])
            support(50/2,50/2/3,2);
            }
            
            
        for (i=[0:fingers-1]){
            // tabs
            translate([shell-0.001,cell_length/2+center_void/2+shell*3+finger_width+(finger_width+finger_gap)*i+finger_gap,cell_width-shell+shell*2])
            cube([cell_depth+0.001,finger_width,shell]);
       
            }
            
              for (i=[-1:fingers-1]){
           
            //supports
            translate([cell_depth+shell*2-0.001,cell_length/2+center_void/2+shell*3+finger_width+(finger_width+finger_gap)*i+finger_gap+finger_width/2-shell/2,cell_width-finger_length-shell+shell*2])
            support(50/2,50/2/3,2);
            }
        
}

}

/*
translate([0,0,-0.001])
cylinder(wire_depth+0.002,shell/2,shell/2,$fn=small_fineness);
translate([0,0,wire_width])
cylinder(shell,shell/2+wire_depth/2,shell/2+wire_depth/2,$fn=medium_fineness);
*/

module benchcube(depth){
    
difference(){
    cube(12.7);
    translate([6.35,6.35,0])
joint_female(20,10,depth);
    
translate([0,6.35,6.35])
rotate([0,90,0])
    joint_female(20,10,depth);
    
translate([6.35,0,6.35])
rotate([-90,0,0])
    joint_female(20,10,depth);
    
}

    translate([6.35,6.35,12.7])
    joint_male(20,10,depth);

    translate([12.7,6.35,6.35])
rotate([0,90,0])
    joint_male(20,10,depth);

    translate([6.35,12.7,6.35])
rotate([-90,0,0])
    joint_male(20,10,depth);

}

//joint_female(20,10,0.99);
//joint_male(20,10,0.99);

module bench_cross(){
    difference(){
        union(){
    benchcube(0.99);

    translate([6.35,6.35,0])
    joint_male(20,10,0.99);
            
        }
        translate([-0.001,-0.001,-0.001])
        cube(6.35);
    }
}

module test_hinge(){
    
    // part a
    translate([0,0,10])
    rotate([0,90,0])
    {
    boxtube(27.5,10,7.5,1.2);
    translate([0,7.5*2+0.0*2+1*2,0])
    boxtube(27.5,10,7.5,1.2);
    
    translate([0,7.5,27.5])
    rotate([-90,0,0])
    translate([0,0,-0.001])
    boxtube(7.5+0.0*2+1*2+0.002,10,7.5,1.2);
    
    translate([5,7.5,5])
    rotate([-90,0,0])
    joint_male(20,10,1);
    
    translate([5,7.5*2+0.0*2+1*2,5])
    rotate([90,0,0])
    joint_male(20,10,1);
    }
    
    // part b
    translate([0,7.5*2+1+0.0+5,0])
    {
        
        difference(){
    translate([0,7.5+0.0+1,10])
    rotate([0,90,0])
    boxtube(27.5,10,7.5,1.2);
    
    translate([5,7.5+0.0-1+1,5])
    rotate([90,0,180])
    joint_femalewheel(20,10,1);
    
    
    translate([5,7.5*2+0.0+1+1,5])
    rotate([-90,0,180])
    joint_femalewheel(20,10,1);
        }
            
        
    translate([5,7.5+0.0+1,5])
    rotate([90,0,0])
    joint_femalewheeldisk(20,10,1);
    
    
    translate([5,7.5*2+0.0+1,5])
    rotate([-90,0,0])
    joint_femalewheeldisk(20,10,1);
    }
}

test_hinge();

//center_panel();
//benchcube(0.99);