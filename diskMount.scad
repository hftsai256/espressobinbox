use <lib/RoundedSquare.scad>
use <lib/Countersunk.scad>
use <lib/VentilationHoles.scad>

module diskMount()
{
//    dinMountingBracketHoles = [
//        [ $din_padding, $din_top, 0 ],
//        [ $box_wi-$din_padding, $din_top, 0 ],
//        [ $din_padding, $din_top+$din_separation, 0 ],
//        [ $box_wi-$din_padding, $din_top+$din_separation, 0 ]
//    ];
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

			echo("board width = ", $box_wi);
			echo("hole distances = ", (boardStandoffs[1] - boardStandoffs[0]),
			                          (boardStandoffs[2] - boardStandoffs[1]));
			echo("Din Holes = ", dinMountingBracketHoles);
			// DIN rail mount
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


            translate( [$box_wi-40, $box_di/2, -2*$wall_t] ) {
                linear_extrude( 3*$wall_t ) {
                    VentilationHoles(
                        partWidth = 40,
                        partHeight = 40,
                        nrows = 12,
                        ncols = 6,
                        holepercent = 0.7
                    );
                }
            }


        }
    }
}
