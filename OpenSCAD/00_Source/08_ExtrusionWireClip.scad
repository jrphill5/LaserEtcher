include <00_GlobalVariables.scad>

thk = 2.0;

xdim = (Extrusion_W - 6.0)/2.0+2*thk;
ydim = Extrusion_W+2*thk;
zdim = 5.0;

translate([Extrusion_W/2.0-xdim+thk,-ydim/2.0,0])
    difference(){
        cube([xdim,ydim,zdim]);
        translate([thk,thk,-eps])
            cube([xdim-2*thk, ydim-2*thk, zdim+2*eps]);
        translate([-eps,2*thk,-eps])
            cube([thk+2*eps,ydim-4*thk,zdim+2*eps]);
    }