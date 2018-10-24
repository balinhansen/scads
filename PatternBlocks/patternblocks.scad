inch=25.4;
space=1/64*inch;

tri=tan(30)*(0.5*inch);
tri_long=inch/2*sqrt(3)-tan(30)*(0.5*inch);
pent=sqrt(pow(0.5*inch/sin(36),2)-pow(0.5*inch,2));
hex=sqrt(3)*inch;


function ngon(count, radius, i = 0, result = []) = i < count
    ? ngon(count, radius, i + 1, concat(result, [[ radius*sin(360/count*i), radius*cos(360/count*i) ]]))
    : result;



module orange(){
    color([1,0.66,0])
    translate([-0.5*inch,-0.5*inch,0])
    cube([1*inch,1*inch,0.25*inch]);
}

module yellow(){
    color([1,1,0])
    linear_extrude(0.25*inch,convexity=10)
    polygon(ngon(6,inch));
}

module purple(){
    color([0.8,0,0.8])
    linear_extrude(0.25*inch,convexity=10)
    polygon(ngon(5,0.5*inch/sin(36)));
}

module blue(){
    color([0.0,0,0.8])
    rotate([0,0,-30+90])
    linear_extrude(0.25*inch,convexity=10)
    polygon([
    [0,0],
    [inch,0],
    [inch+inch*sqrt(3)/4,inch*sqrt(3)/2],
    [inch*sqrt(3)/4,inch*sqrt(3)/2]
    ]);
}

module green(){
  color([0,0.6,0])
    rotate([0,0,60])
    linear_extrude(0.25*inch,convexity=10)
    polygon(ngon(3,tri_long));
}

for (i=[0:4]){
    rotate([0,0,i*360/5])
    translate([0,-inch/2-sqrt(pow(0.5*inch/sin(36),2)-pow(0.5*inch,2))-space,0])
    rotate([0,0,0])
    orange();
}

for (i=[0:4]){
    rotate([0,0,i*360/5])
    translate([0,inch/sin(36)/2+space,0])
    blue();
}

for (i=[0:4]){
    rotate([0,0,i*360/5])
    translate([0,-pent-inch-hex/2-space*2,0])
    rotate([0,0,30])
    yellow();
}

for (i=[0:4]){
    rotate([0,0,i*360/5])
    translate([0,-pent-tri-space-inch-space-hex-space,0])
    rotate([0,0,0])
    green();
}

purple();