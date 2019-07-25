inch=25.4;

kerf=0.0035*inch;

shell=1.2;

overlap=1;

box_width=10;
box_height=10;

small_fineness=24;
medium_fineness=48;
big_fineness=120;




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

module joint_femaletrimmed(points,width,depth){
    difference(){
        joint_female(points,width,depth);
        translate([-width/2-0.1,-width/2-0.1,-width-0.001])
        cube([width+0.2,width+0.2,width]);
    }
}


module boxtube(l,w,h,t){
    difference(){
        
        cube([w,h,l]);
        translate([t,t,-0.001])
        cube([w-t*2,h-t*2,l+0.002]);
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


module tab_male(width,thickness,fineness){
    
    difference(){
        union(){
            
            // tab
            translate([-thickness/2,-width/2,width/2-0.001])
            cube([thickness,width,width/2+0.1+0.002]);
            
            translate([thickness/2,0,width/2])
            rotate([0,-90,0])
            intersection(){
            difference(){
            cylinder(thickness,width/2,width/2,$fn=fineness);
                translate([0,-width/2,-0.001])
                cube([width/2+0.001,width+0.002,thickness+0.002]);
            }
            translate([0,0,+thickness/2])
            rotate([0,90,0])
            sphere(width/2,$fn=fineness);
        }
        
        
    }
    
    difference(){
        
        // cylinder cutout
        translate([-width/2-0.001,-width/2-0.001,-0.001])
        cube([width+0.002,width+0.002,width+0.1+0.003]);
        translate([0,0,-0.002])
        cylinder(width+0.1+0.005,width/2,width/2,$fn=fineness);
    }
    
}
    intersection(){
        union(){
        translate([thickness/2,0,width/2])
    rotate([0,90,0])
        joint_male(20,10,0.99);
        
        translate([-thickness/2,0,width/2])
    rotate([0,-90,0])
        joint_male(20,10,0.99);
        }
        translate([0,0,width/2])
        sphere(width/2,$fn=fineness);
    }
    
}


module tab_female(width,thickness,fineness){
    difference(){
        
        
        union(){
        difference(){
        union(){
            translate([0,0,width/2])
                translate([-width/2,-width/2,0])
                cube([width,width,width/2+0.1+0.001]);
            translate([0,width/2,width/2])
            rotate([90,0,0])
            difference(){
                cylinder(width,width/2,width/2,$fn=fineness);
                translate([-width/2-0.001,0,-0.001])
                cube([width+0.002,width/2+0.001,width+0.002]);
            }
        }
        
        translate([-width/2-0.001,-thickness/2-1,0])
        cube([width+0.002,thickness+2,width+0.1+0.003]);
    
    }
    
    translate([0,-thickness/2-1,width/2])
    rotate([-90,0,0])
    joint_femalewheeldisk(20,10,0.99);
    
    translate([0,thickness/2+1,width/2])
    rotate([90,0,0])
    joint_femalewheeldisk(20,10,0.99);
}
    
    translate([0,-thickness/2,width/2])
    rotate([90,0,0])
    joint_femaletrimmed(20,10,0.99);
    
    translate([0,thickness/2,width/2])
    rotate([-90,0,0])
    joint_femaletrimmed(20,10,0.99);
        
        difference(){
            
            // cylinder cutout
            translate([-width/2-0.001,-width/2-0.001,-0.001])
            cube([width+0.002,width+0.002,width+0.1+0.003]);
            translate([0,0,-0.002])
            cylinder(width+0.1+0.005,width/2,width/2,$fn=fineness);
        }
        
    }
    
}

module nub_male(length,width,thickness,fineness){
    
    translate([0,0,length-width/2])
    sphere(width/2,$fn=fineness);
    
    translate([0,0,width+0.1-0.001])
    cylinder(length-width*1.5-0.1+0.001,width/2,width/2,$fn=fineness);
    
    tab_male(width,thickness,fineness);
    
}


module nub_female(length,width,thickness,fineness){
    
    translate([0,0,length-width/2])
    sphere(width/2,$fn=fineness);
    
    translate([0,0,width+0.1-0.001])
    cylinder(length-0.1-width*1.5+0.001,width/2,width/2,$fn=fineness);
    
    tab_female(width,thickness,fineness);
}

module nub_female_print(length,width,thickness,fineness){
    translate([0,0,width/2])
    rotate([0,90,0])
    nub_female(length,width,thickness,fineness);
}

module nub_male_print(length,width,thickness,fineness){
    translate([0,0,width/2])
    rotate([0,90,0])
    rotate([0,0,90])
    nub_male(length,width,thickness,fineness);
}

module nubs_preview(length,width,thickness,fineness){
    
    translate([0,0,width/2])
    rotate([0,90,0])
    nub_female(length,width,thickness,fineness);
    
    translate([width,0,width/2])
    rotate([0,-90,0])
    rotate([0,0,90])
    nub_male(length,width,thickness,fineness);
    
}


module nubs_print(length,width,thickness,fineness){
    
    translate([0,0,width/2])
    rotate([0,90,0])
    nub_female(length,width,thickness,fineness);
    
    translate([0,width+5,width/2])
    rotate([0,90,0])
    rotate([0,0,90])
    nub_male(length,width,thickness,fineness);
    
}

//joint_female(20,10,0.99);
//joint_male(20,10,0.99);

//test_hinge();
//benchcube(0.99);


//nubs_preview(25.4,10,3,medium_fineness);

nubs_print(25.4,10,3,medium_fineness);

//nub_female(25.4,10,2,medium_fineness);