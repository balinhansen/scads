thickness=1.2;
shell=1.6;
spacing=1;
comfort=0.25;

blades=5;

bit=3;
bits=7;
clasp=25;

nozzle_rows=2;
nozzle_cols=3;

small_fineness=40;
tiny_fineness=9;



function ngon(count, radius, i = 0, result = []) = i < count
    ? ngon(count, radius, i + 1, concat(result, [[ radius*sin(360/count*i), radius*cos(360/count*i) ]]))
    : result;


module blade_holder(){
    difference(){

        translate([0,2,0])
        cube([40+thickness*2,18+thickness,2*thickness+1.5*blades+spacing*(blades-1)]);

        translate([thickness,0,thickness])
        for (i=[0:blades-1]){
            translate([0,2-0.001,(1.5+spacing)*i])
            cube([40,18+0.001,1.5]);
        }

    }
}

module bits_holder(){
    
    cube([bits*bit+(bits-1)*spacing+thickness*2*bits,40+thickness*2,thickness]);
    cube([bits*bit+(bits-1)*spacing+thickness*2*bits,thickness,3+thickness]);
    translate([0,40+thickness,0])
    cube([bits*bit+(bits-1)*spacing+thickness*2*bits,thickness,3+thickness]);

    for (i=[0:bits-1]){
        translate([bit*i+thickness*2*i+spacing*i,thickness+11,thickness-0.001])
        difference(){
            cube([bit+thickness*2,4,bit+0.001]);
            translate([bit/2+thickness-(sin(90-clasp)*bit/2),-0.001,0.001])
            cube([sin(90-clasp)*bit,4+0.002,bit+0.001]);
            translate([thickness,-0.001,0.001])
            cube([bit,4+0.002,bit/2+cos(90-clasp)*bit/2]);
        }
    }
}

module bits(){
    for (i=[0:bits-1]){
        translate([bit*i+thickness*2*i+spacing*i+thickness+bit/2,thickness,thickness+bit/2])
        rotate([-90,0,0]){
            %cylinder(22,bit/2,bit/2,$fn=small_fineness);
            translate([0,0,22-0.001])
            %cylinder(16+0.001,0.4/2,0.4/2,$fn=tiny_fineness);
        }
    }
}

module nozzle(){
    translate([0,0,6.5+3+1.5-0.001])
    cylinder(2+0.001,4.5/2,1.5/2,$fn=small_fineness);

    translate([0,0,1.5+6.5])
    rotate([0,0,30])
    linear_extrude(3,convexity=10)
    polygon(points=ngon(6,4));

    translate([0,0,6.5-0.001])
    cylinder(1.5+0.002,4/2,4/2,$fn=small_fineness);

    cylinder(6.5,6/2,6/2,$fn=small_fineness);
}

module nozzles(){

    for (i=[0:nozzle_rows-1]){
        for (j=[0:nozzle_cols-1]){
            translate([8/2+thickness+thickness*2*j+8*j+spacing*j,thickness+thickness*2*i+(2+3+1.5+6.5)*i+spacing*i,thickness+8/2])
            rotate([-90,0,0])
            nozzle();
        }
    }
}

module nozzle_holder(){
    cube([nozzle_cols*8+nozzle_cols*2*thickness+(nozzle_cols-1)*spacing,13*nozzle_rows+thickness*2*nozzle_rows+(nozzle_rows-1)*spacing,thickness]);
}

%nozzles();
nozzle_holder();