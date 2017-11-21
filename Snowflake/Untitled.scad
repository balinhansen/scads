function ngon(count, radius, i = 0, result = []) = i < count
    ? ngon(count, radius, i + 1, concat(result, [[ radius*sin(360/count*i), radius*cos(360/count*i) ]]))
    : result;
    
    function rhombus(side,angle,i=0, result = []) = 
    i < 4 ? rhombus(side,angle,i+1, concat(result,[[
    i==0?0:i==1?side:i==2?side+cos(angle)*side:i==3?cos(angle)*side:0,
    i==0?0:i==1?0:i==2?sin(angle)*side:i==3?sin(angle)*side:0
    ]])): result;
    
    module flake_end(){
        linear_extrude(1,convexity=10)
            rotate([0,0,30])
        polygon(ngon(6,3));
    }
    
    module hollow_flake_end(){
        difference(){
            flake_end();
            translate([0,0,-0.001])
            linear_extrude(1.002,convexity=10)
            rotate([0,0,30])
            polygon(ngon(6,2));
        }
        
    }
    
    
    module tri_flake_end(){
        difference(){
            
            flake_end();
            for (i=[0:2]){
                union(){
                    translate([0,0,-0.001])
                    linear_extrude(1.002,convexity=10)
                    rotate([0,0,120*i])
                    translate([cos(60)*0.55,sin(60)*0.5,0])
                    //rotate([0,0,60])
                    polygon(rhombus(1.5,120));
                        
                }
            }
            
        }
    }   
    
    
    module hex_flake_end(){
        difference(){
            flake_end();
            for (i=[0:5]){
                translate([0,0,-0.001])
                linear_extrude(1.002,convexity=10)
                rotate([0,0,60*i])
                translate([0,1.5,0])
                rotate([0,0,60])
                polygon(ngon(3,.5));
            }
        }
    }
    
    
    
module snowflake(){
    
    seed=rands(0,10000000,1)[0];

    innerTree=round(rands(0,1,1,seed)[0]);
    
    if (innerTree==1){
        
        innerTreeSize=round(rands(1,10,1,seed)[0]);
        for (i=[0,len(innerTreeSize)]){
            
        }
        tree=rands(0,1,innerTreeSize);
        echo(tree);
    }
    
    for (i=[0:5]){
        
        rotate([0,0,360*i/6]){
            translate([2,-0.5,0])
            cube(size=[2.5,1,1]);
                
            translate([9.5,-0.5,0])
            cube(size=[2.5,1,1]);
                
            translate([7+cos(60)*2.5,sin(60)*2.5,0])    
            rotate([0,0,60])
            translate([0,-0.5,0])
            cube(size=[2.5,1,1]);
                
            translate([7+cos(-60)*2.5,sin(-60)*2.5,0])    
            rotate([0,0,-60])
            translate([0,-0.5,0])
            cube(size=[2.5,1,1]);
                
            translate([14.5,0,0])
            hex_flake_end();
        }
    }

    for (i=[0:2]){
        rotate([0,0,360*i/3]){
        
        translate([3+4,0,0])
            tri_flake_end();
        }
    }
    
    for (i=[0:2]){
        rotate([0,0,60+360*i/3]){
        
        translate([3+4,0,0])
            hollow_flake_end();
        }
    }
}

scale([2,2,2]){
snowflake();

hex_flake_end();

translate([18,0,0.5])
rotate([90,0,0])
rotate_extrude(convexity=10,$fn=128)
translate([1,0,0])
circle(0.5,$fn=64);
}