include <00_GlobalVariables.scad>

use <01_StepperMount.scad>
use <06_YAxisBlankEndstop.scad>

module 06_YAxisStepperEndstop(){
    difference(){
        union(){
            06_YAxisBlankEndstop();

        }
        translate([0,0,-(Rotary_Bearing_OD/2.0+Toolhead_Margin+Extrusion_W/2.0+Guide_Rod_D/2.0)])
            rotate([-90,0,0])
                for(i=[0:90:270])
                    rotate([0,0,i+45])
                        translate([(Stepper_W/2.0+Stepper_Coupler_D/2.0)/2.0,0,-eps])
                            cylinder(d=Stepper_Mount_Hole_D, h=Extrusion_W+2*eps);

        scale([1.02,1.02,1.00])
            translate([0,-Stepper_Mount_Flange_T+Extrusion_W-Rod_Mount_T+Rotary_Bearing_T,-(Rotary_Bearing_OD/2.0+Toolhead_Margin+Extrusion_W/2.0+Guide_Rod_D/2.0)])
                rotate([-90,0,0])
                    rotate([0,0,45])
                        hull()
                            difference(){
                                01_StepperMount();
                                translate([0,0,Stepper_Mount_Flange_T/2.0])
                                    cube([Stepper_W,Stepper_W,Stepper_Mount_Flange_T], center=true);
                            }
    }

}

06_YAxisStepperEndstop();