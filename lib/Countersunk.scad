// A standoff with a screw hole

module Countersunk(
        height,
        radius,
        holeRadius )
{
    if (radius < holeRadius * 2) {
        radius = holeRadius * 2;
    }

    union() {
        translate( [ 0, 0, height - holeRadius/2 ] ) {
            cylinder( holeRadius*2, holeRadius, holeRadius*3 );
        }
        translate( [0, 0, -holeRadius] ) {
            cylinder( height + holeRadius*2, holeRadius, holeRadius );
        }
    }
}
