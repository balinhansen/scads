maximum_width=50;
starting_angle=45;
finishing_angle=75;
iteration_divisor=6;
foot_width=3;
leg_thickness=0.8;
petal_thickness=0.4;
font_enabled=1;
font_emboss=0.4;
font_size=3;
font_rounding_digits=1;

module overhang(maxwidth, start, finish, iter, foot, leg, thickness, font_en, letters, font, font_rnd){
    
    
       offset=(leg/2)/tan((360/(iter+1))/2);
    
    iter_angle=(360/(iter+1));
    back_angle=start+(finish-start)/(iter)*(floor(iter/2));
    back_coef=1/(1+cos(back_angle));
    wedge_angle=start+(finish-start)/(iter)*(floor(iter/2)-1);
    
    wedge_coef=1/(1+cos(wedge_angle)+((sin(iter_angle/2)*foot/2)/maxwidth)); //start+(finish-start)/(iter)*(floor(iter/2)+1);
    
    wedge_leg_coef=1/(1+tan(finish)*tan(wedge_angle));
    
    
    backleg=(maxwidth)*(1-back_coef);
    wedge_leg=(maxwidth*(1-wedge_coef));
    
    backwedge=(maxwidth)*(1-wedge_coef);
    
    maxleg=((iter+1)%2)?(maxwidth)*(wedge_coef):(maxwidth)*(back_coef);
    
    
    echo(iter_angle);
    echo(back_angle);
    echo(wedge_angle);
    echo(maxwidth);
    echo(maxleg);
    echo(backleg);
    echo(backwedge);
    echo(wedge_coef);
    
    
   for (i=[0:iter]){
        theta=start+i*(finish-start)/(iter);
       petaloff=(leg/2)/sin((360/(iter+1))/2);
       
       
      leg_length=maxleg/tan(finish)*tan(theta);
      petal_length=leg_length/sin(theta);
       
      leg_height=maxleg/tan(finish)*tan(finish)+offset;
      wedge_length=(cos(360/(iter+1)/2)*leg_height*cos(finish));
       
       height=maxleg*cos(iter_angle/2)/tan(finish);
       
       projheight=height+thickness*sin(finish);
       
       if (i==0){
           
        // foot
        rotate([0,0,360/(iter+1)*i])
        translate([0,-foot/2,0])
        cube([maxleg+offset,foot,leg]);
        
        // leg
        rotate([0,0,360/(iter+1)*i])
        translate([0,-leg/2,leg])
        cube([maxleg+offset,leg,projheight]);
       
       }
       
       
       if (i != 0){
       
        // feet
        rotate([0,0,360/(iter+1)*i])
        translate([0,-foot/2,0])
        cube([leg_length+offset,foot,leg]);
        
        // legs
        rotate([0,0,360/(iter+1)*i])
        translate([0,-leg/2,leg])
        cube([leg_length+offset,leg,projheight]);
       
       }
       
       
       // petal
       
       
       rotate([0,0,360/(iter+1)*i])
       translate([0,0,leg])
       
   
   
       rotate([0,0,360/(iter+1)/2])
       translate([petaloff,0,0])
       translate([-thickness*cos(theta),0,0])
       
       translate([0,0,thickness*sin(theta)])
       rotate([0,-(90-theta),0])
       translate([0,0,-thickness])
       
       union(){
           
           linear_extrude(thickness,convexity=10)
           polygon(points=[
           [0,0],
           [cos(360/(iter+1)/2)*petal_length,-sin(360/(iter+1)/2)*petal_length*sin(theta)],
           [cos(360/(iter+1)/2)*petal_length,sin(360/(iter+1)/2)*petal_length*sin(theta)]]);
                   
           if (font_en){
           // text             
               translate([(cos(360/(iter+1)/2)*petal_length)-font/2-0.5,0,thickness-0.01])
               rotate([0,0,90])
               linear_extrude(letters+0.01,convexity=10)
               
               text(str(floor(theta*pow(10,font_rnd))/pow(10,font_rnd)), font="Liberation Sans:style=Bold",size=font,halign="center",valign="center",$fn=50);
           }
       }
    }
}

//overhang(50,45,75,6,3,0.8,0.4,1,0.4,3,1);


overhang(maximum_width,starting_angle,finishing_angle,iteration_divisor,foot_width,leg_thickness,petal_thickness,font_enabled,font_emboss,font_size,font_rounding_digits);
