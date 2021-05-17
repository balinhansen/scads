inch=25.4;


function addendum()=[];

function maxinv(base,ad,teeth,t,i=0)=
let(x=base*(cos(i)+(i/180*PI)*sin(i)))
let(y=base*(sin(i)-(i/180*PI)*cos(i)))
let(dis=sqrt(pow(x,2)+pow(y,2)))
(dis<ad)?maxinv(base,ad,teeth,t,i+1):i-1;

function maxang(base,ad,teeth,t,i=0)=
let(x=base*(cos(i)+(i/180*PI)*sin(i)))
let(y=base*(sin(i)-(i/180*PI)*cos(i)))
let(dis=sqrt(pow(x,2)+pow(y,2)))
(dis<ad)?maxang(base,ad,teeth,t,i+1):atan((base*(sin(i-1)-((i-1)/180*PI)*cos(i-1)))/(base*(cos(i-1)+((i-1)/180*PI)*sin(i-1))));

function maxdis(base,ad,teeth,t,i=0)=
let(x=base*(cos(i)+(i/180*PI)*sin(i)))
let(y=base*(sin(i)-(i/180*PI)*cos(i)))
let(dis=sqrt(pow(x,2)+pow(y,2)))
(dis<ad)?maxang(base,ad,teeth,t,i+1):dis;

function rotvec(vec,theta,i=0,result=[])=(i<len(vec))?concat( [vec[i][0]*cos(theta)-vec[i][1]*sin(theta)],[vec[i][0]*sin(theta)+vec[i][1]*cos(theta)],result):result;


function dedendum(base,ad,teeth,t=0,count,i=0,result=[])=
let(x=base*(cos(i)+(i/180*PI)*sin(i)))
let(y=base*(sin(i)-(i/180*PI)*cos(i)))
let(dis=sqrt(pow(x,2)+pow(y,2)))
let(mdis=maxdis(base,ad,teeth,t))
let(mang=maxang(base,ad,teeth,t))
let(gap=(360-(2*mang*teeth))/(teeth))
let(prop=base/dis)
let(pos=i/(count*gap*prop/4)-mang)
let(vec=rotvec([[
(base)*cos(i/count*gap*prop/2-gap*prop/4)-sqrt(1-pow((-count/2+i)/(count/2),2))*0.25,
(base)*sin(i/count*gap*prop/2-gap*prop/4)]],
-mang-gap*prop/2+t*360/teeth))

(i<count)?concat([vec],dedendum(base,ad,teeth,t,count,i+1),result):result;


function involutetooth(base,ad,teeth,t,i=0,flank=[])=
let(x=base*(cos(i)+(i/180*PI)*sin(i)))
let(y=base*(sin(i)-(i/180*PI)*cos(i)))
let(dis=sqrt(pow(x,2)+pow(y,2)))
let(mdis=maxdis(base,ad,teeth,t))
let(mang=maxang(base,ad,teeth,t))
let(gap=(360-(2*mang*teeth))/(teeth))
let(prop=base/dis)
let(vec=rotvec([[x,y]],-mang-gap*prop/4+t*360/teeth))
(dis<ad)?concat([vec],involutetooth(base,ad,teeth,t,i+1,flank)):flank;

function involutetoothrev(base,ad,teeth,t,i=0,flank=[])=
let(x=base*(cos(i)+(i/180*PI)*sin(i)))
let(y=-base*(sin(i)-(i/180*PI)*cos(i)))
let(dis=sqrt(pow(x,2)+pow(y,2)))
let(mdis=maxdis(base,ad,teeth,t))
let(mang=maxang(base,ad,teeth,t))
let(gap=(360-(2*mang*teeth))/(teeth))
let(prop=base/dis)
let(vec=rotvec([[x,y]],mang+gap*prop/4+t*360/teeth))
(i>=0)?concat([vec],involutetoothrev(base,ad,teeth,t,i-1,flank)):flank;



function involutegear(rad,pin,pitch,teeth,t=0,result=[])=
let(base=rad*cos(pitch))
let(mod=(2*2*rad)/(teeth+pin))
let(ad=rad+mod)
let(minv=maxinv(base,ad,teeth,t))
let(mang=maxang(base,ad,teeth,t))
(t<teeth)?concat(dedendum(base,ad,teeth,t,6),involutetooth(base,ad,teeth,t,0),addendum(),involutetoothrev(base,ad,teeth,t,minv),involutegear(rad,pin,pitch,teeth,t+1,result)):result;



