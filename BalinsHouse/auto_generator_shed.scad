include <constructionlib.scad>

module auto_generatorshed(dog_length,dog_width,dog_height,flooring, sheathing,siding,roofing,shingles,roof_angle){
        
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
    
    // roof cladding
    
    random_wood()
    translate([0,dog_width/2,dog_height-shingles-roofing/cos(roof_angle)])
    rotate([-roof_angle,0,0])
    cube([dog_length,dog_width/2/cos(roof_angle)-tan(roof_angle)*roofing,roofing]);
    
    random_wood()
    translate([0,dog_width/2,dog_height-shingles-roofing/cos(roof_angle)])
    mirror([0,1,0])
    rotate([-roof_angle,0,0])
    cube([dog_length,dog_width/2/cos(roof_angle)-tan(roof_angle)*roofing,roofing]);
    
    //rafters
    
    translate([0,dog_width/2,dog_height-shingles-roofing/cos(roof_angle)-two_by_four_width/cos(roof_angle)])
    rotate([-roof_angle,0,])
    cube([two_by_four_height,dog_width/2/cos(roof_angle)-tan(roof_angle)*roofing-tan(roof_angle)*two_by_four_width-two_by_four_height,two_by_four_width]);
    
    
    // Generators
    
    
    color([1,0,0,0.4])
    translate([dog_length/2-22.6*inch/2,dog_width/2-12.61*inch/2,flooring*2+two_by_four_width+1])
    cube([22.6*inch,12.61*inch,18.52*inch]);
        
    
    color([0,0,0,0.3])
    translate([dog_length/2-23.33*inch/2,dog_width/2-18.66*inch/2,flooring*2+two_by_four_width+1])
    cube([23.33*inch,18.66*inch,19.25*inch]);

    color([1,0,0,0.2])
    translate([dog_length/2-26.875*inch/2,dog_width/2-22*inch/2,flooring*2+two_by_four_width+1])
    cube([26.875*inch,22*inch,22.75*inch]);
    
    
    color([0.8,0.8,0.8,0.2])
        cube([dog_length,dog_width,dog_height]);
}

}

auto_generatorshed(36*inch,36*inch,37*inch,15/32*inch,15/32*inch,15/32*inch,15/32*inch,0.24*inch,23);