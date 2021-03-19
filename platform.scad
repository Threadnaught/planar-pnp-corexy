include <constants.scad>;
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

translate([-3.5,11.5,35])rotate(360-135)idler_block();

//Y axis slider
translate([0,0,50])difference(){
	//Main body
	rotate([90,0,0])linear_extrude(50,center=true,convexity=4)difference(){
		translate([-2.5-2.25,0])square([35-4.5,60],center=true);
		translate([0,15])circle(d=15.5);
		translate([-15-ep,-15-ep])square([20+epp,30+epp],center=true);
	}
	translate([5,20])rotate(360-135){
		//Slot for idler block:
		rotate([0,180,180])linear_extrude(30+epp,convexity=4){
			offset(0.2)polygon([[-10,8],[0,8],[7.5,3],[7.5,-3],[0,-8],[-10,-8]]);
			for(y=[-3:6:3])translate([7.5,y])circle(d=2.5);
			translate([20,0])square([15,8.5],center=true);
		}
		//Slot for idler screws:
		for(z=[-5:10:5])translate([ep,0,z-15.25])rotate([0,90,0])
			cylinder(d=5,h=20);
	}
	//Slot for X axis rods
	for(y=[-15:30:15]) translate([-18-ep,y,15])rotate([0,90,0])
		cylinder(d=8.5,h=20+epp,center=true);
	//Retaining Screwholes:
	for(y=[-15:30:15])for(x=[-15:15:0])
		translate([x,y,15])cylinder(d=4,h=15+ep);
	//Limit Sw Screwholes:
	for(y=[0:6.45:6.45])translate([-18,15+y-(6.45/2),-ep])cylinder(d=2.5,h=5+ep);
	translate([-16.5-ep,15,5])cube([7+epp,15,7.5],center=true);

}