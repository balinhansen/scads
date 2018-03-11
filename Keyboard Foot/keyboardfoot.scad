fineness=25;
minkowski_fineness=25;


module peg(){
    
    translate([0,0,-0.001])
    cylinder(2.5+0.001,1,1,$fn=fineness);
    rotate([0,-90,0])
    translate([0.5,0.5,0])
    hull(){
        cylinder(cos(atan(1/3))*3,.5,.5,$fn=fineness);
        translate([-0.5,0,0])
        cylinder(cos(atan(1/3))*3,.5,.5,$fn=fineness);
    }

}

module snap_cutout(){
    
    translate([-3-0.001,2.5-0.6])
    square(size=[2.001,0.6]);

    translate([0,2.5])
    difference(){
        circle(1.6,$fn=fineness);
        circle(1,$fn=fineness);
        translate([-1.6-0.001,0])
        square(size=[3.2+0.002,1.6+0.001]);
    }

    hull(){
        translate([1.75/2+1-0.05,+2.5+1.75/2-0.6])
        circle(1.75/2,$fn=fineness);
        
        translate([3,+2.5+1.75/2-0.6-0.125])
        circle((1.75-0.25)/2,$fn=fineness);
        
        
    }

}

module keyboard_foot(){
        
    translate([0,2.5,0]){
        translate([0,0,0.75])
        mirror([0,0,1])
        peg();

        translate([0,0,14.5-0.75])
        peg();
    }

    difference(){
        
    minkowski(){
    union(){
    hull(){
        translate([0,3,0])
        cylinder(14.5/2,2.5,2.5,$fn=fineness);

        linear_extrude(14.5/2,convexity=10)
        polygon(points=[[5.5,0.5],[13.5,.5],[11.5,2],[5.5,4.5]],polys=[0,1,2,3,4,5]);
        
    }
        linear_extrude(14.5/2,convexity=10)
        polygon(points=[[5.5,0.5],[13.5,.5],[13.5,2],[11.5,2],[5.5,4.5]],polys=[0,1,2,3,4,5]);
    }


    cylinder(14.5/2,0.5,0.5,$fn=minkowski_fineness);
    }

    translate([-3-0.001,1.5,10.5+2])
    rotate([0,90,0])
    linear_extrude(11.5+3+.001,convexity=10)
    polygon(points=[[0.75,0],[2.25,0],[2.25,1],[8.25,1],[8.25,0],[9.75,0],[10.5,4.5],[10.5,5.5],[0,5.5],[0,4.5]]);

    translate([-1,1.5,10.5+2])
    rotate([0,90,0])
    linear_extrude(11.5+1+.001,convexity=10)
    polygon(points=[[0.75,0],[9.75,0],[10.5,4.5],[10.5,5.5],[0,5.5],[0,4.5]]);


    translate([-3-0.001,0,14.5])
    rotate([0,90,0])
    linear_extrude(14+3+0.002,convexity=10)
    polygon(points=[[-0.001,-0.001],[0,-0.001],[0.75,6.001],[-0.001,6.001]]);

    translate([-3-0.001,0,0])
    mirror([0,0,1])
    rotate([0,90,0])
    linear_extrude(14+3+0.002,convexity=10)
    polygon(points=[[-0.001,-0.001],[0,-0.001],[0.75,6.001],[-0.001,6.001]]);



    linear_extrude(1.5+2.75+0.002,convexity=10)
    snap_cutout();

    translate([0,0,14.5-2.75-1.5])
    linear_extrude(1.5+2.75+0.002,convexity=10)
    snap_cutout();

    }
}

translate([3,14.5+3.5/2,0])
rotate([90,0,0])
keyboard_foot();