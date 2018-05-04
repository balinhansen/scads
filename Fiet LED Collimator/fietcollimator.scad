thickness=0.6;
connector=5;
hover=0.1;

screw_width=6.4;

inch=25.4;

kerf=0.0035*inch*2.25;

function ngon(count, radius, i = 0, result = []) = i < count
    ? ngon(count, radius, i + 1, concat(result, [[ radius*sin(360/count*i), radius*cos(360/count*i) ]]))
    : result;


function parabola(width, height, x, y, fine, i = 0, result = []) = i <= fine
    ? parabola(width, height, x, y, fine, i + 1, concat(result, [[ width/fine*i, pow(2/fine*i,2)/4*height]]))
    : result;


function parabola_reverse(width, height, x, y, fine, i, result = []) = i >= 0
    ? parabola_reverse(width, height, x, y, fine, i - 1, concat(result, [[ x+width/fine*i, y+pow(2/fine*i,2)/4*height]]))
    : result;

function parabola_reverse_shell(width, height, x, y, shell, fine, i, result = []) = i >= 0
    ? parabola_reverse_shell(width, height, x, y, shell, fine, i - 1, concat(result, [[ x+(width+shell)/fine*i, y+pow(2/fine*i,2)/4*height-cos(atan(2*(i/fine)*(height/width)))*shell]]))
    : result;


module paraboloid(width,paraboloid_fineness,rotation_fineness){
    rotate_extrude(angle=360,convexity=10,$fn=rotation_fineness)
polygon(concat(parabola(width/2,width/2,0,0,paraboloid_fineness),[[width/2,width/2+1+connector]],[[width/2+thickness,width/2+1+connector]],parabola_reverse_shell(width/2,width/2,0,0,thickness,paraboloid_fineness,paraboloid_fineness)));

}

module parabola_wall(width,paraboloid_fineness){
    linear_extrude(width,convexity=10)
     polygon(concat(parabola(width/2,width/2,0,0,paraboloid_fineness),[[width/2,width/2+1+connector]],[[width/2+thickness,width/2+1+connector]],parabola_reverse_shell(width/2,width/2,0,0,thickness,paraboloid_fineness,paraboloid_fineness)));
}


module parabola_ngon(){
    
    paraboloid_fineness=120;
    width=80;
    length=100;
    sides=6;

    for (s=[0:sides-1]){
        rotate([0,0,s*360/sides])    
        difference(){
            
        rotate([90,0,0])
        translate([0,0,-length/2])
        parabola_wall(width,120);
            rotate([0,0,0.5*360/sides])
            translate([0,0,-thickness-0.001])
            rotate_extrude(angle=360-360/sides,convexity=10,$fn=paraboloid_fineness)
            square(size=[width,length/2+thickness+2+0.002]);
        }
    }
}
/*
difference(){
    translate([0,0,thickness])
    paraboloid(100,120,240);
    cylinder(50.001,55.5/2,55.5/2,$fn=160);
}*/

module feit_ngon(){
    difference(){
        translate([0,0,thickness])
        parabola_ngon();
        cylinder(50.001,55.5/2,55.5/2,$fn=160);
        cube(size=[100,100,39],center=true);
    }
    
    
    difference(){
        translate([0,0,thickness])
        paraboloid(width,40,120);
        cylinder(50.001,55.5/2,55.5/2,$fn=160);
        cube(size=[100,100,39],center=true);
    }
    
    
    links=5;

    // Female Connector
    
