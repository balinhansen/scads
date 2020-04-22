inch=25.4;
gap=10; // visual aid
stud_spacing_inches=18;

building_height=14;
building_width=25;
building_length=55;

property_size=45738;
property_width=152;
property_length=301;
two_by_four_width_inches=3.75;
two_by_four_height_inches=1.75;
pier_width_inches=12;

pier_max_distances=12*8*inch;
pier_min_distance=pier_width_inches*inch*2.5;
pier_fineness=60;

bracket_width_inches=1;
bracket_fineness=24;
bracket_stock_inches=0.25;

block_length_inches=15.625;
block_width_inches=7.625;
block_height_inches=7.625;

slab_length_inches=24;
slab_width_inches=24;
slab_height_inches=8;


side_setback=building_height<14?10:building_height-4;
front_setback=building_height+10;

echo(concat("Sideyard Setbacks: ",side_setback));
echo(concat("Front/Backyard Setbacks:", front_setback));

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

opacity=1;

module wood_color(){
    color([0.94,0.89,0.69,opacity])
    children();
}
module wood_color_b(){
    color([0.88,0.83,0.66,opacity])
    children();
}

module wood_color_c(){
    color([0.94,0.87,0.59,opacity])
    children();
}

module random_wood(){
    color=floor(rands(0,3,1)[0]);
    if (color==0){
        wood_color()
        children();
    }
    if (color==1){
        wood_color_b()
        children();
    }
    if (color==2){
        wood_color_c()
        children();
    }
}


module treated(){
    color([0.8,0.3,0.1,opacity])
    children();
}

module pink_panther(){
    color([1,0.8,0.8,opacity])
    children();
}

module concrete(){
    color([0.8,0.8,0.8,opacity])
    children();
}

module flat_batt(width,height,thickness){
    pink_panther()
    cube(size=[width,height,thickness]);    
}

module wall_batt(width,height,thickness){
    pink_panther()
    cube(size=[width,thickness,height]);    
}


module pier(depth,width=pier_width){
    concrete()
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
    concrete()
    cube([block_length,block_width,block_height]);
}

module cap(){
    concrete()
    cube([16*inch,16*inch,16*inch]);
}

module slab(){
    concrete()
    translate([-slab_length/2,-slab_width/2,-slab_height])
    cube([slab_length,slab_width,slab_height]);
}

module post_hole(length,width,height){
    concrete()
    translate([0,0,height])
    pier(length,width);
}

module woodpost(height,length,width,depth){
    translate([-length/2,-width/2,depth])
    cube([length,width,height]);
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
            translate([0,block_width+gap,0])
            block();
        }
    }
    translate([0,0,-length+height])
    slab();
}


module deck_block(){
    color([0.8,0.8,0.8,1]){
        translate([-10.75*inch/2,-10.75*inch/2])
        cube(size=[10.75*inch,10.75*inch,inch]);
        difference(){
            translate([0,0,inch])
            linear_extrude(height=6.75*inch, scale=0.75, convexity=10)
            translate([-10.75*inch/2,-10.75*inch/2])
            square(size=[10.75*inch,10.75*inch]);
            
            translate([-2*inch,-2*inch,6*inch])
            cube(size=[4*inch,4*inch,2*inch]);
            
            translate([-6.5*inch,-inch,6*inch])
            cube(size=[11*inch,2*inch,2*inch]);
            
            translate([-inch,-6.5*inch,6*inch])
            cube(size=[2*inch,11*inch,2*inch]);
        }
    }
}



module mattress(mattress_width,mattress_length,mattress_depth){
    r=5*inch;
    color([0.8,0.8,1])
        
    translate([-mattress_width/2,-mattress_length/2,0])
    hull(){
        translate([r,r,0])
        cylinder(mattress_depth,r,r,$fn=18);
        
        translate([mattress_width-r,r,0])
        cylinder(mattress_depth,r,r,$fn=18);
        
        translate([r,mattress_length-r,0])
        cylinder(mattress_depth,r,r,$fn=18);
        
        translate([mattress_width-r,mattress_length-r,0])
        cylinder(mattress_depth,r,r,$fn=18);
    }
}

