use_bed_size=1;
bed_size=200;
fineness=100;
bar_length=40;
bar_width=25.4/2;
do_hull=0;
do_caps=1;
do_hull_caps=1;
do_bucky=1;
orb_size=25.4*1.25;
use_hole=0;
hole_width=2.2;
hole_fineness=36;

module stick(length,width){
    rotate([0,90,0])
    cylinder(length,width/2,width/2,$fn=fineness);
    
    if (do_caps && !do_hull || do_hull_caps){
        
        if (do_bucky==1){
            rotate([0,90,0])
            sphere(orb_size/2,$fn=fineness);
        }else{
            rotate([0,90,0])
            sphere(width/2,$fn=fineness);
        }
        translate([length,0,0])
        rotate([0,90,0])
        sphere(width/2,$fn=fineness);
    }
    
}

module stick_truc(length,width){
    rotate([0,90,0])
    cylinder(length,width/2,width/2,$fn=fineness);
    if (do_caps && !do_hull || do_hull_caps){
        if (do_bucky==1){
            rotate([0,90,0])
            sphere(orb_size/2,$fn=fineness);
        }else{
            rotate([0,90,0])
            sphere(width/2,$fn=fineness);
        }
    }
}

module stick_no(length,width){
    rotate([0,90,0])
    cylinder(length,width/2,width/2,$fn=fineness);
    
}


module pentagon(length,width){

    for (i=[4]){
        rotate([0,0,72*i])
        translate([-length/2,-length/2/tan(36),0])
        stick_no(length,width);
    }
    
    for (i=[0,2]){
        rotate([0,0,72*i])
        translate([-length/2,-length/2/tan(36),0])
        stick_truc(length,width);
    }
}


module dodecahalf(length,width){
    translate([0,0,-sin(acos(-1/sqrt(5)))*(sin(108)*length+sin(108-72)*length/2)]){
        
        for (i=[0:4])
            rotate([0,0,72*i])
            translate([0,-length/2/tan(36),0])
            rotate([acos(-1/sqrt(5)),0,0])
            translate([0,length/2/tan(36),0])
            pentagon(length,width);
    }
}


module dodecahedron(length, width){    
    dodecahalf(length,width);
    rotate([180,0,0])
    mirror([1,0,0])
    dodecahalf(length,width);
}


module bed_dodecahedron(bed,thickness){
    actual_base=(bed-thickness-(do_bucky?(orb_size-thickness):0))/4;
    
    half_stick=actual_base*2*tan(36);
    dodecahedron(half_stick,thickness);
}

module render(){
    if (use_bed_size){
        if (do_hull){
            hull()
            bed_dodecahedron(bed_size,bar_width);
        }else{
            bed_dodecahedron(bed_size,bar_width);
        }
    }else{
        if (do_hull){
            hull()
            dodecahedron(bar_length,bar_width);
        }else{
            dodecahedron(bar_length,bar_width);
        }
    }
}

if (do_hull && use_hole){
    difference(){
        length=use_bed_size?bed_size:bar_length/2/tan(36)*4;
        render();
        translate([0,0,-length/2-0.1])
        cylinder(length+0.2,hole_width/2,hole_width/2,$fn=hole_fineness);
    }
}else{
    render();
}