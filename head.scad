use<scaddy/nema.scad>;
use<scaddy/rail.scad>;

ep=0.001;//epsilon
epp=ep*2;
head_spacing=35;
half_head_spacing=head_spacing/2;
tilter_gap=15;

$fn=24;
module z_axis(){
	translate([0,0,3.5])rotate([0,180,0])nema_8_pnp();
	difference(){
		//Body:
		translate([0,2.5,45])cube([30,35,90],true);
		//Motor hole:
		translate([0,0,47])cube([25,25,90],true);
		//Diagonal cut:
		translate([0,-15-ep,40+ep])rotate([0,90,0])linear_extrude(30+epp,center=true)polygon([[0,0],[27.5+ep,0],[0,27.5+ep],[-50-ep,27.5+ep],[-50-ep,0]]);
		//Hole for shoulder:
		translate([0,0,-ep])cylinder(3+epp,8,8);
		bolt_cross=16;
		bolt_dia=2.1;
		//Stepper Screw holes:
		for(x = [-1 : 2 : 1]){
			for(y = [-1 : 2 : 1]){
				translate([x*bolt_cross/2,y*bolt_cross/2,-ep])cylinder(3+epp,bolt_dia/2,bolt_dia/2);
			}
		}
		//Rail screw holes:
		for(z=[10 : 8 : 50])
			for(x=[-6 : 12 : 6])
				translate([x,20+ep,z+30])rotate([90,0,0])cylinder(7.5+epp,d=2.1);
		//Cutouts
		translate([11.5+ep,16.25,65+ep])cube([7+ep,7.5+epp,50+ep],center=true);
		translate([-11.5-ep,16.25,65+ep])cube([7+ep,7.5+epp,50+ep],center=true);
	}
	translate([0,28,76]) rotate([90,90,0]) MGN7C_carriage();
	translate([0,28,44])rotate([90,90,0]) MGN7C_carriage();
	translate([0,7.5,85])rotate([90,0,0])cylinder(10,d=10,center=true);
}
module z_rail(){
	translate([0,28,40]){
		rotate([90,90,0]){
			MGN7x_rail(100);
		}
	}
}

//head_spacing=50+(15*cos($t*360));
///half_head_spacing=head_spacing/2;
//tilter_gap=10+(5*sin($t*360));
max_z_travel=sqrt(pow(half_head_spacing+tilter_gap,2)-pow(half_head_spacing,2));
max_tilter_deflection=acos((half_head_spacing)/(half_head_spacing+tilter_gap));
echo("max z",max_z_travel);
module z_tilter(){
	//translate([0,7.5,87.5])rotate([90,90-max_tilter_deflection,0])linear_extrude(7.5,center=true)
	translate([0,7.5,87.5])rotate([90,90,0])linear_extrude(7.5,center=true)
	union(){
		translate([5,9+tilter_gap+half_head_spacing])square([10,7],true);
		translate([5,-9-tilter_gap-half_head_spacing])square([10,7],true);
		hull(){
			translate([0,half_head_spacing-10.5])circle(d=10);
			translate([5,0])circle(d=10);
			translate([0,10.5-half_head_spacing])circle(d=10);
		}
		difference(){
			hull(){
				translate([0,half_head_spacing+tilter_gap])circle(d=25);
				translate([0,-half_head_spacing-tilter_gap])circle(d=25);
			}
			hull(){
				translate([0,-half_head_spacing])circle(d=11);
				translate([0,-half_head_spacing-tilter_gap])circle(d=11);
			}
			hull(){
				translate([0,half_head_spacing])circle(d=11);
				translate([0,half_head_spacing+tilter_gap])circle(d=11);
			}
			translate([0,-100])square([20,200]);
		}
	}
	translate([0,21.25,87.5])rotate([90,0,0])difference(){
		cylinder(20,d=15,center=true);
		translate([0,0,-1])cylinder(20,d=5.5,center=true);
	}
}
//color([1,0,0])
z_tilter();
translate([0,40,87.5])rotate([90,45,0])
//nema_17();
nema_14_round();


translate([-half_head_spacing,0,0]){
	translate([0,0,2.5])z_axis();
	//translate([0,0,2.5-max_z_travel])z_axis();
	z_rail();
}

translate([half_head_spacing,0,0]){
	translate([0,0,2.5])z_axis();
	z_rail();
}

//cylinder(7,d=22);
%translate([0,33,50])cube([100,10,100],true);