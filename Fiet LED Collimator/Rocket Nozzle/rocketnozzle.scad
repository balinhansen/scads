fineness=120;
thickness=1.6;
connector=0;

// Borrored from Fiet Collimator


function parabola(width, height, x, y, fine, i = 0, result = []) = i <= fine
    ? parabola(width, height, x, y, fine, i + 1, concat(result, [[ x+width/fine*i, pow(2/fine*i,2)/4*height]]))
    : result;


function parabola_reverse(width, height, x, y, fine, i, result = []) = i >= 0
    ? parabola_reverse(width, height, x, y, fine, i - 1, concat(result, [[ x+width/fine*i, y+pow(2/fine*i,2)/4*height]]))
    : result;

function parabola_reverse_shell(width, height, x, y, shell, fine, i, result = []) = i >= 0
    ? parabola_reverse_shell(width, height, x, y, shell, fine, i - 1, concat(result, [[ x+(width+shell)/fine*i, y+pow(2/fine*i,2)/4*height]]))
    : result;


function modelled_paraboloid(width,height,internal_connector,paraboloid_fineness,rotation_fineness)=
    concat(parabola(width/2,height,1,0,paraboloid_fineness),[[width/2,height+internal_connector+connector]],[[width/2+thickness,height+internal_connector+connector]],parabola_reverse_shell(width/2,height,0,0,thickness,paraboloid_fineness,paraboloid_fineness));
    
    

module paraboloid(width,height,x_offset,internal_connector,paraboloid_fineness,rotation_fineness){
    
    echo(modelled_paraboloid(width,height,internal_connector,paraboloid_fineness,rotation_fineness));
    
    rotate_extrude(angle=360,convexity=10,$fn=rotation_fineness)
polygon(concat(parabola(width/2,height,x_offset,0,paraboloid_fineness),[[width/2,height+internal_connector+connector]],[[width/2+thickness,height+internal_connector+connector]],parabola_reverse_shell(width/2,height,x_offset,0,thickness,paraboloid_fineness,paraboloid_fineness)));

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

module nozzle(width,length,throat,exit,thickness){
    difference(){
        cylinder(1,throat/2+thickness,throat/2+thickness,$fn=fineness);
        translate([0,0,-0.001])
        cylinder(1+0.002,throat/2,throat/2,$fn=fineness);
        
    }
    translate([0,0,1])
    paraboloid(width,length,throat/2,0,60);
}

nozzle(12,20,2,0,0.8);