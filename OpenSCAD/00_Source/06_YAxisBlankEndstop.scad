include <00_GlobalVariables.scad>

Endstop_L = 60.0;

Through_Hole_D = 6.0;
Through_Hole_L = 9.0;

Through_Hole_Washer_D = 11.0;

module 06_YAxisBlankEndstop(){
    difference(){
        union(){
            hull(){
                translate([-Endstop_L/2.0,0,-Through_Hole_L])
                    cube([Endstop_L,Extrusion_W,Through_Hole_L]);
                
                translate([-Stepper_W/2.0,0,-Stepper_W/2.0-Rotary_Bearing_OD/2.0-Toolhead_Margin-Extrusion_W/2.0-Guide_Rod_D/2.0])
                    cube([Stepper_W,Extrusion_W,Stepper_W]);
            }
            translate([0,-Toolhead_Margin/2.0,-Endstop_Switch_W/2.0-Endstop_Switch_S])
                cube([Endstop_Switch_L+Toolhead_Margin, Toolhead_Margin, Endstop_Switch_W+Toolhead_Margin], center=true);
        }

        translate([0,-eps+Extrusion_W-Rod_Mount_T,-(Rotary_Bearing_OD/2.0+Toolhead_Margin)-Extrusion_W/2.0-Guide_Rod_D/2.0])
            rotate([-90,0,0]) cylinder(d=Rotary_Bearing_OD, h=Rotary_Bearing_T+2*eps);
        translate([0,+eps+Extrusion_W-Rod_Mount_T,-(Rotary_Bearing_OD/2.0+Toolhead_Margin+Extrusion_W/2.0+Guide_Rod_D/2.0)])
            rotate([-90,0,0]) cylinder(d=Rotary_Bearing_ID, h=Rod_Mount_T);

        for(i=[-1,1])
            translate([i*(Endstop_L/2.0-Extrusion_W/2.0),Extrusion_W/2.0,0]){
                translate([0,0,-Through_Hole_L/2.0])
                    cylinder(d=Through_Hole_D, h=Through_Hole_L+2*eps, center=true);
                translate([0,0,-Rotary_Bearing_OD-2*Toolhead_Margin-Through_Hole_L-20])
                    cylinder(d=Through_Hole_Washer_D, h=Rotary_Bearing_OD+20+2*Toolhead_Margin);
            }

        // Limit switch   
        translate([0,-Toolhead_Margin,-Endstop_Switch_W/2.0-Endstop_Switch_S]) 
            rotate([-90,0,0]){
                translate([0, 0, Endstop_Switch_D/2.0])
                    cube([Endstop_Switch_L, Endstop_Switch_W, Endstop_Switch_D+eps], center=true);
                for(i = [0,1,2]){
                    translate([(i-1)*Endstop_Switch_Hole_S, 0, -eps])
                        cylinder(d = Endstop_Switch_Hole_D, h = Extrusion_W+Toolhead_Margin+2*eps);
                }
            }
            
        translate([-Endstop_L/2.0-eps,-eps,-100-(Endstop_Switch_W+Endstop_Switch_S+Toolhead_Margin/2.0)])
            cube([Endstop_L+2*eps,Extrusion_W-Rod_Mount_T+eps,100]); 
    }

}

06_YAxisBlankEndstop();