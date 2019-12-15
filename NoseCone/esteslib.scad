fineness=96;

inch=25.4;
rod=5/32*inch;
shell=0.4;

kerf=0.0035*inch;


module engine(r,l,f){
    difference(){
        cylinder(l,r,r,$fn=f);   
        translate([0,0,l-5])
        cylinder(5.001,r-2.5,r-2.5,$fn=f);
        
        translate([0,0,-0.001])
        cylinder(1.5+0.001,r-2.5,r-2.5,$fn=f);
        
        translate([0,0,1.5-0.001])
        cylinder(1.5,r-2.5,0,$fn=f);
        
        translate([0,0,3-0.6])
        cylinder(10,2.5,1.4,$fn=f);
    }
}

module engine24mm(){
    r=24/2;
    l=95;
    engine(r,l,fineness);
}


module engine18mm(){
    r=18/2;
    l=70;
    engine(r,l,fineness);
}


module engine13mm(){
    r=13/2;
    l=45;
    engine(r,l,fineness);
}


module lug(length){
    difference(){
            cylinder(length,shell+rod/2+kerf*2,shell+rod/2+kerf*2,$fn=240);
            translate([0,0,-0.001])
            cylinder(length+0.002,rod/2+kerf*2,rod/2+kerf*2,$fn=240);
        }
    
}

module estesdemo(){
translate([-9-13-2-rod/2-shell,0,0])
lug(1*inch);
translate([-6.5-9-1,0,0])
engine13mm();
engine18mm();
translate([9+12+1,0,0])
engine24mm();
}

//estesdemo();