module auto_studs(height, width, thickness, spacing,center){
        if (center){
            translate([-two_by_four_height/2,0,0])
            random_wood()
            cube(size=[two_by_four_height,thickness,height]);
        }else{
            for (i=[0:floor((width/2)/spacing)-1]){
                random_wood()
                translate([-spacing/2-two_by_four_height/2-i*spacing,0,0])
                cube(size=[two_by_four_height,thickness,height]);
              
                random_wood()
                translate([spacing/2-two_by_four_height/2+i*spacing,0,0])
                cube(size=[two_by_four_height,thickness,height]);
            }
        }
}

module tool_shed(){

    for (i=[-1:1]){
        translate([0,(4*12*inch-two_by_four_height/2)*i])
        for (j=[-1:1]){
            translate([(4*12*inch-two_by_four_height/2)*j,0])
            deck_block();
        }
    }

    wood_color()
    translate([-48*inch,0,6*inch])
    for (i=[-1,1]){
        translate([0,(4*12*inch-1*inch)*i-two_by_four_height/2,0])
        cube(size=[8*12*inch,two_by_four_height,two_by_four_width]);
    }

    wood_color_b()
    for (i=[-1:1]){
        translate([(4*12*inch-two_by_four_height/2)*i-two_by_four_height/2,-4*12*inch+two_by_four_height,6*inch])
        cube(size=[two_by_four_height,8*12*inch-two_by_four_height*2,two_by_four_width]);
    }

    wood_color_b()
    for (i=[-2,-1,1,2]){
        translate([(16*inch)*i,-4*12*inch+two_by_four_height,6*inch])
        cube(size=[two_by_four_height,8*12*inch-two_by_four_height*2,two_by_four_width]);
    }

    // floor insulation subfloor
    wood_color_c()
    translate([-4*12*inch,-4*12*inch,6*inch+two_by_four_width])
    cube([4*12*inch,8*12*inch,0.75*inch]);
    wood_color_c()
    translate([0,-4*12*inch,6*inch+two_by_four_width])
    cube([4*12*inch,8*12*inch,0.75*inch]);

    wood_color()
    translate([-4*12*inch,-4*12*inch+two_by_four_height,6*inch+two_by_four_width+0.75*inch])
    for (i=[0:5]){
        translate([18*inch*i,0,0])
        cube(size=[two_by_four_height,8*12*inch-two_by_four_height*2,two_by_four_width]);
    }
    wood_color()
    translate([4*12*inch-two_by_four_height,-4*12*inch+two_by_four_height,6*inch+two_by_four_width+0.75*inch])
    cube(size=[two_by_four_height,8*12*inch-two_by_four_height*2,two_by_four_width]);
    
    wood_color_b()
    for (i=[-1,1]){
        translate([-4*12*inch,(4*12*inch-two_by_four_height/2)*i,6*inch+two_by_four_width+0.75*inch])
        translate([0,-two_by_four_height/2])
    cube(size=[8*12*inch,two_by_four_height,two_by_four_width]);
    }
    
    // floor insulation
    
    translate([-4*12*inch,-4*12*inch+two_by_four_height,6*inch+two_by_four_width+0.75*inch])
    for (i=[0:4]){
        translate([2*inch-(2*inch-two_by_four_height)/2+18*inch*i,0,0])
        flat_batt(16*inch, 8*12*inch-two_by_four_height*2,2*inch);
    }
    pink_panther()
    translate([4*12*inch-4*inch-(2*inch-two_by_four_height)/2,-4*12*inch+two_by_four_height,6*inch+two_by_four_width+0.75*inch])
    flat_batt(96*inch-two_by_four_height*2-(2*inch-two_by_four_height)-18*5*inch,8*12*inch-two_by_four_height*2,2*inch);
    
    // subfloor
    
    wood_color_c()
    translate([-4*12*inch,-4*12*inch,6*inch+two_by_four_width*2+0.75*inch])
    cube([4*12*inch,8*12*inch,0.75*inch]);
    wood_color_c()
    translate([0,-4*12*inch,6*inch+two_by_four_width*2+0.75*inch])
    cube([4*12*inch,8*12*inch,0.75*inch]);

    
    // wall plates
    wood_color()
    for (i=[-1,1]){
        translate([-4*12*inch,-two_by_four_width/2+(4*12*inch-two_by_four_width/2)*i,6*inch+two_by_four_width*2+0.75*inch*2])
        cube(size=[8*12*inch,two_by_four_width,two_by_four_height]);
    }

