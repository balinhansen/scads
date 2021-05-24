use_seed=1;
random_seed=0706209;
print_seed=1;
filter_size=2;
cone_angle=90;
edge_length_inches=4.25;
top_length_inches=2;
peak_inches=2.25;
hole=1;
hole_inches=3.5;
hole_head_inches=0.375;
hole_neck_inches=0.1875;
hole_cladding=2;
hole_shell_depth=4;
hole_fineness=128;
hole_recess=2;
glacier_depth_inches=0.5;
glacier_mirror=0;
glacier_jagged=0;
glacier_round=1;
glacier_points_random=1;
glacier_points=11;
glacier_points_min=17;
glacier_points_max=47;
capacity=100;
paper_thickness=0.4;
base_width_inches=0;
base_thickness=16;
seed_plaque=1;
plaque_thickness=1.6;
plaque_depth=1.2;
font_size_inches=0.25;
base_arc_fineness=240;
thickness=12;
show_example=1;
inch=25.4;
alt_text="";

actual_seed=use_seed?random_seed:floor(rands(0,9999999,1)[0]);

actual_glacier_points=round(glacier_points_random?rands(glacier_points_min,glacier_points_max,1,actual_seed)[0]:glacier_points);

glacier_data=rands(0,1,actual_glacier_points,actual_seed);

function arrayshift(arr,i=0,results=[])=(i<len(arr))?concat(arr[i],arrayshift(arr,i+1,results)):results;

glacier_data_b=arrayshift(rands(0,1,actual_glacier_points*2,actual_seed),actual_glacier_points);

    tip=tan(cone_angle/2)*base_thickness;
    radius=(edge_length_inches*inch+top_length_inches/2)/cos(cone_angle/2);
    base_length=tan(cone_angle/2)*(radius+base_thickness)*2+tip*2;
    edge_radius=(radius+base_thickness)/cos(cone_angle/2);
    
    
function generate_glacier(edge_radius,tip,back,i=0,results=[])=
let(data_point=(back && !glacier_mirror)?glacier_data_b[i]:glacier_data[i])
let(depth=(glacier_jagged?glacier_depth_inches*inch/2+((i%2)?glacier_depth_inches*inch*data_point/2:-glacier_depth_inches*inch*data_point/2):glacier_depth_inches*inch*data_point))
let(span=tan(cone_angle/2)*(peak_inches*inch-depth)+tip*((edge_radius-peak_inches*inch)/edge_radius)+0.1)
let(span_angle=i/(actual_glacier_points-1)*cone_angle)
i<actual_glacier_points?concat(
[[(glacier_round==0)?-span+i/(actual_glacier_points-1)*span*2:sin(-cone_angle/2+span_angle)*(peak_inches*inch+depth)
,(glacier_round==0)?
peak_inches*inch-depth+0.1:cos(-cone_angle/2+span_angle)*(peak_inches*inch+depth)]
],
generate_glacier(edge_radius,tip,back,i+1),
results):results;    


actual_base_width=(base_width_inches?base_width_inches*inch:capacity*paper_thickness+thickness*2)+((hole && hole_cladding)?hole_cladding:0)+((hole && hole_shell_depth)?hole_shell_depth:0);

module filterholder(){
    
    
    // Base Arc
    
    rotate([0,90,90])
    translate([-radius-base_thickness,0,-capacity*paper_thickness/2])
    difference(){
        translate([0,0,-0.1])
cylinder(capacity*paper_thickness+0.2,radius+thickness,radius+thickness,$fn=base_arc_fineness);
    
        translate([0,0,-0.2])
    cylinder(capacity*paper_thickness+0.4,radius,radius,$fn=base_arc_fineness);
        
        rotate([0,0,cone_angle/2])
        translate([-radius-thickness-0.1,0,-0.2])
        cube([(radius+thickness+0.1)*2,radius+thickness+0.1,capacity+paper_thickness+0.2]);
        
        
        rotate([0,0,cone_angle/2])
        translate([-radius-thickness-0.1,0,-0.2])
        cube([(radius+thickness+0.1)*2,radius+thickness+0.1,capacity+paper_thickness+0.2]);
        
        
        rotate([0,0,180-cone_angle/2])
        translate([-radius-thickness-0.1,0,-0.2])
        cube([(radius+thickness+0.1)*2,radius+thickness+0.1,capacity+paper_thickness+0.2]);
    }

    // Base plate
    
    translate([0,(hole?(-actual_base_width/2)+capacity*paper_thickness/2+thickness+(hole_cladding?hole_cladding:0)+(hole_shell_depth?hole_shell_depth:0):0),0])
    
