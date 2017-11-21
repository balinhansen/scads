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

module capsule_threads(count, radius, height, shape, taper, helix_fineness){
    tmp=[];
    
    
    
    shape=[[0,-shell/2],[cos(30)*shell,sin(30)*shell-shell/2],[0,shell/2]];
    
    shape_len=len(shape);
    
    
    newshape=[[0,0,0], for (i=[1:10])
        for (j=[0,shape_len-1])
            concat(shape[j][0]*i/10,shape[j][1]*i/10,inch*i/10)
    ];
    
polyhedron(newshape);
    
}
    

module capsule_bottom(){
    difference(){
        capsule_shell();
        translate([0,0,size-(size-thread_length-corner*2)/2])
        cube(size=[size,size,size/2],center=true);
    }
}


capsule_threads(2,1*inch,1*inch,[[0,-shell/2],[cos(30)*shell,sin(30)*shell-shell/2],[0,shell/2]],1/4*inch,fineness);
    
//capsule_bottom();