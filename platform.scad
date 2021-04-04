include <constants.scad>;
use <../scaddy/nema.scad>;
yoff=-0;
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
		offset(0.2)polygon([[-30,38],[30,38],[0,8],[7.5,3],[7.5,-3],[0,-8],[30,-38],[-30,-38]]);
		for(y=[-3:6:3])translate([7.5,y])circle(d=2.5);
		translate([20,0])square([15,8.5],center=true);
	}
	//Slot for idler screws:
	for(z=[-5:10:5])translate([ep,0,z-15.25])rotate([0,90,0])
		cylinder(d=5,h=20);
}

module limit_cutout(){
	for(y=[0:6.45:6.45])translate([-1.5+ep,y-3.225,-5-ep])cylinder(d=2.5,h=5+ep);
	cube([7+epp,15,7.5],center=true);
}

module tensioner() {
	//Base:
	translate([-4,0,0])difference(){
		union(){
			linear_extrude(6,center=true,convexity=2){
				for(x=[0:2:10])translate([x-5,0,0])circle(d=1.5);
			}
			translate([4,2,-2])cube([22,4,12],center=true);
		}
		rotate([90,0,0])hull(){
			translate([10+1.5,0,0])cylinder(h=10,d=3.5,center=true);
			translate([10-1.5,0,0])cylinder(h=10,d=3.5,center=true);
		}
		translate([-10,0,-5.5])rotate([90,0,0])
			translate([10+1.5,0,0])cylinder(h=10,d=3.5,center=true);
	}
	//Clamp:
	translate([-4,-0.5,0])difference(){
		translate([4,-2,-2])cube([22,4,12],center=true);
		translate([0,ep-0.75,0])cube([20+epp,1.5+epp,6.5],center=true);
		rotate([90,0,0])hull(){
			translate([10+1.5,0,0])cylinder(h=10,d=3.5,center=true);
			translate([10-1.5,0,0])cylinder(h=10,d=3.5,center=true);
		}
		translate([-10,0,-5.5])rotate([90,0,0])
			translate([10+1.5,0,0])cylinder(h=10,d=3.5,center=true);
	}

}

module x_slider(){
	difference(){
		union(){
			//main body:
			translate([0,0,50])rotate([90,0,90])linear_extrude(50,center=true,convexity=4)difference(){
				translate([0,0])square([60,60],center=true);
				translate([15,15])circle(d=16);
				translate([-15,15])circle(d=16);
				translate([-12.625-ep,-15-ep])square([34.75+epp,30+epp],center=true);
			}
			//Extensions for distant tensioners:
			translate([7,-1.125,38.85])cube([9.5,11.75,7.5],center=true);
			translate([-7,-1.125,29.85])cube([9.5,11.75,7.5],center=true);
		}
		//screw holes:
		translate([6,10,38.85])rotate([90,0,0])cylinder(d=4,h=25);
		translate([-6,10,29.85])rotate([90,0,0])cylinder(d=4,h=25);
		translate([-6,10,38.85])rotate([90,0,0])cylinder(d=4,h=25);
		translate([6,10,29.85])rotate([90,0,0])cylinder(d=4,h=25);
		for(y=[-15:30:15])for(x=[-15:30:15])
			translate([x,y,70])cylinder(d=4,h=15+ep);
		for(z=[-15:30:15])for(x=[-15:30:15])
			translate([x,27+ep,z+40])rotate([90,0,0])cylinder(d=4,h=6+epp,center=true);
	}
}
module x_slider_assembly(){
	translate([0,0,-0.15]){
		//outside teeth on pulley
		translate([12,6.2-6,30])rotate([0,0,180])scale([1,-1,1])tensioner();
		//inside teeth on pulley
		translate([-12,-5.55-6,30])rotate([0,0,180])scale([-1,-1,1])tensioner();
		//outside teeth on pulley
		translate([-12,6.2-6,39])rotate([0,0,180])scale([-1,-1,-1])tensioner();
		//inside teeth on pulley
		translate([12,-5.55-6,39])rotate([0,0,180])scale([1,-1,-1])tensioner();
	}
	x_slider();
}

module y_slider(){
	difference(){
		//Main body
		rotate([90,0,0])linear_extrude(50,center=true,convexity=4)difference(){
			translate([-2.5-2.25,0])square([35-4.5,60],center=true);
			translate([0,15])circle(d=15.5);
			translate([-15-ep,-15-ep])square([20+epp,30+epp],center=true);
		}
		translate([5,-5])rotate(225)
			idler_cutout();
		//Slot for X axis rods
		for(y=[-15:30:15]) translate([-18-ep,y,15+3.5])rotate([0,90,0])
			cylinder(d=8.5,h=20+epp,center=true);
		//Retaining Screwholes:
		for(y=[-15:30:15])for(x=[-15:15:0])
			translate([x,y,15])cylinder(d=4,h=15+ep);
		translate([-16.5,-10,5])limit_cutout();
	}
}
module y_slider_assembly(){
	y_slider();
	translate([-3.5,11.5-25,-15])rotate(225)idler_block();
}

module y_termination(){
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

module y_termination_assembly(){
	y_termination();
	translate([-3.5,-11.5,-5])rotate(135)idler_block();
}

module y_motor_termination(){
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

module y_motor_termination_assembly(){
	y_motor_termination();
	translate([18+11.4,49,-20])nema_17();
}

for(m=[-1:2:1])scale([m,1,1])
color(black)
translate([155,-150,40])y_termination_assembly();

for(m=[-1:2:1])scale([m,1,1])
color(black)
translate([155,150,40])y_motor_termination_assembly();

for(m=[-1:2:1]) scale([m,1,1])
//color(black)
translate([155,yoff,50])scale([1,-1,1])y_slider_assembly();

*color(black)
translate([xoff,yoff,50])cube([50,50,60],center=true);
//axis rods:
color(silver){
	//Y axis
	translate([0,yoff+15,68.5])rotate([0,90,0])cylinder(d=8,h=300,center=true);
	translate([0,yoff-15,68.5])rotate([0,90,0])cylinder(d=8,h=300,center=true);
	//X axis:
	translate([155,0,65])rotate([90,0,0])cylinder(d=8,h=300,center=true);
	translate([-155,0,65])rotate([90,0,0])cylinder(d=8,h=300,center=true);
}
//baseplate:
translate([0,0,-10])
linear_extrude(10)
import("baseplate.svg",center=true);
//cube([350,350,10],center=true);

x_slider_assembly();