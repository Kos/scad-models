r1 = 40/2;
r2 = r1-2;
r3 = r1 + 2;
h = 15.1;
h2 = 3.5;
dw = 3;
dh = 10;
dr = 30;

dinks_w1 = 11.4;
dinks_w2 = 10.2;
dinks_h = 11.2;
dinks_r = 1.5;
dinks_t = 2.5;

module mainRingInnerMask() {
    translate([0,0,-1])
    cylinder(r=r2, h+2, $fn=150);
}
    
module mainRing() {
    difference() {
        cylinder(r=r1, h=h, $fn=150);
        mainRingInnerMask();
    }
}



module base() {
    difference() {
        mainRing();        
        translate([0, 0, 7+h2])
        cube([14, 100,14], center=true);
        
        translate([r1, 0, 0])
        cube([8, 8, h*3], center=true);
    };
}


module connectorOuterMask() {
    difference() {
        cylinder(r=r1*2, h=h*2, center=true);
        cylinder(r=r1+1, h=h*3, center=true);
    }
}

module connectors() {
    difference() {
        union() {
            translate([0,r1, 2.3])
            rotate([-30, 0, 0])
            cube([8, 5, 10], center=true);
        }
        mainRingInnerMask();
        connectorOuterMask();
        cylinder(r=r1*2, h=h2*2, center=true);
    }
}

module dinks() {
    fn=20;
    points=[
        [-dinks_w2/2+dinks_r, dinks_r],
        [ dinks_w2/2-dinks_r, dinks_r],
        [ dinks_w1/2-dinks_r, dinks_h-dinks_r],
        [-dinks_w1/2+dinks_r, dinks_h-dinks_r],
    ];

    hull() {
    translate(points[0]) cylinder(r=dinks_r, h=dinks_t, $fn=fn);
    translate(points[1]) cylinder(r=dinks_r, h=dinks_t, $fn=fn);
    translate(points[2]) cylinder(r=dinks_r, h=dinks_t, $fn=fn);
    translate(points[3]) cylinder(r=dinks_r, h=dinks_t, $fn=fn);
    }
}

module dinksOuterMask() {
    difference() {
        cylinder(r=r3*2, h=h*2, center=true);
        cylinder(r=r3, h=h*3, center=true, $fn=150);
    }
}

module placedDinks() {
    translate([0,-r1+1,h2])
    rotate([15,0,0])
    difference() {
        rotate([90,0,0]) dinks();
        translate([0,r1,-h2]) dinksOuterMask();
    }
}


base();
connectors(); rotate([0,0,180]) connectors();
placedDinks(); rotate([0,0,180]) placedDinks();
