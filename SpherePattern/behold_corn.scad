inch=25.4;

sphere_inches=4;
element_inches=0.25;
sphere_fineness=60;
element_fineness=12;
bead_fineness=12;

sphere_size=sphere_inches*inch;
element_size=element_inches*inch;

rings=floor(PI*sphere_size/(2*element_size));

function arraysum(a,i=0,o=0)=i<len(a)?arraysum(a,i+1,o=o+a[i]):o;

module seedbead(){
    rotate([90,0,0])
    rotate_extrude(angle=360,$fn=bead_fineness)
    translate([element_size/3,0,0])
    scale([0.5,1,1])
    circle(element_size/3,$fn=bead_fineness);
    }
 
module behold_corn(){
    scale([1,1,0.5])
    hull(){
        translate([-element_size/4,0,0])
        sphere(element_size/2,$fn=element_fineness);
        translate([element_size/4,0,0])
        sphere(element_size/2,$fn=element_fineness);
    }
}
    
    
function list(i,o)=let(rad=sin(i*180/rings)*sphere_size/2) let(rings=floor(PI*sphere_size/(2*element_size))) i<rings?list(i+1,concat(o,floor(2*rad*PI/element_size))):o;
    

  color([0.8,0.8,0.8,1])
//difference(){  
sphere(sphere_size/2,$fn=sphere_fineness);


for (i=[0:rings-1]){
    ang=i*180/rings;
    rad=sin(ang)*sphere_size/2;
    height=cos(ang)*sphere_size/2;
    
    translate([0,0,-height]){
        /*
        color([i/rings,(rings-i)/rings,0,0.4])
        translate([0,0,-element_size/2])
        cylinder(element_size,rad,rad,$fn=sphere_fineness);
        */
        elements=floor(2*rad*PI/element_size);
        if (elements){
            for (e=[0:elements-1]){
                //color([i/rings,(rings-i)/rings,e/elements,1])
                rotate([0,0,360*e/elements])
                translate([rad,0,0])
                //seedbead();
                
                    rotate([0,-ang,0])
                    behold_corn();
                //sphere(element_size/2,$fn=element_fineness);
            }
            echo(elements);
        }
    }
}


echo(concat("Elements: ",list(1,[])));
echo(concat("Rows: ",len(list(1,[]))));
echo(concat("Total Elements: ",arraysum(list(1,[]))));

//}

/*
color([0.8,0.8,0.8,0.2])
sphere(sphere_size/2,$fn=sphere_fineness);
*/