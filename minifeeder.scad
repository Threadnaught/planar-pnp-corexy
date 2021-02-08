use<../scaddy/vslot.scad>;
use<../scaddy/solenoid.scad>;


clearance=0.5;
ep=0.001;//epsilon
epp=ep*2;
$fn=48;
*translate([0,10,0])rotate([90,0,0])extruded_2040_v(20);
module rail_lock(){
	offset(-clearance)polygon([[3.1,3],[3.1,1.8],[4.9,0],[4.9,-clearance],[-4.9,-clearance],[-4.9,0],[-3.1,1.8],[-3.1,3]]);
}
*difference(){
	rotate([90,90,0])linear_extrude(15,center=true,convexity=3){
		translate([0,20])rotate(180)rail_lock();
		polygon([[3,20],[-3,20],[-3,21],[-16,21],[-16,-20],[-30,-20],[-30,26],[3,26]]);
	}
	translate([-12.5-ep,4,26])rotate([0,90,0])cylinder(d=4,15+ep,center=true);
	translate([-12.5-ep,-4,21])rotate([0,90,0])cylinder(d=4,15+ep,center=true);
}
*difference(){
	rotate([90,90,0])linear_extrude(15,center=true,convexity=3){
		translate([0,-20])rail_lock();
		polygon([[3,-20],[-3,-20],[-3,-21],[-16,-21],[-16,-20-clearance],[-30,-20-clearance],[-30,-26],[3,-26]]);
	}
	translate([-22.5,4,26])rotate([0,90,0])cylinder(d=3+clearance,10,center=true);
	translate([-22.5,-4,21])rotate([0,90,0])cylinder(d=3+clearance,10,center=true);
}

tooth_spacing=4;
sprocket_dia_target=34;
tooth_depth=1;
gear_count = floor((sprocket_dia_target*PI)/tooth_spacing);
sprocket_dia_real = gear_count*tooth_spacing/PI;
angle_per = 360/gear_count;
pusher_rad = sprocket_dia_real/2-5;
module sprocket(){
	rotate([0,90,0])union(){
		translate([0,0,-2.5])linear_extrude(1,convexity=10){
			for(th=[0 : angle_per : 360])rotate(th)
				translate([0,sprocket_dia_real/2,0])polygon([[-0.375,-1.5],[-0.375,-0.25],[-0.25,0.25],[0.25,0.25],[0.375,-0.25],[0.375,-1.5]]);
			
		}
		translate([0,0,-2])linear_extrude(1,center=true){
			difference(){
				circle(d=sprocket_dia_real-1.5,$fn=gear_count);
				circle(d=10.5,$fn=gear_count);
			}
		}
		translate([0,0,-1.5])linear_extrude(5.5,convexity=10)difference(){
			for(th=[0 : angle_per*2 : 360])
				rotate(th)polygon([[0,0],[pusher_rad-1.5,0],[(pusher_rad-4)*cos(angle_per*2),(pusher_rad-3)*sin(angle_per*2)]]);
			circle(d=10.5,$fn=gear_count);
		}
	}
}
module baseplate(){
	difference(){
		union(){
			circle(d=sprocket_dia_real+4);
			translate([0,(sprocket_dia_real+20)/2])square([sprocket_dia_real+4,sprocket_dia_real+20],center=true);
		}
		translate([10,40])circle(d=4);
		translate([10,32.5])circle(d=4);
		hull(){
			translate([5,45])circle(d=3);
			translate([5,30])circle(d=3);
		}
		circle(d=6.5);
	}
}
module guideplate(){
	rotate([0,90,0]){
		translate([0,0,5.5])linear_extrude(1,center=true)baseplate();
		difference(){
			linear_extrude(10,convexity=4,center=true){
				difference(){
					baseplate();
					circle(d=sprocket_dia_real+1.75);
					difference(){
						translate([0,50])square([sprocket_dia_real+1.75,100],center=true);
					}
				}
				union(){
					translate([(sprocket_dia_real-2.25)/2,(sprocket_dia_real+10)/2])square([0.75,sprocket_dia_real+10],center=true);
					translate([(-sprocket_dia_real+2.25)/2,(sprocket_dia_real+10)/2])square([0.75,sprocket_dia_real+10],center=true);
					difference(){
						circle(d=sprocket_dia_real-1.5);
						circle(d=sprocket_dia_real-3);
						translate([0,(sprocket_dia_real-3.5)/2])square(sprocket_dia_real-3,center=true);
					}
				}
			}
			translate([0,0,-0.75])scale([1,1,-1])cylinder(d=sprocket_dia_real+1.75-ep,10);
		}
	}
	difference(){
		union(){
			translate([0,70,-8.5])cube([12,45,5],center=true);
			translate([0,50,-12])cube([12,5,5],center=true);
		}
		hull(){
			translate([0,60,-10.375])cylinder(1.25+epp,d1=6,d2=3.5,center=true);
			translate([0,85,-10.375])cylinder(1.25+epp,d1=6,d2=3.5,center=true);
		}
		hull(){
			translate([0,60,-7.875])cylinder(3.75+epp,d=3.5,center=true);
			translate([0,85,-7.875])cylinder(3.75+epp,d=3.5,center=true);
		}
	}
}
module mountplate(){
	translate([-5,0])rotate([0,90,0])linear_extrude(1,center=true)baseplate();
}
module pusher_arm(){
	difference(){
		translate([0.25,0,9])rotate([0,90,0])linear_extrude(8,convexity=4,center=true)difference(){
			polygon([[0,0],[-3.8,0],[-3.8,4],[-3.8,21],[-2.5,21],[-2.5,23],[-3.8,23],[-3.8,45],[1.5,45],[1.5,10],[-1.5,5],[-1.5,4]]);
			translate([-1,40])circle(d=3.5);
		}
		translate([-ep-1.75,11.5-ep,10.25])cube([4,23+epp,5.5+epp],center=true);
		translate([0.25,40+ep,10.25])cube([4,10,5.5+epp],center=true);
	}
}
module pusher_lever(){
	translate([0.25,5,0]) difference(){
		rotate([0,90,0])linear_extrude(8,convexity=4,center=true)difference(){
				translate([0,35])square([25.5,6],center=true);
				translate([10,35])circle(d=4);
				translate([-10,35])circle(d=3.75);
			}
		for(s=[-1:2:1])scale([s,1,1])
			translate([-2.75-ep,35,9+ep])cube([2.5+ep,6+epp,8+epp],center=true);
	}
}
%*rotate([180,0,0])sprocket();
*guideplate();
*mountplate();
pusher_arm();
pusher_lever();
translate([0.25,78,3])rotate([0,0,180])solenoid(10);
