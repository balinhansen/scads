inch=25.4;

kerf=0.0035*inch;

shell=1.2;

small_fineness=24;
medium_fineness=48;
big_fineness=120;

gums=0.0; // default: 0.5 // no teeth: 0.88



function joint_malewheel_sharppoints(count, radius, depth, i = 0, result = []) =  let(vkerf=kerf/sin(90-atan(radius*2*PI/(count*2)/(depth)))) let (backing=-0.2) i < count*2
    ? joint_malewheel_sharppoints(count, radius, depth,i + 2, concat(result, 
   
    // 1
    [[0,0,0]],
    [[ radius*sin(360/(count*2)*i), radius*cos(360/(count*2)*i),gums]],
    [[ radius*sin(360/(count*2)*(i+1)),
    radius*cos(360/(count*2)*(i+1)),
    depth-vkerf]],
    
    
    // 2
    [[0,0,0]],
    [[ radius*sin(360/(count*2)*(i+1)),
    radius*cos(360/(count*2)*(i+1)),
    depth-vkerf]],
    [[ radius*sin(360/(count*2)*(i+2)), radius*cos(360/(count*2)*(i+2)),gums]],
  
 
    // 3
    [[0,0,backing]],
    [[ radius*sin(360/(count*2)*(i+2)), radius*cos(360/(count*2)*(i+2)),backing]],
    [[ radius*sin(360/(count*2)*(i+1)),
    radius*cos(360/(count*2)*(i+1)),
    backing]],
     
    // 4
    [[0,0,backing]],
    [[ radius*sin(360/(count*2)*(i+1)),
    radius*cos(360/(count*2)*(i+1)),
    backing]],
    [[ radius*sin(360/(count*2)*i), radius*cos(360/(count*2)*i),backing]],
    

    // 5
    [[ radius*sin(360/(count*2)*i), radius*cos(360/(count*2)*i),gums]],
    [[ radius*sin(360/(count*2)*(i+1)),
    radius*cos(360/(count*2)*(i+1)),gums]],
    [[ radius*sin(360/(count*2)*(i+1)),
    radius*cos(360/(count*2)*(i+1)),depth-vkerf]],
    
    
    // 6
    [[ radius*sin(360/(count*2)*(i+1)),
    radius*cos(360/(count*2)*(i+1)),gums]],
    [[ radius*sin(360/(count*2)*(i+2)), radius*cos(360/(count*2)*(i+2)),gums]],
    [[ radius*sin(360/(count*2)*(i+1)),
    radius*cos(360/(count*2)*(i+1)),depth-vkerf]],
    
    
    
    // 7
    [[ radius*sin(360/(count*2)*i), radius*cos(360/(count*2)*i),backing]],   
    [[ radius*sin(360/(count*2)*(i+1)),
    radius*cos(360/(count*2)*(i+1)),backing]],
    [[ radius*sin(360/(count*2)*(i+1)),
    radius*cos(360/(count*2)*(i+1)),gums]],  

    // 8
    [[ radius*sin(360/(count*2)*i), radius*cos(360/(count*2)*i),backing]],  
    [[ radius*sin(360/(count*2)*(i+1)),
    radius*cos(360/(count*2)*(i+1)),gums]],
    [[ radius*sin(360/(count*2)*i), radius*cos(360/(count*2)*i),gums]],
    
    
    // 9
    [[ radius*sin(360/(count*2)*(i+1)),
    radius*cos(360/(count*2)*(i+1)),gums]],
    [[ radius*sin(360/(count*2)*(i+2)), radius*cos(360/(count*2)*(i+2)),backing]],
    [[ radius*sin(360/(count*2)*(i+2)), radius*cos(360/(count*2)*(i+2)),gums]],
    
    // 10
    [[ radius*sin(360/(count*2)*(i+1)),
    radius*cos(360/(count*2)*(i+1)),backing]],
    [[ radius*sin(360/(count*2)*(i+2)), radius*cos(360/(count*2)*(i+2)),backing]],
    [[ radius*sin(360/(count*2)*(i+1)), radius*cos(360/(count*2)*(i+1)),gums]]
    
    
    ))
    : result;


function joint_malewheel_sharppolys(count, i = 0, result = []) = i < count*10
    ? joint_malewheel_sharppolys(count,i + 1, concat(result, 
    
    [[i*3,i*3+1,i*3+2]]
    
    ))
    : result;
    

