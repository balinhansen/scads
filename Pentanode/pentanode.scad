inch=25.4;
foot=12*inch;
cord=20*foot;
space=5*inch;
pad=16*inch;
halls=9.5*foot;
secret=10*foot;
distance=16*inch;
wall_height=9.5*foot;
floorboard=0.5*inch;
cut=0.375*inch;

dummy_height=5*foot+6*inch;

board_kerf=3/8*inch;


// Colors


module decor(){
    color([0,0,0.4,0.4])
    children();
}

module dumb(){
    color([1,1,1,0.4])
    children();
}

module fixture(){
    color([.75,0,.75,0.4])
    children();
}

module appliance(){
    color([0,.75,0,0.4])
    children();
}


radius=sqrt(pow(cord/2,2)+pow((cord/2)*cos(72),2));
wall=cos(36)*radius;
side=sqrt(pow(radius,2)-pow(wall,2))*2;


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


// Dummies


    $fn=12;
    num_dummies=1;
    
    module dummies(){
        for (i=[0:num_dummies-1]){
            translate([floor(rands(-20,20,1)[0])*100,floor(rands(-20,20,1)[0])*100])
          dummy();
        }
    }
    dumb()
    translate([0,0,10*inch+0.5*inch])
    dummies();







module ewdc(){
        translate([-12*inch,-12*inch,0])
        cube([24*inch,24*inch,37*inch]);
}


module tlwh(){
    translate([-7*inch,0,4*foot])
    cube([14*inch,10*inch,23*inch]);
}



module oven(){
    translate([-15*inch,-14.5*inch,0])
    cube([30*inch,29*inch,47*inch]);
}

 


//  Fixtures


module shower(){
    translate([-24*inch,-18*inch,0])
    cube([48*inch,36*inch,7*foot]);
}


module ksink(){
    translate([-16.5*inch,0,36*inch-10*inch])
    cube([33*inch,22*inch,10*inch]);
}


    translate([0,0,10*inch+0.5*inch]){
        
fixture()
rotate([0,0,144])
translate([3.5*foot,-wall+24*inch+4*inch,0])
rotate([0,0,90])
shower();

    }
    
    


    translate([0,0,10*inch+0.5*inch]){
        
appliance()
rotate([0,0,-144])
translate([0,-wall+12*inch+4*inch,0])
ewdc();

appliance()
rotate([0,0,-144])
translate([0,-wall+4*inch,0])
tlwh();

appliance()
rotate([0,0,-144])
translate([+30*inch,-wall+4*inch+14.5*inch,0])
oven();

    }

module toilet(){
    
    translate([0,20*inch,0]){

        translate([0,0,9*inch])
        scale([14/20,1,1])
        translate([-10*inch,-10*inch,0])    
        cube(size=[20*inch,20*inch,10*inch]);
                   
            translate([-4*inch,-20*inch+6*inch,0])
        cube([8*inch,20*inch,10*inch]);

        translate([-10*inch,-8*inch-11*inch,10*inch])
        cube([20*inch,8*inch,18*inch]);
   
    }
    
}



module bsink(){
    translate([-11*inch,0,36*inch-10*inch])
    cube([22*inch,18*inch,10*inch]);
}



    translate([0,0,10*inch+0.5*inch]){
        
fixture()
rotate([0,0,-72])
translate([0,-wall+4*inch,0])
ksink();

fixture()
rotate([0,0,144])
translate([-20*inch,-wall+4*inch,0])
toilet();

fixture()
rotate([0,0,144])
translate([-side/2+4*inch+11*inch+4*inch,-wall+4*inch,0])
bsink();

    }


// Furniture


module full_bed(){
    translate([-27*inch,-37.5*inch,18*inch])
    cube([54*inch,75*inch,14*inch]);
}


module table(){
    translate([0,0,28*inch])
    cylinder(2*inch,18*inch,18*inch);
    translate([0,0,2*inch])
    cylinder(26*inch,1.375*inch,1.375*inch);
    cylinder(2*inch,12*inch,12*inch);
}


    translate([0,0,10*inch+0.5*inch]){


decor()
translate([0,-wall+37.5*inch+4*inch,0])
full_bed();


decor()
rotate([0,0,-72-36])
translate([0,-3*foot,0])
table();

    }
    
    



// Boards

module tbf(length){
    translate([-1*inch,-2*inch,0])
cube([2*inch,4*inch,length]);
}

module tbs(length){
    translate([-1*inch,-3*inch,0])
cube([2*inch,6*inch,length]);
}

module tbe(length){
    translate([-1*inch,-4*inch,0])
cube([2*inch,8*inch,length]);
}



// Walls and Framing


//tbf(8*foot);

module wall(l,a){
    l=l-2*inch;
    nf=floor(l/distance);
    n=((nf==l/distance)?nf:nf+1);
    
    offset=(distance-(l/n));
    
    
    translate([-l/2,0,0])
        for (i=[0:n]){
            if (!search(i,a)){
                translate([i*(distance-offset),0,0])
                tbf(wall_height);
            }
        }
}

module floor_side(l,s){
    translate([0,2*inch,0]){
        
        translate([-l/2,inch,inch])
        rotate([0,90,0])
        tbs(l);

        translate([-l/2,-inch,4*inch+inch*2])
        rotate([90,0,0])
        rotate([0,90,0])
        tbe(l);

        translate([-l/2,0,inch+2*inch+8*inch])
        rotate([0,90,0])
        tbf(l);
        
        translate([-l/2,0,inch+2*inch+8*inch+2*inch+wall_height])
        rotate([0,90,0])
        tbf(l);
    }
}


