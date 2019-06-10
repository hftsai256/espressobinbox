// A standoff with a screw hole

module Standoff(
        height,
        radius,
        holeDepth,
        holeRadius )
{
    difference() {
        cylinder( height, radius, radius );
        if (height == holeDepth) {
            translate( [ 0, 0, height-holeDepth-1 ] ) {
                cylinder( holeDepth+2, holeRadius, holeRadius );
            }
        }
        else {
            translate( [ 0, 0, height-holeDepth ] ) {
                cylinder( holeDepth, holeRadius, holeRadius );
            }
        }

    }
}