function joint_femalewheel_sharppoints(count, radius, depth, i = 0, result = []) = let(vkerf=kerf/sin(90-atan(radius*2*PI/(count*2)/(depth)))) let(backing=0.002) i < count*2
    ? joint_femalewheel_sharppoints(count, radius, depth,i + 2, concat(result, 
    
    
    // 1
    
    [[0,0,vkerf]],
    [[ radius*sin(360/(count*2)*(i+1)),
    radius*cos(360/(count*2)*(i+1)),
    depth]],
    [[ radius*sin(360/(count*2)*i), radius*cos(360/(count*2)*i),vkerf+gums]],
    
    
    // 2
    [[0,0,vkerf]],
    [[ radius*sin(360/(count*2)*(i+2)), radius*cos(360/(count*2)*(i+2)),vkerf+gums]],
    [[ radius*sin(360/(count*2)*(i+1)),
    radius*cos(360/(count*2)*(i+1)),
    depth]],
    
    
     
    // 3
    [[0,0,depth+backing]],
    [[ radius*sin(360/(count*2)*(i+1)),
    radius*cos(360/(count*2)*(i+1)),
    depth+backing]],
    [[ radius*sin(360/(count*2)*(i+2)), radius*cos(360/(count*2)*(i+2)),depth+backing]],
     
     
    // 4
    [[0,0,depth+backing]],
    [[ radius*sin(360/(count*2)*i), radius*cos(360/(count*2)*i),depth+backing]],
    [[ radius*sin(360/(count*2)*(i+1)),
    radius*cos(360/(count*2)*(i+1)),
    depth+backing]],
    
    
    // 5
    [[ radius*sin(360/(count*2)*i), radius*cos(360/(count*2)*i),vkerf+gums]],
    [[ radius*sin(360/(count*2)*(i+1)),
    radius*cos(360/(count*2)*(i+1)),depth]],
    [[ radius*sin(360/(count*2)*i), radius*cos(360/(count*2)*i),depth]],
    
    
    // 6
    [[ radius*sin(360/(count*2)*(i+2)),
    radius*cos(360/(count*2)*(i+2)),vkerf+gums]],
    [[ radius*sin(360/(count*2)*(i+2)), radius*cos(360/(count*2)*(i+2)),depth]],
    [[ radius*sin(360/(count*2)*(i+1)),
    radius*cos(360/(count*2)*(i+1)),depth]],
    
    
    // 7
    [[ radius*sin(360/(count*2)*i), radius*cos(360/(count*2)*i),depth+backing]],
    [[ radius*sin(360/(count*2)*(i+1)),
    radius*cos(360/(count*2)*(i+1)),depth]],  
    [[ radius*sin(360/(count*2)*(i+1)),
    radius*cos(360/(count*2)*(i+1)),depth+backing]],

    // 8
    [[ radius*sin(360/(count*2)*i), radius*cos(360/(count*2)*i),depth+backing]],
    [[ radius*sin(360/(count*2)*i), radius*cos(360/(count*2)*i),depth]],
    [[ radius*sin(360/(count*2)*(i+1)),
    radius*cos(360/(count*2)*(i+1)),depth]],
    
    
    
    // 9
    [[ radius*sin(360/(count*2)*(i+1)),
    radius*cos(360/(count*2)*(i+1)),depth]],
    [[ radius*sin(360/(count*2)*(i+2)), radius*cos(360/(count*2)*(i+2)),depth]],
    [[ radius*sin(360/(count*2)*(i+2)), radius*cos(360/(count*2)*(i+2)),depth+backing]],
    
    // 10
    [[ radius*sin(360/(count*2)*(i+1)),
    radius*cos(360/(count*2)*(i+1)),depth+backing]],
    [[ radius*sin(360/(count*2)*(i+1)), radius*cos(360/(count*2)*(i+1)),depth]],
    [[ radius*sin(360/(count*2)*(i+2)), radius*cos(360/(count*2)*(i+2)),depth+backing]]
    
    ))
    : result;
   
function joint_femalewheel_sharppolys(count, i = 0, result = []) = i < count*10
    ? joint_malewheel_sharppolys(count,i + 1, concat(result, 
    
    [[i*3,i*3+1,i*3+2]]
    
    ))
    : result;



