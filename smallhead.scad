use <../scaddy/nema.scad>

$fn=48;
ep=0.01;
epp=2*ep;

difference(){
	translate([15,0,-1])cube([80,80,2],center=true);
	translate([20+ep,0,-1])cube([70+epp,50,2+epp],center=true);
}
translate([-22.5,0,32.5])cube([5,20,65],center=true);

for(z=[25:33:58])translate([0,0,z])linear_extrude(2.5)difference(){
	translate([-12.5,0])square([17.5,20],center=true);
	circle(d=16.5);
	translate([0,0])square([25,10],center=true);
	for(th=[90:90:180])rotate(th)translate([8,8])circle(d=2.5);
}

%translate([0,0,57.5])nema_8_pnp();

rotate(100*sin($t*360)){
	difference(){
		union(){
			translate([18.5,0,50])cube([5,15,65],center=true);
			translate([0,0,17.5])cylinder(h=9.5,d=10);
			translate([0,0,59.5])cylinder(h=10,d=10);
			translate([5,0,20])cube([25,10,7],center=true);
			translate([5,0,67])cube([25,10,7],center=true);
		}
		translate([0,0,43.5])cylinder(d=5.5,h=52+epp,center=true);
		translate([-ep,0,43.5])cube([15+epp,4,54+epp],center=true);
		for(z=[0:47:47])translate([-5,0,z+20])rotate([90,0,0])cylinder(d=3,10+epp,center=true);

		for(y=[-3.5:7:3.5])for(z=[0:48:48])translate([18.5,y,z+32.5])rotate([0,90,0])cylinder(d=3,h=5+epp,center=true);
	}

	translate([0,0,20])linear_extrude(15)difference(){
		translate([33,0])square([20,20],center=true);
		translate([37.5,0])circle(d=1.5);
		for(y=[-5:10:5]) hull(){
			translate([25,y])circle(d=3.75);
			translate([20,y])circle(d=3.25);
		}
		hull(){
			translate([30,0])circle(d=4);
			translate([20,0])circle(d=4);
		}

	}
}