inch=25.4;
tbf_width=3.5625*inch;
tbf_height=1.5625*inch;

angle=34;
width=10*12*inch;
height=(width/2-tbf_height)/tan(90-angle);


leg=sqrt(pow((width/2-tbf_height),2)*2+pow(height,2));
echo(leg/inch/12);


for (i=[0:3]){
    translate([0,0,height])
    rotate([0,0,45+90*i])
    rotate([0,asin((height)/leg),0])
    translate([-tan(asin(height/leg))*tbf_width,-tbf_height/2,0])
    cube([leg+tan(asin(height/leg))*tbf_width,tbf_height,tbf_width]);
}


for (i=[0:1]){
    rotate([0,0,90*i]){
        translate([-width/2,-width/2,0])
        cube([width,tbf_height,tbf_width]);
        translate([-width/2,width/2-tbf_height,0])
        cube([width,tbf_height,tbf_width]);
    }
}

echo((width/2-tbf_height)/cos(angle)/inch/12);

for (i=[0:3]){
    rotate([0,0,90*i]){
        translate([0,0,height])
        rotate([0,angle,0])
        translate([-tbf_width*tan(angle),-tbf_height/2,0])
        cube([(width/2-tbf_height)/cos(angle)+tbf_width*tan(angle),tbf_height,tbf_width]);
    }
}