module joint_malewheel_sharp(points,width,depth){
    vkerf=kerf/sin(90-atan(10*PI/(points*2)/depth));
    
    polyhedron(points=joint_malewheel_sharppoints(points,width/2,depth), faces=joint_malewheel_sharppolys(points),convexity=10);
    
    difference(){
        scale([1.5,1.5,1])
        sphere(depth-kerf*2/1.5,$fn=medium_fineness);
        translate([-(depth+kerf*2)*1.5-0.001,-(depth+kerf*2)*1.5-0.001,-depth+kerf-0.001])
        scale([1.5,1.5,1])
        cube([(depth-kerf)*2*1.5+0.002,(depth-kerf)*2*1.5+0.002,depth-kerf+0.001]);
    }
}

module joint_femalewheel_sharp(points,width,depth){
    rotate([0,180,0])
    translate([0,0,-depth])
    difference(){
        
    polyhedron(points=joint_femalewheel_sharppoints(points,width/2,depth), faces=joint_femalewheel_sharppolys(points),convexity=10);
        scale([1.5,1.5,1])
        sphere(depth,$fn=medium_fineness);
       
    }
}




module joint_malewheel_cone(points,width,depth){
    vkerf=kerf/sin(90-atan(10*PI/(points*2)/depth));
    
    polyhedron(points=joint_malewheel_sharppoints(points,width/2,depth), faces=joint_malewheel_sharppolys(points),convexity=10);
    
    difference(){
        difference(){
        cylinder(depth-kerf,depth*3-kerf,depth*2-kerf,$fn=medium_fineness);
            difference(){
            cylinder(depth-kerf+0.001,depth-kerf,depth*2-kerf,$fn=medium_fineness);
                cylinder(depth-kerf+0.002,depth-kerf,0,$fn=medium_fineness);
            }
        }
        translate([-(depth+kerf*2)*1.5-0.001,-(depth+kerf*2)*1.5-0.001,-depth+kerf-0.001])
        scale([1.5,1.5,1])
        cube([(depth-kerf)*2*1.5+0.002,(depth-kerf)*2*1.5+0.002,depth-kerf+0.001]);
    }
}

module joint_femalewheel_cone(points,width,depth){
    rotate([0,180,0])
    translate([0,0,-depth])
    difference(){
        
    polyhedron(points=joint_femalewheel_sharppoints(points,width/2,depth), faces=joint_femalewheel_sharppolys(points),convexity=10);
        difference(){
        cylinder(depth,depth*3,depth*2,$fn=medium_fineness);
            difference(){
            cylinder(depth+0.001,depth-kerf,depth*2-kerf,$fn=medium_fineness);
            cylinder(depth+0.002,depth,kerf,$fn=medium_fineness);
            }
        }
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


module tab_male_sharp(width,thickness,fineness){
    
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
        joint_malewheel_sharp(20,10,0.99);
        
        translate([-thickness/2,0,width/2])
    rotate([0,-90,0])
        joint_malewheel_sharp(20,10,0.99);
        }
        translate([0,0,width/2])
        sphere(width/2,$fn=fineness);
    }
    
}



module tab_female_sharp(width,thickness,fineness){
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
               translate([0,0,width/2])
                sphere(width/2,$fn=fineness); //cylinder(width,width/2,width/2,$fn=fineness);
                translate([-width/2-0.001,0,-0.001])
                cube([width+0.002,width/2+0.001,width+0.002]);
            }
        }
        
        translate([-width/2-0.001,-thickness/2-1,0])
        cube([width+0.002,thickness+2,width+0.1+0.003]);
    
    }
    
    intersection(){
        union(){
    translate([0,-thickness/2-1,width/2])
    rotate([-90,0,0])
    joint_femalewheel_sharp(20,10,0.99);
    
    translate([0,thickness/2+1,width/2])
    rotate([90,0,0])
    joint_femalewheel_sharp(20,10,0.99);
        }
        translate([0,0,width/2])
        union(){
            sphere(width/2,$fn=fineness);
            cylinder(width/2+0.1,width/2,width/2,$fn=fineness);
        }
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
    
}


module tab_male_cone(width,thickness,fineness){
    
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
        joint_malewheel_cone(20,10,0.99);
        
        translate([-thickness/2,0,width/2])
    rotate([0,-90,0])
        joint_malewheel_cone(20,10,0.99);
        }
        translate([0,0,width/2])
        sphere(width/2,$fn=fineness);
    }
    
}



