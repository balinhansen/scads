include <constructionlib.scad>

building_height=14;
building_width=25;
building_length=55;

property_size=45738;
property_width=152;
property_length=301;

include <property_layout.scad>
//include <autofence.scad>
include <autoshed.scad>
//include <autosolar.scad>


property();
buildable();

clearance=shadow_clearance(56-23,6*12*inch+18*inch-4*inch);

property_area(property_width*12*inch-16*12*inch,20*12*inch,8*12*inch,property_length*12*inch-8*12*inch-40*12*inch-20*12*inch-clearance*12*inch+4*12*inch,2*inch,[0,0,0.4,0.1]); //Solar Area

property_area(property_width*12*inch-16*12*inch,40*12*inch,8*12*inch,property_length*12*inch-8*12*inch-40*12*inch,2*inch,[0,0,0.8,0.1]);  // Garden Area
