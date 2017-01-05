include <00_GlobalVariables.scad>

module 05_XYAxesCoupler(){
    // Draw main body with bearing mounts
    difference(){
    translate([0,0,Toolhead_Bearing_OD/2.0+Toolhead_Margin])
        difference(){
            cube([Toolhead_Bearing_OD+2.0*Toolhead_Margin, Rod_Mount_W+Toolhead_Bearing_L, Toolhead_Bearing_OD+2.0*Toolhead_Margin], center=true);
    
            for(i=[-1,1])
                translate([0,i*Rod_Mount_W/2.0,0])
                    rotate([i*90,0,0])
                        cylinder(d=XZSled_Bearing_OD, h=Toolhead_Bearing_L+2*eps, center=true);
    
            rotate([90,0,0])
                cylinder(d=Toolhead_Bearing_ID, h=Rod_Mount_W+Toolhead_Bearing_L+2*eps, center=true);
    
            intersection(){
                rotate([90,0,0])
                    cylinder(d=XZSled_Bearing_OD, h=Rod_Mount_W, center=true);
                rotate([0,90,0])
                    cube([0.25*XZSled_Bearing_OD, Rod_Mount_W, XZSled_Bearing_OD], center=true);
            }
    
        }

        translate([0,0,-eps]){
            cylinder(d=M5_Bolt_D, h=Toolhead_Bearing_OD+2*Toolhead_Margin+2*eps);
            cylinder(d=M5_Washer_D, h=Toolhead_Margin+Toolhead_Bearing_OD-(Toolhead_Bearing_OD-Toolhead_Bearing_ID)/2.0+M5_Head_H+eps);
        }

    }
    
    // Draw X axis holding slot
    translate([0,0,(Y_Axis_Cup_D+Y_Axis_Cup_M)/2.0+Toolhead_Bearing_OD+2*Toolhead_Margin])
        difference(){
            cube([Toolhead_Bearing_OD+2*Toolhead_Margin, Rod_Mount_W+2*Y_Axis_Cup_T+2*Y_Axis_Cup_M, Y_Axis_Cup_D+Y_Axis_Cup_M], center=true);
            cube([Rod_Mount_T+2*Y_Axis_Cup_M, Rod_Mount_W+2*Y_Axis_Cup_M, Y_Axis_Cup_D+Y_Axis_Cup_M+2*eps], center=true);
            cube([Toolhead_Bearing_OD+2*Toolhead_Margin+2*eps, Rod_Mount_W-2*Y_Axis_Cup_D+2*Y_Axis_Cup_M, Y_Axis_Cup_D+Y_Axis_Cup_M+2*eps], center=true);
        }
    
    // Draw extrusion attachments
    difference(){
            for(i=[-1,1])
                translate([0,i*((Rod_Mount_W+Toolhead_Bearing_L)/2.0-Toolhead_Margin-Extrusion_W/2.0),-(Extrusion_W+Toolhead_Margin)/2.0])
                    cube([Toolhead_Bearing_OD+2*Toolhead_Margin, Extrusion_W+2*Toolhead_Margin, Extrusion_W+Toolhead_Margin], center=true);
        for(i=[-1,1]){
            translate([((Toolhead_Bearing_OD+2*Toolhead_Margin)/2.0+eps)/2.0,i*(Rod_Mount_W/2.0+Toolhead_Bearing_L/2.0-Extrusion_W/2.0-Toolhead_Margin),-Extrusion_W/2.0+eps/2.0])
                cube([(Toolhead_Bearing_OD+2*Toolhead_Margin)/2.0+Toolhead_Margin+eps, Extrusion_W, Extrusion_W+eps], center=true);
            translate([0,i*(Rod_Mount_W/2.0+Toolhead_Bearing_L/2.0-Extrusion_W/2.0-Toolhead_Margin),-Extrusion_W/2.0]){
                rotate([0,-90,0])
                    cylinder(d=M5_Bolt_D, h=Toolhead_Bearing_OD+2*Toolhead_Margin+2*eps, center=true);
                translate([-Toolhead_Bearing_OD/2.0-Toolhead_Margin-eps,0,0])
                    rotate([0,90,0])
                        cylinder(d=M5_Washer_D, h=Toolhead_Bearing_OD/2.0+eps);
            }
        }
    }

}

05_XYAxesCoupler();