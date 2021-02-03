use<../scaddy/vslot.scad>;

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



gear_spacing=4;
inner_dia_target=39;
gear_count = floor((inner_dia_target*PI)/gear_spacing);
inner_dia_real = gear_count*gear_spacing/PI;
angle_per = 360/gear_count;
tooth_depth = 1;
echo(inner_dia_real);

*linear_extrude(1)for(th=[0 : angle_per : 360])rotate(th)
	polygon([
		[0,0],
		[(inner_dia_real/2),0],
		[cos(1*angle_per/4) * ((inner_dia_real/2)+tooth_depth), sin(1*angle_per/4) * ((inner_dia_real/2)+tooth_depth)],
		[cos(2*angle_per/4) * ((inner_dia_real/2)), sin(2*angle_per/4) * ((inner_dia_real/2))],
		[cos(3*angle_per/4) * ((inner_dia_real/2)), sin(3*angle_per/4) * ((inner_dia_real/2))],
		[cos(4*angle_per/4) * inner_dia_real/2, sin(4*angle_per/4) * inner_dia_real/2]
	]);

translate([0,0,0.5])linear_extrude(1,center=true){
	for(th=[0 : angle_per : 360])rotate(th)
		translate([0,inner_dia_real/2,0])polygon([[-0.375,-1.5],[-0.375,0],[-0.25,0.5],[0.25,0.5],[0.375,0],[0.375,-1.5]]);
	
}
linear_extrude(8-1.25){

	difference(){
		circle(d=inner_dia_real-1.5,$fn=gear_count);
		circle(d=10.35,$fn=gear_count);
	}
}