module tab_female_cone(width,thickness,fineness){
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
               translate([0,0,width/2])
                sphere(width/2,$fn=fineness); //cylinder(width,width/2,width/2,$fn=fineness);
                translate([-width/2-0.001,0,-0.001])
                cube([width+0.002,width/2+0.001,width+0.002]);
            }
        }
        
        translate([-width/2-0.001,-thickness/2-1,0])
        cube([width+0.002,thickness+2,width+0.1+0.003]);
    
    }
    
    intersection(){
        union(){
    translate([0,-thickness/2-1,width/2])
    rotate([-90,0,0])
    joint_femalewheel_cone(20,10,0.99);
    
    translate([0,thickness/2+1,width/2])
    rotate([90,0,0])
    joint_femalewheel_cone(20,10,0.99);
        }
        translate([0,0,width/2])
        union(){
            sphere(width/2,$fn=fineness);
            cylinder(width/2+0.1,width/2,width/2,$fn=fineness);
        }
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
    
}


module nub_sharp(length,width,thickness,fineness,gender){
    
    translate([0,0,length-width/2])
    sphere(width/2,$fn=fineness);
    
    translate([0,0,width+0.1-0.001])
    cylinder(length-0.1-width*1.5+0.001,width/2,width/2,$fn=fineness);
    
    if (gender){
        tab_female_sharp(width,thickness,fineness);
    }else{
        rotate([0,0,90])
        tab_male_sharp(width,thickness,fineness);
    }
}




module nub_cone(length,width,thickness,fineness,gender){
    
    translate([0,0,length-width/2])
    sphere(width/2,$fn=fineness);
    
    translate([0,0,width+0.1-0.001])
    cylinder(length-0.1-width*1.5+0.001,width/2,width/2,$fn=fineness);
    
    if (gender){
        tab_female_cone(width,thickness,fineness);
    }else{
        rotate([0,0,90])
        tab_male_cone(width,thickness,fineness);
    }
}



module link_sharp_described(length,width,thickness,fineness,gender,perp){
    
    
    rotate([0,0,perp[0]?(gender[0]?90:0):(gender[0]?0:90)])
    if (gender[0]){
        tab_female_sharp(width,thickness,fineness);
    }else{
        tab_male_sharp(width,thickness,fineness);
    }
    
    translate([0,0,width+0.1])
    cylinder(length-width*2-0.1*2,width/2,width/2,$fn=fineness);
    
    translate([0,0,length])
    rotate([0,180,0])
    
    rotate([0,0,perp[1]?(gender[1]?90:0):(gender[1]?0:90)])
    if (gender[1]){
        tab_female_sharp(width,thickness,fineness);
    }else{
        tab_male_sharp(width,thickness,fineness);
    }
}



module el_described(length,width,thickness,fineness,gender,perp){
    
    translate([0,0,length-width/2])
    sphere(width/2,$fn=fineness);
    
    translate([0,0,width+0.1-0.001])
    cylinder(length-0.1-width*1.5+0.001,width/2,width/2,$fn=fineness);
    
    rotate([0,0,perp[0]?(gender[0]?90:0):(gender[0]?0:90)])
    if (gender[0]){
        tab_female_sharp(width,thickness,fineness);
    }else{
        tab_male_sharp(width,thickness,fineness);
    }
    
    translate([0,0,length-width/2])
    rotate([0,90,0]){
        cylinder(length-0.1-width*1.5+0.001,width/2,width/2,$fn=fineness);
    
        translate([0,0,length-width/2])
        rotate([0,180,0])
        rotate([0,0,perp[1]?(gender[1]?90:0):(gender[1]?0:90)])
        if (gender[1]){
            tab_female_sharp(width,thickness,fineness);
        }else{
            tab_male_sharp(width,thickness,fineness);
        }
    }
}

module tee_described(length,width,thickness,fineness,gender,perp){
    
    rotate([0,0,perp[0]?(gender[0]?90:0):(gender[0]?0:90)])
    if (gender[0]){
        tab_female_sharp(width,thickness,fineness);
    }else{
        tab_male_sharp(width,thickness,fineness);
    }
    
    translate([0,0,width+0.1])
    cylinder(length/2-width-0.1,width/2,width/2,$fn=fineness);
    
