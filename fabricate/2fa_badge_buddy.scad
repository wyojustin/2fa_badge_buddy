use <scad/secure_id.scad>
use <scad/digipass.scad>
use <scad/case_profile.scad>

thickness = 8;
length = 95;
trap_base1 = 25;
trap_base2 = 20;
trap_thickness = 4;
trap_height = 4.5;

module cutout(){
  translate([0, 0, -12])rotate([180, 0, 0])secure_id();
  translate([0, 0, 0])rotate([180, 0, 0])digipass();
}

module cutouts(){
  cutout();
  rotate([0, 90, 0])translate([7, 0, -100])cylinder(d=8, h=200, $fn=30);
  translate([0, 0, -25])cylinder(r=10, h=50);
  translate([30, 0, -25])cylinder(r=10, h=50);
}

module id_block(){
  color("blue")translate([-11, -11, 0])minkowski(){
    cube([52, 21.8, 9]);
    difference(){
      cylinder(r=5, h=1, $fn=10);
    }
  }
}

module clip(height){
  color("red")rotate([90, 0, 0])linear_extrude(height=height)
    import("svgs/clip.svg");
}

module id_holder(){
  difference(){
    id_block();
    translate([0, 0, 12])cutouts();
    //translate([0, -20, -10])cube(80);
  }

  difference(){
    union(){
      translate([45.9,-8,9.1])rotate([0, 0, 180])scale([.9, 1, 1])clip(4);
      translate([45.9,4,9.1])rotate([0, 0, 180])scale([.9, 1, 1])clip(4);
    }
    translate([0,0,5])digipass();
    rotate([0, 90, 0])translate([-5, 0, -100])cylinder(d=8, h=200, $fn=30);
    translate([41.5, 0, 10])scale([1/10, 1, 1/5])sphere(r=16);
  }

  offset = -2.;
  translate([6, -15.5, 10.8 + offset])rotate([0, 0, 90])clip(20);
  translate([32, 15.5, 10.8 + offset])rotate([0, 0, -90])clip(20);

  if(false){
    if(true){
      translate([0, 0, 0])rotate([180, 0, 0])secure_id();
    }
    else{
      translate([-1, 0, 12.2])rotate([180, 0, 0])digipass();
    }
    if(true){
      translate([30, 30, 0])rotate([180, 0, 180])secure_id();
    }
    else{
      translate([30, 30, 12.2])rotate([180, 0, 180])digipass();
    }
  }

  //translate([0,0,20])digipass();
}

module holders(){
  translate([-15, -72.1, 2]){
    id_holder();
    translate([30, 30])rotate([0, 0, 180])id_holder();
  }
}


module backpack(){
  difference(){
    back();
    for(i=[-1, 1]){
      for(j=[0, 1]){
	translate([i * 15, -42.1 - j * 30, 0])cylinder(r=10, h=50);
      }
    }
    
    translate([-15, -42.1, 0])cylinder(r=10, h=50);
  }
  side_clips();
}

module magnet(){
  magnet_d = 2.98;
  magnet_h = 6;
  cylinder(d2=magnet_d, d1=magnet_d, magnet_h, $fn=30);
translate([0, 0, magnet_h/2])cylinder(d1=magnet_d*1.2, d2=magnet_d, h=.5, $fn=30);
translate([0, 0, magnet_h/2-.5])cylinder(d2=magnet_d*1.2, d1=magnet_d, h=.5, $fn=30);
  
}
module magnet_row(){
  translate([0, -97.6-3.11, 4.5])
  rotate([-90, 0, 0])
  for(i=[-5:5]){
    translate([i * 4, 0, 0])magnet();
  }
  translate([0, -97.6-3.11, 9.5])
  rotate([-90, 0, 0])
  for(i=[-6:5]){
    translate([i * 4  + 2, 0, 0])magnet();
  }
}

module oval(){
  color("red")translate([-23, -97.7, 6.5])minkowski(){
    rotate([90, 0, 0])cylinder(d=9, h=.01, $fn=50);
    cube([55-9, 10, 1]);
  }
}
module top(){
  w = 55;
  difference(){
    oval();
    case();
    magnet_row();
  }
}
module pill(d, w, h, fn=30){
  translate([(w - d)/2, 0, 0])cylinder(d=d, h=h, $fn=fn);
  translate([-(w - d)/2, 0, 0])cylinder(d=d, h=h, $fn=fn);
  translate([-(w - d)/2, -d/2, 0])cube([w - d, d, h]);
}

module pocket(d, w, h, fn=30){
  pill(d, w, h, fn);
  cylinder(d=d * 1.5, h=h, $fn=fn);
}

module lanyard_attachment(){
  color("yellow")difference(){
    translate([0,-10.02,0])oval();
    translate([0,-23.02,2])scale([.9, .9, 1.2])oval();
    
    magnet_row();
    translate([-500, -1110, 0])cube(1000);
    //translate([0, -104.5, -1])pocket(3, 15, 10);
    translate([-16, -104.5, -1])pocket(3, 12, 10);
    translate([16, -104.5, -1])pocket(3, 12, 10);
  }
}

//case();
///// part 1
holders();
top();
//// part 2
translate([0, -1, 0])
lanyard_attachment();

// part 3
translate([70, 0, 5])rotate([0, 180, 0])backpack();



