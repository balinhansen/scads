use_bed_size=1;
bed_size=200;
fineness=60;
bar_length=40;
bar_width=25.4/2;
do_hull=1;
do_caps=1;
do_hull_caps=1;
do_bucky=0;
orb_size=25.4*0.875;
use_hole=0;
hole_width=2.2;
hole_fineness=36;
numbers=1;
number_font_auto=1;
number_font_size=20;
number_font_depth=2;
number_font="Liberation Sans:style=Bold";

module stick(length,width){
    rotate([0,90,0])
    cylinder(length,width/2,width/2,$fn=fineness);
    
    if (do_caps && !do_hull || do_hull_caps){
        
        if (do_bucky==1){
            rotate([0,90,0])
            sphere(orb_size/2,$fn=fineness);
        }else{
            rotate([0,90,0])
            sphere(width/2,$fn=fineness);
        }
        translate([length,0,0])
        rotate([0,90,0])
        sphere(width/2,$fn=fineness);
    }
    
}

module stick_truc(length,width){
    rotate([0,90,0])
    cylinder(length,width/2,width/2,$fn=fineness);
    if (do_caps && !do_hull || do_hull_caps){
        if (do_bucky==1){
            rotate([0,90,0])
            sphere(orb_size/2,$fn=fineness);
        }else{
            rotate([0,90,0])
            sphere(width/2,$fn=fineness);
        }
    }
}

module stick_no(length,width){
    rotate([0,90,0])
    cylinder(length,width/2,width/2,$fn=fineness);
    
}


module pentagon(length,width){

    for (i=[4]){
        rotate([0,0,72*i])
        translate([-length/2,-length/2/tan(36),0])
        stick_no(length,width);
    }
    
    for (i=[0,2]){
        rotate([0,0,72*i])
        translate([-length/2,-length/2/tan(36),0])
        stick_truc(length,width);
    }
}


module dodecahalf(length,width){
    translate([0,0,-sin(acos(-1/sqrt(5)))*(sin(108)*length+sin(108-72)*length/2)]){
        
        for (i=[0:4])
            rotate([0,0,72*i])
            translate([0,-length/2/tan(36),0])
            rotate([acos(-1/sqrt(5)),0,0])
            translate([0,length/2/tan(36),0])
            pentagon(length,width);
    }
}


module assemble_dodecahedron(length, width){    
    dodecahalf(length,width);
    rotate([180,0,0])
    mirror([1,0,0])
    dodecahalf(length,width);
    
}

module place_numbers(length,width){
    //color([0,0,1,1])
    
    auto_font=length/ln(5);
    
    // 1
    translate([0,0,sin(acos(-1/sqrt(5)))*(sin(108)*length+sin(108-72)*length/2)+0.1-number_font_depth+width/2])
    linear_extrude(number_font_depth+0.1,convexity=10)
    text("1", font=number_font,size=number_font_auto?auto_font:number_font_size,halign="center",valign="center");
    
    
    // 12
    translate([0,0,-sin(acos(-1/sqrt(5)))*(sin(108)*length+sin(108-72)*length/2)-0.1-width/2])
    linear_extrude(number_font_depth+0.1,convexity=10)
    rotate([0,180,0])
    text("12", font=number_font,size=number_font_auto?auto_font:number_font_size,halign="center",valign="center");
    
    bottom=["7","9.","11","10","8"];
    
    for (i=[0:4]){
        mirror([0,0,1])
        
        rotate([0,0,72*i++180+72])
        rotate([acos(-1/sqrt(5)),0,0])
        
        translate([0,0,-sin(acos(-1/sqrt(5)))*(sin(108)*length+sin(108-72)*length/2)-1-width/2])
        
        rotate([0,0,180])
        linear_extrude(number_font_depth+1,convexity=10)
        //rotate([0,180,0])
        text(bottom[i], font=number_font,size=number_font_auto?auto_font:number_font_size,halign="center",valign="center");
        
    }
    
    
    top=["2","3","5","6.","4"];
    
    for (i=[0:4]){
           
        rotate([0,0,72*i+72*3])
        rotate([acos(-1/sqrt(5)),0,0])
        
        translate([0,0,-sin(acos(-1/sqrt(5)))*(sin(108)*length+sin(108-72)*length/2)-1-width/2])
        
        linear_extrude(number_font_depth+1,convexity=10)
        rotate([0,180,0])
        rotate([0,0,180])
        text(top[i], font=number_font,size=number_font_auto?auto_font:number_font_size,halign="center",valign="center");
        
    }
}

module hull_dodecahedron(length,width){
    if (numbers){
        difference(){
            hull()
            assemble_dodecahedron(length,width);
            place_numbers(length,width);
        }
    }else{
        hull()
        assemble_dodecahedron(length,width);
    }
}


module hull_bed_dodecahedron(bed,thickness){
    actual_base=(bed-thickness-(do_bucky?(orb_size-thickness):0))/4;
    half_stick=actual_base*2*tan(36);
    
    if (numbers){
        difference(){
            hull()
            bed_dodecahedron(bed,thickness);
            place_numbers(half_stick,thickness);
        }
    }else{
        hull()
        assemble_dodecahedron(half_stick,thickness);
    }
}


module bed_dodecahedron(bed,thickness){
    actual_base=(bed-thickness-(do_bucky?(orb_size-thickness):0))/4;
    half_stick=actual_base*2*tan(36);
    assemble_dodecahedron(half_stick,thickness);
}

module render(){
    if (use_bed_size){
        if (do_hull){
            hull_bed_dodecahedron(bed_size,bar_width);
        }else{
            bed_dodecahedron(bed_size,bar_width);
        }
    }else{
        if (do_hull){
            hull_dodecahedron(bar_length,bar_width);
        }else{
            assemble_dodecahedron(bar_length,bar_width);
        }
    }
}

if (do_hull && use_hole){
    difference(){
        length=use_bed_size?bed_size:bar_length/2/tan(36)*4;
        render();
        translate([0,0,-length/2-0.1])
        cylinder(length+0.2,hole_width/2,hole_width/2,$fn=  hole_fineness);
    }
}else{
    render();
}