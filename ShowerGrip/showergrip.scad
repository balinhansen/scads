fineness=40;
big_fineness=160;

slip_angle=90;
clasp_angle=120;
grip_angle=60;

thickness=3;
pipe=20;
clasp_radius=2.5;
rope=2;

module band(){
    translate([pipe/2+thickness/2,0])
    hull(){
        translate([0,thickness/2,0])
        circle(thickness/2,$fn=fineness);
        translate([0,pipe-thickness/2,0])
        circle(thickness/2,$fn=fineness);
    }
}


module clasp(){
    translate([clasp_radius+thickness/2,0])
    hull(){
        translate([0,thickness/2,0])
        circle(thickness/2,$fn=fineness);
        translate([0,pipe-thickness/2,0])
        circle(thickness/2,$fn=fineness);
    }
}

module grip_ring(){
    translate([pipe/2+thickness/2,0])
    hull(){
        translate([0,thickness/2])
        circle(thickness/2,$fn=fineness);
        translate([thickness,thickness/2])
        circle(thickness/2,$fn=fineness);
    }
}

module grip_end(){
    translate([pipe/2+thickness/2,0])
    hull(){
        translate([0,0])
        sphere(thickness/2,$fn=fineness);
        translate([thickness,0])
        sphere(thickness/2,$fn=fineness);
    }
}

module grip(){
rotate([0,0,180-grip_angle/2])
rotate_extrude(angle=grip_angle,convexity=10,$fn=big_fineness)
grip_ring();


rotate([0,0,180-grip_angle/2])
translate([0,0,thickness/2])
grip_end();

rotate([0,0,180+grip_angle/2])
translate([0,0,thickness/2])
grip_end();
}




rotate([0,0,slip_angle/2])
rotate_extrude(angle=360-slip_angle,convexity=10,$fn=big_fineness)
band();

translate([(thickness+pipe/2)*cos(slip_angle/2),-(thickness+pipe/2)*sin(slip_angle/2),0])
mirror([cos(-slip_angle/2),sin(-slip_angle/2),0])
translate([-clasp_radius*cos(slip_angle/2),clasp_radius*sin(slip_angle/2),0])
rotate([0,0,-slip_angle/2])
rotate_extrude(angle=clasp_angle,$fn=big_fineness)
clasp();

translate([(thickness+pipe/2)*cos(slip_angle/2),(thickness+pipe/2)*sin(slip_angle/2),0])
mirror([cos(slip_angle/2),sin(slip_angle/2),0])
translate([-clasp_radius*cos(slip_angle/2),-clasp_radius*sin(slip_angle/2),0])
rotate([0,0,slip_angle/2])
rotate_extrude(angle=-clasp_angle,$fn=big_fineness)
clasp();



    translate([(thickness/2+clasp_radius)*cos(clasp_angle+180+slip_angle/2),(thickness/2+clasp_radius)*sin(clasp_angle+180+slip_angle/2),0])
    
    translate([(thickness/2+clasp_radius)*cos(slip_angle/2),(thickness/2+clasp_radius)*sin(slip_angle/2),0])
    
    translate([(thickness/2+pipe/2)*cos(slip_angle/2),(thickness/2+pipe/2)*sin(slip_angle/2),0])
hull(){
    translate([0,0,thickness/2+rope])
    sphere(thickness/2+rope,$fn=fineness);
    translate([0,0,pipe-thickness/2-rope])
    sphere(thickness/2+rope,$fn=fineness);
}


    translate([(thickness/2+clasp_radius)*cos(-clasp_angle+180-slip_angle/2),(thickness/2+clasp_radius)*sin(-clasp_angle+180-slip_angle/2),0])

    translate([(thickness/2+clasp_radius)*cos(-slip_angle/2),(thickness/2+clasp_radius)*sin(-slip_angle/2),0])
    
    translate([(thickness/2+pipe/2)*cos(-slip_angle/2),(thickness/2+pipe/2)*sin(-slip_angle/2),0])
hull(){
    translate([0,0,thickness/2+rope])
    sphere(thickness/2+rope,$fn=fineness);
    translate([0,0,pipe-thickness/2-rope])
    sphere(thickness/2+rope,$fn=fineness);
}




translate([0,0,(pipe-11)/2-thickness])
grip();

translate([0,0,(pipe-11)/2+11])
grip();

//translate([0,0,pipe-thickness])
//grip();