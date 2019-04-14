zheight=0.4;
width=0.8;

module line(a=[0,0],b=[0,0]){
    dist=sqrt(pow(b[1]-a[1],2)+pow(b[0]-a[0],2));
    ang=atan((b[1]-a[1])/(b[0]-a[0]));
    angmod=
    ((b[0]<a[0])&&(b[1]>=a[1]))?-180:
    ((b[0]>=a[0])&&(b[1]<=a[1]))?0:
    ((b[0]<=a[0])&&(b[1]<=a[1]))?-180:0;
    
    translate([a[0],a[1],0])
    rotate([0,0,ang+angmod])
    translate([-width/2,-width/2,0])
    cube([dist+width,width,zheight]);
}

module extrusion(p,n,a=[0,0],b=[0,0]){
    dist=sqrt(pow(b[1]-a[1],2)+pow(b[0]-a[0],2));
    ang=atan((b[1]-a[1])/(b[0]-a[0]));
    angmod=
    ((b[0]<a[0])&&(b[1]>=a[1]))?-180:
    ((b[0]>=a[0])&&(b[1]<=a[1]))?0:
    ((b[0]<=a[0])&&(b[1]<=a[1]))?-180:0;
    
    translate([a[0],a[1],0])
    rotate([0,0,ang+angmod])
rotate([0,90,0])
rotate([0,0,90])
    linear_extrude(dist,convexity=10)
    polygon(p);
}

module drawlines(args){
    for (i=[0:len(args)-2]){
        line([args[i][0],args[i][1]],[args[i+1][0],args[i+1][1]]);
    }
}


module drawextrusions(p,n,l){
    for (i=[0:len(l)-2]){
        extrusion(p,n,[l[i][0],l[i][1]],[l[i+1][0],l[i+1][1]]);
    }
}

module linesquare(size){
    union(){
        drawlines([[0,0],[size,0],[size,size],[0,size],[0,0]]);
    }
}
//linear_extrude(10,convexity=10)
//polygon(points=[[0,0],[1,0],[1,1],[0,1]]);

linesquare(114);
extrusion([[0,0],[1,0],[1,1],[0.5,2],[0,1]],[0,0,1],[0,200],[100,100]);

drawextrusions([[0,0],[1,0],[1,1],[0.5,2],[0,1]],[0,0,1],[[0,1],[0,2],[1,2]]);