    wood_color_b()
    for (i=[-1,1]){
        translate([-two_by_four_width/2+(4*12*inch-two_by_four_width/2)*i,-4*12*inch+two_by_four_width,6*inch+two_by_four_width*2+0.75*inch*2])
        cube(size=[two_by_four_width,8*12*inch-two_by_four_width*2,two_by_four_height]);
    }

    // wall corners 
    translate([0,0,6*inch+0.75*inch*2+two_by_four_width*2+two_by_four_height]){
        
    translate([-4*12*inch,-4*12*inch,0])
    three_stud_corner(8*12*inch);
       
    translate([4*12*inch,-4*12*inch,0])
        mirror([1,0,0]) //rotate([0,0,90])
    three_stud_corner(8*12*inch);
        
    translate([-4*12*inch,4*12*inch,0])
        mirror([0,1,0])
    three_stud_corner(8*12*inch);
       
    translate([4*12*inch,4*12*inch,0])
        mirror([0,1,0])
        mirror([1,0,0]) //rotate([0,0,90])
    three_stud_corner(8*12*inch);
    
    }
    
    // front wall
    
    
    // door frame
    translate([0,4*12*inch-two_by_four_width,6*inch+two_by_four_width*2+0.75*inch*2+two_by_four_height])
    door_frame(80*inch,36*inch,two_by_four_width,8*12*inch,4);
    
    front_wall_width=(8*12*inch-2*(two_by_four_width+two_by_four_height)-36*inch-two_by_four_height*4-2*inch)/2;
    
   
    translate([36*inch/2+inch+two_by_four_height*2+front_wall_width/2,4*12*inch-two_by_four_width,6*inch+0.75*inch*2+two_by_four_width*2+two_by_four_height])
    auto_studs(8*12*inch,front_wall_width,two_by_four_width,18*inch,false);
    
    translate([-36*inch/2-inch-two_by_four_height*2-front_wall_width/2,4*12*inch-two_by_four_width,6*inch+0.75*inch*2+two_by_four_width*2+two_by_four_height])
    auto_studs(8*12*inch,front_wall_width,two_by_four_width,18*inch,false);
    
    
    // rear wall
    
    translate([0,-4*12*inch,6*inch+0.75*inch*2+two_by_four_width*2+two_by_four_height])
    auto_studs(8*12*inch,8*12*inch-two_by_four_width*2-two_by_four_height*2,two_by_four_width,18*inch,false);
    
    // left wall
    
    translate([-4*12*inch,0,6*inch+0.75*inch*2+two_by_four_width*2+two_by_four_height])
    rotate([0,0,-90])
    window(8*12*inch, 4*12*inch, 42*inch, 36*inch, 3);
    
    
    // right wall
    translate([4*12*inch,0,6*inch+0.75*inch*2+two_by_four_width*2+two_by_four_height])
    rotate([0,0,90])
    window(8*12*inch, 4*12*inch, 42*inch, 36*inch, 3);
    
    // top plate (first row)
    
    random_wood()
    translate([-4*12*inch,-4*12*inch, 6*inch+0.75*inch*2+two_by_four_width*2+two_by_four_height+8*12*inch])
    cube([8*12*inch,two_by_four_width,two_by_four_height]);
    
    random_wood()
    translate([-4*12*inch,4*12*inch-two_by_four_width, 6*inch+0.75*inch*2+two_by_four_width*2+two_by_four_height+8*12*inch])
    cube([8*12*inch,two_by_four_width,two_by_four_height]);
    
    random_wood()
    translate([-4*12*inch,-4*12*inch+two_by_four_width, 6*inch+0.75*inch*2+two_by_four_width*2+two_by_four_height+8*12*inch])
    cube(size=[two_by_four_width,8*12*inch-two_by_four_width*2,two_by_four_height]);
    
    random_wood()
    translate([4*12*inch-two_by_four_width,-4*12*inch+two_by_four_width, 6*inch+0.75*inch*2+two_by_four_width*2+two_by_four_height+8*12*inch])
    cube(size=[two_by_four_width,8*12*inch-two_by_four_width*2,two_by_four_height]);
    
    // top plate (second row)
    
    random_wood()
    translate([-4*12*inch,-4*12*inch, 6*inch+0.75*inch*2+two_by_four_width*2+two_by_four_height*2+8*12*inch])
    cube([two_by_four_width,8*12*inch,two_by_four_height]);
    
