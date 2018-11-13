inch=25.4;
foot=12*inch;
two=1.625*inch;
four=3.625*inch;
six=5.625*inch;
eight=7.625*inch;
wall=0.625*inch;

module space(l,w){
    cube([l,w,8*foot]);
}


// Master Bed

color([1,0,0,0.4]){

    translate([four+wall,four+wall,0])
    space(12*foot,12*foot);


    translate([four+wall+3*foot,-6*foot])
    space(9*foot,6*foot);

    translate([-30*inch-wall,12*foot-66*inch+wall+four])
    space(30*inch,66*inch);
    
}

// Dining Room

color([1,0.6,0,0.4]){
    translate([-30*inch*2-wall*3-four,12*foot-66*inch+wall+four])
    space(30*inch,66*inch);

    translate([-30*inch*2-wall*5-four*2-12*foot,four+wall,0])
    space(12*foot,12*foot);
}

color([1,0,1,0.4]){
    translate([-wall-30*inch*2-wall*2-four,0])
    space(30*inch*2+wall*2+four,12*foot-60*inch-wall*2-four);
}