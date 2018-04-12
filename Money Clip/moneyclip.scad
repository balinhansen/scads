inch=25.4;
bill_length=6.14*inch;
bill_width=2.61*inch;
bill_thickness=0.0043*inch;

shell=1.6;

comfort=0.0035*inch*2.5;

for(i=[0:100-1]){
    translate([0,0,i*(bill_thickness+0.00040*inch)])
    cube([bill_length,bill_width,bill_thickness]);
}

cube([1,1,3]);