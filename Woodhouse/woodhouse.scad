inch=25.401;
mill_kerf=0.25;

board_spacing=18*inch;
board_width=2*inch;

module vis_two_by_four(){
	
	
}

module stud(){
	cube(size=[2*inch,4*inch,8*12*inch]);
}



// WALL MODULE


module three_stud_corner(direction,direction_vector){
	stud();
	translate([0,6*inch,0])
	rotate([0,0,-90])
	stud();
	translate([2*inch,4*inch,0])
	rotate([0,0,-90])
	stud();
}


module wall(wall_length,minimum_spacing,first_corner,last_corner,first_stud,last_stud){
wall_boards=wall_length/minimum_spacing;

	
	
	if (first_corner){
translate([-4*inch,0,0])
		three_stud_corner();
	}else{
		if (first_stud){
			stud();
		}
	}

	for (i=[1:wall_length/minimum_spacing-1]){
		translate([i*minimum_spacing,0,0])
		stud();
	}


	if (last_corner){
		translate([wall_length,0,0])
		mirror([1,0,0])
		three_stud_corner();
	}else{
		if (last_stud){
			translate([wall_length,0,0])
			stud();
		}
	}
}


// WINDOW MODULE AND SUPPORT


module jack_stud(height){
cube(size=[2*inch,4*inch,height-2*inch]);
}

module trimmer_stud(height,width){
	translate([0,0,height])
	cube(size=[2*inch,4*inch,width]);
}

module window_cripple_stud(wall_height,height,width,header){
	translate([0,0,height+width+header])
	cube(size=[2*inch,4*inch,wall_height-width-height-header]);
}


module window(height,length,width,header,minimum_spacing){
	translate([-4*inch,0,0])
	stud();

	translate([-2*inch,0,0])
	jack_stud(height);

	jack_studs=length/minimum_spacing;
	for (i=[1:jack_studs]){
		translate([i*minimum_spacing,0,0])
		jack_stud(height);
	}
	translate([length,0,0])
	jack_stud(height);
	
	translate([length+2*inch,0,0])
	stud();


	translate([-2*inch,0,height-2*inch])
	cube(size=[length+4*inch,4*inch,2*inch]);


	translate([-2*inch,0,0])
	trimmer_stud(height,width);

	translate([length,0,0])
	trimmer_stud(height,width);


for (i=[0:header/board_width-1]){
	translate([-2*inch,0,height+width+board_width*i])
	cube(size=[length+4*inch,4*inch,board_width]);
}


	translate([-2*inch,0,0])
window_cripple_stud(8*12*inch,height,width,header);

for (i=[1:jack_studs]){
		translate([i*minimum_spacing,0,0])
		window_cripple_stud(8*12*inch,height,width,header);
	}

translate([length,0,0])
window_cripple_stud(8*12*inch,height,width);
	
}



// DOOR MODULE AND SUPPORT

module door_stud(height){
	cube(size=[2*inch,4*inch,height]);
}

module door_cripple_stud(height,header){
translate([0,0,height+header])
	cube(size=[2*inch,4*inch,8*12*inch-height-header]);
}

module door(width,height,header,minimum_spacing){
	translate([-4*inch,0,0])
	stud();
	translate([-2*inch,0,0])
	door_stud(height);

	translate([width,0,0])
	door_stud(height);
	translate([width+2*inch,0,0])
	stud();

	for (i=[0:header/board_width-1]){
		translate([-2*inch,0,height+i*2*inch])
		cube(size=[width+4*inch,4*inch,2*inch]);
	}

	translate([-2*inch,0,0])
	door_cripple_stud(height,header);

	for (i=[1:width/minimum_spacing]){
		translate([minimum_spacing*i,0,0])
			door_cripple_stud(height,header);
	}
	
	translate([width,0,0])
	door_cripple_stud(height,header);
}

module board(){
	rotate([0,90,0])
	
	stud();
}

module garage_stud(height){
	cube(size=[2*inch,4*inch,height]);
}

module garage(width,height,header,minimum_spacing){
	
	stud();

	translate([2*inch,0,0])
	garage_stud(height);

	translate([4*inch,0,0])
	garage_stud(height);

	translate([width+6*inch,0,0])
	garage_stud(height);

	translate([width+8*inch,0,0])
	garage_stud(height);

	translate([width+10*inch,0,0])
	stud();
	
	
	
	for (i=[0:header/board_width]){
	translate([2*inch,0,height+2*inch*i])
cube(size=[width+8*inch,4*inch,2*inch]);
}

}



// Markup of a Wooden House

module caboose(){
// Left rearward wall
translate([36*inch+6*12*inch+8*inch,0,0])
wall(3*12*inch,board_spacing,0,1,0,0);

// Left rearward window
	translate([(36*inch+8*inch),0,0])
	window(28*inch,6*12*inch,42*inch,12*inch,board_spacing);

// Left door
door(36*inch,82*inch,12*inch,board_spacing);

// Left forward window
translate([-6*12*inch-4*inch-4*inch,0,0])
window(28*inch,6*12*inch,42*inch,12*inch,board_spacing);

// Left forward wall
translate([-4*inch-6*12*inch-8*inch,0,0])
mirror([1,0,0])
wall(3*12*inch,board_spacing,0,1,1,0);

// Rearward window
translate([+(3*12+4)*inch+(5*12+4)*inch+3*12*inch+8*inch,10*inch,0])
rotate([0,0,90])
mirror([0,1,0])
window(36*inch,(5*12+2)*inch,34*inch,12*inch,board_spacing);

// Forward door

translate([-(3*12+4)*inch-6*12*inch-8*inch,24*inch,0])
rotate([0,0,90])
mirror([0,1,0])
door(36*inch,82*inch,12*inch,board_spacing);


// Right forward wall


translate([(-10*12)*inch+4*inch,(6*12+8)*inch+2*inch,0])
mirror([0,1,0])
wall((4*12+6)*inch+2*inch,board_spacing,1,0,0,0);

// Right garage door

translate([(-7*12+3)*inch+6*inch,(6*12+8)*inch+2*inch,0])
mirror([0,1,0])
garage(14*12*inch,82*inch,12*inch,board_spacing);

// Right rear wall

translate([(-10*12)*inch+8*inch+(2*12+4)*inch+(14*12+12)*inch,(6*12+8)*inch+2*inch,0])
mirror([0,1,0])
wall((4*12+6)*inch+2*inch,board_spacing,0,1,0,0);

}

stud();
translate([10*12*inch,0,0])

caboose();

translate([-(6*12+8)*inch,7*12*inch+10*12*inch+(2*12+6)*inch,0])
rotate([0,0,-90])
caboose();

translate([10*12*inch,(21*12+4)*inch+12*inch+7*12*inch+7*12*inch,0])
mirror([0,1,0])
caboose();

translate([(29*12+6)*inch,(19*12+6)*inch,0])
mirror([0,1,0])
rotate([0,0,90])
caboose();

// RULER 

// translate([-(6*12+4)*inch,0,-inch])
// cube(size=[6*12*inch,inch,inch]);
stud();
