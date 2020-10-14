include <constructionlib.scad>


module tool_shed(){

    for (i=[-1:1]){
        translate([0,(5*12*inch-two_by_four_height/2)*i])
        for (j=[-1:1]){
            translate([(5*12*inch-two_by_four_height/2)*j,0])
            deck_block();
        }
    }

    // wood foundation
    
    wood_color()
    translate([-60*inch,0,6*inch])
    for (i=[-1,1]){
        translate([0,(5*12*inch-1*inch)*i-two_by_four_height/2,0])
        cube(size=[10*12*inch,two_by_four_height,two_by_four_width]);
    }

    wood_color_b()
    for (i=[-1:1]){
        translate([(5*12*inch-two_by_four_height/2)*i-two_by_four_height/2,-5*12*inch+two_by_four_height,6*inch])
        cube(size=[two_by_four_height,10*12*inch-two_by_four_height*2,two_by_four_width]);
    }

    wood_color_b()
    for (i=[-3,-2,-1,1,2,3]){
        translate([(16*inch)*i,-5*12*inch+two_by_four_height,6*inch])
        cube(size=[two_by_four_height,10*12*inch-two_by_four_height*2,two_by_four_width]);
    }

/*
    // floor insulation subfloor
    wood_color_c()
    translate([-4*12*inch,-4*12*inch,6*inch+two_by_four_width])
    cube([4*12*inch,8*12*inch,0.75*inch]);
    wood_color_c()
    translate([0,-4*12*inch,6*inch+two_by_four_width])
    cube([4*12*inch,8*12*inch,0.75*inch]);
*/

    // floor joists
    
    wood_color()
    translate([-5*12*inch,-5*12*inch+two_by_four_height,6*inch+two_by_four_width+0.75*inch])
    for (i=[0:7]){
        translate([16*inch*i,0,0])
        cube(size=[two_by_four_height,10*12*inch-two_by_four_height*2,two_by_four_width]);
    }
    wood_color()
    translate([5*12*inch-two_by_four_height,-5*12*inch+two_by_four_height,6*inch+two_by_four_width+0.75*inch])
    cube(size=[two_by_four_height,10*12*inch-two_by_four_height*2,two_by_four_width]);
    
    wood_color_b()
    for (i=[-1,1]){
        translate([-5*12*inch,(5*12*inch-two_by_four_height/2)*i,6*inch+two_by_four_width+0.75*inch])
        translate([0,-two_by_four_height/2])
    cube(size=[10*12*inch,two_by_four_height,two_by_four_width]);
    }
    
    // floor insulation
    /*
    translate([-4*12*inch,-4*12*inch+two_by_four_height,6*inch+two_by_four_width+0.75*inch])
    for (i=[0:4]){
        translate([2*inch-(2*inch-two_by_four_height)/2+16*inch*i,0,0])
        flat_batt(15*inch, 8*12*inch-two_by_four_height*2,2*inch);
    }
    pink_panther()
    translate([4*12*inch-4*inch-(2*inch-two_by_four_height)/2,-4*12*inch+two_by_four_height,6*inch+two_by_four_width+0.75*inch])
    flat_batt(96*inch-two_by_four_height*2-(2*inch-two_by_four_height)-18*5*inch,8*12*inch-two_by_four_height*2,2*inch);
    */
    
    
    // subfloor
    /*
    wood_color_c()
    translate([-4*12*inch,-4*12*inch,6*inch+two_by_four_width*2+0.75*inch])
    cube([4*12*inch,8*12*inch,0.75*inch]);
    wood_color_c()
    translate([0,-4*12*inch,6*inch+two_by_four_width*2+0.75*inch])
    cube([4*12*inch,8*12*inch,0.75*inch]);
*/
    
    
    // wall plates
    wood_color()
    for (i=[-1,1]){
        translate([-5*12*inch,-two_by_four_width/2+(5*12*inch-two_by_four_width/2)*i,6*inch+two_by_four_width*2+0.75*inch*2])
        cube(size=[10*12*inch,two_by_four_width,two_by_four_height]);
    }

    wood_color_b()
    for (i=[-1,1]){
        translate([-two_by_four_width/2+(5*12*inch-two_by_four_width/2)*i,-5*12*inch+two_by_four_width,6*inch+two_by_four_width*2+0.75*inch*2])
        cube(size=[two_by_four_width,10*12*inch-two_by_four_width*2,two_by_four_height]);
    }