    translate([0,0,length/2])
    rotate([0,90,0])
    translate([0,0,-length/2]){
           
        rotate([0,0,perp[1]?(gender[1]?90:0):(gender[1]?0:90)])
        if (gender[1]){
            tab_female_sharp(width,thickness,fineness);
        }else{
            tab_male_sharp(width,thickness,fineness);
        }
        
        translate([0,0,width+0.1])
        cylinder(length-width*2-0.1*2,width/2,width/2,$fn=fineness);
        
        translate([0,0,length])
        rotate([0,180,0])
            
        rotate([0,0,perp[2]?(gender[2]?90:0):(gender[2]?0:90)])
        if (gender[2]){
            tab_female_sharp(width,thickness,fineness);
        }else{
            tab_male_sharp(width,thickness,fineness);
        }
    
    }
}




module cross_described(length,width,thickness,fineness,gender,perp){
    
    rotate([0,0,perp[0]?(gender[0]?90:0):(gender[0]?0:90)])
    if (gender[0]){
        tab_female_sharp(width,thickness,fineness);
    }else{
        tab_male_sharp(width,thickness,fineness);
    }
    
    translate([0,0,width+0.1])
    cylinder(length-width*2-0.1*2,width/2,width/2,$fn=fineness);
    
    translate([0,0,length/2])
    rotate([0,90,0])
    translate([0,0,-length/2]){
           
        rotate([0,0,perp[1]?(gender[1]?90:0):(gender[1]?0:90)])
        if (gender[1]){
            tab_female_sharp(width,thickness,fineness);
        }else{
            tab_male_sharp(width,thickness,fineness);
        }
        
        translate([0,0,width+0.1])
        cylinder(length-width*2-0.1*2,width/2,width/2,$fn=fineness);
        
        translate([0,0,length])
        rotate([0,180,0])
            
        rotate([0,0,perp[3]?(gender[3]?90:0):(gender[3]?0:90)])
        if (gender[3]){
            tab_female_sharp(width,thickness,fineness);
        }else{
            tab_male_sharp(width,thickness,fineness);
        }
    
    }
    
    translate([0,0,length])
    rotate([0,180,0])
    rotate([0,0,perp[2]?(gender[2]?90:0):(gender[2]?0:90)])
    if (gender[2]){
        tab_female_sharp(width,thickness,fineness);
    }else{
        tab_male_sharp(width,thickness,fineness);
    }
}


module palm(digits,length,finger,width,thickness,fineness){
    translate([width/2,0,0]){

        rotate([0,90,0]){
            
            cylinder(length-width,width/2,width/2,$fn=fineness);
            translate([0,0,length-width])
            sphere(width/2,$fn=fineness);
        }
        
        for (i=[0:digits-1]){
            translate([((length-width)/(digits-1))*i,0,0]){
            cylinder(finger-width*1.5-0.1,width/2,width/2,$fn=fineness);
                translate([0,0,finger-width/2])
                rotate([0,0,90])
                rotate([0,180,0])
                tab_female_sharp(width,thickness,fineness);
            }
        }
        
        translate([
        cos(atan(((length-width)/(digits-1))/((length-width)/(digits-1))*digits))*((length-width)/(digits-1))*ceil((digits-2)/2),0,sin(atan(((length-width)/(digits-1))/((length-width)/(digits-1))*digits))*((length-width)/(digits-1))*ceil((digits-2)/2)])
        translate([((length-width)/(digits-1))*(digits-2),0,0])
        translate([0,0,-((length-width)/(digits-1))*digits])
        
        rotate([180,0,0])
        rotate([0,atan(((length-width)/(digits-1))/((length-width)/(digits-1))*digits),0])
        for (i=[0:1]){
        translate([((length-width)/(digits-1))*i,0,0]){
            cylinder(finger-width*1.5-0.1,width/2,width/2,$fn=fineness);
                translate([0,0,finger-width/2])
                rotate([0,0,90])
                rotate([0,180,0])
                tab_female_sharp(width,thickness,fineness);
            }
        }
        
        
    
        translate([((length-width)/(digits-1))*floor((digits-2)/2),0,0])
        translate([0,0,-((length-width)/(digits-1))*digits])
        
        rotate([180,0,0])
        
        for (i=[0:1]){
        translate([((length-width)/(digits-1))*i,0,0]){
            cylinder(finger-width*1.5-0.1,width/2,width/2,$fn=fineness);
                translate([0,0,finger-width/2])
                rotate([0,0,90])
                rotate([0,180,0])
                tab_female_sharp(width,thickness,fineness);
            }
        }
        
        
        translate([0,0,-(length-width)/(digits-1)*digits])
        cylinder((length-width)/(digits-1)*digits,width/2,width/2,$fn=fineness);
        
        translate([0,0,-(length-width)/(digits-1)*digits])
        sphere(width/2,$fn=fineness);
                   
        translate([0,0,-(length-width)/(digits-1)*digits])
        rotate([0,90,0])
        cylinder((length-width)/(digits-1)*(digits-2),width/2,width/2,$fn=fineness);
        
        translate([(length-width)/(digits-1)*(digits-2),0,-(length-width)/(digits-1)*digits])
        sphere(width/2,$fn=fineness);
        
        translate([(length-width)/(digits-1)*(digits-2),0,-(length-width)/(digits-1)*digits])
        rotate([0,atan(((length-width)/(digits-1))/((length-width)/(digits-1)*digits)),0])
        cylinder(sqrt(pow((length-width)/(digits-1),2)+pow(-(length-width)/(digits-1)*digits,2)),width/2,width/2,$fn=fineness);
        
    }
}

