// A standoff with a screw hole

module Countersunk(
        height,
        radius,
        holeRadius )
{
    headRadius = holeRadius * 2;
    headHeight = holeRadius / 2;

    if (radius < headRadius) {
        radius = headRadius;
    }

    union() {
        translate( [ 0, 0, height-headHeight ] ) {
            cylinder( headHeight * 2, holeRadius, headRadius * 2 );
        }
        translate( [0, 0, -1] ) {
            cylinder( height + 2, holeRadius, holeRadius );
        }
    }
}