    random_wood()
    translate([4*12*inch-two_by_four_width,-4*12*inch, 6*inch+0.75*inch*2+two_by_four_width*2+two_by_four_height*2+8*12*inch])
    cube([two_by_four_width,8*12*inch,two_by_four_height]);
    
    
    random_wood()
    translate([-4*12*inch+two_by_four_width,-4*12*inch, 6*inch+0.75*inch*2+two_by_four_width*2+two_by_four_height*2+8*12*inch])
    cube(size=[8*12*inch-two_by_four_width*2,two_by_four_width,two_by_four_height]);
    
    random_wood()
    translate([-4*12*inch+two_by_four_width,4*12*inch-two_by_four_width, 6*inch+0.75*inch*2+two_by_four_width*2+two_by_four_height*2+8*12*inch])
    cube(size=[8*12*inch-two_by_four_width*2,two_by_four_width,two_by_four_height]);
    
    
    // ceiling joists
    
    for (i=[0:floor((8*12*inch/2-8*inch)/(16*inch))-1]){
        random_wood()
        translate([-4*12*inch,8*inch-two_by_four_height/2+16*inch*i,6*inch+0.75*inch*2+two_by_four_width*2+two_by_four_height*3+8*12*inch])
        cube([8*12*inch,two_by_four_height, two_by_four_width]);
    
        random_wood()
            translate([-4*12*inch,-8*inch-two_by_four_height/2-16*inch*i,6*inch+0.75*inch*2+two_by_four_width*2+two_by_four_height*3+8*12*inch])
        cube([8*12*inch,two_by_four_height, two_by_four_width]);
    
        }
    
        //roof ridge
        roof_angle=90-56;
        birds_mouth=sin(roof_angle)*1.5*inch;
        echo(birds_mouth/25.4);
        overhang=12*inch;
        min_ridge=two_by_four_width/cos(roof_angle);
        echo(min_ridge/25.4);
        
        roof_ridge_height=(4*12*inch-two_by_four_height/2)*tan(roof_angle)-birds_mouth;
        
        rafter_cut=sqrt(pow(two_by_four_width,2)+pow(tan(roof_angle)*two_by_four_width,2));
        
        
        random_wood()
        translate([-4*12*inch-overhang,-two_by_four_height/2,6*inch+0.75*inch*2+two_by_four_width*2+two_by_four_height*3+8*12*inch+roof_ridge_height])
        cube([8*12*inch+overhang*2,two_by_four_height,min_ridge]);




    // auto rafters
    
