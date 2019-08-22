inch=25.4;

kerf=0.0035*inch;
thread_gap=kerf*2;
fineness_low=40;
fineness_stl=200;

build_stl=false;
thread_length_inches=0.1875; //0.125;
size_inches=1;
corner_inches=0.375;
shell_inches=0.0625;
vent_inches=0.125;

//threads=2;
thread_length=thread_length_inches*inch;

size=size_inches*inch;
shell=shell_inches*inch;
corner=corner_inches*inch;
vent=vent_inches*inch;


fineness=build_stl?fineness_stl:fineness_low;

module capsule_shape(){
    translate([0,0,corner])
    minkowski(){
        cylinder(size-corner*2,size/2-corner,size/2-corner,$fn=fineness);
        sphere(corner,$fn=fineness);
    }
}

module capsule_void(){
    translate([0,0,corner])
    minkowski(){
        cylinder(size-corner*2,size/2-corner,size/2-corner,$fn=fineness);
        sphere(corner-shell,$fn=fineness);
    }
}

module capsule_shell(){
    difference(){
        capsule_shape();
        capsule_void();
    }
}



function trim(a,v,i=0,r=[])=
    i<len(a)?
        trim(a,v,i+1,concat(r,a[i][v]))
    :r;

function vlen(a,v)=2; //max(trim(a,v))-min(trim(a,v));

function augment(a,d,i=0,r=[])=
    i<len(a)?
        augment(a,d,i+1,concat(r,[concat(a[i],d)])):r;


function thread_place(thread_shape,thread_position,i=0,result=[])=(i<len(thread_shape))?thread_place(thread_shape,thread_position,i+1,concat(result,[[thread_shape[i][0]+thread_position[0],thread_shape[i][1]+thread_position[1],thread_shape[i][2]?thread_shape[i][2]+thread_position[2]:thread_position[2]]])):result;

function thread_rotate(thread_shape,angle,i=0,result=[])=
(i<len(thread_shape))?thread_rotate(thread_shape,angle,i+1,concat(result,[[cos(angle)*thread_shape[i][0],sin(angle)*thread_shape[i][0],thread_shape[i][1]]])):result;

function reverse(poly,i=0,result=[])=i<len(poly)?reverse(poly,i+1,concat(result,[poly[len(poly)-1-i]])):result;

//ar=[[-0.1,0],[0,0],[0,1],[1,1],[1,1.99],[-0.1,1.99]];

ar=[[-0.1,0],[0,0],[0,1+kerf+thread_gap/2],[1-kerf,1+kerf+thread_gap/2],[1-kerf,2-kerf-thread_gap/2],[0,2-kerf-thread_gap/2],[-0.1,2-kerf-thread_gap/2]];

fem_threads=[[kerf*2,kerf+thread_gap/2],[1+kerf+0.1,kerf+thread_gap/2],[1+kerf+0.1,1.99],[1+kerf,1.99],[1+kerf,1-kerf-thread_gap/2],[kerf*2,1-kerf-thread_gap/2]];

//ar=[[0,0],[1,1],[0,1.99]];

function genpoly(thread_shape,start=0,i=0,result=[])=
    (i<len(thread_shape))?genpoly(thread_shape,start,i+1,concat(result,[i+start])):result;
    
function nextpoly(thread_shape,start=0,i=0,result=[])=
    (i<(len(thread_shape)-1))?nextpoly(thread_shape,start,i+1,concat(result,[[i+start,i+start+1,i+start+len(thread_shape)+1,i+start+len(thread_shape)]])):concat(result,[[i+start,i+start-len(thread_shape)+1,i+start+1,i+start+len(thread_shape)]]);

function capsule_thread_points(length, radius, thread_shape, thread_height,fineness, y, rot=0, result = []) = 
        let(v=thread_height)
        let(y=y?y:-v)
        let(result=(result)?result:thread_place(thread_rotate(thread_shape,rot),[cos(rot)*radius,sin(rot)*radius,y]))
    (y<(length)+v/fineness)?
    capsule_thread_points(length, radius, thread_shape, thread_height,fineness, y+v/fineness, rot+360/fineness, concat(result, thread_place(thread_rotate(thread_shape,rot+360/fineness),[cos(rot+360/fineness)*radius,sin(rot+360/fineness)*radius,y+v/fineness])))
    : result;


