inch=25.4;

cylinder((1/8-1/32)*inch,3/16*inch,3/16*inch,$fn=100);

translate([0,0,(1/8-1/32)*inch])
cylinder(1/4*inch,3/32*inch,3/32*inch,$fn=100);

translate([0,0,(1/4+1/8-1/32)*inch])
cylinder((1/8-1/32)*inch,3/16*inch,3/16*inch,$fn=100);