        for (i=[0:floor((8*12*inch/2-8*inch)/(16*inch))]){
            
            random_wood()
        translate([i*(16*inch-two_by_four_height/2)+8*inch,two_by_four_height/2,6*inch+0.75*inch*2+two_by_four_width*2+two_by_four_height*3+8*12*inch+roof_ridge_height])
        rotate([-roof_angle,0,0])
        translate([-two_by_four_height/2,-tan(roof_angle)*two_by_four_width,0])
        difference(){
            cube(size=[two_by_four_height,sqrt(pow(4*12*inch+overhang,2)+pow(roof_ridge_height+birds_mouth,2)),two_by_four_width]);
            color([0,0,1,1])
            translate([-0.01,-0.01,-0.01])
            //translate([0,0,rafter_cut])
            rotate([roof_angle,0,0])
            translate([0,0,-(rafter_cut-cos(roof_angle)*two_by_four_width)])
            cube(size=[two_by_four_height+0.02,sin(roof_angle)*two_by_four_width+0.01,rafter_cut+0.02]);
        }
        
   random_wood()
        translate([i*(16*inch-two_by_four_height/2)+8*inch,-two_by_four_height/2,6*inch+0.75*inch*2+two_by_four_width*2+two_by_four_height*3+8*12*inch+roof_ridge_height])
        translate([-two_by_four_height/2,0,0])
        mirror([0,1,0])
        rotate([-roof_angle,0,0])
        translate([0,-tan(roof_angle)*two_by_four_width,0])
        difference(){
            cube(size=[two_by_four_height,sqrt(pow(4*12*inch+overhang,2)+pow(roof_ridge_height+birds_mouth,2)),two_by_four_width]);
            color([0,0,1,1])
            translate([-0.01,-0.01,-0.01])
            //translate([0,0,rafter_cut])
            rotate([roof_angle,0,0])
            translate([0,0,-(rafter_cut-cos(roof_angle)*two_by_four_width)])
            cube(size=[two_by_four_height+0.02,sin(roof_angle)*two_by_four_width+0.01,rafter_cut+0.02]);
        }
        
          
            random_wood()
        translate([-i*(16*inch-two_by_four_height/2)-8*inch,two_by_four_height/2,6*inch+0.75*inch*2+two_by_four_width*2+two_by_four_height*3+8*12*inch+roof_ridge_height])
        rotate([-roof_angle,0,0])
        translate([-two_by_four_height/2,-tan(roof_angle)*two_by_four_width,0])
        difference(){
            cube(size=[two_by_four_height,sqrt(pow(4*12*inch+overhang,2)+pow(roof_ridge_height+birds_mouth,2)),two_by_four_width]);
            color([0,0,1,1])
            translate([-0.01,-0.01,-0.01])
            //translate([0,0,rafter_cut])
            rotate([roof_angle,0,0])
            translate([0,0,-(rafter_cut-cos(roof_angle)*two_by_four_width)])
            cube(size=[two_by_four_height+0.02,sin(roof_angle)*two_by_four_width+0.01,rafter_cut+0.02]);
        }
        
   random_wood()
        translate([-i*(16*inch-two_by_four_height/2)-8*inch,-two_by_four_height/2,6*inch+0.75*inch*2+two_by_four_width*2+two_by_four_height*3+8*12*inch+roof_ridge_height])
        translate([-two_by_four_height/2,0,0])
        mirror([0,1,0])
        rotate([-roof_angle,0,0])
        translate([0,-tan(roof_angle)*two_by_four_width,0])
        difference(){
            cube(size=[two_by_four_height,sqrt(pow(4*12*inch+overhang,2)+pow(roof_ridge_height+birds_mouth,2)),two_by_four_width]);
            color([0,0,1,1])
            translate([-0.01,-0.01,-0.01])
            //translate([0,0,rafter_cut])
            rotate([roof_angle,0,0])
            translate([0,0,-(rafter_cut-cos(roof_angle)*two_by_four_width)])
            cube(size=[two_by_four_height+0.02,sin(roof_angle)*two_by_four_width+0.01,rafter_cut+0.02]);
        }
    }



    // end rafters
    
        for (i=[-1,1]){
            
            random_wood()
        translate([i*(4*12*inch-two_by_four_height/2),two_by_four_height/2,6*inch+0.75*inch*2+two_by_four_width*2+two_by_four_height*3+8*12*inch+roof_ridge_height])
        rotate([-roof_angle,0,0])
        translate([-two_by_four_height/2,-tan(roof_angle)*two_by_four_width,0])
        difference(){
            cube(size=[two_by_four_height,sqrt(pow(4*12*inch+overhang,2)+pow(roof_ridge_height+birds_mouth,2)),two_by_four_width]);
            color([0,0,1,1])
            translate([-0.01,-0.01,-0.01])
            //translate([0,0,rafter_cut])
            rotate([roof_angle,0,0])
            translate([0,0,-(rafter_cut-cos(roof_angle)*two_by_four_width)])
            cube(size=[two_by_four_height+0.02,sin(roof_angle)*two_by_four_width+0.01,rafter_cut+0.02]);
        }
        
   random_wood()
        translate([i*(4*12*inch-two_by_four_height/2),-two_by_four_height/2,6*inch+0.75*inch*2+two_by_four_width*2+two_by_four_height*3+8*12*inch+roof_ridge_height])
        translate([-two_by_four_height/2,0,0])
        mirror([0,1,0])
        rotate([-roof_angle,0,0])
        translate([0,-tan(roof_angle)*two_by_four_width,0])
        difference(){
            cube(size=[two_by_four_height,sqrt(pow(4*12*inch+overhang,2)+pow(roof_ridge_height+birds_mouth,2)),two_by_four_width]);
            color([0,0,1,1])
            translate([-0.01,-0.01,-0.01])
            //translate([0,0,rafter_cut])
            rotate([roof_angle,0,0])
            translate([0,0,-(rafter_cut-cos(roof_angle)*two_by_four_width)])
            cube(size=[two_by_four_height+0.02,sin(roof_angle)*two_by_four_width+0.01,rafter_cut+0.02]);
        }
    }
    
        
    // barge boards
        
