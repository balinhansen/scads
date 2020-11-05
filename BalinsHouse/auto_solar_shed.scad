include <constructionlib.scad>

module auto_solarshed(dog_length,dog_width,dog_height,flooring, sheathing,siding,roofing,shingles,roof_angle){
        
    translate([-dog_length/2,-dog_width/2,0]){
    
        translate([sheathing+siding,sheathing+siding,0]){
            
            random_wood()
            cube([dog_length-sheathing*2-siding*2,dog_width-sheathing*2-siding*2,flooring]);

            translate([0,0,flooring]){
            random_wood()
            cube([dog_length-sheathing*2-siding*2,two_by_four_height,two_by_four_width]);
            translate([0,dog_width-sheathing*2-siding*2-two_by_four_height,0])
            random_wood()
            cube([dog_length-sheathing*2-siding*2,two_by_four_height,two_by_four_width]);
            
            translate([0,two_by_four_height,0]){
            random_wood()
            cube([two_by_four_height,dog_width-sheathing*2-siding*2-two_by_four_height*2,two_by_four_width]);
            
            random_wood()
            translate([dog_length-sheathing*2-siding*2-two_by_four_height,0])
                cube([two_by_four_height,dog_width-sheathing*2-siding*2-two_by_four_height*2,two_by_four_width]);
            }
            
        }
        
        translate([0,0,flooring+two_by_four_width])
        random_wood()
        cube([dog_length-sheathing*2-siding*2,dog_width-sheathing*2-siding*2,flooring]);


        translate([0,0,flooring*2+two_by_four_width]){
            random_wood()
            cube([dog_length-sheathing*2-siding*2,two_by_four_width,two_by_four_height]);
            translate([0,dog_width-sheathing*2-siding*2-two_by_four_width,0])
            random_wood()
            cube([dog_length-sheathing*2-siding*2,two_by_four_width,two_by_four_height]);
            
            translate([0,two_by_four_width,0]){
            random_wood()
            cube([two_by_four_width,dog_width-sheathing*2-siding*2-two_by_four_width*2,two_by_four_height]);
            
            random_wood()
            translate([dog_length-sheathing*2-siding*2-two_by_four_width,0])
                cube([two_by_four_width,dog_width-sheathing*2-siding*2-two_by_four_width*2,two_by_four_height]);
            }
            
        }
    }
    
    // cover box cladding
    
    
    random_wood()
    translate([0,sin(roof_angle)*two_by_four_width,dog_height-shingles-roofing*cos(roof_angle)])
    rotate([-roof_angle,0,0])
    //translate([0,tan(roof_angle)*two_by_four_width,0])
    cube([dog_length,48*inch,roofing]);
    
    translate([0,0,dog_height-shingles-(roofing+two_by_four_width)*cos(roof_angle)])
    rotate([-roof_angle,0,0])
    cube([two_by_four_height,48*inch,two_by_four_width]);
    
    // solar roof cladding
    
    random_wood()
    translate([0,0,dog_height-shingles-((two_by_four_width+roofing)*cos(roof_angle))-(shingles+roofing)/cos(roof_angle)])
    rotate([-roof_angle,0,0])
    cube([dog_length,dog_width/cos(roof_angle)-tan(roof_angle)*roofing,roofing]);
    
    //rafters
    
    translate([0,0,dog_height-shingles-((two_by_four_width+roofing)*cos(roof_angle))-(shingles+roofing)/cos(roof_angle)-two_by_four_width/cos(roof_angle)])
    rotate([-roof_angle,0,])
    cube([two_by_four_height,dog_width/cos(roof_angle)-tan(roof_angle)*roofing-tan(roof_angle)*two_by_four_width-two_by_four_height,two_by_four_width]);
    
    echo(dog_width/cos(roof_angle)/25.4);
    
    echo(-tan(roof_angle)*two_by_four_width/25.4);
    
    echo(sqrt(pow(48*inch,2)+pow(two_by_four_width+roofing,2))/25.4);
    
    color([0.8,0.8,0.8,0.2])
        cube([dog_length,dog_width,dog_height]);
}

}

auto_solarshed(72*inch,44*inch,37*inch,15/32*inch,15/32*inch,15/32*inch,15/32*inch,0.25*inch,23);