module wall_side(l){
    translate([0,2*inch,0]){
        translate([0,0,2*inch+8*inch+2*inch])
        wall(l);


        translate([-l/2,inch,inch])
        rotate([0,90,0])
        tbs(l);

        translate([-l/2,-inch,4*inch+inch*2])
        rotate([90,0,0])
        rotate([0,90,0])
        tbe(l);

        translate([-l/2,0,inch+2*inch+8*inch])
        rotate([0,90,0])
        tbf(l);
        
        translate([-l/2,0,inch+2*inch+8*inch+2*inch+wall_height])
        rotate([0,90,0])
        tbf(l);
    }
}

module door(w,h){
        translate([-w/2,-1.75*inch/2,0])
        cube([w,1.75*inch,h]);
}

module doorframe(w,h){
    translate([-w/2-inch-4*inch,0,0])
    tbf(wall_height);
    
    translate([w/2+inch+4*inch,0,0])
    tbf(wall_height);
    
    translate([-w/2-inch-2*inch,0,0])
    tbf(h+2*inch);
    translate([w/2+inch+2*inch,0,0])
    tbf(h+2*inch);
    
    translate([-(w+8*inch)/2,inch,h+2*inch+2*inch])
    rotate([90,0,0])
    rotate([0,90,0])
    tbf(w+8*inch);
    
    translate([-(w+8*inch)/2,-inch,h+2*inch+2*inch])
    rotate([90,0,0])
    rotate([0,90,0])
    tbf(w+8*inch);
    
    l=w-2*inch+8*inch;
    nf=floor(l/distance);
    n=((nf==l/distance)?nf:nf+1);
    
    offset=(distance-(l/n));
    
    
    translate([-l/2,0,0])
        for (i=[0:n]){
            translate([i*(distance-offset),0,h+3*2*inch])
            tbf(wall_height-h-3*2*inch);
        }
}


module window(w,h,z){
      l=w-2*inch+4*inch;
    nf=floor(l/distance);
    n=((nf==l/distance)?nf:nf+1);
    
    offset=(distance-(l/n));
    
    translate([-w/2-inch-2*inch,0,0])
    tbf(wall_height);
    
    translate([w/2+inch+2*inch,0,0])
    tbf(wall_height);
    
    translate([-l/2,0,0])
    for (i=[0:n]){
        translate([i*(distance-offset),0,0])
        tbf(z-2*inch);
    }
    
    translate([-(w+4*inch)/2,0,inch+z-2*inch])
    rotate([0,90,0])
    tbf(w+4*inch);
    
    translate([-w/2-inch,0,z])
    tbf(h);
    
    translate([w/2+inch,0,z])
    tbf(h);
    
    translate([-(w+4*inch)/2,-inch,2*inch+z+h])
    rotate([90,0,0])
    rotate([0,90,0])
    tbf(w+4*inch);
    
    translate([-(w+4*inch)/2,inch,2*inch+z+h])
    rotate([90,0,0])
    rotate([0,90,0])
    tbf(w+4*inch);
        
    translate([-l/2,0,z+h+4*inch])
    for (i=[0:n]){
        translate([i*(distance-offset),0,0])
        tbf(wall_height-z-h-2*2*inch);
    }
        
}


module wall_interior(l){
    translate([-l/2,0,inch])
    rotate([0,90,0])
    tbf(l);
    
    translate([0,0,2*inch])
    wall(l);
    
    translate([-l/2,0,inch+wall_height+2*inch])
    rotate([0,90,0])
    tbf(l);
}



// Bathroom (Interior)

translate([0,0,10*inch])
rotate([0,0,144]){

    translate([side/2-5*inch-2*inch,-wall+4*inch+26*inch])
    rotate([0,0,90])
    wall_interior(52*inch);

    translate([-side/2+5*inch+2*inch,-wall+4*inch+26*inch])
    rotate([0,0,90])
    wall_interior(52*inch);


    translate([0,-wall+4*inch+48*inch+2*inch])
    rotate([0,0,0])
    wall_interior(side-10*inch-8*inch);

}

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



// Customized Pentanode



module wall_example(){
    translate([-side/2+5*inch+50*inch/2+16*inch,0,0]){
        door(38*inch,84*inch);
        doorframe(38*inch,84.25*inch);
    }
    translate([side/2-5*inch-48*inch/2-16*inch,0,0])
    window(4*foot,4*foot,30*inch);
    wall(side-10*inch,[2,3,4,5,6,7]);
}


pentapad();



for (i=[0:4]){
    rotate([0,0,i*360/5])
    translate([0,-wall,0])
    floor_side(side-10*inch);
}

for (i=[0]){
    rotate([0,0,i*360/5])
    translate([0,-wall,0])
wall_side(side-10*inch);
}

    rotate([0,0,1*360/5])
    translate([0,-wall+2*inch,12*inch])
//wall_example(side-10*inch);
wall_example();



rotate([0,0,4*360/5])
    translate([0,-wall+2*inch,12*inch])
{
    wall(side-10*inch,[3,4,5,6]); 
    window(48*inch,4*foot,36*inch);
}



rotate([0,0,3*360/5])
    translate([0,-wall+2*inch,12*inch])
{
    wall(side-10*inch,[2,3,]); 
    translate([-side/2+30*inch/2+5*inch+2*foot,0,0])
    window(30*inch,4*foot,36*inch);
}


rotate([0,0,2*360/5])
    translate([0,-wall+2*inch,12*inch])
{
    wall(side-10*inch,[2,3,4,5,6,7]); 
    translate([-side/2+44*inch/2+5*inch+2*foot,0,0])
    window(36*inch,3*foot,54*inch);
    
        translate([side/2-44*inch/2-5*inch-16*inch,0,0])
    window(36*inch,1.5*foot,84*inch);
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

