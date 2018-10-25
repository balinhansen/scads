inch=25.4;
space=0.0;//25*inch;

tri=tan(30)*(0.5*inch);
tri_long=inch/2*sqrt(3)-tan(30)*(0.5*inch);
quad=norm([1,1])*inch;
pent=sqrt(pow(0.5*inch/sin(36),2)-pow(0.5*inch,2));
hex=sqrt(3)*inch;
pent_to_tri=sqrt(pow(inch/2,2)+pow(sin(21)*(inch/2),2))/2;

function ngon(count, radius, i = 0, result = []) = i < count
    ? ngon(count, radius, i + 1, concat(result, [[ radius*sin(360/count*i), radius*cos(360/count*i) ]]))
    : result;


// ORANGE

module orange(){
    color([1,0.66,0])
    translate([-0.5*inch,-0.5*inch,0])
    cube([1*inch,1*inch,0.25*inch]);
}

module orange_center(){
    orange();
}

module orange_side(){
    rotate([0,0,180])
    translate([0,0.5*inch,0])
    orange();
}

module orange_corner(){
    rotate([0,0,-45-90])
    translate([0.5*inch,0.5*inch,0])
    orange();
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


// BLUE

module blue(){
    color([0.0,0,0.8])
    rotate([0,0,-30+90])
    linear_extrude(0.25*inch,convexity=10)
    polygon([
    [0,0],
    [inch,0],
    [inch+cos(60)*inch,sin(60)*inch],
    [cos(60)*inch,sin(60)*inch]
    ]);
}

module blue_wide(){
    translate([0,-inch/2,0])
    rotate([0,0,-90])
    translate([0,-hex/2,0])
    blue();
}


module green(){
  color([0,0.6,0])
    rotate([0,0,60])
    linear_extrude(0.25*inch,convexity=10)
    polygon(ngon(3,tri_long));
}

module beige(){
    
    color([1,0.91,0.7])
    rotate([0,0,-15-90])
    linear_extrude(0.25*inch,convexity=10)
    polygon(
    [[0,0],
    [inch,0],
    [inch+cos(30)*inch,sin(30)*inch],
    [cos(30)*inch,sin(30)*inch]
    ]);
}


//      RED

module red(){
    color([0.8,0,0])
    rotate([0,0,180])
    linear_extrude(0.25*inch,convexity=10)
    polygon([[-inch,0],[inch,0],[0.5*inch,sin(60)*inch],[-0.5*inch,sin(60)*inch]]);
}


purple();

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


for (i=[0:4]){
    rotate([0,0,i*360/5-36])
    translate([0,-inch/sin(36)/2-tri*9-space*2,0])
    rotate([0,0,180])
    red();
}

for (i=[0:4]){
    rotate([0,0,i*360/5-36])
    translate([0,-inch/sin(36)/2-tri*9-space*3,0])
    orange_corner();
}



for (i=[0:4]){
    rotate([0,0,i*360/5])
for (j=[0:4]){
    translate([0,-pent-inch-hex-(tri*3)-sqrt(pow(inch/2,2)+pow(sin(21)*(inch/2),2))/2-space*5,0])
    rotate([0,0,j*360/5])
beige();
}
}


for (i=[0:4]){
    rotate([0,0,i*360/5])
for (j=[1,2,3,4]){
    translate([0,-pent-inch-hex-(tri*3)-pent_to_tri-space*5,0])
    rotate([0,0,j*360/5])
    translate([0,pent*1.5+tri+space,0])
    rotate([0,0,60])
green();
}
}


for (i=[0:4]){
    rotate([0,0,i*360/5-36])
    translate([0,-inch/sin(36)/2-inch-hex-hex/2-quad-space*4,0])
    yellow();
}

for (i=[0:9]){
    rotate([0,0,i*360/10-36-18])
    translate([0,-inch/sin(36)/2-tri*9-space*5-hex/2-quad-hex,0])
    blue();
}

for (i=[0:19]){
    rotate([0,0,i*360/20-36-9])
    translate([0,-inch/sin(36)/2-tri*9-space*6-hex/2-quad-hex,0])
    purple();
}


for (i=[0:19]){
    rotate([0,0,i*360/20-36])
    translate([0,-inch/sin(36)/2-tri*9-space*6-hex/2-quad-hex-tri*2,0])
    rotate([0,0,60])
    green();
}


for (i=[0:19]){
    rotate([0,0,i*360/20-36])
    translate([0,-inch/sin(36)/2-tri*9-space*7-hex/2-quad-hex-tri*3,0])
    orange_side();
}



for (i=[0:19]){
    rotate([0,0,i*360/20-36-9])
    translate([0,-inch/sin(36)/2-tri*9-space*7-hex/2-quad-hex-pent,0])
    blue_wide();
}