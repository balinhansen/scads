inch=25.4;

kerf=0.007*inch;

fineness_low=40;
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

function vlen(a,v)=max(trim(a,v))-min(trim(a,v));

//max(trim(a,v))-min(trim(a),v);




ar=[[-0.001,0],[0,0],[0,1],[1,1],[1,2],[-0.001,2],[-0.001,0]];

echo(vlen(ar,1));


function capsule_thread_points(length, radius, thread_shape, fineness, y, result = []) = 
        let(v=vlen(thread_shape,1))
        let(ang=asin(v/(radius*2*PI)))
        let(adj=cos(ang)*v)
        let(turns=(length+adj*2)/adj)
        let(y=y?y:-1*adj)
    (y<(length+v))?
    capsule_thread_points(length, radius, thread_shape, fineness, y+adj/fineness, concat(result, [
    [0,1],[1,0]
    
    ]))
    : concat(result,thread_shape); //result;


echo(capsule_thread_points(25.4,size/2,ar,fineness));


module capsule_threads(count, radius, height, shape, taper, helix_fineness){
    tmp=[];
    
    
    
    shape=[[0,-shell/2],[cos(30)*shell,sin(30)*shell-shell/2],[0,shell/2]];
    
    shape_len=len(shape);
    
    
    
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


capsule_threads(2,1*inch,1*inch,[[0,-shell/2],[cos(30)*shell,sin(30)*shell-shell/2],[0,shell/2]],1/4*inch,fineness);
    
//capsule_bottom();