    difference(){
        translate([-base_length/2,-actual_base_width/2,0])
        cube([base_length,actual_base_width,base_thickness]);
    
        translate([-base_length/2,-actual_base_width/2-0.1,0])
        rotate([0,cone_angle/2,0])
        translate([-tip,0,0])
        cube([tip,actual_base_width+0.2,base_thickness/sin(cone_angle/2)]);
        
        mirror([1,0,0])
        translate([-base_length/2,-actual_base_width/2-0.1,0])
        rotate([0,cone_angle/2,0])
        translate([-tip,0,0])
        cube([tip,actual_base_width+0.2,base_thickness/sin(cone_angle/2)]);
        
    }
    

    // Sides
    
    
    translate([-sin(cone_angle/2)*(edge_radius),-capacity*paper_thickness/2-0.1,base_thickness])
    rotate([0,cone_angle/2,0])
    
    cube([thickness,capacity*paper_thickness+0.2,edge_radius-base_thickness*cos(cone_angle/2)-radius]);
    
    mirror([1,0,0])
    translate([-sin(cone_angle/2)*(edge_radius),-capacity*paper_thickness/2-0.1,base_thickness])
    rotate([0,cone_angle/2,0])
    cube([thickness,capacity*paper_thickness+0.2,edge_radius-base_thickness*cos(cone_angle/2)-radius]);
    
    
    // Walls
    
    
    rotate([-90,0,0])
    translate([0,-cos(cone_angle/2)*(edge_radius+(base_thickness)/cos(cone_angle/2)),capacity*paper_thickness/2]){
        
        difference(){
            
        linear_extrude(thickness,convexity=10)
        difference(){
           polygon(points=[[0,0],
            [-sin(cone_angle/2)*(edge_radius+base_thickness),
            cos(cone_angle/2)*(edge_radius+base_thickness)],
            [sin(cone_angle/2)*(edge_radius+base_thickness),
            cos(cone_angle/2)*(edge_radius+base_thickness)]]);

    polygon(points=concat([[0,-0.1]],generate_glacier(edge_radius,tip,0)));
            
            if (hole){
                translate([0,hole_inches*inch,-0.1])
                circle(hole_neck_inches*inch/2,$fn=hole_fineness);

                translate([-hole_neck_inches*inch/2,hole_inches*inch,-0.1])
                square(hole_neck_inches*inch);

                translate([0,hole_inches*inch+hole_neck_inches*inch+cos(asin((hole_neck_inches/2)/(hole_head_inches/2)))*(hole_head_inches*inch/2)-0.1,-0.1])
                circle(hole_head_inches*inch/2,$fn=hole_fineness);
            }
        }
        
        
            // Recess
        translate([0,0,-0.1])
                linear_extrude(thickness+hole_recess,convexity=10)
                union(){
                translate([0,hole_inches*inch,-0.1])
                    circle(hole_head_inches*inch/2,$fn=hole_fineness);

                    translate([-hole_head_inches*inch/2,hole_inches*inch,-0.1])
                    square([hole_head_inches*inch,hole_neck_inches*inch*1+cos(asin((hole_neck_inches/2)/(hole_head_inches/2)))*hole_head_inches*inch/2]);

                    translate([0,hole_inches*inch+hole_neck_inches*inch+cos(asin((hole_neck_inches/2)/(hole_head_inches/2)))*(hole_head_inches*inch/2)-0.1,-0.1])
                    circle(hole_head_inches*inch/2,$fn=hole_fineness);
                }
            }
            
            
        // Hanging Hole
            
            if (hole){
        
        translate([0,0,(hole_shell_depth?hole_shell_depth:0)+thickness-0.1])
        linear_extrude(hole_cladding+0.1, convexity=10)
        difference(){
            union(){
                translate([0,hole_inches*inch,-0.1])
                circle(hole_neck_inches*inch/2+hole_cladding,$fn=hole_fineness);

                translate([-hole_neck_inches*inch/2-hole_cladding,hole_inches*inch,-0.1])
                square(hole_neck_inches*inch+hole_cladding*2);

                translate([0,hole_inches*inch+hole_neck_inches*inch+cos(asin((hole_neck_inches/2)/(hole_head_inches/2)))*(hole_head_inches*inch/2)-0.1,-0.1])
                circle(hole_head_inches*inch/2+hole_cladding,$fn=hole_fineness);
            }
            
            translate([0,hole_inches*inch,-0.1])
            circle(hole_neck_inches*inch/2,$fn=hole_fineness);

            translate([-hole_neck_inches*inch/2,hole_inches*inch,-0.1])
            square(hole_neck_inches*inch);

            translate([0,hole_inches*inch+hole_neck_inches*inch+cos(asin((hole_neck_inches/2)/(hole_head_inches/2)))*(hole_head_inches*inch/2)-0.1,-0.1])
            circle(hole_head_inches*inch/2,$fn=hole_fineness);
            
        }
        
        // Hole shell
        
            if (hole_shell_depth){
                difference(){
                    
        translate([0,0,thickness-0.1])
        linear_extrude(hole_shell_depth+0.1,convexity=10)
        difference(){
                    
            union(){
                    translate([0,hole_inches*inch,-0.1])
                    circle(hole_head_inches*inch/2+hole_cladding,$fn=hole_fineness);

                    translate([-hole_head_inches*inch/2-hole_cladding,hole_inches*inch,-0.1])
                    square([hole_head_inches*inch+hole_cladding*2,hole_neck_inches*inch*1+cos(asin((hole_neck_inches/2)/(hole_head_inches/2)))*hole_head_inches*inch/2]);

                    translate([0,hole_inches*inch+hole_neck_inches*inch+cos(asin((hole_neck_inches/2)/(hole_head_inches/2)))*(hole_head_inches*inch/2)-0.1,-0.1])
                    circle(hole_head_inches*inch/2+hole_cladding,$fn=hole_fineness);
                }
                
                translate([0,hole_inches*inch,-0.1])
                circle(hole_neck_inches*inch/2,$fn=hole_fineness);

                translate([-hole_neck_inches*inch/2,hole_inches*inch,-0.1])
                square(hole_neck_inches*inch);

                translate([0,hole_inches*inch+hole_neck_inches*inch+cos(asin((hole_neck_inches/2)/(hole_head_inches/2)))*(hole_head_inches*inch/2)-0.1,-0.1])
                circle(hole_head_inches*inch/2,$fn=hole_fineness);
                
                
            }
            
            // Recess
                linear_extrude(thickness+hole_recess,convexity=10)
                union(){
                translate([0,hole_inches*inch,-0.1])
                    circle(hole_head_inches*inch/2,$fn=hole_fineness);

                    translate([-hole_head_inches*inch/2,hole_inches*inch,-0.1])
                    square([hole_head_inches*inch,hole_neck_inches*inch*1+cos(asin((hole_neck_inches/2)/(hole_head_inches/2)))*hole_head_inches*inch/2]);

                    translate([0,hole_inches*inch+hole_neck_inches*inch+cos(asin((hole_neck_inches/2)/(hole_head_inches/2)))*(hole_head_inches*inch/2)-0.1,-0.1])
                    circle(hole_head_inches*inch/2,$fn=hole_fineness);
                }
                
                
        }
        
        }
            
    }
    }
        
