inch=25.4;
bill_length=6.14*inch;
bill_width=2.61*inch;
bill_thickness=0.0043*inch;
bill_count=100;

shell=1.6;

echo(bill_width);
echo(bill_length);


comfort=0.0035*inch*2.5;

module flat_bills(){
    for(i=[0:bill_count-1]){
        translate([0,0,i*(bill_thickness+0.00040*inch)])
        cube([bill_length,bill_width,bill_thickness]);
    }
}

module case_bills(){
    
    translate([shell+comfort,shell+comfort,shell])
    flat_bills();
    
}

flat_bills();