fineness=120;
thickness=0.8;
connector=10;
inch=25.4;


function parabola(width, height, x, y, fine, i = 0, result = []) = i <= fine
    ? parabola(width, height, x, y, fine, i + 1, concat(result, [[ x+width*(i/fine), y+height*pow(i/fine,2)]]))
    : result;

function parabola_reverse_shell(width, height, x, y, shell, fine, i, result = []) = i >= 0
    ? parabola_reverse_shell(width, height, x, y, shell, fine, i - 1, concat(result, [[ x+width*i/fine+sin(atan(2*pow(i/fine,2)))*shell, y+pow(i/fine,2)*height-cos(atan(2*pow(i/fine,2)))*shell]]))
    : result;


function modelled_paraboloid(width,height,internal_connector,paraboloid_fineness,rotation_fineness)=
    concat(parabola(width/2,height,0,0,paraboloid_fineness),parabola_reverse_shell(width/2,height,0,0,thickness,paraboloid_fineness,paraboloid_fineness));
    
    

module paraboloid(width,height,x_offset,internal_connector,paraboloid_fineness,rotation_fineness){
    
    echo(modelled_paraboloid(width,height,internal_connector,paraboloid_fineness,rotation_fineness));
    
    rotate_extrude(angle=360,convexity=10,$fn=rotation_fineness)
polygon(concat(parabola(width/2,height,x_offset,0,paraboloid_fineness),[[x_offset+width/2+thickness,height]],parabola_reverse_shell(width/2,height,x_offset,0,thickness,paraboloid_fineness,paraboloid_fineness)));

}

module nozzle(width,length,throat,thickness,throat_connector){
   
    difference(){
        cylinder(throat_connector,throat/2+thickness,throat/2+thickness,$fn=fineness);
        translate([0,0,-0.001])
        cylinder(throat_connector+0.002,throat/2,throat/2,$fn=fineness);
        
    }
   
    translate([0,0,throat_connector])
    paraboloid(width,length,throat/2,0,30,120);
    
    translate([throat/2+thickness,0,throat_connector-thickness])
    rotate([0,15,0])
    translate([0,0,sqrt(pow(width/2,2)+pow(length,2))/2+thickness])
    %cube([1,1,sqrt(pow(width/2,2)+pow(length,2))+thickness*2],center=true);
        
}


//difference(){
//nozzle(0.75*inch-thickness*2-2.3,inch,2.3,thickness,10);
nozzle(0.75*inch-thickness*2-2.3,inch,2.3,thickness,10);
  //  cube ([40,40,40]);
//}