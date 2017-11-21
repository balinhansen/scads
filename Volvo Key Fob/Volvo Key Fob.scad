fineness=100;

module fob(){
    
    translate([2,3,0])
    cube(size=[22.5,26,2]);
    
    translate([0,0,1.99]){
        
        translate([0,3,0])
        cube(size=[26.5,26,1.01]);
        
        translate([0,0,1.49]){
            linear_extrude(1.52,convexity=10)
            polygon(points=[[0,0],[26.5,0],[26.5,32],[14,39],[14,44],[0,44]]);
            
            translate([0,0,01.49])
            linear_extrude(2.01,convexity=10)
            polygon(points=[[0,2],[26.5,2],[26.5,32],[14,39],[14,41],[0,41]]);
            
            translate([0,0,0.99]){            
                translate([2,4,0]){
                    cube(size=[6.5,6.5,2.01]);
                    translate([3.25,3.25,1.99]){
                        cylinder(1.51,2.25,2.25,$fn=fineness);
                        translate([0,0,1.5])
                        button_impression();
                        
                        rotate([0,0,180])
                        translate([-1,-5.25,5])
                        linear_extrude(0.54,convexity=10)
                        text("UNLOCK", font="Liberation Sans:style=Bold",size=2,halign="center");
                                
                    }
                }
                
                translate([18,4,0]){
                    cube(size=[6.5,6.5,2.01]);
                    translate([3.25,3.25,1.99]){
                        cylinder(1.51,2.25,2.25,$fn=fineness);
                        translate([0,0,1.5])
                        button_impression();
                        
                        rotate([0,0,180])
                        translate([0,-5.25,5])
                        linear_extrude(0.54,convexity=10)
                        text("LOCK", font="Liberation Sans:style=Bold",size=2,halign="center");
                    }
                }
                
                translate([10,20,0]){
                    cube(size=[6.5,6.5,2.01]);
                    translate([3.25,3.25,1.99]){
                        cylinder(1.51,2.25,2.25,$fn=fineness);
                        translate([0,0,1.5])
                        button_impression();
                        
                        
                        rotate([0,0,180])
                        translate([0,-5.25,5])
                        linear_extrude(0.54,convexity=10)
                        text("TRUNK", font="Liberation Sans:style=Bold",size=2,halign="center",$fn=fineness);
                        
                    }
                }
                
                translate([5,34.5,0]){
                    cube(size=[6.5,6.5,2.01]);
                    translate([3.25,3.25,1.99]){
                        cylinder(1.51,2.25,2.25,$fn=fineness);
                        translate([0,0,1.5])
                        button_impression();
                        
                        
                        rotate([0,0,180])
                        translate([0,-5.25,5])
                        linear_extrude(0.54,convexity=10)
                        text("ALARM", font="Liberation Sans:style=Bold",size=2,halign="center");
                    }
                }
            }
        }
    }
}


module fob_front(){
    union(){
        difference(){
            translate([2,2,6])
            minkowski(){
                cube(size=[26.5,44,6]);
                    sphere(2,$fn=fineness);
            }
            
            translate([2,2,2])
            union()
            fob();
            
            translate([-0.01,-0.01,3.99])
            cube(size=[30.52,48.2,2.01]);
            
            
            translate([21,39,-0.01]){
                translate([3.1,3.1,0]){
                    translate([0,0,9])
                //cylinder(3.2,3.1,3.1,$fn=fineness);
            
                    linear_extrude(5.01,convexity=10)
                    polygon(ngon(6,5.9/2));
                    
                    cylinder(10.01,1.6,1.6,$fn=fineness);
                }
            }
            
        }
        
        translate([2,2,1.86])
         
        translate([0,0,-0.01])
        difference(){
                minkowski(){
                    cube(size=[26.5,44,2.15]);
                    cylinder(2.15,2,2,$fn=fineness);
                }
                
                translate([0,0,-0.01])
                minkowski(){
                    cube(size=[26.5,44,2.17]);
                    cylinder(2.17,1.1,1.1,$fn=fineness);
                }
        }
        
