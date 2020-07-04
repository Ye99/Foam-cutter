include <BOSL/constants.scad>
use <BOSL/metric_screws.scad>
use <BOSL/transforms.scad>
include <OpenSCAD-common-libraries/screw_matrics.scad>
include <OpenSCAD-common-libraries/roundedCube.scad>

module screw_hole() {
    #screw(one_fourth_screw_hole_tap_diameter, 
       screwlen=one_fourth_screw_stem_length,
       headsize=one_fourth_screw_head_diameter,
       headlen=3, countersunk=false, align="base");
}

module remove_slab() {
    left(25)
        down(25)
            cube([50, 50, 50]);
}

module added_slab() {
    right(9.5)
        difference() {
            roundedCube([10, 19, 20], center=true, r=2,
                    x=true, xcorners=[false, true, true, false],
                    z=true, 
                    y=true);
            back(3)
                right(25)
                    yrot(90)
                    screw_hole();
        }
}


module brace() {
    union() {
        difference() {
            translate([0, -97.89, 0])
                import("handle.stl");
            
            remove_slab();
        }
        added_slab();
    }
}

brace();