    // wall corners 
    translate([0,0,6*inch+0.75*inch*2+two_by_four_width*2+two_by_four_height]){
        
    translate([-5*12*inch,-5*12*inch,0])
    three_stud_corner(8*12*inch);
       
    translate([5*12*inch,-5*12*inch,0])
        mirror([1,0,0]) //rotate([0,0,90])
    three_stud_corner(8*12*inch);
        
    translate([-5*12*inch,5*12*inch,0])
        mirror([0,1,0])
    three_stud_corner(8*12*inch);
       
    translate([5*12*inch,5*12*inch,0])
        mirror([0,1,0])
        mirror([1,0,0]) //rotate([0,0,90])
    three_stud_corner(8*12*inch);
    
    }
    
    // front wall
    
    
    // door frame
    translate([5*12*inch-two_by_four_width,(60)/2*inch,6*inch+two_by_four_width*2+0.75*inch*2+two_by_four_height])
    rotate([0,0,-90])
    door_frame(82*inch,36*inch,two_by_four_width,8*12*inch,4);
    
    front_wall_width=(10*12*inch-2*(two_by_four_width+two_by_four_height)-36*inch-two_by_four_height*4-2*inch)/2;
    
   
    translate([5*12*inch,-(60)/2*inch+two_by_four_width+two_by_four_height,6*inch+0.75*inch*2+two_by_four_width*2+two_by_four_height])
    rotate([0,0,90])
    window(8*12*inch, 2*12*inch, 36*inch, 36*inch, 3);
    
    
    /*
    translate([36*inch/2+inch+two_by_four_height*2+front_wall_width/2,4*12*inch-two_by_four_width,6*inch+0.75*inch*2+two_by_four_width*2+two_by_four_height])
    auto_studs(8*12*inch,front_wall_width,two_by_four_width,stud_spacing,false);
    
    translate([-36*inch/2-inch-two_by_four_height*2-front_wall_width/2,4*12*inch-two_by_four_width,6*inch+0.75*inch*2+two_by_four_width*2+two_by_four_height])
    auto_studs(8*12*inch,front_wall_width,two_by_four_width,stud_spacing,false);
    
    */
    
    sill_plate_height=6*inch+0.75*inch*2+two_by_four_width*2+two_by_four_height;
    
    // rear wall
    
    translate([-5*12*inch,0,6*inch+0.75*inch*2+two_by_four_width*2+two_by_four_height])
    rotate([0,0,-90])
    auto_studs(8*12*inch,8*12*inch-two_by_four_width*2-two_by_four_height*2,two_by_four_width,stud_spacing,false);
    
    // left wall
    
    left_walls_length=(10*12*inch-2*12*inch-two_by_four_height*4-two_by_four_height*2-two_by_four_width*2)/2;
    
    translate([-5*12*inch,-5*12*inch,sill_plate_height])
    translate([left_walls_length/2+two_by_four_height+two_by_four_width,0,0])
    auto_studs(8*12*inch,left_walls_length,two_by_four_width,stud_spacing,false);
    
    translate([0,-5*12*inch,6*inch+0.75*inch*2+two_by_four_width*2+two_by_four_height])
    window(8*12*inch, 2*12*inch, 36*inch, 36*inch, 3);
    
    
    translate([5*12*inch,-5*12*inch,sill_plate_height])
    
    translate([-left_walls_length/2-two_by_four_height-two_by_four_width,0,0])
    auto_studs(8*12*inch,left_walls_length,two_by_four_width,stud_spacing,false);
    
    
    // right wall
    
    right_walls_length=(10*12*inch-2*12*inch-two_by_four_height*4-two_by_four_height*2-two_by_four_width*2)/2;
    
    translate([-5*12*inch,5*12*inch-two_by_four_width,sill_plate_height])
    translate([right_walls_length/2+two_by_four_height+two_by_four_width,0,0])
    auto_studs(8*12*inch,right_walls_length,two_by_four_width,stud_spacing,false);
    
    
    translate([0,5*12*inch-two_by_four_width,6*inch+0.75*inch*2+two_by_four_width*2+two_by_four_height])
    window(8*12*inch, 2*12*inch, 36*inch, 36*inch, 3);
    
    
    translate([5*12*inch,5*12*inch-two_by_four_width,sill_plate_height])
    translate([-left_walls_length/2-two_by_four_height-two_by_four_width,0,0])
    auto_studs(8*12*inch,right_walls_length,two_by_four_width,stud_spacing,false);
    
    
    // top plate (first row)
    
