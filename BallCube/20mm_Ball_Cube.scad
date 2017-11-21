stl_output=1;
fineness=100;

view_fineness=18;
render_fineness=100;

finesness=stl_output?render_fineness:view_fineness;

difference(){
    minkowski(){
        cube(size=[12,12,12],center=true);
        sphere(4,$fn=fineness);
    }
sphere(11,$fn=fineness);
    

}



    sphere(7,$fn=fineness);