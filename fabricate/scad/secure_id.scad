include<digipass.scad>

// secure_id
secure_id_d = 28;
secure_id_l = 58.2;
secure_id_w = 20;
secure_id_t = 9.75;

module orig_secure_id(pyramid_extension=false){
  color("grey")
    union(){
    cylinder(d=secure_id_d, h=secure_id_t, $fn=50);
    translate([0, -secure_id_w/2, 0])
      cube([secure_id_l - secure_id_d/2, secure_id_w, secure_id_t]);
    translate([0, 0, 0])scale([1, 1, .2])sphere(d=18);
    translate([24, 6, 0])rotate([0, 90, 0])scale([.3, 1, 1])
      cylinder(d=4, h=18, $fn=20);
    translate([-secure_id_d/2, 0, secure_id_t/2])rotate([0, -90, 0])
      cylinder(d=5, h=4, $fn=30);
  }
  if(pyramid_extension){
    translate([44.2, 0, 9.8])
      difference(){
      rotate([0, 90, 0])
	rotate([0, 0, 45])
	cylinder(d1=27.8, d2=0, $fn=4, h=15);
      translate([-500, -500, 0])cube(1000);
    }
  }
  //digipass();
}
R = 5;
r = 1;
module secure_id_base(pyramid_extension=false){
  linear_extrude(height=.1)import("../inkscape/secure_id_1.svg");
}

module secure_id_cutouts(){
  secure_id();
  translate([0, 0, -100])cylinder(d=20, h=100);
  translate([0, -13/2, -100])cube([41, 13, 100]);
  translate([0, 0, 0])cylinder(d=secure_id_d, h=100);

translate([66, 0, -50])scale([1, 1.5, 1])cylinder(d=15, h=100);
}

module secure_id(){
  translate([0, 0, -4.6 - 1])minkowski(){
    secure_id_base();
    scale([.25, .25, 9.6/2])sphere(r=1, $fn=20);
  }
}


//secure_id_base();
secure_id();
