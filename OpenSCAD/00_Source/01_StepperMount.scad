include <00_GlobalVariables.scad>

module chamfer(W, H, C){
    for(i=[-1,1])
        for(j=[-1,1])
            translate([i*(W/2.0+eps), j*(W/2.0+eps), -eps])
                linear_extrude(height = H+2*eps)
                    polygon(points = [[0, 0], [-i*C-2*eps, 0], [0, -j*C-2*eps], [0, 0]]);
}

module 01_StepperMount(){
    difference(){
        // Create block
        translate([0, 0, Stepper_Mount_L/2.0])
            cube([Stepper_W, Stepper_W, Stepper_Mount_L], center=true);
    
        // Drill spindle hole
        translate([0,0,-eps])
            cylinder(d=Stepper_Coupler_D, h=Stepper_Mount_L+2*eps);
    
        // Drill mounting holes
        for(i=[-1:2:1])
            for(j=[-1:2:1])
                translate([i*Stepper_Hole_S/2.0, j*Stepper_Hole_S/2.0, -eps])
                    cylinder(d=Stepper_Hole_D, h=Stepper_Mount_Flange_T+2*eps);
    
        // Chamfer motor mount
        chamfer(Stepper_W, Stepper_Mount_L, Stepper_Mount_Chamfer);
    
        translate([0, 0, Stepper_Mount_Flange_T])
            chamfer(Stepper_W, Stepper_Mount_L-Stepper_Mount_Flange_T, Stepper_W/2.0-Stepper_Mount_Chamfer/sqrt(2.0));
        
        // Create wrench access slot
        for(i=[45:90:315])
            rotate([0,0,i])
                translate([0,-Stepper_Mount_Wrench_Slot_S/2.0,Stepper_Mount_Flange_T+Stepper_Mount_Wrench_Slot_Offset+Stepper_Mount_Wrench_Slot_S/2.0]){
                    cube([Stepper_W/2.0, Stepper_Mount_Wrench_Slot_S, Stepper_Mount_L-Stepper_Mount_Flange_T-Stepper_Mount_Wrench_Slot_Offset-Stepper_Mount_Wrench_Slot_S/2.0+eps]);
                    translate([0,Stepper_Mount_Wrench_Slot_S/2.0,0]){
                        rotate([0,90,0])
                            cylinder(d=Stepper_Mount_Wrench_Slot_S, h=Stepper_W/2.0);
                        translate([0,0,Stepper_Mount_L-Stepper_Mount_Flange_T-2*Stepper_Mount_Wrench_Slot_Offset-2*Stepper_Mount_Wrench_Slot_S/2.0])
                            rotate([0,90,0])
                                cylinder(d=Stepper_Mount_Wrench_Slot_S, h=Stepper_W/2.0);
                    }
                }
    
        // Create mounting holes and nut slots
        for(i=[0:90:270])
            rotate([0,0,i]){
                translate([(Stepper_W/2.0+Stepper_Coupler_D/2.0)/2.0,0,2*Stepper_Mount_Flange_T])
                    cylinder(d=Stepper_Mount_Hole_D, h=Stepper_Mount_L-2*Stepper_Mount_Flange_T+eps);
                translate([(Stepper_W/2.0+Stepper_Coupler_D/2.0)/2.0,0,Stepper_Mount_L-Stepper_Mount_Flange_T-Stepper_Mount_Nut_Slot_T]){
                    cylinder($fn=6, d=Stepper_Mount_Nut_Slot_D, h=Stepper_Mount_Nut_Slot_T);
                    translate([0,-Stepper_Mount_Nut_Slot_D*cos(30)/2.0,0])
                        cube([(Stepper_W-Stepper_Coupler_D)/4.0+1.0, Stepper_Mount_Nut_Slot_D*cos(30), Stepper_Mount_Nut_Slot_T]);
                }
            }
    }
}

01_StepperMount();