    for (i=[-1,1]){
        random_wood()
        translate([-5*12*inch,i*(5*12*inch-two_by_four_width/2), 6*inch+0.75*inch*2+two_by_four_width*2+two_by_four_height+8*12*inch])
        translate([0,-two_by_four_width/2,0])
        cube([10*12*inch,two_by_four_width,two_by_four_height]);
        
        random_wood()        
        translate([i*(5*12*inch-two_by_four_width/2),-5*12*inch+two_by_four_width, 6*inch+0.75*inch*2+two_by_four_width*2+two_by_four_height+8*12*inch])
        translate([-two_by_four_width/2,0,0])
        cube(size=[two_by_four_width,10*12*inch-two_by_four_width*2,two_by_four_height]);
        
        // double top plate
       
        random_wood()
        translate([i*(5*12*inch-two_by_four_width/2),-5*12*inch, 6*inch+0.75*inch*2+two_by_four_width*2+two_by_four_height*2+8*12*inch])
        translate([-two_by_four_width/2,0,0])
        cube([two_by_four_width,10*12*inch,two_by_four_height]);
        
        random_wood()
        translate([-5*12*inch+two_by_four_width,i*(5*12*inch-two_by_four_width/2), 6*inch+0.75*inch*2+two_by_four_width*2+two_by_four_height*2+8*12*inch])
        translate([0,-two_by_four_width/2,0])
        cube(size=[10*12*inch-two_by_four_width*2,two_by_four_width,two_by_four_height]);
        
    }
    
    // ceiling joists
    
    for (i=[0:floor((10*12*inch/2-8*inch-two_by_four_width*2)/(16*inch))]){
        random_wood()
        translate([8*inch+16*inch*i+two_by_four_height,-5*12*inch,6*inch+0.75*inch*2+two_by_four_width*2+two_by_four_height*3+8*12*inch])
        translate([-two_by_four_height/2,0,0])
        cube([two_by_four_height, 10*12*inch,two_by_six_width]);
    
        random_wood()
        translate([-8*inch-16*inch*i-two_by_four_height,-5*12*inch,6*inch+0.75*inch*2+two_by_four_width*2+two_by_four_height*3+8*12*inch])
        translate([-two_by_four_height/2,0,0])
        cube([two_by_four_height, 10*12*inch,two_by_six_width]);
    
    }
    
        
        
    //roof ridge
    
    
    roof_angle=90-56;
    overhang=12*inch-1.5625*inch;
    projected_length=5*12*inch+overhang-two_by_four_height/2;
    
    birds_mouth=2.25*inch;
    birds_mouth_length=birds_mouth/cos(roof_angle);
    birds_mouth_depth=birds_mouth_length*sin(roof_angle);
    
    birds_mouth_actual=birds_mouth_depth*cos(roof_angle);
    
    echo(concat("Birds mouth cut: ",imp_frac(birds_mouth_actual/25.4)," is ",ceil(100*birds_mouth_actual/(5.5625*inch)),"% of board width."));
    
    echo(concat("Rafter board dips below joint corner by ",(5.5625*inch)-(((5.5625*inch)/cos(roof_angle))-birds_mouth_depth), "mm."));
    
    echo(birds_mouth/25.4);
    min_ridge=two_by_six_width/cos(roof_angle);
    
    echo(concat("Minimum Ridge Beam: ",min_ridge/25.4));
       
    echo(concat("Rafter board minimum: ",(projected_length+sin(roof_angle)*two_by_six_width)/cos(roof_angle)/25.4/12));
    
    /*
    echo(concat("Birdsmouth Cut A: ",roof_angle," degrees ",birds_mouth/25.4*16," sixteenths at ",(projected_length/cos(roof_angle)-birds_mouth_length)/25.4," inches"));
    echo(concat("Birdsmouth Cut B: ",90-roof_angle," degrees ", birds_mouth_depth/25.4*16," sixteenths at ",projected_length/cos(roof_angle)/25.4," inches."));
    echo(concat("Birds mouth true depth at ",birds_mouth_actual));
    */
    
    
    roof_ridge_height=(5*12*inch-two_by_four_height/2)*tan(roof_angle)-birds_mouth_depth;
    
