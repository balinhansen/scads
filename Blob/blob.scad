inch=25.4;
build_stl=0;

random_seed=189185;
use_seed=1;
auto_seed=1;

count=23;
dynamic_fineness=1;
low_fineness=24;
high_fineness=240;
blob_fineness=2;
blob_sink=1;
blob_hover=1;
orb_size=1;
blob_min=3;
blob_max=16;
hull_the_blobs=0;

seed=use_seed==1 && auto_seed==1?round(rands(0,1000000,1)[0]):random_seed;
    
if (use_seed==1 && auto_seed==1){
    echo("Autogenerated seed: ",seed);
}

seeds=[for (a=rands(0,1000000,3,seed)) a];

fineness=build_stl?high_fineness:low_fineness;

blobs = [for (a = rands(blob_min, blob_max, count-1, seeds[0])) a];
angles = [for (a = rands(-90, 90, count-1, seeds[1])) a];
anglebs = [for (a = rands(0, 369, count-1, seeds[2])) a];
    
if (hull_the_blobs){
hull(){
    
sphere(orb_size/2*inch,$fn=fineness);

for (i=[0:count-1]){
    blob=use_seed?blobs[i]:rands(blob_min,blob_max,1)[0];
    ang=use_seed?angles[i]:rands(-90,90,1)[0];
    angb=use_seed?anglebs[i]:rands(0,360,1)[0];
    
    rotate([0,0,angb])
    rotate([0,ang,0])
    translate([orb_size/2*inch+blob_sink*blob/64*inch-blob_hover/16*inch,0,0])
    rotate([0,0,60])
    sphere(blob/64*inch,$fn=dynamic_fineness?1/blob_fineness*fineness*blob/16:fineness);
}
}

}else{
    sphere(orb_size/2*inch,$fn=fineness);

for (i=[0:count-1]){
    blob=use_seed?blobs[i]:rands(blob_min,blob_max,1)[0];
    ang=use_seed?angles[i]:rands(-90,90,1)[0];
    angb=use_seed?anglebs[i]:rands(0,360,1)[0];
    
    rotate([0,0,angb])
    rotate([0,ang,0])
    translate([orb_size/2*inch+blob_sink*blob/64*inch-blob_hover/16*inch,0,0])
    rotate([0,0,60])
    sphere(blob/64*inch,$fn=dynamic_fineness?1/blob_fineness*fineness*blob/16:fineness);
}

}