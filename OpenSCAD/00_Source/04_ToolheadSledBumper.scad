include <00_GlobalVariables.scad>

Bumper_T = 8.0;

Nut_D = 13.0;
Nut_T = 6.0;

module 04_ToolheadSledBumper(){
    difference(){
        translate([0,0,Bumper_T/2.0])
            for(i=[0,1])
                rotate([0,0,i*90])
                    cube([Toolhead_Bearing_L, 2.0*(((Toolhead_Bearing_S-Toolhead_Bearing_OD)/2.0+Toolhead_Nut_W*cos(30)/2.0)/2.0)+2.0*Nut_D, Bumper_T], center=true);
    
        for(i=[-1,1])
            translate([0,i*((Toolhead_Bearing_S-Toolhead_Bearing_OD)/2.0+Toolhead_Nut_W*cos(30)/2.0)/2.0,0]){
                translate([0,0,Bumper_T-Nut_T])
                    cylinder($fn=6, d=Nut_D, h=Nut_T+eps);
                translate([0,0,-eps])
                    cylinder(d=Screw_Body_D, h=Bumper_T+eps);
            }
    }
}

04_ToolheadSledBumper();