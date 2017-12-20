inch=25.4;
ingot_count=10;
kerf=0.007*inch;
layers=3;
coef=layers-1;
width=2.54;
wall=2;
rows=2;

module silver_round(){
    
    cylinder(2.54,39/2,39/2,$fn=360);
    
}

theta=atan(((wall+width+kerf*2)*layers)/39);
//theta=30;

ws=wall*(layers-1)+width*layers+kerf*2*(layers-1);

transit=sqrt(pow(ws/tan(theta),2)+pow(ws,2));

echo(transit);

for (h=[0:rows-1]){
for (i=[0:ingot_count/rows-1]){


translate([cos(theta)*(39/2)+(transit/layers)*i,h*(39+wall)+39/2,sin(theta)*39/2])
rotate([0,theta,0])
silver_round();

}}