//echo(involutegear(inch,10,23));




difference(){
    gear=1*inch;
    hub=26+0.0035*inch; // 1/4*inch;
    ring=1/8*inch;
    corner=1/8*inch;
    sections=9;

/*    
    linear_extrude(25.4/4,convexity=48)
    polygon(points=involutegear(25.4,32,20,64));
*/
union(){
rotate([0,0,$t*360+360/128])
linear_extrude(25.4/8,twist=5, convexity=10,slices=10)
polygon(points=involutegear(25.4,32,20,64));

//color([1,0,0,0.4])
translate([0,0,1/8*inch])
rotate([0,0,-5+360/128])
linear_extrude(25.4/8,twist=-5, convexity=10,slices=10)
polygon(points=involutegear(25.4,32,20,64));
}
    translate([0,0,-0.1])
    cylinder(1/4*inch+0.2,hub/2,hub/2,$fn=240);
    
    translate([0,0,-0.1])
    for (i=[0:sections-1]){
        
        hull(){
        rotate([0,0,i*360/sections])
        
        translate([hub/2+ring+corner/2,0,0])
        cylinder(1/4*inch+0.2,corner/2,corner/2,$fn=48);
        ang=360/sections/4;
        rotate([0,0,i*360/sections]){
            rotate([0,0,ang])
            translate([gear-ring-corner/2,0,0])
            cylinder(1/4*inch+0.2,corner/2,corner/2,$fn=48);
            
            rotate([0,0,-ang])
            translate([gear-ring-corner/2,0,0])
            cylinder(1/4*inch+0.2,corner/2,corner/2,$fn=48);
            }
        }
    
    
        rotate([0,0,i*360/sections+360/(sections*2)])
        translate([hub/2+ring,0,0])
        cylinder(1/4*inch+0.2,corner/2,corner/2,$fn=48);
        

}
}


/*

// DEMO GEARS

//color([1,0,0,0.2])
rotate([0,0,360/128])
//linear_extrude(25.4/8,twist=5, convexity=10,slices=10)
polygon(points=involutegear(25.4,32,20,64));

//color([0,0,1,0.2])
translate([inch*1.5,0,0])
//linear_extrude(25.4/8,twist=-10, convexity=10,slices=10)
polygon(points=involutegear(12.7,64,20,32));

*/


// HERRINGBONE GEARS
/*
//color([1,0,0,0.4])
rotate([0,0,$t*360+360/128])
linear_extrude(25.4/8,twist=5, convexity=10,slices=10)
polygon(points=involutegear(25.4,32,20,64));

//color([1,0,0,0.4])
translate([0,0,1/8*inch])
rotate([0,0,-5+360/128])
linear_extrude(25.4/8,twist=-5, convexity=10,slices=10)
polygon(points=involutegear(25.4,32,20,64));
*/

/*
//color([0,0,1,0.4])
translate([inch*1.5,0,0])
linear_extrude(25.4/8,twist=-10, convexity=10,slices=10)
polygon(points=involutegear(12.7,64,20,32));

//color([0,0,1,0.4])
translate([inch*1.5,0,1/8*inch])
rotate([0,0,10])
linear_extrude(25.4/8,twist=10, convexity=10,slices=10)
polygon(points=involutegear(12.7,64,20,32));
*/



/*
r=$t*360;

for (i=[0:teeth-1]){
    rotate([0,0,i*360/teeth-r])
        for (j=[0:tooth_fineness]){
            k=1/j;
            
            X=(inch-mod)*(cos(j)+(j/180*PI)*sin(j));
            Y=(inch-mod)*(sin(j)-(j/180*PI)*cos(j));
            L=(inch-mod)/2*pow(j/180*PI,2);
            
            rotate([0,0,ang/4])
            translate([X,Y,0])
            cube(0.2);
            
            mirror([0,1,0])
            rotate([0,0,ang/4])
            translate([X,Y,0])
            cube(0.2);
        }
       
}
*/