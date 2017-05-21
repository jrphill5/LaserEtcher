include <00_GlobalVariables.scad>
use <01_StepperMount.scad>

thickness = 3.0;
washer_h = 2.0;

bearing_ID = 13.0;
bearing_OD = 21.0;

perimeter = 2.0;

difference(){
    union(){
        cylinder(d=bearing_ID+2.0*perimeter, h=thickness+washer_h);
        hull()
            for(i=[0:180:270])
                rotate([0,0,i])
                    translate([(Stepper_W/2.0+Stepper_Coupler_D/2.0)/2.0,0,0])
                        cylinder(d=Stepper_Mount_Hole_D+2.0*perimeter, h=thickness);
        hull()
            for(i=[90:180:270])
                rotate([0,0,i])
                    translate([(Stepper_W/2.0+Stepper_Coupler_D/2.0)/2.0,0,0])
                        cylinder(d=Stepper_Mount_Hole_D+2.0*perimeter, h=thickness);
    }    
    translate([0,0,-eps])
        cylinder(d=bearing_ID, h=thickness+washer_h+2*eps);
    for(i=[0:90:270])
        rotate([0,0,i])
            translate([(Stepper_W/2.0+Stepper_Coupler_D/2.0)/2.0,0,-eps])
                cylinder(d=Stepper_Mount_Hole_D, h=thickness+2*eps);
}