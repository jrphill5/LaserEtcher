include <00_GlobalVariables.scad>

module 03_ToolheadSled(){
    difference(){
        // Main body of toolhead
        translate([0,0,Toolhead_Bearing_L/2.0])
            cube([Toolhead_Bearing_OD+2.0*Toolhead_Margin, Toolhead_Bearing_S+Toolhead_Bearing_OD+2.0*Toolhead_Margin, Toolhead_Bearing_L], center=true);
    
        // Linear bearing mounting holes
        for(i=[-1,1])
            translate([0,i*Toolhead_Bearing_S/2.0,-eps])
                cylinder(d=Toolhead_Bearing_OD, h=Toolhead_Bearing_L+2*eps);
        
        // Clearance hole for acme rod
        translate([0,0,-eps])
            cylinder(d=Guide_Rod_D, h=Toolhead_Bearing_L+2*eps);
        
        // Slot for acme nut
        translate([0,0,Toolhead_Bearing_L/2.0]){
            cylinder($fn=6, h=Toolhead_Nut_T, d=Toolhead_Nut_W, center=true);
            translate([(Toolhead_Bearing_OD/2.0+Toolhead_Margin)/2.0-0.1*Toolhead_Nut_W/2.0+eps/2.0,0,0])
                cube([Toolhead_Bearing_OD/2.0+Toolhead_Margin+0.1*Toolhead_Nut_W+eps,Toolhead_Nut_W*cos(30),Toolhead_Nut_T], center=true);
            // Slot for removing acme nut
            rotate([0,90,0]) cylinder(d=3.0, h=Toolhead_Bearing_OD+2*Toolhead_Margin+2*eps, center=true);
        }       
        
        // Mounting screw holes
        for(i=[-1,1])
            translate([-Toolhead_Bearing_OD/2.0-Toolhead_Margin,i*((Toolhead_Bearing_S-Toolhead_Bearing_OD)/2.0+Toolhead_Nut_W*cos(30)/2.0)/2.0,Toolhead_Bearing_L/2.0])
                rotate([0,90,0]){
                    translate([0,0,Screw_Head_S+Screw_Head_T])
                        cylinder(d=Screw_Body_D, h=Toolhead_Bearing_OD+2*Toolhead_Margin-Screw_Head_S-Screw_Head_T+eps);
                    translate([0,0,Screw_Head_S])
                        cylinder(d1=Screw_Head_D, d2=Screw_Body_D, h=Screw_Head_T);
                    translate([0,0,-eps])
                        cylinder(d=Screw_Head_D, h=Screw_Head_S+eps);
            }
        
    }
}

03_ToolheadSled();