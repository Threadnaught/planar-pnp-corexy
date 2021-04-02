include <constants.scad>
use <../scaddy/nema.scad>


!union(){
	//base
	difference(){
		translate([15,0,-2.5])cube([80,80,5],center=true);
		translate([20+ep,0,-2.5])cube([70+epp,50,5+epp],center=true);
	}
	translate([22.5,0,-1])cube([95,80,2],center=true);

	//spine
	translate([-22.5,0,37.5])cube([5,30,75],center=true);

	//motor holder
	translate([0,0,22.5])linear_extrude(5)difference(){
		translate([-2.5,0])square([35,30],center=true);
		circle(d=23);
		translate([0,0])square([30,10],center=true);
		for(th=[0:90:359])rotate(th)translate([23/2,23/2])circle(d=2.5);
	}

	//bearing holder
	translate([0,0,65])difference(){
		union(){
			translate([0,0,5])cylinder(d=32,h=10,center=true);
			translate([-15,0,5])cube([10,20,10],center=true);
		}
		translate([0,0,2])cylinder(d=24,h=8+ep);
		for(th=[0:120:360])rotate([90,0,90+th])translate([0,7.5,10])cylinder(d=4,h=10);
	}

	//struts
	for(s=[-1:2:1])scale([1,s,1])translate([-23,10,0])rotate([0,-90,0])linear_extrude(2)polygon([[60,0],[30,0],[0,15],[0,30]]);
}

//motor
%translate([0,0,28])rotate([0,180,0])nema_11();

//rotating section:
rotate(0){
	difference(){
		union(){
			translate([30,0,52.5])cube([5,15,80],center=true);
			translate([10,0,16.5])cube([35,15,8],center=true);
			translate([10,0,90])cube([35,15,5],center=true);
			translate([0,0,68])cylinder(d=7.95,h=19.5);
		}
		for(y=[-3.5:7:3.5])for(z=[0:48:48])translate([30,y,z+32.5])rotate([0,90,0])cylinder(d=3,h=5+epp,center=true);
		translate([0,0,16.5])cylinder(d=5.5,h=8+epp,center=true);
		translate([0,0,16.5]) rotate([0,-90,0])cylinder(d=4,h=7.5+ep);
	}
	union(){
		//OLD::::
		difference(){
			translate([0,0,20])linear_extrude(25,convexity=4)difference(){
				translate([53,0])square([30,20],center=true);
				translate([65,0])circle(d=1.6);
				for(y=[-5:10:5]){
						hull(){
						translate([40,y])circle(d=3.6);
						translate([35,y])circle(d=3.2);
					}
					translate([54,y*1.2])square([6,3.5],true);
				}
				hull(){
					translate([54,0])circle(d=3.5);
					translate([45,0])circle(d=4);
					translate([35,0])circle(d=4);
				}
			}
			translate([50,0,32.5])cube([25,20+epp,10],true);
			translate([54,0,25])rotate([90,0,0])cylinder(h=20+epp,d=3.5,center=true);
			translate([62,0,40])cylinder(d=11,h=5+ep);
		}
		translate([53,30,35])difference(){
			//Body:
			translate([0,0,-2.5])cube([30,20,25],center=true);
			//Cutouts for slider:
			translate([-17.5,0,-2.5])cube([25,20+epp,10],center=true);
			translate([-8.5,0,-6])cube([25,20+epp,3],center=true);
			//Cutout for guide rods:
			for(y=[-5:10:5]){
				linear_extrude(30+epp,center=true)hull(){
					translate([-13,y])circle(d=3.6);
					translate([-18,y])circle(d=3.2);
				}
			}
			//Cutout for lead screw / slider clamp (bottom):
			translate([0,0,-11.25])linear_extrude(7.5+epp,center=true)hull(){
				translate([1,0])circle(d=3.5);
				translate([-8,0])circle(d=4);
				translate([-18,0])circle(d=4);
			}
			//Cutout for lead screw (top):
			translate([0,0,8.75])linear_extrude(12.5+epp,center=true)hull(){
				translate([-8,0])circle(d=4);
				translate([-18,0])circle(d=4);
			}
			//NUT CUTOUT:
			for(y=[-6:12:6]){
				translate([1,y,-11.25])cube([6,3.5,7.5+epp],center=true);
			}
			//Lateral screwholes:
			translate([1,0,-10])rotate([90,0,0])cylinder(h=20+epp,d=3.5,center=true);
			//Vertical screwholes:
			for(y=[-6:12:6]){
				translate([-1.5,y,5])cylinder(h=20+epp,d=4,center=true);
			}
			//Needle hole/valve:
			translate([62-53,0,5])cylinder(d=11,h=5+ep);
			translate([65-53,0])cylinder(d=1.6,h=30+epp,center=true);
		}
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