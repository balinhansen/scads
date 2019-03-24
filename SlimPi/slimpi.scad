inch=25.4;

module mobile_sata(){
    union(){
        translate([0,0.25*inch,0])
        square([5.05*inch,0.25*inch]);
        square([4.05*inch,0.25*inch+0.001]);
    }
}

linear_extrude(0.5,convexity=10)
translate([1.2+0.5,1.2+0.5,0])
    difference(){
        offset(delta=1.2+0.5)
        mobile_sata();
        offset(delta=0.5)
        mobile_sata();
    }

//translate([1.2,1.2,1.2])
  //  mobile_sata();
