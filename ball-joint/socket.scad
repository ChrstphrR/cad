/*

 This module takes four parameters:
    ball - Diameter of the ball
    pipe - Outer diameter of the pipe being conencting to
    size - Size of the socket [X, Y, Z]
    bolt - Diameter of the bolts connecting the socket to the pipe

 Please note, all measurements in centimeters!

*/

include <helper.scad>;

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
			difference ()
			{
				//Original tube to remove
				cylinder(h = 6, r = radius(pipe));
				//minus:
				difference ()
				{
					//TODO: The scaled radii here need to be replaced w/
					// appropriate passed/looked-up values later

					//initial "stud"
					cylinder(h = (size[2] / 8), r = radius(pipe * 0.8));
					//hollow it out.
					cylinder(h = (size[2] / 8), r = radius(pipe * 0.6));
				}
			}
		}

		// Cut hole for the ball
		sphere(r = radius(ball));
	}

}
