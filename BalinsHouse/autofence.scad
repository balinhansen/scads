include <constructionlib.scad>

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

