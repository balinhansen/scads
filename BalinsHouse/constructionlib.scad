inch=25.4;
gap=10; // visual aid
stud_spacing_inches=16;

building_height=14;
building_width=25;
building_length=55;

property_size=45738;
property_width=152;
property_length=301;

two_by_ten_width_inches=9.5625;
two_by_eight_width_inches=7.5625;
two_by_six_width_inches=5.5625;
two_by_four_width_inches=3.5625;
two_by_four_height_inches=1.5625;
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
two_by_six_width=two_by_six_width_inches*inch;
two_by_eight_width=two_by_eight_width_inches*inch;
two_by_ten_width=two_by_ten_width_inches*inch;

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

function imp_frac(i)=concat(floor(i)," and ",(i-floor(i))*32,"/32nds");


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



module obelisk(height,width,cap_height,cap_theta){
    cap_width=cap_height/tan(cap_theta);
    cap_zpos=height-cap_height;

polyhedron(points=[
    [-width/2,-width/2,0],[width/2,-width/2,0],[width/2,width/2,0],[-width/2,width/2,0],
    [-cap_width,-cap_width,cap_zpos],[cap_width,-cap_width,cap_zpos],[cap_width,cap_width,cap_zpos],[-cap_width,cap_width,cap_zpos],[0,0,height]    
    ],faces=[[0,1,2,3],[0,1,5,4],[1,2,6,5],[2,3,7,6],[3,0,4,7],[4,5,8],[5,6,8],[6,7,8],[7,4,8]],convexity=10);    
}



module mattress(mattress_width,mattress_length,mattress_depth){
    r=5*inch;
    mattress_fineness=32;
    color([0.8,0.8,1])
        
    translate([-mattress_width/2,-mattress_length/2,0])
    hull(){
        translate([r,r,0])
        cylinder(mattress_depth,r,r,$fn=mattress_fineness);
        
        translate([mattress_width-r,r,0])
        cylinder(mattress_depth,r,r,$fn=mattress_fineness);
        
        translate([r,mattress_length-r,0])
        cylinder(mattress_depth,r,r,$fn=mattress_fineness);
        
        translate([mattress_width-r,mattress_length-r,0])
        cylinder(mattress_depth,r,r,$fn=mattress_fineness);
    }
}

module auto_studs(height, width, thickness, spacing,center){
        if (center){
            translate([-two_by_four_height/2,0,0])
            random_wood()
            cube(size=[two_by_four_height,thickness,height]);
        }else{
            for (i=[0:floor((width-spacing)/(spacing*2))]){
                random_wood()
                translate([-spacing/2-two_by_four_height/2-i*spacing,0,0])
                cube(size=[two_by_four_height,thickness,height]);
              
                random_wood()
                translate([spacing/2-two_by_four_height/2+i*spacing,0,0])
                cube(size=[two_by_four_height,thickness,height]);
            }
        }
}

module rafter_board(projected_length,roof_angle,overhang,birds_mouth){
    
    birds_mouth_length=birds_mouth/cos(roof_angle);
    
    birds_mouth_depth=birds_mouth_length*sin(roof_angle);
    
    birds_mouth_kerf=1/16*inch;
    
 
    min_ridge=two_by_six_width/cos(roof_angle);
    
    roof_ridge_height=(5*12*inch-two_by_four_height/2)*tan(roof_angle)-birds_mouth_depth;
    
    rafter_cut=sqrt(pow(two_by_six_width,2)+pow(tan(roof_angle)*two_by_six_width,2));
    
    translate([0,two_by_four_height/2,0])
    rotate([-roof_angle,0,0])
    translate([-two_by_four_height/2,-tan(roof_angle)*two_by_six_width,0])
    
    difference(){
        cube(size=[two_by_four_height,(projected_length+sin(roof_angle)*two_by_six_width)/cos(roof_angle), two_by_six_width]);
        
        
        translate([-0.1,-0.1,-0.1])
        rotate([roof_angle,0,0])
        translate([0,0,-(rafter_cut-cos(roof_angle)*two_by_six_width)])
        cube(size=[two_by_four_height+0.2,sin(roof_angle)*two_by_six_width+0.1,rafter_cut+0.2]);
     
        translate([-0.1,(projected_length+sin(roof_angle)*two_by_six_width)/cos(roof_angle),-0.01])
        rotate([roof_angle,0,0])
        translate([0,0,0])
        cube(size=[two_by_four_height+0.2,sin(roof_angle)*two_by_six_width+0.1,rafter_cut+0.2]);  
        
        translate([0,(5*12*inch+sin(roof_angle)*two_by_six_width-two_by_four_height/2)/cos(roof_angle),0])
        rotate([roof_angle,0,0])
    translate([-1,-birds_mouth-birds_mouth_kerf,-birds_mouth_kerf])
    cube([two_by_four_height+2, birds_mouth+birds_mouth_kerf*2, birds_mouth_depth+birds_mouth_kerf*2]);
   
    }
    
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
    
    auto_studs(floor_height-two_by_four_height,length,two_by_four_width,stud_spacing,false);
    
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
    auto_studs(wall_height-floor_height-window_height-header_boards*two_by_four_height,length,two_by_four_width,stud_spacing,false);
    
    
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
        auto_studs(wall_height-door_height-2*inch-two_by_four_height*header_boards,36*inch,two_by_four_width,stud_spacing,false);
}




// Jogging track

concrete()
difference(){
    translate([2*12*inch,2*12*inch,0])
    cube([(property_width-4)*12*inch,(property_length-4)*12*inch,inch/4]);

    translate([6*12*inch,6*12*inch,-inch/8])
    cube([(property_width-12)*12*inch,(property_length-12)*12*inch,2*inch/4]);
}


// Driveway

concrete()
translate([(property_width*12*inch-14*12*inch)/2,0,0])
cube([14*12*inch,25*12*inch,inch/2]);


/*
translate([(property_width-building_length)/2*12*inch,(property_length-building_width)/2*12*inch,0])
cube([building_length*12*inch,building_width*12*inch,building_height*12*inch]);
*/


//pier_one(24*inch,6*inch);
//pier_two(80*inch,6*inch);

//wall_section(5*12*inch,8*12*inch);

//three_stud_corner(8*12*inch);
//window(4*12*inch,8*12*inch,3*12*inch,3*12*inch,6*inch);



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
    
    // plant examples
    
    color([0,0.8,0,0.4])
    for (i=[0:7]){
        for (j=[0:1]){
            translate([15*inch+30*inch*i,15*inch+30*inch*j,plot_height-4*inch])
            cylinder(6*12*inch,9*12,15*inch,$fn=12);
        }
    }
}


// Raised Garden

for (j=[0:3]){
    for (i=[0:4]){
        
        translate([12*12*inch+i*27*12*inch,property_length*12*inch-12*12*inch-5*12*inch-j*9*12*inch,0])
        garden_plot(20*12*inch,5*12*inch,18*inch,two_by_four_width_inches*inch,two_by_four_height_inches*inch);
    }
}






translate([property_width*12*inch/2,property_length*12*inch/2,0])
color([0.2,0.2,0.2,1])
obelisk(7*12*inch,24*inch,18*inch,65);