module nubs_sharp_preview(length,width,thickness,fineness){
    
    translate([0,0,width/2])
    rotate([0,90,0])
    nub_sharp(length,width,thickness,fineness,1);
    
    translate([width,0,width/2])
    rotate([0,-90,0])
    nub_sharp(length,width,thickness,fineness,0);
    
}


module nubs_cone_preview(length,width,thickness,fineness){
    
    translate([0,0,width/2])
    rotate([0,90,0])
    nub_cone(length,width,thickness,fineness,1);
    
    translate([width,0,width/2])
    rotate([0,-90,0])
    nub_cone(length,width,thickness,fineness,0);
    
}



module nubs_sharp_print(length,width,thickness,fineness){
    
    translate([0,0,width/2])
    rotate([0,90,0])
    nub_sharp(length,width,thickness,fineness,1);
    
    translate([0,width+5,width/2])
    rotate([0,90,0])
    nub_sharp(length,width,thickness,fineness,0);
    
}




module nubs_cone_print(length,width,thickness,fineness){
    
    translate([0,0,width/2])
    rotate([0,90,0])
    nub_cone(length,width,thickness,fineness,1);
    
    translate([0,width+5,width/2])
    rotate([0,90,0])
    nub_cone(length,width,thickness,fineness,0);
    
}


module print_linksharp(){
translate([0,0,5])
rotate([0,90,0]){
link_sharp_described(25.4,10,3,medium_fineness,[1,0],[0,1]);

translate([0,15,0])
link_sharp_described(25.4,10,3,medium_fineness,[1,0],[0,0]);
}
}



// VIEWS



//tab_female_sharp(10,8/3,medium_fineness);

//tab_male_sharp(10,8/3,medium_fineness);

//nubs_sharp_preview(25.4,10,3,medium_fineness);
//nubs_sharp_print(25.4,10,3,medium_fineness);
nubs_cone_print(25.4,10,3,medium_fineness);

/*
difference(){    
nubs_cone_preview(25.4,10,3,medium_fineness);
cube([5,10,10]);
}
*/

//joint_malewheel_sharp(20,10,0.99);

//joint_femalewheel_sharp(20,10,0.99);


//cross_described(35.4,10,8/3,medium_fineness,[0,0,1,1],[0,1,0,1]);

//tee_described(35.4,10,3,medium_fineness,[1,0,0],[1,0,0]);

//el_described(25.4,10,3,medium_fineness,[0,0],[0,0]);

/*
translate([0,0,10])
rotate([90,0,0])
palm(4,25.4+15.4*2,25.4,10,3,medium_fineness);
*/

/*
    translate([0,0,10/2])
    rotate([0,90,0])
nub_sharp(25.4,10,3,medium_fineness,0);

*/

/*
rotate([45,0,0])
rotate([0,90,0])
link_sharp_described(25.4,10,3,medium_fineness,[1,0],[0,1]);
*/

/*
rotate([0,90,0])
link_sharp_described(25.4,10,3,medium_fineness,[1,0],[0,0]);
   */ 