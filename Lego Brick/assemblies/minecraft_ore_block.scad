include <../libraries/legobrick_vars.scad>;
include <../libraries/legobrick_lib.scad>;

echo("Lego Ore Block loaded ...");

lego_length=16;
big_overrides=1; // Brick over 1:1 scale

module print_oreblock(){
    space=2.5;
    
    color([0.75,0.75,0.75,1.0]){
    xbyy_brick(2,2,lego_block_height/3);
    
    translate([lego_length*2+space/8*lego_length,0,0])
    twobytwo_centerknob(lego_block_height/3);
    
    translate([0,lego_length*2+space/8*lego_length,0])
    xbyy_brick(1,1,lego_block_height/3);
    
    translate([lego_length+space/8*lego_length,lego_length*2+space/8*lego_length,0])
    xbyy_brick(1,1,lego_block_height/3);
    
    translate([lego_length*2+2*space/8*lego_length,lego_length*2+space/8*lego_length,0])
    xbyy_brick(1,1,lego_block_height/3);
    
    translate([lego_length*3+3*space/8*lego_length,lego_length*2+space/8*lego_length,0])
    xbyy_brick(1,1,lego_block_height/3);
    
    }
    
    color([0.0,0.0,0.8,0.6]){
    translate([0,lego_length*3+2*space/8*lego_length,0])
    lego_round_brick(lego_block_height/3);
    
    translate([lego_length+space/8*lego_length,lego_length*3+2*space/8*lego_length,0])
    lego_round_brick(lego_block_height/3);
    
    translate([lego_length*2+2*space/8*lego_length,lego_length*3+2*space/8*lego_length,0])
    lego_round_brick(lego_block_height/3);
    
    translate([lego_length*3+3*space/8*lego_length,lego_length*3+2*space/8*lego_length,0])
    lego_round_brick(lego_block_height/3);
    }
}


module print_just_gems(){
    space=2.5;
    
    color([0.0,0.0,0.8,0.6]){
    translate([0,0,0])
    lego_round_brick(lego_block_height/3);
    
    translate([0,lego_length+1*space/8*lego_length,0])
    lego_round_brick(lego_block_height/3);
    
    translate([lego_length+1*space/8*lego_length,0,0])
    lego_round_brick(lego_block_height/3);
    
    translate([lego_length+1*space/8*lego_length,lego_length+1*space/8*lego_length,0])
    lego_round_brick(lego_block_height/3);
    }
    
}

module print_just_rocks(){
    space=2.5;
        
    color([0.75,0.75,0.75,1.0]){
    xbyy_brick(2,2,lego_block_height/3);
    
    translate([lego_length*2+space/8*lego_length,0,0])
    twobytwo_centerknob(lego_block_height/3);
        
    translate([0,lego_length*2+1*space/8*lego_length,0])
    xbyy_brick(1,1,lego_block_height/3);
    
    translate([lego_length+1*space/8*lego_length,lego_length*2+1*space/8*lego_length,0])
    xbyy_brick(1,1,lego_block_height/3);
    
    translate([lego_length*2+2*space/8*lego_length,lego_length*2+1*space/8*lego_length,0])
    xbyy_brick(1,1,lego_block_height/3);
    
    translate([lego_length*3+3*space/8*lego_length,lego_length*2+1*space/8*lego_length,0])
    xbyy_brick(1,1,lego_block_height/3);
    }
}

module build_oreblock(){
    
    color([0.75,0.75,0.75,1.0]){
    xbyy_brick(2,2,lego_block_height/3);
    
    translate([0,0,lego_block_height])
    twobytwo_centerknob(lego_block_height/3);
    
    translate([0,lego_length,lego_block_height/3])
    
        translate([lego_length/2,lego_length/2,0])
    rotate([0,0,rands(-5,5,1)[0]])
        translate([-lego_length/2,-lego_length/2,0])
    xbyy_brick(1,1,lego_block_height/3);
    
    translate([lego_length,0,lego_block_height/3])
    
        translate([lego_length/2,lego_length/2,0])
    rotate([0,0,rands(-15,15,1)[0]])
        translate([-lego_length/2,-lego_length/2,0])
    xbyy_brick(1,1,lego_block_height/3);
    
    translate([0,0,lego_block_height/3*2])
    
        translate([lego_length/2,lego_length/2,0])
    rotate([0,0,rands(-15,15,1)[0]])
        translate([-lego_length/2,-lego_length/2,0])
    xbyy_brick(1,1,lego_block_height/3);
    
    translate([lego_length,lego_length,lego_block_height/3*2])
        translate([lego_length/2,lego_length/2,0])
    rotate([0,0,rands(-15,15,1)[0]])
        translate([-lego_length/2,-lego_length/2,0])
    xbyy_brick(1,1,lego_block_height/3);
    
    }
    
    color([0.0,0.0,0.8,0.6]){
    translate([0,0,lego_block_height/3])
    lego_round_brick(lego_block_height/3);
    
    translate([lego_length,lego_length,lego_block_height/3])
    lego_round_brick(lego_block_height/3);
    
    translate([0,lego_length,lego_block_height/3*2])
    lego_round_brick(lego_block_height/3);
    
    translate([lego_length,0,lego_block_height/3*2])
    lego_round_brick(lego_block_height/3);
    }
}

//print_just_gems();
//print_just_rocks();
//print_oreblock();

for (z=[0:0]){
for (x=[0:0]){
    translate([x*lego_length*2*2,0,2*z*lego_block_height/3*4])
build_oreblock();
}
}