    rotate([-90,0,0])
    translate([0,-cos(cone_angle/2)*(edge_radius+(base_thickness)/cos(cone_angle/2)),-thickness-capacity*paper_thickness/2])
    linear_extrude(thickness,convexity=10)
    difference(){
       polygon(points=[[0,0],
        [-sin(cone_angle/2)*(edge_radius+base_thickness),
        cos(cone_angle/2)*(edge_radius+base_thickness)],
        [sin(cone_angle/2)*(edge_radius+base_thickness),
        cos(cone_angle/2)*(edge_radius+base_thickness)]]);

polygon(points=concat([[0,-0.1]],generate_glacier(edge_radius,tip,1)));

 
// Seed plaque
    }
    
    seed_string=str("Seed: ",floor(actual_seed/1000000)%10, floor(actual_seed/100000)%10, floor(actual_seed/10000)%10, 
                    floor(actual_seed/1000)%10, floor(actual_seed/100)%10, floor(actual_seed/10)%10, floor(actual_seed/1)%10);
    
    plaque=alt_text?alt_text:seed_string;
    
    if (seed_plaque){
        
        rotate([90,0,0])
        translate([0,font_size_inches*inch+base_thickness,capacity*paper_thickness/2+thickness])
        
        difference(){
            translate([0,0,plaque_thickness/2-0.1/2])
            cube([font_size_inches*inch*len(plaque)*1,font_size_inches*inch*2,plaque_thickness+0.1],center=true);
        
            translate([0,0,-0.1+plaque_thickness-plaque_depth])
            linear_extrude(plaque_depth+0.3,convexity=10)
                   text(str(plaque), font="Liberation Sans:style=Bold",size=font_size_inches*inch,halign="center",valign="center",$fn=50);
        }
    }
    
    if (!seed_plaque || alt_text){
        %translate([0,-actual_base_width/2-font_size_inches*inch,0])
        linear_extrude(thickness+0.3,convexity=10)
        text(str(seed_string), font="Liberation Sans:style=Bold",size=font_size_inches*inch,halign="center",valign="center",$fn=50);
    }
    
}

filterholder();