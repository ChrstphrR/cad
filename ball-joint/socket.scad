/*

 This module takes four parameters:
    ball - Diameter of the ball
    pipe - Outer diameter of the pipe being conencting to
    size - Size of the socket
    bolt - Diameter of the bolts connecting the socket to the pipe

 Please note, all measurements in centimeters!

*/

// Temporary stud include for testing
include <stud.scad>;

function radius(diameter) = diameter / 2;

module bolt(length, diameter)
{
    rotate([0, 90, 0])
    {
        cylinder(h = length, r = radius(diameter));
    }
}

module socket(ball, pipe, size, bolt)
{
    difference()
    {
        // Create socket body
        translate([-size[0] / 2, -size[1] / 2, -ball / 4])
        {
            cube(size);
        }
        
        // Cut bolt holes out of the socket
        translate([-size[0] / 2, 0, size[2] - size[2] / 1.5])
        {
            bolt(size[0], bolt);
        }

        translate([-size[0] / 2, 0, size[2] - size[2] / 4])
        {
            bolt(size[0], bolt);
        }
        
        // Cut hole for the connecting pipe
        translate([0, 0, size[2] / 4])
        {
            cylinder(h = 6, r = radius(pipe));
        }
        
        // Cut hole for the ball
        sphere(r = radius(ball));
    }
    
}

socket(2.56, 2.1336, [4, 1.5, 7], 0.3175);

rotate([180, 0, 0])
{
    stud(2.54, 1.27, 5.08, 0.3175);
}

 // So smooth~
$fn = 100;