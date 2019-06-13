use <lib/RoundedSquare.scad>
use <lib/Countersunk.scad>

module boardMount()
{
    boardStandoffs = [
        [ $boardEdge_hole_d, $boardEdge_hole_d ],
        [ $box_wi - $boardEdge_hole_d, $boardEdge_hole_d ],
        [ $boardEdge_hole_d, $box_di - $boardEdge_hole_d ],
        [ $box_wi - $boardEdge_hole_d, $box_di - $boardEdge_hole_d ]
    ];

    boardMounts = [
        [ 3*$boardEdge_hole_d, 3*$boardEdge_hole_d ],
        [ 3*$boardEdge_hole_d, 1*$boardEdge_hole_d + $board_d]
    ];

    armThickness = 3;

    difference() {
        union() {
            translate( [ -$wall_t, -$wall_t, -$wall_t ] ) {
                linear_extrude( $wall_t ) {
                    RoundedSquare(
                            p_width  = 4*$boardEdge_hole_d + $wall_t,
                            p_height = 4*$boardEdge_hole_d + $wall_t,
                            p_radius = $box_ri);
                }
            }
            translate( [ -$wall_t, $box_di - 4*$boardEdge_hole_d, -$wall_t ] ) {
                linear_extrude( $wall_t ) {
                    RoundedSquare(
                            p_width  = 4*$boardEdge_hole_d + $wall_t,
                            p_height = 4*$boardEdge_hole_d + $wall_t,
                            p_radius = $box_ri);
                }
            }
            translate( [ -$wall_t, 2*$boardEdge_hole_d, -$wall_t ] ) {
                linear_extrude( $wall_t ) {
                    square( [ 4*$boardEdge_hole_d + $wall_t - $box_ri, $box_di - 4*$boardEdge_hole_d ] );
                }
            }
        }

        translate( [ armThickness, 4*$boardEdge_hole_d, -2*$wall_t ] ) {
            #linear_extrude( 3*$wall_t ) {
                RoundedSquare(
                        p_width  = 8*$boardEdge_hole_d,
                        p_height = $box_di - 8*$boardEdge_hole_d,
                        p_radius = $box_ri + $wall_t);
            }
        }

        for( p = boardStandoffs ) {
            translate( [ p[0], p[1], -$wall_t ] ) {
                #Countersunk(
                    height     = $wall_t,
                    radius     = $countersunk_ro,
                    holeRadius = $countersunk_ri );
            }
        }

        for( p = boardMounts ) {
            translate( [ p[0], p[1], -2*$wall_t ] ) {
                cylinder( 3*$wall_t, $countersunk_ri, $countersunk_ri );
            }
        }

    }
}