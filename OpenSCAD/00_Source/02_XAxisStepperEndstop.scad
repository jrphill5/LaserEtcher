include <00_GlobalVariables.scad>

use <01_StepperMount.scad>
use <02_XAxisBlankEndstop.scad>

module 02_XAxisStepperEndstop(){
    difference(){
        
        02_XAxisBlankEndstop();
        
        for(i=[0:90:270])
            rotate([0,0,i+45])
                translate([(Stepper_W/2.0+Stepper_Coupler_D/2.0)/2.0,0,0])
                    cylinder(d=Stepper_Mount_Hole_D, h=Rod_Mount_W);
        scale([1.02,1.02,1.00])
        translate([0,0,-Stepper_Mount_L+Rod_Mount_T-Rotary_Bearing_T+eps])
            rotate([0,0,45])
                hull()
                    difference(){
                        01_StepperMount();
                        translate([0,0,Stepper_Mount_Flange_T/2.0])
                            cube([Stepper_W,Stepper_W,Stepper_Mount_Flange_T], center=true);
                    }
            
    }
}

02_XAxisStepperEndstop();