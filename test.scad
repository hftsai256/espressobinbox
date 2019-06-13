use <lib/Countersunk.scad>
use <diskBoard.scad>

// key measurements (we cannot do anyhthing about that)

$board_w          = 100;      // EspressoBIN board width (longer dimension)
$board_d          =  72;      // EspressoBIN board depth (shorter dimension)
$board_t          =   1.8;    // EspressoBIN board thickness (board only, not components)
$boardEdge_hole_d =   3;

$diskHoles_dx     =  77;      // distance between the screw holes on the disk along X
$diskHoles_dy     =  62;      // distance between the screw holes on the disk along Y

// key parameters (we can change those)

$wall_t           = 1.5;                        // wall thickness
$box_ri           = 4;                          // inside curve radius of the box's corners

$countersunk_ri   = 1.5;                        // countersunk m3 screw radius (hole)
$countersunk_ro   = 3;                          // countersunk m3 screw radius (padding)

$din_padding      = 30;
$din_top          = 9;
$din_separation   = 25;

// derived values (cannot change)

$box_wi           = $board_w + 4*$boardEdge_hole_d; // box length on the inside
$box_di           = $board_d + 4*$boardEdge_hole_d; // box width on the inside

$fn = 100;

diskBoard();