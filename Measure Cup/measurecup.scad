inch=25.4;

ounces=2;


ml=ounces*29.5735;

eleventh=ml/11;

void_top_width=1.75*inch;
void_bottom_width=1.25*inch;

top_clearance=0.25*inch;


r1=void_bottom_width/2;
r2=void_top_width/2;

void_height=(1000*ml)/(1/3*PI*(pow(r1,2)+pow(r2,2)+r1*r2));

echo(void_height);

cylinder(void_height,void_bottom_width/2,void_top_width/2,$fn=80);
