fineness=96;
size=10;
div=2;

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

echo(Strip(2,3));

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

/*
difference(){
    
SearsHaackMesh(100,8000*PI,240);
    
    cylinder(70,9,9,$fn=240);
    
}
*/

SearsHaackMesh(30,200,48);