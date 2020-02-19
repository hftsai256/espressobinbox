use <lib/RoundedSquare.scad>
use <lib/Countersunk.scad>
use <lib/VentilationHoles.scad>

module diskMount()
{
    dinMountingBracketHoles = [
            [ $din_top, $din_padding, 0],
            [ $din_top, $box_di-$din_padding, 0],
            [ $din_top+$din_separation, $din_padding, 0],
            [ $din_top+$din_separation, $box_di-$din_padding, 0]
    ];

    boardStandoffs = [
        [ $boardEdge_hole_d, $boardEdge_hole_d],
        [ $box_wi - $boardEdge_hole_d, $boardEdge_hole_d],
        [ $boardEdge_hole_d, $box_di - $boardEdge_hole_d],
        [ $box_wi - $boardEdge_hole_d, $box_di - $boardEdge_hole_d]
    ];

    union() {
        difference() {
            // bottom plate
            translate( [ -$wall_t, -$wall_t, -$wall_t ] ) {
                linear_extrude( $wall_t ) {
                    RoundedSquare(
                            p_width  = $box_wi + 2*$wall_t,
                            p_height = $box_di + 2*$wall_t,
                            p_radius = $box_ri);
                }
            }

            for( p = dinMountingBracketHoles ) {
                translate( p ) {
                    mirror( [0, 0, 1] ) {
                        Countersunk(
                            height     = $wall_t,
                            radius     = $countersunk_ro,
                            holeRadius = $countersunk_ri );
                    }
                }
            }

            for( p = boardStandoffs ) {
                translate( [ p[0], p[1], -$wall_t ] ) {
                    Countersunk(
                        height     = $wall_t,
                        radius     = $countersunk_ro,
                        holeRadius = $countersunk_ri );
                }
            }

            translate( [$box_wi/2, $box_di/2, -2*$wall_t] ) {
                linear_extrude( 3*$wall_t ) {
                    VentilationHoles(
                        partWidth = 40,
                        partHeight = 40,
                        nrows = 12,
                        ncols = 6,
                        holepercent = 0.75
                    );
                }
            }
        }
		// Tuner Box Support
        translate( [ $box_wi-8, 30-6, -5-$wall_t ] ) {
            linear_extrude( 5+$wall_t ) {
                square([$wall_t, 25]);
            }
        }
    }
}