        for (i=[-1,1]){
            
            random_wood()
        translate([i*(4*12*inch+overhang-two_by_four_height/2),two_by_four_height/2,6*inch+0.75*inch*2+two_by_four_width*2+two_by_four_height*3+8*12*inch+roof_ridge_height])
        rotate([-roof_angle,0,0])
        translate([-two_by_four_height/2,-tan(roof_angle)*two_by_four_width,0])
        difference(){
            cube(size=[two_by_four_height,sqrt(pow(4*12*inch+overhang,2)+pow(roof_ridge_height+birds_mouth,2)),two_by_four_width]);
            color([0,0,1,1])
            translate([-0.01,-0.01,-0.01])
            //translate([0,0,rafter_cut])
            rotate([roof_angle,0,0])
            translate([0,0,-(rafter_cut-cos(roof_angle)*two_by_four_width)])
            cube(size=[two_by_four_height+0.02,sin(roof_angle)*two_by_four_width+0.01,rafter_cut+0.02]);
        }
        
   random_wood()
        translate([i*(4*12*inch+overhang-two_by_four_height/2),-two_by_four_height/2,6*inch+0.75*inch*2+two_by_four_width*2+two_by_four_height*3+8*12*inch+roof_ridge_height])
        translate([-two_by_four_height/2,0,0])
        mirror([0,1,0])
        rotate([-roof_angle,0,0])
        translate([0,-tan(roof_angle)*two_by_four_width,0])
        difference(){
            cube(size=[two_by_four_height,sqrt(pow(4*12*inch+overhang,2)+pow(roof_ridge_height+birds_mouth,2)),two_by_four_width]);
            color([0,0,1,1])
            translate([-0.01,-0.01,-0.01])
            //translate([0,0,rafter_cut])
            rotate([roof_angle,0,0])
            translate([0,0,-(rafter_cut-cos(roof_angle)*two_by_four_width)])
            cube(size=[two_by_four_height+0.02,sin(roof_angle)*two_by_four_width+0.01,rafter_cut+0.02]);
        }
    }
        
    
        
    // mattress (lol)
    translate([0,0,6*inch+two_by_four_width*2+0.75*inch*2])
    mattress(80*inch,60*inch, 12*inch);


}


module brick_fence(length,height,spacing,void,cap_begin,cap_end){
    count=floor((length-(block_width+spacing))/(block_length+spacing));
    stack=floor(height/(block_height+spacing));

    a=(length-(block_width+spacing));
    b=floor((length-(block_width+spacing))/(block_length+spacing))*(block_length+spacing);
    
    diff=a-b;
    
    
    half_void=(diff>=(block_width+spacing))?true:false;
    
    
    echo (concat("Blocks ",count));
    echo (concat("Half void: ",half_void));
    echo (concat("Void: ",void));
    
    for (z=[0:stack-1]){
        knock=(((half_void && void) && !z%2) || ((half_void && !void) && (z%2)) || !half_void)?true:false;
        
        for (i=[0:count-(knock?1:0)]){
            translate([
            (
                (void?
                    ((z%2)?0:(block_width+spacing)):
                    ((z%2)?(block_width+spacing):0)  
                )
            )+
            
            (block_length+spacing)*i,0,z*(block_height+spacing)])
            block();
        }
    }
}



module two_by_four(length){
    color([0.94,0.89,0.69,1.0])
    translate([-two_by_four_height/2,0,0])
    cube(size=[two_by_four_height,two_by_four_width,length]);
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
	translate([two_by_four_height/2,0,0])
    two_by_four(length);
    
	translate([0,two_by_four_width+two_by_four_height,0])
	rotate([0,0,-90])
	translate([two_by_four_height/2,0,0])
	two_by_four(length);
    
	translate([two_by_four_height,two_by_four_width,0])
	rotate([0,0,-90])
	translate([two_by_four_height/2,0,0])
	two_by_four(length);
}


module window(wall_height,length,floor_height,window_height,header_boards){

    // wall studs
    
    random_wood()
    translate([-length/2-3*(two_by_four_height/2),0,0])
    two_by_four(wall_height);
    
    random_wood()
    translate([length/2+3*(two_by_four_height/2),0,0])
    two_by_four(wall_height);
    
    // jack studs
    
    random_wood()
    translate([-length/2-two_by_four_height/2,0,0])
    two_by_four(floor_height-two_by_four_height);
    
