inch=25.4;

mode="link"; // ["wheel","link"]

wheel_teeth=5;

sprocket_bevel=1/32*inch;
//sprocket_thickness=inch*2/16;

link_count=1;

link_width=1*inch;
link_length=inch*1/3;
link_pad=inch*3/64;

rod_radius=inch*3/64;
rod_offset=0*inch;
rod_length=inch*0.25;

rod_mount_thickness=inch*1/16;
//rod_mount_radius=inch*1/32;

connector_kerf=inch*0.007; // [0.007]

connector_peg_radius=rod_radius;//inch*3/64; // Merge rod_radius and connector_peg_radius ...
connector_socket_width=inch*3/64;
connector_socket_radius=connector_peg_radius+connector_socket_width+connector_kerf;
connector_socket_z=link_pad+connector_kerf+rod_offset;

rod_y=(link_width-rod_length)/2;
rod_z=link_pad+rod_offset+connector_socket_width+connector_kerf*2;

theta=atan(1)*4/wheel_teeth;


axle_radius=1/8*inch/4+connector_kerf/2; // [4.1/4,1/8*inch/4]
spool_radius=sqrt(pow(axle_radius,2)*2)+axle_radius;


wheel_radius=link_length/(2*sin(theta));

sprocket_cog=wheel_radius*3.145969-(rod_radius*2*wheel_teeth);

sprocket_angle=(wheel_teeth-2)*180/wheel_teeth;

sprocket_cog_cut=link_length; //sqrt(pow(sin(theta*2)*wheel_radius-sin(theta*4)*wheel_radius,2)+pow(cos(theta*2)*wheel_radius-cos(theta*4)*wheel_radius,2));


sprocket_cog_cut_radius=link_length-rod_radius-connector_kerf; // Tooth shaping

sprocket_cog_midpoint=sqrt(pow(wheel_radius,2)-pow(link_length/2,2));

sprocket_cog_cut_length=sqrt(pow(link_length,2)-pow(link_length/2,2))+sprocket_cog_midpoint-connector_kerf-rod_radius; // Tooth Edge

link_pad_depth=cos(theta)*wheel_radius+rod_radius+connector_kerf+connector_socket_width+rod_offset;

sprocket_thickness=((rod_length-connector_kerf*4)/3);

sprocket_cog_cut_tip=link_pad_depth<sprocket_cog_cut_length?link_pad_depth:sprocket_cog_cut_length;

link_vane=sprocket_cog_cut_tip-spool_radius+rod_offset-connector_kerf;

function sprocket_cut(i)=[
[sin(theta*i*2)*wheel_radius,cos(theta*i*2)*wheel_radius],
[sin(theta*(i+1)*2)*wheel_radius,cos(theta*(i+1)*2)*wheel_radius],
[sin(theta*(i+1)*2)*wheel_radius*2,cos(theta*(i+1)*2)*(wheel_radius*2)],
[sin(theta*i*2)*wheel_radius*2,cos(theta*i*2)*(wheel_radius*2)]];


module wheel(){
    union(){
        
        difference(){
            cylinder(sprocket_thickness,wheel_radius,wheel_radius,$fn=100);
            
            for (i=[1:wheel_teeth]){
                translate([sin(theta*i*2)*(wheel_radius),cos(theta*i*2)*(wheel_radius),-1])
                cylinder(sprocket_thickness+2,rod_radius+connector_kerf,rod_radius+connector_kerf,$fn=100);
            }
             
            for (i=[1:wheel_teeth]){
                translate([0,0,-0.1])
                linear_extrude(sprocket_thickness+0.2,convexity=10)
                polygon(sprocket_cut(i));
            }
            
            
            
        }
        
        for (i=[1:wheel_teeth]){
            a=(theta*i*2)-180-sprocket_angle/2;
            d=link_length; 
            
            intersection(){
                translate([sin(theta*i*2)*wheel_radius,cos(theta*i*2)*wheel_radius,0])            
                cylinder(sprocket_thickness,sprocket_cog_cut_radius,sprocket_cog_cut_radius,$fn=100);
                
                translate([sin(a+sprocket_angle)*d,cos(a+sprocket_angle)*d,0])
                translate([sin(theta*i*2)*wheel_radius,cos(theta*i*2)*wheel_radius,0])            
                cylinder(sprocket_thickness,sprocket_cog_cut_radius,sprocket_cog_cut_radius,$fn=100);
             cylinder(sprocket_thickness,sprocket_cog_cut_tip,sprocket_cog_cut_tip,$fn=100);   
         
            }
            
        }
    }
    
    /* Guidelines
    for (i=[1:wheel_teeth]){
        translate([sin(i*theta*2)*wheel_radius,cos(i*theta*2)*wheel_radius,0])
        cylinder(rod_mount_thickness,rod_radius,rod_radius,$fn=100);
        
        d=sqrt(pow(link_length,2)-pow(link_length/2,2));
        o=sqrt(pow(wheel_radius,2)-pow(link_length/2,2));
        
        translate([sin(i*theta*2+theta)*(o+d),cos(i*theta*2+theta)*(o+d),0])
        cylinder(rod_mount_thickness,rod_radius,rod_radius,$fn=100);
    }
    
    //sprocket_cog_cut_tip=wheel_radius;
    color([0.75,0.75,0.75,0.3])
    //cylinder(rod_mount_thickness,sprocket_cog_cut_tip,sprocket_cog_cut_tip,$fn=100); 
    ); 
    
    */
}

