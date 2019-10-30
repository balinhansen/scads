inch=25.4;
gap=0; // visual aid
stud_spacing_inches=18;


two_by_four_width_inches=3.75;
two_by_four_height_inches=1.75;
pier_width_inches=12;

pier_max_distances=12*8*inch;
pier_min_distance=pier_width_inches*inch*2.5;
pier_fineness=60;

bracket_width_inches=1;
bracket_fineness=24;
bracket_stock_inches=0.25;

block_length_inches=16;
block_width_inches=8;
block_height_inches=8;

slab_length_inches=24;
slab_width_inches=24;
slab_height_inches=8;


stud_spacing=stud_spacing_inches*inch;

two_by_four_width=two_by_four_width_inches*inch;
two_by_four_height=two_by_four_height_inches*inch;

pier_width=pier_width_inches*inch;
bracket_width=bracket_width_inches*inch;
bracket_stock=bracket_stock_inches*inch;

block_length=block_length_inches*inch;
block_width=block_width_inches*inch;
block_height=block_height_inches*inch;

slab_length=slab_length_inches*inch;
slab_width=slab_width_inches*inch;
slab_height=slab_height_inches*inch;

module pier(depth){
    color([0.8,0.8,0.8,0.8])
    translate([0,0,-depth])
    cylinder(depth,pier_width/2,pier_width/2,$fn=pier_fineness);
}

module pier_placement(length,sans_start,sans_finish){
    count=length-2*(1.5*pier_width);
    
}

module bracket(length,height,box_size,box_height){
    color([0.2,0.2,0.2,1]){
        translate([0,0,-length+height])
        cylinder(length-bracket_stock+0.001,bracket_width/2,bracket_width/2,$fn=bracket_fineness);
        translate([-box_size/2,-bracket_stock-box_size/2,height-bracket_stock]){
            cube([box_size,box_size+bracket_stock*2,bracket_stock]);
            translate([0,0,bracket_stock-0.001])
            cube([box_size,bracket_stock,box_height+0.001]);
            translate([0,bracket_stock+box_size,bracket_stock-0.001])
            cube([box_size,bracket_stock,box_height+0.001]);
        }
    }
}

module block(){
    color([0.8,0.8,0.8,1])
    cube([block_length,block_width,block_height]);
}

module cap(){
    color([0.8,0.8,0.8,1])
    cube([16*inch,16*inch,16*inch]);
}

module slab(){
    color([0.8,0.8,0.8,1])
    translate([-slab_length/2,-slab_width/2,-slab_height])
    cube([slab_length,slab_width,slab_height]);
}

module pier_one(length,height){
    bracket(18*inch,height,4*inch,3.5*inch);
    pier(length);
    translate([0,0,-length])
    slab();
}

module pier_two(length,height){
    for (i=[0:floor(length/(block_height+gap))-1]){
        rotate([0,0,(i%2)?90:0])
        translate([0,0,-length+(block_height+gap)*i+height])
        translate([-block_length/2,-block_width-gap/2,0]){
            block();
            translate([0,8*inch+gap,0])
            block();
        }
    }
    translate([0,0,-length+height])
    slab();
}




module two_by_four(length){
    color([0.94,0.89,0.69,1.0])
    cube(size=[two_by_four_height,two_by_four_width,length]);
}

module two_by_four_center(length){
    translate([-two_by_four_depth/2,-two_by_four_width/2,0])
    two_by_four(length);
}


module wall_section(length,height,sans_begin,sans_end){
    count=floor((length-two_by_four_height*2)/stud_spacing);
    two_by_four(height);
    diff=((length-two_by_four_height)-(stud_spacing*count))/2;
    echo(diff);
    echo(count);
    translate([diff,0,0])
    for (i=[0:count]){
        translate([stud_spacing*i,0,0])
        two_by_four(height);
    }
    
    translate([-two_by_four_height+length,0,0])
    two_by_four(height);
    
}

module three_stud_corner(length){
	two_by_four(length);
	translate([0,two_by_four_width+two_by_four_height,0])
	rotate([0,0,-90])
	two_by_four(length);
	translate([two_by_four_height,two_by_four_width,0])
	rotate([0,0,-90])
	two_by_four(length);
}


module window(length,wall_height,height,window_height,header){
    two_by_four(height-two_by_four_height);
    translate([0,0,height])
    rotate([0,90,0])
    two_by_four(length);
    translate([0,0,height])
    two_by_four(window_height);
    
    translate([0,0,height+window_height+two_by_four_height])
    for (i=[0:ceil(header/two_by_four_height)-1]){
        translate([0,0,two_by_four_height*i])
        rotate([0,90,0])
        two_by_four(length);
    }
    
    translate([0,0,height+window_height+two_by_four_height*ceil(header/two_by_four_height)])
    two_by_four(wall_height-height-window_height-two_by_four_height*ceil(header/two_by_four_height));
    
    
    // Right Side Studs
    
    translate([length-two_by_four_height,0,0])
    two_by_four(height-two_by_four_height);
    
    translate([length-two_by_four_height,0,height])
    two_by_four(window_height);
    
    translate([length-two_by_four_height,0,height+window_height+two_by_four_height*ceil(header/two_by_four_height)])
    two_by_four(wall_height-height-window_height-two_by_four_height*ceil(header/two_by_four_height));
    
}


pier_one(24*inch,6*inch);
//pier_two(80*inch,6*inch);

//wall_section(5*12*inch,8*12*inch);

//three_stud_corner(8*12*inch);
window(4*12*inch,8*12*inch,3*12*inch,3*12*inch,6*inch);