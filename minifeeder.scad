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
			translate([0,(sprocket_dia_real+4)/2])square(sprocket_dia_real+4,center=true);
		}
		translate([-3.5,30])circle(d=4);
		translate([11,20])circle(d=4);
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
					translate([(sprocket_dia_real-2.25)/2,(sprocket_dia_real)/2])square([0.75,sprocket_dia_real],center=true);
					translate([(-sprocket_dia_real+2.25)/2,(sprocket_dia_real)/2])square([0.75,sprocket_dia_real],center=true);
					difference(){
						circle(d=sprocket_dia_real-1.5);
						circle(d=sprocket_dia_real-3);
						translate([0,(sprocket_dia_real-3.5)/2])square(sprocket_dia_real-3,center=true);
					}
				}
			}
			translate([0,0,-0.75])scale([1,1,-1])cylinder(d=sprocket_dia_real+1.25-ep,10);
		}
	}
}
module mountplate(){
	translate([-5,0])rotate([0,90,0])linear_extrude(1,center=true)baseplate();
}
module pusher_arm(){
	translate([2.25,0,(sprocket_dia_real/2)-7.5])rotate([0,90,0])linear_extrude(4,center=true)difference(){
		polygon([[0,0],[-3,0],[-3.8,4],[-3.8,21],[-2.5,21],[-2.5,23],[-3.8,23],[-3.8,35],[1.5,35],[1.5,10],[-1.5,5],[-1.5,4]]);
		translate([-1,30])circle(d=4);
	}
}
module pusher_lever(){
	translate([-2.5,27.5,(sprocket_dia_real/2)-4])rotate([0,90,0])linear_extrude(4,center=true)difference(){
		translate([-1,-0.5])square([26,6]);
		translate([2.5,2.5])circle(d=4);
		translate([9,2.5])circle(d=4);
		translate([22,2.5])circle(d=3);
	}
}
%rotate([180,0,0])sprocket();
guideplate();
*mountplate();
pusher_arm();
pusher_lever();
%translate([-2,65,-10])rotate([0,0,0])solenoid(0);








*translate([30,0,0])difference(){
	cube([5,20,5],center=true);
	translate([0,-5-ep,0])rotate([90,0,0])cylinder(5+epp,d=4);
}
//block
*translate([0,0,-4])linear_extrude(9)difference(){
	hull(){
		circle(d=42);
		translate([20,0])circle(d=42);
	}
	hull(){
		circle(d=40.25);
		translate([20,0])circle(d=40.25);
	}
	translate([21.25,-50])square(100);
}
*for(z=[-5:10.5:5.5])translate([0,0,z])linear_extrude(1)difference(){
	union(){
		circle(d=42);
		translate([0,-21])square([31.25,42]);
	}
	circle(d=6.5);
	for(th=[-90:45:90])rotate(th)translate([-18,0])square([3,7.5],center=true);
}
*difference(){
	translate([0,0,6.5])cylinder(7.5,d=15);
	translate([0,0,6.5-ep])cylinder(7.5+epp,d=6.5);
	translate([0,0,11])rotate([0,90,0])cylinder(15+epp,d=4,center=true);
}
*translate([0,0,0.25])rotate([0,-90,90])linear_extrude(0.5)difference(){
	square([8,100],center=true);
	translate([1.75-4,0])square([1.5,100+epp],center=true);
}

*for(s=[-1:2:1])scale([1,s,1])difference(){
	union(){
		*translate([10,26,0])cube([10,10,10],center=true);
		translate([10,26,6])cube([10,10,1],center=true);
	}
	translate([10,26,0])cylinder(20,d=3.5,center=true);
}