module link(){
    
    // Link Pad
    translate([connector_kerf,0,0])
    cube(size=[link_length-connector_kerf*2,link_width,link_pad]);
    
    // Link Guide Vane
    translate([0,link_width/2+sprocket_thickness/2,link_pad])
    rotate([90,0,0])
    linear_extrude(sprocket_thickness,convexity=10)
    polygon([[rod_radius,0],[link_length/2-rod_radius,link_vane],[link_length/2+rod_radius,link_vane],[link_length-rod_radius,0]]);
    
    
    // Link Rod
    translate([0,rod_y,rod_z+rod_radius])
    rotate([-90,0,0])
    cylinder(rod_length,rod_radius,rod_radius,$fn=100);
    
    
    connector_socket();
    
    translate([0,link_width,0])
    mirror([0,1,0])
    connector_socket();
    
    
    connector_peg();
    
    translate([0,link_width,0])
    mirror([0,1,0])
    connector_peg();
    
}

module connector_socket(){
    difference(){
        union(){
            
            // Bracket Polygon
            translate([0,rod_y-rod_mount_thickness-connector_kerf,link_pad])
            rotate([90,0,0])
            linear_extrude(rod_mount_thickness,convexity=10,twist=0)
            polygon(points=[[link_length/2,0],[link_length-connector_socket_radius,rod_z-link_pad+rod_radius],[link_length,rod_offset+connector_kerf],[link_length-connector_kerf,0]],paths=[[0,1,2,3]]);
            
            // Connector socket Disk
            translate([link_length,rod_y-rod_mount_thickness*2-connector_kerf,connector_socket_z+connector_socket_radius])
            rotate([-90,0,0])
            cylinder(rod_mount_thickness,connector_socket_radius,connector_socket_radius,$fn=100);
        }
        
    translate([link_length,rod_y-rod_mount_thickness*2-1-connector_kerf,link_pad+rod_offset+rod_radius+connector_socket_width+connector_kerf*2])
            rotate([-90,0,0])
            cylinder(rod_mount_thickness+2,connector_peg_radius+connector_kerf,connector_peg_radius+connector_kerf,$fn=100);
    
        // Wedge slice polygon
        
        translate([0,rod_y-rod_mount_thickness-connector_kerf,connector_socket_z])
        linear_extrude(connector_socket_radius*2+connector_kerf*2)
        polygon(points=[[link_length,0.1],[link_length,0],[link_length+connector_socket_radius+connector_kerf,-rod_mount_thickness/3],[link_length+connector_socket_radius+connector_kerf,0.1]]);
    }
    
}

module connector_peg(){
    union(){
        
        // Bracket Polygon
        translate([0,rod_y-rod_mount_thickness*0,link_pad])
        rotate([90,0,0])
        linear_extrude(rod_mount_thickness,convexity=10,twist=0)
        polygon(points=[[link_length/2,0],[connector_socket_radius,rod_z-link_pad+rod_radius],[0,rod_offset+connector_kerf],[connector_kerf,0]]);

        
        // Connector Peg Mounting Disk
        translate([0,rod_y-rod_mount_thickness,link_pad+rod_offset+rod_radius+connector_socket_width+connector_kerf*2])
        rotate([-90,0,0])
        cylinder(rod_mount_thickness,connector_socket_radius,connector_socket_radius,$fn=100);
    
        // Connector Peg Disk
        difference(){
    translate([0,rod_y-rod_mount_thickness*2-connector_kerf,link_pad+rod_offset+rod_radius+connector_socket_width+connector_kerf*2])
            rotate([-90,0,0])
            cylinder(rod_mount_thickness+connector_kerf,connector_peg_radius,connector_peg_radius,$fn=100);
        
            // Wedge Slice Polygon
        translate([0,rod_y-rod_mount_thickness*2-connector_kerf,rod_z])
        linear_extrude(connector_peg_radius*2,convexity=10)
        polygon(points=[[connector_peg_radius,-0],[connector_peg_radius,0],[-connector_peg_radius,rod_mount_thickness/3],[-connector_peg_radius,-0.1]]);
        }
    }
}

if (mode == "wheel"){
    difference(){
        union(){
            wheel();
            translate([0,0,sprocket_thickness])
            cylinder(sprocket_thickness+connector_kerf*2,spool_radius,spool_radius,$fn=100);
            translate([0,0,sprocket_thickness*2+connector_kerf*2])
            wheel();
        }
        
        axle_hole_length=sprocket_thickness*3+connector_kerf*2+0.2;
        
        translate([0,0,axle_hole_length/2-0.1])
        //cylinder(axle_hole_length,axle_radius,axle_radius,$fn=100);
        cube(size=[axle_radius*2,axle_radius*2,axle_hole_length],center=true);
    }
    
}else if (mode == "link"){
    //translate([-link_length,0,0])
    for (i=[1:link_count]){
        translate([link_length*(i-1),0,0])
        union()
        link();
    }
}else if (mode == "both"){
   wheel();
   link();
}