        translate([30.5/2,0,8])
        rotate_extrude(angle=180,convexity=10,$fn=fineness)
        translate([-7.5,0,0])
        circle(3,$fn=fineness);
    }
}

module fob_back(){
    difference(){
        translate([2,2,2])
        minkowski(){
            cube(size=[26.5,44,4]);
                sphere(2,$fn=fineness);
        }
        
        translate([2,2,1.99])
        union()
        fob();
        
        translate([-0.01,-0.01,5.99])
        cube(size=[30.52,48.2,2.51]);
        
        translate([21,39,-0.01]){
            translate([3.1,3.1,0]){
            cylinder(2.4,3.1,3.1,$fn=fineness);
        
            cylinder(10,1.6,1.6,$fn=fineness);
            }
        }
        
        
        translate([2,2,2])
        difference(){
            translate([-0.01,-0.01,0])
            minkowski(){
                cube(size=[26.5,44,2]);
                cylinder(2,2.05,2.05,$fn=fineness);
            }
            
            translate([0,0,-0.01])
            minkowski(){
                cube(size=[26.6,44.2,2.02]);
                cylinder(2.02,0.9,0.9,$fn=fineness);
            }
        }
        
                        translate([30.5/2,48/2,0.5])
                        rotate([0,180,0])
                        linear_extrude(0.51,convexity=10)
                        text("VOLVO", font="Liberation Sans:style=Bold",size=5,halign="center",$fn=fineness);
                        
        
                        translate([30.5/2,36/2,0.5])
                        rotate([0,180,0])
                        linear_extrude(0.51,convexity=10)
                        text("S70", font="Liberation Sans:style=Bold",size=4,halign="center",$fn=fineness);
        
    }
}

module button_impression(){
    union(){
        translate([0,0,-3.5])
            difference(){
                cylinder(5.78,4.39,4.39,$fn=fineness);
                translate([0,-8.2,7.64])
                cube(size=[10,10,10],center=true);
            }
        translate([0,0,1.27]){
            cylinder(6,2.39,2.39,$fn=fineness);
        }
    }
}

module button(){
    union(){
    difference(){
        cylinder(2,4.25,4.25,$fn=fineness);
        translate([0,-8,4.99])
        cube(size=[10,10,10],center=true);
    }
    translate([0,0,2]){
        cylinder(2,2.25,2.25,$fn=fineness);
        
        translate([0,0,2])
        scale([1,1,1.5/2.25])
        sphere(2.25,$fn=fineness);
    }
}
}


function ngon(count, radius, i = 0, result = []) = i < count
    ? ngon(count, radius, i + 1, concat(result, [[ radius*sin(360/count*i), radius*cos(360/count*i) ]]))
    : result;


// RENDER MODES

module fob_full(){
    color([0.4,0.4,0.4,0.2])
    fob_back();
    translate([2,2,2])
    color([0.6,0.6,0.6])
    fob();
    color([0.8,0.8,0.8,0.2])
    fob_front();
}

module fob_explode(){
  
    color([0.4,0.4,0.4,0.4])
    fob_back();
    
    color([0.6,0.6,0.6,0.4])
    translate([2,2,12])
    fob();

    translate([0,0,24])
    color([0.8,0.8,0.8,0.4])
    union()
    fob_front();

}

module fob_front_print(){
    translate([30.5,0,12.5])
    rotate([0,180,0])
    fob_front();
}

module fob_both_print(){
    translate([30.5,0,12.5])
    rotate([0,180,0])
    fob_front();
    
    translate([40.5,0,0])
    fob_back();
}

module button_view(){
    button();
    color([0.5,0.5,0.5,0.5])
    button_impression();
}

//button();

//button_view();

//fob_explode();

fob_front_print();

//fob_both_print();

//fob_back();

//fob_full();