    rafter_cut=sqrt(pow(two_by_four_width,2)+pow(tan(roof_angle)*two_by_four_width,2));
    
    random_wood()
    translate([-5*12*inch-overhang,-two_by_four_height/2,6*inch+0.75*inch*2+two_by_four_width*2+two_by_four_height*3+8*12*inch+roof_ridge_height+min_ridge-two_by_ten_width])
    cube([10*12*inch+overhang*2,two_by_four_height,two_by_ten_width]);
    
    // verge plates
    
    verge_length=(5*12*inch-two_by_four_height/2-birds_mouth)/cos(roof_angle);
    
    echo(concat("Place verge plate at ",imp_frac((two_by_ten_width-(two_by_six_width+two_by_four_height)/cos(roof_angle))/25.4)));
    echo(concat("Verge plate board is ",imp_frac((5*12*inch-two_by_four_height/2-birds_mouth)/cos(roof_angle)/25.4)," inches."));
    
    for (i=[-1,1]){
        random_wood()
        translate([-i*(5*12*inch-two_by_six_width/2),two_by_four_height/2,6*inch+0.75*inch*2+two_by_four_width*2+two_by_four_height*3+8*12*inch+roof_ridge_height-two_by_four_height/cos(roof_angle)])
        rotate([-roof_angle,0,0])
        translate([-two_by_six_width/2,-tan(roof_angle)*two_by_four_height,0])
        difference(){
            cube([two_by_six_width,(5*12*inch-two_by_four_height/2-birds_mouth)/cos(roof_angle),two_by_four_height]);
            
            // plumb cut
            color([1,0,0,1])
            translate([0,tan(roof_angle)*two_by_four_height,0])
            rotate([roof_angle,0,0])
            translate([-1,-1-tan(roof_angle)*two_by_four_height,-1])
            
            cube([two_by_six_width+2,tan(roof_angle)*two_by_four_height+1,tan(roof_angle)*two_by_four_height/sin(roof_angle)+2]);
            
            // seat cut
            color([0,0,1,1])
            translate([0,(5*12*inch-two_by_four_height/2-birds_mouth)/cos(roof_angle)-two_by_four_height/tan(roof_angle),0])
            rotate([roof_angle,0,0])
            translate([-0.1,-0.1,-0.1-two_by_four_height*cos(roof_angle)])
            
            cube([two_by_six_width+0.2,two_by_four_height/sin(roof_angle)+0.2,two_by_four_height*cos(roof_angle)+0.1]);
        }
        
        random_wood()
        translate([-i*(5*12*inch-two_by_six_width/2),-two_by_four_height/2,6*inch+0.75*inch*2+two_by_four_width*2+two_by_four_height*3+8*12*inch+roof_ridge_height-two_by_four_height/cos(roof_angle)])
        mirror([0,1,0])
        rotate([-roof_angle,0,0])
        translate([-two_by_six_width/2,-tan(roof_angle)*two_by_four_height,0])
        difference(){
            cube([two_by_six_width,(5*12*inch-two_by_four_height/2-birds_mouth)/cos(roof_angle),two_by_four_height]);
            
            // plumb cut
            color([1,0,0,1])
            translate([0,tan(roof_angle)*two_by_four_height,0])
            rotate([roof_angle,0,0])
            translate([-1,-1-tan(roof_angle)*two_by_four_height,-1])
            
            cube([two_by_six_width+2,tan(roof_angle)*two_by_four_height+1,tan(roof_angle)*two_by_four_height/sin(roof_angle)+2]);
            
            // seat cut
            color([0,0,1,1])
            translate([0,(5*12*inch-two_by_four_height/2-birds_mouth)/cos(roof_angle)-two_by_four_height/tan(roof_angle),0])
            rotate([roof_angle,0,0])
            translate([-0.1,-0.1,-0.1-two_by_four_height*cos(roof_angle)])
            
            cube([two_by_six_width+0.2,two_by_four_height/sin(roof_angle)+0.2,two_by_four_height*cos(roof_angle)+0.1]);
        }
    }
    
    // gable post
    
    echo(concat("Gable post is ",imp_frac((roof_ridge_height+min_ridge-two_by_ten_width)/25.4)," inches."));
    for (i=[-1,1]){
        random_wood()
        translate([-i*(5*12*inch-two_by_six_width/2),0,6*inch+0.75*inch*2+two_by_four_width*2+two_by_four_height*3+8*12*inch])
        translate([-two_by_six_width/2,-two_by_four_height/2,0])
        cube([two_by_six_width,two_by_four_height,roof_ridge_height+min_ridge-two_by_ten_width]);
    }
    
    
    bmsc=(5*12*inch+sin(roof_angle)*two_by_six_width-two_by_four_height/2)/cos(roof_angle)-birds_mouth/cos(roof_angle);
    
