include <00_GlobalVariables.scad>

module 02_XAxisBlankEndstop(){
    difference(){
        // Mounting plate, centered around x-y axis, above Z-plane
        translate([0, 0, Rod_Mount_T/2.0])
            cube([Rod_Mount_L, Rod_Mount_W, Rod_Mount_T], center=true);
        // Inset for bearing
        translate([0, 0, Rod_Mount_T-Rotary_Bearing_T])
            cylinder(d=Rotary_Bearing_OD, h=Rotary_Bearing_T+eps);
        // Through hole to allow outer nut or motor coupling
        translate([0, 0, -eps])
            cylinder(d=Rotary_Bearing_ID, h=Rod_Mount_T+2*eps);
        // Corner mounting holes
        for(i = [-1,1])
            for(j = [-1,1])
                translate([i*Rod_Mount_Hole_Sx/2.0, j*Rod_Mount_Hole_Sy/2.0, -eps]){
                    cylinder(d=Rod_Mount_Hole_D, h=Rod_Mount_T+2*eps);
                    cylinder($fn=6, d=Stepper_Mount_Nut_Slot_D, h=Stepper_Mount_Nut_Slot_T);
                }
        // Limit switch    
        translate([0, Rod_Mount_W/2.0-Endstop_Switch_W/2.0-Endstop_Switch_S, 0]){
            translate([0, 0, Endstop_Switch_D/2.0+Rod_Mount_T-Endstop_Switch_D+eps/2.0])
                cube([Endstop_Switch_L, Endstop_Switch_W, Endstop_Switch_D+eps], center=true);
            for(i = [0,1,2]){
                translate([(i-1)*Endstop_Switch_Hole_S, 0, -eps])
                    cylinder(d = Endstop_Switch_Hole_D, h = Rod_Mount_T+2*eps);
            }
        }
        // Smooth rod clearance holes
        for(i=[-1,1])
            translate([i*Rod_Mount_Hole_Sx/2.0,0,-eps])
                cylinder(d=Rail_D, h=Rod_Mount_T+2*eps);
        // Nut slots
        for(i=[-1,1]){
            translate([i*(Rod_Mount_L/4.0+Rod_Mount_Hole_Sx/4.0+Rail_D/4.0-Stepper_Mount_Nut_Slot_T/4.0),0,Rod_Mount_T/2.0])
                cube([Stepper_Mount_Nut_Slot_T,Stepper_Mount_Nut_Slot_D*cos(30),Rod_Mount_T+2*eps], center=true);
            translate([i*(Rod_Mount_Hole_Sx/2.0+Rail_D/2.0+1.0+eps),0,Rod_Mount_T/2.0])
                rotate([0,i*90,0])
                    cylinder(d=M5_Bolt_D, h=Rod_Mount_L/2.0-Rod_Mount_Hole_Sx/2.0-Rail_D/2.0-1.0+eps);
        }
    }
}

02_XAxisBlankEndstop();