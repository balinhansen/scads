inch=25.4;
foot=12*inch;
cord=20*foot;
space=5*inch;
pad=16*inch;
halls=9.5*foot;
secret=10*foot;

floorboard=0.5*inch;

dummy_height=6*foot;

board_kerf=3/8*inch;



radius=sqrt(pow(cord/2,2)+pow((cord/2)*cos(72),2));
wall=cos(36)*radius;

module dummy(){
    translate([0,0,6.5*dummy_height/7])
    scale([1/1.61,1/1.61,1])
    sphere(dummy_height/7/2);
    
    //scale([1/1.61/2,1/1.61*1/1.61/2,1])
    translate([0,0,3*dummy_height/7+(3)*dummy_height/7/2/2])
    minkowski(){
        cylinder(3*dummy_height/7/2,dummy_height/7/2/2/2/2,dummy_height/7/2/2/2);
        scale([1/1.16,1/2,1])
        sphere(3*dummy_height/7/2/2);
    }
 
    
translate([0,0,4*dummy_height/7/2/2]){
    translate([-dummy_height/7/1.61/2,0,0])
    minkowski(){
        cylinder(4*dummy_height/7/2,dummy_height/7/2/2/2/2,dummy_height/7/2/2/2);
        scale([1/4/1.61,1/4/1.61,1])
        sphere(4*dummy_height/7/2/2);
    }

    translate([+dummy_height/7/1.61/2,0,0])
    minkowski(){
        cylinder(4*dummy_height/7/2,dummy_height/7/2/2/2/2,dummy_height/7/2/2/2);
        scale([1/4/1.61,1/4/1.61,1])
        sphere(4*dummy_height/7/2/2);
    }
}
      
}

dummy();




    $fn=5;
    num_dummies=100;
    
    module dummies(){
        for (i=[0:num_dummies-1]){
            translate([floor(rands(-20,20,1)[0])*100,floor(rands(-20,20,1)[0])*100])
          dummy();
        }
    }
    dummies();

echo(norm([1,1,1]));
echo(cross([1,0,0],[0,1,0]));

module tbf(length){
    translate([-1*inch,-2*inch,0])
cube([2*inch-board_kerf,4*inch-board_kerf,length]);
}

tbf(8*foot);


function ngon(count, radius, i = 0, result = []) = i < count
    ? ngon(count, radius, i + 1, concat(result, [[ radius*sin(360/count*i), radius*cos(360/count*i) ]]))
    : result;



module pentapad(){
    color([0.4,0.4,0.4,0.4])
    linear_extrude(floorboard,convexity=10)
    polygon(ngon(5,radius));
}






module ring(list){
    echo(list);
    for (i=list){
        rotate([0,0,i*360/5])
        translate([0,-wall*2-pad,0])
        rotate([0,0,180])
        children();
    }
}

module affine_wall(){
    translate([0,-wall*2-pad,0])
    rotate([0,0,180])
    children();
}

module pentamod(){
        translate([0,-wall-pad/2,0])
        hallway(pad,halls);
        pentapad();
    
}

//ring([1:5])
//pentamod();

// Some interesting test ideas ... 

translate([0,0,12.5*foot])
compound();

pentapad();

affine_wall()
pentamod();

ring([1,3,4])
pentamod();


module full_bath(){
    translate([-5*foot,-3*foot,0])
    cube ([10*foot,6*foot,floorboard]);
}


module closet(){
    translate([-2.5*foot,-1.25*foot,0])
    cube ([5*foot,2.5*foot,floorboard]);
}

module hallway(l,w){
    translate([-w/2,-l/2,0])
    cube([w,l,floorboard]);
}

module bedroom(){

rotate([0,0,180-36])
pentamod();
    
rotate([0,0,0])
translate([0,-wall-3*foot,0])
full_bath();

rotate([0,0,+72])
translate([0,-wall-1.25*foot,0])
closet();

rotate([0,0,-72])
translate([0,-wall-secret/2,0])
hallway(secret,halls);
}



translate([0,-1*(wall*2+pad),0])
rotate([0,0,36])
translate([0,-1*(wall*2+pad),0])
rotate([0,0,36])
bedroom();

module r641a(){
    translate([0,-1*(wall*2+pad),0])
    rotate([0,0,36-72])
    translate([0,-1*(wall*2+pad),0])
    rotate([0,0,36])
    children();
}

r641a(){
    rotate([0,0,144])
    pentamod();
    rotate([0,0,-72])
    translate([0,-wall-3*foot,0])
    full_bath();
}

module r640(){
    rotate([0,0,+144])
    translate([0,-1*(wall*2+pad),0])
    rotate([0,0,36])
    children();
}

r640()
bedroom();

module r640b(){
    rotate([0,0,-36])
    translate([0,+wall*2+pad,0])
    rotate([0,0,-36])        
    translate([0,wall*2+secret,0]) 
    children();
}

r640b(){
    pentapad();
    ring([1,2,3,4])
    pentamod();
}



module compound(){
    pentapad();
    affine_wall()
    pentamod();
    
    ring([1,2,3,4])
    
    rotate([0,0,-144])
    bedroom();
}
