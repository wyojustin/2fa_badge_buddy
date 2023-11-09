case_height=93;

module trapazoid(base1, base2, width){
/*
    base 1 -->
--------+--------
\       |       /
 \      | W    /
  \     |     /
   -----------
   base 2 -->
 */

  polygon([[-base1/2, 0],
	   [-base2/2, width],
	   [ base2/2, width],
	   [ base1/2, 0]]);
}
h = 50;
module case(){
color("grey")translate([0, 0, -2.5])rotate([-90, 0, 180]){
    difference(){
      linear_extrude(height=case_height)import("../inkscape/case_profile.svg");
      //translate([0, 0, 1])scale([.975,.8,2])linear_extrude(height=case_height)import("../inkscape/case_profile.svg");
    }
    translate([0, -9.5, 93-5-.5])linear_extrude(height=5.5)trapazoid(26, 30, 5);
    translate([-63/2+3, -4.5, -6.25 ])cube([57, .7, 29.5]);
}
}

module back(){
  l = 70;
  w = 62;
  h = 5;
  translate([0, -4, 0])
  difference(){
    translate([-l/2, -w/2-53, -2])cube([l, w, h]);
    case();
  }
}
back();
module side_clip(){
  w = 62;
  d = 12;
  difference(){
    union(){
      translate([30, -52, -2])rotate([90, 0, 0])
	difference(){
	{
	  translate([2, 0, 1-w/2+4+d/2])scale([.9, 1, 1])
	    union(){
	    cylinder(d=d, h=w-d, $fn=50);
	    sphere(d=d, $fn=50);
	    translate([0, 0, w-d])sphere(d=d, $fn=50);
	  }
	  translate([-8.5, -9, -w/2+4])cube([10, 10, w+2]);
	  translate([-5, 5, -w/2+4])cube([10, 10, w+2]);
	  translate([-5, 4, -1])cube([10, 10, 20]);
	}
      }
    }
    case();
  }
}

module side_clips(){
  side_clip();
  mirror([1, 0, 0]) side_clip();
}
//case();

