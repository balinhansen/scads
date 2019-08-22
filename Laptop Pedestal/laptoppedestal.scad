inch=25.4;

module laptop(){
        cube([14*inch,10*inch,0.375*inch]);
    translate([0,10*inch+0.155*inch,0.375*inch])
        rotate([80,0,0])
        cube([14*inch,10*inch,0.125*inch]);
}

module mousepad(){
    translate([0.5*inch,0.5*inch,0])
    minkowski(){
        cube([7.5*inch,6*inch,0.0625*inch]);
        cylinder(0.0625*inch,0.5*inch,0.5*inch,$fn=120);
    }
}


module present(){
    translate([0,0,7*inch]){
        cube([15*inch,12*inch,0.5*inch]);

        translate([15.125*inch,0,0])
        cube([10*inch,10*inch,0.5*inch]);

        translate([15.125*inch,0,0.5*inch])
        translate([0.75*inch,0.25*inch,0])
        mousepad();


        translate([0.5*inch,0.25*inch,0.5*inch])
        laptop();
    }
}

present();