fineness_stl=240;
fineness_low=64;

build_stl=false;

$fn = build_stl?fineness_stl:fineness_low;

module mount(){
    difference(){
        union(){    
             translate([-15,0,0])   
                cube([30, 27, 4]);
             
             translate([-15,27,0])
             cube([30,12,19]);
            
             translate([-15,-5,0])   
                cube([30, 5, 4]);
             
        }
    translate([10,7,2])    
        boltHole();
        
    translate([-10,7,2])    
        boltHole();
    
    translate([-11.5,33,0])    
        longBoltHole();
     
    translate([11.5,33,0])    
        longBoltHole();
      
    translate([0,26,18.95])
        e3dMount();

    }
}

module bracket(){
    
    difference(){
        translate([-15,-20,0])
            cube([30,12,12]);
      
        translate([-11.5,-14,-1])
            cylinder(d=3.1,h=20);
        
        translate([11.5,-14,-1])
            cylinder(d=3.1,h=20);
        
        translate([11.5,-14,-0.1])
            cylinder(d=6,h=9.1);
        
        translate([-11.5,-14,-0.1])
            cylinder(d=6,h=9.1);
        
        translate([0,-21,11.95])
            e3dMount();
    }
}

function ngon(count, radius, i = 0, result = []) = i < count
    ? ngon(count, radius, i + 1, concat(result, [[ radius*sin(360/count*i), radius*cos(360/count*i) ]]))
    : result;


module hexagon(width, rad, height){
     minkowski(){
         linear_extrude(height/2,$convexity=10)
        polygon(ngon(6,width/2-rad));
        cylinder(height/2,rad,rad);
         
     }
     
   
   /* 
    hull(){
     
      translate([width/2-rad,0,0])
        cylinder(r=rad,h=height);
         
      rotate([0,0,60])
         translate([width/2-rad,0,0])
            cylinder(r=rad,h=height);   
        
      rotate([0,0,120])
         translate([width/2-rad,0,0])
            cylinder(r=rad,h=height);
         
      rotate([0,0,180])
         translate([width/2-rad,0,0])
            cylinder(r=rad,h=height);
         
      rotate([0,0,240])
         translate([width/2-rad,0,0])
            cylinder(r=rad,h=height);
         
      rotate([0,0,300])
         translate([width/2-rad,0,0])
            cylinder(r=rad,h=height);
       
    } 
    */   
           
}

module boltHole(){
    union(){
        hexagon(6.5,0.25,2.5);
        translate([0,0,-4])
            cylinder(d=3.1, h=5);
        
    }    
    
}

module longBoltHole(){
    union(){
        translate([0,0,-.1])
        hexagon(6.5,.25,2.5);
        translate([0,0,0])
            cylinder(d=3.1, h=20);
        
    }    
    
}

module e3dMount(){
    rotate([-90,0,0]){
        union(){
        
            cylinder(d=16.2, h=4.1);
            translate([0,0,4])
                cylinder(d=12, h=6.1);
            translate([0,0,10])
                cylinder(d=16.2, h=6);
        
        }
    }
    
}

//e3dMount();
//hexagon(6.5,0.25,2.5);
//bracket();
//longBoltHole();
mount();