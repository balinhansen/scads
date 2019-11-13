bead_fineness=12;

module seedbead(){
   rotate_extrude(angle=360,$fn=bead_fineness)
    translate([1,0,0])
    scale([0.5,1,1])
    circle(1,$fn=bead_fineness);
 }

for(i=[0,2,5])
    rotate([0,0,360/7*i])
translate([2,0,0])
rotate([90,0,0])
seedbead();


for(i=[2,5.5,7.5,11])
    rotate([0,0,360/13*i])
translate([3.5,0,0])
rotate([90,0,0])
seedbead();
