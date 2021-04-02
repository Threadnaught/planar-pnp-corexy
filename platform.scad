include <constants.scad>;
use <../scaddy/nema.scad>;
yoff=-85;
xoff=0;

black=[0.33,0.33,0.33];
white=[1,1,1];
silver=[0.8,0.8,0.8];

module idler_block_profile(){
	hull(){
		translate([-21.5*sqrt(2),0])circle(d=16);
		translate([-12.5,0])square([1,16],center=true);
	}
	
}
module idler_block(){
	difference(){
		union(){
			//Profiles:
			translate([0,0,-12.775])linear_extrude(5.95,center=true)idler_block_profile();
			translate([0,0,-0.25])linear_extrude(0.5,center=true)idler_block_profile();
			translate([0,0,10.775])linear_extrude(2.95,center=true)idler_block_profile();
			//Spacers:
			translate([-21.5*sqrt(2),0,9.15])cylinder(d1=5,d2=10,h=0.3,center=true);
			translate([-21.5*sqrt(2),0,0.15])cylinder(d1=10,d2=5,h=0.3,center=true);
			translate([-21.5*sqrt(2),0,-0.65])cylinder(d1=5,d2=10,h=0.3,center=true);
			translate([-21.5*sqrt(2),0,-9.65])cylinder(d1=10,d2=5,h=0.3,center=true);
		}
		//Screw/Insert:
		translate([-21.5*sqrt(2),0,5])cylinder(d=3.5,h=20,center=true);
		translate([-21.5*sqrt(2),0,-12])cylinder(d=4,h=10,center=true);
	}
	//Back:
	difference(){
		translate([-20.5,0,-1.75])linear_extrude(28,center=true)polygon([[8.5,8],[16,3],[16,-3],[8.5,-8]]);
		for(z=[-5:10:5])translate([8.5-ep-20.5,0,z-0.25])rotate([0,90,0])
			union(){
				cylinder(d=5,h=15);
				cylinder(d=8.5,h=4,$fn=6);
			}
	}
}
module idler_cutout(){
	//Slot for idler block:
	rotate([0,180,180])linear_extrude(35+epp,convexity=4){
		offset(0.2)polygon([[-10,8],[0,8],[7.5,3],[7.5,-3],[0,-8],[-10,-8]]);
		for(y=[-3:6:3])translate([7.5,y])circle(d=2.5);
		translate([20,0])square([15,8.5],center=true);
	}
	//Slot for idler screws:
	for(z=[-5:10:5])translate([ep,0,z-15.25])rotate([0,90,0])
		cylinder(d=5,h=20);
}
//translate([16.5+ep,-15,-5])
module limit_cutout(){
	for(y=[0:6.45:6.45])translate([-1.5+ep,y-3.225,-5-ep])cylinder(d=2.5,h=5+ep);
	cube([7+epp,15,7.5],center=true);
}

module y_axis_slider(){
	difference(){
		//Main body
		rotate([90,0,0])linear_extrude(50,center=true,convexity=4)difference(){
			translate([-2.5-2.25,0])square([35-4.5,60],center=true);
			translate([0,15])circle(d=15.5);
			translate([-15-ep,-15-ep])square([20+epp,30+epp],center=true);
		}
		translate([5,20])rotate(225)
			idler_cutout();
		//Slot for X axis rods
		for(y=[-15:30:15]) translate([-18-ep,y,15])rotate([0,90,0])
			cylinder(d=8.5,h=20+epp,center=true);
		//Retaining Screwholes:
		for(y=[-15:30:15])for(x=[-15:15:0])
			translate([x,y,15])cylinder(d=4,h=15+ep);
		translate([-16.5,15,5])limit_cutout();
	}
}
module y_axis_slider_assembly(){
	y_axis_slider();
	translate([-3.5,11.5,-15])rotate(225)idler_block();
}

module y_axis_termination(){
	difference(){
		//Main body
		union(){
			rotate([90,0,0])linear_extrude(50,center=true,convexity=4)difference(){
				translate([1.5,0])square([18,80],center=true);
				translate([0,25])circle(d=8.5);
			}
			translate([0,0,-37.5])cube([40,50,5],center=true);
		}
		//Retaining Screwholes:
		for(y=[-15:30:15])
			translate([0,y,25])cylinder(d=4,h=20+ep);
		//Mounting Screwholes
		for(y=[-15:30:15])for(x=[-15:30:15])
			translate([x,y,-50])cylinder(d=5.5,h=20+ep);
		translate([5,-20,10])rotate(135)
			idler_cutout();
		//Limit Sw Slot:
		translate([-2.5,21.5,10])rotate([90,0,90])limit_cutout();
	}
}

module y_axis_termination_assembly(){
	y_axis_termination();
	translate([-3.5,-11.5,-5])rotate(135)idler_block();
}

module y_axis_motor_termination(){
	difference(){
		//Main body
		union(){
			rotate([90,0,0])linear_extrude(50,center=true,convexity=4)difference(){
				translate([1.5,0])square([18,80],center=true);
				translate([0,25])circle(d=8.5);
			}
			translate([0,0,-37.5])cube([40,50,5],center=true);
		}
		//Retaining Screwholes:
		for(y=[-15:30:15])
			translate([0,y,25])cylinder(d=4,h=20+ep);
		//Mounting Screwholes
		for(y=[-15:30:15])for(x=[-15:30:15])
			translate([x,y,-50])cylinder(d=5.5,h=20+ep);
	}
	//Stepper mount:
	translate([0,0,-20])linear_extrude(5)difference(){
		polygon([[55,15],[55,70],[10,70],[-5,70],[-5,-25],[10,-25]]);
		translate([18+11.4,49])circle(d=30);
		translate([18+11.4,49])for(y=[-31/2:31:31/2])for(x=[-31/2:31:31/2])
			hull(){
				translate([x-2,y])circle(d=4);
				translate([x+2,y])circle(d=4);
			}
	}
}

module y_axis_motor_termination_assembly(){
	y_axis_motor_termination();
	translate([18+11.4,49,-20])nema_17();
}

for(m=[-1:2:1])scale([m,1,1])
color(white)
translate([155,-150,40])y_axis_termination_assembly();

for(m=[-1:2:1])scale([m,1,1])
color(white)
translate([155,150,40])y_axis_motor_termination_assembly();

for(m=[-1:2:1]) scale([m,1,1])
color(black)
translate([155,yoff,50])scale([1,-1,1])y_axis_slider_assembly();

color(black)
translate([xoff,yoff,50])cube([50,50,60],center=true);
//axis rods:
color(silver){
	//Y axis
	translate([0,yoff+15,65])rotate([0,90,0])cylinder(d=8,h=300,center=true);
	translate([0,yoff-15,65])rotate([0,90,0])cylinder(d=8,h=300,center=true);
	//X axis:
	translate([155,0,65])rotate([90,0,0])cylinder(d=8,h=300,center=true);
	translate([-155,0,65])rotate([90,0,0])cylinder(d=8,h=300,center=true);
}
//baseplate:
translate([0,0,-10])
linear_extrude(10)
import("baseplate.svg",center=true);
//cube([350,350,10],center=true);

*difference(){
	union(){
		*linear_extrude(25,center=true,convexity=2){
			for(x=[0:2:10])translate([x-5,0,0])circle(d=1.5);
			translate([0,1,0])square([25,2],center=true);
		}
		translate([0,-5,0])cube([25,2,25],center=true);
	}
	for(z=[-1:2:1])for(x=[-1:2:1])scale([x,1,z])translate([9,0,9])rotate([90,0,0])cylinder(h=20,d=3.75,center=true);
}