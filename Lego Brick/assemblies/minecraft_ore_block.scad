include <../libraries/legobrick_vars.scad>;
include <../libraries/legobrick_lib.scad>;

echo("Lego Ore Block loaded ...");

lego_length=16;
big_overrides=1; // Brick over 1:1 scale

module oreblock_print(){
    space=2.5;
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
    
    
    translate([0,lego_length*3+2*space/8*lego_length,0])
    lego_round_brick(lego_block_height/3);
    
    translate([lego_length+space/8*lego_length,lego_length*3+2*space/8*lego_length,0])
    lego_round_brick(lego_block_height/3);
    
    translate([lego_length*2+2*space/8*lego_length,lego_length*3+2*space/8*lego_length,0])
    lego_round_brick(lego_block_height/3);
    
    translate([lego_length*3+3*space/8*lego_length,lego_length*3+2*space/8*lego_length,0])
    lego_round_brick(lego_block_height/3);
    
}

oreblock_print();