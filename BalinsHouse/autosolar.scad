include <constructionlib.scad>

function shadow_clearance(angle,height)=ceil(height/tan(angle)/25.4/12);

module shadow(angle,height){

shadow_height=height;
shadow_length=shadow_height/tan(angle);
shadow_distance=shadow_height/sin(angle);

echo(shadow_clearance(angle,height));

color([0,0,0,0.4])

translate([0,-shadow_length,0])
rotate([-90+angle,0,0])
cylinder(shadow_distance,6*inch,6*inch,$fn=12);

}


translate([property_width*12*inch/2,property_length*12*inch-8*12*inch-40*12*inch+4*12*inch])
shadow(56-23,6*12*inch+18*inch-4*inch);




module solar_battery(){
        post_hole(3*12*inch,10*inch,1*inch);
    treated()
    woodpost(8*12*inch,two_by_four_width,two_by_four_width,-3*12*inch+1*inch);
    translate([0,0,5*12*inch+1*inch+two_by_four_width/2])
    rotate([90-56,0,0]){
        wood_color_c()
        translate([-1*12*inch,-2*12*inch])
        cube([2*12*inch,4*12*inch,0.75*inch]);
        color([0,0,0.4,opacity])
        translate([-1*11*inch,-2*11*inch,0.75*inch])
        cube([2*11*inch,4*11*inch,0.25*inch]);
        
    }
    
}

rotate([0,0,180])
solar_battery();




module solar_panel(length,width,cell,space){
    color([0.9,0.9,0.9,1])
    cube([length,width,30]);
    
    length_count=floor((length-space)/(cell+space));
    length_border=(length-space-(length_count*(cell+space)))/2;
    
    width_count=floor((width-space)/(cell+space));
    width_border=(width-space-(width_count*(cell+space)))/2;
    
    for (i=[0:length_count-1]){
        for (j=[0:width_count-1]){
            color([0,0,0.4,1])
            translate([length_border+space+(cell+space)*i,width_border+space+(cell+space)*j,30])
            cube([cell,cell,1]);
        }
    }
   
}

module solar_array(length,width,spacing,angle){
    panel_length=1680;
    panel_width=1015;
    
    rotate([90-angle,0,0])
    translate([-((panel_length+spacing)*length-spacing)/2,0,0])
    for (i=[0:length-1]){
        for (j=[0:width-1]){
            translate([(panel_length+spacing)*i,(panel_width+spacing)*j,0])
            solar_panel(panel_length,panel_width,360,6);
        }
    }
    
    echo(concat("Solar width: ",(sin(angle)*((panel_width+spacing)*width-spacing))/25.4/12," feet."));
    
    echo(concat("Solar height: ",(cos(angle)*((panel_width+spacing)*width-spacing))/25.4/12," feet."));
}

clearance=shadow_clearance(56-23,6*12*inch+18*inch-4*inch);

translate([property_width*12*inch/2,property_length*12*inch-8*12*inch-40*12*inch-clearance*12*inch+4*12*inch,0])
rotate([0,0,180])
solar_array(12,7,inch,56+23);

