thickness=1.2;
shell=1.2;
points=5;
drags=0;
cut_depth=10;
arc_depth=10;
hole_radius=10;

$fn=100;

outer_radius=50;
inner_radius=30;
drag_radius=20;

side=outer_radius*sin(360/points/2)*2;
echo(side);

arc_radius=(pow(arc_depth,2)+pow(side/2,2))/(arc_depth*2);

echo(arc_radius);

edge=cos(360/points/2)*outer_radius;
echo(edge);

module drag(){
    difference(){
        sphere(5);
        sphere(5-shell);
        translate([0,-5,-5])
        cube([5,10,10]);
    }
}

difference(){
union(){
cylinder(thickness/2,outer_radius,outer_radius-cut_depth);
translate([0,0,-thickness/2])
cylinder(thickness/2,outer_radius-cut_depth,outer_radius);
}

translate([0,0,-thickness/2-0.001])
cylinder(thickness+0.002,hole_radius,hole_radius);

for (i=[0:points-1]){
    rotate(i*360/points)
    translate([0,edge-arc_depth+arc_radius,0]){
        translate([0,0,-0.001])
    cylinder(thickness/2+0.002,arc_radius,arc_radius+cut_depth);
        translate([0,0,-thickness/2-0.001])
        cylinder(thickness/2+0.002,arc_radius+cut_depth,arc_radius);
    }
}

}

if (drags){
for (i=[0:drags-1]){
    rotate(i*360/drags)
    translate([0,drag_radius,0])
    drag();
}    
}