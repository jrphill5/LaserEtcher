$fn = 100;

eps = 0.05;

Rail_D = 12.0 + 0.5;

// 01_StepperMount.scad

Stepper_W = 42.0;
Stepper_Hole_S = 31.0;
Stepper_Hole_D = 4.0;
Stepper_Coupler_D = 22.0 + 0.5;

Stepper_Mount_L = 37.0;
Stepper_Mount_Flange_T = 5.0;
Stepper_Mount_Chamfer = 4.0;

Stepper_Mount_Wrench_Slot_S = 3.0;
Stepper_Mount_Wrench_Slot_Offset = 10.0;

Stepper_Mount_Nut_Slot_T = 4.5;
Stepper_Mount_Nut_Slot_D = 9.5;

Stepper_Mount_Hole_D = 6.0;

// 02_RodMountEndstop.scad

Rod_Mount_L = 100;
Rod_Mount_W = 60;
Rod_Mount_T = 10;

Rotary_Bearing_T = 7.0;
Rotary_Bearing_OD = 22.225 + 0.25;
Rotary_Bearing_ID = 10.0 + 5.0;
//Rotary_Bearing_ID = Stepper_Coupler_D;

Rod_Mount_Hole_Sx = 60;
Rod_Mount_Hole_Sy = 36;
Rod_Mount_Hole_D = 6;

Endstop_Switch_L = 20 + 0.5;
Endstop_Switch_W = 6.5 + 0.25;
Endstop_Switch_D = 5.5;
Endstop_Switch_S = 6.0;

Endstop_Switch_Hole_D = 4;
Endstop_Switch_Hole_S = 8;

// 03_ToolheadSled.scad

// For 1/4"-20 x 1" countersink screw
Screw_Head_S = 7.0;
Screw_Head_D = 12.0 + 0.75;
Screw_Head_T = 5.0;
Screw_Body_D = 6.5;

Guide_Rod_D = 9.5 + 1.5;

Toolhead_Nut_T = 8.5 + 1.0 - 0.125;
Toolhead_Nut_W = 20.0 + 1.0;

Toolhead_Bearing_ID = 12.0 + 0.75;
Toolhead_Bearing_OD = 21.0 + 0.50 - 0.125;
Toolhead_Bearing_L = 30.0;
Toolhead_Bearing_S = Rod_Mount_Hole_Sx;

Toolhead_Margin = 5.0;

// 05_YAxisCup.scad

Y_Axis_Cup_D = 10.0;
Y_Axis_Cup_T = 2.5;
Y_Axis_Cup_M = 0.25;

XZSled_Bearing_OD = Toolhead_Bearing_OD + 0.50 - 0.125;

Extrusion_W = 20.0 + 0.25;

M5_Washer_D = 10.0;
M5_Head_H = 6.0;
M5_Bolt_D = 6.0;
M5_Bolt_L = 16.0;