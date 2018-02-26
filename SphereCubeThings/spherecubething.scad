inch=25.4;
kerf=0.35;

wholecube=1*inch;
lattice=3/32*inch;

cutout=wholecube-lattice*2;

fineness=80;
small_fineness=24;

module axes(){
    children();
    
    rotate([90,0,0])
        children();
    
    rotate([0,90,0])
    children();
}

module random_vector(){
    rotate([rands(0,360,1)[0],rands(0,180,1)[0],0])
    children();
}

module wholecube_cutout(){


}

module hoop(){
    difference(){
            
        cylinder(lattice,wholecube/2,wholecube/2);
            translate([0,0,-0.001],$fn=fineness)
        cylinder(lattice+0.002,wholecube/2-lattice,wholecube/2-lattice,$fn=fineness);
        }
}

module lattice_cube(){

difference(){
cube(wholecube,center=true);
    axes()
    cube(size=[cutout,cutout,wholecube+0.002],center=true);
    
    
}

axes(){
    translate([0,0,wholecube/2-lattice])
        hoop();
    translate([0,0,-wholecube/2])
        hoop();
    }
    
}



module sphere_cut(){
    
    translate([3*lattice/2,3*lattice/2,3*lattice/2])
    cube(size=[2*sqrt(2*pow(cutout/2,2))-kerf+0.002,2*sqrt(2*pow(cutout/2,2))-kerf+0.002,sqrt(2*pow(cutout/2,2))-kerf+0.001]);
}

module sphere_cuts(){
    
    for (i=[0:3]){
        rotate([0,0,360/4*i])
        sphere_cut();
    }
}

module sphere_disk(){
    translate([3*lattice/2,3*lattice/2,-lattice/2])
    cube(size=[2*sqrt(2*pow(cutout/2,2))-kerf+0.002,2*sqrt(2*pow(cutout/2,2))-kerf+0.002,lattice]);
}

module sphere_disks(){
    
    for (i=[0:3]){
        rotate([0,0,360/4*i])
        sphere_disk();
    }
}

module cell_sphere(){
    
    difference(){
        
    sphere(sqrt(2*pow(cutout/2,2))-kerf-lattice-kerf,$fn=fineness);
    sphere(sqrt(2*pow(cutout/2,2))-kerf-lattice-kerf-lattice,$fn=fineness);
        cylinder(sqrt(2*pow(cutout/2,2))-kerf-lattice-kerf+0.002,3*(sqrt(2*pow(cutout/2,2))-kerf-lattice-kerf-lattice)/4,3*(sqrt(2*pow(cutout/2,2))-kerf-lattice-kerf-lattice)/4,$fn=fineness);
    }
}

module swiss_sphere(){
    
    difference(){
        
     sphere(sqrt(2*pow(cutout/2,2))-kerf-lattice-kerf-lattice-kerf,$fn=fineness);
        
        sphere(sqrt(2*pow(cutout/2,2))-kerf-lattice-kerf-lattice-kerf-lattice,$fn=fineness);
        
        
        cylinder(
        sqrt(2*pow(cutout/2,2))-kerf-lattice-kerf-lattice+0.002,
        3*(sqrt(2*pow(cutout/2,2))-kerf-lattice-kerf-lattice-kerf-lattice)/4,
        3*(sqrt(2*pow(cutout/2,2))-kerf-lattice-kerf-lattice-kerf-lattice)/4,$fn=fineness);
        
    for (i=[0:11]){
        rotate([90,0,360/12*i])
        cylinder(sqrt(2*pow(cutout/2,2))-kerf-lattice-kerf-lattice-kerf+0.002,lattice/2,lattice/2,$fn=small_fineness);
    }
       
    for (i=[0:9]){
        rotate([67.5,0,360/10*i])
        cylinder(sqrt(2*pow(cutout/2,2))-kerf-lattice-kerf-lattice-kerf+0.002,lattice/2,lattice/2,$fn=small_fineness);
    }
    for (i=[0:9]){
        rotate([112.5,0,360/10*i])
        cylinder(sqrt(2*pow(cutout/2,2))-kerf-lattice-kerf-lattice-kerf+0.002,lattice/2,lattice/2,$fn=small_fineness);
    }
    
       
    
    for (i=[0:7]){
        rotate([135,0,360/8*i])
        cylinder(sqrt(2*pow(cutout/2,2))-kerf-lattice-kerf-lattice-kerf+0.002,lattice/2,lattice/2,$fn=small_fineness);
    }
    
    
    for (i=[0:4]){
        rotate([157.5,0,360/5*i])
        cylinder(sqrt(2*pow(cutout/2,2))-kerf-lattice-kerf-lattice-kerf+0.002,lattice/2,lattice/2,$fn=small_fineness);
    }
    
    }
    
}

module lattice_sphere(){
    difference(){
    sphere(sqrt(2*pow(cutout/2,2))-kerf,$fn=fineness);
        
        sphere_cuts();
        
        rotate([180,0,0])
        sphere_cuts();
        
        axes()
            sphere_disks();
        
        axes()
        cube(size=[lattice,lattice,2*sqrt(2*pow(cutout/2,2))-kerf+0.002],center=true);
        
        
        sphere(sqrt(2*pow(cutout/2,2))-kerf-lattice,$fn=fineness);
        //cylinder(2*sqrt(2*pow(cutout/2,2))-kerf*2+0.002,sqrt(2*pow(cutout/2,2))-kerf-lattice,sqrt(2*pow(cutout/2,2))-kerf-lattice,center=true);
    }
    }

    lattice_cube();
    lattice_sphere();
    cell_sphere();
    swiss_sphere();