    echo(concat("Bird's mouth seat cut at ",imp_frac(bmsc/25.4)," inches."));
    
    echo(concat("Bird's mouth flush cut at ",imp_frac((bmsc+(birds_mouth/cos(roof_angle)))/25.4)," inches."));
    
    mirror([0,1,0])
    translate([-5*12*inch-overhang-inch,0,6*inch+0.75*inch*2+two_by_four_width*2+two_by_four_height*3+8*12*inch+roof_ridge_height])
    rotate([-roof_angle,0,0])
    translate([0,-sin(roof_angle)*two_by_six_width,0])
    cube([inch,bmsc,inch]);
    
    // auto rafters
    
    for (i=[0:floor((10*12*inch/2-8*inch-two_by_four_width*2)/(16*inch))]){
            
        random_wood()
        translate([i*(16*inch)+8*inch,0,6*inch+0.75*inch*2+two_by_four_width*2+two_by_four_height*3+8*12*inch+roof_ridge_height])
        rafter_board(5*12*inch+overhang-two_by_four_height/2,90-56,overhang,birds_mouth);
            
        random_wood()
        translate([i*(16*inch)+8*inch,0,6*inch+0.75*inch*2+two_by_four_width*2+two_by_four_height*3+8*12*inch+roof_ridge_height])
        mirror([0,1,0])
        rafter_board(5*12*inch+overhang-two_by_four_height/2,90-56,overhang,birds_mouth);
        
        
        random_wood()
        translate([-i*(16*inch)-8*inch,0,6*inch+0.75*inch*2+two_by_four_width*2+two_by_four_height*3+8*12*inch+roof_ridge_height])
        rafter_board(5*12*inch+overhang-two_by_four_height/2,90-56,overhang,birds_mouth);
        
        random_wood()    
        translate([-i*(16*inch)-8*inch,0,6*inch+0.75*inch*2+two_by_four_width*2+two_by_four_height*3+8*12*inch+roof_ridge_height])
        mirror([0,1,0])
        
        rafter_board(5*12*inch+overhang-two_by_four_height/2,90-56,overhang,birds_mouth);
    }
            
    // ending rafters
    
    for (i=[-1,1]){
        
        random_wood()
        translate([(5*12*inch-two_by_four_height/2)*i,0,6*inch+0.75*inch*2+two_by_four_width*2+two_by_four_height*3+8*12*inch+roof_ridge_height])
        rafter_board(5*12*inch+overhang-two_by_four_height/2,90-56,overhang,birds_mouth);
    
        random_wood()
        translate([(5*12*inch-two_by_four_height/2)*i,0,6*inch+0.75*inch*2+two_by_four_width*2+two_by_four_height*3+8*12*inch+roof_ridge_height])
        mirror([0,1,0])
        rafter_board(5*12*inch+overhang-two_by_four_height/2,90-56,overhang,birds_mouth);
    
    }

    // barge boards (facsia)
    
    for (i=[-1,1]){
        random_wood()
        translate([(5*12*inch+overhang-two_by_four_height/2)*i,0,6*inch+0.75*inch*2+two_by_four_width*2+two_by_four_height*3+8*12*inch+roof_ridge_height])
        rafter_board(5*12*inch+overhang-two_by_four_height/2,90-56,overhang,birds_mouth);
    
        random_wood()
        translate([(5*12*inch+overhang-two_by_four_height/2)*i,0,6*inch+0.75*inch*2+two_by_four_width*2+two_by_four_height*3+8*12*inch+roof_ridge_height])
        mirror([0,1,0])
        rafter_board(5*12*inch+overhang-two_by_four_height/2,90-56,overhang,birds_mouth);
    }

        
    // mattress (lol)
    translate([-(60-40)*inch+two_by_four_width,-(60-30)*inch+two_by_four_width,6*inch+two_by_four_width*2+0.75*inch*2])
    mattress(80*inch,60*inch, 12*inch);


}



translate([18.5*12*inch,property_length*12*inch-129.6*12*inch,0])
tool_shed();