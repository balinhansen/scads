sphere_fineness=200;

iter=72;
fineness=48;

eye_fineness=48;
eye_size=1;
eye_width=40;
eye_space=10;
eye_pos=-10;


mouth_size=1;
mouth_iter=144;
mouth_width=40;
mouth_curve=-5;
mouth_pos=20;

difference(){
    
    sphere(10, $fn=sphere_fineness);

//hull(){
    for (i=[0:iter]){
        if (i<=(iter/2)){
            rad=(i==0 || i==iter)?1/iter*sin(i/iter*180):i/(iter/2)*sin(i/iter*180);
            rotate([0,0,eye_space+eye_width*i/iter])
            rotate([eye_pos-5*i/iter,0])
            rotate([0,0,-90])
            translate([10,0,0])
                sphere(rad*eye_size,$fn=fineness);
    
        }else{
            rad=(i==0 || i==iter)?1/iter*sin(i/iter*180):(iter-i)/(iter/2)*sin(i/iter*180);
        
            rotate([0,0,eye_space+eye_width*i/iter])
            rotate([eye_pos-5*i/iter,0])
            rotate([0,0,-90])
            translate([10,0,0])
                sphere(rad*eye_size,$fn=fineness);
    
        }         
    }
//}



mirror([1,0,0])
//hull(){
    for (i=[0:iter]){
        if (i<=(iter/2)){
            rad=(i==0 || i==iter)?1/iter*sin(i/iter*180):i/(iter/2)*sin(i/iter*180);
            rotate([0,0,eye_space+eye_width*i/iter])
            rotate([eye_pos-5*i/iter,0])
            rotate([0,0,-90])
            translate([10,0,0])
                sphere(rad*eye_size,$fn=fineness);
    
        }else{
            rad=(i==0 || i==iter)?1/iter*sin(i/iter*180):(iter-i)/(iter/2)*sin(i/iter*180);
        
            rotate([0,0,eye_space+eye_width*i/iter])
            rotate([eye_pos-5*i/iter,0])
            rotate([0,0,-90])
            translate([10,0,0])
                sphere(rad*eye_size,$fn=fineness);
    
        }         
    }
//}


//hull(){
    for (i=[0:mouth_iter]){
        if (i<=(mouth_iter/2)){
            rad=(i==0 || i==mouth_iter)?1/mouth_iter*sin(i/mouth_iter*180):i/(mouth_iter/2)*sin(i/mouth_iter*180);
            rotate([0,0,-mouth_width/2+mouth_width*i/mouth_iter])
            rotate([mouth_pos-mouth_curve+mouth_curve*i/mouth_iter,0])
            rotate([0,0,-90])
            translate([10,0,0])
                sphere(rad*mouth_size,$fn=fineness);
    
        }else{
            rad=(i==0 || i==mouth_iter)?1/mouth_iter*sin(i/mouth_iter*180):(mouth_iter-i)/(mouth_iter/2)*sin(i/mouth_iter*180);
        
            rotate([0,0,-mouth_width/2+mouth_width*i/mouth_iter])
            rotate([mouth_pos-mouth_curve*i/mouth_iter,0])
            rotate([0,0,-90])
            translate([10,0,0])
                sphere(rad*mouth_size,$fn=fineness);
    
        }         
    }
}


//}


            rotate([0,0,eye_space+eye_width/2])
            rotate([eye_pos-2.5,0])
            rotate([0,0,-90])
            translate([10-eye_size,0,0])
                sphere(eye_size,$fn=eye_fineness);


mirror([1,0,0])
            rotate([0,0,eye_space+eye_width/2])
            rotate([eye_pos-2.5,0])
            rotate([0,0,-90])
            translate([10-eye_size,0,0])
                sphere(eye_size,$fn=eye_fineness);