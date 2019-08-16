inch=25.4;

kerf=0.0035*inch;

fineness_low=20;
fineness_stl=200;

build_stl=false;


threads=2;
thread_length=3/8*inch;

size=1*inch;
shell=1/16*inch;
corner=1/4*inch;

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

ar=[[-0.1,0],[0,0],[0,1],[1,1],[1,2],[-0.1,2],[-0.1,0]];

//ar=[[-0.1,0],[0,0],[0,1+kerf],[1-kerf,1+kerf],[1-kerf,2-kerf],[0,2-kerf],[-0.1,2-kerf],[-0.1,0]];

ar=[[0,0],[1,1],[0,1.5]];

function genpoly(thread_shape,start=0,i=0,result=[])=
    (i<len(thread_shape))?genpoly(thread_shape,start,i+1,concat(result,[i+start])):result;
    
function nextpoly(thread_shape,start=0,i=0,result=[])=
    (i<(len(thread_shape)-1))?nextpoly(thread_shape,start,i+1,concat(result,[[i+start,i+start+1,i+start+len(thread_shape)+1,i+start+len(thread_shape)]])):concat(result,[[i+start,i+start-len(thread_shape)+1,i+start+1,i+start+len(thread_shape)]]);

function capsule_thread_points(length, radius, thread_shape, fineness, y, rot=0, result = []) = 
        let(v=vlen(thread_shape,1))
        let(y=y?y:-v)
        let(result=(result)?result:thread_place(thread_rotate(thread_shape,rot),[cos(rot)*radius,sin(rot)*radius,y]))
    (y<(length)+v/fineness)?
    capsule_thread_points(length, radius, thread_shape, fineness, y+v/fineness, rot+360/fineness, concat(result, thread_place(thread_rotate(thread_shape,rot+360/fineness),[cos(rot+360/fineness)*radius,sin(rot+360/fineness)*radius,y+v/fineness])))
    : result; //result;


function capsule_thread_polys(length,thread_shape,fineness,start,y,result=[])=
        let(v=vlen(thread_shape,1))
        let(y=y?y:-v)
let(result=(result)?result:[reverse(genpoly(thread_shape,0))])

(y<(length+v/fineness))?capsule_thread_polys(length,thread_shape,fineness,start,y+v/fineness,concat(result,nextpoly(thread_shape,len(result)-1)) ):concat(result,[genpoly(thread_shape,start)]);


da_points=capsule_thread_points(25.4,size/2,ar,fineness);
da_polys=capsule_thread_polys(25.4,ar,fineness,len(da_points)-len(ar),convexity=10);


union(){
    
polyhedron(points=da_points,faces=da_polys,convexity=10);

    
}

module capsule_bottom(){
    difference(){
        capsule_shell();
        translate([0,0,size-(size-thread_length-corner*2)/2])
        cube(size=[size,size,size/2],center=true);
    }
}

function rand2DPoints(count,xmin,xmax,ymin,ymax,i=0,result=[])=
i<count?rand2DPoints(count,xmin,xmax,ymin,ymax,i+1,concat(result,[[rands(xmin,xmax,1)[0],rands(ymin,ymax,1)[0]]])):result;


    
//capsule_bottom();