function capsule_thread_polys(length,thread_shape,thread_height,fineness,start,y,result=[])=
        let(v=thread_height)
        let(y=y?y:-v)
let(result=(result)?result:[reverse(genpoly(thread_shape,0))])

(y<(length+v/fineness))?capsule_thread_polys(length,thread_shape,thread_height,fineness,start,y+v/fineness,concat(result,nextpoly(thread_shape,len(result)-1)) ):concat(result,[genpoly(thread_shape,start)]);



module threads(height,radius,thread_shape,thread_width,thread_height,fineness){
    da_points=capsule_thread_points(height,radius,thread_shape,thread_height,fineness);
    da_polys=capsule_thread_polys(height,thread_shape,thread_height,fineness,len(da_points)-len(thread_shape));


    difference(){
            
        polyhedron(points=da_points,faces=da_polys);
        
            
            translate([-(radius*2+thread_width*2+0.002)/2,-(radius*2+thread_width*2+0.002)/2,-thread_height-0.001])
            cube([radius*2+thread_width*2+0.002,radius*2+thread_width*2+0.002,thread_height+0.001]);
            
            translate([-(radius*2+thread_width*2+0.002)/2,-(radius*2+thread_width*2+0.002)/2,height])
            cube([radius*2+thread_width*2+0.002,radius*2+thread_width*2+0.002,thread_height+thread_height/fineness+0.001]);
            
            
    }
}

module capsule_bottom(){
    
    difference(){
        capsule_shell();
        translate([-size/2,-size/2,size-corner-shell-kerf*2])
        cube(size=[size,size,size-(corner+shell+kerf*2)]);
    }
    
    translate([0,0,size-corner-thread_length-shell])
    //rotate([0,180,0])
    threads(thread_length-kerf*2,size/2,ar,1+kerf*2+0.1,2,fineness);
    
}


module capsule_top(){
    
    difference(){
        capsule_shell();
        translate([-size/2,-size/2,0])
        cube(size=[size,size,size-corner-shell-0.001]);
        translate([0,0,-0.001])
        cylinder(size+0.002,vent/2,vent/2,$fn=fineness);
    }
    
    translate([0,0,size-shell-corner-thread_length])
    difference(){
        cylinder(thread_length+shell,size/2+shell+1+kerf*2,size/2+shell+1+kerf*2,$fn=fineness);
        translate([0,0,thread_length-0.001])
        cylinder(shell+0.002,size/2-0.1,size/2-0.1,$fn=fineness);
        
        translate([0,0,-0.001])
        cylinder(thread_length+0.001,size/2+kerf*2+1,size/2+kerf*2+1,$fn=fineness);
        
    }
    
    
    translate([0,0,size-corner-thread_length-shell])
    threads(thread_length,size/2,fem_threads,1+kerf*2+0.1,2,fineness);
    
}

function rand2DPoints(count,xmin,xmax,ymin,ymax,i=0,result=[])=
i<count?rand2DPoints(count,xmin,xmax,ymin,ymax,i+1,concat(result,[[rands(xmin,xmax,1)[0],rands(ymin,ymax,1)[0]]])):result;

module bottom_cross(){
    difference(){
        realsize=size+2+kerf*4+shell*2;
        capsule_bottom(); 
        translate([-realsize/2,0,0])
        cube([realsize,realsize/2,realsize]);
    }
}
module top_cross(){
    difference(){
        realsize=size+2+kerf*4+shell*2;
        capsule_top(); 
        translate([-realsize/2,0])
        cube([realsize,realsize/2,realsize]);
    }
}

module assembled(){
   // capsule
}

module print_top(){
    rotate([0,180,0])
    translate([0,0,-size])
    capsule_top();    
}

module cross_section(){
    bottom_cross();
    top_cross();
}


//threads(thread_length,size/2,ar,1+kerf*2+0.1,4,fineness);
//threads(thread_length,size/2,fem_threads,1+kerf*2+0.1,2,fineness);


//capsule_bottom();
//capsule_top();
//polygon(points=ar);
//polygon(points=fem_threads);
cross_section();
//print_top();