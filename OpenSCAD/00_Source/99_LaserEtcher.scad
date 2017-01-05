include <00_GlobalVariables.scad>

use <01_StepperMount.scad>
use <02_XAxisBlankEndstop.scad>
use <02_XAxisStepperEndstop.scad>
use <03_ToolheadSled.scad>
use <04_ToolheadSledBumper.scad>
use <05_XYAxesCoupler.scad>
use <06_YAxisBlankEndstop.scad>
use <06_YAxisStepperEndstop.scad>
use <07_YAxisNutMount.scad>

W = 500.0;
L = 500.0;

Printer_W = W + 100.0;
Printer_L = L;

X_Endstop_Adj = -Rod_Mount_T/2.0;
X_Rail_ZS = Rod_Mount_Hole_Sx;
Y_Rail_XS = W;
XY_Rail_ZS = Rod_Mount_L/2.0+Toolhead_Bearing_OD/2.0+Toolhead_Margin;

module BR6(){
    echo("BR6 Rotary Bearing");
    difference(){
        cylinder(d=22.225+4*eps, h=7.14375);
        translate([0,0,-2*eps])
            cylinder(d=9.525, h=7.14375+6*eps);
    }
}

module B6000(){
    echo("B6000 Rotary Bearing");
    difference(){
        cylinder(d=26.0+4*eps, h=8.0);
        translate([0,0,-2*eps])
            cylinder(d=10.0, h=8.0+6*eps);
    }
}

module LHU12(){
    echo("LHU12 Linear Bearing");
    difference(){
        cylinder(d=21.0, h=30.0+4*eps, center=true);
        cylinder(d=12.0, h=30.0+6*eps, center=true);
    }
}

module SHF12(){
    echo("SHF12 Linear Rod Mount");
    difference(){
        union(){
            hull(){
                for(i=[-1,1])
                    translate([i*37.0/2.0,0,0])
                        cylinder(d=10.0, h=9.0);
                translate([-5/2.0,14-1,0]) cube([5,1,9.0]);
                translate([-20/2.0,-14+6,0]) cube([20,1,9.0]);
            }
            translate([-20/2.0,-14,0]) cube([20,6,9.0]);
            cylinder(d=25, h=13.0);
        }
        translate([0,0,-0.5]) cylinder(d=12.0, h=13.0+1.0);
        for(i=[-1,1])
            translate([i*36.0/2.0,0,-0.5])
                cylinder(d=5.5, h=9.0+1.0);
    }
}

module AEX20(L){
    echo(str("20x", L, "mm Aluminum Extrusion"));
    Outer_W = Extrusion_W;
    TSlot_W = 12.0;
    TSlot_D = 6.0;
    TSlot_T = 4.0;
    Center_W = 8.0;
    Outer_T = 2.0;
    Hole_D = 4.2;

    color("DimGrey")
    difference(){
        union(){
            cube([Center_W, Center_W, L], center=true);
    
            for(i=[0:90:270])
                rotate([0,0,i])
                    translate([Outer_W/2.0-(Outer_W-TSlot_W)/4.0, Outer_W/2.0-(Outer_W-TSlot_W)/4.0, 0]){
                        cube([(Outer_W-TSlot_W)/2.0, (Outer_W-TSlot_W)/2.0, L], center=true);
                        translate([-(Outer_W-TSlot_D)/4.0+(Outer_W-TSlot_W)/4.0, (Outer_W-TSlot_W)/4.0-Outer_T/2.0, 0])
                            cube([(Outer_W-TSlot_D)/2.0, Outer_T, L], center=true);
                        translate([(Outer_W-TSlot_W)/4.0-Outer_T/2.0, -(Outer_W-TSlot_D)/4.0+(Outer_W-TSlot_W)/4.0, 0])
                            cube([Outer_T, (Outer_W-TSlot_D)/2.0, L], center=true);
                    }

            for(i=[-1,1])
                rotate([0,0,i*45])
                    cube([sqrt(2.0), sqrt(2.0)*(Outer_W-1.0), L], center=true);

        }

        cylinder(d=Hole_D, h=L+2*eps, center=true);
    }
}

module Rail(D, L){
    echo(str(D, "x", L, "mm Smooth Rod"));
    color("GhostWhite")
        cylinder(d=D, h=L, center=true);
}

module Rod(D, L){
    echo(str(D, "x", L, "mm Threaded Rod"));
    color("DarkSlateGrey")
        cylinder(d=D, h=L, center=true);
}

module Base(){
    echo("Table-Top Base");
    color("DimGrey"){
        cylinder(d=20.0, h=7.0);
        translate([0,0,7.0]) cylinder(d=5.0, h=28.0);
    }
}

// Draw extrusion for printer bed:
for(i=[-1,1]){
    translate([0,i*(Printer_L/2.0+Extrusion_W/2.0),0]) rotate([0,90,0]) AEX20(Printer_W);
    translate([i*(Printer_W/2.0-Extrusion_W/2.0),0,0]) rotate([90,0,0]) AEX20(Printer_L);
    translate([i*(W/2.0+(W/2.0-Printer_W/2.0+Extrusion_W/2.0)),0,0]) rotate([90,0,0]) AEX20(Printer_L);
    for(j=[-1,1]){
        translate([i*(Printer_W/2.0-Extrusion_W/2.0), j*(Printer_L/2.0+Extrusion_W/2.0), +125/2.0+Extrusion_W/2.0]){
            AEX20(125.0);
            translate([0,0,+125.0/2.0+8.0]) rotate([0,180,0]) Base();
        }
        translate([i*(Printer_W/2.0-Extrusion_W/2.0), j*(Printer_L/2.0+Extrusion_W/2.0), -75/2.0-Extrusion_W/2.0]){
            AEX20(75.0);
            translate([0,0,-75.0/2.0-8.0]) Base();
        }
    }
}

