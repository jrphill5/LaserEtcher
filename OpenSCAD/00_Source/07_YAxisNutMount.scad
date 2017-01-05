include <00_GlobalVariables.scad>

Through_Hole_D = 6.0;
Through_Hole_L = 9.0;
Through_Hole_S = 20.0;

Through_Hole_Washer_D = 11.0;

Toolhead_Nut_W2 = Toolhead_Nut_W - 0.50;
Toolhead_Nut_T2 = Toolhead_Nut_T - 0.25;

module 07_YAxisNutMount(){
    difference(){
        hull(){
            cube([Extrusion_W+3*Toolhead_Margin,Rod_Mount_W+Toolhead_Bearing_L,Extrusion_W+2*Toolhead_Margin], center=true);
            for(i=[-1,1]) for(j=[0,1]) rotate([j*180,0,0])
                translate([0,i*(Rod_Mount_W+Toolhead_Bearing_L-Extrusion_W-2*Toolhead_Margin)/2.0,Extrusion_W/2.0+Through_Hole_L/2.0+eps])
                    hull(){
                        cube([Extrusion_W+3*Toolhead_Margin,Through_Hole_Washer_D,Through_Hole_L-2*eps], center=true);
                        translate([0,0,-Through_Hole_L/2.0+Toolhead_Margin/2.0])
                            cube([Extrusion_W+3*Toolhead_Margin,Extrusion_W+2*Toolhead_Margin,Toolhead_Margin], center=true);
                    
                        }
            translate([0,0,-Extrusion_W/2.0-Guide_Rod_D/2.0-Toolhead_Margin/2.0])
                cube([Extrusion_W+3*Toolhead_Margin,Toolhead_Nut_T2+2*Toolhead_Margin,Toolhead_Nut_W2*cos(30.0)+Toolhead_Margin], center=true);
           
        }
        
        // Clearance holes for extrusion and screws
        for(i=[-1,1]){
            translate([0,i*(Rod_Mount_W+Toolhead_Bearing_L-Extrusion_W-2*Toolhead_Margin)/2.0,0])
                cube([Extrusion_W+3*Toolhead_Margin+2*eps,Extrusion_W,Extrusion_W], center=true);
            for(j=[-1,1])
                for(k=[0,1])
                    rotate([k*180,0,0])
                        translate([j*Through_Hole_S/2.0,i*(Rod_Mount_W+Toolhead_Bearing_L-Extrusion_W-2*Toolhead_Margin)/2.0,-Extrusion_W/2.0-Through_Hole_L/2.0]){
                            cylinder(d=Through_Hole_D, h=Through_Hole_L+2*eps, center=true);
                            translate([0,0,Extrusion_W+3*Through_Hole_L/2.0-(k-1)*eps])
                                cylinder(d=Through_Hole_Washer_D, h=Guide_Rod_D+Toolhead_Nut_W2+Toolhead_Margin);
                        }
        }
         
        translate([0,0,-Extrusion_W/2.0-Guide_Rod_D/2.0]){
            rotate([90,0,0]){
                // Clearance hole for acme rod
                cylinder(d=Guide_Rod_D, h=Rod_Mount_W+Toolhead_Bearing_L+2*eps, center=true);
        
                // Slot for acme nut
                cylinder($fn=6, h=Toolhead_Nut_T2, d=Toolhead_Nut_W2, center=true);
                translate([(Toolhead_Bearing_OD/2.0+2*Toolhead_Margin)/2.0-0.1*Toolhead_Nut_W2/2.0+eps/2.0,0,0])
                    cube([Toolhead_Bearing_OD/2.0+2*Toolhead_Margin+0.1*Toolhead_Nut_W2+eps,Toolhead_Nut_W2*cos(30),Toolhead_Nut_T2], center=true);
            }
        
            // Slot for removing acme nut
            rotate([0,90,0])
                cylinder(d=3.0, h=Extrusion_W+3*Toolhead_Margin+2*eps, center=true);
        }
        
    }
    
}

07_YAxisNutMount();