include <constructionlib.scad>

module property(){

echo(concat("Perimeter ",property_length*2+property_width*2));

color([0,0.8,0,0.1])
translate([0,0,-1.5*inch])
cube([property_width*12*inch,property_length*12*inch,inch/4]);
}

module buildable(){
    color([0.8,0,0,0.1])
    translate([(building_height-4)*12*inch,(building_height+4)*12*inch,-0.5*inch])
    cube([(property_width-(building_height-4)*2)*12*inch,(property_length-(building_height+10)*2)*12*inch,inch/4]);

}


module property_area(w,l,off_w,off_l,h,c){
    color(c)
    translate([off_w,off_l,0])
        cube([w,l,inch*2]);

}


/*

Example code:

property();
buildable();

clearance=shadow_clearance(56-23,6*12*inch+18*inch-4*inch);

property_area(property_width*12*inch-16*12*inch,20*12*inch,8*12*inch,property_length*12*inch-8*12*inch-40*12*inch-20*12*inch-clearance*12*inch+4*12*inch,2*inch,[0,0,0.4,0.1]); //Solar Area

property_area(property_width*12*inch-16*12*inch,40*12*inch,8*12*inch,property_length*12*inch-8*12*inch-40*12*inch,2*inch,[0,0,0.8,0.1]);  // Garden Area

*/