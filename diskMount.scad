use <lib/RoundedSquare.scad>
use <lib/Countersunk.scad>
use <lib/VentilationHoles.scad>

module diskMount()
{
    $diskMountSpacer = 9;
    $diskHole1_x = $countersunk_ro + $diskMountSpacer; // x coordinate of the bottom-left disk hole
    $diskHole1_y = ($box_di - $diskHoles_dy) / 2;        // y coordinate of the bottom-left disk hole

    diskHoles = [
        [ $diskHole1_x,                 $diskHole1_y ],
        [ $diskHole1_x + $diskHoles_dx, $diskHole1_y ],
        [ $diskHole1_x,                 $diskHole1_y + $diskHoles_dy ],
        [ $diskHole1_x + $diskHoles_dx, $diskHole1_y + $diskHoles_dy ]
    ];

    dinMountingBracketHoles = [
        [ $din_padding, $din_top, 0 ],
        [ $box_wi-$din_padding, $din_top, 0 ],
        [ $din_padding, $din_top+$din_separation, 0 ],
        [ $box_wi-$din_padding, $din_top+$din_separation, 0 ]
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

            for( p = diskHoles ) {
                translate( [ p[0], p[1], -$wall_t ] ) {
                    Countersunk(
                        height     = $wall_t,
                        radius     = $countersunk_ro,
                        holeRadius = $countersunk_ri );
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
                        partHeight = 50,
                        nrows = 12,
                        ncols = 12,
                        holepercent = 0.75
                    );
                }
            }

        }
    }
}
