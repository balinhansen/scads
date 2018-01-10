

build_stl=1;
big_overrides=0; // Bricks over 1:1 use different physics

inch=25.4;
// kerf=0.007*25.4;  // Too Tight at 5:1 @ 0.3mm layer height
//kerf=(0.007*25.4+0.05); // Attempt for 5:1 @ 0.3mm could be better!
kerf=big_overrides?(0.007*25.4):0; // Attempt for 5:1 @ 0.3mm GOODish! Testing!
round_kerf_adj=big_overrides?0.1:0.0035*inch;
accessory_kerf_adj=big_overrides?(kerf+0.05):0;
flat_kerf_adj=big_overrides?-0.075:0;

//kerf=0.2;



//xy_shrink=128/127; //1; // PLA == 128/127;
xy_shrink=1;

knob_fineness_stl=0.5*240;
knob_fineness_low=16;
knob_adjustment=0.0; // 0.1 for Shaxon PLA

knob_fineness=build_stl?knob_fineness_stl:knob_fineness_low;
technic_hole_adjustment=0.00;

lego_length=8; // 8/8*50;
lego_height=0.4*lego_length;
lego_block_height=1.2*lego_length;

lego_knob_height=1.8/8*lego_length;
lego_knob_width=(4.9+knob_adjustment)/8*lego_length;
lego_tube_hole=(4.9+technic_hole_adjustment)/8*lego_length+(kerf+round_kerf_adj)*2;

lego_tube=6.4137/8*lego_length-kerf; // 6.51371/8*lego_length; //6.51371/8*lego_length;

lego_accessory_hole=(3.1)/8*lego_length+(round_kerf_adj+accessory_kerf_adj)*2;
lego_accessory_peg=3.1/8*lego_length-(kerf)*2;

lego_changer_height=5.7/8*lego_length;

lego_technic_hole_height=5.8/8*lego_length;
lego_technic_hole=(4.9+technic_hole_adjustment)/8*lego_length+(kerf+round_kerf_adj)*2;
lego_technic_hole_support=7.2/8*lego_length;
lego_technic_bevel=(6.2+technic_hole_adjustment)/8*lego_length+(kerf+round_kerf_adj)*2;
lego_technic_bevel_depth=0.8/8*lego_length;
lego_technic_axle_width=4.8/8*lego_length;
lego_technic_axle_tooth=2/8*lego_length;
lego_technic_axle_stop=1.6/8*lego_length;
lego_technic_axle_stop_width=6.1/8*lego_length;

lego_technic_beam_width=7.4/8*lego_length;

lego_pad_width_spec=0.6;
lego_pad_width_adj=0.2;
lego_pad_width=(lego_pad_width_spec+lego_pad_width_adj)/8*lego_length;

lego_wall_thickness=1.2;

lego_pad_depth_spec=(8-4.9)/2-lego_wall_thickness; //0.3;
lego_pad_depth_adj=0.0;
lego_pad_depth=(lego_pad_depth_spec+lego_pad_depth_adj);
