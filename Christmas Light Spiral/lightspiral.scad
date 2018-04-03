module hole_spiral(count){
    for (i=[1:count]){
        T=sqrt(i)*200;
        translate([T/30*cos(T),T/30*sin(T),0])
        children();
    }
}

module cut_spiral(count){
    for (i=[1:count]){
        hull(){
        T=sqrt(i)*200;
        translate([T/30*cos(T),T/30*sin(T),0])
        children();
        
            if (i==count){
                U=sqrt(i)*200;
                translate([(10+U/30)*cos(U),(10+U/30)*sin(U),0])
                children();
            }else{
                U=sqrt(i+1)*200;
                translate([U/30*cos(U),U/30*sin(U),0])
                children();

            }
        }
    }
}


difference(){
    translate([50,50,9])
    cylinder(1.6,50,50,$fn=240);
    
    translate([48,53,0])
    hole_spiral(50)
    cylinder(18,8.54/2,9.54/2,$fn=30);
    
    translate([48,53,0])
    cut_spiral(50)
    cylinder(18,3/2,3/2,$fn=16);
}
    translate([48,53,0])
    hole_spiral(50)
    cylinder(18,8.5/2,9.5/2,$fn=30);


    