    width=80;
    for (s=[0:2]){
        rotate([0,0,s*360/3])
        translate([width/2+thickness,-width/4+0.5*((width/2)/(links*2)),width/2+thickness]){
            //cube([connector,width/2,thickness]);
            
            
            translate([0,((width/2)/(links*2))/2,0])
            for (i=[1:links-1]){
                translate([0,(2*i*(width/2)/(links*2))+0.001-(1.5*(width/2)/(links*2)),-thickness])
                cube([connector,((width/2)/(links*2))-0.002,thickness]);
                
                translate([0,(2*i*(width/2)/(links*2))-0.001-(1.5*(width/2)/(links*2)),connector])
                cube([connector,((width/2)/(links*2))+0.002,thickness]);
                
            }
            
            translate([0,((width/2)/(links*2))/2,0])
            for (i=[1:links]){
                translate([0,(2*i*(width/2)/(links*2))+0.001-(2.5*(width/2)/(links*2)),kerf])
                cube([connector,((width/2)/(links*2))-0.002,thickness]);
                
                translate([0,(2*i*(width/2)/(links*2))-0.001-(2.5*(width/2)/(links*2)),connector-thickness-kerf])
                cube([connector,((width/2)/(links*2))+0.002,thickness]);
                
            }
            
            for (i=[0:links-1]){
                translate([0,(2*i*(width/2)/(links*2)),-thickness])
                cube(size=[connector,thickness,connector+thickness*2]);
                translate([0,((2*i+1)*(width/2)/(links*2))-thickness,-thickness])
                cube(size=[connector,thickness,connector+thickness*2]);
            }
        }
    }

    // Male Connector
    
    for (s=[0:2]){
        rotate([0,0,60+s*360/3])
        translate([width/2+thickness,-width/4,width/2+thickness]){
            //cube([connector,width/2,thickness]);
        
            
            translate([0,((width/2)/(links*2))/2,0])
            for (i=[0:links-2]){
                translate([0,(2*i*(width/2)/(links*2))+0.001+((width/2)/(links*2))+kerf,kerf])
                cube([connector,((width/2)/(links*2))-0.002-2*kerf,thickness]);
                
                translate([0,(2*i*(width/2)/(links*2))-0.001+((width/2)/(links*2))+kerf,connector-thickness-kerf])
                cube([connector,((width/2)/(links*2))+0.002-2*kerf,thickness]);
                
            }
            
            translate([0,3*((width/2)/(links*2))/2,0])
            for (i=[0:links-2]){
                translate([0,(2*i*(width/2)/(links*2))+kerf,kerf])
                cube(size=[connector,thickness,connector-kerf*2]);
                translate([0,((2*i+1)*(width/2)/(links*2))-thickness-kerf,kerf])
                cube(size=[connector,thickness,connector-kerf*2]);
            }
        }
    }
    
    // Mount Screw Positions
    
    for (l=[0:2]){
        for (s=[0:1]){
            
            edge=(width/2+connector/2+thickness+hover);
            hype=edge;
            
            rotate([0,0,60+(s?-1:1)*l*360/6+(s?-1:0)*360/6]){
            
                // Screw Ring
            
                translate([edge,(edge/sqrt(3)),width/2+thickness+l*(connector/3+kerf)])
                difference(){
                    cylinder(connector/3-kerf,connector/2,connector/2,$fn=50);
                    translate([0,0,-0.001])
                    cylinder(connector/3-kerf+0.002,(connector-screw_width/2)/2,(connector-screw_width/2)/2,$fn=50);
                }
                
                
                // Mount Cube
                
                translate([edge,(edge/sqrt(3)),width/2+thickness+l*(connector/3+kerf)])
                rotate([0,0,360/12]){
                    difference(){
                        translate([-connector,-connector/2,0])
                        cube(size=[connector,connector,connector/3-kerf]);
                        
                        translate([0,0,-0.001])
                        cylinder(connector/3-kerf+0.002,(connector-screw_width/2)/2,(connector-screw_width/2)/2,$fn=50);
                        
                    //}
                
                        translate([-(width/2*sqrt(3))/2-2*connector/3,0,-0.001])
                        linear_extrude(connector/3-kerf+0.002,convexity=10)
                        rotate([0,0,360/12])
                        polygon(points=ngon(6,(width/2*sqrt(3))/2) );
                    }
                }
            }
        }
    }

}

feit_ngon();

/*

translate([80+thickness*2+connector+hover*2,0,0])
feit_ngon();

translate([sin(30)*(80+thickness*2+connector+hover*2),cos(30)*(80+thickness*2+connector+hover*2),0])
feit_ngon();

*/


/*
width=80;
for (s=[0:5]){
    rotate([0,0,s*360/6])
    translate([width+connector+hover,0,0])
    feit_ngon();
    
}
*/