function SearsHaack(L,V,x)=(16*V)/(3*L*PI)*sqrt(pow(4*x*(1-x),3));

function SearsHaackRadius(L,V,x)=sqrt(SearsHaack(L,V,x)/PI);

function PointCircle(r,z,fine,i=0,result=[])=i<=fine?PointCircle(r,z,fine,i+1,concat(result,[[cos(i*360/fine)*r,sin(i*360/fine)*r,z]])):result;

function FanFrom(f,v,i=1,result=[])=i<=v?FanFrom(f,v,i+1,concat(result,[[f,f+i,f+i+1]])):result;

function FanTo(t,v,i=0,result=[])=i<v?FanTo(t,v,i+1,concat(result,[[t,t-1-v+i+1,t-1-v+i]])):result;

function Strip(s,v,i=0,result=[])=i<v?Strip(s,v,i+1,concat(result,[[s+i,s+i+v+1,s+i+1],[s+i+1,s+i+v+1,s+v+i+2]])):result;

function HaackBodyPoints(L,V,res=1,fine,i=1,result=[[0,0,0]])=i<L?HaackBodyPoints(L,V,res,fine,i+res,concat(result,PointCircle(SearsHaackRadius(L,V,i/L),i,fine))):concat(result,[[0,0,L]]);

function HaackBodyPolys(L,fine,res=1,i=0,result=[])=let (result=!len(result)?FanFrom(0,fine):result)i<(L-2)?HaackBodyPolys(L,fine,res,i+res,concat(result,Strip(1+(i*(fine+1)),fine))):concat(result,FanTo(1+(i+1)*(fine+1),fine));

module SearsHaackModel(L,V,fine){
    for (t=[0:L]){
        translate([0,0,t])
        circle(SearsHaackRadius(L,V,t/L),$fn=fine);
    }
}

module SearsHaackMesh(L,V,fine){
    polyhedron(points=HaackBodyPoints(L,V,1,fine),faces=HaackBodyPolys(L,fine,1),convexity=10);
}

module HaackCone(l,r,c,res,fine) // length, radius, haack coefficient, resolution, fineness
{
    edges=l/res;
    function theta(x) = acos(1 - 2*x/l);
    function y(x) = r * sqrt(theta(x)*PI/180 - sin(2*theta(x))/2 + c * pow(sin(theta(x)), 3)) / sqrt(PI);

    cone=concat([[0, 0]], [ for (i = [0 : edges]) let (x = i * l / edges) [y(l - x), x] ]);
    
    rotate_extrude($fn=fine)       
        polygon(points=cone);
}


