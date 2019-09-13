unit=20;
teeth=5;

module gear(r,l,t,s){
    cylinder(l,r,r);
    for (i=[0:t-1]){
        rotate([0,0,i*360/t])
        translate([r,-(2*r*PI/(t*2))/2,0])
        cube([s,2*r*PI/(t*2),l]);
    }
}

module internalgear(r,l,t,s,e){
    difference(){
        cylinder(l,e,e);
        translate([0,0,-0.001])
        cylinder(l+0.002,r,r);
    }
    for (i=[0:t-1]){
        rotate([0,0,i*360/t])
        translate([r-s,-(2*r*PI/(t*2))/2,0])
        cube([s,2*r*PI/(t*2),l]);
    }
}

module bearing(r,s,f){
    for (i=[0:floor(r*2*PI/(s*2))]){
        
        rotate([0,0,360/floor(r*2*PI/(s*2))*i])
        translate([r,0,0])
        sphere(s,$fn=f);
    }
    
}

translate([0,0,12.5]){
    gear(20,10,16,5);
    translate([0,0,75])
    gear(20,10,16,5);
}

cylinder(110,5,5);
translate([45,0,0])
{
    translate([0,0,12.5])
    rotate([0,0,360/(16*2)]){
        gear(20,10,16,5);
        translate([0,0,75])
        gear(20,10,16,5);
    }
    cylinder(110,5,5);
}

translate([0,0,25])
gear(30,10,24,5);

translate([45,0,75])
gear(30,10,24,5);

translate([22.5,0,25])
rotate([0,0,360/80])
internalgear(57.5,10,40,5,67.5);

translate([22.5,0,75])
rotate([0,0,360/80])
internalgear(57.5,10,40,5,67.5);

translate([22.5,0,0])
{
    translate([0,0,25-2.2])
bearing(62.5,2.2,10);
translate([0,0,25+10+2.2])
bearing(62.5,2.2,10);
    
    translate([0,0,75-2.2])
bearing(62.5,2.2,10);
    translate([0,0,75+10+2.2])
bearing(62.5,2.2,10);
}

translate([22.5,0,0])
{   
    translate([0,0,25+5])
    bearing(67.5+2.2,2.2,10);
    translate([0,0,75+5])
    bearing(67.5+2.2,2.2,10);
}