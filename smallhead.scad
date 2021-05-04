include <constants.scad>
use <../scaddy/nema.scad>


translate([0,60,0])rotate(90)union(){
	//spine
	translate([-22.5,0,70])difference(){
		cube([5,30,100],center=true);
		hull(){
			translate([0,0,-45])rotate([90,0,90])cylinder(d=3.5,h=6,center=true);
			translate([0,0,20])rotate([90,0,90])cylinder(d=3.5,h=5,center=true);
		}
		translate([0,-10,35])rotate([90,0,90])cylinder(d=3.5,h=6,center=true);
	}

	//motor holder
	translate([0,0,62.5])linear_extrude(5)difference(){
		translate([-10,0])square([20,30],center=true);
		circle(d=23);
		translate([0,0])square([30,10],center=true);
		for(th=[0:90:359])rotate(th)translate([23/2,23/2])circle(d=2.5);
	}

	//camera platform
	translate([0,0,35])linear_extrude(5)difference(){
		hull()for(x=[-20:35:15])for(y=[-12.5:25:12.5])
			translate([x-2.5,y])circle(d=5);
		for(x=[-12:24:12])
			translate([x,x])circle(d=2.5);
		for(y=[-3:6:3])translate([-9,8+y])circle(d=2.5);
	}

	//bearing holder
	translate([0,0,110])difference(){
		union(){
			translate([0,0,5])cylinder(d=32,h=10,center=true);
			translate([-15,0,5])cube([10,20,10],center=true);
		}
		translate([0,0,2])cylinder(d=24,h=8+ep);
		for(th=[0:120:360])rotate([90,0,90+th])translate([0,7.5,10])cylinder(d=4,h=10);
	}
}

//motor
%translate([0,60,68])rotate([0,180,0])nema_11();

//rotating section:
translate([0,60,40])rotate(0+90){
	difference(){
		union(){
			translate([26,0,45])cube([5,15,95],center=true);
			translate([10,0,16.5])cube([35,15,8],center=true);
			translate([10,0,90])cube([35,15,5],center=true);
			translate([0,0,75])cylinder(d=7.95,h=14.5);
			translate([12,-6,16.5])cylinder(d=7.5,h=8,center=true);
			translate([36,-17,64])cube([15,2,10],center=true);
			translate([26,-12.75,64])cube([5,10.5,10],center=true);
		}
		for(y=[-3.5:7:3.5])for(z=[0:48:48])translate([26,y,z+2.5])rotate([0,90,0])cylinder(d=3,h=5+epp,center=true);
		translate([0,0,16.5])cylinder(d=5.5,h=8+epp,center=true);
		translate([12,-6,16.5])cylinder(d=4,h=8+epp,center=true);
		translate([0,0,16.5]) rotate([0,-90,0])cylinder(d=4,h=7.5+ep);
		translate([28,-16,64])for(y=[-3:6:3])rotate([90,90,0])translate([0,10+y])cylinder(h=5+epp,d=2.5,center=true);
	}
	
	translate([53,0,5])difference(){
		//Body:
		translate([2.5,-2.5,-2.5])cube([35,25,25],center=true);
		//Cutouts for slider:
		translate([-17.5,-2.5,-2.5])cube([25,25+epp,10],center=true);
		translate([-3.5,-2.5,-6])cube([25,25+epp,3],center=true);
		//Cutout for guide rods:
		for(y=[-5:10:5]){
			linear_extrude(30+epp,center=true)hull(){
				translate([-13,y])circle(d=3.6);
				translate([-18,y])circle(d=3.2);
			}
		}
		//Cutout for lead screw / slider clamp (bottom):
		translate([0,0,-11.25])linear_extrude(7.5+epp,center=true)hull(){
			translate([6,0])circle(d=3.5);
			translate([-8,0])circle(d=4);
			translate([-18,0])circle(d=4);
		}
		//Cutout for lead screw (top):
		translate([0,0,8.75])linear_extrude(12.5+epp,center=true)hull(){
			translate([-8,0])circle(d=4);
			translate([-18,0])circle(d=4);
		}
		//Vertical screwholes:
		for(y=[-6:12:6]){
			translate([-1.5,y,5])cylinder(h=20+epp,d=4,center=true);
		}
		//Needle hole/valve:
		translate([65-53,0,5])cylinder(d=11,h=5+ep);
		translate([65-53,0])cylinder(d=1.6,h=30+epp,center=true);
	}
	
}

*union(){
	translate([0,15,0])difference(){
		linear_extrude(10,convexity=2)difference(){
			square(15,true);
			circle(d=5.5);
		}
		translate([0,0,5])rotate([90,0,0])cylinder(h=7.5+epp,d=4);
	}
}