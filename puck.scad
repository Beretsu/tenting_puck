$fa = 1;
$fs = 0.4;
center_insert_h = 6;
center_install_r = 3.5; //less than insert outerdia for instalation.
//1/4" = 6.35mm
// center outer diameter = 8
puck_h = center_insert_h;
puck_r = 20.55;
r_to_m2 = 19.05;
m2_head_h = 2;  //height of m2 head
m2_head_w = 2;  //width
//m2 outer diameter = 3.2
m2_install_r = 1.3; //less than insert outerdia for instalation.
m2_insert_h = 5;
m2_install_h = m2_insert_h + m2_insert_h/2; //plus 50% for the heated plastic to escape to
m2_z_offset = puck_h/2 + m2_head_h - m2_install_h;
delta = 0.01;

difference() {
    union() {
        cylinder(h=puck_h, r=puck_r, center=true);
        
        translate([r_to_m2,0,m2_z_offset])
        cylinder(h=m2_install_h, r=m2_install_r+m2_head_w);
        
        translate([-r_to_m2,0,m2_z_offset])
        cylinder(h=m2_install_h, r=m2_install_r+m2_head_w);
        
        translate([0,r_to_m2,m2_z_offset])
        cylinder(h=m2_install_h, r=m2_install_r+m2_head_w);
        
        translate([0,-r_to_m2,m2_z_offset])
        cylinder(h=m2_install_h, r=m2_install_r+m2_head_w);
    }
    tapered_hole(h=center_insert_h+delta, r=center_install_r, taper_h = 1.8, taper_r = center_install_r+1, center=
    true);
    translate([r_to_m2,0,m2_z_offset])
        tapered_hole(h=m2_install_h+delta, r=m2_install_r, taper_h = 0.8, taper_r = m2_install_r+.6);
    translate([-r_to_m2,0,m2_z_offset])
        tapered_hole(h=m2_install_h+delta, r=m2_install_r, taper_h = 0.8, taper_r = m2_install_r+.6);
    translate([0,r_to_m2,m2_z_offset])
        tapered_hole(h=m2_install_h+delta, r=m2_install_r, taper_h = 0.8, taper_r = m2_install_r+.6);
    translate([0,-r_to_m2,m2_z_offset])
        tapered_hole(h=m2_install_h+delta, r=m2_install_r, taper_h = 0.8, taper_r = m2_install_r+.6);
}

module tapered_hole(h=center_insert_h, r=center_insert_h, taper_h, taper_r, center=false) {
    if (center) {
        hull() {
            translate([0,0,h/2-0.01/2])
            cylinder(h=0.01, r=taper_r, center=center);
            translate([0,0,h/2-taper_h+0.01/2])
            cylinder(h=0.01, r=r, center=center);
        }
    } else {
        hull() {
            translate([0,0,h-0.01])
            cylinder(h=0.01, r=taper_r, center=center);
            translate([0,0,h-taper_h])
            cylinder(h=0.01, r=r, center=center);
        }
    }
    cylinder(h=h, r=r, center=center);
}