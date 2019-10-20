slot=8.5;
slot_length=80;
slot_depth=65;
shell=2;

angle=0;

fineness=120;
small_fineness=40;

phone=14;
phone_length=80;
phone_depth=17;

cable_width=14;
cable_height=10;


distance=slot*tan(angle);
echo(distance);

module plug(length){
    translate([1,1,0]){
        cylinder(length,1,1,$fn=small_fineness);
        translate([0,cable_height-2,0])
        cylinder(length,1,1,$fn=small_fineness);
        
        translate([cable_width-2,0,0])
        cylinder(length,1,1,$fn=small_fineness);
        translate([cable_width-2,cable_height-2,0])
        cylinder(length,1,1,$fn=small_fineness);
        
        translate([0,-1,0])
        cube([cable_width-2,cable_height,length]);
        
        translate([-1,0,0])
        cube([cable_width,cable_height-2,length]);
    }
}

difference(){
    union(){
        translate([slot/2,slot/2,slot/2]){

            sphere(8.5/2,$fn=fineness);
            translate([slot_length-slot,0,0])
            sphere(slot/2,$fn=fineness);
        }


        translate([slot/2,slot/2,slot/2])
        rotate([0,90,0])
        cylinder(slot_length-slot,slot/2,slot/2,$fn=fineness);
   
difference(){
    union(){
        translate([slot/2,slot/2,slot/2]){
            cylinder(slot_depth-slot/2+distance+0.001,slot/2,slot/2,$fn=fineness);
            translate([slot_length-slot,0,0])
            cylinder(slot_depth-slot/2+distance+0.001,slot/2,slot/2,$fn=fineness);
        }

    translate([slot/2,0,slot/2])
    cube([slot_length-slot,slot,slot_depth-slot/2+distance+0.001]);
    }
    
    
    translate([0,0,slot_depth+0.001])
    rotate([angle,0,0])
    translate([-0.001,-0.001,0])
    cube([slot_length+0.002,sqrt(pow(distance,2)+pow(slot,2))+0.002,distance+0.001]);
    
}

}


   translate([(slot_length-cable_width)/2,cos(angle)*sqrt(pow(slot,2)+pow(distance,2))/2,slot_depth+sin(angle)*sqrt(pow(slot,2)+pow(distance,2))/2])
    rotate([angle,0,0])
    translate([0,-cable_height/2,-24])
    plug(25);
}


translate([-(phone_length-slot_length)/2,+shell*sin(angle)+cos(angle)*sqrt(pow(slot,2)+pow(distance,2))/2,-shell*cos(angle)+slot_depth+sin(angle)*sqrt(pow(slot,2)+pow(distance,2))/2])
rotate([angle,0,0]){
    translate([0,0,shell+phone/2])
    difference(){
        union(){
            sphere(shell+phone/2,$fn=fineness);
            translate([phone_length,0,0])
            sphere(shell+phone/2,$fn=fineness);
            rotate([0,90,0])
            cylinder(phone_length,shell+phone/2,shell+phone/2,$fn=fineness);
        }
        translate([-phone/2-shell-0.001,-phone/2-shell-0.001,0.001])
        cube([phone_length+shell*2+phone+0.002,shell*2+phone+0.002,shell+phone/2]);
        
        sphere(phone/2,$fn=fineness);
        translate([phone_length,0,0])
        sphere(phone/2,$fn=fineness);
        rotate([0,90,0])
        cylinder(phone_length,phone/2,phone/2,$fn=fineness);
        translate([(phone_length-cable_width)/2,-cable_height/2,-25])
        plug(25);
    }

    translate([0,0,phone/2+shell])
    difference(){
        union(){
            cylinder(phone_depth-phone/2,shell+phone/2,shell+phone/2,$fn=fineness);
            translate([phone_length,0,0])
            cylinder(phone_depth-phone/2,shell+phone/2,shell+phone/2,$fn=fineness);
            translate([0,-shell-phone/2,0])
            cube([phone_length,phone+shell*2,phone_depth-phone/2]);
        }
        translate([0,0,-0.001])
        union(){
            cylinder(phone_depth-phone/2+0.002,phone/2,phone/2,$fn=fineness);
            translate([phone_length,0,0])
            cylinder(phone_depth-phone/2+0.002,phone/2,phone/2,$fn=fineness);
            translate([0,-phone/2,0])
            cube([phone_length,phone,phone_depth-phone/2+0.002]);
        }
    }
    
    
}


