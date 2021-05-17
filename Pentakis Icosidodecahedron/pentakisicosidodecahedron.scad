// Catalan Pentakis Icosidodecahedron (attempt)

half_dome=1;

enable_hull=0;
no_nodes=0;
no_struts=0;
no_pyramids=0;

dome_size_inches=2;
node_size_inches= 0.0503125;
strut_width_inches=0.03125;

node_fineness=32; //48;
strut_fineness=36;

lenA=0.54653;
lenB=0.61803;

inch=25.4;
kerf=0.0035*inch;

node_size=node_size_inches*inch;
strut_width=strut_width_inches*inch;

dome_size=dome_size_inches*inch-((node_size>strut_width)?node_size:strut_width);



function alp(A,B,C)=acos((pow(B,2)+pow(C,2)-pow(A,2))/(2*B*C));
function bet(A,B,C)=acos((pow(A,2)+pow(C,2)-pow(B,2))/(2*A*C));
function del(A,B,C)=acos((pow(A,2)+pow(B,2)-pow(C,2))/(2*A*B));

strutA=lenA*dome_size/2;
strutB=lenB*dome_size/2;
angA=alp(lenA,lenB,lenB);
angB=alp(lenB,lenB,lenA);
edgeA=strutB/2/tan(36);

//  Angle A (52.48xxx) projects to 54 degrees
// Angle B (63.75xxx) projects to 72 degrees

// Deprojected Angle (Dang) = arcsin( (cos(alpha)*sin(36)) )
// Calculate for Alpha

// sin(Dang) = cos(alpha)*sin(36)
// sin(Dang)/sin(36) = cos(alpha)
// acos( sin(Dang)/sin(36) ) = alpha

// Facet Angle: (alpha) = asin( sin(Dang)/sin(36) );

// Demo 
/*
alpha=23;

rotate([0,-alpha,0])
linear_extrude(0.001,convexity=10)
polygon(points=[[0,0],[cos(36),sin(36)*cos(alpha)],[cos(36),-sin(36*cos(alpha))]]);

rotate([0,0,36])
rotate([90,0,0])
linear_extrude(0.001,convexity=10)
square(1);

translate([cos(alpha)*cos(36),cos(alpha)*sin(36),sin(alpha)*cos(36)])
sphere(0.01,$fn=24);

translate([cos(36),sin(36)*cos(alpha),0])
sphere(0.01,$fn=24);
*/

rotA=acos(sin(angA/2)/sin(36))/2;
edgeB=sin(rotA)*edgeA;
facB=atan(edgeB/strutA);
geoA=asin((strutA/2)/(dome_size/2))*2;

echo(geoA);

facA=asin(edgeB/strutA);
dihA=atan(sin(rotA)*edgeA / edgeA);

echo(alp(lenB,lenB,lenA));
echo(alp(lenA,lenB,lenB));
echo(alp(lenB,lenA,lenB));

module five_pyramid(nodes){

if (!no_nodes && !no_pyramids){
    sphere(node_size/2,$fn=node_fineness);
}

    for (i=[0:4]){
            rotate([0,0,i*360/5])
            rotate([0,90-facA,0]){
                
        if (!no_struts && !no_pyramids){
                cylinder(strutA,strut_width/2, strut_width/2,$fn=strut_fineness);
        }
            
           if (nodes[i] ==1 && !no_nodes){
            translate([0,0,strutA])
               rotate([0,90-geoA/2,0])
            sphere(node_size/2,$fn=node_fineness);
           }
        }
        
        if (!no_struts){
            translate([0,0,edgeB])
            rotate([0,0,i*360/5])
            translate([-edgeA,0,0])
            rotate([90,0,0])
            translate([0,0,-strutB/2])
            cylinder(strutB,strut_width/2,strut_width/2,$fn=strut_fineness);
        }
    }
}

// Base Pentagonal Pyramid

module dome(){
    
    translate([0,0,-dome_size/2])
    five_pyramid([1,1,1,1,1]);
    
    for (i=[0:4]){
        rotate([0,0,i*360/5])
        rotate([0,-geoA*2,0])
        translate([0,0,-dome_size/2])
        rotate([0,0,180])
        five_pyramid([0,1,1,1,0]);
        
        if (half_dome && !no_struts){
            rotate([0,0,i*360/5])
            rotate([0,geoA*2,0])
            translate([-edgeA,0,edgeB])
            translate([0,0,-dome_size/2])
            rotate([90,0,0])
            translate([0,0,-strutB/2])
            cylinder(strutB,strut_width/2,strut_width/2,$fn=strut_fineness);
        }
    }
}

if (enable_hull){
    difference(){   
        hull(){
            union(){
                if (!half_dome){
                    dome();
                }

                mirror([0,1,0])
                rotate([0,0,180])
                rotate([180,0,0])
                dome();
               
            }
        }
     
        if (half_dome){
                translate([-dome_size_inches*inch/2-0.1,-dome_size_inches*inch/2-0.1,-dome_size_inches/2*inch-0.1])
                cube([dome_size_inches*inch+0.2,dome_size_inches*inch+0.2,dome_size_inches/2*inch+0.1]);
        }

    }
    
}else{

    if (!half_dome){
        dome();
    }

    mirror([0,1,0])
    rotate([0,0,180])
    rotate([180,0,0])
    dome();
   
}
//sphere(dome_size/2+node_size/2-0.1,$fn=480);