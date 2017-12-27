


function ngon(count, radius, i = 0, result = []) = i < count
    ? ngon(count, radius, i + 1, concat(result, [[ radius*sin(360/count*i), radius*cos(360/count*i) ]]))
    : result;
    
    
module blade(){
difference(){
linear_extrude(5,convexity=10)
polygon([[0,-4],[23,-8.5],[70,-6.5],[73,-5],[73,5],[70,6.5],[23,8.5],[0,4],[0,-4]]);

rotate([90,0,90])
linear_extrude(73.002,convexity=10)
polygon([[-8.501,4],[-5,3.75],[2,2.5],[8.501,-0.001],[-8.501,-0.001],[-8.501,4]]);

rotate([90,0,90])
linear_extrude(73.002,convexity=10)
polygon([[-8.501,5],[-5,4.75],[2,3.5],[8.501,0.1-0.001],[8.501,6],[-8.501,6]]);
    }
    
}

module propeller(){
        
    translate([0,0,6]){
        difference(){
            union(){
                translate([0,0,-6])
                difference(){
                    cylinder(6.001,4,4,$fn=100);
                    
                    translate([0,0,-0.001])
                    linear_extrude(7.501,convexity=10)
                    rotate([0,0,30])
                    polygon(ngon(6,6.1/2));
                }
                cylinder(6,5,5,$fn=100);
                blade();
                rotate([0,0,180])
                blade();
            }
            translate([0,0,2])
            cylinder(4.002,3.9,3.9,$fn=100);
            
            translate([0,0,-6])
            cylinder(12,1,1,$fn=100);
        }
    }
}

translate([0,0,12])
rotate([180,0,-45])
propeller();