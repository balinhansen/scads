include <../libraries/legobrick_vars.scad>;
include <../libraries/legobrick_lib.scad>;
include <tests_lib.scad>;

echo("Legobrick test batches loaded");

lego_length=16;
// Brick Tests

//xbyy_brick(1,1,lego_block_height/3);
//translate([-lego_length/2,0,1.5*lego_block_height/3])
//xbyy_brick(2,1,lego_block_height/3);

//translate([0,0,-1.5*lego_block_height/3])
//xbyy_brick(2,2,lego_block_height/3);

//lego_badge(8,8,lego_block_height/3);


//x_technic_brick(4,lego_block_height);

//lego_technic_axle_stopped(3,1);

//minkowski(){
  //  lego_technic_axle_end();
   // sphere(0.1/8*lego_length,$fn=knob_fineness);
//}

//lego_technic_beam(3);


//xbyy_brick(2,2,lego_block_height/3);



// Fit Tests

//brick_test();
//technic_test();



// Print Tests

//brick_test_print();

//scale([xy_shrink,xy_shrink,1])
//print_test_full();

//print_callibration_test(10);