// Draw X-axis smooth rails, threaded rod, supports, and bearings:
translate([0,0,XY_Rail_ZS]){
    translate([-914.4/2.0+W/2.0+25.0,0,0]) rotate([0,90,0]) Rod(9.525, 914.4);
    for(i=[-1,1]){
        translate([i*(W/2.0+X_Endstop_Adj),0,0]) rotate([0,i*90,0]) BR6();
        translate([0,0,i*X_Rail_ZS/2.0]){
            rotate([0,90,0]){
                Rail(Rail_D, W);
                LHU12();
            }
            for(j=[-1,1]) translate([-j*(W/2.0+X_Endstop_Adj),0,0]) rotate([j*90,(j-1)*90,90]) SHF12();
        }
    }
}

// Draw Y-axis smooth rails and supports:
for(i=[-1,1])
    translate([i*Y_Rail_XS/2.0,0,0]){
        rotate([90,0,0]) Rail(Rail_D, L);
        for(j=[-1,1])
            translate([0, j*L/2.0, 0]) rotate([j*90,(j-1)*90,0]) SHF12();
    }

// Draw Y-axis threaded rod:
translate([0,-914.4/2.0+L/2.0+Extrusion_W+25.0,-Toolhead_Bearing_OD/2.0-Toolhead_Margin-Extrusion_W/2.0-Extrusion_W/2.0-Guide_Rod_D/2.0]) rotate([90,0,0]) Rod(9.525, 914.4);

// Draw Y-axis linear bearings:
for(i=[-1,1]) for(j=[-1,1]) translate([i*W/2.0, j*Rod_Mount_W/2.0+2*eps, 0]) rotate([90,0,0]) LHU12();

// Draw Y-axis rotary bearings:
for(i=[-1,1]) translate([0,i*L/2.0-2*eps,-Extrusion_W/2.0-Rotary_Bearing_OD/2.0-Toolhead_Margin-Extrusion_W/2.0-Guide_Rod_D/2.0]) rotate([-i*90,0,0]) BR6();

// Draw X-axis extrusion braces:
for(i=[-1,1])
    translate([0,i*(Rod_Mount_W+Toolhead_Bearing_L-Extrusion_W-2*Toolhead_Margin)/2.0,-Toolhead_Bearing_OD/2.0-Toolhead_Margin-Extrusion_W/2.0])
        rotate([0,90,0]) AEX20(W);

// Draw previously designed 3D printed parts:
color("Yellow"){

    translate([0,0,XY_Rail_ZS]){
        translate([+W/2.0+Rod_Mount_T+X_Endstop_Adj,0,0])
            rotate([0,-90,0]){
                translate([0,0,-Stepper_Mount_L+Rod_Mount_T-Rotary_Bearing_T])
                    rotate([0,0,45])
                        01_StepperMount();
                translate([0,0,2*eps])
                    02_XAxisStepperEndstop();
            }
        translate([-W/2.0-Rod_Mount_T-X_Endstop_Adj,0,0])
            rotate([0,90,0])
                translate([0,0,-2*eps])
                    02_XAxisBlankEndstop();
        translate([-Toolhead_Bearing_L/2.0,0,0])
            rotate([90,0,90])
                03_ToolheadSled();
        translate([0,Toolhead_Bearing_OD/2.0+Toolhead_Margin,0])
            rotate([-90,0,0])
                04_ToolheadSledBumper();
    }

    for(i=[-1,1])
        translate([i*W/2.0,0,-Toolhead_Bearing_OD/2.0-Toolhead_Margin])
            rotate([0,0,(i+1)*90]) 05_XYAxesCoupler();

    translate([0,L/2.0+Stepper_Mount_L+Extrusion_W-(Rod_Mount_T-Rotary_Bearing_T),-Toolhead_Bearing_OD/2.0-Toolhead_Margin-Extrusion_W/2.0-Extrusion_W/2.0-Guide_Rod_D/2.0])
        rotate([90,45,0]) 01_StepperMount();

    translate([0,0,-Extrusion_W/2.0]){
        translate([0,-L/2.0,0]) rotate([0,0,180]) 06_YAxisBlankEndstop();
        translate([0,+L/2.0,0]) 06_YAxisStepperEndstop();
    }

    translate([0,0,-Toolhead_Bearing_OD/2.0-Toolhead_Margin-Extrusion_W/2.0]) 07_YAxisNutMount();

}

// Draw table surface:
translate([0, 0, -75-Extrusion_W/2.0-0.5-10]) cube([Printer_W+4*20, Printer_L+2*Extrusion_W+4*Extrusion_W, 1], center=true);

// Draw printer bed:
echo(str((W+(W-Printer_W+Extrusion_W)), "x", Printer_L+Extrusion_W, "mm Build Plate"));
color("Coral", 0.25) cube([(W+(W-Printer_W+Extrusion_W)), Printer_L+Extrusion_W, 1], center=true);