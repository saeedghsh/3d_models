include <../lib/color_names.scad>

tol = 0.1;
fragments = 100;


module add_peg_hole(diameter, height, thickness, rotation_axis, concentric_offset){
    hole_diameter = height /2;
    peg_height = concentric_offset + thickness / 2;
    peg_diameter = 0.7 * hole_diameter;

    // for the square ring
    x_outer = (diameter+thickness) * sqrt(2) / 2;
    x_inner = (diameter-thickness) * sqrt(2) / 2;

    angle = rotation_axis=="x" ? 0 : 90;
    rotate([0, 0, angle])
        union(){    
        
        difference(){
            // the ring
  	        children();

    	      // holes
  	        rotate([90, 0, 0])
  	        cylinder(h=diameter+thickness+tol, d=hole_diameter, center=true, $fn=fragments);
        }

        // peg to positive sides (+x and +y)
        translate([(diameter + peg_height) / 2, 0, 0])

        rotate([0, 90, 0])
        union(){
            // peg shaft
            cylinder(h=peg_height + thickness, d=peg_diameter, center=true, $fn=fragments);
            // peg end disk
            translate([0, 0, (peg_height+thickness)/2])
  	        cylinder(h=thickness/2, d=peg_diameter*2, center=true, $fn=fragments);
        }

        // peg to negative sides (-x and -y)
        translate([-(diameter + peg_height) / 2, 0, 0])
        rotate([0, 90, 0])
        union(){
            // peg shaft
            cylinder(h=peg_height + thickness, d=peg_diameter, center=true, $fn=fragments);
            // peg end disk
            translate([0, 0, -(peg_height+thickness)/2])
  	        cylinder(h=thickness/2, d=peg_diameter*2, center=true, $fn=fragments);
        }
    }
}