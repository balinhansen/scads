LEA=30; // Leading Edge Angle
LER=10; // Leading Edge Radius
MT=14; // Maximum Thickness
MTD=10; // Maximum Thickness Distance
TEA=-15; // Trailing Edge Angle

/*
rotate([0,0,LEA])
translate([LER,0])
circle(10);
*/

//square([100,1]);

module NACA_Four_Demo(C,CD,T,S){
    t=0.15;
    c=0.05;
    cd=0.35;
    s=1;
    
    for (xp=[0:99]){
        x=xp/100;
       // translate([xp,0])
      // square([1,xp]);
        
    Yt=(5*t*(0.2969*sqrt(x)-0.1260*x-0.3516*pow(x,2)+0.2843*pow(x,3)-(s?0.1015:0.1036)*pow(x,4))<=0)?0.00001:5*t*(0.2969*sqrt(x)-0.1260*x-0.3516*pow(x,2)+0.2843*pow(x,3)-(s?0.1036:0.1015)*pow(x,4));
        
        Yc=(x<cd)?((c)/pow(cd,2))*(2*cd*x-pow(x,2)):(c)/pow((1-cd),2)*((1-2*cd)+2*cd*x-pow(x,2));
        
        der=(x<cd)?2*c/pow(cd,2)*(cd-x):(2*c)/pow((1-cd),2)*(cd-x);
        
        theta=atan(der);
    
        translate([xp,((-Yt*100*2)/2)])
        square([1,Yt*100*2]);
        
        translate([xp,40+Yc*100])
        square([1,1]);
        
        translate([xp,20])
        rotate([0,0,theta])
        translate([0,-10])
        square([0.2,20]);
 
        translate([0,Yc*100+80])
        translate([xp,0])
        rotate([0,0,theta])
        translate([0,-Yt*100,0])
        square([1,Yt*100*2]);
        
    }
    
}

//NACA_Four_Demo(0,0,0);

function naca_four(m,p,t,s,f,i=0,result=[])=
let (
    edge=1/f/2/2,
    odd=(f%2==1)?edge:0,
    low=i<(f/2),
    x=(((i==0 || i==(f-1)) && odd)?edge:(odd && i==((f-1)/2))?0.25:low?i/f/2:0.5-(odd?edge:0)-i/f/2)*4,
    coef=s?0.1036:0.1015,
    Yt=(5*t*(0.2969*sqrt(x)-0.1260*x-0.3516*(x*x)+0.2843*(x*x*x)-coef*(x*x*x*x))),
    Yc=(x<p)?((m)/(p*p)*(2*p*x-(x*x))):(m)/((1-p)*(1-p))*((1-2*p)+2*p*x-(x*x)),
    drv=(x<p)?2*m/(p*p)*(p-x):(2*m)/((1-p)*(1-p))*(p-x),
    theta=atan(drv),
sxl=x+Yt*sin(theta),
sxu=x-Yt*sin(theta),
syl=Yc-Yt*cos(theta),
syu=Yc+Yt*cos(theta),
    sx=(low)?sxl:sxu,
    sy=(low)?syl:syu
)
(i<f)?naca_four(m,p,t,s,f,i+1,concat(result,[[sx,sy]])):result;


airfoil=naca_four(0.12,0.4,0.1,1,26);
attack=125;
blade=10/sin(attack);
blade_length=15;
turbine_radius=35;
ring_thickness=2;
ring_fineness=60;
echo(blade);

difference(){
    cylinder(10,turbine_radius,turbine_radius,$fn=ring_fineness);
    translate([0,0,-0.01])
    cylinder(10.02,turbine_radius-ring_thickness,turbine_radius-ring_thickness,$fn=ring_fineness);
}

difference(){
for (i=[0:24]){
    rotate([0,0,360/25*i])
    translate([0,0,5])
    rotate([-attack,0,0])
    translate([turbine_radius-0.5,0])
    rotate([90,0,0])
    rotate([0,90,0])
    translate([-blade/2,0,0])
    
    linear_extrude(blade_length+1,convexity=10)
    scale([blade,blade])
    polygon(points=airfoil);

}

difference(){
    cylinder(10,turbine_radius+blade_length+1,turbine_radius+blade_length+1,$fn=ring_fineness);
    translate([0,0,-0.01])
    cylinder(10.02,turbine_radius+blade_length,turbine_radius+blade_length,$fn=ring_fineness);
}
}