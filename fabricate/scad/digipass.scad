digi_w = 26.5;
digi_R = 19;
digi_t = 11.4;
digi_l = 37;

module digipass(){
  translate([30, 0, 0])rotate([0, 0, 180]){
    cylinder(d=digi_w, h=digi_t);
    translate([0, -digi_w/2, 0])cube([digi_l, digi_w, digi_t]);
    translate([25, 0, 0])intersection(){
      cylinder(r=digi_R, h=digi_t, $fn=50);
      translate([0, -digi_w/2, 0])cube([100, digi_w, 100]);
    }
  }
}
//digipass();
//translate([-digi_w/2, 0, 0])cube([57, 10, 2 * digi_t]);
