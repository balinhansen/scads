fineness=96;
size=10;
div=2;
fins=1.6;
shell=2.0;
inch=25.4;

kerf=0.0035*inch;

module spheraboloid(){

rotate_extrude(angle=360,convexity=10,$fn=fineness)
difference(){
hull()
for (i=[0:size]){
    if (i!=size){
        for (x=[1:div-1]){
            translate([0,(i+x/div)*((i+x/div)-1)/2+1+1])
            circle(i+x/div,$fn=fineness);
        }
    }else{
    
        translate([0,i*(i-1)/2+1+1])
        circle(i,$fn=fineness);
    }   
}

translate([-size,0])
square([size,(size+1)*(size)/2+1+1]);

translate([-0.001,size*(size-1)/2+1+1])
square([size+0.002,size]);


}}



function SearsHaack(L,V,x)=(16*V)/(3*L*PI)*sqrt(pow(4*x*(1-x),3));

function SearsHaackRadius(L,V,x)=sqrt(SearsHaack(L,V,x)/PI);

function PointCircle(r,z,fine,i=0,result=[])=i<=fine?PointCircle(r,z,fine,i+1,concat(result,[[cos(i*360/fine)*r,sin(i*360/fine)*r,z]])):result;

function FanFrom(f,v,i=1,result=[])=i<=v?FanFrom(f,v,i+1,concat(result,[[f,f+i,f+i+1]])):result;

function FanTo(t,v,i=0,result=[])=i<v?FanTo(t,v,i+1,concat(result,[[t,t-1-v+i+1,t-1-v+i]])):result;

function Strip(s,v,i=0,result=[])=i<v?Strip(s,v,i+1,concat(result,[[s+i,s+i+v+1,s+i+1],[s+i+1,s+i+v+1,s+v+i+2]])):result;

function HaackBodyPoints(L,V,res=1,fine,i=1,result=[[0,0,0]])=i<L?HaackBodyPoints(L,V,res,fine,i+res,concat(result,PointCircle(SearsHaackRadius(L,V,i/L),i,fine))):concat(result,[[0,0,L]]);

function HaackBodyPolys(L,fine,res=1,i=0,result=[])=let (result=!len(result)?FanFrom(0,fine):result)i<(L-2)?HaackBodyPolys(L,fine,res,i+res,concat(result,Strip(1+(i*(fine+1)),fine))):concat(result,FanTo(1+(i+1)*(fine+1),fine));

//echo(HaackBodyPoints(200,200*PI,100,1,10));
//echo(FanTo(39,10));
//echo(FanFrom(12,10));

//echo(SearsHaack(200,200*PI,100/200));

//echo(HaackBodyPoints(3,20,1,4));
//echo(len(HaackBodyPoints(3,20,1,4)));

//echo(HaackBodyPolys(3,4,1));
//echo(len(HaackBodyPolys(3,4,1)));

module SearsHaackModel(L,V){
    for (t=[0:L]){
        translate([0,0,t])
        circle(SearsHaackRadius(L,V,t/L),$fn=fineness);
    }
}

module SearsHaackMesh(L,V,fine){
    polyhedron(points=HaackBodyPoints(L,V,1,fine),faces=HaackBodyPolys(L,fine,1),convexity=10);
}

//SearsHaackModel(2,10);
//SearsHaackModel(100,1000*PI);

module rocket(){

    difference(){
        
    SearsHaackMesh(150,12000*PI,240);
        
        cylinder(70+25,9+kerf,9+kerf,$fn=240);
        
    }

    module fin(){
        translate([-9,0,0])
        rotate([90,0,0])
        translate([0,0,-0.8])
        linear_extrude(1.6,convexity=10)
        polygon(points=[[0,35],[0,65],[-30,20],[-30,0]]);
        
    }

    for (i=[0:3]){
        rotate([0,0,360/4*i])
        fin();
    }

}
//SearsHaackMesh(30,200,48);


module engine(){
    difference(){
        cylinder(70,9,9,$fn=48);   
        translate([0,0,65])
        cylinder(5.001,9-2.5,9-2.5,$fn=48);
        
        translate([0,0,-0.001])
        cylinder(1.5+0.001,9-2.5,9-2.5,$fn=48);
        
        translate([0,0,1.5-0.001])
        cylinder(1.5,9-2.5,0,$fn=48);
        
        translate([0,0,3-0.6])
        cylinder(10,2.5,1.4,$fn=48);
    }
}


/*
rocket();
translate([0,0,25])
engine();

*/



difference(){
    cylinder(70+shell,9+shell,9+shell,$fn=240);
    translate([0,0,-0.001])
    cylinder(70,9,9,$fn=240);
}



//engine();

adj=((shell+1/16*inch+2*kerf)/((1/16*inch+shell+9+4*kerf+1/16*inch)*PI*2))*360;

rotate([0,0,45+adj])
translate([1/16*inch+shell+9+kerf+2*kerf,0,0])
difference(){
    cylinder(1.*inch,1/16*inch+shell+2*kerf,1/16*inch+shell+2*kerf,$fn=48);
    translate([0,0,-0.001])
    cylinder(1.0*inch+0.002,1/16*inch+2*kerf,1/16*inch+2*kerf,$fn=48);
}

rotate([0,0,180+45+adj])
translate([1/16*inch+shell+9+kerf+2*kerf,0,0])
difference(){
    cylinder(1.*inch,1/16*inch+shell+2*kerf,1/16*inch+shell+2*kerf,$fn=48);
    translate([0,0,-0.001])
    cylinder(1.0*inch+0.002,1/16*inch+2*kerf,1/16*inch+2*kerf,$fn=48);
}



translate([0,0,50.8])
difference(){
    SearsHaackMesh(40,9000,240);
    translate([0,0,10-0.001])
    cube([18+kerf*2+shell*2+0.1,18+kerf*2+shell*2+0.1,20.001],center=true);
}

for (i=[0:3]){
    rotate([0,0,45+360/4*i])
    translate([9+kerf+shell-0.15,0,0])
    rotate([90,0,0])
    translate([0,0,-shell/2])
    linear_extrude(shell,convexity=10)
    polygon([[0,0],[0,1.5*inch],[1*inch,0],[1*inch,-0.75*inch],[0.75*inch,-0.75*inch]]);
}