    random_wood()
    translate([length/2+two_by_four_height/2,0,0])
    two_by_four(floor_height-two_by_four_height);
    
    auto_studs(floor_height-two_by_four_height,length,two_by_four_width,18*inch,false);
    
    // window sill
    
    random_wood()
    translate([-length/2-two_by_four_height,0,floor_height-two_by_four_height/2])
    rotate([0,90,0])
    two_by_four(length+two_by_four_height*2);
    
    // window studs
    
    random_wood()
    translate([-length/2-two_by_four_height/2,0,floor_height])
    two_by_four(window_height);
    
    random_wood()
    translate([length/2+two_by_four_height/2,0,floor_height])
    two_by_four(window_height);
    
    // windows header
    
    translate([-length/2-two_by_four_height,0,floor_height+window_height])
    for (i=[0:header_boards-1]){
        random_wood()
        translate([0,0,two_by_four_height*i+two_by_four_height/2])
        rotate([0,90,0])
        two_by_four(length+two_by_four_height*2);
    }
    
    // cripple studs
    
    random_wood()
    translate([-length/2-two_by_four_height/2,0,floor_height+window_height+two_by_four_height*header_boards])
    two_by_four(wall_height-floor_height-window_height-two_by_four_height*header_boards);
    
    
    random_wood()
    translate([length/2+two_by_four_height/2,0,floor_height+window_height+two_by_four_height*header_boards])
    two_by_four(wall_height-floor_height-window_height-two_by_four_height*header_boards);
    
    translate([0,0,floor_height+window_height+header_boards*two_by_four_height])
    auto_studs(wall_height-floor_height-window_height-header_boards*two_by_four_height,length,two_by_four_width,18*inch,false);
    
    
}

module door_frame(door_height,door_width,thickness,wall_height,header_boards){
    // door studs
    wood_color(){
    translate([-door_width/2-two_by_four_height-1*inch,0,0])
    cube(size=[two_by_four_height,two_by_four_width,door_height+2*inch]);
    
    translate([door_width/2+1*inch,0,0])
    cube(size=[two_by_four_height,two_by_four_width,door_height+2*inch]);
    }
    
    wood_color_b(){
    // wall studs
    translate([-door_width/2-2*two_by_four_height-1*inch,0,0])
    cube(size=[two_by_four_height,two_by_four_width,wall_height]);

    translate([door_width/2+two_by_four_height+1*inch,0,0])
    cube(size=[two_by_four_height,two_by_four_width,wall_height]);
    }
    
    // door header
    for (i=[0:header_boards-1]){
    random_wood()
    translate([-door_width/2-two_by_four_height-1*inch,0,door_height+2*inch+two_by_four_height*i])
    cube(size=[door_width+2*inch+two_by_four_height*2,two_by_four_width,two_by_four_height]);
    }
    
    // cripples
    wood_color(){
    translate([-door_width/2-two_by_four_height-1*inch,0,door_height+2*inch+two_by_four_height*header_boards])
    cube(size=[two_by_four_height,two_by_four_width,wall_height-door_height-2*inch-two_by_four_height*header_boards]);
    
    translate([door_width/2+1*inch,0,door_height+2*inch+two_by_four_height*header_boards])
    cube(size=[two_by_four_height,two_by_four_width,wall_height-door_height-2*inch-two_by_four_height*header_boards]);
    }
    translate([0,0,door_height+2*inch+two_by_four_height*header_boards])
        auto_studs(wall_height-door_height-2*inch-two_by_four_height*header_boards,36*inch,two_by_four_width,18*inch,false);
}

echo(concat("Perimeter ",property_length*2+property_width*2));

color([0,0.8,0,0.1])
translate([0,0,-inch])
cube([property_width*12*inch,property_length*12*inch,inch]);

color([0.8,0,0,0.1])
translate([(building_height-4)*12*inch,(building_height+4)*12*inch,0])
cube([(property_width-(building_height-4)*2)*12*inch,(property_length-(building_height+10)*2)*12*inch,inch]);


/*
translate([(property_width-building_length)/2*12*inch,(property_length-building_width)/2*12*inch,0])
cube([building_length*12*inch,building_width*12*inch,building_height*12*inch]);
*/


//pier_one(24*inch,6*inch);
//pier_two(80*inch,6*inch);

