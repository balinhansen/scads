small_fineness=48;
fineness=120;
shell=2;
width=50;
height=100;
rod=2;
inch=25.4;
blades=3;
overlap=0.1;


kerf=0.0035*inch;
thread_gap=kerf*2;

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

thread_shape=[[-overlap,0],[0,0],[0,1],[width-rod-shell+overlap,1],[width-rod-shell+overlap,2],[0,2],[-overlap,2]];

for (i=[0:blades-1]){
    rotate(360/blades*i)
    threads(height,rod,thread_shape,width,100,fineness);
}

difference(){
 cylinder(height,width,width,$fn=fineness);
 translate([0,0,-0.1])
    cylinder(100.2,width-shell,width-shell,$fn=fineness);
}

cylinder(height,rod,rod,$fn=small_fineness);