//wall_section(5*12*inch,8*12*inch);

//three_stud_corner(8*12*inch);
//window(4*12*inch,8*12*inch,3*12*inch,3*12*inch,6*inch);

/*

brick_fence(((property_width-24)/2)*12*inch,7*12*inch,gap,false,false,true);

// Left Fence

translate([block_width,0,0])
rotate([0,0,90])
brick_fence(property_length*12*inch,7*12*inch,gap,true,false,false);

a=(property_length*12*inch-(block_width+gap));
b=(block_length+gap)*floor((property_length*12*inch-(block_width+gap))/(block_length+gap));

echo(a);
echo(b);
echo(block_width+gap);
half_void=((a-b)>(block_width+gap))?true:false;

echo (half_void);



// Rear Fence

translate([0,(block_length+gap)*floor((property_length*12*inch-block_width-gap)/(block_length+gap))+(half_void?(block_width+gap):0),0])
brick_fence(property_width*12*inch,7*12*inch,gap,!half_void,false,false);

c=(property_width*12*inch-(block_width+gap));
d=floor((property_width*12*inch-(block_width+gap))/(block_length+gap))*(block_length+gap);
echo(c);

echo(d);
rear_void=((c-d)>(block_width+gap))?(half_void?true:false):(half_void?false:true);

echo(concat("Rear void: ",rear_void));

// Right Fence

translate([(rear_void?0:(block_width+gap))+block_width+gap+(block_length+gap)*floor((property_width*12*inch-block_width-gap)/(block_length+gap)),0,0])
rotate([0,0,90])


brick_fence(property_length*12*inch,7*12*inch,gap,half_void?rear_void:!rear_void ,false,false);

*/

module garden_plot(plot_length,plot_width,plot_height,corner,border){
    
    // corners
    color([0.9,0.5,0.3]){
    translate([-corner,-corner,0])
    cube(size=[corner,corner,plot_height]);
    
    translate([plot_length,-corner,0])
    cube(size=[corner,corner,plot_height]);
    
    translate([-corner,plot_width,0])
    cube(size=[corner,corner,plot_height]);

    translate([plot_length,plot_width,0])
    cube(size=[corner,corner,plot_height]);
    }
    
    // garden walls
    color([0.94,0.89,0.69,1.0]){
        translate([0,-border,0])
        cube(size=[plot_length,border,plot_height]);
        
        translate([0,plot_width,0])
        cube(size=[plot_length,border,plot_height]);

        translate([-border,0,0])
        cube(size=[border,plot_width,plot_height]);
        
        translate([plot_length,0,0])
        cube(size=[border,plot_width,plot_height]);
    }
    
    // garden bed
    color([0.5,0.2,0])
    cube([plot_length,plot_width,plot_height-4*inch]);
}


// Raised Garden

for (j=[0:0]){
    for (i=[0:5]){
        
        translate([6*12*inch+i*24*12*inch,property_length*12*inch-6*12*inch-5*12*inch-j*9*12*inch,0])
        garden_plot(20*12*inch,5*12*inch,18*inch,two_by_four_width_inches*inch,two_by_four_height_inches*inch);
    }
}


for (j=[1:3]){
    for (i=[0,1,4,5]){
        
        translate([6*12*inch+i*24*12*inch,property_length*12*inch-6*12*inch-5*12*inch-j*9*12*inch,0])
        garden_plot(20*12*inch,5*12*inch,18*inch,two_by_four_width_inches*inch,two_by_four_height_inches*inch);
    }
}


translate([48*12*inch+6*12*inch,property_length*12*inch-6*12*inch-9*12*inch,0])
rotate([0,0,-90])
for (i=[0:1]){
    translate([0,i*9*12*inch,0])
    garden_plot(20*12*inch,5*12*inch,18*inch,two_by_four_width_inches*inch,two_by_four_height_inches*inch);
}


translate([78*12*inch+6*12*inch,property_length*12*inch-6*12*inch-9*12*inch,0])
rotate([0,0,-90])
for (i=[0:1]){
    translate([0,i*9*12*inch,0])
    garden_plot(20*12*inch,5*12*inch,18*inch,two_by_four_width_inches*inch,two_by_four_height_inches*inch);
}


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

solar_battery();


translate([property_width*12*inch/2,property_length*12*inch-23*12*inch,0])
tool_shed();
